Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52B567C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiGFDAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGFDAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:00:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED51BE8E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657076418; x=1688612418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hEpBYdeZhQy0F5FFGq2HaM1gLEXbenT6fwpuBylUe7A=;
  b=ZsmJPx/v2Rv1B0fNRNJzIBU5AsBjFTrvvBhTjAuRMOuCdBFnw1/jGsHM
   DJCbvFeYQQ+PlaIFDdvIX4sUA+ug99aEE6aarf1EgBadVwfs3m9jwEtjp
   IcNskI7xSF8OHmyA0zv8dsHtrsab5mFWqcVqu5G4bYeBpA6LgAYyMN56y
   h91BwvBdQO+LcQmhoPFwg5dhdYqgjR1v4CEn9RAbdP7DYS6N5ca8f5oSo
   w3ZJggsLpt6Bcj0JUw7pedICrLxgaFXMVvdxb3tkLz46QTRzIeKzB6esX
   tYdYGz0SrmkaUgOWpVI9xKaqrY/T8QDHSl9xiBl6v5Cbg90c2SxPBB1Du
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409601"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="272409601"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:00:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567875316"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 20:00:15 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 10/11] iommu/vt-d: Use device_domain_lock accurately
Date:   Wed,  6 Jul 2022 10:55:23 +0800
Message-Id: <20220706025524.2904370-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_domain_lock is used to protect the device tracking list of
a domain. Remove unnecessary spin_lock/unlock()'s and move the necessary
ones around the list access.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 57 +++++++++++++------------------------
 1 file changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 899ae63e1ddf..46991e313bf3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -535,15 +535,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	int nid = NUMA_NO_NODE;
 
-	assert_spin_locked(&device_domain_lock);
-
-	if (list_empty(&domain->devices))
-		return NUMA_NO_NODE;
-
+	spin_lock(&device_domain_lock);
 	list_for_each_entry(info, &domain->devices, link) {
-		if (!info->dev)
-			continue;
-
 		/*
 		 * There could possibly be multiple device numa nodes as devices
 		 * within the same domain may sit behind different IOMMUs. There
@@ -554,6 +547,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
 		if (nid != NUMA_NO_NODE)
 			break;
 	}
+	spin_unlock(&device_domain_lock);
 
 	return nid;
 }
@@ -1376,23 +1370,23 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
 }
 
 static struct device_domain_info *
-iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
-			 u8 bus, u8 devfn)
+iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
+			u8 bus, u8 devfn)
 {
 	struct device_domain_info *info;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!iommu->qi)
 		return NULL;
 
-	list_for_each_entry(info, &domain->devices, link)
+	spin_lock(&device_domain_lock);
+	list_for_each_entry(info, &domain->devices, link) {
 		if (info->iommu == iommu && info->bus == bus &&
 		    info->devfn == devfn) {
-			if (info->ats_supported && info->dev)
-				return info;
-			break;
+			spin_unlock(&device_domain_lock);
+			return info->ats_supported ? info : NULL;
 		}
+	}
+	spin_unlock(&device_domain_lock);
 
 	return NULL;
 }
@@ -1402,23 +1396,21 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 	struct device_domain_info *info;
 	bool has_iotlb_device = false;
 
-	assert_spin_locked(&device_domain_lock);
-
-	list_for_each_entry(info, &domain->devices, link)
+	spin_lock(&device_domain_lock);
+	list_for_each_entry(info, &domain->devices, link) {
 		if (info->ats_enabled) {
 			has_iotlb_device = true;
 			break;
 		}
-
+	}
 	domain->has_iotlb_device = has_iotlb_device;
+	spin_unlock(&device_domain_lock);
 }
 
 static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!info || !dev_is_pci(info->dev))
 		return;
 
@@ -1464,8 +1456,6 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	assert_spin_locked(&device_domain_lock);
-
 	if (!dev_is_pci(info->dev))
 		return;
 
@@ -1906,9 +1896,10 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct pasid_table *table,
 				      u8 bus, u8 devfn)
 {
+	struct device_domain_info *info =
+			iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 	u16 did = domain->iommu_did[iommu->seq_id];
 	int translation = CONTEXT_TT_MULTI_LEVEL;
-	struct device_domain_info *info = NULL;
 	struct context_entry *context;
 	int ret;
 
@@ -1922,9 +1913,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	BUG_ON(!domain->pgd);
 
-	spin_lock(&device_domain_lock);
 	spin_lock(&iommu->lock);
-
 	ret = -ENOMEM;
 	context = iommu_context_addr(iommu, bus, devfn, 1);
 	if (!context)
@@ -1975,7 +1964,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		 * Setup the Device-TLB enable bit and Page request
 		 * Enable bit:
 		 */
-		info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 		if (info && info->ats_supported)
 			context_set_sm_dte(context);
 		if (info && info->pri_supported)
@@ -1998,7 +1986,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 					goto out_unlock;
 			}
 
-			info = iommu_support_dev_iotlb(domain, iommu, bus, devfn);
 			if (info && info->ats_supported)
 				translation = CONTEXT_TT_DEV_IOTLB;
 			else
@@ -2044,7 +2031,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 out_unlock:
 	spin_unlock(&iommu->lock);
-	spin_unlock(&device_domain_lock);
 
 	return ret;
 }
@@ -2456,13 +2442,11 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	spin_lock(&device_domain_lock);
-	info->domain = domain;
 	ret = domain_attach_iommu(domain, iommu);
-	if (ret) {
-		spin_unlock(&device_domain_lock);
+	if (ret)
 		return ret;
-	}
+	info->domain = domain;
+	spin_lock(&device_domain_lock);
 	list_add(&info->link, &domain->devices);
 	spin_unlock(&device_domain_lock);
 
@@ -4637,9 +4621,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 	if (!domain)
 		return -EINVAL;
 
-	spin_lock(&device_domain_lock);
 	spin_lock(&iommu->lock);
-
 	ret = -EINVAL;
 	if (!info->pasid_supported)
 		goto out;
@@ -4669,7 +4651,6 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 
  out:
 	spin_unlock(&iommu->lock);
-	spin_unlock(&device_domain_lock);
 
 	return ret;
 }
-- 
2.25.1

