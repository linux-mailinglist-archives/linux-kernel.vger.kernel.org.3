Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE044A797C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347191AbiBBUbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347134AbiBBUau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F84FC06173B;
        Wed,  2 Feb 2022 12:30:50 -0800 (PST)
Date:   Wed, 02 Feb 2022 20:30:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QwL6ImiIFbGk1ZxSuKWALC4wGw+S9Uyhv6lO2i334fA=;
        b=n9qqKZMrqn4HhK6Eddq8izvAfbSxvN7Z+adee6qjAyFUp9L5oAxyu/GADv5FEWBjZcw070
        2Ab2Bm4Z1K1e4EhR+ngw0QjBsF5Ua9myyPj0Q0ncUn/RkC6H7RtHwAOHHRst2d2dxRCj83
        6fB9ddTL6SRiBwnttB0HwyqVXH5N91CtLQT69kDFB9L793EddNYDfMSp4nC7KnU4z1sUW8
        a+hq7bStt/5JWU2h5Y0f+JoTk504pERzU4uiP1wfZPA6/ppEc896GHIJayX1b5ygDAc1AB
        TJEFA6cEHj59942VL8Pw4TU6c41rYlojaiO7nWaKilAZj5moAe+wVF2wEFPOLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QwL6ImiIFbGk1ZxSuKWALC4wGw+S9Uyhv6lO2i334fA=;
        b=+PkjcPChtWcaxvIUByZQZJaPr0kUfl1uprYgmX1YIt2EbM4brvj0QEs7MqJh0r8PrJKlh5
        Bi/8AxwxxZcyASDg==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Also match function number in $PIR table
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201020154440.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020154440.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383384716.16921.7522475956670765987.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     9598dca94cbf86c1bd62e752baf5edb8001f36dd
Gitweb:        https://git.kernel.org/tip/9598dca94cbf86c1bd62e752baf5edb8001f36dd
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sun, 02 Jan 2022 23:24:35 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:55 +01:00

x86/PCI: Also match function number in $PIR table

Contrary to the PCI BIOS specification[1] some systems include the PCI 
function number for onboard devices in their $PIR table.  Consequently 
the wrong entry can be matched leading to interrupt routing failures.

For example the Tyan Tomcat IV S1564D board has:

00:07.1 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:00/deb8

00:07.2 slot=00
 0:00/deb8
 1:00/deb8
 2:00/deb8
 3:63/deb8

for its IDE interface and USB controller functions of the 82371SB PIIX3
southbridge.  Consequently the first entry matches causing the inability to
route the USB interrupt in the `noapic' mode, in which case the kernel must
rely on the interrupt line set by the BIOS:

uhci_hcd 0000:00:07.2: runtime IRQ mapping not provided by arch
uhci_hcd 0000:00:07.2: PCI INT D not routed
uhci_hcd 0000:00:07.2: enabling bus mastering
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00006000

Try to match the PCI device and function combined then and if that fails 
move on to PCI device matching only.  Compliant systems will only have a 
single $PIR table entry per PCI device, so this update does not change 
the semantics with them, while systems that have several entries for 
individual functions of a single PCI device each will match the correct 
entry:

uhci_hcd 0000:00:07.2: runtime IRQ mapping not provided by arch
uhci_hcd 0000:00:07.2: PCI INT D -> PIRQ 63, mask deb8, excl 0c20
uhci_hcd 0000:00:07.2: PCI INT D -> newirq 11
uhci_hcd 0000:00:07.2: found PCI INT D -> IRQ 11
uhci_hcd 0000:00:07.2: sharing IRQ 11 with 0000:00:11.0
uhci_hcd 0000:00:07.2: enabling bus mastering
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00006000

[1] "PCI BIOS Specification", Revision 2.1, PCI Special Interest Group,
    August 26, 1994, Table 4-1 "Layout of IRQ routing table entry.", p.
    12

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201020154440.56863@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index b6b9853..dcb9c21 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1132,18 +1132,29 @@ static void __init pirq_find_router(struct irq_router *r)
 	/* The device remains referenced for the kernel lifetime */
 }
 
+/*
+ * We're supposed to match on the PCI device only and not the function,
+ * but some BIOSes build their tables with the PCI function included
+ * for motherboard devices, so if a complete match is found, then give
+ * it precedence over a slot match.
+ */
 static struct irq_info *pirq_get_info(struct pci_dev *dev)
 {
 	struct irq_routing_table *rt = pirq_table;
 	int entries = (rt->size - sizeof(struct irq_routing_table)) /
 		sizeof(struct irq_info);
+	struct irq_info *slotinfo = NULL;
 	struct irq_info *info;
 
 	for (info = rt->slots; entries--; info++)
-		if (info->bus == dev->bus->number &&
-			PCI_SLOT(info->devfn) == PCI_SLOT(dev->devfn))
-			return info;
-	return NULL;
+		if (info->bus == dev->bus->number) {
+			if (info->devfn == dev->devfn)
+				return info;
+			if (!slotinfo &&
+			    PCI_SLOT(info->devfn) == PCI_SLOT(dev->devfn))
+				slotinfo = info;
+		}
+	return slotinfo;
 }
 
 static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
