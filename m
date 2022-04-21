Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565085096C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384438AbiDUF1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384417AbiDUF1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:27:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939E9DFAF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650518675; x=1682054675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q/fs1ph+YqLVAyZTEiwMNr7hln+IAf6hu2jmOFzBo0o=;
  b=U9ahv44RlibZVgZy8lUZSr2NS2D3j/I28i1FEbySnUvbVyjCDws9b+Ll
   WpPzenuEImBNmnfhcZSB+XrMmwu5GeRT+kWUj8gbIwRbwDy+WWVnZDron
   AvLFc3IUJQQng+Xbcuj+6+1venNO3RxYbQIAHHWUtkkQd2Y4UB1cgzU/o
   jTcWFd5nZBNb3NtFyaX4/bMJ9D8cFB/OEIODWu4mjYItKCkFSoqAATb5a
   wCkadVRjQGAF0U22+Ser7vz4/+wpM2lrblVjv0G52qo6zWlcb8Bw410Sv
   iR8nJi9OxGcf8vb94LN0jDPXWrBjGiYqA0H42+sd6KnfuHY8RcTPWXRAb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246135696"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="246135696"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 22:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="702944157"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 22:24:31 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA interfaces
Date:   Thu, 21 Apr 2022 13:21:17 +0800
Message-Id: <20220421052121.3464100-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing iommu SVA interfaces are implemented by calling the SVA
specific iommu ops provided by the IOMMU drivers. There's no need for
any SVA specific ops in iommu_ops vector anymore as we can achieve
this through the generic attach/detach_dev_pasid domain ops.

This refactors the IOMMU SVA interfaces implementation by using the
attach/detach_pasid_dev ops and align them with the concept of the
iommu domain. Put the new SVA code in the sva related file in order
to make it self-contained.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         |  44 ++++----
 drivers/iommu/iommu-sva-lib.h |   5 +
 drivers/iommu/iommu-sva-lib.c | 196 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |  95 +---------------
 4 files changed, 227 insertions(+), 113 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 14c3b2197b35..2a2d17431826 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -677,12 +677,6 @@ int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
 
-struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm,
-					void *drvdata);
-void iommu_sva_unbind_device(struct iommu_sva *handle);
-u32 iommu_sva_get_pasid(struct iommu_sva *handle);
-
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -1019,21 +1013,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
-static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
-{
-	return NULL;
-}
-
-static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
-{
-}
-
-static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
-{
-	return IOMMU_PASID_INVALID;
-}
-
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
 	return NULL;
@@ -1075,6 +1054,29 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
 }
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_SVA
+struct iommu_sva *iommu_sva_bind_device(struct device *dev,
+					struct mm_struct *mm,
+					void *drvdata);
+void iommu_sva_unbind_device(struct iommu_sva *handle);
+u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+#else /* CONFIG_IOMMU_SVA */
+static inline struct iommu_sva *
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+{
+	return NULL;
+}
+
+static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
+{
+}
+
+static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	return IOMMU_PASID_INVALID;
+}
+#endif /* CONFIG_IOMMU_SVA */
+
 /**
  * iommu_map_sgtable - Map the given buffer to the IOMMU domain
  * @domain:	The IOMMU domain to perform the mapping
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 9c5e108e2c8a..724af2226581 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -27,6 +27,7 @@ int iopf_queue_flush_dev(struct device *dev);
 struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
+void iommu_sva_ioas_put(struct iommu_sva_ioas *ioas);
 
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
@@ -64,5 +65,9 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 {
 	return -ENODEV;
 }
+
+static inline void iommu_sva_ioas_put(struct iommu_sva_ioas *ioas)
+{
+}
 #endif /* CONFIG_IOMMU_SVA */
 #endif /* _IOMMU_SVA_LIB_H */
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index d524a402be3b..7439f046d2ab 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -11,6 +11,7 @@
 
 static DEFINE_MUTEX(iommu_sva_lock);
 static DECLARE_IOASID_SET(iommu_sva_pasid);
+static DEFINE_XARRAY_ALLOC(iommu_sva_ioas_array);
 
 struct iommu_sva_ioas {
 	struct mm_struct *mm;
@@ -87,3 +88,198 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
 	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
+
+/*
+ * Get or put an ioas for a shared memory.
+ */
+static struct iommu_sva_ioas *iommu_sva_ioas_get(struct mm_struct *mm,
+						 ioasid_t pasid)
+{
+	struct iommu_sva_ioas *ioas;
+	int ret;
+
+	ioas = xa_load(&iommu_sva_ioas_array, pasid);
+	if (ioas) {
+		if (WARN_ON(ioas->mm != mm))
+			return ERR_PTR(-EINVAL);
+		refcount_inc(&ioas->users);
+		return ioas;
+	}
+
+	ioas = kzalloc(sizeof(*ioas), GFP_KERNEL);
+	if (!ioas)
+		return ERR_PTR(-ENOMEM);
+
+	ioas->mm = mm;
+	ioas->pasid = pasid;
+	refcount_set(&ioas->users, 1);
+	INIT_LIST_HEAD(&ioas->bonds);
+	ret = xa_err(xa_store(&iommu_sva_ioas_array, pasid, ioas, GFP_KERNEL));
+	if (ret) {
+		kfree(ioas);
+		return ERR_PTR(ret);
+	}
+
+	mmgrab(mm);
+
+	return ioas;
+}
+
+void iommu_sva_ioas_put(struct iommu_sva_ioas *ioas)
+{
+	if (!ioas)
+		return;
+
+	if (refcount_dec_and_test(&ioas->users)) {
+		WARN_ON(!list_empty(&ioas->bonds));
+		xa_erase(&iommu_sva_ioas_array, ioas->pasid);
+		mmdrop(ioas->mm);
+		kfree(ioas);
+	}
+}
+
+/*
+ * IOMMU SVA driver-oriented interfaces
+ */
+static struct iommu_domain *
+iommu_sva_alloc_domain(struct device *dev, struct iommu_sva_ioas *ioas)
+{
+	struct bus_type *bus = dev->bus;
+	struct iommu_domain *domain;
+
+	if (!bus || !bus->iommu_ops)
+		return NULL;
+
+	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_SVA);
+	if (!domain)
+		return NULL;
+
+	/* The caller must hold a reference to ioas. */
+	domain->sva_ioas = ioas;
+	domain->type = IOMMU_DOMAIN_SVA;
+
+	return domain;
+}
+
+/**
+ * iommu_sva_bind_device() - Bind a process address space to a device
+ * @dev: the device
+ * @mm: the mm to bind, caller must hold a reference to it
+ * @drvdata: opaque data pointer to pass to bind callback
+ *
+ * Create a bond between device and address space, allowing the device to access
+ * the mm using the returned PASID. If a bond already exists between @device and
+ * @mm, it is returned and an additional reference is taken. Caller must call
+ * iommu_sva_unbind_device() to release each reference.
+ *
+ * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
+ * initialize the required SVA features.
+ *
+ * On error, returns an ERR_PTR value.
+ */
+struct iommu_sva *
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+{
+	int ret = -EINVAL;
+	struct iommu_sva *handle;
+	struct iommu_domain *domain;
+	struct iommu_sva_ioas *ioas;
+
+	/*
+	 * TODO: Remove the drvdata parameter after kernel PASID support is
+	 * enabled for the idxd driver.
+	 */
+	if (drvdata)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/* Allocate mm->pasid if necessary. */
+	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mutex_lock(&iommu_sva_lock);
+	ioas = iommu_sva_ioas_get(mm, mm->pasid);
+	if (IS_ERR(ioas)) {
+		ret = PTR_ERR(ioas);
+		goto out_unlock;
+	}
+
+	/* Search for an existing bond. */
+	list_for_each_entry(handle, &ioas->bonds, node) {
+		if (handle->dev == dev) {
+			refcount_inc(&handle->users);
+			/* No new bond, drop the counter. */
+			iommu_sva_ioas_put(ioas);
+			goto out_success;
+		}
+	}
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle) {
+		ret = -ENOMEM;
+		goto out_put_ioas;
+	}
+
+	/* The reference to ioas will be kept until domain free. */
+	domain = iommu_sva_alloc_domain(dev, ioas);
+	if (!domain) {
+		ret = -ENODEV;
+		goto out_free_handle;
+	}
+
+	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
+	if (ret)
+		goto out_free_domain;
+
+	handle->dev = dev;
+	handle->domain = domain;
+	handle->sva_ioas = ioas;
+	refcount_set(&handle->users, 1);
+	list_add_tail(&handle->node, &ioas->bonds);
+
+out_success:
+	mutex_unlock(&iommu_sva_lock);
+	return handle;
+
+out_free_domain:
+	domain->ops->free(domain);
+out_free_handle:
+	kfree(handle);
+out_put_ioas:
+	iommu_sva_ioas_put(ioas);
+out_unlock:
+	mutex_unlock(&iommu_sva_lock);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
+
+/**
+ * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
+ * @handle: the handle returned by iommu_sva_bind_device()
+ *
+ * Put reference to a bond between device and address space. The device should
+ * not be issuing any more transaction for this PASID. All outstanding page
+ * requests for this PASID must have been flushed to the IOMMU.
+ */
+void iommu_sva_unbind_device(struct iommu_sva *handle)
+{
+	struct device *dev = handle->dev;
+	struct iommu_domain *domain = handle->domain;
+	struct iommu_sva_ioas *ioas = handle->sva_ioas;
+
+	mutex_lock(&iommu_sva_lock);
+	if (refcount_dec_and_test(&handle->users)) {
+		list_del(&handle->node);
+		iommu_detach_device_pasid(domain, dev, ioas->pasid);
+		iommu_domain_free(domain);
+		kfree(handle);
+	}
+	mutex_unlock(&iommu_sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
+
+u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	return handle->sva_ioas->pasid;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c6fdc0067d76..7ed0a61351a5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -27,6 +27,8 @@
 #include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
 
+#include "iommu-sva-lib.h"
+
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
@@ -1905,6 +1907,7 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 void iommu_domain_free(struct iommu_domain *domain)
 {
 	iommu_put_dma_cookie(domain);
+	iommu_sva_ioas_put(domain->sva_ioas);
 	domain->ops->free(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
@@ -2708,98 +2711,6 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 }
 EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
 
-/**
- * iommu_sva_bind_device() - Bind a process address space to a device
- * @dev: the device
- * @mm: the mm to bind, caller must hold a reference to it
- * @drvdata: opaque data pointer to pass to bind callback
- *
- * Create a bond between device and address space, allowing the device to access
- * the mm using the returned PASID. If a bond already exists between @device and
- * @mm, it is returned and an additional reference is taken. Caller must call
- * iommu_sva_unbind_device() to release each reference.
- *
- * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
- * initialize the required SVA features.
- *
- * On error, returns an ERR_PTR value.
- */
-struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
-{
-	struct iommu_group *group;
-	struct iommu_sva *handle = ERR_PTR(-EINVAL);
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (!ops->sva_bind)
-		return ERR_PTR(-ENODEV);
-
-	group = iommu_group_get(dev);
-	if (!group)
-		return ERR_PTR(-ENODEV);
-
-	/* Ensure device count and domain don't change while we're binding */
-	mutex_lock(&group->mutex);
-
-	/*
-	 * To keep things simple, SVA currently doesn't support IOMMU groups
-	 * with more than one device. Existing SVA-capable systems are not
-	 * affected by the problems that required IOMMU groups (lack of ACS
-	 * isolation, device ID aliasing and other hardware issues).
-	 */
-	if (iommu_group_device_count(group) != 1)
-		goto out_unlock;
-
-	handle = ops->sva_bind(dev, mm, drvdata);
-
-out_unlock:
-	mutex_unlock(&group->mutex);
-	iommu_group_put(group);
-
-	return handle;
-}
-EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
-
-/**
- * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
- * @handle: the handle returned by iommu_sva_bind_device()
- *
- * Put reference to a bond between device and address space. The device should
- * not be issuing any more transaction for this PASID. All outstanding page
- * requests for this PASID must have been flushed to the IOMMU.
- */
-void iommu_sva_unbind_device(struct iommu_sva *handle)
-{
-	struct iommu_group *group;
-	struct device *dev = handle->dev;
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (!ops->sva_unbind)
-		return;
-
-	group = iommu_group_get(dev);
-	if (!group)
-		return;
-
-	mutex_lock(&group->mutex);
-	ops->sva_unbind(handle);
-	mutex_unlock(&group->mutex);
-
-	iommu_group_put(group);
-}
-EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
-
-u32 iommu_sva_get_pasid(struct iommu_sva *handle)
-{
-	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
-
-	if (!ops->sva_get_pasid)
-		return IOMMU_PASID_INVALID;
-
-	return ops->sva_get_pasid(handle);
-}
-EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
-
 /*
  * Changes the default domain of an iommu group that has *only* one device
  *
-- 
2.25.1

