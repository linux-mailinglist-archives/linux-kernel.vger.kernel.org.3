Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C346C792
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbhLGWim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:38:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:41972 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242249AbhLGWig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:38:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237509354"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237509354"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 14:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="515845500"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2021 14:35:04 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 3/4] iommu/vt-d: Support PASID DMA for in-kernel usage
Date:   Tue,  7 Dec 2021 05:47:13 -0800
Message-Id: <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between DMA requests with and without PASID (legacy), DMA mapping APIs
are used indiscriminately on a device. Therefore, we should always match
the addressing mode of the legacy DMA when enabling kernel PASID.

This patch adds support for VT-d driver where the kernel PASID is
programmed to match RIDPASID. i.e. if the device is in pass-through, the
kernel PASID is also in pass-through; if the device is in IOVA mode, the
kernel PASID will also be using the same IOVA space.

There is additional handling for IOTLB and device TLB flush w.r.t. the
kernel PASID. On VT-d, PASID-selective IOTLB flush is also on a
per-domain basis; whereas device TLB flush is per device. Note that
IOTLBs are used even when devices are in pass-through mode. ATS is
enabled device-wide, but the device drivers can choose to manage ATS at
per PASID level whenever control is available.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 105 +++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel/pasid.c |   7 +++
 include/linux/intel-iommu.h |   3 +-
 3 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 60253bc436bb..a2ef6b9e4bfc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1743,7 +1743,14 @@ static void domain_flush_piotlb(struct intel_iommu *iommu,
 	if (domain->default_pasid)
 		qi_flush_piotlb(iommu, did, domain->default_pasid,
 				addr, npages, ih);
-
+	if (domain->kernel_pasid && !domain_type_is_si(domain)) {
+		/*
+		 * REVISIT: we only do PASID IOTLB inval for FL, we could have SL
+		 * for PASID in the future such as vIOMMU PT. this doesn't get hit.
+		 */
+		qi_flush_piotlb(iommu, did, domain->kernel_pasid,
+				addr, npages, ih);
+	}
 	if (!list_empty(&domain->devices))
 		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, npages, ih);
 }
@@ -5695,6 +5702,100 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	}
 }
 
+static int intel_enable_pasid_dma(struct device *dev, u32 pasid)
+{
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct device_domain_info *info;
+	unsigned long flags;
+	int ret = 0;
+
+	info = get_domain_info(dev);
+	if (!info)
+		return -ENODEV;
+
+	if (!dev_is_pci(dev) || !sm_supported(info->iommu))
+		return -EINVAL;
+
+	if (intel_iommu_enable_pasid(info->iommu, dev))
+		return -ENODEV;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&iommu->lock);
+	/*
+	 * Store PASID for IOTLB flush, but only needed for non-passthrough
+	 * unmap case. For passthrough, we only need to do IOTLB flush during
+	 * PASID teardown. Flush covers all devices in the same domain as the
+	 * domain ID is the same for the same SL.
+	 */
+	info->domain->kernel_pasid = pasid;
+
+	/*
+	 * Tracks how many attached devices are using the kernel PASID. Clear
+	 * the domain kernel PASID when all users called disable_pasid_dma().
+	 */
+	atomic_inc(&info->domain->kernel_pasid_user);
+
+	/*
+	 * Addressing modes (IOVA vs. PA) is a per device choice made by the
+	 * platform code. We must treat legacy DMA (request w/o PASID) and
+	 * DMA w/ PASID identially in terms of mapping. Here we just set up
+	 * the kernel PASID to match the mapping of RID2PASID/PASID0.
+	 */
+	if (hw_pass_through && domain_type_is_si(info->domain)) {
+		ret = intel_pasid_setup_pass_through(info->iommu, info->domain,
+						dev, pasid);
+		if (ret)
+			dev_err(dev, "Failed kernel PASID %d in BYPASS", pasid);
+
+	} else if (domain_use_first_level(info->domain)) {
+		/* We are using FL for IOVA, this is the default option */
+		ret = domain_setup_first_level(info->iommu, info->domain, dev,
+					       pasid);
+		if (ret)
+			dev_err(dev, "Failed kernel PASID %d IOVA FL", pasid);
+	} else {
+		ret = intel_pasid_setup_second_level(info->iommu, info->domain,
+						     dev, pasid);
+		if (ret)
+			dev_err(dev, "Failed kernel SPASID %d IOVA SL", pasid);
+	}
+
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	return ret;
+}
+
+static int intel_disable_pasid_dma(struct device *dev)
+{
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct device_domain_info *info;
+	unsigned long flags;
+	int ret = 0;
+
+	info = get_domain_info(dev);
+	if (!info)
+		return -ENODEV;
+
+	if (!dev_is_pci(dev) || !sm_supported(info->iommu))
+		return -EINVAL;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	spin_lock(&iommu->lock);
+
+	/* Tear down kernel PASID for this device */
+	intel_pasid_tear_down_entry(info->iommu, info->dev,
+				    info->domain->kernel_pasid,
+				    false);
+	/* Clear the domain kernel PASID when there is no users */
+	if (atomic_dec_and_test(&info->domain->kernel_pasid_user))
+		info->domain->kernel_pasid = 0;
+
+	spin_unlock(&iommu->lock);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+	return ret;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -5732,6 +5833,8 @@ const struct iommu_ops intel_iommu_ops = {
 	.sva_get_pasid		= intel_svm_get_pasid,
 	.page_response		= intel_svm_page_response,
 #endif
+	.enable_pasid_dma	= intel_enable_pasid_dma,
+	.disable_pasid_dma	= intel_disable_pasid_dma,
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 07c390aed1fe..24e889612357 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -505,6 +505,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 	else
 		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+	/*
+	 * Flush the kernel PASID if used by the device. This is the case where
+	 * a device driver uses IOVA via DMA map APIs for request with PASID.
+	 */
+	if (dev->pasid)
+		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, dev->pasid, qdep, 0,
+					 64 - VTD_PAGE_SHIFT);
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index fe9fd417d611..6725a0ddfc6a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -567,7 +567,8 @@ struct dmar_domain {
 					 * The default pasid used for non-SVM
 					 * traffic on mediated devices.
 					 */
-
+	u32		kernel_pasid;	/* for in-kernel DMA w/ PASID */
+	atomic_t	kernel_pasid_user; /* count of kernel_pasid users */
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
 };
-- 
2.25.1

