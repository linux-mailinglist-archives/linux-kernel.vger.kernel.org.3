Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5D14FAD8F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbiDJK44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiDJK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADFD1B7B6;
        Sun, 10 Apr 2022 03:54:31 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jhf28TEYQ2SsZDoeJOlabay4EHMg+uoQkNvvIU60ta4=;
        b=vw885PriyKeSD0bYmxECIDaP04bdeL4zA82K9AxY1yPrp/MmFXELEH1BX/1Gc1n7ouLci4
        ZOgnFi3hRFcsVdm4iAQErQPOTD/cz4l195PHjfHLyCfreYGo2L3j/6pR7ls8aKL6y8QL82
        w/xwLyaOYq727UbNnVGwHaxTMczjaEwiGHuEqW3xpJFqH8seFOE1bjlYGrwy8J0QPHZIgt
        KONILbue2D1JaMDEplIWSDsoXOOOGT4k+EOMaK3PDfJIVrNzkYLDBbWTIre4M3SmPWoiEi
        4m6bATIbd9UNddteAOqZOjjnhluNh09hIrB0aa8bfPp5nIcM6/6wXQ8CF/tw6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jhf28TEYQ2SsZDoeJOlabay4EHMg+uoQkNvvIU60ta4=;
        b=TAHHVc7/mtTisW/qsRhomB2MhZ566lv7dz5xiGMVVMAmMlyBJFUMR8hhcPuMzxaIgBO2nh
        K79YZ/tT+sSBYrBw==
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
In-Reply-To: <alpine.DEB.2.21.2203302018570.9038@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203302018570.9038@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958806853.4207.607739098267936156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     ac7cd5e16df8696c39e29b03dfedf069a025b822
Gitweb:        https://git.kernel.org/tip/ac7cd5e16df8696c39e29b03dfedf069a025b822
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:11:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:14 +02:00

x86/PCI: Handle PIRQ routing tables with no router device given

PIRQ routing tables provided by the PCI BIOS usually specify the PCI 
vendor:device ID as well as the bus address of the device implementing 
the PIRQ router, e.g.:

PCI: Interrupt Routing Table found at 0xc00fde10
[...]
PCI: Attempting to find IRQ router for [8086:7000]
pci 0000:00:07.0: PIIX/ICH IRQ router [8086:7000]

however in some cases they do not, in which case we fail to match the 
router handler, e.g.:

PCI: Interrupt Routing Table found at 0xc00fdae0
[...]
PCI: Attempting to find IRQ router for [0000:0000]
PCI: Interrupt router not found at 00:00

This is because we always match the vendor:device ID and the bus address 
literally, even if they are all zeros.

Handle this case then and iterate over all PCI devices until we find a 
matching router handler if the vendor ID given by the routing table is 
the invalid value of zero:

PCI: Attempting to find IRQ router for [0000:0000]
PCI: Trying IRQ router for [1039:0496]
pci 0000:00:05.0: SiS85C497 IRQ router [1039:0496]

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nikolai Zhubr <zhubr.2@gmail.com>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203302018570.9038@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 64 ++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index ef97b26..d4ecf88 100644
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
@@ -1197,27 +1219,29 @@ static void __init pirq_find_router(struct irq_router *r)
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
-	}
-	dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
-		 pirq_router.name,
-		 pirq_router_dev->vendor, pirq_router_dev->device);
+	if (pirq_router_dev)
+		dev_info(&pirq_router_dev->dev, "%s IRQ router [%04x:%04x]\n",
+			 pirq_router.name,
+			 pirq_router_dev->vendor, pirq_router_dev->device);
+	else
+		DBG(KERN_DEBUG "PCI: Interrupt router not found at "
+		    "%02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
 
 	/* The device remains referenced for the kernel lifetime */
 }
