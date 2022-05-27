Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3993A535EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351207AbiE0LDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350746AbiE0LCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:02:51 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B134413D35
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:02:33 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Cxj+a3r5BiSRAEAA--.20871S4;
        Fri, 27 May 2022 19:02:29 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH RFC V2 02/10] irqchip: Add LoongArch CPU interrupt controller support
Date:   Fri, 27 May 2022 19:02:12 +0800
Message-Id: <1653649335-11998-3-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1653649335-11998-1-git-send-email-lvjianmin@loongson.cn>
References: <1653649335-11998-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Cxj+a3r5BiSRAEAA--.20871S4
X-Coremail-Antispam: 1UD129KBjvAXoWfGr15uw4fAr4kCFyxZFyxXwb_yoW8JFWDXo
        WfXFZrA348Cr1rJrWjgFs2qFW5ZF98uan3A3s3ursxA34rKr45Ka17Ka4ayFW3WF1rJrZx
        AFWIgw1fJFZrXFnxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYW7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M28IrcIa0x
        kI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
        jcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe1v3UUUUU
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
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/irqchip/Kconfig                    |  10 ++
 drivers/irqchip/Makefile                   |   1 +
 drivers/irqchip/irq-loongarch-cpu.c        | 115 +++++++++++++++++
 drivers/irqchip/irq-loongarch-pic-common.c | 201 +++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongarch-pic-common.h |  44 +++++++
 5 files changed, 371 insertions(+)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongarch-pic-common.c
 create mode 100644 drivers/irqchip/irq-loongarch-pic-common.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 39d6be2..a596ee7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -545,6 +545,16 @@ config EXYNOS_IRQ_COMBINER
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
index 160a1d8..736f030 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-pic-common.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
new file mode 100644
index 0000000..26f948f
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -0,0 +1,115 @@
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
+#include "irq-loongarch-pic-common.h"
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
+	/* Mask interrupts. */
+	clear_csr_ecfg(ECFG0_IM);
+	clear_csr_estat(ESTATF_IP);
+
+	irq_domain = irq_domain_add_legacy(NULL, EXCCODE_INT_NUM, 0, 0,
+						&loongarch_cpu_intc_irq_domain_ops, NULL);
+	if (!irq_domain)
+		panic("Failed to add irqdomain for LoongArch CPU");
+
+	set_handle_irq(&handle_cpu_irq);
+
+	return irq_domain;
+}
+#ifdef CONFIG_ACPI
+static int __init
+liointc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_lio_pic *liointc_entry = (struct acpi_madt_lio_pic *)header;
+
+	return liointc_acpi_init(irq_domain, liointc_entry);
+}
+
+static int __init
+eiointc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_eio_pic *eiointc_entry = (struct acpi_madt_eio_pic *)header;
+
+	return eiointc_acpi_init(irq_domain, eiointc_entry);
+}
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
+			      liointc_parse_madt, 0);
+	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
+			      eiointc_parse_madt, 0);
+	return 0;
+}
+static int __init coreintc_acpi_init_v1(union acpi_subtable_headers *header,
+				   const unsigned long end)
+{
+	if (irq_domain)
+		return 0;
+
+	init_vector_parent_group();
+	loongarch_cpu_irq_init();
+	acpi_cascade_irqdomain_init();
+	return 0;
+}
+IRQCHIP_ACPI_DECLARE(coreintc_v1, ACPI_MADT_TYPE_CORE_PIC,
+		NULL, ACPI_MADT_CORE_PIC_VERSION_V1,
+		coreintc_acpi_init_v1);
+#endif
diff --git a/drivers/irqchip/irq-loongarch-pic-common.c b/drivers/irqchip/irq-loongarch-pic-common.c
new file mode 100644
index 0000000..94437e4
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-pic-common.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Loongson Limited, All Rights Reserved.
+ */
+
+#include <linux/irq.h>
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include "irq-loongarch-pic-common.h"
+
+static struct acpi_vector_group vector_group[MAX_IO_PICS];
+struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
+
+struct irq_domain *liointc_domain;
+struct irq_domain *pch_lpc_domain;
+struct irq_domain *pch_msi_domain[MAX_IO_PICS];
+struct irq_domain *pch_pic_domain[MAX_IO_PICS];
+
+static int find_pch_pic(u32 gsi)
+{
+	int i, start, end;
+
+	/* Find the PCH_PIC that manages this GSI. */
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		struct acpi_madt_bio_pic *irq_cfg = acpi_pchpic[i];
+
+		if (!irq_cfg)
+			return -1;
+
+		start = irq_cfg->gsi_base;
+		end   = irq_cfg->gsi_base + irq_cfg->size;
+		if (gsi >= start && gsi < end)
+			return i;
+	}
+
+	pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
+	return -1;
+}
+
+int pcibios_device_add(struct pci_dev *dev)
+{
+	int id = pci_domain_nr(dev->bus);
+
+	dev_set_msi_domain(&dev->dev, pch_msi_domain[id]);
+
+	return 0;
+}
+
+int acpi_gsi_to_irq(u32 gsi, unsigned int *irqp)
+{
+	if (irqp != NULL)
+		*irqp = acpi_register_gsi(NULL, gsi, -1, -1);
+	return (*irqp >= 0) ? 0 : -EINVAL;
+}
+EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
+
+int acpi_isa_irq_to_gsi(unsigned int isa_irq, u32 *gsi)
+{
+	if (gsi)
+		*gsi = isa_irq;
+	return 0;
+}
+
+/*
+ * success: return IRQ number (>=0)
+ * failure: return < 0
+ */
+int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
+{
+	int id;
+	struct irq_fwspec fwspec;
+
+	switch (gsi) {
+	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+		fwspec.fwnode = liointc_domain->fwnode;
+		fwspec.param[0] = gsi - GSI_MIN_CPU_IRQ;
+		fwspec.param_count = 1;
+
+		return irq_create_fwspec_mapping(&fwspec);
+
+	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
+		if (!pch_lpc_domain)
+			return -EINVAL;
+
+		fwspec.fwnode = pch_lpc_domain->fwnode;
+		fwspec.param[0] = gsi - GSI_MIN_LPC_IRQ;
+		fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
+		fwspec.param_count = 2;
+
+		return irq_create_fwspec_mapping(&fwspec);
+
+	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+		id = find_pch_pic(gsi);
+		if (id < 0)
+			return -EINVAL;
+
+		fwspec.fwnode = pch_pic_domain[id]->fwnode;
+		fwspec.param[0] = gsi - acpi_pchpic[id]->gsi_base;
+		fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
+		fwspec.param_count = 2;
+
+		return irq_create_fwspec_mapping(&fwspec);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(acpi_register_gsi);
+
+void acpi_unregister_gsi(u32 gsi)
+{
+	int id, irq, hw_irq;
+	struct irq_domain *d;
+
+	switch (gsi) {
+	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+		if (!liointc_domain)
+			return;
+		d = liointc_domain;
+		hw_irq = gsi - GSI_MIN_CPU_IRQ;
+		break;
+
+	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
+		if (!pch_lpc_domain)
+			return;
+		d = pch_lpc_domain;
+		hw_irq = gsi - GSI_MIN_LPC_IRQ;
+		break;
+
+	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+		id = find_pch_pic(gsi);
+		if (id < 0)
+			return;
+		if (!pch_pic_domain[id])
+			return;
+		d = pch_pic_domain[id];
+
+		hw_irq = gsi - acpi_pchpic[id]->gsi_base;
+		break;
+	}
+	irq = irq_find_mapping(d, hw_irq);
+	irq_dispose_mapping(irq);
+
+	return;
+}
+EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
+
+static int pci_mcfg_parse(struct acpi_table_header *header)
+{
+	struct acpi_table_mcfg *mcfg;
+	struct acpi_mcfg_allocation *mptr;
+	int i, n;
+
+	if (header->length < sizeof(struct acpi_table_mcfg))
+		return -EINVAL;
+
+	n = (header->length - sizeof(struct acpi_table_mcfg)) /
+					sizeof(struct acpi_mcfg_allocation);
+	mcfg = (struct acpi_table_mcfg *)header;
+	mptr = (struct acpi_mcfg_allocation *) &mcfg[1];
+
+	for (i = 0; i < n; i++, mptr++)
+		vector_group[mptr->pci_segment].node = (mptr->address >> 44) & 0xf;
+
+	return 0;
+}
+
+void __init init_vector_parent_group(void)
+{
+	acpi_table_parse(ACPI_SIG_MCFG, pci_mcfg_parse);
+}
+
+void acpi_set_vector_parent(int node, struct irq_domain *parent)
+{
+	int i;
+
+	if (cpu_has_flatmode)
+		node = cpu_to_node(node * CORES_PER_EIO_NODE);
+
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		if (node == vector_group[i].node) {
+			vector_group[i].parent = parent;
+			return;
+		}
+	}
+}
+
+struct irq_domain *acpi_get_msi_parent(int index)
+{
+	return vector_group[index].parent;
+}
+
+struct irq_domain *acpi_get_pch_parent(int node)
+{
+	int i;
+
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		if (node == vector_group[i].node)
+			return vector_group[i].parent;
+	}
+	return NULL;
+}
diff --git a/drivers/irqchip/irq-loongarch-pic-common.h b/drivers/irqchip/irq-loongarch-pic-common.h
new file mode 100644
index 0000000..3815fc9
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-pic-common.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Loongson Limited, All Rights Reserved.
+ */
+
+#ifndef _IRQ_LOONGARCH_PIC_COMMON_H
+#define _IRQ_LOONGARCH_PIC_COMMON_H
+
+#include <linux/of.h>
+#include <linux/irqdomain.h>
+
+struct acpi_vector_group {
+	int node;
+	struct irq_domain *parent;
+};
+
+/* IRQ number definitions */
+#define LOONGSON_LPC_IRQ_BASE		0
+#define LOONGSON_CPU_IRQ_BASE		16
+#define LOONGSON_PCH_IRQ_BASE		64
+
+#define GSI_MIN_LPC_IRQ		LOONGSON_LPC_IRQ_BASE
+#define GSI_MAX_LPC_IRQ		(LOONGSON_LPC_IRQ_BASE + 16 - 1)
+#define GSI_MIN_CPU_IRQ		LOONGSON_CPU_IRQ_BASE
+#define GSI_MAX_CPU_IRQ		(LOONGSON_CPU_IRQ_BASE + 48 - 1)
+#define GSI_MIN_PCH_IRQ		LOONGSON_PCH_IRQ_BASE
+#define GSI_MAX_PCH_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
+
+extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
+extern struct irq_domain *liointc_domain;
+extern struct irq_domain *pch_lpc_domain;
+extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
+extern struct irq_domain *pch_pic_domain[MAX_IO_PICS];
+
+int liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic *acpi_liointc);
+int eiointc_acpi_init(struct irq_domain *parent, struct acpi_madt_eio_pic *acpi_eiointc);
+int htvec_acpi_init(struct irq_domain *parent, struct acpi_madt_ht_pic *acpi_htvec);
+int pch_lpc_acpi_init(struct irq_domain *parent, struct acpi_madt_lpc_pic *acpi_pchlpc);
+void init_vector_parent_group(void);
+void acpi_set_vector_parent(int node, struct irq_domain *parent);
+struct irq_domain *acpi_get_msi_parent(int index);
+struct irq_domain *acpi_get_pch_parent(int node);
+
+#endif /* _IRQ_LOONGARCH_PIC_COMMON_H */
-- 
1.8.3.1

