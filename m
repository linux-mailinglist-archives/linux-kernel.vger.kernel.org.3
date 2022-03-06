Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E424CEB01
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiCFLYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCFLYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:24:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25496673D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:23:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8F6260AFD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59200C340EC;
        Sun,  6 Mar 2022 11:23:45 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V10 08/10] irqchip: Add LoongArch CPU interrupt controller support
Date:   Sun,  6 Mar 2022 19:21:53 +0800
Message-Id: <20220306112155.811157-9-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220306112155.811157-1-chenhuacai@loongson.cn>
References: <20220306112155.811157-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are preparing to add new Loongson (based on LoongArch, not compatible
with old MIPS-based Loongson) support. This patch add the LoongArch CPU
interrupt controller support.

LoongArch CPUINTC stands for CSR.ECFG/CSR.ESTAT and related interrupt
controller that described in Section 7.4 of "LoongArch Reference Manual,
Vol 1". For more information please refer Documentation/loongarch/irq-
chip-model.rst.

LoongArch CPUINTC has 13 interrupt sources: SWI0~1, HWI0~7, IPI, TI
(Timer) and PCOV (PMC). IRQ mappings of HWI0~7 are configurable (can be
created from DT/ACPI), but IPI, TI (Timer) and PCOV (PMC) are hardcoded
bits, so we define get_xxx_irq() for them.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/Kconfig             | 10 ++++
 drivers/irqchip/Makefile            |  1 +
 drivers/irqchip/irq-loongarch-cpu.c | 92 +++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 139aa10e0b80..a7fe97dcac8d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -536,6 +536,16 @@ config EXYNOS_IRQ_COMBINER
 	  Say yes here to add support for the IRQ combiner devices embedded
 	  in Samsung Exynos chips.
 
+config IRQ_LOONGARCH_CPU
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	help
+	  Support for the LoongArch CPU Interrupt Controller. For details of
+	  irq chip hierarchy on LoongArch platforms please read the document
+	  Documentation/loongarch/irq-chip-model.rst.
+
 config LOONGSON_LIOINTC
 	bool "Loongson Local I/O Interrupt Controller"
 	depends on MACH_LOONGSON64
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c1f611cbfbf8..42724fc51103 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
new file mode 100644
index 000000000000..6f7e66734af3
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+
+#include <asm/loongarch.h>
+#include <asm/setup.h>
+
+static struct irq_domain *irq_domain;
+
+static void mask_loongarch_irq(struct irq_data *d)
+{
+	clear_csr_ecfg(ECFGF(d->hwirq));
+}
+
+static void unmask_loongarch_irq(struct irq_data *d)
+{
+	set_csr_ecfg(ECFGF(d->hwirq));
+}
+
+static struct irq_chip cpu_irq_controller = {
+	.name		= "LoongArch",
+	.irq_mask	= mask_loongarch_irq,
+	.irq_unmask	= unmask_loongarch_irq,
+};
+
+static void handle_cpu_irq(struct pt_regs *regs)
+{
+	int hwirq;
+	unsigned int estat = read_csr_estat() & CSR_ESTAT_IS;
+
+	while ((hwirq = ffs(estat))) {
+		estat &= ~BIT(hwirq - 1);
+		generic_handle_domain_irq(irq_domain, hwirq - 1);
+	}
+}
+
+int get_ipi_irq(void)
+{
+	return irq_create_mapping(irq_domain, EXCCODE_IPI - EXCCODE_INT_START);
+}
+
+int get_pmc_irq(void)
+{
+	return irq_create_mapping(irq_domain, EXCCODE_PMC - EXCCODE_INT_START);
+}
+
+int get_timer_irq(void)
+{
+	return irq_create_mapping(irq_domain, EXCCODE_TIMER - EXCCODE_INT_START);
+}
+
+static int loongarch_cpu_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_set_noprobe(irq);
+	irq_set_chip_and_handler(irq, &cpu_irq_controller, handle_percpu_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
+	.map = loongarch_cpu_intc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+struct irq_domain * __init loongarch_cpu_irq_init(void)
+{
+	struct fwnode_handle *domain_handle;
+
+	/* Mask interrupts. */
+	clear_csr_ecfg(ECFG0_IM);
+	clear_csr_estat(ESTATF_IP);
+
+	domain_handle = irq_domain_alloc_fwnode(NULL);
+	irq_domain = irq_domain_create_linear(domain_handle, EXCCODE_INT_NUM,
+					&loongarch_cpu_intc_irq_domain_ops, NULL);
+
+	if (!irq_domain)
+		panic("Failed to add irqdomain for LoongArch CPU");
+
+	set_handle_irq(&handle_cpu_irq);
+
+	return irq_domain;
+}
-- 
2.27.0

