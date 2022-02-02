Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39134A797A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347174AbiBBUbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347113AbiBBUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048ECC06173D;
        Wed,  2 Feb 2022 12:30:45 -0800 (PST)
Date:   Wed, 02 Feb 2022 20:30:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cmu9k2gkbvt8BhkEdUvwTScgyyQvDvuWXTSCSKGeSQI=;
        b=ZoiWjkl9Xv7Qy/1+U4LcCRlB8+WGjSESKq+RCROuBvsfgQIw3TzE4snMnSERQU2c1DBmFz
        az4FvRNaKh51J2DVWS0RxjZXaY8MrqJoytEyjRvlzWFzJdnwaQDkUqZfO4/XCjzf78gIvH
        vHOkmwEbuH5kkAFe3xHQgAqQ/2szaQQYQauODZPa70y+0lrQ6eWYwequDkXL8jERAcxlVp
        mtXW5bWR25qcw4+B39Da1Mk8miZMHFRbP2yAb14HGKn2wCAvJHOI+Hr1dJp8NzBj0j7/8Q
        tabA/igDX8mH0aFLACjhl8nJCtIQoGpj6pulhElh+qXmOppQhn9PBEchzfPPAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cmu9k2gkbvt8BhkEdUvwTScgyyQvDvuWXTSCSKGeSQI=;
        b=B1qz+7Q90tcISc6bMLcnBpn10XF8qSpnsqflnL+gkASE6/7rNuM4Vd79aa49aXoAc5cmHD
        f34RiXSivTDl+HAw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Handle PIRQ routing tables with no router
 device given
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nikolai Zhubr <zhubr.2@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201022007170.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022007170.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383384199.16921.7991989154514994409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     f3ff9dcbdd5b0f26d99063cbf2ae8193e7d851e1
Gitweb:        https://git.kernel.org/tip/f3ff9dcbdd5b0f26d99063cbf2ae8193e7d851e1
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 06 Jan 2022 11:24:06 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:55 +01:00

x86/PCI: Handle PIRQ routing tables with no router device given

PIRQ routing tables provided by the PCI BIOS usually specify the PCI 
vendor:device ID as well as the bus address of the device implementing 
the PIRQ router, e.g.:

PCI: Interrupt Routing Table found at 0xc00fde10
[...]
PCI: Attempting to find IRQ router for [8086:7000]
pci 0000:00:07.0: PIIX/ICH IRQ router [8086:7000]

however in some cases they do not, in which case the kernel fails to match
the router handler, e.g.:

PCI: Interrupt Routing Table found at 0xc00fdae0
[...]
PCI: Attempting to find IRQ router for [0000:0000]
PCI: Interrupt router not found at 00:00

This is because it always matches the vendor:device ID and the bus address 
literally, even if they are all zeros.

Handle this case then and iterate over all PCI devices until a matching
router handler can be found if the vendor ID given by the routing table is
the invalid value of zero:

PCI: Attempting to find IRQ router for [0000:0000]
PCI: Trying IRQ router for [1039:0496]
pci 0000:00:05.0: SiS85C497 IRQ router [1039:0496]

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nikolai Zhubr <zhubr.2@gmail.com>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201022007170.56863@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 63 +++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 2abfcfc..7113688 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1175,10 +1175,32 @@ static struct pci_dev *pirq_router_dev;
  *	chipset" ?
  */
 
+static bool __init pirq_try_router(struct irq_router *r,
+				   struct irq_routing_table *rt,
+				   struct pci_dev *dev)
+{
+	struct irq_router_handler *h;
+
+	DBG(KERN_DEBUG "PCI: Trying IRQ router for [%04x:%04x]\n",
+	    dev->vendor, dev->device);
+
+	for (h = pirq_routers; h->vendor; h++) {
+		/* First look for a router match */
+		if (rt->rtr_vendor == h->vendor &&
+		    h->probe(r, dev, rt->rtr_device))
+			return true;
+		/* Fall back to a device match */
+		if (dev->vendor == h->vendor &&
+		    h->probe(r, dev, dev->device))
+			return true;
+	}
+	return false;
+}
+
 static void __init pirq_find_router(struct irq_router *r)
 {
 	struct irq_routing_table *rt = pirq_table;
-	struct irq_router_handler *h;
+	struct pci_dev *dev;
 
 #ifdef CONFIG_PCI_BIOS
 	if (!rt->signature) {
@@ -1197,27 +1219,30 @@ static void __init pirq_find_router(struct irq_router *r)
 	DBG(KERN_DEBUG "PCI: Attempting to find IRQ router for [%04x:%04x]\n",
 	    rt->rtr_vendor, rt->rtr_device);
 
-	pirq_router_dev = pci_get_domain_bus_and_slot(0, rt->rtr_bus,
-						      rt->rtr_devfn);
-	if (!pirq_router_dev) {
-		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
-			"%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
-		return;
+	/* Use any vendor:device provided by the routing table or try all.  */
+	if (rt->rtr_vendor) {
+		dev = pci_get_domain_bus_and_slot(0, rt->rtr_bus,
+						  rt->rtr_devfn);
+		if (dev && pirq_try_router(r, rt, dev))
+			pirq_router_dev = dev;
+	} else {
+		dev = NULL;
+		for_each_pci_dev(dev) {
+			if (pirq_try_router(r, rt, dev)) {
+				pirq_router_dev = dev;
+				break;
+			}
+		}
 	}
 
-	for (h = pirq_routers; h->vendor; h++) {
-		/* First look for a router match */
-		if (rt->rtr_vendor == h->vendor &&
-			h->probe(r, pirq_router_dev, rt->rtr_device))
-			break;
-		/* Fall back to a device match */
-		if (pirq_router_dev->vendor == h->vendor &&
-			h->probe(r, pirq_router_dev, pirq_router_dev->device))
-			break;
+	if (pirq_router_dev) {
+		dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
+			 pirq_router.name,
+			 pirq_router_dev->vendor, pirq_router_dev->device);
+	} else {
+		DBG(KERN_DEBUG "PCI: Interrupt router not found at %02x:%02x\n",
+		    rt->rtr_bus, rt->rtr_devfn);
 	}
-	dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
-		 pirq_router.name,
-		 pirq_router_dev->vendor, pirq_router_dev->device);
 
 	/* The device remains referenced for the kernel lifetime */
 }
