Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6406575C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiGOHHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiGOHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:06:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B04174358
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:06:10 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWeDQEdFiyyogAA--.1717S16;
        Fri, 15 Jul 2022 15:06:03 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V15 14/15] irqchip: Add LoongArch CPU interrupt controller support
Date:   Fri, 15 Jul 2022 15:05:50 +0800
Message-Id: <1657868751-30444-15-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9AxWeDQEdFiyyogAA--.1717S16
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyftFW7GrykZr18Xw4fKrg_yoWftw1DpF
        W3AwsFqr4UJFW8Xr9Yka98Wry3Zw1fG3y2qayfGa43Ar4DtryqqF1vyr9F9FyYy3y8Gay2
        vF4rtFW8uF4UAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VW5Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
        6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
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
bits, so we expose the fwnode_handle to map them, and get mapped irq
by irq_create_mapping when using them.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/irq.h    |   8 +--
 arch/loongarch/kernel/irq.c         |  15 ++++-
 arch/loongarch/kernel/time.c        |  14 ++++-
 drivers/irqchip/Kconfig             |  10 +++
 drivers/irqchip/Makefile            |   1 +
 drivers/irqchip/irq-loongarch-cpu.c | 119 ++++++++++++++++++++++++++++++++++++
 6 files changed, 157 insertions(+), 10 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index a826ac4..ca46856 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -35,9 +35,6 @@ static inline bool on_irq_stack(int cpu, unsigned long sp)
 	return (low <= sp && sp <= high);
 }
 
-int get_ipi_irq(void);
-int get_pmc_irq(void);
-int get_timer_irq(void);
 void spurious_interrupt(void);
 
 #define NR_IRQS_LEGACY 16
@@ -94,13 +91,10 @@ struct acpi_vector_group {
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
@@ -120,7 +114,7 @@ int pch_pic_acpi_init(struct irq_domain *parent,
 extern struct acpi_madt_msi_pic *acpi_pchmsi[MAX_IO_PICS];
 extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
 
-extern struct irq_domain *cpu_domain;
+extern struct fwnode_handle *cpuintc_handle;
 extern struct fwnode_handle *liointc_handle;
 extern struct fwnode_handle *pch_lpc_handle;
 extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 06f2a15..99924d8 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -25,7 +25,6 @@
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
-struct irq_domain *cpu_domain;
 struct acpi_vector_group pch_group[MAX_IO_PICS];
 struct acpi_vector_group msi_group[MAX_IO_PICS];
 
@@ -89,6 +88,16 @@ static void __init init_vec_parent_group(void)
 	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
 }
 
+static int __init get_ipi_irq(void)
+{
+	struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
+
+	if (d)
+		return irq_create_mapping(d, EXCCODE_IPI - EXCCODE_INT_START);
+
+	return -EINVAL;
+}
+
 void __init init_IRQ(void)
 {
 	int i;
@@ -105,7 +114,9 @@ void __init init_IRQ(void)
 	init_vec_parent_group();
 	irqchip_init();
 #ifdef CONFIG_SMP
-	ipi_irq = EXCCODE_IPI - EXCCODE_INT_START;
+	ipi_irq = get_ipi_irq();
+	if (ipi_irq < 0)
+		panic("IPI IRQ mapping failed\n");
 	irq_set_percpu_devid(ipi_irq);
 	r = request_percpu_irq(ipi_irq, loongson3_ipi_interrupt, "IPI", &ipi_dummy_dev);
 	if (r < 0)
diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
index fe68238..79dc5ed 100644
--- a/arch/loongarch/kernel/time.c
+++ b/arch/loongarch/kernel/time.c
@@ -123,6 +123,16 @@ void sync_counter(void)
 	csr_write64(-init_timeval, LOONGARCH_CSR_CNTC);
 }
 
+static int get_timer_irq(void)
+{
+	struct irq_domain *d = irq_find_matching_fwnode(cpuintc_handle, DOMAIN_BUS_ANY);
+
+	if (d)
+		return irq_create_mapping(d, EXCCODE_TIMER - EXCCODE_INT_START);
+
+	return -EINVAL;
+}
+
 int constant_clockevent_init(void)
 {
 	unsigned int irq;
@@ -132,7 +142,9 @@ int constant_clockevent_init(void)
 	struct clock_event_device *cd;
 	static int timer_irq_installed = 0;
 
-	irq = EXCCODE_TIMER - EXCCODE_INT_START;
+	irq = get_timer_irq();
+	if (irq < 0)
+		pr_err("Failed to map irq %d (timer)\n", irq);
 
 	cd = &per_cpu(constant_clockevent_device, cpu);
 
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8f077d3..f53164c 100644
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
index 0000000..476f407
--- /dev/null
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -0,0 +1,119 @@
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
+struct fwnode_handle *cpuintc_handle;
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
+static int __init loongarch_cpu_irq_init(void)
+{
+	/* Mask interrupts. */
+	clear_csr_ecfg(ECFG0_IM);
+	clear_csr_estat(ESTATF_IP);
+
+	cpuintc_handle = irq_domain_alloc_fwnode(NULL);
+	irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
+					&loongarch_cpu_intc_irq_domain_ops, NULL);
+
+	if (!irq_domain)
+		panic("Failed to add irqdomain for LoongArch CPU");
+
+	set_handle_irq(&handle_cpu_irq);
+
+	return 0;
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
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
+			      liointc_parse_madt, 0);
+	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
+			      eiointc_parse_madt, 0);
+	return 0;
+}
+
+static int __init coreintc_acpi_init_v1(union acpi_subtable_headers *header,
+				   const unsigned long end)
+{
+	if (irq_domain)
+		return 0;
+
+	loongarch_cpu_irq_init();
+	acpi_cascade_irqdomain_init();
+
+	return 0;
+}
+
+IRQCHIP_ACPI_DECLARE(coreintc_v1, ACPI_MADT_TYPE_CORE_PIC,
+		NULL, ACPI_MADT_CORE_PIC_VERSION_V1,
+		coreintc_acpi_init_v1);
-- 
1.8.3.1

