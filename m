Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761E6504A48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 02:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiDRAzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 20:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiDRAzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 20:55:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D09B13E3F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650243154; x=1681779154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TxQUqxgq0V80eGTV4OZaTU6ty6y55vZc2ZiNOlXdQXk=;
  b=EzLWYbqxziNN+IEulfR9o/UIq4E/9UwgTVTNzi7gPtaR6fPPngdedUXM
   W7K0yocOXhzPHXoSlfVTY7maMaIqj4tp5OK/VO4vNnJriR3VgyGQghrnz
   pbcbY+ZnKQWxCV4u47Ga/PbpPd/vpozRTFuj9B+NArkjvXGHLU6vozHHL
   6bbuFPjsHrg2rCnyajI8S4FirjUfHAyvJTVaFIYhOUZ5X77LAnER2oSp5
   CEZvL1pTxrHuDWPwTUjv3sHdPcw3PxH4Mt5EqnPzKDXVnfL4/SYcfsEFn
   /FeKgk2ZKALCHlsxilXjk5GHLezstMGGF3irZoukU015ywzJZXnfY5Rci
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245313207"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="245313207"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 17:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="701651274"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v8 01/11] iommu: Add DMA ownership management interfaces
Date:   Mon, 18 Apr 2022 08:49:50 +0800
Message-Id: <20220418005000.897664-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple devices may be placed in the same IOMMU group because they
cannot be isolated from each other. These devices must either be
entirely under kernel control or userspace control, never a mixture.

This adds dma ownership management in iommu core and exposes several
interfaces for the device drivers and the device userspace assignment
framework (i.e. VFIO), so that any conflict between user and kernel
controlled dma could be detected at the beginning.

The device driver oriented interfaces are,

	int iommu_device_use_default_domain(struct device *dev);
	void iommu_device_unuse_default_domain(struct device *dev);

By calling iommu_device_use_default_domain(), the device driver tells
the iommu layer that the device dma is handled through the kernel DMA
APIs. The iommu layer will manage the IOVA and use the default domain
for DMA address translation.

The device user-space assignment framework oriented interfaces are,

	int iommu_group_claim_dma_owner(struct iommu_group *group,
					void *owner);
	void iommu_group_release_dma_owner(struct iommu_group *group);
	bool iommu_group_dma_owner_claimed(struct iommu_group *group);

The device userspace assignment must be disallowed if the DMA owner
claiming interface returns failure.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/iommu.h |  31 +++++++++
 drivers/iommu/iommu.c | 153 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9208eca4b0d1..77972ef978b5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -675,6 +675,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 
+int iommu_device_use_default_domain(struct device *dev);
+void iommu_device_unuse_default_domain(struct device *dev);
+
+int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
+void iommu_group_release_dma_owner(struct iommu_group *group);
+bool iommu_group_dma_owner_claimed(struct iommu_group *group);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1031,6 +1038,30 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
 	return NULL;
 }
+
+static inline int iommu_device_use_default_domain(struct device *dev)
+{
+	return 0;
+}
+
+static inline void iommu_device_unuse_default_domain(struct device *dev)
+{
+}
+
+static inline int
+iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_group_release_dma_owner(struct iommu_group *group)
+{
+}
+
+static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
+{
+	return false;
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f2c45b85b9fc..eba8e8ccf19d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -48,6 +48,8 @@ struct iommu_group {
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
 	struct list_head entry;
+	unsigned int owner_cnt;
+	void *owner;
 };
 
 struct group_device {
@@ -294,7 +296,11 @@ int iommu_probe_device(struct device *dev)
 	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
 
-	if (group->default_domain) {
+	/*
+	 * If device joined an existing group which has been claimed, don't
+	 * attach the default domain.
+	 */
+	if (group->default_domain && !group->owner) {
 		ret = __iommu_attach_device(group->default_domain, dev);
 		if (ret) {
 			mutex_unlock(&group->mutex);
@@ -2109,7 +2115,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->default_domain && group->domain != group->default_domain)
+	if (group->domain && group->domain != group->default_domain)
 		return -EBUSY;
 
 	ret = __iommu_group_for_each_dev(group, domain,
@@ -2146,7 +2152,11 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (!group->default_domain) {
+	/*
+	 * If the group has been claimed already, do not re-attach the default
+	 * domain.
+	 */
+	if (!group->default_domain || group->owner) {
 		__iommu_group_for_each_dev(group, domain,
 					   iommu_group_do_detach_device);
 		group->domain = NULL;
@@ -3095,3 +3105,140 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	return ret;
 }
+
+/**
+ * iommu_device_use_default_domain() - Device driver wants to handle device
+ *                                     DMA through the kernel DMA API.
+ * @dev: The device.
+ *
+ * The device driver about to bind @dev wants to do DMA through the kernel
+ * DMA API. Return 0 if it is allowed, otherwise an error.
+ */
+int iommu_device_use_default_domain(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+	int ret = 0;
+
+	if (!group)
+		return 0;
+
+	mutex_lock(&group->mutex);
+	if (group->owner_cnt) {
+		if (group->domain != group->default_domain ||
+		    group->owner) {
+			ret = -EBUSY;
+			goto unlock_out;
+		}
+	}
+
+	group->owner_cnt++;
+
+unlock_out:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+
+/**
+ * iommu_device_unuse_default_domain() - Device driver stops handling device
+ *                                       DMA through the kernel DMA API.
+ * @dev: The device.
+ *
+ * The device driver doesn't want to do DMA through kernel DMA API anymore.
+ * It must be called after iommu_device_use_default_domain().
+ */
+void iommu_device_unuse_default_domain(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(dev);
+
+	if (!group)
+		return;
+
+	mutex_lock(&group->mutex);
+	if (!WARN_ON(!group->owner_cnt))
+		group->owner_cnt--;
+
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+
+/**
+ * iommu_group_claim_dma_owner() - Set DMA ownership of a group
+ * @group: The group.
+ * @owner: Caller specified pointer. Used for exclusive ownership.
+ *
+ * This is to support backward compatibility for vfio which manages
+ * the dma ownership in iommu_group level. New invocations on this
+ * interface should be prohibited.
+ */
+int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
+{
+	int ret = 0;
+
+	mutex_lock(&group->mutex);
+	if (group->owner_cnt) {
+		ret = -EPERM;
+		goto unlock_out;
+	} else {
+		if (group->domain && group->domain != group->default_domain) {
+			ret = -EBUSY;
+			goto unlock_out;
+		}
+
+		group->owner = owner;
+		if (group->domain)
+			__iommu_detach_group(group->domain, group);
+	}
+
+	group->owner_cnt++;
+unlock_out:
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
+
+/**
+ * iommu_group_release_dma_owner() - Release DMA ownership of a group
+ * @group: The group.
+ *
+ * Release the DMA ownership claimed by iommu_group_claim_dma_owner().
+ */
+void iommu_group_release_dma_owner(struct iommu_group *group)
+{
+	mutex_lock(&group->mutex);
+	if (WARN_ON(!group->owner_cnt || !group->owner))
+		goto unlock_out;
+
+	group->owner_cnt = 0;
+	/*
+	 * The UNMANAGED domain should be detached before all USER
+	 * owners have been released.
+	 */
+	if (!WARN_ON(group->domain) && group->default_domain)
+		__iommu_attach_group(group->default_domain, group);
+	group->owner = NULL;
+unlock_out:
+	mutex_unlock(&group->mutex);
+}
+EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
+
+/**
+ * iommu_group_dma_owner_claimed() - Query group dma ownership status
+ * @group: The group.
+ *
+ * This provides status query on a given group. It is racy and only for
+ * non-binding status reporting.
+ */
+bool iommu_group_dma_owner_claimed(struct iommu_group *group)
+{
+	unsigned int user;
+
+	mutex_lock(&group->mutex);
+	user = group->owner_cnt;
+	mutex_unlock(&group->mutex);
+
+	return user;
+}
+EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
-- 
2.25.1

