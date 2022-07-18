Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3657850C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbiGROOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiGRON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:13:58 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E76E613E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:13:53 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9GWatViBtEmAA--.33569S12;
        Mon, 18 Jul 2022 22:13:47 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V16 10/14] irqchip/loongson-liointc: Add ACPI init support
Date:   Mon, 18 Jul 2022 22:13:37 +0800
Message-Id: <1658153621-40445-11-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
References: <1658153621-40445-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx_9GWatViBtEmAA--.33569S12
X-Coremail-Antispam: 1UD129KBjvJXoW3KryfuF4kuw4ruw1kXw13Arb_yoWDWw18pF
        W8A34qqr45GFy7WrWktFWDZa4ay3yY9FsFqFWruas7A3WDJ3sYkFn5uFnrAF43C3yrWFWY
        vF4rKa18GF45Ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
        JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        XdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

LIOINTC stands for "Legacy I/O Interrupts" that described in Section
11.1 of "Loongson 3A5000 Processor Reference Manual". For more
information please refer Documentation/loongarch/irq-chip-model.rst.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/irq.h       |   4 +-
 arch/loongarch/kernel/irq.c            |   1 -
 drivers/irqchip/irq-loongson-liointc.c | 207 +++++++++++++++++++++------------
 3 files changed, 134 insertions(+), 78 deletions(-)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 3e61824..de8af43 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -97,7 +97,7 @@ static inline void eiointc_enable(void)
 
 struct irq_domain *loongarch_cpu_irq_init(void);
 
-struct irq_domain *liointc_acpi_init(struct irq_domain *parent,
+int liointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lio_pic *acpi_liointc);
 struct irq_domain *eiointc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_eio_pic *acpi_eiointc);
@@ -130,7 +130,7 @@ int pch_pic_acpi_init(struct irq_domain *parent,
 extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
 
 extern struct irq_domain *cpu_domain;
-extern struct irq_domain *liointc_domain;
+extern struct fwnode_handle *liointc_handle;
 extern struct fwnode_handle *pch_lpc_handle;
 extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
 
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index ce21281..b04201c 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -26,7 +26,6 @@
 EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 struct irq_domain *cpu_domain;
-struct irq_domain *liointc_domain;
 
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 8d05d8b..fe4ee36 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -23,7 +23,7 @@
 #endif
 
 #define LIOINTC_CHIP_IRQ	32
-#define LIOINTC_NUM_PARENT 4
+#define LIOINTC_NUM_PARENT	4
 #define LIOINTC_NUM_CORES	4
 
 #define LIOINTC_INTC_CHIP_START	0x20
@@ -41,6 +41,7 @@
 
 #if defined(CONFIG_MIPS)
 #define liointc_core_id get_ebase_cpunum()
+#define GSI_MIN_CPU_IRQ		0
 #else
 #define liointc_core_id get_csr_cpuid()
 #endif
@@ -58,6 +59,8 @@ struct liointc_priv {
 	bool				has_lpc_irq_errata;
 };
 
+struct fwnode_handle *liointc_handle;
+
 static void liointc_chained_handle_irq(struct irq_desc *desc)
 {
 	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
@@ -153,97 +156,79 @@ static void liointc_resume(struct irq_chip_generic *gc)
 	irq_gc_unlock_irqrestore(gc, flags);
 }
 
-static const char * const parent_names[] = {"int0", "int1", "int2", "int3"};
-static const char * const core_reg_names[] = {"isr0", "isr1", "isr2", "isr3"};
+static int parent_irq[LIOINTC_NUM_PARENT];
+static u32 parent_int_map[LIOINTC_NUM_PARENT];
+static const char *const parent_names[] = {"int0", "int1", "int2", "int3"};
+static const char *const core_reg_names[] = {"isr0", "isr1", "isr2", "isr3"};
 
-static void __iomem *liointc_get_reg_byname(struct device_node *node,
-						const char *name)
+static int liointc_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
+			     const u32 *intspec, unsigned int intsize,
+			     unsigned long *out_hwirq, unsigned int *out_type)
 {
-	int index = of_property_match_string(node, "reg-names", name);
-
-	if (index < 0)
-		return NULL;
-
-	return of_iomap(node, index);
+	if (WARN_ON(intsize < 1))
+		return -EINVAL;
+	*out_hwirq = intspec[0] - GSI_MIN_CPU_IRQ;
+	*out_type = IRQ_TYPE_NONE;
+	return 0;
 }
 
-static int __init liointc_of_init(struct device_node *node,
-				  struct device_node *parent)
+static const struct irq_domain_ops acpi_irq_gc_ops = {
+	.map	= irq_map_generic_chip,
+	.unmap  = irq_unmap_generic_chip,
+	.xlate	= liointc_domain_xlate,
+};
+
+static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
+		struct fwnode_handle *domain_handle, struct device_node *node)
 {
+	int i, err;
+	void __iomem *base;
+	struct irq_chip_type *ct;
 	struct irq_chip_generic *gc;
 	struct irq_domain *domain;
-	struct irq_chip_type *ct;
 	struct liointc_priv *priv;
-	void __iomem *base;
-	u32 of_parent_int_map[LIOINTC_NUM_PARENT];
-	int parent_irq[LIOINTC_NUM_PARENT];
-	bool have_parent = FALSE;
-	int sz, i, err = 0;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	if (of_device_is_compatible(node, "loongson,liointc-2.0")) {
-		base = liointc_get_reg_byname(node, "main");
-		if (!base) {
-			err = -ENODEV;
-			goto out_free_priv;
-		}
+	base = ioremap(addr, size);
+	if (!base)
+		goto out_free_priv;
 
-		for (i = 0; i < LIOINTC_NUM_CORES; i++)
-			priv->core_isr[i] = liointc_get_reg_byname(node, core_reg_names[i]);
-		if (!priv->core_isr[0]) {
-			err = -ENODEV;
-			goto out_iounmap_base;
-		}
-	} else {
-		base = of_iomap(node, 0);
-		if (!base) {
-			err = -ENODEV;
-			goto out_free_priv;
-		}
+	for (i = 0; i < LIOINTC_NUM_CORES; i++)
+		priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
 
-		for (i = 0; i < LIOINTC_NUM_CORES; i++)
-			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
-	}
+	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
+		priv->handler[i].parent_int_map = parent_int_map[i];
 
-	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
-		parent_irq[i] = of_irq_get_byname(node, parent_names[i]);
-		if (parent_irq[i] > 0)
-			have_parent = TRUE;
-	}
-	if (!have_parent) {
-		err = -ENODEV;
-		goto out_iounmap_isr;
-	}
+	if (revision > 1) {
+		for (i = 0; i < LIOINTC_NUM_CORES; i++) {
+			int index = of_property_match_string(node,
+					"reg-names", core_reg_names[i]);
 
-	sz = of_property_read_variable_u32_array(node,
-						"loongson,parent_int_map",
-						&of_parent_int_map[0],
-						LIOINTC_NUM_PARENT,
-						LIOINTC_NUM_PARENT);
-	if (sz < 4) {
-		pr_err("loongson-liointc: No parent_int_map\n");
-		err = -ENODEV;
-		goto out_iounmap_isr;
-	}
+			if (index < 0)
+				return -EINVAL;
 
-	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
-		priv->handler[i].parent_int_map = of_parent_int_map[i];
+			priv->core_isr[i] = of_iomap(node, index);
+		}
+	}
 
 	/* Setup IRQ domain */
-	domain = irq_domain_add_linear(node, 32,
+	if (!acpi_disabled)
+		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
+					&acpi_irq_gc_ops, priv);
+	else
+		domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
 					&irq_generic_chip_ops, priv);
 	if (!domain) {
 		pr_err("loongson-liointc: cannot add IRQ domain\n");
-		err = -EINVAL;
-		goto out_iounmap_isr;
+		goto out_iounmap;
 	}
 
-	err = irq_alloc_domain_generic_chips(domain, 32, 1,
-					node->full_name, handle_level_irq,
-					IRQ_NOPROBE, 0, 0);
+	err = irq_alloc_domain_generic_chips(domain, LIOINTC_CHIP_IRQ, 1,
+					(node ? node->full_name : "LIOINTC"),
+					handle_level_irq, 0, IRQ_NOPROBE, 0);
 	if (err) {
 		pr_err("loongson-liointc: unable to register IRQ domain\n");
 		goto out_free_domain;
@@ -299,24 +284,96 @@ static int __init liointc_of_init(struct device_node *node,
 				liointc_chained_handle_irq, &priv->handler[i]);
 	}
 
+	liointc_handle = domain_handle;
 	return 0;
 
 out_free_domain:
 	irq_domain_remove(domain);
-out_iounmap_isr:
-	for (i = 0; i < LIOINTC_NUM_CORES; i++) {
-		if (!priv->core_isr[i])
-			continue;
-		iounmap(priv->core_isr[i]);
-	}
-out_iounmap_base:
+out_iounmap:
 	iounmap(base);
 out_free_priv:
 	kfree(priv);
 
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int __init liointc_of_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	bool have_parent = FALSE;
+	int sz, i, index, revision, err = 0;
+	struct resource res;
+
+	if (!of_device_is_compatible(node, "loongson,liointc-2.0")) {
+		index = 0;
+		revision = 1;
+	} else {
+		index = of_property_match_string(node, "reg-names", "main");
+		revision = 2;
+	}
+
+	if (of_address_to_resource(node, index, &res))
+		return -EINVAL;
+
+	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
+		parent_irq[i] = of_irq_get_byname(node, parent_names[i]);
+		if (parent_irq[i] > 0)
+			have_parent = TRUE;
+	}
+	if (!have_parent)
+		return -ENODEV;
+
+	sz = of_property_read_variable_u32_array(node,
+						"loongson,parent_int_map",
+						&parent_int_map[0],
+						LIOINTC_NUM_PARENT,
+						LIOINTC_NUM_PARENT);
+	if (sz < 4) {
+		pr_err("loongson-liointc: No parent_int_map\n");
+		return -ENODEV;
+	}
+
+	err = liointc_init(res.start, resource_size(&res),
+			revision, of_node_to_fwnode(node), node);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 IRQCHIP_DECLARE(loongson_liointc_1_0, "loongson,liointc-1.0", liointc_of_init);
 IRQCHIP_DECLARE(loongson_liointc_1_0a, "loongson,liointc-1.0a", liointc_of_init);
 IRQCHIP_DECLARE(loongson_liointc_2_0, "loongson,liointc-2.0", liointc_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+int __init liointc_acpi_init(struct irq_domain *parent, struct acpi_madt_lio_pic *acpi_liointc)
+{
+	int ret;
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_liointc)
+		return -EINVAL;
+
+	parent_int_map[0] = acpi_liointc->cascade_map[0];
+	parent_int_map[1] = acpi_liointc->cascade_map[1];
+
+	parent_irq[0] = irq_create_mapping(parent, acpi_liointc->cascade[0]);
+	parent_irq[1] = irq_create_mapping(parent, acpi_liointc->cascade[1]);
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_liointc);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return -ENOMEM;
+	}
+	ret = liointc_init(acpi_liointc->address, acpi_liointc->size,
+			   1, domain_handle, NULL);
+	if (ret)
+		irq_domain_free_fwnode(domain_handle);
+
+	return ret;
+}
+#endif
-- 
1.8.3.1

