Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627F7535970
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbiE0Ge5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245730AbiE0GeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:34:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01365FF38
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633264; x=1685169264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLgt8GpnD0r5X5XNCxy8KVU7WroIhMRrSOoUkBm0OtU=;
  b=oCk2JnRwT37NDNE0atdGMtZz8uqP9U6HZDdloKtDpA8EAatNEIwSYBLe
   wqQb3AZhRg4nfoUa9/p1n+QKR8bBb5HoWNNLkm2fpefACj62slOORrdn1
   V/zaH7Bs9acUY5mT12xcVRJebgEf7wwpDdcXhnaDSgpqgWkONZlOe+p8o
   8tvZSqFyJDgHAtCnHNcTau+42HhN2rqGud4qfOH4ac5/1fNCvCfE7D0o6
   ZcQNIN2C8x5a+6O09vnvN5qQCA0nzzOm6ec9dWfrnr1st2GsFiDTFRqrm
   kZbzA7lxilZcXlJ1Aadgoq0AaVHhIl5w6OULuK5n3OYkhzIUHwHtB9HHv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335044918"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335044918"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718688729"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:21 -0700
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
Subject: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain free path
Date:   Fri, 27 May 2022 14:30:16 +0800
Message-Id: <20220527063019.3112905-10-baolu.lu@linux.intel.com>
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

When the IOMMU domain is about to be freed, it should not be set on any
device. Instead of silently dealing with some bug cases, it's better to
trigger a warning to report and fix any potential bugs at the first time.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e195a639502..6f3119c68cd2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -294,7 +294,6 @@ static LIST_HEAD(dmar_satc_units);
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
-static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
@@ -1835,9 +1834,8 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 
 static void domain_exit(struct dmar_domain *domain)
 {
-
-	/* Remove associated devices and clear attached or cached domains */
-	domain_remove_dev_info(domain);
+	if (WARN_ON(!list_empty(&domain->devices)))
+		return;
 
 	if (domain->pgd) {
 		LIST_HEAD(freelist);
@@ -2328,17 +2326,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
 
-static void domain_remove_dev_info(struct dmar_domain *domain)
-{
-	struct device_domain_info *info, *tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &domain->devices, link)
-		__dmar_remove_one_dev_info(info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
-- 
2.25.1

