Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933F9482D26
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 00:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiABXZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 18:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiABXZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:25:13 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9027C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 15:25:12 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id C0F4B9200D0; Mon,  3 Jan 2022 00:25:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id BAE9A9200CE;
        Sun,  2 Jan 2022 23:25:10 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:25:10 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] x86/PCI: Add support for the SiS85C497 PIRQ router
In-Reply-To: <alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2201022045560.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Tested-by: Nikolai Zhubr <zhubr.2@gmail.com>
---
 arch/x86/pci/irq.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

linux-x86-pirq-router-sis85c497.diff
Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -580,6 +580,81 @@ static int pirq_cyrix_set(struct pci_dev
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
@@ -969,6 +1044,11 @@ static __init int serverworks_router_pro
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
