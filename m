Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE375534E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351992AbiFUOs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351922AbiFUOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:48:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3540B175AD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655822912; x=1687358912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=23hC2f4dgyTyX4xCupRfbmP4pCP+etJyCkXoUnCA06c=;
  b=R+TbAYfw8ewkSg7/1lArpPJAnmOBWpm5mraDm3jZSUXYBFa+aFVynnG4
   JP5pQrdOBjKlRhrfgQ0XcAU9OtSqs7K5Tbt2nveh3Pq109g+P4y56J/M9
   N+SL4UzQU0jOP3+slwx+T4fOqjh7EtTapq6dODDi6FCvMf4WutM8XE8jY
   gGQxxVrO69sQRTkF6xcSVcEoBpv5MdSpKb9aDDeLSKq+pNLURFfEuctZS
   Onq8Tl56B/yziN/3+4byzY3D6CeJuJCK+/I/8+grvMleuFk6AR1ftjAwe
   GmEf77cG+T9k28REqd+E/rQ6QQYefWqlrcxw+OeJkOPxs5l/8UrxmRT6Z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="260566691"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="260566691"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 07:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="643659433"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 21 Jun 2022 07:48:28 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v9 07/11] iommu/sva: Refactoring iommu_sva_bind/unbind_device()
Date:   Tue, 21 Jun 2022 22:43:49 +0800
Message-Id: <20220621144353.17547-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621144353.17547-1-baolu.lu@linux.intel.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
set/block_pasid_dev ops and align them with the concept of the SVA
iommu domain. Put the new SVA code in the sva related file in order
to make it self-contained.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         |  67 +++++++++++--------
 drivers/iommu/iommu-sva-lib.c |  98 ++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         | 119 ++++++++--------------------------
 3 files changed, 165 insertions(+), 119 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b8b6b8c5e20e..c0c23d9fd8fe 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -39,7 +39,6 @@ struct device;
 struct iommu_domain;
 struct iommu_domain_ops;
 struct notifier_block;
-struct iommu_sva;
 struct iommu_fault_event;
 struct iommu_dma_cookie;
 
@@ -57,6 +56,14 @@ struct iommu_domain_geometry {
 	bool force_aperture;       /* DMA only allowed in mappable range? */
 };
 
+/**
+ * struct iommu_sva - handle to a device-mm bond
+ */
+struct iommu_sva {
+	struct device		*dev;
+	refcount_t		users;
+};
+
 /* Domain feature flags */
 #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
@@ -105,6 +112,7 @@ struct iommu_domain {
 		};
 		struct {	/* IOMMU_DOMAIN_SVA */
 			struct mm_struct *mm;
+			struct iommu_sva bond;
 		};
 	};
 };
@@ -638,13 +646,6 @@ struct iommu_fwspec {
 /* ATS is supported */
 #define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
 
-/**
- * struct iommu_sva - handle to a device-mm bond
- */
-struct iommu_sva {
-	struct device			*dev;
-};
-
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
@@ -685,11 +686,6 @@ int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
 
-struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm);
-void iommu_sva_unbind_device(struct iommu_sva *handle);
-u32 iommu_sva_get_pasid(struct iommu_sva *handle);
-
 int iommu_device_use_default_domain(struct device *dev);
 void iommu_device_unuse_default_domain(struct device *dev);
 
@@ -703,6 +699,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
 			      ioasid_t pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 			       ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1033,21 +1031,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
-static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
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
@@ -1093,6 +1076,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
 					     struct device *dev, ioasid_t pasid)
 {
 }
+
+static inline struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
@@ -1118,4 +1107,26 @@ void iommu_debugfs_setup(void);
 static inline void iommu_debugfs_setup(void) {}
 #endif
 
+#ifdef CONFIG_IOMMU_SVA
+struct iommu_sva *iommu_sva_bind_device(struct device *dev,
+					struct mm_struct *mm);
+void iommu_sva_unbind_device(struct iommu_sva *handle);
+u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+#else
+static inline struct iommu_sva *
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
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
 #endif /* __LINUX_IOMMU_H */
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 106506143896..1e3e2b395b1e 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -4,6 +4,7 @@
  */
 #include <linux/mutex.h>
 #include <linux/sched/mm.h>
+#include <linux/iommu.h>
 
 #include "iommu-sva-lib.h"
 
@@ -69,3 +70,100 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
 	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
+
+/**
+ * iommu_sva_bind_device() - Bind a process address space to a device
+ * @dev: the device
+ * @mm: the mm to bind, caller must hold a reference to mm_users
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
+struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
+{
+	struct iommu_domain *domain;
+	ioasid_t max_pasids;
+	int ret = -EINVAL;
+
+	/* Allocate mm->pasid if necessary. */
+	max_pasids = dev->iommu->max_pasids;
+	if (!max_pasids)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mutex_lock(&iommu_sva_lock);
+	/* Search for an existing domain. */
+	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
+	if (domain) {
+		refcount_inc(&domain->bond.users);
+		goto out_success;
+	}
+
+	/* Allocate a new domain and set it on device pasid. */
+	domain = iommu_sva_domain_alloc(dev, mm);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
+	if (ret)
+		goto out_free_domain;
+	domain->bond.dev = dev;
+	refcount_set(&domain->bond.users, 1);
+
+out_success:
+	mutex_unlock(&iommu_sva_lock);
+	return &domain->bond;
+
+out_free_domain:
+	iommu_domain_free(domain);
+out_unlock:
+	mutex_unlock(&iommu_sva_lock);
+
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
+	struct iommu_domain *domain =
+			container_of(handle, struct iommu_domain, bond);
+	ioasid_t pasid = iommu_sva_get_pasid(handle);
+
+	mutex_lock(&iommu_sva_lock);
+	if (refcount_dec_and_test(&domain->bond.users)) {
+		iommu_detach_device_pasid(domain, dev, pasid);
+		iommu_domain_free(domain);
+	}
+	mutex_unlock(&iommu_sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
+
+u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	struct iommu_domain *domain =
+			container_of(handle, struct iommu_domain, bond);
+
+	return domain->mm->pasid;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8450f914cb2b..34d71418e7c7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2789,97 +2789,6 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 }
 EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
 
-/**
- * iommu_sva_bind_device() - Bind a process address space to a device
- * @dev: the device
- * @mm: the mm to bind, caller must hold a reference to it
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
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
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
-	handle = ops->sva_bind(dev, mm);
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
@@ -3364,3 +3273,31 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
 
 	iommu_group_put(group);
 }
+
+/*
+ * This is a variant of iommu_get_domain_for_dev(). It returns the existing
+ * domain attached to pasid of a device. It's only for internal use of the
+ * IOMMU subsystem. The caller must take care to avoid any possible
+ * use-after-free case.
+ */
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+
+	if (!pasid_valid(pasid))
+		return NULL;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return NULL;
+	/*
+	 * The xarray protects its internal state with RCU. Hence the domain
+	 * obtained is either NULL or fully formed.
+	 */
+	domain = xa_load(&group->pasid_array, pasid);
+	iommu_group_put(group);
+
+	return domain;
+}
-- 
2.25.1

