Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6204B3F16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 02:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiBNB57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 20:57:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbiBNB5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 20:57:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD75532FA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 17:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644803867; x=1676339867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSq/mIL6JZbJ/Ks58W4o4yuQUpHdn2gRwhbH1yixEeE=;
  b=FXPXcG92WAcUQ3hu4H6sQN5P3t4ZwxTJ3otVXSmHFDs+wjf9e/yhy8GJ
   1daVeYhPijROGHLx1N+YR/QcHLdWr5WB72g3TCH3yH2cps2s4bd3m48QZ
   FxIYc2RbcKTzYtmnFVLBxWA2Cb7Zyi+xkz0ETg9YcheqWnKaD2mGeNKH8
   GMFFcV5RFSA2Yw4ZNX639w/r3vgR7avUBtDO6/QllaoizbzN43lUJlHoy
   afpsYCirogAQ9qB8E0yWQgzelHOjE/G/ZtMgkFYu7s13sFSJ2RDN024LM
   mOOUuOWEt3oDxPcFb1BsYr9TMBhvnUpDuUUfNwQVT/UQGJODR33y4PV7O
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="248823693"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="248823693"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 17:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="680137263"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2022 17:57:42 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 04/10] iommu: Remove aux-domain related interfaces and iommu_ops
Date:   Mon, 14 Feb 2022 09:55:32 +0800
Message-Id: <20220214015538.2828933-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aux-domain related interfaces and iommu_ops are not referenced
anywhere in the tree. We've also reached a consensus to redesign it
based the new iommufd framework. Remove them to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/iommu.h | 29 ---------------------------
 drivers/iommu/iommu.c | 46 -------------------------------------------
 2 files changed, 75 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cde1d0aad60f..9983a01373b2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -144,7 +144,6 @@ struct iommu_resv_region {
 
 /**
  * enum iommu_dev_features - Per device IOMMU features
- * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
  * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
  * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
  *			 enabling %IOMMU_DEV_FEAT_SVA requires
@@ -157,7 +156,6 @@ struct iommu_resv_region {
  * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
  */
 enum iommu_dev_features {
-	IOMMU_DEV_FEAT_AUX,
 	IOMMU_DEV_FEAT_SVA,
 	IOMMU_DEV_FEAT_IOPF,
 };
@@ -223,8 +221,6 @@ struct iommu_iotlb_gather {
  * @dev_has/enable/disable_feat: per device entries to check/enable/disable
  *                               iommu specific features.
  * @dev_feat_enabled: check enabled feature
- * @aux_attach/detach_dev: aux-domain specific attach/detach entries.
- * @aux_get_pasid: get the pasid given an aux-domain
  * @sva_bind: Bind process address space to device
  * @sva_unbind: Unbind process address space from device
  * @sva_get_pasid: Get PASID associated to a SVA handle
@@ -285,11 +281,6 @@ struct iommu_ops {
 	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
 
-	/* Aux-domain specific attach/detach entries */
-	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
-	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
-
 	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
 				      void *drvdata);
 	void (*sva_unbind)(struct iommu_sva *handle);
@@ -655,9 +646,6 @@ void iommu_release_device(struct device *dev);
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
 bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
-int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev);
-void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
-int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm,
@@ -1002,23 +990,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
-static inline int
-iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
-{
-	return -ENODEV;
-}
-
-static inline void
-iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
-{
-}
-
-static inline int
-iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
-{
-	return -ENODEV;
-}
-
 static inline struct iommu_sva *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3cbf4781e5bd..0ebaf561a70e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2749,8 +2749,6 @@ EXPORT_SYMBOL_GPL(iommu_dev_enable_feature);
 
 /*
  * The device drivers should do the necessary cleanups before calling this.
- * For example, before disabling the aux-domain feature, the device driver
- * should detach all aux-domains. Otherwise, this will return -EBUSY.
  */
 int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 {
@@ -2778,50 +2776,6 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
 }
 EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
 
-/*
- * Aux-domain specific attach/detach.
- *
- * Only works if iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX) returns
- * true. Also, as long as domains are attached to a device through this
- * interface, any tries to call iommu_attach_device() should fail
- * (iommu_detach_device() can't fail, so we fail when trying to re-attach).
- * This should make us safe against a device being attached to a guest as a
- * whole while there are still pasid users on it (aux and sva).
- */
-int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (domain->ops->aux_attach_dev)
-		ret = domain->ops->aux_attach_dev(domain, dev);
-
-	if (!ret)
-		trace_attach_device_to_domain(dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_aux_attach_device);
-
-void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev)
-{
-	if (domain->ops->aux_detach_dev) {
-		domain->ops->aux_detach_dev(domain, dev);
-		trace_detach_device_from_domain(dev);
-	}
-}
-EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
-
-int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (domain->ops->aux_get_pasid)
-		ret = domain->ops->aux_get_pasid(domain, dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
-
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
-- 
2.25.1

