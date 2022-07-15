Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0500575C23
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiGOHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiGOHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:06:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B38074359
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:06:10 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWeDQEdFiyyogAA--.1717S15;
        Fri, 15 Jul 2022 15:06:02 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V15 13/15] irqchip: Add Loongson Extended I/O interrupt controller support
Date:   Fri, 15 Jul 2022 15:05:49 +0800
Message-Id: <1657868751-30444-14-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9AxWeDQEdFiyyogAA--.1717S15
X-Coremail-Antispam: 1UD129KBjvAXoW3uw1DJw4UCry5tr1fXr18Xwb_yoW8XF15Wo
        WfJFsxtw1rJr1fZrWrWw4xtry5Zas0qr9Yywn3urZ3u3WfAa15KF47W3Waya13Ja1rCryx
        Za4xXa4xJFWxXFn8n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUY47CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAF
        z4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
        x4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
        0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48J
        MxAIw28IcVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
        xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUbXdbUUUUUU==
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

EIOINTC stands for "Extended I/O Interrupts" that described in Section
11.2 of "Loongson 3A5000 Processor Reference Manual". For more
information please refer Documentation/loongarch/irq-chip-model.rst.

Loongson-3A5000 has 4 cores per NUMA node, and each NUMA node has an
EIOINTC; while Loongson-3C5000 has 16 cores per NUMA node, and each NUMA
node has 4 EIOINTCs. In other words, 16 cores of one NUMA node in
Loongson-3C5000 are organized in 4 groups, each group connects to an
EIOINTC. We call the "group" here as an EIOINTC node, so each EIOINTC
node always includes 4 cores (both in Loongson-3A5000 and Loongson-
3C5000).

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/irq.h       |  11 +-
 drivers/irqchip/Kconfig                |  10 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-loongson-eiointc.c | 395 +++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h             |   1 +
 5 files changed, 408 insertions(+), 10 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index a07315a..a826ac4 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -87,15 +87,6 @@ struct acpi_vector_group {
 extern int find_pch_pic(u32 gsi);
 extern int eiointc_get_node(int id);
 
-static inline void eiointc_enable(void)
-{
-	uint64_t misc;
-
-	misc = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
-	misc |= IOCSR_MISC_FUNC_EXT_IOI_EN;
-	iocsr_write64(misc, LOONGARCH_IOCSR_MISC_FUNC);
-}
-
 struct acpi_madt_lio_pic;
 struct acpi_madt_eio_pic;
 struct acpi_madt_ht_pic;
@@ -107,7 +98,7 @@ static inline void eiointc_enable(void)
 
 int liointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lio_pic *acpi_liointc);
-struct irq_domain *eiointc_acpi_init(struct irq_domain *parent,
+int eiointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_eio_pic *acpi_eiointc);
 
 int htvec_acpi_init(struct irq_domain *parent,
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8844e6b..8f077d3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -555,6 +555,16 @@ config LOONGSON_LIOINTC
 	help
 	  Support for the Loongson Local I/O Interrupt Controller.
 
+config LOONGSON_EIOINTC
+	bool "Loongson Extend I/O Interrupt Controller"
+	depends on LOONGARCH
+	depends on MACH_LOONGSON64
+	default MACH_LOONGSON64
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_CHIP
+	help
+	  Support for the Loongson3 Extend I/O Interrupt Vector Controller.
+
 config LOONGSON_HTPIC
 	bool "Loongson3 HyperTransport PIC Controller"
 	depends on MACH_LOONGSON64 && MIPS
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 242b8b3..0cfd4f0 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
+obj-$(CONFIG_LOONGSON_EIOINTC)		+= irq-loongson-eiointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
new file mode 100644
index 0000000..80d8ca6
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Loongson Extend I/O Interrupt Controller support
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#define pr_fmt(fmt) "eiointc: " fmt
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#define EIOINTC_REG_NODEMAP	0x14a0
+#define EIOINTC_REG_IPMAP	0x14c0
+#define EIOINTC_REG_ENABLE	0x1600
+#define EIOINTC_REG_BOUNCE	0x1680
+#define EIOINTC_REG_ISR		0x1800
+#define EIOINTC_REG_ROUTE	0x1c00
+
+#define VEC_REG_COUNT		4
+#define VEC_COUNT_PER_REG	64
+#define VEC_COUNT		(VEC_REG_COUNT * VEC_COUNT_PER_REG)
+#define VEC_REG_IDX(irq_id)	((irq_id) / VEC_COUNT_PER_REG)
+#define VEC_REG_BIT(irq_id)     ((irq_id) % VEC_COUNT_PER_REG)
+#define EIOINTC_ALL_ENABLE	0xffffffff
+
+#define MAX_EIO_NODES		(NR_CPUS / CORES_PER_EIO_NODE)
+
+static int nr_pics;
+
+struct eiointc_priv {
+	u32			node;
+	nodemask_t		node_map;
+	cpumask_t		cpuspan_map;
+	struct fwnode_handle	*domain_handle;
+	struct irq_domain	*eiointc_domain;
+};
+
+static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
+
+static void eiointc_enable(void)
+{
+	uint64_t misc;
+
+	misc = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
+	misc |= IOCSR_MISC_FUNC_EXT_IOI_EN;
+	iocsr_write64(misc, LOONGARCH_IOCSR_MISC_FUNC);
+}
+
+static int cpu_to_eio_node(int cpu)
+{
+	return cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
+}
+
+static void eiointc_set_irq_route(int pos, unsigned int cpu, unsigned int mnode, nodemask_t *node_map)
+{
+	int i, node, cpu_node, route_node;
+	unsigned char coremap;
+	uint32_t pos_off, data, data_byte, data_mask;
+
+	pos_off = pos & ~3;
+	data_byte = pos & 3;
+	data_mask = ~BIT_MASK(data_byte) & 0xf;
+
+	/* Calculate node and coremap of target irq */
+	cpu_node = cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
+	coremap = BIT(cpu_logical_map(cpu) % CORES_PER_EIO_NODE);
+
+	for_each_online_cpu(i) {
+		node = cpu_to_eio_node(i);
+		if (!node_isset(node, *node_map))
+			continue;
+
+		/* EIO node 0 is in charge of inter-node interrupt dispatch */
+		route_node = (node == mnode) ? cpu_node : node;
+		data = ((coremap | (route_node << 4)) << (data_byte * 8));
+		csr_any_send(EIOINTC_REG_ROUTE + pos_off, data, data_mask, node * CORES_PER_EIO_NODE);
+	}
+}
+
+static DEFINE_RAW_SPINLOCK(affinity_lock);
+
+static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *affinity, bool force)
+{
+	unsigned int cpu;
+	unsigned long flags;
+	uint32_t vector, regaddr;
+	struct cpumask intersect_affinity;
+	struct eiointc_priv *priv = d->domain->host_data;
+
+	raw_spin_lock_irqsave(&affinity_lock, flags);
+
+	cpumask_and(&intersect_affinity, affinity, cpu_online_mask);
+	cpumask_and(&intersect_affinity, &intersect_affinity, &priv->cpuspan_map);
+
+	if (cpumask_empty(&intersect_affinity)) {
+		raw_spin_unlock_irqrestore(&affinity_lock, flags);
+		return -EINVAL;
+	}
+	cpu = cpumask_first(&intersect_affinity);
+
+	vector = d->hwirq;
+	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);
+
+	/* Mask target vector */
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE & (~BIT(vector & 0x1F)), 0x0, 0);
+	/* Set route for target vector */
+	eiointc_set_irq_route(vector, cpu, priv->node, &priv->node_map);
+	/* Unmask target vector */
+	csr_any_send(regaddr, EIOINTC_ALL_ENABLE, 0x0, 0);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	raw_spin_unlock_irqrestore(&affinity_lock, flags);
+
+	return IRQ_SET_MASK_OK;
+}
+
+static int eiointc_index(int node)
+{
+	int i;
+
+	for (i = 0; i < nr_pics; i++) {
+		if (node_isset(node, eiointc_priv[i]->node_map))
+			return i;
+	}
+
+	return -1;
+}
+
+static int eiointc_router_init(unsigned int cpu)
+{
+	int i, bit;
+	uint32_t data;
+	uint32_t node = cpu_to_eio_node(cpu);
+	uint32_t index = eiointc_index(node);
+
+	if (index < 0) {
+		pr_err("Error: invalid nodemap!\n");
+		return -1;
+	}
+
+	if ((cpu_logical_map(cpu) % CORES_PER_EIO_NODE) == 0) {
+		eiointc_enable();
+
+		for (i = 0; i < VEC_COUNT / 32; i++) {
+			data = (((1 << (i * 2 + 1)) << 16) | (1 << (i * 2)));
+			iocsr_write32(data, EIOINTC_REG_NODEMAP + i * 4);
+		}
+
+		for (i = 0; i < VEC_COUNT / 32 / 4; i++) {
+			bit = BIT(1 + index); /* Route to IP[1 + index] */
+			data = bit | (bit << 8) | (bit << 16) | (bit << 24);
+			iocsr_write32(data, EIOINTC_REG_IPMAP + i * 4);
+		}
+
+		for (i = 0; i < VEC_COUNT / 4; i++) {
+			/* Route to Node-0 Core-0 */
+			if (index == 0)
+				bit = BIT(cpu_logical_map(0));
+			else
+				bit = (eiointc_priv[index]->node << 4) | 1;
+
+			data = bit | (bit << 8) | (bit << 16) | (bit << 24);
+			iocsr_write32(data, EIOINTC_REG_ROUTE + i * 4);
+		}
+
+		for (i = 0; i < VEC_COUNT / 32; i++) {
+			data = 0xffffffff;
+			iocsr_write32(data, EIOINTC_REG_ENABLE + i * 4);
+			iocsr_write32(data, EIOINTC_REG_BOUNCE + i * 4);
+		}
+	}
+
+	return 0;
+}
+
+static void eiointc_irq_dispatch(struct irq_desc *desc)
+{
+	int i;
+	u64 pending;
+	bool handled = false;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct eiointc_priv *priv = irq_desc_get_handler_data(desc);
+
+	chained_irq_enter(chip, desc);
+
+	for (i = 0; i < VEC_REG_COUNT; i++) {
+		pending = iocsr_read64(EIOINTC_REG_ISR + (i << 3));
+		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
+		while (pending) {
+			int bit = __ffs(pending);
+			int irq = bit + VEC_COUNT_PER_REG * i;
+
+			generic_handle_domain_irq(priv->eiointc_domain, irq);
+			pending &= ~BIT(bit);
+			handled = true;
+		}
+	}
+
+	if (!handled)
+		spurious_interrupt();
+
+	chained_irq_exit(chip, desc);
+}
+
+static void eiointc_ack_irq(struct irq_data *d)
+{
+}
+
+static void eiointc_mask_irq(struct irq_data *d)
+{
+}
+
+static void eiointc_unmask_irq(struct irq_data *d)
+{
+}
+
+static struct irq_chip eiointc_irq_chip = {
+	.name			= "EIOINTC",
+	.irq_ack		= eiointc_ack_irq,
+	.irq_mask		= eiointc_mask_irq,
+	.irq_unmask		= eiointc_unmask_irq,
+	.irq_set_affinity	= eiointc_set_irq_affinity,
+};
+
+static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int ret;
+	unsigned int i, type;
+	unsigned long hwirq = 0;
+	struct eiointc *priv = domain->host_data;
+
+	ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i, &eiointc_irq_chip,
+					priv, handle_edge_irq, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void eiointc_domain_free(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs)
+{
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_data *d = irq_domain_get_irq_data(domain, virq + i);
+
+		irq_set_handler(virq + i, NULL);
+		irq_domain_reset_irq_data(d);
+	}
+}
+
+static const struct irq_domain_ops eiointc_domain_ops = {
+	.translate	= irq_domain_translate_onecell,
+	.alloc		= eiointc_domain_alloc,
+	.free		= eiointc_domain_free,
+};
+
+static void acpi_set_vec_parent(int node, struct irq_domain *parent, struct acpi_vector_group *vec_group)
+{
+	int i;
+
+	if (cpu_has_flatmode)
+		node = cpu_to_node(node * CORES_PER_EIO_NODE);
+
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		if (node == vec_group[i].node) {
+			vec_group[i].parent = parent;
+			return;
+		}
+	}
+}
+
+struct irq_domain *acpi_get_vec_parent(int node, struct acpi_vector_group *vec_group)
+{
+	int i;
+
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		if (node == vec_group[i].node)
+			return vec_group[i].parent;
+	}
+	return NULL;
+}
+
+static int __init
+pch_pic_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
+	unsigned int node = (pchpic_entry->address >> 44) & 0xf;
+	struct irq_domain *parent = acpi_get_vec_parent(node, pch_group);
+
+	if (parent)
+		return pch_pic_acpi_init(parent, pchpic_entry);
+
+	return -EINVAL;
+}
+
+static int __init
+pch_msi_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
+	struct irq_domain *parent = acpi_get_vec_parent(eiointc_priv[nr_pics - 1]->node, msi_group);
+
+	if (parent)
+		return pch_msi_acpi_init(parent, pchmsi_entry);
+
+	return -EINVAL;
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
+			      pch_pic_parse_madt, 0);
+	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
+			      pch_msi_parse_madt, 1);
+	return 0;
+}
+
+int __init eiointc_acpi_init(struct irq_domain *parent,
+				     struct acpi_madt_eio_pic *acpi_eiointc)
+{
+	int i, parent_irq;
+	unsigned long node_map;
+	struct eiointc_priv *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_eiointc);
+	if (!priv->domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		goto out_free_priv;
+	}
+
+	priv->node = acpi_eiointc->node;
+	node_map = acpi_eiointc->node_map ? : -1ULL;
+
+	for_each_possible_cpu(i) {
+		if (node_map & (1ULL << cpu_to_eio_node(i))) {
+			node_set(cpu_to_eio_node(i), priv->node_map);
+			cpumask_or(&priv->cpuspan_map, &priv->cpuspan_map, cpumask_of(i));
+		}
+	}
+
+	/* Setup IRQ domain */
+	priv->eiointc_domain = irq_domain_create_linear(priv->domain_handle, VEC_COUNT,
+					&eiointc_domain_ops, priv);
+	if (!priv->eiointc_domain) {
+		pr_err("loongson-eiointc: cannot add IRQ domain\n");
+		goto out_free_handle;
+	}
+
+	eiointc_priv[nr_pics++] = priv;
+
+	eiointc_router_init(0);
+
+	parent_irq = irq_create_mapping(parent, acpi_eiointc->cascade);
+	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
+
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
+				  "irqchip/loongarch/intc:starting",
+				  eiointc_router_init, NULL);
+
+	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, pch_group);
+	acpi_set_vec_parent(acpi_eiointc->node, priv->eiointc_domain, msi_group);
+	acpi_cascade_irqdomain_init();
+
+	return 0;
+
+out_free_handle:
+	irq_domain_free_fwnode(priv->domain_handle);
+	priv->domain_handle = NULL;
+out_free_priv:
+	kfree(priv);
+
+	return -ENOMEM;
+}
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 19f0dbf..de662f3 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -151,6 +151,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_STARTING,
+	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_MICROCODE_LOADER,
-- 
1.8.3.1

