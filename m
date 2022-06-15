Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CB54C1A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349878AbiFOGIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346254AbiFOGHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:07:54 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D959426553
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:07:52 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx398id6li2SVDAA--.6137S8;
        Wed, 15 Jun 2022 14:07:45 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V12 06/10] irqchip/loongson-pch-msi: Add ACPI init support
Date:   Wed, 15 Jun 2022 14:07:26 +0800
Message-Id: <1655273250-23495-7-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655273250-23495-1-git-send-email-lvjianmin@loongson.cn>
References: <1655273250-23495-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx398id6li2SVDAA--.6137S8
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw1UuF1UZFW8ur47JryfCrg_yoWxAw4rpF
        W7Z3y7Xr48J3yUurZ5CF4DXryayFyUKFWIqa1fG3Wftw4qyr9YgF18CF129F43ArW8GFn0
        va18Ka1UuF4DJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Change-Id: Ifaa229d36212d645ca423f1e2ff7c0cb5fd0cc01
Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-msi.c | 138 +++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index e3801c4..a2e94f3 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -14,6 +14,9 @@
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include "irq-loongarch-pic-common.h"
+
+static int nr_pics;
 
 struct pch_msi_data {
 	struct mutex	msi_map_lock;
@@ -21,8 +24,11 @@ struct pch_msi_data {
 	u32		irq_first;	/* The vector number that MSIs starts */
 	u32		num_irqs;	/* The number of vectors for MSIs */
 	unsigned long	*msi_map;
+	struct fwnode_handle *domain_handle;
 };
 
+static struct pch_msi_data *pch_msi_priv[2];
+
 static void pch_msi_mask_msi_irq(struct irq_data *d)
 {
 	pci_msi_mask_irq(d);
@@ -154,12 +160,14 @@ static void pch_msi_middle_domain_free(struct irq_domain *domain,
 };
 
 static int pch_msi_init_domains(struct pch_msi_data *priv,
-				struct device_node *node,
-				struct irq_domain *parent)
+				struct irq_domain *parent,
+				struct fwnode_handle *domain_handle)
 {
 	struct irq_domain *middle_domain, *msi_domain;
 
-	middle_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	priv->domain_handle = domain_handle;
+
+	middle_domain = irq_domain_create_linear(priv->domain_handle,
 						priv->num_irqs,
 						&pch_msi_middle_domain_ops,
 						priv);
@@ -171,7 +179,7 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 	middle_domain->parent = parent;
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
-	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain = pci_msi_create_irq_domain(priv->domain_handle,
 					       &pch_msi_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
@@ -183,19 +191,11 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 	return 0;
 }
 
-static int pch_msi_init(struct device_node *node,
-			    struct device_node *parent)
+static int pch_msi_init(phys_addr_t msg_address, int irq_base, int irq_count,
+			struct irq_domain *parent_domain, struct fwnode_handle *domain_handle)
 {
-	struct pch_msi_data *priv;
-	struct irq_domain *parent_domain;
-	struct resource res;
 	int ret;
-
-	parent_domain = irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("Failed to find the parent domain\n");
-		return -ENXIO;
-	}
+	struct pch_msi_data *priv;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -203,48 +203,102 @@ static int pch_msi_init(struct device_node *node,
 
 	mutex_init(&priv->msi_map_lock);
 
-	ret = of_address_to_resource(node, 0, &res);
-	if (ret) {
-		pr_err("Failed to allocate resource\n");
-		goto err_priv;
-	}
-
-	priv->doorbell = res.start;
-
-	if (of_property_read_u32(node, "loongson,msi-base-vec",
-				&priv->irq_first)) {
-		pr_err("Unable to parse MSI vec base\n");
-		ret = -EINVAL;
-		goto err_priv;
-	}
-
-	if (of_property_read_u32(node, "loongson,msi-num-vecs",
-				&priv->num_irqs)) {
-		pr_err("Unable to parse MSI vec number\n");
-		ret = -EINVAL;
-		goto err_priv;
-	}
+	priv->doorbell = msg_address;
+	priv->irq_first = irq_base;
+	priv->num_irqs = irq_count;
 
 	priv->msi_map = bitmap_zalloc(priv->num_irqs, GFP_KERNEL);
-	if (!priv->msi_map) {
-		ret = -ENOMEM;
+	if (!priv->msi_map)
 		goto err_priv;
-	}
 
 	pr_debug("Registering %d MSIs, starting at %d\n",
 		 priv->num_irqs, priv->irq_first);
 
-	ret = pch_msi_init_domains(priv, node, parent_domain);
+	ret = pch_msi_init_domains(priv, parent_domain, domain_handle);
 	if (ret)
 		goto err_map;
 
+	pch_msi_handle[nr_pics] = domain_handle;
+	pch_msi_priv[nr_pics++] = priv;
 	return 0;
 
 err_map:
 	bitmap_free(priv->msi_map);
 err_priv:
 	kfree(priv);
-	return ret;
+
+	return -EINVAL;
+}
+
+#ifdef CONFIG_OF
+
+static int pch_msi_of_init(struct device_node *node, struct device_node *parent)
+{
+	int err;
+	int irq_base, irq_count;
+	struct resource res;
+	struct irq_domain *parent_domain;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("Failed to find the parent domain\n");
+		return -ENXIO;
+	}
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("Failed to allocate resource\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "loongson,msi-base-vec", &irq_base)) {
+		pr_err("Unable to parse MSI vec base\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32(node, "loongson,msi-num-vecs", &irq_count)) {
+		pr_err("Unable to parse MSI vec number\n");
+		return -EINVAL;
+	}
+
+	err = pch_msi_init(res.start, irq_base, irq_count, parent_domain, of_node_to_fwnode(node));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
+
+#endif
+
+#ifdef CONFIG_ACPI
+int __init pch_msi_init_irqdomain(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi)
+{
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_pchmsi)
+		return -EINVAL;
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
+
+	return pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
+				acpi_pchmsi->count, parent, domain_handle);
+}
+static int __init msiintc_parse_madt(union acpi_subtable_headers *header,
+		       const unsigned long end)
+{
+	struct acpi_madt_msi_pic *pch_msi_entry = (struct acpi_madt_msi_pic *)header;
+
+	return pch_msi_init_irqdomain(acpi_get_msi_parent(nr_pics), pch_msi_entry);
 }
 
-IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
+static int __init pch_msi_acpi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC,
+			      msiintc_parse_madt, 0);
+
+	return 0;
+}
+early_initcall(pch_msi_acpi_init);
+#endif
-- 
1.8.3.1

