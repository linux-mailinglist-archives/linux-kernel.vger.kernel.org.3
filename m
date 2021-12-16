Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFF477EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbhLPVkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:40:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbhLPVkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:22 -0500
Date:   Thu, 16 Dec 2021 21:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Em+rD6aapGQwvzpTyg1y4gzmhghCVA050SBTTrvD6ig=;
        b=rOtjFyIPBxaBs4iwY7dp5HyWdZ7uF+ug4cObk2ZJqPIMOQfjtpIixsyzKARkn86a480rgt
        g38zSXAx8XaDiNPiXlIwYAOrDj2XpLRvrZTuEPRzur0h9PgCHqyGhADV5+EuEq7RIj58sm
        rr2KYm1j6M2WWx7j8cfzbCNkOQDNAM7PI458EmlO+kCaW7/v4cMDVaBXI1udp6O3kKJ4eq
        2MkgBRCdDyP94du+DMJ4wug567AoTwjmLfSzyHYur9kWEGWCwortatZTjNeQzhPlVuaERl
        94Z+UprYNW6UG1YroiQY0kZlh525z9yG6W4uZ1AogKLl2JExnD7Lzi1CfAr9Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Em+rD6aapGQwvzpTyg1y4gzmhghCVA050SBTTrvD6ig=;
        b=9yeymY84e8+ZgiIFGxHJv/yjEkxu60gOhQtSmlTjP9VzCgNY+tY7Syv/ZOxwhxWXgPWMDZ
        pxldIvc69GpC7HBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Simplify sysfs handling
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210749.224917330@linutronix.de>
References: <20211206210749.224917330@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969081941.23020.3537255291797650928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     bf5e758f02fc739589dcc6a3395c3a3eb77b5c90
Gitweb:        https://git.kernel.org/tip/bf5e758f02fc739589dcc6a3395c3a3eb77b5c90
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:20 +01:00

genirq/msi: Simplify sysfs handling

The sysfs handling for MSI is a convoluted maze and it is in the way of
supporting dynamic expansion of the MSI-X vectors because it only supports
a one off bulk population/free of the sysfs entries.

Change it to do:

   1) Creating an empty sysfs attribute group when msi_device_data is
      allocated

   2) Populate the entries when the MSI descriptor is initialized

   3) Free the entries when a MSI descriptor is detached from a Linux
      interrupt.

   4) Provide functions for the legacy non-irqdomain fallback code to
      do a bulk population/free. This code won't support dynamic
      expansion.

This makes the code simpler and reduces the number of allocations as the
empty attribute group can be shared.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210749.224917330@linutronix.de

---
 include/linux/msi.h |  23 ++---
 kernel/irq/msi.c    | 198 +++++++++++++++++++------------------------
 2 files changed, 103 insertions(+), 118 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 70cc6a5..1a00367 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -71,7 +71,7 @@ struct irq_data;
 struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
-struct attribute_group;
+struct device_attribute;
 
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
@@ -129,6 +129,7 @@ struct pci_msi_desc {
  * @dev:	Pointer to the device which uses this descriptor
  * @msg:	The last set MSI message cached for reuse
  * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
+ * @sysfs_attr:	Pointer to sysfs device attribute
  *
  * @write_msi_msg:	Callback that may be called when the MSI message
  *			address or data changes
@@ -148,6 +149,9 @@ struct msi_desc {
 #ifdef CONFIG_IRQ_MSI_IOMMU
 	const void			*iommu_cookie;
 #endif
+#ifdef CONFIG_SYSFS
+	struct device_attribute		*sysfs_attrs;
+#endif
 
 	void (*write_msi_msg)(struct msi_desc *entry, void *data);
 	void *write_msi_msg_data;
@@ -171,7 +175,6 @@ enum msi_desc_filter {
 /**
  * msi_device_data - MSI per device data
  * @properties:		MSI properties which are interesting to drivers
- * @attrs:		Pointer to the sysfs attribute group
  * @platform_data:	Platform-MSI specific data
  * @list:		List of MSI descriptors associated to the device
  * @mutex:		Mutex protecting the MSI list
@@ -179,7 +182,6 @@ enum msi_desc_filter {
  */
 struct msi_device_data {
 	unsigned long			properties;
-	const struct attribute_group    **attrs;
 	struct platform_msi_priv_data	*platform_data;
 	struct list_head		list;
 	struct mutex			mutex;
@@ -264,14 +266,6 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
-#ifdef CONFIG_SYSFS
-int msi_device_populate_sysfs(struct device *dev);
-void msi_device_destroy_sysfs(struct device *dev);
-#else /* CONFIG_SYSFS */
-static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
-static inline void msi_device_destroy_sysfs(struct device *dev) { }
-#endif /* !CONFIG_SYSFS */
-
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
  * as weak symbols so that they /can/ be overriden by architecture specific
@@ -285,6 +279,13 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc);
 void arch_teardown_msi_irq(unsigned int irq);
 int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
 void arch_teardown_msi_irqs(struct pci_dev *dev);
+#ifdef CONFIG_SYSFS
+int msi_device_populate_sysfs(struct device *dev);
+void msi_device_destroy_sysfs(struct device *dev);
+#else /* CONFIG_SYSFS */
+static inline int msi_device_populate_sysfs(struct device *dev) { return 0; }
+static inline void msi_device_destroy_sysfs(struct device *dev) { }
+#endif /* !CONFIG_SYSFS */
 #endif /* CONFIG_PCI_MSI_ARCH_FALLBACKS */
 
 /*
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index e8c1974..d290e09 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -19,6 +19,7 @@
 
 #include "internals.h"
 
+static inline int msi_sysfs_create_group(struct device *dev);
 #define dev_to_msi_list(dev)	(&(dev)->msi.data->list)
 
 /**
@@ -178,6 +179,7 @@ static void msi_device_data_release(struct device *dev, void *res)
 int msi_setup_device_data(struct device *dev)
 {
 	struct msi_device_data *md;
+	int ret;
 
 	if (dev->msi.data)
 		return 0;
@@ -186,6 +188,12 @@ int msi_setup_device_data(struct device *dev)
 	if (!md)
 		return -ENOMEM;
 
+	ret = msi_sysfs_create_group(dev);
+	if (ret) {
+		devres_free(md);
+		return ret;
+	}
+
 	INIT_LIST_HEAD(&md->list);
 	mutex_init(&md->mutex);
 	dev->msi.data = md;
@@ -351,6 +359,20 @@ unsigned int msi_get_virq(struct device *dev, unsigned int index)
 EXPORT_SYMBOL_GPL(msi_get_virq);
 
 #ifdef CONFIG_SYSFS
+static struct attribute *msi_dev_attrs[] = {
+	NULL
+};
+
+static const struct attribute_group msi_irqs_group = {
+	.name	= "msi_irqs",
+	.attrs	= msi_dev_attrs,
+};
+
+static inline int msi_sysfs_create_group(struct device *dev)
+{
+	return devm_device_add_group(dev, &msi_irqs_group);
+}
+
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -360,97 +382,74 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
 }
 
-/**
- * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
- * @dev:	The device(PCI, platform etc) who will get sysfs entries
- */
-static const struct attribute_group **msi_populate_sysfs(struct device *dev)
+static void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc)
 {
-	const struct attribute_group **msi_irq_groups;
-	struct attribute **msi_attrs, *msi_attr;
-	struct device_attribute *msi_dev_attr;
-	struct attribute_group *msi_irq_group;
-	struct msi_desc *entry;
-	int ret = -ENOMEM;
-	int num_msi = 0;
-	int count = 0;
+	struct device_attribute *attrs = desc->sysfs_attrs;
 	int i;
 
-	/* Determine how many msi entries we have */
-	msi_for_each_desc(entry, dev, MSI_DESC_ALL)
-		num_msi += entry->nvec_used;
-	if (!num_msi)
-		return NULL;
+	if (!attrs)
+		return;
 
-	/* Dynamically create the MSI attributes for the device */
-	msi_attrs = kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
-	if (!msi_attrs)
-		return ERR_PTR(-ENOMEM);
-
-	msi_for_each_desc(entry, dev, MSI_DESC_ALL) {
-		for (i = 0; i < entry->nvec_used; i++) {
-			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
-			if (!msi_dev_attr)
-				goto error_attrs;
-			msi_attrs[count] = &msi_dev_attr->attr;
-
-			sysfs_attr_init(&msi_dev_attr->attr);
-			msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
-							    entry->irq + i);
-			if (!msi_dev_attr->attr.name)
-				goto error_attrs;
-			msi_dev_attr->attr.mode = 0444;
-			msi_dev_attr->show = msi_mode_show;
-			++count;
-		}
+	desc->sysfs_attrs = NULL;
+	for (i = 0; i < desc->nvec_used; i++) {
+		if (attrs[i].show)
+			sysfs_remove_file_from_group(&dev->kobj, &attrs[i].attr, msi_irqs_group.name);
+		kfree(attrs[i].attr.name);
 	}
+	kfree(attrs);
+}
 
-	msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
-	if (!msi_irq_group)
-		goto error_attrs;
-	msi_irq_group->name = "msi_irqs";
-	msi_irq_group->attrs = msi_attrs;
+static int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *desc)
+{
+	struct device_attribute *attrs;
+	int ret, i;
 
-	msi_irq_groups = kcalloc(2, sizeof(void *), GFP_KERNEL);
-	if (!msi_irq_groups)
-		goto error_irq_group;
-	msi_irq_groups[0] = msi_irq_group;
+	attrs = kcalloc(desc->nvec_used, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
 
-	ret = sysfs_create_groups(&dev->kobj, msi_irq_groups);
-	if (ret)
-		goto error_irq_groups;
-
-	return msi_irq_groups;
-
-error_irq_groups:
-	kfree(msi_irq_groups);
-error_irq_group:
-	kfree(msi_irq_group);
-error_attrs:
-	count = 0;
-	msi_attr = msi_attrs[count];
-	while (msi_attr) {
-		msi_dev_attr = container_of(msi_attr, struct device_attribute, attr);
-		kfree(msi_attr->name);
-		kfree(msi_dev_attr);
-		++count;
-		msi_attr = msi_attrs[count];
+	desc->sysfs_attrs = attrs;
+	for (i = 0; i < desc->nvec_used; i++) {
+		sysfs_attr_init(&attrs[i].attr);
+		attrs[i].attr.name = kasprintf(GFP_KERNEL, "%d", desc->irq + i);
+		if (!attrs[i].attr.name) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		attrs[i].attr.mode = 0444;
+		attrs[i].show = msi_mode_show;
+
+		ret = sysfs_add_file_to_group(&dev->kobj, &attrs[i].attr, msi_irqs_group.name);
+		if (ret) {
+			attrs[i].show = NULL;
+			goto fail;
+		}
 	}
-	kfree(msi_attrs);
-	return ERR_PTR(ret);
+	return 0;
+
+fail:
+	msi_sysfs_remove_desc(dev, desc);
+	return ret;
 }
 
+#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
 /**
  * msi_device_populate_sysfs - Populate msi_irqs sysfs entries for a device
  * @dev:	The device (PCI, platform etc) which will get sysfs entries
  */
 int msi_device_populate_sysfs(struct device *dev)
 {
-	const struct attribute_group **group = msi_populate_sysfs(dev);
+	struct msi_desc *desc;
+	int ret;
 
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-	dev->msi.data->attrs = group;
+	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
+		if (desc->sysfs_attrs)
+			continue;
+		ret = msi_sysfs_populate_desc(dev, desc);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 
@@ -461,28 +460,17 @@ int msi_device_populate_sysfs(struct device *dev)
  */
 void msi_device_destroy_sysfs(struct device *dev)
 {
-	const struct attribute_group **msi_irq_groups = dev->msi.data->attrs;
-	struct device_attribute *dev_attr;
-	struct attribute **msi_attrs;
-	int count = 0;
-
-	dev->msi.data->attrs = NULL;
-	if (!msi_irq_groups)
-		return;
+	struct msi_desc *desc;
 
-	sysfs_remove_groups(&dev->kobj, msi_irq_groups);
-	msi_attrs = msi_irq_groups[0]->attrs;
-	while (msi_attrs[count]) {
-		dev_attr = container_of(msi_attrs[count], struct device_attribute, attr);
-		kfree(dev_attr->attr.name);
-		kfree(dev_attr);
-		++count;
-	}
-	kfree(msi_attrs);
-	kfree(msi_irq_groups[0]);
-	kfree(msi_irq_groups);
+	msi_for_each_desc(desc, dev, MSI_DESC_ALL)
+		msi_sysfs_remove_desc(dev, desc);
 }
-#endif
+#endif /* CONFIG_PCI_MSI_ARCH_FALLBACK */
+#else /* CONFIG_SYSFS */
+static inline int msi_sysfs_create_group(struct device *dev) { return 0; }
+static inline int msi_sysfs_populate_desc(struct device *dev, struct msi_desc *desc) { return 0; }
+static inline void msi_sysfs_remove_desc(struct device *dev, struct msi_desc *desc) { }
+#endif /* !CONFIG_SYSFS */
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
@@ -914,6 +902,12 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			ret = msi_init_virq(domain, virq + i, vflags);
 			if (ret)
 				return ret;
+
+			if (info->flags & MSI_FLAG_DEV_SYSFS) {
+				ret = msi_sysfs_populate_desc(dev, desc);
+				if (ret)
+					return ret;
+			}
 		}
 		allocated++;
 	}
@@ -958,18 +952,7 @@ int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device 
 
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
 	if (ret)
-		goto cleanup;
-
-	if (!(info->flags & MSI_FLAG_DEV_SYSFS))
-		return 0;
-
-	ret = msi_device_populate_sysfs(dev);
-	if (ret)
-		goto cleanup;
-	return 0;
-
-cleanup:
-	msi_domain_free_irqs_descs_locked(domain, dev);
+		msi_domain_free_irqs_descs_locked(domain, dev);
 	return ret;
 }
 
@@ -994,6 +977,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nve
 
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
+	struct msi_domain_info *info = domain->host_data;
 	struct irq_data *irqd;
 	struct msi_desc *desc;
 	int i;
@@ -1008,6 +992,8 @@ void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 		}
 
 		irq_domain_free_irqs(desc->irq, desc->nvec_used);
+		if (info->flags & MSI_FLAG_DEV_SYSFS)
+			msi_sysfs_remove_desc(dev, desc);
 		desc->irq = 0;
 	}
 }
@@ -1036,8 +1022,6 @@ void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device 
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	if (info->flags & MSI_FLAG_DEV_SYSFS)
-		msi_device_destroy_sysfs(dev);
 	ops->domain_free_irqs(domain, dev);
 	msi_domain_free_msi_descs(info, dev);
 }
