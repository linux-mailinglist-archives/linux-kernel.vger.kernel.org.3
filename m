Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1DC57B562
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbiGTL1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbiGTL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:27:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316504506F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:27:35 -0700 (PDT)
Date:   Wed, 20 Jul 2022 11:27:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658316453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sp/9YTXwULDxDWs3J7ffxI2E8SZJ71BAI5e8Uluzm4=;
        b=ZSNnDvgTQfk6eEXzY4XtHbMtgHgf1a/7qxZ00LjzL/q06OAlsaSFKdnVpKxB27/Ai8ah4g
        ym1mRXSo5Pp+ExORZH5a/ZSNGiyh/7lv/cVXRWi2DgC9yjDFFTFpIxm8H+uDOBSMDha1X1
        4vTf/nJru6a/VJHMloX+V/K4Y70IFetNi99mf/yAtIXQ/aCBW9ppMoOApS+K4oOJWaWCz5
        Dr7lQyAkyvuFwHu6AoP78tLzl9BnuiJ6fftN9deKgz0mEpOxpBMiR/buOOrD7Jz1XKRmXN
        +1kecwBBbhAf319ptC1PLtxeWeFcoUtpfSBGiexOzBRo3UdJDWC/OskdQloK5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658316453;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sp/9YTXwULDxDWs3J7ffxI2E8SZJ71BAI5e8Uluzm4=;
        b=TwI5iQGWGZnazTnQwt0+MufG0wouJmBsz7dWqZejdF+6vrcrrdjN+Q2YZCRHr498TX3GJP
        FMVzb8JFXHW9nkCA==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-pch-msi: Add ACPI init support
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <1658314292-35346-10-git-send-email-lvjianmin@loongson.cn>
References: <1658314292-35346-10-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Message-ID: <165831645269.15455.17131443650121862103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     023087324000ae704cf3cfd0abf1fc30c6e0e8d5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/023087324000ae704cf3cfd0abf1fc30c6e0e8d5
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Wed, 20 Jul 2022 18:51:28 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 20 Jul 2022 12:09:21 +01:00

irqchip/loongson-pch-msi: Add ACPI init support

PCH-PIC/PCH-MSI stands for "Interrupt Controller" that described in
Section 5 of "Loongson 7A1000 Bridge User Manual". For more information
please refer Documentation/loongarch/irq-chip-model.rst.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1658314292-35346-10-git-send-email-lvjianmin@loongson.cn
---
 arch/loongarch/include/asm/irq.h       |  12 +-
 arch/loongarch/kernel/irq.c            |   1 +-
 drivers/irqchip/Kconfig                |   2 +-
 drivers/irqchip/irq-loongson-pch-msi.c | 127 ++++++++++++++++--------
 4 files changed, 96 insertions(+), 46 deletions(-)

diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 9549806..e9039f2 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -114,11 +114,20 @@ struct irq_domain *htvec_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_ht_pic *acpi_htvec);
 int pch_lpc_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_lpc_pic *acpi_pchlpc);
-struct irq_domain *pch_msi_acpi_init(struct irq_domain *parent,
+#if IS_ENABLED(CONFIG_LOONGSON_PCH_MSI)
+int pch_msi_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_msi_pic *acpi_pchmsi);
+#else
+static inline int pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi)
+{
+	return 0;
+}
+#endif
 int pch_pic_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_bio_pic *acpi_pchpic);
 int find_pch_pic(u32 gsi);
+struct fwnode_handle *get_pch_msi_handle(int pci_segment);
 
 extern struct acpi_madt_lio_pic *acpi_liointc;
 extern struct acpi_madt_eio_pic *acpi_eiointc[MAX_IO_PICS];
@@ -131,7 +140,6 @@ extern struct acpi_madt_bio_pic *acpi_pchpic[MAX_IO_PICS];
 extern struct irq_domain *cpu_domain;
 extern struct irq_domain *liointc_domain;
 extern struct fwnode_handle *pch_lpc_handle;
-extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
 extern struct fwnode_handle *pch_pic_handle[MAX_IO_PICS];
 
 extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index 575b8de..066f892 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -27,7 +27,6 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
 
 struct irq_domain *cpu_domain;
 struct irq_domain *liointc_domain;
-struct irq_domain *pch_msi_domain[MAX_IO_PICS];
 
 struct acpi_vector_group pch_group[MAX_IO_PICS];
 struct acpi_vector_group msi_group[MAX_IO_PICS];
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f62bdec..8844e6b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -583,7 +583,7 @@ config LOONGSON_PCH_PIC
 
 config LOONGSON_PCH_MSI
 	bool "Loongson PCH MSI Controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on MACH_LOONGSON64
 	depends on PCI
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index e3801c4..d0e8551 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -15,6 +15,8 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+static int nr_pics;
+
 struct pch_msi_data {
 	struct mutex	msi_map_lock;
 	phys_addr_t	doorbell;
@@ -23,6 +25,8 @@ struct pch_msi_data {
 	unsigned long	*msi_map;
 };
 
+static struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
+
 static void pch_msi_mask_msi_irq(struct irq_data *d)
 {
 	pci_msi_mask_irq(d);
@@ -154,12 +158,12 @@ static const struct irq_domain_ops pch_msi_middle_domain_ops = {
 };
 
 static int pch_msi_init_domains(struct pch_msi_data *priv,
-				struct device_node *node,
-				struct irq_domain *parent)
+				struct irq_domain *parent,
+				struct fwnode_handle *domain_handle)
 {
 	struct irq_domain *middle_domain, *msi_domain;
 
-	middle_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	middle_domain = irq_domain_create_linear(domain_handle,
 						priv->num_irqs,
 						&pch_msi_middle_domain_ops,
 						priv);
@@ -171,7 +175,7 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 	middle_domain->parent = parent;
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
-	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain = pci_msi_create_irq_domain(domain_handle,
 					       &pch_msi_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
@@ -183,19 +187,11 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
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
@@ -203,48 +199,95 @@ static int pch_msi_init(struct device_node *node,
 
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
 
+	pch_msi_handle[nr_pics++] = domain_handle;
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
 }
 
-IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_init);
+IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
+#endif
+
+#ifdef CONFIG_ACPI
+struct fwnode_handle *get_pch_msi_handle(int pci_segment)
+{
+	int i;
+
+	for (i = 0; i < MAX_IO_PICS; i++) {
+		if (msi_group[i].pci_segment == pci_segment)
+			return pch_msi_handle[i];
+	}
+	return NULL;
+}
+
+int __init pch_msi_acpi_init(struct irq_domain *parent,
+					struct acpi_madt_msi_pic *acpi_pchmsi)
+{
+	int ret;
+	struct fwnode_handle *domain_handle;
+
+	domain_handle = irq_domain_alloc_fwnode((phys_addr_t *)acpi_pchmsi);
+	ret = pch_msi_init(acpi_pchmsi->msg_address, acpi_pchmsi->start,
+				acpi_pchmsi->count, parent, domain_handle);
+	if (ret < 0)
+		irq_domain_free_fwnode(domain_handle);
+
+	return ret;
+}
+#endif
