Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF7535971
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343666AbiE0GfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245757AbiE0Ge3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:34:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149F5DE78
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633268; x=1685169268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GXkVdGV21h6YoEr6KbCeCrkJohsaI0ajhb6vA1EQLzI=;
  b=VjQG7sZAhw5fa0sMpKLkv+hK5LL/61DoNbNqswRhlxnYg2NjceF4N2d8
   HJ9WMqHMwe6paczTPr/yehpw3hSySI9n/4DXMXvKZSjgVjRCyVzVBkYGh
   EMpy8J2w9gwsXkZE4ybrI2lvvYNyFnHwguKlAtvAEzhjbHW/YD55d3n4Z
   m/PR9aPnpxsuLrlaVPbGnlU5PYjwYo8N9QeKL5rv0vC+i1ROKDcuDWYzL
   TubCXFz3b9Gx+JjLEitQ4TfSmeBzCXe3YxU8klXV+em6zYtSH++btv9Vw
   yzi3RDVdfAokDm+B2IZfUrRBk5IPA1tDGfYlL4/RH4mao7JdzIaSuJMhk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335044927"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335044927"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718688874"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:25 -0700
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
Subject: [PATCH 10/12] iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
Date:   Fri, 27 May 2022 14:30:17 +0800
Message-Id: <20220527063019.3112905-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 6f3119c68cd2..d02ddd338afd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -295,7 +295,6 @@ static LIST_HEAD(dmar_satc_units);
 static int g_num_of_iommus;
 
 static void dmar_remove_one_dev_info(struct device *dev);
-static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -4133,20 +4132,14 @@ static void domain_context_clear(struct device_domain_info *info)
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
@@ -4156,20 +4149,11 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
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

