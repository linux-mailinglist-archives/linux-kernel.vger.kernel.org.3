Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AA74CEB00
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiCFLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiCFLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:24:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5E74505E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:23:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35422B80CB9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CA6C340EC;
        Sun,  6 Mar 2022 11:23:20 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V10 07/10] irqchip/loongson-liointc: Add ACPI init support
Date:   Sun,  6 Mar 2022 19:21:52 +0800
Message-Id: <20220306112155.811157-8-chenhuacai@loongson.cn>
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
with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
as its boot protocol, so add ACPI init support.

LIOINTC stands for "Legacy I/O Interrupts" that described in Section
11.1 of "Loongson 3A5000 Processor Reference Manual". For more
information please refer Documentation/loongarch/irq-chip-model.rst.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 204 +++++++++++++++----------
 1 file changed, 125 insertions(+), 79 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 649c58391618..ff3cb5b05710 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -16,10 +16,14 @@
 #include <linux/smp.h>
 #include <linux/irqchip/chained_irq.h>
 
+#ifdef CONFIG_MIPS
 #include <loongson.h>
+#else
+#include <asm/loongson.h>
+#endif
 
 #define LIOINTC_CHIP_IRQ	32
-#define LIOINTC_NUM_PARENT 4
+#define LIOINTC_NUM_PARENT	4
 #define LIOINTC_NUM_CORES	4
 
 #define LIOINTC_INTC_CHIP_START	0x20
@@ -41,6 +45,7 @@ struct liointc_handler_data {
 };
 
 struct liointc_priv {
+	struct fwnode_handle		*domain_handle;
 	struct irq_chip_generic		*gc;
 	struct liointc_handler_data	handler[LIOINTC_NUM_PARENT];
 	void __iomem			*core_isr[LIOINTC_NUM_CORES];
@@ -53,7 +58,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = handler->priv->gc;
-	int core = get_ebase_cpunum() % LIOINTC_NUM_CORES;
+	int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
 	u32 pending;
 
 	chained_irq_enter(chip, desc);
@@ -143,97 +148,62 @@ static void liointc_resume(struct irq_chip_generic *gc)
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
-{
-	int index = of_property_match_string(node, "reg-names", name);
-
-	if (index < 0)
-		return NULL;
-
-	return of_iomap(node, index);
-}
-
-static int __init liointc_of_init(struct device_node *node,
-				  struct device_node *parent)
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
+	domain = irq_domain_create_linear(domain_handle, LIOINTC_CHIP_IRQ,
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
@@ -293,20 +263,96 @@ static int __init liointc_of_init(struct device_node *node,
 
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
+
+struct irq_domain *liointc_acpi_init(struct irq_domain *parent,
+				     struct acpi_madt_lio_pic *acpi_liointc)
+{
+	int ret;
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_liointc)
+		return NULL;
+
+	parent_int_map[0] = acpi_liointc->cascade_map[0];
+	parent_int_map[1] = acpi_liointc->cascade_map[1];
+
+	parent_irq[0] = irq_create_mapping(parent, acpi_liointc->cascade[0]);
+	if (!cpu_has_extioi)
+		parent_irq[1] = irq_create_mapping(parent, acpi_liointc->cascade[1]);
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_liointc);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return NULL;
+	}
+
+	ret = liointc_init(acpi_liointc->address, acpi_liointc->size,
+			   1, domain_handle, NULL);
+	if (ret < 0)
+		return NULL;
+
+	return irq_find_matching_fwnode(domain_handle, DOMAIN_BUS_ANY);
+}
+
+#endif
-- 
2.27.0

