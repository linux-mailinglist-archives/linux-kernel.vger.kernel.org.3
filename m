Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4733454A743
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiFNDAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343582AbiFNC7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:59:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D01BEA7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655175369; x=1686711369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2OradfonvTzvQIlP/JG0I5HnkCgZvFw+PYBG+YT/4/4=;
  b=i2e3PkpG9vO2hDjNBBFS3qg2P1G+nR3+90Mz9cIqniN5LTE7k3lHtHCF
   f7abaRQBYoGScBlQ3tqgTHmt2k6gMBY37miIgOOlPxXouuK1L1lhD8QZb
   ts+gRDdWQgEKuzYAnN3tW89EZJlAl9263yxPu3pvqbrQi8sIEw91FXDLc
   DfU3oF/nVGgQiSMyDJ0MqJXcCIWtuIx57XWUjnwhQdT9CtX+CFo6cE/W/
   k2nGQlYeJeU/MqmgallQZTBJHuNz5u8szpB0FiOExDJbpksFRAHB5z3BR
   wYAY32djGeAkcy1YobGyXVdm2t0WH6Mkoh9QjCrVUZGYPr6iCvVHiaiCE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258930433"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="258930433"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 19:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="588166694"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 19:56:02 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 10/12] iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
Date:   Tue, 14 Jun 2022 10:51:35 +0800
Message-Id: <20220614025137.1632762-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold __dmar_remove_one_dev_info() into dmar_remove_one_dev_info() which
is its only caller. Make the spin lock critical range only cover the
device list change code and remove some unnecessary checks.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index af22690f44c8..8345e0c0824c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -295,7 +295,6 @@ static LIST_HEAD(dmar_satc_units);
 static int g_num_of_iommus;
 
 static void dmar_remove_one_dev_info(struct device *dev);
-static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -4141,20 +4140,14 @@ static void domain_context_clear(struct device_domain_info *info)
 			       &domain_context_clear_one_cb, info);
 }
 
-static void __dmar_remove_one_dev_info(struct device_domain_info *info)
+static void dmar_remove_one_dev_info(struct device *dev)
 {
-	struct dmar_domain *domain;
-	struct intel_iommu *iommu;
-
-	assert_spin_locked(&device_domain_lock);
-
-	if (WARN_ON(!info))
-		return;
-
-	iommu = info->iommu;
-	domain = info->domain;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *domain = info->domain;
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
 
-	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
+	if (!dev_is_real_dma_subdevice(info->dev)) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
@@ -4164,20 +4157,11 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 		intel_pasid_free_table(info->dev);
 	}
 
-	list_del(&info->link);
-	domain_detach_iommu(domain, iommu);
-}
-
-static void dmar_remove_one_dev_info(struct device *dev)
-{
-	struct device_domain_info *info;
-	unsigned long flags;
-
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev_iommu_priv_get(dev);
-	if (info)
-		__dmar_remove_one_dev_info(info);
+	list_del(&info->link);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	domain_detach_iommu(domain, iommu);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
-- 
2.25.1

