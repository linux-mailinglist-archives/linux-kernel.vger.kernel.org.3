Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3B4CEB03
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiCFLZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiCFLY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:24:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446E66F97
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:24:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 116D160B3A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7212DC340EC;
        Sun,  6 Mar 2022 11:24:03 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V10 09/10] irqchip: Add Loongson Extended I/O interrupt controller support
Date:   Sun,  6 Mar 2022 19:21:54 +0800
Message-Id: <20220306112155.811157-10-chenhuacai@loongson.cn>
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
with old MIPS-based Loongson) support. This patch add Loongson Extended
I/O CPU interrupt controller support.

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

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/Kconfig                |  10 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-loongson-eiointc.c | 372 +++++++++++++++++++++++++
 include/linux/cpuhotplug.h             |   1 +
 4 files changed, 384 insertions(+)
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a7fe97dcac8d..a785495df3d9 100644
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
 	depends on (MACH_LOONGSON64 && MIPS)
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 42724fc51103..2a5dc2b5f737 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
 obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
+obj-$(CONFIG_LOONGSON_EIOINTC)		+= irq-loongson-eiointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
new file mode 100644
index 000000000000..05b5a7952702
--- /dev/null
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -0,0 +1,372 @@
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
+#include <linux/syscore_ops.h>
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
+static struct eiointc_priv *eiointc_priv[2];
+
+int eiointc_get_node(int id)
+{
+	return eiointc_priv[id]->node;
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
+	unsigned char coremap[MAX_EIO_NODES];
+	uint32_t pos_off, data, data_byte, data_mask;
+
+	pos_off = pos & ~3;
+	data_byte = pos & 3;
+	data_mask = ~BIT_MASK(data_byte) & 0xf;
+
+	memset(coremap, 0, sizeof(unsigned char) * MAX_EIO_NODES);
+
+	/* Calculate node and coremap of target irq */
+	cpu_node = cpu_logical_map(cpu) / CORES_PER_EIO_NODE;
+	coremap[cpu_node] |= BIT(cpu_logical_map(cpu) % CORES_PER_EIO_NODE);
+
+	for_each_online_cpu(i) {
+		node = cpu_to_eio_node(i);
+		if (!node_isset(node, *node_map))
+			continue;
+
+		/* EIO node 0 is in charge of inter-node interrupt dispatch */
+		route_node = (node == mnode) ? cpu_node : node;
+		data = ((coremap[node] | (route_node << 4)) << (data_byte * 8));
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
+	if (!IS_ENABLED(CONFIG_SMP))
+		return -EPERM;
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
+	if (!d->parent_data)
+		vector = d->hwirq;
+	else
+		vector = d->parent_data->hwirq;
+
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
+			iocsr_writel(data, EIOINTC_REG_NODEMAP + i * 4);
+		}
+
+		for (i = 0; i < VEC_COUNT / 32 / 4; i++) {
+			bit = BIT(1 + index); /* Route to IP[1 + index] */
+			data = bit | (bit << 8) | (bit << 16) | (bit << 24);
+			iocsr_writel(data, EIOINTC_REG_IPMAP + i * 4);
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
+			iocsr_writel(data, EIOINTC_REG_ROUTE + i * 4);
+		}
+
+		for (i = 0; i < VEC_COUNT / 32; i++) {
+			data = 0xffffffff;
+			iocsr_writel(data, EIOINTC_REG_ENABLE + i * 4);
+			iocsr_writel(data, EIOINTC_REG_BOUNCE + i * 4);
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
+		pending = iocsr_readq(EIOINTC_REG_ISR + (i << 3));
+		iocsr_writeq(pending, EIOINTC_REG_ISR + (i << 3));
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
+	if (d->parent_data)
+		irq_chip_ack_parent(d);
+}
+
+static void eiointc_mask_irq(struct irq_data *d)
+{
+	if (d->parent_data)
+		irq_chip_mask_parent(d);
+}
+
+static void eiointc_unmask_irq(struct irq_data *d)
+{
+	if (d->parent_data)
+		irq_chip_unmask_parent(d);
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
+static int eiointc_suspend(void)
+{
+	return 0;
+}
+
+static void eiointc_resume(void)
+{
+	int i, j;
+	struct irq_desc *desc;
+	struct irq_data *irq_data;
+
+	eiointc_router_init(0);
+
+	for (i = 0; i < nr_pics; i++) {
+		for (j = 0; j < VEC_COUNT; j++) {
+			desc = irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
+			if (desc && desc->handle_irq && desc->handle_irq != handle_bad_irq) {
+				irq_data = &desc->irq_data;
+				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
+			}
+		}
+	}
+}
+
+static struct syscore_ops eiointc_syscore_ops = {
+	.suspend = eiointc_suspend,
+	.resume = eiointc_resume,
+};
+
+struct irq_domain *eiointc_acpi_init(struct irq_domain *parent,
+				     struct acpi_madt_eio_pic *acpi_eiointc)
+{
+	int i, parent_irq;
+	unsigned long node_map;
+	struct eiointc_priv *priv;
+
+	if (!acpi_eiointc)
+		return NULL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return NULL;
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
+		goto out_free_priv;
+	}
+
+	eiointc_priv[nr_pics++] = priv;
+
+	eiointc_router_init(0);
+
+	parent_irq = irq_create_mapping(parent, acpi_eiointc->cascade);
+	irq_set_chained_handler_and_data(parent_irq, eiointc_irq_dispatch, priv);
+
+	register_syscore_ops(&eiointc_syscore_ops);
+	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_LOONGARCH_STARTING,
+				  "irqchip/loongarch/intc:starting",
+				  eiointc_router_init, NULL);
+
+	return irq_find_matching_fwnode(priv->domain_handle, DOMAIN_BUS_ANY);
+
+out_free_priv:
+	priv->domain_handle = NULL;
+	kfree(priv);
+
+	return NULL;
+}
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 411a428ace4d..2caee2154f17 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -149,6 +149,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_BCM2836_STARTING,
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_STARTING,
+	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_MICROCODE_LOADER,
-- 
2.27.0

