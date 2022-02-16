Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0679A4B7E31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbiBPCzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:55:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbiBPCzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:55:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD1DFCB55
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644980102; x=1676516102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XpIxu7uYd7PFgmPJeVxNoGIeAwpN+dcjvGXhEso3oLQ=;
  b=nBKFQ93K15Eko7Wa8SxQrfIB9Pl8Xl2Rm015TsEaUo1dYFlBk2pPXroJ
   FsLXygR7r2YBwu2yRgAv2Q1NUHIc0jXvDGrRpqu0QL4kvj/fdb2FcnVSk
   4hh7wG8PGG6l3OHfjX3VwFYcd6x3MP1+ldWE+lAzQaScPHNM2ap1+aJxh
   9wiqJnMFYMsLFHIq9c2PmvuyYO9+4pJaL10KSxqi0QBi0XxgsnCIpYbg/
   FgX8qpCY8gEM2Ur5Sn1d706kCYvp5VRnBIY/Z8hy8SbnVSUKCuzwblx5Z
   OidgokxIW7E0rtRDU8I92KPNIu8f2bWnDU9oBb3uQ/nGAJxx09jQgrc9a
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="336940663"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="336940663"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="681312561"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 18:54:57 -0800
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
Subject: [PATCH v4 8/9] iommu: Remove unused argument in is_attach_deferred
Date:   Wed, 16 Feb 2022 10:52:48 +0800
Message-Id: <20220216025249.3459465-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
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

The is_attach_deferred iommu_ops callback is a device op. The domain
argument is unnecessary and never used. Remove it to make code clean.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/iommu.h         |  2 +-
 drivers/iommu/amd/amd_iommu.h |  3 +--
 drivers/iommu/amd/iommu.c     |  3 +--
 drivers/iommu/amd/iommu_v2.c  |  2 +-
 drivers/iommu/intel/iommu.c   |  3 +--
 drivers/iommu/iommu.c         | 15 ++++++---------
 6 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 90f1b5e3809d..1ded6076a75c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -269,7 +269,7 @@ struct iommu_ops {
 	void (*put_resv_regions)(struct device *dev, struct list_head *list);
 
 	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
-	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
+	bool (*is_attach_deferred)(struct device *dev);
 
 	/* Per device IOMMU features */
 	bool (*dev_has_feat)(struct device *dev, enum iommu_dev_features f);
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bb95edf74415..982798c7a3c8 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -117,8 +117,7 @@ void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
 
 
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
-extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
-					 struct device *dev);
+extern bool amd_iommu_is_attach_deferred(struct device *dev);
 extern int __init add_special_device(u8 type, u8 id, u16 *devid,
 				     bool cmd_line);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a18b549951bb..7e4e82158a80 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2221,8 +2221,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	list_add_tail(&region->list, head);
 }
 
-bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
-				  struct device *dev)
+bool amd_iommu_is_attach_deferred(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 58da08cc3d01..7c94ec05d289 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -537,7 +537,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	ret = NOTIFY_DONE;
 
 	/* In kdump kernel pci dev is not initialized yet -> send INVALID */
-	if (amd_iommu_is_attach_deferred(NULL, &pdev->dev)) {
+	if (amd_iommu_is_attach_deferred(&pdev->dev)) {
 		amd_iommu_complete_ppr(pdev, iommu_fault->pasid,
 				       PPR_INVALID, tag);
 		goto out;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2b5f4e57a8bb..80f1294be634 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5052,8 +5052,7 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 	}
 }
 
-static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
-					   struct device *dev)
+static bool intel_iommu_is_attach_deferred(struct device *dev)
 {
 	return attach_deferred(dev);
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7af0ee670deb..27276421d253 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -831,13 +831,12 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 	return ret;
 }
 
-static bool iommu_is_attach_deferred(struct iommu_domain *domain,
-				     struct device *dev)
+static bool iommu_is_attach_deferred(struct device *dev)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	if (ops->is_attach_deferred)
-		return ops->is_attach_deferred(domain, dev);
+		return ops->is_attach_deferred(dev);
 
 	return false;
 }
@@ -894,7 +893,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
-	if (group->domain  && !iommu_is_attach_deferred(group->domain, dev))
+	if (group->domain  && !iommu_is_attach_deferred(dev))
 		ret = __iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
@@ -1745,7 +1744,7 @@ static int iommu_group_do_dma_attach(struct device *dev, void *data)
 	struct iommu_domain *domain = data;
 	int ret = 0;
 
-	if (!iommu_is_attach_deferred(domain, dev))
+	if (!iommu_is_attach_deferred(dev))
 		ret = __iommu_attach_device(domain, dev);
 
 	return ret;
@@ -2020,9 +2019,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
 
 int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 {
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-
-	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
+	if (iommu_is_attach_deferred(dev))
 		return __iommu_attach_device(domain, dev);
 
 	return 0;
@@ -2031,7 +2028,7 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 static void __iommu_detach_device(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	if (iommu_is_attach_deferred(domain, dev))
+	if (iommu_is_attach_deferred(dev))
 		return;
 
 	if (unlikely(domain->ops->detach_dev == NULL))
-- 
2.25.1

