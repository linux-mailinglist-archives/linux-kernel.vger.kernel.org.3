Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D674A796A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347104AbiBBUan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:30:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48936 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiBBUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:30:42 -0500
Date:   Wed, 02 Feb 2022 20:30:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643833841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54afrDkQmYef/7+IzIcc6kjzecS6H7UHSY23IZtpV+k=;
        b=uM1KuDg0Z2BWAGs0/oJkePKm2RKyyl2FrmMaTudHZ6XlFHar5lCQuMMUH9op731+NfHRO+
        u2OHgfFFyqIICq1qIAuA+CtPsivOLdkpfvEq4/TKzgQigVDmQrQ3UiYyOWzbnBe51V8Z2l
        E9H3IgUV8aga9v1c+PLPGTsXh62zbim0tA9Wu+whW+ENwMQ9fWplOjEn5Kn3Wz1c4kU/Bw
        KlqjWPLrraoqYxU4UPFJRlTVy4hUPQ4NE0LDyP2tQbpdWxgNnitOT0ubdPG70lNjUvQw3k
        P5U7M/16jJHxiSUJg5knQeiH6WyDaPBqVupZrmgr14lojYHpMDzbcdNfXK4QIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643833841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54afrDkQmYef/7+IzIcc6kjzecS6H7UHSY23IZtpV+k=;
        b=Wo7x8CaY74Kqj6HeK6Fa+04Ho+bziicX5e/KDuInAl/040ChhBEccysdxucNIOJvYryg+K
        mFOffYA0ytjnjFCw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Fix ALi M1487 (IBC) PIRQ router link value
 interpretation
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2201022131050.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022131050.56863@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164383383990.16921.10511731021620392794.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     07a9d83afc3d193da7abad1929725ba3fcfb703c
Gitweb:        https://git.kernel.org/tip/07a9d83afc3d193da7abad1929725ba3fcfb703c
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 06 Jan 2022 11:24:16 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:27:55 +01:00

x86/PCI: Fix ALi M1487 (IBC) PIRQ router link value interpretation

Correct ALi M1487 (IBC) PIRQ router link value (`pirq' cookie)
interpretation according to findings in the BIOS.

Credit to Nikolai Zhubr for the detective work as to the bit layout.

Fixes: 1ce849c75534 ("x86/PCI: Add support for the ALi M1487 (IBC) PIRQ router")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2201022131050.56863@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 486ba58..b0d0640 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -324,6 +324,15 @@ static void write_pc_conf_nybble(u8 base, u8 index, u8 val)
 	pc_conf_set(reg, x);
 }
 
+/*
+ * FinALi pirq rules are as follows:
+ *
+ * - bit 0 selects between INTx Routing Table Mapping Registers,
+ *
+ * - bit 3 selects the nibble within the INTx Routing Table Mapping Register,
+ *
+ * - bits 7:4 map to bits 3:0 of the PCI INTx Sensitivity Register.
+ */
 static int pirq_finali_get(struct pci_dev *router, struct pci_dev *dev,
 			   int pirq)
 {
@@ -331,11 +340,13 @@ static int pirq_finali_get(struct pci_dev *router, struct pci_dev *dev,
 		0, 9, 3, 10, 4, 5, 7, 6, 0, 11, 0, 12, 0, 14, 0, 15
 	};
 	unsigned long flags;
+	u8 index;
 	u8 x;
 
+	index = (pirq & 1) << 1 | (pirq & 8) >> 3;
 	raw_spin_lock_irqsave(&pc_conf_lock, flags);
 	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
-	x = irqmap[read_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1)];
+	x = irqmap[read_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, index)];
 	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
 	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
 	return x;
@@ -349,13 +360,15 @@ static int pirq_finali_set(struct pci_dev *router, struct pci_dev *dev,
 	};
 	u8 val = irqmap[irq];
 	unsigned long flags;
+	u8 index;
 
 	if (!val)
 		return 0;
 
+	index = (pirq & 1) << 1 | (pirq & 8) >> 3;
 	raw_spin_lock_irqsave(&pc_conf_lock, flags);
 	pc_conf_set(PC_CONF_FINALI_LOCK, PC_CONF_FINALI_LOCK_KEY);
-	write_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, pirq - 1, val);
+	write_pc_conf_nybble(PC_CONF_FINALI_PCI_INTX_RT1, index, val);
 	pc_conf_set(PC_CONF_FINALI_LOCK, 0);
 	raw_spin_unlock_irqrestore(&pc_conf_lock, flags);
 	return 1;
@@ -364,7 +377,7 @@ static int pirq_finali_set(struct pci_dev *router, struct pci_dev *dev,
 static int pirq_finali_lvl(struct pci_dev *router, struct pci_dev *dev,
 			   int pirq, int irq)
 {
-	u8 mask = ~(1u << (pirq - 1));
+	u8 mask = ~((pirq & 0xf0u) >> 4);
 	unsigned long flags;
 	u8 trig;
 
