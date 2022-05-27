Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9768053596B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245697AbiE0GeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245561AbiE0GeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:34:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD0E5E14C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633251; x=1685169251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e6QO4/f2d5ksEADm5yEq5XT7V7SUplsTUbaoXwowz1g=;
  b=NudlK8gZTCqX6qKcG/FZjDyUEWOZzp9qGO1kYOYsmR54DEVy3QjUrQyM
   LEbvK7Hqng4fEMziMKW80Hneo/xDnS5yNtgxgz9IbbR/Wm5eC3YgFfqwL
   KzDniVj76ABNuiB/ZC2SQmLwXvlB2megRvRaP1HHjlqAaNDpvzyMgaAi4
   6MmPaisWrxykNlwgfmKyoR0gcO31VJGYJjTknrNHje779FVwdPlmwcnYR
   1wlNEh4FxeY8r07IF87QU3DAMWpgxz5megsjM3Je5z+qQOt2sZ++KL4yl
   BZi5KzojCrWkvwj55zW3DcelhBkQVAoQajbnr2pQekBHZpGBWzfGVsCGo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335044869"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335044869"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:34:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718688453"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:08 -0700
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
Subject: [PATCH 05/12] iommu/vt-d: Unncessary spinlock for root table alloc and free
Date:   Fri, 27 May 2022 14:30:12 +0800
Message-Id: <20220527063019.3112905-6-baolu.lu@linux.intel.com>
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

The IOMMU root table is allocated and freed in the IOMMU initialization
code in static boot or hot-plug paths. There's no need for a spinlock.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bbdd3417a1b1..2d5f02b85de8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -809,14 +809,12 @@ static int device_context_mapped(struct intel_iommu *iommu, u8 bus, u8 devfn)
 
 static void free_context_table(struct intel_iommu *iommu)
 {
-	int i;
-	unsigned long flags;
 	struct context_entry *context;
+	int i;
+
+	if (!iommu->root_entry)
+		return;
 
-	spin_lock_irqsave(&iommu->lock, flags);
-	if (!iommu->root_entry) {
-		goto out;
-	}
 	for (i = 0; i < ROOT_ENTRY_NR; i++) {
 		context = iommu_context_addr(iommu, i, 0, 0);
 		if (context)
@@ -828,12 +826,10 @@ static void free_context_table(struct intel_iommu *iommu)
 		context = iommu_context_addr(iommu, i, 0x80, 0);
 		if (context)
 			free_pgtable_page(context);
-
 	}
+
 	free_pgtable_page(iommu->root_entry);
 	iommu->root_entry = NULL;
-out:
-	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
 #ifdef CONFIG_DMAR_DEBUG
@@ -1232,7 +1228,6 @@ static void domain_unmap(struct dmar_domain *domain, unsigned long start_pfn,
 static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 {
 	struct root_entry *root;
-	unsigned long flags;
 
 	root = (struct root_entry *)alloc_pgtable_page(iommu->node);
 	if (!root) {
@@ -1242,10 +1237,7 @@ static int iommu_alloc_root_entry(struct intel_iommu *iommu)
 	}
 
 	__iommu_flush_cache(iommu, root, ROOT_SIZE);
-
-	spin_lock_irqsave(&iommu->lock, flags);
 	iommu->root_entry = root;
-	spin_unlock_irqrestore(&iommu->lock, flags);
 
 	return 0;
 }
-- 
2.25.1

