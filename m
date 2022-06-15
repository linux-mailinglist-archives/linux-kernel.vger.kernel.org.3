Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2F954C1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351095AbiFOGKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350769AbiFOGKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:10:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C1BA201AA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:10:04 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxP0ywd6livyZDAA--.5882S2;
        Wed, 15 Jun 2022 14:09:52 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V12 08/10] irqchip/loongson-liointc: Add ACPI init support
Date:   Wed, 15 Jun 2022 14:09:48 +0800
Message-Id: <1655273390-27904-1-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9DxP0ywd6livyZDAA--.5882S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw1UKr45trW5WF1kWryfWFg_yoWfZFWrpF
        W8JrZ0qr45JFy7Wr4vyaykZa4avw45uFZrXFWfuas7A3ZrJ3s5AF4ruFnrAF43CryrWFWY
        vF4rJa18GFW5Ca7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkKb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267
        AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
        AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k2
        0xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_
        Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1RwZ7
        UUUUU==
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

We are preparing to add new Loongson (based on LoongArch, not compatible
with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
as its boot protocol, so add ACPI init support.

LIOINTC stands for "Legacy I/O Interrupts" that described in Section
11.1 of "Loongson 3A5000 Processor Reference Manual". For more
information please refer Documentation/loongarch/irq-chip-model.rst.

Change-Id: Ia54268726f5be801dae568c55bbf63d019ba7207
Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 225 ++++++++++++++++++++++-----------
 1 file changed, 150 insertions(+), 75 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index aed8885..7f004d0 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -23,7 +23,7 @@
 #endif
 
 #define LIOINTC_CHIP_IRQ	32
-#define LIOINTC_NUM_PARENT 4
+#define LIOINTC_NUM_PARENT	4
 #define LIOINTC_NUM_CORES	4
 
 #define LIOINTC_INTC_CHIP_START	0x20
@@ -45,6 +45,7 @@ struct liointc_handler_data {
 };
 
 struct liointc_priv {
+	struct fwnode_handle		*domain_handle;
 	struct irq_chip_generic		*gc;
 	struct liointc_handler_data	handler[LIOINTC_NUM_PARENT];
 	void __iomem			*core_isr[LIOINTC_NUM_CORES];
@@ -147,97 +148,83 @@ static void liointc_resume(struct irq_chip_generic *gc)
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
+const struct irq_domain_ops acpi_irq_gc_ops = {
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
+	priv->domain_handle = domain_handle;
 
-		for (i = 0; i < LIOINTC_NUM_CORES; i++)
-			priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
-	}
+	for (i = 0; i < LIOINTC_NUM_CORES; i++)
+		priv->core_isr[i] = base + LIOINTC_REG_INTC_STATUS;
 
-	for (i = 0; i < LIOINTC_NUM_PARENT; i++) {
-		parent_irq[i] = of_irq_get_byname(node, parent_names[i]);
-		if (parent_irq[i] > 0)
-			have_parent = TRUE;
-	}
-	if (!have_parent) {
-		err = -ENODEV;
-		goto out_iounmap_isr;
-	}
+	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
+		priv->handler[i].parent_int_map = parent_int_map[i];
 
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
+#ifdef CONFIG_OF
+	if (revision > 1) {
+		for (i = 0; i < LIOINTC_NUM_CORES; i++) {
+			int index = of_property_match_string(node,
+					"reg-names", core_reg_names[i]);
 
-	for (i = 0; i < LIOINTC_NUM_PARENT; i++)
-		priv->handler[i].parent_int_map = of_parent_int_map[i];
+			if (index < 0)
+				return -EINVAL;
+
+			priv->core_isr[i] = of_iomap(node, index);
+		}
+	}
+#endif
 
 	/* Setup IRQ domain */
-	domain = irq_domain_add_linear(node, 32,
+	if (!node)
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
@@ -293,24 +280,112 @@ static int __init liointc_of_init(struct device_node *node,
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
+static int __init
+htintc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_ht_pic *htintc_entry = (struct acpi_madt_ht_pic *)header;
+	struct irq_domain *parent = irq_find_matching_fwnode(liointc_handle, DOMAIN_BUS_ANY);
+
+	return htvec_acpi_init(parent, htintc_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_HT_PIC,
+			      htintc_parse_madt, 0);
+	return 0;
+}
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
+	if (ret == 0)
+		acpi_cascade_irqdomain_init();
+
+	return ret;
+}
+#endif
-- 
1.8.3.1

