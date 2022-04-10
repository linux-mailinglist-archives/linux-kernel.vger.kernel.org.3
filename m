Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6284FAD8B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbiDJK4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiDJK4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7FD1B78B;
        Sun, 10 Apr 2022 03:54:29 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXMgtxVdsYQjWjMd2CLJ8t0VDESANjVtCC+9y1cU/Xk=;
        b=RhHftVvZfPe1QRjqkgEuZh5JVjbcmdddKit02i0fGLhaBHgS42EH+6YDAhWjovX0PPhk4o
        N8PYR2LuY0bM38QuvO6w6XZG83HBH2v6BJIqZmEKhxsMCUqeOqjvG87pBeSJJdy0YFni4U
        fYkclzszXSr2c21NexKkPa/bOLbc4vsroBA8x93wza02OzpTIb/nkNFe3sEcdgDp8Ego0u
        YW5YSTey50RjcYCJkRIs7SycFq9zbPCUhYyaibKh0Wnya95iwnTYrME3Vr7kJ4RfDa1tCa
        I5k5TJBTtoVlwkZA20ySg9anL0HfgClfjdHcwsfVBCXrA+B/jOwqjc+pTlyElQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xXMgtxVdsYQjWjMd2CLJ8t0VDESANjVtCC+9y1cU/Xk=;
        b=I2UuCMv3QfbuJxiBxK4a3D8c2ECB76BZ/n872fjP8VaR0AwYuUa/CXXZs92NFBi3XOj3UN
        mcFMbv5V/CajK4AA==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Fix ALi M1487 (IBC) PIRQ router link value
 interpretation
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2203310013270.44113@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203310013270.44113@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958806677.4207.10793944128781488268.tip-bot2@tip-bot2>
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

Commit-ID:     4969e223b109754c2340a26bba9b1cf44f0cba9b
Gitweb:        https://git.kernel.org/tip/4969e223b109754c2340a26bba9b1cf44f0cba9b
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:11:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:15 +02:00

x86/PCI: Fix ALi M1487 (IBC) PIRQ router link value interpretation

Fix an issue with commit 1ce849c75534 ("x86/PCI: Add support for the ALi 
M1487 (IBC) PIRQ router") and correct ALi M1487 (IBC) PIRQ router link 
value (`pirq' cookie) interpretation according to findings in the BIOS.

Credit to Nikolai Zhubr for the detective work as to the bit layout.

Fixes: 1ce849c75534 ("x86/PCI: Add support for the ALi M1487 (IBC) PIRQ router")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203310013270.44113@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index 4a5e80f..ceac715 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -337,6 +337,15 @@ static void write_pc_conf_nybble(u8 base, u8 index, u8 val)
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
@@ -344,11 +353,13 @@ static int pirq_finali_get(struct pci_dev *router, struct pci_dev *dev,
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
@@ -362,13 +373,15 @@ static int pirq_finali_set(struct pci_dev *router, struct pci_dev *dev,
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
@@ -377,7 +390,7 @@ static int pirq_finali_set(struct pci_dev *router, struct pci_dev *dev,
 static int pirq_finali_lvl(struct pci_dev *router, struct pci_dev *dev,
 			   int pirq, int irq)
 {
-	u8 mask = ~(1u << (pirq - 1));
+	u8 mask = ~((pirq & 0xf0u) >> 4);
 	unsigned long flags;
 	u8 trig;
 
