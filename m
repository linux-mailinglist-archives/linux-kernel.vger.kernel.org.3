Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8064053F3A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiFGByQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiFGByK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:54:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C649C7CB2C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654566846; x=1686102846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EsVpPZ9MnHZsxncCMiZw8qfuJkjqsOQgb35Fw6H5c3E=;
  b=gB+LKbn+mCCSjAQxq92QrzXZ1wqhXKm8jA3AdObu7fnWTjSk0QYN86UH
   krox48FmLHYapRNGZoxyRv4UXHYXK41SEalhZYykw2AVaVTXHfGABeaPc
   /uUMj8HD/2C7bNnxNYIUP/UOi/dJ5dnXNNpVE5m2Rr6Sql0yCUQBvk2I3
   iZdg/loUfET+16r5irL1d0AlBdfMq0ZzzBWWTInWNZLFS8lGcylRZzWNt
   rywIMttIze/+wBRIq7GSlIGmcnG3jldCiwbdG/2I5hvWFH2+US76YOUsA
   D/UumsGUcz44q8EwQvJEx17ZAeX3gvSrHVR9UubiyW7GIBypajKNsv5N0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="302064146"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="302064146"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="635886286"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2022 18:54:02 -0700
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v8 08/11] iommu: Remove SVA related callbacks from iommu ops
Date:   Tue,  7 Jun 2022 09:49:39 +0800
Message-Id: <20220607014942.3954894-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These ops'es have been replaced with the dev_attach/detach_pasid domain
ops'es. There's no need for them anymore. Remove them to avoid dead
code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/intel-iommu.h                   |  3 --
 include/linux/iommu.h                         |  7 ---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 16 ------
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 40 ---------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 --
 drivers/iommu/intel/iommu.c                   |  3 --
 drivers/iommu/intel/svm.c                     | 49 -------------------
 7 files changed, 121 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 9007428a68f1..5bd19c95a926 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -738,9 +738,6 @@ struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
 extern void intel_svm_check(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
 extern int intel_svm_finish_prq(struct intel_iommu *iommu);
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm);
-void intel_svm_unbind(struct iommu_sva *handle);
-u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(void);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 04d3da546eee..fcdde6dd28c9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -227,9 +227,6 @@ struct iommu_iotlb_gather {
  * @dev_has/enable/disable_feat: per device entries to check/enable/disable
  *                               iommu specific features.
  * @dev_feat_enabled: check enabled feature
- * @sva_bind: Bind process address space to device
- * @sva_unbind: Unbind process address space from device
- * @sva_get_pasid: Get PASID associated to a SVA handle
  * @page_response: handle page request response
  * @def_domain_type: device default domain type, return value:
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
@@ -263,10 +260,6 @@ struct iommu_ops {
 	int (*dev_enable_feat)(struct device *dev, enum iommu_dev_features f);
 	int (*dev_disable_feat)(struct device *dev, enum iommu_dev_features f);
 
-	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm);
-	void (*sva_unbind)(struct iommu_sva *handle);
-	u32 (*sva_get_pasid)(struct iommu_sva *handle);
-
 	int (*page_response)(struct device *dev,
 			     struct iommu_fault_event *evt,
 			     struct iommu_page_response *msg);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 96399dd3a67a..15dd4c7e6d3a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -754,9 +754,6 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
-struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
-void arm_smmu_sva_unbind(struct iommu_sva *handle);
-u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
 struct iommu_domain *arm_smmu_sva_domain_alloc(void);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
@@ -790,19 +787,6 @@ static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master
 	return false;
 }
 
-static inline struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
-{
-	return ERR_PTR(-ENODEV);
-}
-
-static inline void arm_smmu_sva_unbind(struct iommu_sva *handle) {}
-
-static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
-{
-	return IOMMU_PASID_INVALID;
-}
-
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
 
 static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 0af86e31e674..05973ada63c2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -344,11 +344,6 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	if (!bond)
 		return ERR_PTR(-ENOMEM);
 
-	/* Allocate a PASID for this mm if necessary */
-	ret = iommu_sva_alloc_pasid(mm, 1, (1U << master->ssid_bits) - 1);
-	if (ret)
-		goto err_free_bond;
-
 	bond->mm = mm;
 	bond->sva.dev = dev;
 	refcount_set(&bond->refs, 1);
@@ -367,41 +362,6 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 	return ERR_PTR(ret);
 }
 
-struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
-{
-	struct iommu_sva *handle;
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-
-	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&sva_lock);
-	handle = __arm_smmu_sva_bind(dev, mm);
-	mutex_unlock(&sva_lock);
-	return handle;
-}
-
-void arm_smmu_sva_unbind(struct iommu_sva *handle)
-{
-	struct arm_smmu_bond *bond = sva_to_bond(handle);
-
-	mutex_lock(&sva_lock);
-	if (refcount_dec_and_test(&bond->refs)) {
-		list_del(&bond->list);
-		arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		kfree(bond);
-	}
-	mutex_unlock(&sva_lock);
-}
-
-u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
-{
-	struct arm_smmu_bond *bond = sva_to_bond(handle);
-
-	return bond->mm->pasid;
-}
-
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
 	unsigned long reg, fld;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a30b252e2f95..8b9b78c7a67d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2855,9 +2855,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
-	.sva_bind		= arm_smmu_sva_bind,
-	.sva_unbind		= arm_smmu_sva_unbind,
-	.sva_get_pasid		= arm_smmu_sva_get_pasid,
 	.page_response		= arm_smmu_page_response,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 	.owner			= THIS_MODULE,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 993a1ce509a8..37d68eda1889 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4921,9 +4921,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.pgsize_bitmap		= SZ_4K,
 #ifdef CONFIG_INTEL_IOMMU_SVM
-	.sva_bind		= intel_svm_bind,
-	.sva_unbind		= intel_svm_unbind,
-	.sva_get_pasid		= intel_svm_get_pasid,
 	.page_response		= intel_svm_page_response,
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 6def2fdcc862..1fd019043e71 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -313,14 +313,6 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	return 0;
 }
 
-static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
-{
-	ioasid_t max_pasid = dev_is_pci(dev) ?
-			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
-
-	return iommu_sva_alloc_pasid(mm, PASID_MIN, max_pasid - 1);
-}
-
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
 					   struct mm_struct *mm)
@@ -809,47 +801,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	return IRQ_RETVAL(handled);
 }
 
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm)
-{
-	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
-	struct iommu_sva *sva;
-	int ret;
-
-	mutex_lock(&pasid_mutex);
-	ret = intel_svm_alloc_pasid(dev, mm);
-	if (ret) {
-		mutex_unlock(&pasid_mutex);
-		return ERR_PTR(ret);
-	}
-
-	sva = intel_svm_bind_mm(iommu, dev, mm);
-	mutex_unlock(&pasid_mutex);
-
-	return sva;
-}
-
-void intel_svm_unbind(struct iommu_sva *sva)
-{
-	struct intel_svm_dev *sdev = to_intel_svm_dev(sva);
-
-	mutex_lock(&pasid_mutex);
-	intel_svm_unbind_mm(sdev->dev, sdev->pasid);
-	mutex_unlock(&pasid_mutex);
-}
-
-u32 intel_svm_get_pasid(struct iommu_sva *sva)
-{
-	struct intel_svm_dev *sdev;
-	u32 pasid;
-
-	mutex_lock(&pasid_mutex);
-	sdev = to_intel_svm_dev(sva);
-	pasid = sdev->pasid;
-	mutex_unlock(&pasid_mutex);
-
-	return pasid;
-}
-
 int intel_svm_page_response(struct device *dev,
 			    struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg)
-- 
2.25.1

