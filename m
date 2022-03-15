Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B824D939C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344859AbiCOFMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344845AbiCOFMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:12:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1B149240
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647321068; x=1678857068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A38Y0t7PfbeOjDPwxZIh5wdCYYvnUSyCF8g2Op2aXRY=;
  b=ifXHBuiDQnzZnGwtooP5zzIPgbswZ1vUy1cGg849n2zhEYyPnvGYRQsr
   LR7xlr0XQzFCdbBTelC/w7HbzoImsx297aTbQfXG2e74wt12zIDrQLE2q
   bGkC4xPJoWcobgVK/LCuJZwZFDkr8/+RsLCOVKdQnWDTqIMT1Za7OBqLz
   AjU3HYLm4uUtIvSvXSbCWmNsmi36UB4mR43UtKjNSsr1U/L0ZlFX0VZhL
   cH4W3iIjy7dcLBREtvQ+A783njVNf+zVQpwAaQIl2/vVDY0SlHGipAVDe
   gi8GFjTte4M4plhTTHs2+FQdXVZMDWxpGRnZk4+7XaaYALlIlQ25VqMmR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236159108"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="236159108"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="580383593"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:59 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 8/8] iommu: Remove unused driver data in sva_bind_device
Date:   Mon, 14 Mar 2022 22:07:12 -0700
Message-Id: <20220315050713.2000518-9-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one is using drvdata for sva_bind_device after kernel SVA support is
removed from VT-d driver. Remove the drvdata parameter as well.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/dma/idxd/cdev.c                         | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 ++---
 drivers/iommu/intel/svm.c                       | 9 ++++-----
 drivers/iommu/iommu.c                           | 4 ++--
 drivers/misc/uacce/uacce.c                      | 2 +-
 include/linux/intel-iommu.h                     | 3 +--
 include/linux/iommu.h                           | 9 +++------
 8 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index b9b2b4a4124e..312ec37ebf91 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -100,7 +100,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	filp->private_data = ctx;
 
 	if (device_pasid_enabled(idxd)) {
-		sva = iommu_sva_bind_device(dev, current->mm, NULL);
+		sva = iommu_sva_bind_device(dev, current->mm);
 		if (IS_ERR(sva)) {
 			rc = PTR_ERR(sva);
 			dev_err(dev, "pasid allocation failed: %d\n", rc);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index a737ba5f727e..eb2f5cb0701a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -354,7 +354,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 }
 
 struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 {
 	struct iommu_sva *handle;
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index cd48590ada30..d2ba86470c42 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -754,8 +754,7 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
 int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
 int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
 bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
-struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
-				    void *drvdata);
+struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
@@ -791,7 +790,7 @@ static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master
 }
 
 static inline struct iommu_sva *
-arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
 {
 	return ERR_PTR(-ENODEV);
 }
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 37d6218f173b..94deb58375f5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -500,8 +500,7 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
 	return ret;
 }
 
-static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
-				 unsigned int flags)
+static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
 {
 	ioasid_t max_pasid = dev_is_pci(dev) ?
 			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
@@ -1002,20 +1001,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 	return IRQ_RETVAL(handled);
 }
 
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct iommu_sva *sva;
 	int ret;
 
 	mutex_lock(&pasid_mutex);
-	ret = intel_svm_alloc_pasid(dev, mm, flags);
+	ret = intel_svm_alloc_pasid(dev, mm);
 	if (ret) {
 		mutex_unlock(&pasid_mutex);
 		return ERR_PTR(ret);
 	}
 
-	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
+	sva = intel_svm_bind_mm(iommu, dev, mm);
 	if (IS_ERR_OR_NULL(sva))
 		intel_svm_free_pasid(mm);
 	mutex_unlock(&pasid_mutex);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 107dcf5938d6..fef34879bc0c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3049,7 +3049,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
  * On error, returns an ERR_PTR value.
  */
 struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
 	struct iommu_group *group;
 	struct iommu_sva *handle = ERR_PTR(-EINVAL);
@@ -3074,7 +3074,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	if (iommu_group_device_count(group) != 1)
 		goto out_unlock;
 
-	handle = ops->sva_bind(dev, mm, drvdata);
+	handle = ops->sva_bind(dev, mm);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 281c54003edc..3238a867ea51 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -99,7 +99,7 @@ static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 	if (!(uacce->flags & UACCE_DEV_SVA))
 		return 0;
 
-	handle = iommu_sva_bind_device(uacce->parent, current->mm, NULL);
+	handle = iommu_sva_bind_device(uacce->parent, current->mm);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 3f4c98f170ec..9dc855d7479d 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -777,8 +777,7 @@ extern int intel_svm_finish_prq(struct intel_iommu *iommu);
 int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			  struct iommu_gpasid_bind_data *data);
 int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
-struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
-				 void *drvdata);
+struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm);
 void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index fb011722e4f8..b570b37181ad 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -294,9 +294,7 @@ struct iommu_ops {
 	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
-
-	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
-				      void *drvdata);
+	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm);
 	void (*sva_unbind)(struct iommu_sva *handle);
 	int (*attach_dev_pasid)(struct iommu_domain *domain,
 				struct device *dev, ioasid_t id);
@@ -705,8 +703,7 @@ void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
 int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
 
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm,
-					void *drvdata);
+					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 
@@ -1065,7 +1062,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
 }
 
 static inline struct iommu_sva *
-iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
+iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
 	return NULL;
 }
-- 
2.25.1

