Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56034FAD95
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiDJK5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbiDJK4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2041C92E;
        Sun, 10 Apr 2022 03:54:35 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsSZQaHahKGCt4uGj62kElvqjD0lnZg4Jek7nB3fL9g=;
        b=EwZ5ooKwKSL24E7PHtV9gKh2KKGLbln9bVI204Nt8AWmDWzlrJ4ccqb+ZUlmjkutTohq5f
        POnxAfS8h/MEw4Jcdx18tHrM6GQcYF225GO+x+B60M5lgCs293exV9mtTLuVvxywtkPUUG
        D5ov+JA2z7AfoXSGA/2pFoKmpcOTAT1j9G/Om74zm4lHGmX9uZMj/T3n0fXX/AHmruLVc5
        XgV7xVIAzvMv6mLn6eu7aYxABeN4D4rINdwglP5by/S4drlTyk4CoxI4/R7RGSgob7qYCD
        qfgWbWVjXj0t0FbBKx+9kwjlnrkF3WHvJrTOnlz5NVuWqrmTxDlVNeIFyDJGrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588074;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jsSZQaHahKGCt4uGj62kElvqjD0lnZg4Jek7nB3fL9g=;
        b=s6Tr1cR1gw01v8WcUD0PxUt9z8ZsLs3ym91I6Rt0NiSjvmfaxjeQR/BCR9Une2GzjnImPw
        6yH2c98m/ce0jRDw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Also match function number in $PIR table
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2203301536020.22465@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203301536020.22465@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958807321.4207.10339453650098953248.tip-bot2@tip-bot2>
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

Commit-ID:     3132450254f28428cb0a4368b0115a26cd85d170
Gitweb:        https://git.kernel.org/tip/3132450254f28428cb0a4368b0115a26cd85d170
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:10:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:14 +02:00

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
southbridge.  Consequently the first entry matches causing the inability 
to route the USB interrupt in the `noapic' mode, in which case we need 
to rely on the interrupt line set by the BIOS:

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
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203301536020.22465@angie.orcam.me.uk

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
