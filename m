Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BCC4CEAFD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiCFLW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiCFLWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:22:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB956C964
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6862860B0C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08829C340EC;
        Sun,  6 Mar 2022 11:21:53 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V10 04/10] irqchip/loongson-pch-msi: Add ACPI init support
Date:   Sun,  6 Mar 2022 19:21:49 +0800
Message-Id: <20220306112155.811157-5-chenhuacai@loongson.cn>
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

PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
please refer Documentation/loongarch/irq-chip-model.rst.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-msi.c | 128 +++++++++++++++++--------
 1 file changed, 86 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index e3801c4a77ed..6720212bece1 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -15,14 +15,19 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+static int nr_pics;
+
 struct pch_msi_data {
 	struct mutex	msi_map_lock;
 	phys_addr_t	doorbell;
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
@@ -154,12 +159,14 @@ static const struct irq_domain_ops pch_msi_middle_domain_ops = {
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
@@ -171,7 +178,7 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 	middle_domain->parent = parent;
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
-	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain = pci_msi_create_irq_domain(priv->domain_handle,
 					       &pch_msi_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
@@ -183,19 +190,11 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
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
@@ -203,48 +202,93 @@ static int pch_msi_init(struct device_node *node,
 
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
 
+	pch_msi_priv[nr_pics++] = priv;
+
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
+
+struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi)
+{
+	int ret;
+	struct fwnode_handle *domain_handle;
+
+	if (!acpi_pchmsi)
+		return NULL;
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
+
+	ret = pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
+				acpi_pchmsi->count, parent, domain_handle);
+	if (ret < 0)
+		return NULL;
+
+	return irq_find_matching_fwnode(domain_handle, DOMAIN_BUS_PCI_MSI);
 }
 
-IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
+#endif
-- 
2.27.0

