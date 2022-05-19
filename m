Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA63E52CCE2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiESHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiESHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:24:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD84087205
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652945075; x=1684481075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z00PR00Z0bBOcue3nPUlEzoXnGwLMcqBoCnXf6Kl2GI=;
  b=MabUvEJZQsSnZRAt/DUK1s9aGTdD0+zHOUGl00tMV3r9BjN32Qxa9349
   nvAI+eM+x8OKuiNKeV3ap8yokd3mO6fuL42r3Q/Ph74xM6ylUBs61Cp4m
   hRyiRLSTd/XPcndr69tygVHGp8inqYZaHPhexE1199kCYG6qrlcsy8yHG
   tOeHqccI/yN1SafqBuxEkF2CCvbGBAjQiGotTG3dZdNRcLke+hZJRLKjW
   hzsMMTNRgFR7Pfg8fk5Z5OPXrnZ85ODC9e0UwtLhYGwy4ZqkHkRehDa/R
   XrA9+83uKe4McR6Rplk19M+XXnA3A+YvCTlB3jDUtvxta8HHhaC/gcPHQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="272195908"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="272195908"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 00:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="714853061"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2022 00:24:31 -0700
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
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v7 04/10] iommu/vt-d: Add SVA domain support
Date:   Thu, 19 May 2022 15:20:41 +0800
Message-Id: <20220519072047.2996983-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for domain ops callbacks for an SVA domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  4 ++++
 drivers/iommu/intel/iommu.c |  4 ++++
 drivers/iommu/intel/svm.c   | 37 ++++++++++++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index df23300cfa88..5e88eaa245aa 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -744,6 +744,10 @@ void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+void intel_svm_detach_dev_pasid(struct iommu_domain *domain,
+				struct device *dev, ioasid_t pasid);
 
 struct intel_svm_dev {
 	struct list_head list;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e56b3a4b6998..2b6a52c87c73 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4923,6 +4923,10 @@ const struct iommu_ops intel_iommu_ops = {
 	.sva_unbind		= intel_svm_unbind,
 	.sva_get_pasid		= intel_svm_get_pasid,
 	.page_response		= intel_svm_page_response,
+	.sva_domain_ops = &(const struct iommu_domain_ops) {
+		.set_dev_pasid		= intel_svm_attach_dev_pasid,
+		.block_dev_pasid	= intel_svm_detach_dev_pasid,
+	},
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d04880a291c3..d575792441f3 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -323,6 +323,7 @@ static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
 
 static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 					   struct device *dev,
+					   ioasid_t pasid,
 					   struct mm_struct *mm)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
@@ -331,13 +332,13 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	struct intel_svm *svm;
 	int ret = 0;
 
-	svm = pasid_private_find(mm->pasid);
+	svm = pasid_private_find(pasid);
 	if (!svm) {
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm)
 			return ERR_PTR(-ENOMEM);
 
-		svm->pasid = mm->pasid;
+		svm->pasid = pasid;
 		svm->mm = mm;
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
@@ -387,7 +388,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
 	spin_lock_irqsave(&iommu->lock, iflags);
-	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
+	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	spin_unlock_irqrestore(&iommu->lock, iflags);
 
@@ -403,7 +404,7 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 free_svm:
 	if (list_empty(&svm->devs)) {
 		mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(mm->pasid);
+		pasid_private_remove(pasid);
 		kfree(svm);
 	}
 
@@ -822,7 +823,7 @@ struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm)
 		return ERR_PTR(ret);
 	}
 
-	sva = intel_svm_bind_mm(iommu, dev, mm);
+	sva = intel_svm_bind_mm(iommu, dev, mm->pasid, mm);
 	mutex_unlock(&pasid_mutex);
 
 	return sva;
@@ -931,3 +932,29 @@ int intel_svm_page_response(struct device *dev,
 	mutex_unlock(&pasid_mutex);
 	return ret;
 }
+
+int intel_svm_attach_dev_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct mm_struct *mm = domain_to_mm(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct iommu_sva *sva;
+	int ret = 0;
+
+	mutex_lock(&pasid_mutex);
+	sva = intel_svm_bind_mm(iommu, dev, pasid, mm);
+	if (IS_ERR(sva))
+		ret = PTR_ERR(sva);
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+
+void intel_svm_detach_dev_pasid(struct iommu_domain *domain,
+				struct device *dev, ioasid_t pasid)
+{
+	mutex_lock(&pasid_mutex);
+	intel_svm_unbind_mm(dev, pasid);
+	mutex_unlock(&pasid_mutex);
+}
-- 
2.25.1

