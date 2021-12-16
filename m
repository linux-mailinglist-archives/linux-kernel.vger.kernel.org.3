Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE33477F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbhLPVnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbhLPVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:12 -0500
Date:   Thu, 16 Dec 2021 21:41:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhjlckydGB45EX+I4shK2EFUZYn+KrHggfOKiZ8+l7Q=;
        b=c24jQTQX+sU2C+dNgx3Jy//+IzNZFTsldGZEk9hchkx4H8j2T5/1JmnH9M4fN9PONUa3L2
        SLSQQ5CVySkm8TqzQrVO+zv0rJScvG0sSAH+yEQH+klpmPCAuAPLRGP4+TX7tWGXdxFjBF
        QrSbtRMVZr0i8tUYsNFbdMiIRKWMPkeh4gy42aBfF08Ihskq6xv2t2WF5lHpA/0xlGyr03
        MM2r5NpMGqmEkejAdTKlhwOP/pd0gXhyNK/Be7Ltn3WMZeEjQNArztEmVAhlnM8onDghqG
        ahE+rwYHJt3/6bU5TWwH6PvwnyjAoJS12UbU6Wn4x4KhKX6IF2t0FqfHZX6oXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VhjlckydGB45EX+I4shK2EFUZYn+KrHggfOKiZ8+l7Q=;
        b=oeb6mVaeELWFdreZepDHacTH4qUz8nh8sOrHiGUgTVVfTYQ2jTPhJZZX+YIqXW+CNQkfcr
        iplxYqwdLFlbqzAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] device: Move MSI related data into a struct
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.617178827@linutronix.de>
References: <20211210221813.617178827@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969087037.23020.15636749326432406439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     34fff62827b254f8a43633cc878deb04bf11297c
Gitweb:        https://git.kernel.org/tip/34fff62827b254f8a43633cc878deb04bf11297c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:18:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:38 +01:00

device: Move MSI related data into a struct

The only unconditional part of MSI data in struct device is the irqdomain
pointer. Everything else can be allocated on demand. Create a data
structure and move the irqdomain pointer into it. The other MSI specific
parts are going to be removed from struct device in later steps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20211210221813.617178827@linutronix.de


---
 drivers/base/platform-msi.c                 | 12 ++++++------
 drivers/dma/ti/k3-udma.c                    |  4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
 drivers/irqchip/irq-mvebu-icu.c             |  6 +++---
 drivers/soc/ti/k3-ringacc.c                 |  4 ++--
 drivers/soc/ti/ti_sci_inta_msi.c            |  2 +-
 include/linux/device.h                      | 20 ++++++++++++++------
 7 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 3d6c8f9..f1f0876 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -210,10 +210,10 @@ platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 	 * accordingly (which would impact the max number of MSI
 	 * capable devices).
 	 */
-	if (!dev->msi_domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
+	if (!dev->msi.domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
 		return ERR_PTR(-EINVAL);
 
-	if (dev->msi_domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
+	if (dev->msi.domain->bus_token != DOMAIN_BUS_PLATFORM_MSI) {
 		dev_err(dev, "Incompatible msi_domain, giving up\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -269,7 +269,7 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	if (err)
 		goto out_free_priv_data;
 
-	err = msi_domain_alloc_irqs(dev->msi_domain, dev, nvec);
+	err = msi_domain_alloc_irqs(dev->msi.domain, dev, nvec);
 	if (err)
 		goto out_free_desc;
 
@@ -282,7 +282,7 @@ int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
 	return 0;
 
 out_free_irqs:
-	msi_domain_free_irqs(dev->msi_domain, dev);
+	msi_domain_free_irqs(dev->msi.domain, dev);
 out_free_desc:
 	platform_msi_free_descs(dev, 0, nvec);
 out_free_priv_data:
@@ -306,7 +306,7 @@ void platform_msi_domain_free_irqs(struct device *dev)
 		platform_msi_free_priv_data(desc->platform.msi_priv_data);
 	}
 
-	msi_domain_free_irqs(dev->msi_domain, dev);
+	msi_domain_free_irqs(dev->msi.domain, dev);
 	platform_msi_free_descs(dev, 0, MAX_DEV_MSIS);
 }
 EXPORT_SYMBOL_GPL(platform_msi_domain_free_irqs);
@@ -354,7 +354,7 @@ __platform_msi_create_device_domain(struct device *dev,
 		return NULL;
 
 	data->host_data = host_data;
-	domain = irq_domain_create_hierarchy(dev->msi_domain, 0,
+	domain = irq_domain_create_hierarchy(dev->msi.domain, 0,
 					     is_tree ? 0 : nvec,
 					     dev->fwnode, ops, data);
 	if (!domain)
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 041d8e3..20edd0b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5279,9 +5279,9 @@ static int udma_probe(struct platform_device *pdev)
 	if (IS_ERR(ud->ringacc))
 		return PTR_ERR(ud->ringacc);
 
-	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
+	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
-	if (!dev->msi_domain) {
+	if (!dev->msi.domain) {
 		dev_err(dev, "Failed to get MSI domain\n");
 		return -EPROBE_DEFER;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f5848b3..5ba9006 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3170,7 +3170,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
 		return;
 
-	if (!dev->msi_domain) {
+	if (!dev->msi.domain) {
 		dev_info(smmu->dev, "msi_domain absent - falling back to wired irqs\n");
 		return;
 	}
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 3e7297f..4a4a65a 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -314,12 +314,12 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
 		msi_data->subset_data = of_device_get_match_data(dev);
 	}
 
-	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
+	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_PLATFORM_MSI);
-	if (!dev->msi_domain)
+	if (!dev->msi.domain)
 		return -EPROBE_DEFER;
 
-	msi_parent_dn = irq_domain_get_of_node(dev->msi_domain);
+	msi_parent_dn = irq_domain_get_of_node(dev->msi.domain);
 	if (!msi_parent_dn)
 		return -ENODEV;
 
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 312ba0f..26159a5 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1356,9 +1356,9 @@ static int k3_ringacc_init(struct platform_device *pdev,
 	struct resource *res;
 	int ret, i;
 
-	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
+	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
-	if (!dev->msi_domain) {
+	if (!dev->msi.domain) {
 		dev_err(dev, "Failed to get MSI domain\n");
 		return -EPROBE_DEFER;
 	}
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index a1d9c02..428a482 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -140,7 +140,7 @@ EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
 
 void ti_sci_inta_msi_domain_free_irqs(struct device *dev)
 {
-	msi_domain_free_irqs(dev->msi_domain, dev);
+	msi_domain_free_irqs(dev->msi.domain, dev);
 	ti_sci_inta_msi_free_descs(dev);
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);
diff --git a/include/linux/device.h b/include/linux/device.h
index 2a22875..f212b7a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -372,6 +372,16 @@ struct dev_links_info {
 };
 
 /**
+ * struct dev_msi_info - Device data related to MSI
+ * @domain:	The MSI interrupt domain associated to the device
+ */
+struct dev_msi_info {
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	struct irq_domain	*domain;
+#endif
+};
+
+/**
  * struct device - The basic device structure
  * @parent:	The device's "parent" device, the device to which it is attached.
  * 		In most cases, a parent device is some sort of bus or host
@@ -407,8 +417,8 @@ struct dev_links_info {
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
+ * @msi:	MSI related data
  * @msi_list:	Hosts MSI descriptors
- * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
  * @dma_ops:    DMA mapping operations for this device.
  * @dma_mask:	Dma mask (if dma'ble device).
@@ -500,12 +510,10 @@ struct device {
 	struct em_perf_domain	*em_pd;
 #endif
 
-#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	struct irq_domain	*msi_domain;
-#endif
 #ifdef CONFIG_PINCTRL
 	struct dev_pin_info	*pins;
 #endif
+	struct dev_msi_info	msi;
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	struct list_head	msi_list;
 #endif
@@ -666,7 +674,7 @@ static inline void set_dev_node(struct device *dev, int node)
 static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	return dev->msi_domain;
+	return dev->msi.domain;
 #else
 	return NULL;
 #endif
@@ -675,7 +683,7 @@ static inline struct irq_domain *dev_get_msi_domain(const struct device *dev)
 static inline void dev_set_msi_domain(struct device *dev, struct irq_domain *d)
 {
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
-	dev->msi_domain = d;
+	dev->msi.domain = d;
 #endif
 }
 
