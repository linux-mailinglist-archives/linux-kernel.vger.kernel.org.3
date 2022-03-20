Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C14E1A87
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244898AbiCTGp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244895AbiCTGox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:44:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA598DCA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647758590; x=1679294590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e9Arp02M+Z+kYGcAnrD0NPhVZDhy+//PQc/OW3MJBzw=;
  b=W9KmMWEFPoQSbBg+/5ncuT4Fn+CZoZDAa0GoM4Pq4Vm7Zp369pGu9T1P
   lz7zHGcFwTONOfC/a2qoBMipN3oPwOyV1dGifGRHt6xhh+k6bPMOtcWKM
   6101tr0qIj8+rnyv6ldwUyPBrEepVatvpNh24I+sB3C6sn8cPT8ibWxMG
   ZzmkbPmvpannPE++eJzsoxm5VWegQDUuz99GiDAGhOgI8k1L/7MzfBmc3
   XbnqP4KnQA3zkdwNTn8ZhyNqjvsCWXgKhvvHIV/Z85UJ7HCjhv1PyWT4B
   D0NO2ISb0u1YI9byE90uq7i2VnLjzU50VAr/9iKhoFV/b0pPX7NlE4chK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254924038"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254924038"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="691839952"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:43:03 -0700
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
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH RFC 08/11] iommu: Handle IO page faults directly
Date:   Sun, 20 Mar 2022 14:40:27 +0800
Message-Id: <20220320064030.2936936-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly call the IO page fault handler in iommu_report_device_fault()
unless the device driver registered its own page fault handler. There
is no need to explicitly register the fault handler in IOMMU drivers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 13 +------------
 drivers/iommu/intel/iommu.c                     | 14 ++------------
 drivers/iommu/iommu.c                           | 11 ++++++++---
 3 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 3537a2291d7c..8497425f3c13 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -426,7 +426,6 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master)
 
 static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
 {
-	int ret;
 	struct device *dev = master->dev;
 
 	/*
@@ -439,16 +438,7 @@ static int arm_smmu_master_sva_enable_iopf(struct arm_smmu_master *master)
 	if (!master->iopf_enabled)
 		return -EINVAL;
 
-	ret = iopf_queue_add_device(master->smmu->evtq.iopf, dev);
-	if (ret)
-		return ret;
-
-	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
-	if (ret) {
-		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
-		return ret;
-	}
-	return 0;
+	return iopf_queue_add_device(master->smmu->evtq.iopf, dev);
 }
 
 static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
@@ -458,7 +448,6 @@ static void arm_smmu_master_sva_disable_iopf(struct arm_smmu_master *master)
 	if (!master->iopf_enabled)
 		return;
 
-	iommu_unregister_device_fault_handler(dev);
 	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8781305b9a02..8f9cc66787c3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4760,7 +4760,6 @@ static int intel_iommu_enable_sva(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
-	int ret;
 
 	if (!info || dmar_disabled)
 		return -EINVAL;
@@ -4778,24 +4777,15 @@ static int intel_iommu_enable_sva(struct device *dev)
 	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
 		return -EINVAL;
 
-	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
-	if (!ret)
-		ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
-
-	return ret;
+	return iopf_queue_add_device(iommu->iopf_queue, dev);
 }
 
 static int intel_iommu_disable_sva(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
-	int ret;
-
-	ret = iommu_unregister_device_fault_handler(dev);
-	if (!ret)
-		ret = iopf_queue_remove_device(iommu->iopf_queue, dev);
 
-	return ret;
+	return iopf_queue_remove_device(iommu->iopf_queue, dev);
 }
 
 static int intel_iommu_enable_iopf(struct device *dev)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c0966fc9b686..4f90b71c6f6e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -27,6 +27,8 @@
 #include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
 
+#include "iommu-sva-lib.h"
+
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
@@ -1177,10 +1179,9 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 	if (!param || !evt)
 		return -EINVAL;
 
-	/* we only report device fault if there is a handler registered */
 	mutex_lock(&param->lock);
 	fparam = param->fault_param;
-	if (!fparam || !fparam->handler) {
+	if (!fparam) {
 		ret = -EINVAL;
 		goto done_unlock;
 	}
@@ -1198,7 +1199,11 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 		mutex_unlock(&fparam->lock);
 	}
 
-	ret = fparam->handler(&evt->fault, fparam->data);
+	if (fparam->handler)
+		ret = fparam->handler(&evt->fault, fparam->data);
+	else
+		ret = iommu_queue_iopf(&evt->fault, fparam->data);
+
 	if (ret && evt_pending) {
 		mutex_lock(&fparam->lock);
 		list_del(&evt_pending->list);
-- 
2.25.1

