terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "digitalocean_token" {}

provider "digitalocean" {
  token = var.digitalocean_token
}
#
#resource "digitalocean_droplet" "etcd" {
#  count    = 1
#  image    = "ubuntu-18-04-x64"
#  name     = "ectd-${count.index}"
#  region   = "lon1"
#  size     = "s-1vcpu-1gb"
#  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
#}

resource "digitalocean_droplet" "loadBalancer" {
  name     = "loadBalancer"
  image    = "ubuntu-18-04-x64"
  size     = "s-1vcpu-1gb"
  region   = "lon1"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}

resource "digitalocean_ssh_key" "default" {
  name       = "my ssh key"
  public_key = file("~/.ssh/id_rsa.pub")
}

#output "ipv4_address" {
#  value = digitalocean_droplet.etcd.*.ipv4_address
#}

output "loadBalancer-ipv4_addres" {
  value = digitalocean_droplet.loadBalancer.ipv4_address
}
