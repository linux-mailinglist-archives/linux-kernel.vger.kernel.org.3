Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A2D482D25
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 00:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiABXZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 18:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiABXZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:25:06 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9DD7C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 15:25:05 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 228549200CF; Mon,  3 Jan 2022 00:25:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1F6B29200CE;
        Sun,  2 Jan 2022 23:25:05 +0000 (GMT)
Date:   Sun, 2 Jan 2022 23:25:05 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Nikolai Zhubr <zhubr.2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
cc:     Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/PCI: Disambiguate SiS85C503 PIRQ router code
 entities
In-Reply-To: <alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2201022044250.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201022040130.56863@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to adding support for the SiS85C497 PIRQ router add `503' 
to the names of SiS85C503 PIRQ router code entities so that they clearly 
indicate which device they refer to.

Also restructure `sis_router_probe' such that new device IDs will be 
just new switch cases.

No functional change.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
No change from v1.
---
 arch/x86/pci/irq.c |   33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

linux-x86-pirq-router-sis85c503.diff
Index: linux-macro/arch/x86/pci/irq.c
===================================================================
--- linux-macro.orig/arch/x86/pci/irq.c
+++ linux-macro/arch/x86/pci/irq.c
@@ -641,11 +641,12 @@ static int pirq_cyrix_set(struct pci_dev
  *				bit 6-4 are probably unused, not like 5595
  */
 
-#define PIRQ_SIS_IRQ_MASK	0x0f
-#define PIRQ_SIS_IRQ_DISABLE	0x80
-#define PIRQ_SIS_USB_ENABLE	0x40
+#define PIRQ_SIS503_IRQ_MASK	0x0f
+#define PIRQ_SIS503_IRQ_DISABLE	0x80
+#define PIRQ_SIS503_USB_ENABLE	0x40
 
-static int pirq_sis_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
+static int pirq_sis503_get(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq)
 {
 	u8 x;
 	int reg;
@@ -654,10 +655,11 @@ static int pirq_sis_get(struct pci_dev *
 	if (reg >= 0x01 && reg <= 0x04)
 		reg += 0x40;
 	pci_read_config_byte(router, reg, &x);
-	return (x & PIRQ_SIS_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS_IRQ_MASK);
+	return (x & PIRQ_SIS503_IRQ_DISABLE) ? 0 : (x & PIRQ_SIS503_IRQ_MASK);
 }
 
-static int pirq_sis_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
+static int pirq_sis503_set(struct pci_dev *router, struct pci_dev *dev,
+			   int pirq, int irq)
 {
 	u8 x;
 	int reg;
@@ -666,8 +668,8 @@ static int pirq_sis_set(struct pci_dev *
 	if (reg >= 0x01 && reg <= 0x04)
 		reg += 0x40;
 	pci_read_config_byte(router, reg, &x);
-	x &= ~(PIRQ_SIS_IRQ_MASK | PIRQ_SIS_IRQ_DISABLE);
-	x |= irq ? irq: PIRQ_SIS_IRQ_DISABLE;
+	x &= ~(PIRQ_SIS503_IRQ_MASK | PIRQ_SIS503_IRQ_DISABLE);
+	x |= irq ? irq : PIRQ_SIS503_IRQ_DISABLE;
 	pci_write_config_byte(router, reg, x);
 	return 1;
 }
@@ -966,13 +968,14 @@ static __init int serverworks_router_pro
 
 static __init int sis_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
-	if (device != PCI_DEVICE_ID_SI_503)
-		return 0;
-
-	r->name = "SIS";
-	r->get = pirq_sis_get;
-	r->set = pirq_sis_set;
-	return 1;
+	switch (device) {
+	case PCI_DEVICE_ID_SI_503:
+		r->name = "SiS85C503";
+		r->get = pirq_sis503_get;
+		r->set = pirq_sis503_set;
+		return 1;
+	}
+	return 0;
 }
 
 static __init int cyrix_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
