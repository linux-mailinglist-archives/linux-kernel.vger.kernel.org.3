Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B980154C1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353058AbiFOGI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346259AbiFOGHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:07:55 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C41D925EB2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:07:53 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx398id6li2SVDAA--.6137S7;
        Wed, 15 Jun 2022 14:07:44 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V12 05/10] irqchip/loongson-pch-pic: Add ACPI init support
Date:   Wed, 15 Jun 2022 14:07:25 +0800
Message-Id: <1655273250-23495-6-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655273250-23495-1-git-send-email-lvjianmin@loongson.cn>
References: <1655273250-23495-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx398id6li2SVDAA--.6137S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw1UZFy7Jw48Jw1kuF48JFb_yoW3ZF13pF
        W5J39xZr4UJF1UWr1kCws8Xryay34S9ayIgaySkFn3trsrXrykKF10vF1jkr1rArW8AF43
        Zrs3K3Wj9a1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkGb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267
        AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
        AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k2
        0xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8GYLUUU
        UU=
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

PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
please refer Documentation/loongarch/irq-chip-model.rst.

Change-Id: I40e9b9e5298d7b3f6ae2ab2ba69f5bcfa50c1418
Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 171 +++++++++++++++++++++++++++------
 1 file changed, 141 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index a4eb8a2..1426b93 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -15,6 +15,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include "irq-loongarch-pic-common.h"
 
 /* Registers */
 #define PCH_PIC_MASK		0x20
@@ -33,13 +34,20 @@
 #define PIC_REG_IDX(irq_id)	((irq_id) / PIC_COUNT_PER_REG)
 #define PIC_REG_BIT(irq_id)	((irq_id) % PIC_COUNT_PER_REG)
 
+static int nr_pics;
+
 struct pch_pic {
 	void __iomem		*base;
 	struct irq_domain	*pic_domain;
+	struct fwnode_handle	*domain_handle;
 	u32			ht_vec_base;
 	raw_spinlock_t		pic_lock;
+	u32			gsi_end;
+	u32			gsi_base;
 };
 
+static struct pch_pic *pch_pic_priv[2];
+
 static void pch_pic_bitset(struct pch_pic *priv, int offset, int bit)
 {
 	u32 reg;
@@ -139,6 +147,24 @@ static void pch_pic_ack_irq(struct irq_data *d)
 	.irq_set_type		= pch_pic_set_type,
 };
 
+static int pch_pic_domain_translate(struct irq_domain *d,
+					struct irq_fwspec *fwspec,
+					unsigned long *hwirq,
+					unsigned int *type)
+{
+	struct pch_pic *priv = d->host_data;
+	struct device_node *of_node = to_of_node(fwspec->fwnode);
+
+	if (fwspec->param_count < 1)
+		return -EINVAL;
+	if (of_node)
+		*hwirq += priv->ht_vec_base;
+	else
+		*hwirq = fwspec->param[0] - priv->gsi_base;
+	*type = IRQ_TYPE_NONE;
+
+	return 0;
+}
 static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nr_irqs, void *arg)
 {
@@ -149,13 +175,13 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 	struct irq_fwspec parent_fwspec;
 	struct pch_pic *priv = domain->host_data;
 
-	err = irq_domain_translate_twocell(domain, fwspec, &hwirq, &type);
+	err = pch_pic_domain_translate(domain, fwspec, &hwirq, &type);
 	if (err)
 		return err;
 
 	parent_fwspec.fwnode = domain->parent->fwnode;
 	parent_fwspec.param_count = 1;
-	parent_fwspec.param[0] = hwirq + priv->ht_vec_base;
+	parent_fwspec.param[0] = hwirq;
 
 	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
 	if (err)
@@ -170,7 +196,7 @@ static int pch_pic_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops pch_pic_domain_ops = {
-	.translate	= irq_domain_translate_twocell,
+	.translate	= pch_pic_domain_translate,
 	.alloc		= pch_pic_alloc,
 	.free		= irq_domain_free_irqs_parent,
 };
@@ -180,7 +206,7 @@ static void pch_pic_reset(struct pch_pic *priv)
 	int i;
 
 	for (i = 0; i < PIC_COUNT; i++) {
-		/* Write vectored ID */
+		/* Write vector ID */
 		writeb(priv->ht_vec_base + i, priv->base + PCH_INT_HTVEC(i));
 		/* Hardcode route to HT0 Lo */
 		writeb(1, priv->base + PCH_INT_ROUTE(i));
@@ -198,50 +224,41 @@ static void pch_pic_reset(struct pch_pic *priv)
 	}
 }
 
-static int pch_pic_of_init(struct device_node *node,
-				struct device_node *parent)
+static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
+			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle,
+			u32 gsi_base)
 {
+	int vec_count;
 	struct pch_pic *priv;
-	struct irq_domain *parent_domain;
-	int err;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	raw_spin_lock_init(&priv->pic_lock);
-	priv->base = of_iomap(node, 0);
-	if (!priv->base) {
-		err = -ENOMEM;
+	priv->base = ioremap(addr, size);
+	if (!priv->base)
 		goto free_priv;
-	}
 
-	parent_domain = irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("Failed to find the parent domain\n");
-		err = -ENXIO;
-		goto iounmap_base;
-	}
+	priv->domain_handle = domain_handle;
 
-	if (of_property_read_u32(node, "loongson,pic-base-vec",
-				&priv->ht_vec_base)) {
-		pr_err("Failed to determine pic-base-vec\n");
-		err = -EINVAL;
-		goto iounmap_base;
-	}
+	priv->ht_vec_base = vec_base;
+	vec_count = ((readq(priv->base) >> 48) & 0xff) + 1;
+	priv->gsi_base = gsi_base;
+	priv->gsi_end = gsi_base + vec_count - 1;
 
 	priv->pic_domain = irq_domain_create_hierarchy(parent_domain, 0,
-						       PIC_COUNT,
-						       of_node_to_fwnode(node),
-						       &pch_pic_domain_ops,
-						       priv);
+						vec_count, priv->domain_handle,
+						&pch_pic_domain_ops, priv);
+
 	if (!priv->pic_domain) {
 		pr_err("Failed to create IRQ domain\n");
-		err = -ENOMEM;
 		goto iounmap_base;
 	}
 
 	pch_pic_reset(priv);
+	pch_pic_handle[nr_pics] = domain_handle;
+	pch_pic_priv[nr_pics++] = priv;
 
 	return 0;
 
@@ -250,7 +267,101 @@ static int pch_pic_of_init(struct device_node *node,
 free_priv:
 	kfree(priv);
 
-	return err;
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int pch_pic_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int err, vec_base;
+	struct resource res;
+	struct irq_domain *parent_domain;
+
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		return -ENXIO;
+	}
+
+	if (of_property_read_u32(node, "loongson,pic-base-vec", &vec_base)) {
+		pr_err("Failed to determine pic-base-vec\n");
+		return -EINVAL;
+	}
+
+	err = pch_pic_init(res.start, resource_size(&res), vec_base,
+				parent_domain, of_node_to_fwnode(node), 0);
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+static int __init
+lpcintc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_lpc_pic *lpcintc_entry = (struct acpi_madt_lpc_pic *)header;
+
+	return pch_lpc_acpi_init(pch_pic_priv[0]->pic_domain, lpcintc_entry);
+}
+
+static int __init acpi_cascade_irqdomain_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_LPC_PIC,
+			      lpcintc_parse_madt, 0);
+	return 0;
+}
+int __init pch_pic_init_irqdomain(struct irq_domain *parent,
+					struct acpi_madt_bio_pic *acpi_pchpic)
+{
+	int ret, vec_base;
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_pchpic)
+		return -EINVAL;
+
+	vec_base = acpi_pchpic->gsi_base - GSI_MIN_PCH_IRQ;
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchpic);
+	if (!domain_handle) {
+		pr_err("Unable to allocate domain handle\n");
+		return -ENOMEM;
+	}
+
+	ret = pch_pic_init(acpi_pchpic->address, acpi_pchpic->size,
+				vec_base, parent, domain_handle, acpi_pchpic->gsi_base);
+	if (ret == 0 && acpi_pchpic->id == 0)
+		acpi_cascade_irqdomain_init();
+
+	return ret;
+}
+
+static int __init pchintc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_bio_pic *pch_pic_entry = (struct acpi_madt_bio_pic *)header;
+
+	acpi_pchpic[nr_pics] = pch_pic_entry;
+	return pch_pic_init_irqdomain(acpi_get_pch_parent((pch_pic_entry->address >> 44) & 0xf),
+										pch_pic_entry);
+}
+
+static int __init pch_pic_acpi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_BIO_PIC,
+			      pchintc_parse_madt, 0);
+
+	return 0;
+}
+early_initcall(pch_pic_acpi_init);
+#endif
-- 
1.8.3.1

