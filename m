Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C965154DB15
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359323AbiFPGyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359013AbiFPGxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:53:50 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDE7B5997A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:53:40 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(23338:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 16 Jun 2022 14:42:36 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     sboyd@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>, Marc Zyngier <maz@kernel.org>
Subject: [PATCH v19 08/11] irqchip: Add Sunplus SP7021 interrupt controller driver
Date:   Thu, 16 Jun 2022 14:42:24 +0800
Message-Id: <870195b818c1e9d78b1db67acee64a8b0014c620.1655360818.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1655360818.git.qinjian@cqplus1.com>
References: <cover.1655360818.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt controller driver for Sunplus SP7021 SoC.

This is the interrupt controller in P-chip which collects all interrupt
sources in P-chip and routes them to parent interrupt controller in C-chip.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 MAINTAINERS                       |   3 -
 drivers/irqchip/Kconfig           |   9 +
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-sp7021-intc.c | 278 ++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 3 deletions(-)
 create mode 100644 drivers/irqchip/irq-sp7021-intc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f5f625fb..cdbc9eb26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2831,9 +2831,6 @@ F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
-F:	arch/arm/boot/dts/sunplus-sp7021*.dts*
-F:	arch/arm/configs/sp7021_*defconfig
-F:	arch/arm/mach-sunplus/
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/irqchip/irq-sp7021-intc.c
 F:	drivers/reset/reset-sunplus.c
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4ab1038b5..8a4468de1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -627,4 +627,13 @@ config MCHP_EIC
 	help
 	  Support for Microchip External Interrupt Controller.
 
+config SUNPLUS_SP7021_INTC
+	bool "Sunplus SP7021 interrupt controller" if COMPILE_TEST
+	default SOC_SP7021
+	help
+	  Support for the Sunplus SP7021 Interrupt Controller IP core.
+	  SP7021 SoC has 2 Chips: C-Chip & P-Chip. This is used as a
+	  chained controller, routing all interrupt source in P-Chip to
+	  the primary controller on C-Chip.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5b67450a9..cb12a1526 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -115,3 +115,4 @@ obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
+obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
diff --git a/drivers/irqchip/irq-sp7021-intc.c b/drivers/irqchip/irq-sp7021-intc.c
new file mode 100644
index 000000000..bed78d1de
--- /dev/null
+++ b/drivers/irqchip/irq-sp7021-intc.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (C) Sunplus Technology Co., Ltd.
+ *       All rights reserved.
+ */
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define SP_INTC_HWIRQ_MIN	0
+#define SP_INTC_HWIRQ_MAX	223
+
+#define SP_INTC_NR_IRQS		(SP_INTC_HWIRQ_MAX - SP_INTC_HWIRQ_MIN + 1)
+#define SP_INTC_NR_GROUPS	DIV_ROUND_UP(SP_INTC_NR_IRQS, 32)
+#define SP_INTC_REG_SIZE	(SP_INTC_NR_GROUPS * 4)
+
+/* REG_GROUP_0 regs */
+#define REG_INTR_TYPE		(sp_intc.g0)
+#define REG_INTR_POLARITY	(REG_INTR_TYPE     + SP_INTC_REG_SIZE)
+#define REG_INTR_PRIORITY	(REG_INTR_POLARITY + SP_INTC_REG_SIZE)
+#define REG_INTR_MASK		(REG_INTR_PRIORITY + SP_INTC_REG_SIZE)
+
+/* REG_GROUP_1 regs */
+#define REG_INTR_CLEAR		(sp_intc.g1)
+#define REG_MASKED_EXT1		(REG_INTR_CLEAR    + SP_INTC_REG_SIZE)
+#define REG_MASKED_EXT0		(REG_MASKED_EXT1   + SP_INTC_REG_SIZE)
+#define REG_INTR_GROUP		(REG_INTR_CLEAR    + 31 * 4)
+
+#define GROUP_MASK		(BIT(SP_INTC_NR_GROUPS) - 1)
+#define GROUP_SHIFT_EXT1	(0)
+#define GROUP_SHIFT_EXT0	(8)
+
+/*
+ * When GPIO_INT0~7 set to edge trigger, doesn't work properly.
+ * WORKAROUND: change it to level trigger, and toggle the polarity
+ * at ACK/Handler to make the HW work.
+ */
+#define GPIO_INT0_HWIRQ		120
+#define GPIO_INT7_HWIRQ		127
+#define IS_GPIO_INT(irq)					\
+({								\
+	u32 i = irq;						\
+	(i >= GPIO_INT0_HWIRQ) && (i <= GPIO_INT7_HWIRQ);	\
+})
+
+/* index of states */
+enum {
+	_IS_EDGE = 0,
+	_IS_LOW,
+	_IS_ACTIVE
+};
+
+#define STATE_BIT(irq, idx)		(((irq) - GPIO_INT0_HWIRQ) * 3 + (idx))
+#define ASSIGN_STATE(irq, idx, v)	assign_bit(STATE_BIT(irq, idx), sp_intc.states, v)
+#define TEST_STATE(irq, idx)		test_bit(STATE_BIT(irq, idx), sp_intc.states)
+
+static struct sp_intctl {
+	/*
+	 * REG_GROUP_0: include type/polarity/priority/mask regs.
+	 * REG_GROUP_1: include clear/masked_ext0/masked_ext1/group regs.
+	 */
+	void __iomem *g0; // REG_GROUP_0 base
+	void __iomem *g1; // REG_GROUP_1 base
+
+	struct irq_domain *domain;
+	raw_spinlock_t lock;
+
+	/*
+	 * store GPIO_INT states
+	 * each interrupt has 3 states: is_edge, is_low, is_active
+	 */
+	DECLARE_BITMAP(states, (GPIO_INT7_HWIRQ - GPIO_INT0_HWIRQ + 1) * 3);
+} sp_intc;
+
+static struct irq_chip sp_intc_chip;
+
+static void sp_intc_assign_bit(u32 hwirq, void __iomem *base, bool value)
+{
+	u32 offset, mask;
+	unsigned long flags;
+	void __iomem *reg;
+
+	offset = (hwirq / 32) * 4;
+	reg = base + offset;
+
+	raw_spin_lock_irqsave(&sp_intc.lock, flags);
+	mask = readl_relaxed(reg);
+	if (value)
+		mask |= BIT(hwirq % 32);
+	else
+		mask &= ~BIT(hwirq % 32);
+	writel_relaxed(mask, reg);
+	raw_spin_unlock_irqrestore(&sp_intc.lock, flags);
+}
+
+static void sp_intc_ack_irq(struct irq_data *d)
+{
+	u32 hwirq = d->hwirq;
+
+	if (unlikely(IS_GPIO_INT(hwirq) && TEST_STATE(hwirq, _IS_EDGE))) { // WORKAROUND
+		sp_intc_assign_bit(hwirq, REG_INTR_POLARITY, !TEST_STATE(hwirq, _IS_LOW));
+		ASSIGN_STATE(hwirq, _IS_ACTIVE, true);
+	}
+
+	sp_intc_assign_bit(hwirq, REG_INTR_CLEAR, 1);
+}
+
+static void sp_intc_mask_irq(struct irq_data *d)
+{
+	sp_intc_assign_bit(d->hwirq, REG_INTR_MASK, 0);
+}
+
+static void sp_intc_unmask_irq(struct irq_data *d)
+{
+	sp_intc_assign_bit(d->hwirq, REG_INTR_MASK, 1);
+}
+
+static int sp_intc_set_type(struct irq_data *d, unsigned int type)
+{
+	u32 hwirq = d->hwirq;
+	bool is_edge = !(type & IRQ_TYPE_LEVEL_MASK);
+	bool is_low = (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_EDGE_FALLING);
+
+	irq_set_handler_locked(d, is_edge ? handle_edge_irq : handle_level_irq);
+
+	if (unlikely(IS_GPIO_INT(hwirq) && is_edge)) { // WORKAROUND
+		/* store states */
+		ASSIGN_STATE(hwirq, _IS_EDGE, is_edge);
+		ASSIGN_STATE(hwirq, _IS_LOW, is_low);
+		ASSIGN_STATE(hwirq, _IS_ACTIVE, false);
+		/* change to level */
+		is_edge = false;
+	}
+
+	sp_intc_assign_bit(hwirq, REG_INTR_TYPE, is_edge);
+	sp_intc_assign_bit(hwirq, REG_INTR_POLARITY, is_low);
+
+	return 0;
+}
+
+static int sp_intc_get_ext_irq(int ext_num)
+{
+	void __iomem *base = ext_num ? REG_MASKED_EXT1 : REG_MASKED_EXT0;
+	u32 shift = ext_num ? GROUP_SHIFT_EXT1 : GROUP_SHIFT_EXT0;
+	u32 groups;
+	u32 pending_group;
+	u32 group;
+	u32 pending_irq;
+
+	groups = readl_relaxed(REG_INTR_GROUP);
+	pending_group = (groups >> shift) & GROUP_MASK;
+	if (!pending_group)
+		return -1;
+
+	group = fls(pending_group) - 1;
+	pending_irq = readl_relaxed(base + group * 4);
+	if (!pending_irq)
+		return -1;
+
+	return (group * 32) + fls(pending_irq) - 1;
+}
+
+static void sp_intc_handle_ext_cascaded(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int ext_num = (uintptr_t)irq_desc_get_handler_data(desc);
+	int hwirq;
+
+	chained_irq_enter(chip, desc);
+
+	while ((hwirq = sp_intc_get_ext_irq(ext_num)) >= 0) {
+		if (unlikely(IS_GPIO_INT(hwirq) && TEST_STATE(hwirq, _IS_ACTIVE))) { // WORKAROUND
+			ASSIGN_STATE(hwirq, _IS_ACTIVE, false);
+			sp_intc_assign_bit(hwirq, REG_INTR_POLARITY, TEST_STATE(hwirq, _IS_LOW));
+		} else {
+			generic_handle_domain_irq(sp_intc.domain, hwirq);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static struct irq_chip sp_intc_chip = {
+	.name = "sp_intc",
+	.irq_ack = sp_intc_ack_irq,
+	.irq_mask = sp_intc_mask_irq,
+	.irq_unmask = sp_intc_unmask_irq,
+	.irq_set_type = sp_intc_set_type,
+};
+
+static int sp_intc_irq_domain_map(struct irq_domain *domain,
+				  unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sp_intc_chip, handle_level_irq);
+	irq_set_chip_data(irq, &sp_intc_chip);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops sp_intc_dm_ops = {
+	.xlate = irq_domain_xlate_twocell,
+	.map = sp_intc_irq_domain_map,
+};
+
+static int sp_intc_irq_map(struct device_node *node, int i)
+{
+	unsigned int irq;
+
+	irq = irq_of_parse_and_map(node, i);
+	if (!irq)
+		return -ENOENT;
+
+	irq_set_chained_handler_and_data(irq, sp_intc_handle_ext_cascaded, (void *)(uintptr_t)i);
+
+	return 0;
+}
+
+static int __init sp_intc_init_dt(struct device_node *node, struct device_node *parent)
+{
+	int i, ret;
+
+	sp_intc.g0 = of_iomap(node, 0);
+	if (!sp_intc.g0)
+		return -ENXIO;
+
+	sp_intc.g1 = of_iomap(node, 1);
+	if (!sp_intc.g1) {
+		ret = -ENXIO;
+		goto out_unmap0;
+	}
+
+	ret = sp_intc_irq_map(node, 0); // EXT_INT0
+	if (ret)
+		goto out_unmap1;
+
+	ret = sp_intc_irq_map(node, 1); // EXT_INT1
+	if (ret)
+		goto out_unmap1;
+
+	/* initial regs */
+	for (i = 0; i < SP_INTC_NR_GROUPS; i++) {
+		/* all mask */
+		writel_relaxed(0, REG_INTR_MASK + i * 4);
+		/* all edge */
+		writel_relaxed(~0, REG_INTR_TYPE + i * 4);
+		/* all high-active */
+		writel_relaxed(0, REG_INTR_POLARITY + i * 4);
+		/* all EXT_INT0 */
+		writel_relaxed(~0, REG_INTR_PRIORITY + i * 4);
+		/* all clear */
+		writel_relaxed(~0, REG_INTR_CLEAR + i * 4);
+	}
+
+	sp_intc.domain = irq_domain_add_linear(node, SP_INTC_NR_IRQS,
+					       &sp_intc_dm_ops, &sp_intc);
+	if (!sp_intc.domain) {
+		ret = -ENOMEM;
+		goto out_unmap1;
+	}
+
+	raw_spin_lock_init(&sp_intc.lock);
+
+	return 0;
+
+out_unmap1:
+	iounmap(sp_intc.g1);
+out_unmap0:
+	iounmap(sp_intc.g0);
+
+	return ret;
+}
+
+IRQCHIP_DECLARE(sp_intc, "sunplus,sp7021-intc", sp_intc_init_dt);
-- 
2.33.1

