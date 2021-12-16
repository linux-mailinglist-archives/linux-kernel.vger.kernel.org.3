Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBA6477F53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbhLPVmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242036AbhLPVlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556F0C061763;
        Thu, 16 Dec 2021 13:40:45 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+edDRfAqGEce1U7pUkjf6CGnBKOzQqLIjEph6sr6D8=;
        b=kMZJWi9nvrNzcOHMqsuLZZ1kfBWh6BpcbmKgfaF54R5TXiYN4iH/2o9PaP4t11Q7aqUr24
        iUOtN3BJVGnRmkwQJnyqXvQzxbATtF+B4TmEftTuF1T5y1vnHV4U0qWjEQgwbPSGUDeXoJ
        Mf5vooyy/LvATTB9wEtEWB/C2hvajyr2E4GXJjcyjAj3p39MF3VigSdyMvPq70h5sF6qcv
        wzAJMd1E6EdQMEgJYMZJD0z8Bu2IEIBxFPs/1/7gj5b7+C+ZfyoC3ePy5zkaNDYzIhR3NH
        ym2FwRhyVMq+kBUg8mhh8AZklrvUji9DvJ+ICcPU18PtLndQH7n2U8gVmpoM5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+edDRfAqGEce1U7pUkjf6CGnBKOzQqLIjEph6sr6D8=;
        b=AVRyRLF8Qh0s9H1gtX+2Iv8MKZsYYhmNWQeELHbXQhQByJABfFEkk7T9UCugEm0PojM8qi
        nnGlxUfAh3faHrDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211206210747.765371053@linutronix.de>
References: <20211206210747.765371053@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084294.23020.7082779500273605511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     0f62d941acf9ac3b6025692ce649b1f282b89e7f
Gitweb:        https://git.kernel.org/tip/0f62d941acf9ac3b6025692ce649b1f282b89e7f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:17 +01:00

genirq/msi: Provide msi_domain_alloc/free_irqs_descs_locked()

Usage sites which do allocations of the MSI descriptors before invoking
msi_domain_alloc_irqs() require to lock the MSI decriptors accross the
operation.

Provide entry points which can be called with the MSI mutex held and lock
the mutex in the existing entry points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210747.765371053@linutronix.de

---
 include/linux/msi.h |  3 ++-
 kernel/irq/msi.c    | 74 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 2cf6c53..69c588e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -383,9 +383,12 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct irq_domain *parent);
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec);
+int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
+				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 97ec245..3b21e99 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -672,10 +672,8 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false,
 					       desc->affinity);
-		if (virq < 0) {
-			ret = msi_handle_pci_fail(domain, desc, allocated);
-			goto cleanup;
-		}
+		if (virq < 0)
+			return msi_handle_pci_fail(domain, desc, allocated);
 
 		for (i = 0; i < desc->nvec_used; i++) {
 			irq_set_msi_desc_off(virq, i, desc);
@@ -709,7 +707,7 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 		}
 		ret = irq_domain_activate_irq(irq_data, can_reserve);
 		if (ret)
-			goto cleanup;
+			return ret;
 	}
 
 skip_activate:
@@ -724,38 +722,63 @@ skip_activate:
 		}
 	}
 	return 0;
-
-cleanup:
-	msi_domain_free_irqs(domain, dev);
-	return ret;
 }
 
 /**
- * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
+ * msi_domain_alloc_irqs_descs_locked - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are allocated
  * @nvec:	The number of interrupts to allocate
  *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation/free.
+ *
  * Return: %0 on success or an error code.
  */
-int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			  int nvec)
+int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
+				       int nvec)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 	int ret;
 
+	lockdep_assert_held(&dev->msi.data->mutex);
+
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
 	if (ret)
-		return ret;
+		goto cleanup;
 
 	if (!(info->flags & MSI_FLAG_DEV_SYSFS))
 		return 0;
 
 	ret = msi_device_populate_sysfs(dev);
 	if (ret)
-		msi_domain_free_irqs(domain, dev);
+		goto cleanup;
+	return 0;
+
+cleanup:
+	msi_domain_free_irqs_descs_locked(domain, dev);
+	return ret;
+}
+
+/**
+ * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
+ * @domain:	The domain to allocate from
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are allocated
+ * @nvec:	The number of interrupts to allocate
+ *
+ * Return: %0 on success or an error code.
+ */
+int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec)
+{
+	int ret;
+
+	msi_lock_descs(dev);
+	ret = msi_domain_alloc_irqs_descs_locked(domain, dev, nvec);
+	msi_unlock_descs(dev);
 	return ret;
 }
 
@@ -785,22 +808,41 @@ void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 }
 
 /**
- * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
+ * msi_domain_free_irqs_descs_locked - Free interrupts from a MSI interrupt @domain associated to @dev
  * @domain:	The domain to managing the interrupts
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are free
+ *
+ * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
+ * pair. Use this for MSI irqdomains which implement their own vector
+ * allocation.
  */
-void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 
+	lockdep_assert_held(&dev->msi.data->mutex);
+
 	if (info->flags & MSI_FLAG_DEV_SYSFS)
 		msi_device_destroy_sysfs(dev);
 	ops->domain_free_irqs(domain, dev);
 }
 
 /**
+ * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
+ * @domain:	The domain to managing the interrupts
+ * @dev:	Pointer to device struct of the device for which the interrupts
+ *		are free
+ */
+void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+{
+	msi_lock_descs(dev);
+	msi_domain_free_irqs_descs_locked(domain, dev);
+	msi_unlock_descs(dev);
+}
+
+/**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
  * @domain:	The interrupt domain to retrieve data from
  *
