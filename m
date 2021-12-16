Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9821477F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbhLPVmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbhLPVlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5B3C06175D;
        Thu, 16 Dec 2021 13:40:42 -0800 (PST)
Date:   Thu, 16 Dec 2021 21:40:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2SAOEfcXfgIdQYob1QUIgcjpDfALzZWbwCfpy4uRcdE=;
        b=oybRFNjMVNIbdv5mFllAw3UUrBX/fN/pXKrTaFOpinBQMZaQShyzHkV/ldt1ZBmmYseDUN
        xfDLeFf3XPszfnr6Zikmo12ASGToPTRUpivpr5yyg37gBl2dIttARMl2N7SJQjri9AvfXB
        6PKcOZHLuThoY5l0+rVT9tLFGvhxmKQCIFypFESXeND9DizmapD0e6Z7p3qzZMAksKONLe
        JPKBtz+WnzvSdoHdH5P62X78SOY4zp+wv8k904UgyHhjGuhdlQPp3oXz6qy0hQDU//t1tF
        3AEhwtG9ApWuSAFHx6xJzFAWpbn5djhCf042V2ZF+d8YCXw9yCs2RJ3oy/XiCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690841;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2SAOEfcXfgIdQYob1QUIgcjpDfALzZWbwCfpy4uRcdE=;
        b=XveAkshZoIXB+Cb+mM+AreZp0sPSY+7LisovJ6dEJdsFeSNbPaM2kIZYZtdraS93rb0gWQ
        BLYFt2y4P4fBrcBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Provide domain flags to allocate/free MSI
 descriptors automatically
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@nvidia.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211206210747.928198636@linutronix.de>
References: <20211206210747.928198636@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969084057.23020.15516499987764809138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     645474e2cee450131e8b8d8a69a5d9bbabd43f3f
Gitweb:        https://git.kernel.org/tip/645474e2cee450131e8b8d8a69a5d9bbabd43f3f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:51:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:22:17 +01:00

genirq/msi: Provide domain flags to allocate/free MSI descriptors automatically

Provide domain info flags which tell the core to allocate simple
descriptors or to free descriptors when the interrupts are freed and
implement the required functionality.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211206210747.928198636@linutronix.de

---
 include/linux/msi.h | 17 ++++++++++++++++-
 kernel/irq/msi.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index bbb8c1e..17e47ab 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -105,6 +105,8 @@ struct pci_msi_desc {
 	};
 };
 
+#define MSI_MAX_INDEX		((unsigned int)USHRT_MAX)
+
 /**
  * struct msi_desc - Descriptor structure for MSI based interrupts
  * @list:	List head for management
@@ -248,6 +250,17 @@ static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
 #endif /* CONFIG_PCI_MSI */
 
 int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
+void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
+			      unsigned int first_index, unsigned int last_index);
+
+/**
+ * msi_free_msi_descs - Free MSI descriptors of a device
+ * @dev:	Device to free the descriptors
+ */
+static inline void msi_free_msi_descs(struct device *dev)
+{
+	msi_free_msi_descs_range(dev, MSI_DESC_ALL, 0, MSI_MAX_INDEX);
+}
 
 struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
 				 const struct irq_affinity_desc *affinity);
@@ -408,6 +421,10 @@ enum {
 	MSI_FLAG_DEV_SYSFS		= (1 << 7),
 	/* MSI-X entries must be contiguous */
 	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 8),
+	/* Allocate simple MSI descriptors */
+	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 9),
+	/* Free MSI descriptors */
+	MSI_FLAG_FREE_MSI_DESCS		= (1 << 10),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 6ffe75e..b511dc1 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -119,6 +119,32 @@ fail:
 	return -ENOMEM;
 }
 
+/**
+ * msi_free_msi_descs_range - Free MSI descriptors of a device
+ * @dev:		Device to free the descriptors
+ * @filter:		Descriptor state filter
+ * @first_index:	Index to start freeing from
+ * @last_index:		Last index to be freed
+ */
+void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
+			      unsigned int first_index, unsigned int last_index)
+{
+	struct msi_desc *desc;
+
+	lockdep_assert_held(&dev->msi.data->mutex);
+
+	msi_for_each_desc(desc, dev, filter) {
+		/*
+		 * Stupid for now to handle MSI device domain until the
+		 * storage is switched over to an xarray.
+		 */
+		if (desc->msi_index < first_index || desc->msi_index > last_index)
+			continue;
+		list_del(&desc->list);
+		free_msi_entry(desc);
+	}
+}
+
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
 {
 	*msg = entry->msg;
@@ -879,6 +905,16 @@ skip_activate:
 	return 0;
 }
 
+static int msi_domain_add_simple_msi_descs(struct msi_domain_info *info,
+					   struct device *dev,
+					   unsigned int num_descs)
+{
+	if (!(info->flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS))
+		return 0;
+
+	return msi_add_simple_msi_descs(dev, 0, num_descs);
+}
+
 /**
  * msi_domain_alloc_irqs_descs_locked - Allocate interrupts from a MSI interrupt domain
  * @domain:	The domain to allocate from
@@ -901,6 +937,10 @@ int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device 
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
+	ret = msi_domain_add_simple_msi_descs(info, dev, nvec);
+	if (ret)
+		return ret;
+
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
 	if (ret)
 		goto cleanup;
@@ -962,6 +1002,13 @@ void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 	}
 }
 
+static void msi_domain_free_msi_descs(struct msi_domain_info *info,
+				      struct device *dev)
+{
+	if (info->flags & MSI_FLAG_FREE_MSI_DESCS)
+		msi_free_msi_descs(dev);
+}
+
 /**
  * msi_domain_free_irqs_descs_locked - Free interrupts from a MSI interrupt @domain associated to @dev
  * @domain:	The domain to managing the interrupts
@@ -982,6 +1029,7 @@ void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device 
 	if (info->flags & MSI_FLAG_DEV_SYSFS)
 		msi_device_destroy_sysfs(dev);
 	ops->domain_free_irqs(domain, dev);
+	msi_domain_free_msi_descs(info, dev);
 }
 
 /**
