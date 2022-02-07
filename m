Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA43D4AB55C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbiBGG5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357835AbiBGGoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:44:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C6C043187
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216260; x=1675752260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6WtSTQdjRD4wi8NPB/wH0EeILHtZl3dydvFj3GNNpHk=;
  b=NN1f/sPU7usXw7MPT8L/xf2ghf2katrlmVLV9jMGZA8jsLc/nZv3e6XS
   wm46sgJ+PQdCK1gTtNRtG9VUVDpML+NG3l0lM08d4Vh5XrplyWrkgwAdf
   2DlqqH0LTjvuxIfD0HlO677bXEUNkuVOG6vP9AH0J0IeoZ0FFEGL/YVKP
   WdQ8wDHDHCjIM7BM2usf2NRGa89gZ2sNohWyx6i6LbMaovynBEgJQ1hjR
   CLU7Hxrv69BWoZtZ9KbCkeXc+Gj2ZFrrUvOVupy/RhKwnets5KtyWqL9M
   37h9i8zfREJ7a67sOCQ2XIXEXXpmjDIRAeZWqqNq8sSTX/2jboFAd69NB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273171187"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273171187"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:43:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525020280"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:15 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 06/10] iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
Date:   Mon,  7 Feb 2022 14:41:38 +0800
Message-Id: <20220207064142.1092846-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate and set the per-device iommu private data during iommu device
probe. Add a flag to indicate whether default domain attachment is
deferred. With this refactoring, the dummy DEFER_DEVICE_DOMAIN_INFO
pointer is removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 122 +++++++++++++++---------------------
 1 file changed, 51 insertions(+), 71 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 185aa38df602..165c890b8304 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -309,19 +309,9 @@ static int iommu_skip_te_disable;
 int intel_iommu_gfx_mapped;
 EXPORT_SYMBOL_GPL(intel_iommu_gfx_mapped);
 
-#define DEFER_DEVICE_DOMAIN_INFO ((struct device_domain_info *)(-2))
 struct device_domain_info *get_domain_info(struct device *dev)
 {
-	struct device_domain_info *info;
-
-	if (!dev)
-		return NULL;
-
-	info = dev_iommu_priv_get(dev);
-	if (unlikely(info == DEFER_DEVICE_DOMAIN_INFO))
-		return NULL;
-
-	return info;
+	return dev_iommu_priv_get(dev);
 }
 
 DEFINE_SPINLOCK(device_domain_lock);
@@ -708,11 +698,6 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 	return &context[devfn];
 }
 
-static bool attach_deferred(struct device *dev)
-{
-	return dev_iommu_priv_get(dev) == DEFER_DEVICE_DOMAIN_INFO;
-}
-
 /**
  * is_downstream_to_pci_bridge - test if a device belongs to the PCI
  *				 sub-hierarchy of a candidate PCI-PCI bridge
@@ -2426,9 +2411,6 @@ struct dmar_domain *find_domain(struct device *dev)
 	if (unlikely(!dev || !dev->iommu))
 		return NULL;
 
-	if (unlikely(attach_deferred(dev)))
-		return NULL;
-
 	/* No lock here, assumes no domain exit in normal case */
 	info = get_domain_info(dev);
 	if (likely(info))
@@ -2497,66 +2479,20 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    struct device *dev,
 						    struct dmar_domain *domain)
 {
-	struct device_domain_info *info;
+	struct device_domain_info *info = get_domain_info(dev);
 	unsigned long flags;
 	int ret;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return NULL;
-
-	if (!dev_is_real_dma_subdevice(dev)) {
-		info->bus = bus;
-		info->devfn = devfn;
-		info->segment = iommu->segment;
-	} else {
-		struct pci_dev *pdev = to_pci_dev(dev);
-
-		info->bus = pdev->bus->number;
-		info->devfn = pdev->devfn;
-		info->segment = pci_domain_nr(pdev->bus);
-	}
-
-	info->dev = dev;
-	info->domain = domain;
-	info->iommu = iommu;
-
-	if (dev && dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(info->dev);
-
-		if (ecap_dev_iotlb_support(iommu->ecap) &&
-		    pci_ats_supported(pdev) &&
-		    dmar_find_matched_atsr_unit(pdev))
-			info->ats_supported = 1;
-
-		if (sm_supported(iommu)) {
-			if (pasid_supported(iommu)) {
-				int features = pci_pasid_features(pdev);
-				if (features >= 0)
-					info->pasid_supported = features | 1;
-			}
-
-			if (info->ats_supported && ecap_prs(iommu->ecap) &&
-			    pci_pri_supported(pdev))
-				info->pri_supported = 1;
-		}
-	}
-
 	spin_lock_irqsave(&device_domain_lock, flags);
+	info->domain = domain;
 	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
 	spin_unlock(&iommu->lock);
-
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
-		kfree(info);
 		return NULL;
 	}
-
 	list_add(&info->link, &domain->devices);
-	list_add(&info->global, &device_domain_list);
-	if (dev)
-		dev_iommu_priv_set(dev, info);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
@@ -4405,14 +4341,56 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 
 static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 {
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
+	struct device_domain_info *info;
 	struct intel_iommu *iommu;
+	unsigned long flags;
+	u8 bus, devfn;
 
-	iommu = device_to_iommu(dev, NULL, NULL);
+	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
-	if (translation_pre_enabled(iommu))
-		dev_iommu_priv_set(dev, DEFER_DEVICE_DOMAIN_INFO);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	if (dev_is_real_dma_subdevice(dev)) {
+		info->bus = pdev->bus->number;
+		info->devfn = pdev->devfn;
+		info->segment = pci_domain_nr(pdev->bus);
+	} else {
+		info->bus = bus;
+		info->devfn = devfn;
+		info->segment = iommu->segment;
+	}
+
+	info->dev = dev;
+	info->iommu = iommu;
+	if (dev_is_pci(dev)) {
+		if (ecap_dev_iotlb_support(iommu->ecap) &&
+		    pci_ats_supported(pdev) &&
+		    dmar_find_matched_atsr_unit(pdev))
+			info->ats_supported = 1;
+
+		if (sm_supported(iommu)) {
+			if (pasid_supported(iommu)) {
+				int features = pci_pasid_features(pdev);
+
+				if (features >= 0)
+					info->pasid_supported = features | 1;
+			}
+
+			if (info->ats_supported && ecap_prs(iommu->ecap) &&
+			    pci_pri_supported(pdev))
+				info->pri_supported = 1;
+		}
+	}
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	list_add(&info->global, &device_domain_list);
+	dev_iommu_priv_set(dev, info);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
 
 	return &iommu->iommu;
 }
@@ -4635,7 +4613,9 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
 
 static bool intel_iommu_is_attach_deferred(struct device *dev)
 {
-	return attach_deferred(dev);
+	struct device_domain_info *info = get_domain_info(dev);
+
+	return translation_pre_enabled(info->iommu) && !info->domain;
 }
 
 /*
-- 
2.25.1

