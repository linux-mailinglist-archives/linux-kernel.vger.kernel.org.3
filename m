Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E264F53596C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbiE0Gen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343593AbiE0GeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:34:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC045FF14
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633261; x=1685169261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6noG+HsWwgZ3hsLbFVG+gjOIvdtpwhZqbvCacXrgpNY=;
  b=Y2v0r4Z+1HeZlCvGOq98siTyTRwb8uQ2tTimqq33dDAu0niEM12OaUBw
   70qy4FI0bnDgEg+xLJC7VdialVWn9kFJAMet6LJSVSGWz3FVCMKMux0tH
   qLU3PHiQpc65lm7MuqDRjSmhZmoMKhERlaojDE5MWKVxqxMokeXbmG7dR
   6bmeyzD3vzMEz6cIAMgYfMyoAOPGMNLA0vf6xz+jZtqm2jRHY9T0uBsRK
   lPBpbwmNKjYfCQkNX/KhZ6CCSFIjhV7CulQamtHvULz7Nt+OBV0+VuFQy
   DEcID0v/MU4XaXf8KJSQxddW4UrfWrQSEPElsMFrexdQsNp4GIXw3ezxD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335044913"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335044913"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:34:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718688675"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:18 -0700
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
Subject: [PATCH 08/12] iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()
Date:   Fri, 27 May 2022 14:30:15 +0800
Message-Id: <20220527063019.3112905-9-baolu.lu@linux.intel.com>
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

The iommu->lock is used to protect changes in root/context/pasid tables
and domain ID allocation. There's no use case to change these resources
in any interrupt context. Hence there's no need to disable interrupts
when helding the spinlock.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c |  6 ++----
 drivers/iommu/intel/iommu.c   | 17 +++++++----------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index eea8727aa7bc..ca1adceeba19 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -263,10 +263,9 @@ static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16 bus)
 
 static void root_tbl_walk(struct seq_file *m, struct intel_iommu *iommu)
 {
-	unsigned long flags;
 	u16 bus;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	seq_printf(m, "IOMMU %s: Root Table Address: 0x%llx\n", iommu->name,
 		   (u64)virt_to_phys(iommu->root_entry));
 	seq_puts(m, "B.D.F\tRoot_entry\t\t\t\tContext_entry\t\t\t\tPASID\tPASID_table_entry\n");
@@ -278,8 +277,7 @@ static void root_tbl_walk(struct seq_file *m, struct intel_iommu *iommu)
 	 */
 	for (bus = 0; bus < 256; bus++)
 		ctx_tbl_walk(m, iommu, bus);
-
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 }
 
 static int dmar_translation_struct_show(struct seq_file *m, void *unused)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ccf3c7fa26f1..2e195a639502 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -797,13 +797,12 @@ static int device_context_mapped(struct intel_iommu *iommu, u8 bus, u8 devfn)
 {
 	struct context_entry *context;
 	int ret = 0;
-	unsigned long flags;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
 	if (context)
 		ret = context_present(context);
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 	return ret;
 }
 
@@ -2287,16 +2286,15 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 {
 	struct intel_iommu *iommu = info->iommu;
 	struct context_entry *context;
-	unsigned long flags;
 	u16 did_old;
 
 	if (!iommu)
 		return;
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 	context = iommu_context_addr(iommu, bus, devfn, 0);
 	if (!context) {
-		spin_unlock_irqrestore(&iommu->lock, flags);
+		spin_unlock(&iommu->lock);
 		return;
 	}
 
@@ -2311,7 +2309,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 	iommu->flush.flush_context(iommu,
 				   did_old,
 				   (((u16)bus) << 8) | devfn,
@@ -2764,7 +2762,6 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	struct root_entry *old_rt;
 	phys_addr_t old_rt_phys;
 	int ctxt_table_entries;
-	unsigned long flags;
 	u64 rtaddr_reg;
 	int bus, ret;
 	bool new_ext, ext;
@@ -2807,7 +2804,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 		}
 	}
 
-	spin_lock_irqsave(&iommu->lock, flags);
+	spin_lock(&iommu->lock);
 
 	/* Context tables are copied, now write them to the root_entry table */
 	for (bus = 0; bus < 256; bus++) {
@@ -2826,7 +2823,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 		iommu->root_entry[bus].hi = val;
 	}
 
-	spin_unlock_irqrestore(&iommu->lock, flags);
+	spin_unlock(&iommu->lock);
 
 	kfree(ctxt_tbls);
 
-- 
2.25.1

