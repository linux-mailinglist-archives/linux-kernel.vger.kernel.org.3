Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550254EA73F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiC2Fmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiC2Fm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:42:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9431924A76B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648532442; x=1680068442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6btWeZ5iTNOQlxZgaeVAufZpKRbPQP+0YXeY7Gwq8LE=;
  b=KyvpPyq40jYU+qWjHw+GjF2zJRoharkU65OVQLnbqK9BWb4N79Y/4BmI
   YLNTnfs92djxniJpbiBBfFGc30yqE6WCtX9fviwR04F2NdsuD3JYS8Jvt
   YELcmX8fap65vvaCQAjPhbBcZrCXPb7yzVDcG3xqXvUHFfSlQ1g9hVvao
   HezDNuxR0abmyY+GHpP2wkQDu6MJEmz+h47uLT7dR7vS+uyljm3bbqPRv
   YBuJ6lb94jAXWrdQkvNm8ZrCAKbxh8f9Kct1v3oCMcWf5IpoDVOdVpuDc
   otwPoH5Qmn2/BKzWwa+494L3lcCLO8xpeSAIuxLrxTlsTgnOk445spy4x
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259137030"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="259137030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="694603662"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:38 -0700
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
Subject: [PATCH RFC v2 08/11] iommu/sva: Use attach/detach_pasid_dev in SVA interfaces
Date:   Tue, 29 Mar 2022 13:37:57 +0800
Message-Id: <20220329053800.3049561-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 include/linux/iommu.h         |  51 +++++++++-------
 drivers/iommu/iommu-sva-lib.c | 110 +++++++++++++++++++++++++++++++++-
 drivers/iommu/iommu.c         |  92 ----------------------------
 3 files changed, 138 insertions(+), 115 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a46285488a57..11c4d99e122d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -629,7 +629,12 @@ struct iommu_fwspec {
  * struct iommu_sva - handle to a device-mm bond
  */
 struct iommu_sva {
-	struct device			*dev;
+	struct device		*dev;
+	ioasid_t		pasid;
+	struct iommu_domain	*domain;
+	/* Link to sva domain's bonds list */
+	struct list_head	node;
+	refcount_t		users;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
@@ -672,12 +677,6 @@ int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
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
 
@@ -1018,21 +1017,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
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
@@ -1085,6 +1069,29 @@ iommu_put_domain_for_dev_pasid(struct iommu_domain *domain)
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
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 78820be23f15..1b45b7d01836 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -17,6 +17,7 @@ struct iommu_sva_cookie {
 	struct mm_struct *mm;
 	ioasid_t pasid;
 	refcount_t users;
+	struct list_head bonds;
 };
 
 /**
@@ -101,6 +102,7 @@ iommu_sva_alloc_domain(struct device *dev, struct mm_struct *mm)
 	cookie->mm = mm;
 	cookie->pasid = mm->pasid;
 	refcount_set(&cookie->users, 1);
+	INIT_LIST_HEAD(&cookie->bonds);
 	domain->type = IOMMU_DOMAIN_SVA;
 	domain->sva_cookie = cookie;
 	curr = xa_store(&sva_domain_array, mm->pasid, domain, GFP_KERNEL);
@@ -118,6 +120,7 @@ iommu_sva_alloc_domain(struct device *dev, struct mm_struct *mm)
 static void iommu_sva_free_domain(struct iommu_domain *domain)
 {
 	xa_erase(&sva_domain_array, domain->sva_cookie->pasid);
+	WARN_ON(!list_empty(&domain->sva_cookie->bonds));
 	kfree(domain->sva_cookie);
 	domain->ops->free(domain);
 }
@@ -137,7 +140,7 @@ void iommu_sva_domain_put_user(struct iommu_domain *domain)
 		iommu_sva_free_domain(domain);
 }
 
-static __maybe_unused struct iommu_domain *
+static struct iommu_domain *
 iommu_sva_get_domain(struct device *dev, struct mm_struct *mm)
 {
 	struct iommu_domain *domain;
@@ -158,3 +161,108 @@ struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain)
 {
 	return domain->sva_cookie->mm;
 }
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
+
+	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mutex_lock(&iommu_sva_lock);
+	domain = iommu_sva_get_domain(dev, mm);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	/* Search for an existing bond. */
+	list_for_each_entry(handle, &domain->sva_cookie->bonds, node) {
+		if (handle->dev == dev && handle->pasid == mm->pasid) {
+			refcount_inc(&handle->users);
+			mutex_lock(&iommu_sva_lock);
+
+			return handle;
+		}
+	}
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle) {
+		ret = -ENOMEM;
+		goto out_put_domain;
+	}
+
+	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
+	if (ret)
+		goto out_free_handle;
+
+	handle->dev = dev;
+	handle->domain = domain;
+	handle->pasid = mm->pasid;
+	refcount_set(&handle->users, 1);
+	list_add_tail(&handle->node, &domain->sva_cookie->bonds);
+
+	mutex_unlock(&iommu_sva_lock);
+	return handle;
+
+out_free_handle:
+	kfree(handle);
+out_put_domain:
+	iommu_sva_domain_put_user(domain);
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
+	struct mm_struct *mm = iommu_sva_domain_mm(domain);
+
+	mutex_lock(&iommu_sva_lock);
+	if (refcount_dec_and_test(&handle->users)) {
+		list_del(&handle->node);
+		iommu_detach_device_pasid(domain, dev, mm->pasid);
+		kfree(handle);
+	}
+
+	iommu_sva_domain_put_user(domain);
+	mutex_unlock(&iommu_sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
+
+u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	return handle->pasid;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8163ad7f6902..6b51ead9d63b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2712,98 +2712,6 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
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
-	if (!iommu_group_singleton_lockdown(group))
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

