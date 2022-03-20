Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241294E1A86
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbiCTGo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244870AbiCTGoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:44:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CC92DC9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647758582; x=1679294582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GgJjm5L//lZa3AFsSBcPVxqUxFH3rG+YLHsQRqITlJc=;
  b=Bhg41CA0h0D+xlvgl+un+LL6BEIvwRzB41YSCZ+edaz9Szbs5fAkqv/u
   nB7XhyPYhsOj5rSZmPMC9l3zqEgtXZtqpe6fhW7WIJ1FMTUO5d+ajVVDm
   Ynhgj+CkUpOgdcwZSNgAFNzcam9VgryL2nUHiO577SfmTMzdTSfJXzoe+
   bHQQL1gz69cDyC9WtTsXNf35tCFby6EHLgSBYpka0WejVj7n283BJ4ahC
   4Jvk7wju9cHlSVKShS03ninQ9G2vkBNWG2MM4T8LdeGgZyPQRNMSOidJf
   UY+YwSb9U4d3BsI0sVrf7o4eTfIrwxsyrl4AGuMJOa4jNRcufvhyJU144
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254924032"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254924032"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="691839929"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:42:56 -0700
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
Subject: [PATCH RFC 06/11] iommu/sva: Use attach/detach_pasid_dev in SVA interfaces
Date:   Sun, 20 Mar 2022 14:40:25 +0800
Message-Id: <20220320064030.2936936-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
 include/linux/iommu.h         |  46 +++++++++-------
 drivers/iommu/iommu-sva-lib.c | 100 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |  92 -------------------------------
 3 files changed, 125 insertions(+), 113 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e51845b9a146..1c7db6a94022 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -629,6 +629,8 @@ struct iommu_fwspec {
  */
 struct iommu_sva {
 	struct device			*dev;
+	ioasid_t			pasid;
+	struct iommu_domain		*domain;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
@@ -671,12 +673,6 @@ int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
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
 
@@ -1014,21 +1010,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
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
@@ -1070,6 +1051,29 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
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
index 106506143896..47cf98e661ff 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -3,6 +3,8 @@
  * Helpers for IOMMU drivers implementing SVA
  */
 #include <linux/mutex.h>
+#include <linux/iommu.h>
+#include <linux/slab.h>
 #include <linux/sched/mm.h>
 
 #include "iommu-sva-lib.h"
@@ -69,3 +71,101 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
 	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
+
+static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev)
+{
+	struct bus_type *bus = dev->bus;
+	struct iommu_domain *domain;
+
+	if (!bus || !bus->iommu_ops)
+		return NULL;
+
+	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_SVA);
+	if (domain)
+		domain->type = IOMMU_DOMAIN_SVA;
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
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return ERR_PTR(-ENOMEM);
+
+	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
+	if (ret)
+		goto out;
+
+	domain = iommu_sva_domain_alloc(dev);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	domain->sva_cookie = mm;
+
+	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
+	if (ret)
+		goto out_free_domain;
+
+	handle->dev = dev;
+	handle->domain = domain;
+	handle->pasid = mm->pasid;
+
+	return handle;
+
+out_free_domain:
+	iommu_domain_free(domain);
+out:
+	kfree(handle);
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
+	struct iommu_domain *domain = handle->domain;
+	struct mm_struct *mm = domain->sva_cookie;
+
+	iommu_detach_device_pasid(domain, dev, mm->pasid);
+	iommu_domain_free(domain);
+	kfree(handle);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
+
+u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+{
+	return handle->pasid;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 78c71ee15f36..c0966fc9b686 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2706,98 +2706,6 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
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

