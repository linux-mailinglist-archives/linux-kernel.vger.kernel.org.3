Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3053054741C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiFKLFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 07:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFKLEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 07:04:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88F83AB0C5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 04:04:43 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx707CdqRiKxA5AA--.24235S7;
        Sat, 11 Jun 2022 19:04:36 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH RFC V3 11/11] irqchip: Add Loongson PCH LPC controller support
Date:   Sat, 11 Jun 2022 19:04:34 +0800
Message-Id: <1654945474-30858-6-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1654945474-30858-1-git-send-email-lvjianmin@loongson.cn>
References: <1654945474-30858-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx707CdqRiKxA5AA--.24235S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw15WrWruw1UAr45tFy7Jrb_yoW3Gw4kpF
        W3u3y3Ar48XF4jvws5CayUZrW3Zwn7Kayjka93Gw13Jr9rC34vgFn2yF9rZFsrArWagFWa
        yFZ0yFW8CF15CaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4U
        JVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x0262
        8vn2kIc2xKxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
        vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
        Ja73UjIFyTuYvjfUF18BUUUUU
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are preparing to add new Loongson (based on LoongArch, not compatible
with old MIPS-based Loongson) support. This patch add Loongson PCH LPC
interrupt controller support.

PCH-LPC stands for "LPC Interrupts" that described in Section 24.3 of
"Loongson 7A1000 Bridge User Manual". For more information please refer
Documentation/loongarch/irq-chip-model.rst.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/Kconfig                |   8 ++
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-loongson-pch-lpc.c | 202 +++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a785495..4a3de74 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -601,6 +601,14 @@ config LOONGSON_PCH_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
 
+config LOONGSON_PCH_LPC
+	bool "Loongson PCH LPC Controller"
+	depends on MACH_LOONGSON64
+	default (MACH_LOONGSON64 && LOONGARCH)
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for the Loongson PCH LPC Controller.
+
 config MST_IRQ
 	bool "MStar Interrupt Controller"
 	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 519b7a1..6c21542 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
+obj-$(CONFIG_LOONGSON_PCH_LPC)		+= irq-loongson-pch-lpc.o
 obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loongson-pch-lpc.c
new file mode 100644
index 0000000..568fba7
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson LPC Interrupt Controller support
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#define pr_fmt(fmt) "lpc: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include "irq-loongarch-pic-common.h"
+
+/* Registers */
+#define LPC_INT_CTL		0x00
+#define LPC_INT_ENA		0x04
+#define LPC_INT_STS		0x08
+#define LPC_INT_CLR		0x0c
+#define LPC_INT_POL		0x10
+#define LPC_COUNT		16
+
+struct pch_lpc {
+	void __iomem		*base;
+	struct irq_domain	*lpc_domain;
+	raw_spinlock_t		lpc_lock;
+	u32			saved_reg_ctl;
+	u32			saved_reg_ena;
+	u32			saved_reg_pol;
+};
+
+static void ack_lpc_irq(struct irq_data *d)
+{
+	unsigned long flags;
+	struct pch_lpc *priv = d->domain->host_data;
+
+	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
+	writel(0x1 << d->hwirq, priv->base + LPC_INT_CLR);
+	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
+}
+static void mask_lpc_irq(struct irq_data *d)
+{
+	unsigned long flags;
+	struct pch_lpc *priv = d->domain->host_data;
+
+	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
+	writel(readl(priv->base + LPC_INT_ENA) & (~(0x1 << (d->hwirq))),
+			priv->base + LPC_INT_ENA);
+	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
+}
+
+static void unmask_lpc_irq(struct irq_data *d)
+{
+	unsigned long flags;
+	struct pch_lpc *priv = d->domain->host_data;
+
+	raw_spin_lock_irqsave(&priv->lpc_lock, flags);
+	writel(readl(priv->base + LPC_INT_ENA) | (0x1 << (d->hwirq)),
+			priv->base + LPC_INT_ENA);
+	raw_spin_unlock_irqrestore(&priv->lpc_lock, flags);
+}
+
+static int lpc_set_type(struct irq_data *d, unsigned int type)
+{
+	u32 val;
+	u32 mask = 0x1 << (d->hwirq);
+	struct pch_lpc *priv = d->domain->host_data;
+
+	if (!(type & IRQ_TYPE_LEVEL_MASK))
+		return 0;
+
+	val = readl(priv->base + LPC_INT_POL);
+
+	if (type == IRQ_TYPE_LEVEL_HIGH)
+		val |= mask;
+	else
+		val &= ~mask;
+
+	writel(val, priv->base + LPC_INT_POL);
+
+	return 0;
+}
+
+static struct irq_chip pch_lpc_irq_chip = {
+	.name			= "PCH LPC",
+	.irq_mask		= mask_lpc_irq,
+	.irq_unmask		= unmask_lpc_irq,
+	.irq_ack		= ack_lpc_irq,
+	.irq_set_type		= lpc_set_type,
+	.flags			= IRQCHIP_SKIP_SET_WAKE,
+};
+
+static void lpc_irq_dispatch(struct irq_desc *desc)
+{
+	u32 pending, bit, virq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct pch_lpc *priv = irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+
+	pending = readl(priv->base + LPC_INT_ENA);
+	pending &= readl(priv->base + LPC_INT_STS);
+	if (!pending)
+		spurious_interrupt();
+
+	while (pending) {
+		bit = __ffs(pending);
+		virq = irq_linear_revmap(priv->lpc_domain, bit);
+
+		generic_handle_irq(bit);
+		pending &= ~BIT(bit);
+	}
+	chained_irq_exit(chip, desc);
+}
+
+static int pch_lpc_map(struct irq_domain *d, unsigned int irq,
+			irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &pch_lpc_irq_chip, handle_level_irq);
+	return 0;
+}
+
+static const struct irq_domain_ops pch_lpc_domain_ops = {
+	.map 		= pch_lpc_map,
+	.translate	= irq_domain_translate_twocell,
+};
+
+static void pch_lpc_reset(struct pch_lpc *priv)
+{
+	/* Enable the LPC interrupt, bit31: en  bit30: edge */
+	writel(0x80000000, priv->base + LPC_INT_CTL);
+	writel(0, priv->base + LPC_INT_ENA);
+	/* Clear all 18-bit interrpt bit */
+	writel(0x3ffff, priv->base + LPC_INT_CLR);
+}
+
+static int pch_lpc_disabled(struct pch_lpc *priv)
+{
+	return (readl(priv->base + LPC_INT_ENA) == 0xffffffff) &&
+			(readl(priv->base + LPC_INT_STS) == 0xffffffff);
+}
+
+int __init pch_lpc_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_lpc_pic *acpi_pchlpc)
+{
+	int parent_irq;
+	struct pch_lpc *priv;
+	struct irq_fwspec fwspec;
+	struct fwnode_handle *irq_handle;
+
+	if (!acpi_pchlpc)
+		return -EINVAL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&priv->lpc_lock);
+
+	priv->base = ioremap(acpi_pchlpc->address, acpi_pchlpc->size);
+	if (!priv->base)
+		goto free_priv;
+
+	if (pch_lpc_disabled(priv)) {
+		pr_err("Failed to get LPC status\n");
+		goto iounmap_base;
+	}
+
+	irq_handle = irq_domain_alloc_named_fwnode("lpcintc");
+	if (!irq_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		goto iounmap_base;
+	}
+
+	priv->lpc_domain = irq_domain_create_linear(irq_handle, LPC_COUNT,
+					&pch_lpc_domain_ops, priv);
+	if (!priv->lpc_domain) {
+		pr_err("Failed to create IRQ domain\n");
+		goto iounmap_base;
+	}
+	pch_lpc_reset(priv);
+
+	fwspec.fwnode = parent->fwnode;
+	fwspec.param[0] = acpi_pchlpc->cascade;
+	fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
+	fwspec.param_count = 2;
+	parent_irq = irq_create_fwspec_mapping(&fwspec);
+	irq_set_chained_handler_and_data(parent_irq, lpc_irq_dispatch, priv);
+
+	pch_lpc_handle = irq_handle;
+	return 0;
+
+iounmap_base:
+	iounmap(priv->base);
+free_priv:
+	kfree(priv);
+
+	return -ENOMEM;
+}
-- 
1.8.3.1

