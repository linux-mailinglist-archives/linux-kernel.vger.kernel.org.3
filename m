Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431B5547419
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiFKLEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiFKLEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 07:04:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86933AB0E7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 04:04:40 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx707CdqRiKxA5AA--.24235S3;
        Sat, 11 Jun 2022 19:04:34 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH RFC V3 07/11] irqchip/loongson-pch-msi: Add ACPI init support
Date:   Sat, 11 Jun 2022 19:04:30 +0800
Message-Id: <1654945474-30858-2-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1654945474-30858-1-git-send-email-lvjianmin@loongson.cn>
References: <1654945474-30858-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dx707CdqRiKxA5AA--.24235S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw15WrykWFyDuF4DuFWruFg_yoWxWF4xpF
        W7Z3y7Xr48J3yUurZ5CF4DXryayFyUKFW2qa1fG3Z3trsFyr9YgF18CF129r43ArW8GFn0
        vw48Ka1UuF4DJFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
        yTuYvjfUOtC7UUUUU
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
with old MIPS-based Loongson) support. LoongArch use ACPI other than DT
as its boot protocol, so add ACPI init support.

PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
please refer Documentation/loongarch/irq-chip-model.rst.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
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

