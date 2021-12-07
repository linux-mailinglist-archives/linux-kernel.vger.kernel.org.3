Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1962446C78F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbhLGWii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:38:38 -0500
Received: from mga09.intel.com ([134.134.136.24]:41972 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242113AbhLGWie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:38:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237509348"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237509348"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 14:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="515845489"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2021 14:35:03 -0800
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
Subject: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Date:   Tue,  7 Dec 2021 05:47:11 -0800
Message-Id: <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-kernel DMA is managed by DMA mapping APIs, which supports per device
addressing mode for legacy DMA requests. With the introduction of
Process Address Space ID (PASID), device DMA can now target at a finer
granularity per PASID + Requester ID (RID).

However, for in-kernel DMA there is no need to differentiate between
legacy DMA and DMA with PASID in terms of mapping. DMA address mapping
for RID+PASID can be made identical to the RID. The benefit for the
drivers is the continuation of DMA mapping APIs without change.

This patch reserves a special IOASID for devices that perform in-kernel
DMA requests with PASID. This global IOASID is excluded from the
IOASID allocator. The analogous case is PASID #0, a special PASID
reserved for DMA requests without PASID (legacy). We could have different
kernel PASIDs for individual devices, but for simplicity reasons, a
globally reserved one will fit the bill.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/intel/iommu.c                     | 4 ++--
 drivers/iommu/intel/pasid.h                     | 3 +--
 drivers/iommu/intel/svm.c                       | 2 +-
 drivers/iommu/ioasid.c                          | 2 ++
 include/linux/ioasid.h                          | 4 ++++
 6 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index ee66d1f4cb81..ac79a37ffe06 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -329,7 +329,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 		return ERR_PTR(-ENOMEM);
 
 	/* Allocate a PASID for this mm if necessary */
-	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
+	ret = iommu_sva_alloc_pasid(mm, IOASID_ALLOC_BASE, (1U << master->ssid_bits) - 1);
 	if (ret)
 		goto err_free_bond;
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6afb4d4e09ef..60253bc436bb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3253,7 +3253,7 @@ static ioasid_t intel_vcmd_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
 	 * PASID range. Host can partition guest PASID range based on
 	 * policies but it is out of guest's control.
 	 */
-	if (min < PASID_MIN || max > intel_pasid_max_id)
+	if (min < IOASID_ALLOC_BASE || max > intel_pasid_max_id)
 		return INVALID_IOASID;
 
 	if (vcmd_alloc_pasid(iommu, &ioasid))
@@ -4824,7 +4824,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 		u32 pasid;
 
 		/* No private data needed for the default pasid */
-		pasid = ioasid_alloc(NULL, PASID_MIN,
+		pasid = ioasid_alloc(NULL, IOASID_ALLOC_BASE,
 				     pci_max_pasids(to_pci_dev(dev)) - 1,
 				     NULL);
 		if (pasid == INVALID_IOASID) {
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index d5552e2c160d..c3a714535c03 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -10,8 +10,7 @@
 #ifndef __INTEL_PASID_H
 #define __INTEL_PASID_H
 
-#define PASID_RID2PASID			0x0
-#define PASID_MIN			0x1
+#define PASID_RID2PASID			IOASID_DMA_NO_PASID
 #define PASID_MAX			0x100000
 #define PASID_PTE_MASK			0x3F
 #define PASID_PTE_PRESENT		1
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5b5d69b04fcc..95dcaf78c22c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -511,7 +511,7 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
 	ioasid_t max_pasid = dev_is_pci(dev) ?
 			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
 
-	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
+	return iommu_sva_alloc_pasid(mm, IOASID_ALLOC_BASE, max_pasid - 1);
 }
 
 static void intel_svm_free_pasid(struct mm_struct *mm)
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 50ee27bbd04e..89c6132bf1ec 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -317,6 +317,8 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	data->private = private;
 	refcount_set(&data->refs, 1);
 
+	if (min < IOASID_ALLOC_BASE)
+		min = IOASID_ALLOC_BASE;
 	/*
 	 * Custom allocator needs allocator data to perform platform specific
 	 * operations.
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e9dacd4b9f6b..4d435cbd48b8 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -6,6 +6,10 @@
 #include <linux/errno.h>
 
 #define INVALID_IOASID ((ioasid_t)-1)
+#define IOASID_DMA_NO_PASID	0 /* For DMA request w/o PASID */
+#define IOASID_DMA_PASID	1 /* For in-kernel DMA w/ PASID */
+#define IOASID_ALLOC_BASE	2 /* Start of the allocation */
+
 typedef unsigned int ioasid_t;
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
-- 
2.25.1

