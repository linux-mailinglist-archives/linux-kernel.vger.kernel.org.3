Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D455C38D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbiF0LvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiF0LsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:48:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51C98BE0A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:40:15 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx39kNl7liP_FfAA--.6156S13;
        Mon, 27 Jun 2022 19:40:04 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V13 11/13] irqchip: Add LoongArch CPU interrupt controller support
Date:   Mon, 27 Jun 2022 19:39:55 +0800
Message-Id: <1656329997-20524-12-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
References: <1656329997-20524-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx39kNl7liP_FfAA--.6156S13
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyftFW7GrykAF1kuF4Durg_yoW3ArykpF
        W3ZwnFqr4UJFWUXr90ka15Wryav3WfG3y2qayfGa47JrWqkryq9F1kZr9F9Fyjy3yUWay2
        9F4rtFW8uF4UAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
        JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

LoongArch CPUINTC stands for CSR.ECFG/CSR.ESTAT and related interrupt
controller that described in Section 7.4 of "LoongArch Reference Manual,
Vol 1". For more information please refer Documentation/loongarch/irq-
chip-model.rst.

LoongArch CPUINTC has 13 interrupt sources: SWI0~1, HWI0~7, IPI, TI
(Timer) and PCOV (PMC). IRQ mappings of HWI0~7 are configurable (can be
created from DT/ACPI), but IPI, TI (Timer) and PCOV (PMC) are hardcoded
bits, so we define get_xxx_irq() for them.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/irq.h    |   4 --
 arch/loongarch/kernel/irq.c         |   1 -
 drivers/irqchip/Kconfig             |  10 +++
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-loongarch-cpu.c | 131 ++++++++++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 5 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 021b8b5..fe61288 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -94,13 +94,10 @@ struct acpi_vector_group {
 struct acpi_madt_msi_pic;
 struct acpi_madt_lpc_pic;
 
-struct irq_domain *loongarch_cpu_irq_init(void);
-
 int liointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lio_pic *acpi_liointc);
 int eiointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_eio_pic *acpi_eiointc);
-
 int htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
 int pch_lpc_acpi_init(struct irq_domain *parent,
@@ -116,7 +113,6 @@ int pch_lpc_acpi_init(struct irq_domain *parent,
 extern struct acpi_madt_msi_pic *acpi_pchmsi[MAX_IO_PICS];
 extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
 
-extern struct irq_domain *cpu_domain;
 extern struct fwnode_handle *liointc_handle;
 extern struct fwnode_handle *pch_lpc_handle;
 extern struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 5695826..bb53ede 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -25,7 +25,6 @@
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
-struct irq_domain *cpu_domain;
 struct acpi_vector_group pch_group[MAX_IO_PICS];
 struct acpi_vector_group msi_group[MAX_IO_PICS];
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e918579..ebfa2cd 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -546,6 +546,16 @@ config EXYNOS_IRQ_COMBINER
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
index 0cfd4f0..e559007 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_EIOINTC)		+= irq-loongson-eiointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
new file mode 100644
index 0000000..f2dfbcb
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -0,0 +1,131 @@
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
+	.name		= "CPUINTC",
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
+
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
+	loongarch_cpu_irq_init();
+	acpi_cascade_irqdomain_init();
+	return 0;
+}
+IRQCHIP_ACPI_DECLARE(coreintc_v1, ACPI_MADT_TYPE_CORE_PIC,
+		NULL, ACPI_MADT_CORE_PIC_VERSION_V1,
+		coreintc_acpi_init_v1);
-- 
1.8.3.1

