Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B414FAD91
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiDJK5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbiDJK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:56:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90F91B7AC;
        Sun, 10 Apr 2022 03:54:32 -0700 (PDT)
Date:   Sun, 10 Apr 2022 10:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649588071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvGqTsjP8E61NKSYj+gKdPH9D515JASx/4dlmok3OtQ=;
        b=At6+kftCobmhiVtJRgiLb+d0YrF69e1byrgYwnsbgSB/kvEFwB9DtrKIWhnxIanxancoAV
        8ZzAnWrH8mg+UTzL7gmx3BALF53ZeXtwa8xhu2hXrRWl0PgBuPSJa2K06SLfLIA626mLXN
        7QCH05S74Fa9D6UD8dKNBa9gPyuPs+3EP++x71/AhzCqTn4+3hcR3ZKVogsCxCLPJjSiYZ
        Sz7nNZv8B3ccZSZMJ8WCHd15OayUIuIBc/dLDpJrBAooHpJ9L0l0O4zIWauGs/0MLOO0Vi
        A1OOoCAO0wkFPAlcKrrBmv3FmYTG7Vg7wk+WRC2nwHihGjwDLnXGwHIBX/aP8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649588071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvGqTsjP8E61NKSYj+gKdPH9D515JASx/4dlmok3OtQ=;
        b=5cL//+C5bRPmibdh2F5t4i0IqqOMzMdwCgfZH5578clqNNDjj0PY4UFJL/K8rXzp4LEn1Z
        BqFl/KptYKc6cHBw==
From:   "tip-bot2 for Maciej W. Rozycki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/PCI: Add support for the SiS85C497 PIRQ router
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nikolai Zhubr <zhubr.2@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <alpine.DEB.2.21.2203301610490.22465@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2203301610490.22465@angie.orcam.me.uk>
MIME-Version: 1.0
Message-ID: <164958807049.4207.2725071892682453211.tip-bot2@tip-bot2>
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

Commit-ID:     fe62bc23620fa027162e05594a610ff5e556496a
Gitweb:        https://git.kernel.org/tip/fe62bc23620fa027162e05594a610ff5e556496a
Author:        Maciej W. Rozycki <macro@orcam.me.uk>
AuthorDate:    Thu, 31 Mar 2022 08:10:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 12:48:14 +02:00

x86/PCI: Add support for the SiS85C497 PIRQ router

The SiS 85C496/497 486 Green PC VESA/ISA/PCI Chipset has support for PCI 
steering and the ELCR register implemented.  These features are handled 
by the SiS85C497 AT Bus Controller & Megacell (ATM) ISA bridge, however 
the device is wired as a peer bridge directly to the host bus and has 
its PCI configuration registers decoded at addresses 0x80-0xff by the 
accompanying SiS85C496 PCI & CPU Memory Controller (PCM) host bridge[1].  
Therefore we need to match on the host bridge's vendor and device ID.

Like with the SiS85C503 PIRQ router handle link value ranges of 1-4 and 
0xc0-0xc3, corresponding respectively to PIRQ line numbers counted from 
1 and link register PCI configuration space addresses.

References:

[1]  "486 Green PC VESA/ISA/PCI Chipset, SiS 85C496/497", Rev 3.0,
     Silicon Integrated Systems Corp., July 1995, Part IV, Section 3. 
     "PCI Configuration Space Registers (00h ~ FFh)", p. 114

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nikolai Zhubr <zhubr.2@gmail.com>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203301610490.22465@angie.orcam.me.uk

---
 arch/x86/pci/irq.c | 80 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+)

diff --git a/arch/x86/pci/irq.c b/arch/x86/pci/irq.c
index e5bc9f7..4b0e008 100644
--- a/arch/x86/pci/irq.c
+++ b/arch/x86/pci/irq.c
@@ -580,6 +580,81 @@ static int pirq_cyrix_set(struct pci_dev *router, struct pci_dev *dev, int pirq,
 	return 1;
 }
 
+
+/*
+ *	PIRQ routing for the SiS85C497 AT Bus Controller & Megacell (ATM)
+ *	ISA bridge used with the SiS 85C496/497 486 Green PC VESA/ISA/PCI
+ *	Chipset.
+ *
+ *	There are four PCI INTx#-to-IRQ Link registers provided in the
+ *	SiS85C497 part of the peculiar combined 85C496/497 configuration
+ *	space decoded by the SiS85C496 PCI & CPU Memory Controller (PCM)
+ *	host bridge, at 0xc0/0xc1/0xc2/0xc3 respectively for the PCI INT
+ *	A/B/C/D lines.  Bit 7 enables the respective link if set and bits
+ *	3:0 select the 8259A IRQ line as follows:
+ *
+ *	0000 : Reserved
+ *	0001 : Reserved
+ *	0010 : Reserved
+ *	0011 : IRQ3
+ *	0100 : IRQ4
+ *	0101 : IRQ5
+ *	0110 : IRQ6
+ *	0111 : IRQ7
+ *	1000 : Reserved
+ *	1001 : IRQ9
+ *	1010 : IRQ10
+ *	1011 : IRQ11
+ *	1100 : IRQ12
+ *	1101 : Reserved
+ *	1110 : IRQ14
+ *	1111 : IRQ15
+ *
+ *	We avoid using a reserved value for disabled links, hence the
+ *	choice of IRQ15 for that case.
+ *
+ *	References:
+ *
+ *	"486 Green PC VESA/ISA/PCI Chipset, SiS 85C496/497", Rev 3.0,
+ *	Silicon Integrated Systems Corp., July 1995
+ */
+
+#define PCI_SIS497_INTA_TO_IRQ_LINK	0xc0u
+
+#define PIRQ_SIS497_IRQ_MASK		0x0fu
+#define PIRQ_SIS497_IRQ_ENABLE		0x80u
+
+static int pirq_sis497_get(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq)
+{
+	int reg;
+	u8 x;
+
+	reg = pirq;
+	if (reg >= 1 && reg <= 4)
+		reg += PCI_SIS497_INTA_TO_IRQ_LINK - 1;
+
+	pci_read_config_byte(router, reg, &x);
+	return (x & PIRQ_SIS497_IRQ_ENABLE) ? (x & PIRQ_SIS497_IRQ_MASK) : 0;
+}
+
+static int pirq_sis497_set(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
+{
+	int reg;
+	u8 x;
+
+	reg = pirq;
+	if (reg >= 1 && reg <= 4)
+		reg += PCI_SIS497_INTA_TO_IRQ_LINK - 1;
+
+	pci_read_config_byte(router, reg, &x);
+	x &= ~(PIRQ_SIS497_IRQ_MASK | PIRQ_SIS497_IRQ_ENABLE);
+	x |= irq ? (PIRQ_SIS497_IRQ_ENABLE | irq) : PIRQ_SIS497_IRQ_MASK;
+	pci_write_config_byte(router, reg, x);
+	return 1;
+}
+
 /*
  *	PIRQ routing for SiS 85C503 router used in several SiS chipsets.
  *	We have to deal with the following issues here:
@@ -962,6 +1037,11 @@ static __init int serverworks_router_probe(struct irq_router *r,
 static __init int sis_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
 	switch (device) {
+	case PCI_DEVICE_ID_SI_496:
+		r->name = "SiS85C497";
+		r->get = pirq_sis497_get;
+		r->set = pirq_sis497_set;
+		return 1;
 	case PCI_DEVICE_ID_SI_503:
 		r->name = "SiS85C503";
 		r->get = pirq_sis503_get;
