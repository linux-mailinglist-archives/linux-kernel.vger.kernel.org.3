Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0104624FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhK2Wdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:33:42 -0500
Received: from mail.mutex.one ([62.77.152.124]:37270 "EHLO mail.mutex.one"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhK2WdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:33:09 -0500
X-Greylist: delayed 1035 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Nov 2021 17:33:09 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id CDC8A16DDFAF;
        Tue, 30 Nov 2021 00:12:34 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CgdqX3x226dP; Tue, 30 Nov 2021 00:12:33 +0200 (EET)
Received:  [127.0.0.1] (localhost [127.0.0.1])nknown [79.112.88.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mutex.one (Postfix) with ESMTPSA id 21B8F16DDF17;
        Tue, 30 Nov 2021 00:12:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1638223953; bh=6sv/YtC7HRNVTUOzq8MATmzCdYfyVXcxC85XY1WhJs8=;
        h=From:To:Cc:Subject:Date:From;
        b=ei0kKSGBhAJPjFIfsMrxMdqnDrUMcUYkca/dahv0dt0jIm1xVrlmCBIJ2VxCoOGSb
         bfjKGG5+NlyW9vNVhiIVDECTHtLGT9w5eEdwPtLT1GX8tOeVOko4WM/OzCyWWb6+Kg
         RPc/A7beXgHWJTZiCWNFxDmCJrssxhyIhkytYYNQ=
From:   Marian Postevca <posteuca@mutex.one>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marian Postevca <posteuca@mutex.one>
Subject: [PATCH] usb: gadget: u_ether: fix race in setting MAC address in setup phase
Date:   Tue, 30 Nov 2021 00:12:29 +0200
Message-Id: <20211129221229.31845-1-posteuca@mutex.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When listening for notifications through netlink of a new interface being
registered, sporadically, it is possible for the MAC to be read as zero.
The zero MAC address lasts a short period of time and then switches to a
valid random MAC address.

This causes problems for netd in Android, which assumes that the interface
is malfunctioning and will not use it.

In the good case we get this log:
InterfaceController::getCfg() ifName usb0
 hwAddr 92:a8:f0:73:79:5b ipv4Addr 0.0.0.0 flags 0x1002

In the error case we get these logs:
InterfaceController::getCfg() ifName usb0
 hwAddr 00:00:00:00:00:00 ipv4Addr 0.0.0.0 flags 0x1002

netd : interfaceGetCfg("usb0")
netd : interfaceSetCfg() -> ServiceSpecificException
 (99, "[Cannot assign requested address] : ioctl() failed")

The reason for the issue is the order in which the interface is setup,
it is first registered through register_netdev() and after the MAC
address is set.

Fixed by first setting the MAC address of the net_device and after that
calling register_netdev().

Signed-off-by: Marian Postevca <posteuca@mutex.one>
---
 drivers/usb/gadget/function/u_ether.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index e0ad5aed6ac9..6f5d45ef2e39 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -17,6 +17,7 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_vlan.h>
+#include <linux/etherdevice.h>
 
 #include "u_ether.h"
 
@@ -863,19 +864,23 @@ int gether_register_netdev(struct net_device *net)
 {
 	struct eth_dev *dev;
 	struct usb_gadget *g;
-	struct sockaddr sa;
 	int status;
 
 	if (!net->dev.parent)
 		return -EINVAL;
 	dev = netdev_priv(net);
 	g = dev->gadget;
+
+	net->addr_assign_type = NET_ADDR_RANDOM;
+	eth_hw_addr_set(net, dev->dev_mac);
+
 	status = register_netdev(net);
 	if (status < 0) {
 		dev_dbg(&g->dev, "register_netdev failed, %d\n", status);
 		return status;
 	} else {
 		INFO(dev, "HOST MAC %pM\n", dev->host_mac);
+		INFO(dev, "MAC %pM\n", dev->dev_mac);
 
 		/* two kinds of host-initiated state changes:
 		 *  - iff DATA transfer is active, carrier is "on"
@@ -883,15 +888,6 @@ int gether_register_netdev(struct net_device *net)
 		 */
 		netif_carrier_off(net);
 	}
-	sa.sa_family = net->type;
-	memcpy(sa.sa_data, dev->dev_mac, ETH_ALEN);
-	rtnl_lock();
-	status = dev_set_mac_address(net, &sa, NULL);
-	rtnl_unlock();
-	if (status)
-		pr_warn("cannot set self ethernet address: %d\n", status);
-	else
-		INFO(dev, "MAC %pM\n", dev->dev_mac);
 
 	return status;
 }
-- 
2.32.0

