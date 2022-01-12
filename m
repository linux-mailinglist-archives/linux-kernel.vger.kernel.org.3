Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E8D48C70E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354635AbiALPTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:19:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35378 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243741AbiALPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:18:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E955B81F6F;
        Wed, 12 Jan 2022 15:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3368C36AEA;
        Wed, 12 Jan 2022 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642000724;
        bh=NMtXD9XGfSjQw24lmJI+lMXHAN8OHl/EPTCgYLivcC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYYGtr81QTCzI4iU2gu8MRONhgV0GKuluNVzdqUHxxkhxGAC8h97/x5QXSdNeM18W
         PXtDjFnnKuE4mriuDrtJcu+r8lyKSobcMyB02tTuNuBrW87alNAmHnr1f3VghKr/i2
         +0qqPmZcoI7Wv2soeQFkZBRilsyPMB+D8+ufU8WQA7/xPI28+ZnLlo4Oi5bWfFHvaD
         3TPiyEpf2hckHYPUnvgdqcIWL50nGyCT8Wl+RLWn1+aAcSWKY0ELekVd8hpRCSd9O3
         qD/+2pUPLaWiaTrBcmWdXxs2ghGXq010C1i52l/eMY7oyxc7EtJrvyjASSRKJvtouk
         dMMW0yNpS6NkA==
Received: by pali.im (Postfix)
        id 8A943768; Wed, 12 Jan 2022 16:18:43 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/11] PCI: mvebu: Implement support for legacy INTx interrupts
Date:   Wed, 12 Jan 2022 16:18:13 +0100
Message-Id: <20220112151814.24361-11-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220112151814.24361-1-pali@kernel.org>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for legacy INTx interrupts received from other PCIe
devices and which are reported by a new INTx irq chip.

With this change, kernel can distinguish between INTA, INTB, INTC and INTD
interrupts.

Note that for this support, device tree files has to be properly adjusted
to provide "interrupts" or "interrupts-extended" property with intx
interrupt source, "interrupt-names" property with "intx" string and also
'interrupt-controller' subnode must be defined.

If device tree files do not provide these nodes then driver would work as
before.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/pci-mvebu.c | 185 +++++++++++++++++++++++++++--
 1 file changed, 177 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1e90ab888075..dbb6ecb4cb70 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -54,9 +54,10 @@
 	 PCIE_CONF_ADDR_EN)
 #define PCIE_CONF_DATA_OFF	0x18fc
 #define PCIE_INT_CAUSE_OFF	0x1900
+#define PCIE_INT_UNMASK_OFF	0x1910
+#define  PCIE_INT_INTX(i)		BIT(24+i)
 #define  PCIE_INT_PM_PME		BIT(28)
-#define PCIE_MASK_OFF		0x1910
-#define  PCIE_MASK_ENABLE_INTS          0x0f000000
+#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
 #define PCIE_CTRL_OFF		0x1a00
 #define  PCIE_CTRL_X1_MODE		0x0001
 #define  PCIE_CTRL_RC_MODE		BIT(1)
@@ -110,6 +111,9 @@ struct mvebu_pcie_port {
 	struct mvebu_pcie_window iowin;
 	u32 saved_pcie_stat;
 	struct resource regs;
+	struct irq_domain *intx_irq_domain;
+	raw_spinlock_t irq_lock;
+	int intx_irq;
 };
 
 static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
@@ -235,7 +239,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 {
-	u32 ctrl, lnkcap, cmd, dev_rev, mask;
+	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
 
 	/* Setup PCIe controller to Root Complex mode. */
 	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
@@ -288,10 +292,30 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	/* Point PCIe unit MBUS decode windows to DRAM space. */
 	mvebu_pcie_setup_wins(port);
 
-	/* Enable interrupt lines A-D. */
-	mask = mvebu_readl(port, PCIE_MASK_OFF);
-	mask |= PCIE_MASK_ENABLE_INTS;
-	mvebu_writel(port, mask, PCIE_MASK_OFF);
+	/* Mask all interrupt sources. */
+	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
+
+	/* Clear all interrupt causes. */
+	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
+
+	if (port->intx_irq <= 0) {
+		/*
+		 * When neither "summary" interrupt, nor "intx" interrupt was
+		 * specified in DT then unmask all legacy INTx interrupts as in
+		 * this case driver does not provide a way for masking and
+		 * unmasking of individual legacy INTx interrupts. In this case
+		 * all interrupts, including legacy INTx are reported via one
+		 * shared GIC source and therefore kernel cannot distinguish
+		 * which individual legacy INTx was triggered. These interrupts
+		 * are shared, so it should not cause any issue. Just
+		 * performance penalty as every PCIe interrupt handler needs to
+		 * be called when some interrupt is triggered.
+		 */
+		unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+		unmask |= PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
+			  PCIE_INT_INTX(2) | PCIE_INT_INTX(3);
+		mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	}
 }
 
 static struct mvebu_pcie_port *mvebu_pcie_find_port(struct mvebu_pcie *pcie,
@@ -924,6 +948,108 @@ static struct pci_ops mvebu_pcie_ops = {
 	.write = mvebu_pcie_wr_conf,
 };
 
+static void mvebu_pcie_intx_irq_mask(struct irq_data *d)
+{
+	struct mvebu_pcie_port *port = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
+	u32 unmask;
+
+	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+	unmask &= ~PCIE_INT_INTX(hwirq);
+	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+}
+
+static void mvebu_pcie_intx_irq_unmask(struct irq_data *d)
+{
+	struct mvebu_pcie_port *port = d->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	unsigned long flags;
+	u32 unmask;
+
+	raw_spin_lock_irqsave(&port->irq_lock, flags);
+	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+	unmask |= PCIE_INT_INTX(hwirq);
+	mvebu_writel(port, unmask, PCIE_INT_UNMASK_OFF);
+	raw_spin_unlock_irqrestore(&port->irq_lock, flags);
+}
+
+static struct irq_chip intx_irq_chip = {
+	.name = "mvebu-INTx",
+	.irq_mask = mvebu_pcie_intx_irq_mask,
+	.irq_unmask = mvebu_pcie_intx_irq_unmask,
+};
+
+static int mvebu_pcie_intx_irq_map(struct irq_domain *h,
+				   unsigned int virq, irq_hw_number_t hwirq)
+{
+	struct mvebu_pcie_port *port = h->host_data;
+
+	irq_set_status_flags(virq, IRQ_LEVEL);
+	irq_set_chip_and_handler(virq, &intx_irq_chip, handle_level_irq);
+	irq_set_chip_data(virq, port);
+
+	return 0;
+}
+
+static const struct irq_domain_ops mvebu_pcie_intx_irq_domain_ops = {
+	.map = mvebu_pcie_intx_irq_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
+{
+	struct device *dev = &port->pcie->pdev->dev;
+	struct device_node *pcie_intc_node;
+
+	raw_spin_lock_init(&port->irq_lock);
+
+	pcie_intc_node = of_get_next_child(port->dn, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "No PCIe Intc node found for %s\n", port->name);
+		return -ENODEV;
+	}
+
+	port->intx_irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						      &mvebu_pcie_intx_irq_domain_ops,
+						      port);
+	of_node_put(pcie_intc_node);
+	if (!port->intx_irq_domain) {
+		dev_err(dev, "Failed to get INTx IRQ domain for %s\n", port->name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void mvebu_pcie_irq_handler(struct irq_desc *desc)
+{
+	struct mvebu_pcie_port *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct device *dev = &port->pcie->pdev->dev;
+	u32 cause, unmask, status;
+	int i;
+
+	chained_irq_enter(chip, desc);
+
+	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
+	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
+	status = cause & unmask;
+
+	/* Process legacy INTx interrupts */
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		if (!(status & PCIE_INT_INTX(i)))
+			continue;
+
+		if (generic_handle_domain_irq(port->intx_irq_domain, i) == -EINVAL)
+			dev_err_ratelimited(dev, "unexpected INT%c IRQ\n", (char)i+'A');
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
 static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	/* Interrupt support on mvebu emulated bridges is not implemented yet */
@@ -1121,6 +1247,21 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 		port->io_attr = -1;
 	}
 
+	/*
+	 * Old DT bindings do not contain "intx" interrupt
+	 * so do not fail probing driver when interrupt does not exist.
+	 */
+	port->intx_irq = of_irq_get_byname(child, "intx");
+	if (port->intx_irq == -EPROBE_DEFER) {
+		ret = port->intx_irq;
+		goto err;
+	}
+	if (port->intx_irq <= 0) {
+		dev_warn(dev, "%s: legacy INTx interrupts cannot be masked individually, "
+			      "%pOF does not contain intx interrupt\n",
+			 port->name, child);
+	}
+
 	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
 	if (reset_gpio == -EPROBE_DEFER) {
 		ret = reset_gpio;
@@ -1317,6 +1458,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
+		int irq = port->intx_irq;
 
 		child = port->dn;
 		if (!child)
@@ -1344,6 +1486,22 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		if (irq > 0) {
+			ret = mvebu_pcie_init_irq_domain(port);
+			if (ret) {
+				dev_err(dev, "%s: cannot init irq domain\n",
+					port->name);
+				pci_bridge_emul_cleanup(&port->bridge);
+				devm_iounmap(dev, port->base);
+				port->base = NULL;
+				mvebu_pcie_powerdown(port);
+				continue;
+			}
+			irq_set_chained_handler_and_data(irq,
+							 mvebu_pcie_irq_handler,
+							 port);
+		}
+
 		/*
 		 * PCIe topology exported by mvebu hw is quite complicated. In
 		 * reality has something like N fully independent host bridges
@@ -1448,6 +1606,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 
 	for (i = 0; i < pcie->nports; i++) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
+		int irq = port->intx_irq;
 
 		if (!port->base)
 			continue;
@@ -1458,7 +1617,17 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
 		mvebu_writel(port, cmd, PCIE_CMD_OFF);
 
 		/* Mask all interrupt sources. */
-		mvebu_writel(port, 0, PCIE_MASK_OFF);
+		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
+
+		/* Clear all interrupt causes. */
+		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
+
+		if (irq > 0)
+			irq_set_chained_handler_and_data(irq, NULL, NULL);
+
+		/* Remove IRQ domains. */
+		if (port->intx_irq_domain)
+			irq_domain_remove(port->intx_irq_domain);
 
 		/* Free config space for emulated root bridge. */
 		pci_bridge_emul_cleanup(&port->bridge);
-- 
2.20.1

