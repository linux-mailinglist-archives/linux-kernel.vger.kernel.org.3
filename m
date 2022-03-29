Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB4E4EA741
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiC2Fm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiC2FmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:42:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB123D45E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648532433; x=1680068433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rmTrrsN6o/iiXpbXXW5KgezOuk/1ln46uK9jx/UqwWI=;
  b=ca3Tq2SJasmqPILKPlagA7Pjsg3O9+Qr8ElOrr4038c6sJlmw+YT/u+V
   0nTbswk3XSw2FR+SxWW61sNfOSQzo7NGfO2rLYdrOn9eT0zLZe0pDAVsC
   f0Q1ULS/rTn0yv1kRzPLOTCd9xpfkcsLTSDR5hC5CabRCw6fsxwlWDQP+
   FwhHYIktN4EuvIKGeQJFjGcimq3KqVD7UE2jmwQS1YnmM+zaLY2EyLgDJ
   dyKKxRowEiF0gVn7uDYyXqHQuwwMShXEGgMXv+ufemgzMci9AMDYfhe5H
   BTJLqhChu1oEjXCDlosSW3U3NIOTjWQ3rnnSJOjoDV9c6iof02TcXVBGw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259136999"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="259136999"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:40:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="694603611"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:27 -0700
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
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH RFC v2 05/11] iommu/vt-d: Remove SVM_FLAG_SUPERVISOR_MODE suport
Date:   Tue, 29 Mar 2022 13:37:54 +0800
Message-Id: <20220329053800.3049561-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current in-kernel supervisor PASID support is based on the SVA
machinery in SVA lib. The binding between a kernel PASID and kernel
mapping has many flaws. Remove SVM_FLAG_SUPERVISOR_MODE support.

Link: https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 53 +++++++++------------------------------
 1 file changed, 12 insertions(+), 41 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d1c42dfae6ca..ee5ecde5b318 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -313,8 +313,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	return 0;
 }
 
-static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
-				 unsigned int flags)
+static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
 {
 	ioasid_t max_pasid = dev_is_pci(dev) ?
 			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
@@ -324,8 +323,7 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
 
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
-					   struct mm_struct *mm,
-					   unsigned int flags)
+					   struct mm_struct *mm)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	unsigned long iflags, sflags;
@@ -341,22 +339,18 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 
 		svm->pasid = mm->pasid;
 		svm->mm = mm;
-		svm->flags = flags;
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
-		if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
-			svm->notifier.ops = &intel_mmuops;
-			ret = mmu_notifier_register(&svm->notifier, mm);
-			if (ret) {
-				kfree(svm);
-				return ERR_PTR(ret);
-			}
+		svm->notifier.ops = &intel_mmuops;
+		ret = mmu_notifier_register(&svm->notifier, mm);
+		if (ret) {
+			kfree(svm);
+			return ERR_PTR(ret);
 		}
 
 		ret = pasid_private_add(svm->pasid, svm);
 		if (ret) {
-			if (svm->notifier.ops)
-				mmu_notifier_unregister(&svm->notifier, mm);
+			mmu_notifier_unregister(&svm->notifier, mm);
 			kfree(svm);
 			return ERR_PTR(ret);
 		}
@@ -391,9 +385,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	}
 
 	/* Setup the pasid table: */
-	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
-			PASID_FLAG_SUPERVISOR_MODE : 0;
-	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
+	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	sflags |= PASID_FLAG_PAGE_SNOOP;
 	spin_lock_irqsave(&iommu->lock, iflags);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
@@ -411,8 +403,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	kfree(sdev);
 free_svm:
 	if (list_empty(&svm->devs)) {
-		if (svm->notifier.ops)
-			mmu_notifier_unregister(&svm->notifier, mm);
+		mmu_notifier_unregister(&svm->notifier, mm);
 		pasid_private_remove(mm->pasid);
 		kfree(svm);
 	}
@@ -822,37 +813,17 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
-	unsigned int flags = 0;
 	struct iommu_sva *sva;
 	int ret;
 
-	if (drvdata)
-		flags = *(unsigned int *)drvdata;
-
-	if (flags & SVM_FLAG_SUPERVISOR_MODE) {
-		if (!ecap_srs(iommu->ecap)) {
-			dev_err(dev, "%s: Supervisor PASID not supported\n",
-				iommu->name);
-			return ERR_PTR(-EOPNOTSUPP);
-		}
-
-		if (mm) {
-			dev_err(dev, "%s: Supervisor PASID with user provided mm\n",
-				iommu->name);
-			return ERR_PTR(-EINVAL);
-		}
-
-		mm = &init_mm;
-	}
-
 	mutex_lock(&pasid_mutex);
-	ret = intel_svm_alloc_pasid(dev, mm, flags);
+	ret = intel_svm_alloc_pasid(dev, mm);
 	if (ret) {
 		mutex_unlock(&pasid_mutex);
 		return ERR_PTR(ret);
 	}
 
-	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
+	sva = intel_svm_bind_mm(iommu, dev, mm);
 	mutex_unlock(&pasid_mutex);
 
 	return sva;
-- 
2.25.1

