Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14A54A7978
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347177AbiBBUbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:31:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347120AbiBBUas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:48 -0500
Date:   Wed, 02 Feb 2022 20:30:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2beHnRyD57KQHoaZD0r7xoMZxPiSoUs0rlsC2RzkOw=;
        b=l9B9IC18k+X1R/TCLoDkcxlx2x432ApV7aoQxmrnAFxC5ZWNskWKbVlAan2LVbnLZkk7La
        WDumprfx6z2YixSOGsOa+OA6B9OxZpMGBDbwjcvlqELxbTQBYqg81pxwi7PpsNWJiYe97f
        fdtvHx5ZoXgAhqvIs28dAWxlHAdX49VBD2IjEv9lHVSVjVPRK6EfTQIcPAxrDkVCobQIzB
        Xkb1Y6FxSTU4vf0PlAJREbwbpLbrEAmEV5O4JR1Z8pgbI8soXiYcJMc5WwRfDGqzRnWsCM
        526wDGhzMHLEZ3NVZE90se8am8DnJ/zzjLEtN5rGXsKq5cSur22OJtcazo6/Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2beHnRyD57KQHoaZD0r7xoMZxPiSoUs0rlsC2RzkOw=;
        b=oNbmQ4GW8fBMl7u5LDZLtKXh7oFWm/frFGL07r5g+dbURkxfl1ji90bdSULA+kNd4D6+7y
        AGoiK4DomlVzG6BA==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Handle IRQ swizzling with PIRQ routers
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201020158320.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020158320.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383384623.16921.5814708160589665711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     c9df2d2677e823a110456bedd4357360b9ee2eda
Gitweb:        https://git.kernel.org/tip/c9df2d2677e823a110456bedd4357360b9ee2eda
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Sun, 02 Jan 2022 23:24:41 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:55 +01:00

x86/PCI: Handle IRQ swizzling with PIRQ routers

Similarly to MP-tables PIRQ routing tables may not list devices behind 
PCI-to-PCI bridges, leading to interrupt routing failures, e.g.:

pci 0000:00:07.0: PIIX/ICH IRQ router [8086:7000]
pci 0000:02:00.0: ignoring bogus IRQ 255
pci 0000:02:01.0: ignoring bogus IRQ 255
pci 0000:02:02.0: ignoring bogus IRQ 255
pci 0000:04:00.0: ignoring bogus IRQ 255
pci 0000:04:00.3: ignoring bogus IRQ 255
pci 0000:00:11.0: PCI INT A -> PIRQ 63, mask deb8, excl 0c20
pci 0000:00:11.0: PCI INT A -> newirq 0
PCI: setting IRQ 11 as level-triggered
pci 0000:00:11.0: found PCI INT A -> IRQ 11
pci 0000:00:11.0: sharing IRQ 11 with 0000:00:07.2
pci 0000:02:00.0: PCI INT A not found in routing table
pci 0000:02:01.0: PCI INT A not found in routing table
pci 0000:02:02.0: PCI INT A not found in routing table
pci 0000:04:00.0: PCI INT A not found in routing table
pci 0000:04:00.3: PCI INT D not found in routing table
pci 0000:06:05.0: PCI INT A not found in routing table
pci 0000:06:08.0: PCI INT A not found in routing table
pci 0000:06:08.1: PCI INT B not found in routing table
pci 0000:06:08.2: PCI INT C not found in routing table

and consequently non-working devices.  Since PCI-to-PCI bridges have a 
standardised way of routing interrupts by the means of swizzling do it 
for configurations that use a PIRQ router as well, like with APIC-based 
setups, and use the determined corresponding topmost bridge's interrupt 
pin assignment to route a given device's interrupt:

pci 0000:00:07.0: PIIX/ICH IRQ router [8086:7000]
pci 0000:02:00.0: ignoring bogus IRQ 255
pci 0000:02:01.0: ignoring bogus IRQ 255
pci 0000:02:02.0: ignoring bogus IRQ 255
pci 0000:04:00.0: ignoring bogus IRQ 255
pci 0000:04:00.3: ignoring bogus IRQ 255
pci 0000:00:11.0: PCI INT A -> PIRQ 63, mask deb8, excl 0c20
pci 0000:00:11.0: PCI INT A -> newirq 0
PCI: setting IRQ 11 as level-triggered
pci 0000:00:11.0: found PCI INT A -> IRQ 11
pci 0000:00:11.0: sharing IRQ 11 with 0000:00:07.2
pci 0000:02:00.0: using bridge 0000:00:11.0 INT A to get INT A
pci 0000:00:11.0: sharing IRQ 11 with 0000:02:00.0
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:04:00.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:04:00.3: using bridge 0000:00:11.0 INT A to get INT D
pci 0000:00:11.0: sharing IRQ 11 with 0000:04:00.3
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:08.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:06:08.1: using bridge 0000:00:11.0 INT D to get INT B
pci 0000:06:08.2: using bridge 0000:00:11.0 INT A to get INT C
pci 0000:00:11.0: sharing IRQ 11 with 0000:06:08.2
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:01.0: PCI INT A -> PIRQ 60, mask deb8, excl 0c20
pci 0000:02:01.0: PCI INT A -> newirq 0
PCI: setting IRQ 10 as level-triggered
pci 0000:02:01.0: found PCI INT A -> IRQ 10
pci 0000:02:01.0: sharing IRQ 10 with 0000:00:14.0
pci 0000:02:00.0: using bridge 0000:00:11.0 INT A to get INT A
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:04:00.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:01.0: sharing IRQ 10 with 0000:04:00.0
pci 0000:04:00.3: using bridge 0000:00:11.0 INT A to get INT D
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:08.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:06:08.1: using bridge 0000:00:11.0 INT D to get INT B
pci 0000:06:08.2: using bridge 0000:00:11.0 INT A to get INT C
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:02:02.0: PCI INT A -> PIRQ 61, mask deb8, excl 0c20
pci 0000:02:02.0: PCI INT A -> newirq 0
PCI: setting IRQ 5 as level-triggered
pci 0000:02:02.0: found PCI INT A -> IRQ 5
pci 0000:02:02.0: sharing IRQ 5 with 0000:00:13.0
pci 0000:02:00.0: using bridge 0000:00:11.0 INT A to get INT A
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:04:00.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:04:00.3: using bridge 0000:00:11.0 INT A to get INT D
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:08.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:02:02.0: sharing IRQ 5 with 0000:06:08.0
pci 0000:06:08.1: using bridge 0000:00:11.0 INT D to get INT B
pci 0000:06:08.2: using bridge 0000:00:11.0 INT A to get INT C
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:05.0: PCI INT A -> PIRQ 62, mask deb8, excl 0c20
pci 0000:06:05.0: PCI INT A -> newirq 0
pci 0000:06:05.0: found PCI INT A -> IRQ 5
pci 0000:06:05.0: sharing IRQ 5 with 0000:00:12.0
pci 0000:02:00.0: using bridge 0000:00:11.0 INT A to get INT A
pci 0000:02:01.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:02:02.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:04:00.0: using bridge 0000:00:11.0 INT B to get INT A
pci 0000:04:00.3: using bridge 0000:00:11.0 INT A to get INT D
pci 0000:06:05.0: using bridge 0000:00:11.0 INT D to get INT A
pci 0000:06:08.0: using bridge 0000:00:11.0 INT C to get INT A
pci 0000:06:08.1: using bridge 0000:00:11.0 INT D to get INT B
pci 0000:06:05.0: sharing IRQ 5 with 0000:06:08.1
pci 0000:06:08.2: using bridge 0000:00:11.0 INT A to get INT C

Adjust log messages accordingly.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201020158320.56863@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 60 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index dcb9c21..bd32e4b 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -1138,7 +1138,7 @@ static void __init pirq_find_router(struct irq_router *r)
  * for motherboard devices, so if a complete match is found, then give
  * it precedence over a slot match.
  */
-static struct irq_info *pirq_get_info(struct pci_dev *dev)
+static struct irq_info *pirq_get_dev_info(struct pci_dev *dev)
 {
 	struct irq_routing_table *rt = pirq_table;
 	int entries = (rt->size - sizeof(struct irq_routing_table)) /
@@ -1157,11 +1157,42 @@ static struct irq_info *pirq_get_info(struct pci_dev *dev)
 	return slotinfo;
 }
 
+/*
+ * Buses behind bridges are typically not listed in the PIRQ routing table.
+ * Do the usual dance then and walk the tree of bridges up adjusting the
+ * pin number accordingly on the way until the originating root bus device
+ * has been reached and then use its routing information.
+ */
+static struct irq_info *pirq_get_info(struct pci_dev *dev, u8 *pin)
+{
+	struct pci_dev *temp_dev = dev;
+	struct irq_info *info;
+	u8 temp_pin = *pin;
+	u8 dpin = temp_pin;
+
+	info = pirq_get_dev_info(dev);
+	while (!info && temp_dev->bus->parent) {
+		struct pci_dev *bridge = temp_dev->bus->self;
+
+		temp_pin = pci_swizzle_interrupt_pin(temp_dev, temp_pin);
+		info = pirq_get_dev_info(bridge);
+		if (info)
+			dev_warn(&dev->dev,
+				 "using bridge %s INT %c to get INT %c\n",
+				 pci_name(bridge),
+				 'A' + temp_pin - 1, 'A' + dpin - 1);
+
+		temp_dev = bridge;
+	}
+	*pin = temp_pin;
+	return info;
+}
+
 static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 {
-	u8 pin;
 	struct irq_info *info;
 	int i, pirq, newirq;
+	u8 dpin, pin;
 	int irq = 0;
 	u32 mask;
 	struct irq_router *r = &pirq_router;
@@ -1169,8 +1200,8 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 	char *msg = NULL;
 
 	/* Find IRQ pin */
-	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
-	if (!pin) {
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &dpin);
+	if (!dpin) {
 		dev_dbg(&dev->dev, "no interrupt pin\n");
 		return 0;
 	}
@@ -1183,20 +1214,21 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 	if (!pirq_table)
 		return 0;
 
-	info = pirq_get_info(dev);
+	pin = dpin;
+	info = pirq_get_info(dev, &pin);
 	if (!info) {
 		dev_dbg(&dev->dev, "PCI INT %c not found in routing table\n",
-			'A' + pin - 1);
+			'A' + dpin - 1);
 		return 0;
 	}
 	pirq = info->irq[pin - 1].link;
 	mask = info->irq[pin - 1].bitmap;
 	if (!pirq) {
-		dev_dbg(&dev->dev, "PCI INT %c not routed\n", 'A' + pin - 1);
+		dev_dbg(&dev->dev, "PCI INT %c not routed\n", 'A' + dpin - 1);
 		return 0;
 	}
 	dev_dbg(&dev->dev, "PCI INT %c -> PIRQ %02x, mask %04x, excl %04x",
-		'A' + pin - 1, pirq, mask, pirq_table->exclusive_irqs);
+		'A' + dpin - 1, pirq, mask, pirq_table->exclusive_irqs);
 	mask &= pcibios_irq_mask;
 
 	/* Work around broken HP Pavilion Notebooks which assign USB to
@@ -1238,7 +1270,7 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 				newirq = i;
 		}
 	}
-	dev_dbg(&dev->dev, "PCI INT %c -> newirq %d", 'A' + pin - 1, newirq);
+	dev_dbg(&dev->dev, "PCI INT %c -> newirq %d", 'A' + dpin - 1, newirq);
 
 	/* Check if it is hardcoded */
 	if ((pirq & 0xf0) == 0xf0) {
@@ -1272,15 +1304,17 @@ static int pcibios_lookup_irq(struct pci_dev *dev, int assign)
 			return 0;
 		}
 	}
-	dev_info(&dev->dev, "%s PCI INT %c -> IRQ %d\n", msg, 'A' + pin - 1, irq);
+	dev_info(&dev->dev, "%s PCI INT %c -> IRQ %d\n",
+		 msg, 'A' + dpin - 1, irq);
 
 	/* Update IRQ for all devices with the same pirq value */
 	for_each_pci_dev(dev2) {
-		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &pin);
-		if (!pin)
+		pci_read_config_byte(dev2, PCI_INTERRUPT_PIN, &dpin);
+		if (!dpin)
 			continue;
 
-		info = pirq_get_info(dev2);
+		pin = dpin;
+		info = pirq_get_info(dev2, &pin);
 		if (!info)
 			continue;
 		if (info->irq[pin - 1].link == pirq) {
