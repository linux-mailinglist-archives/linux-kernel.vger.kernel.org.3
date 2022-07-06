Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1082F567C3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiGFDAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiGFDAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:00:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA51B79B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657076401; x=1688612401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1CTKfefQ/h6z94Nvf/sEonitLTLnAFkKkQpkqf1GosQ=;
  b=YWRLO7kQdathmhc2izWRqwbhzyg/++X/DyUM0F99dsOG4YBUG9edQi4+
   E9Lrz2DCkOM5RykRbS0o15vSSpYJdqbGRrU+FfMkHIPcD8KGQ4eAFUjL7
   1AxtxlzokzABYEyireQ9HKKQ0BTtuWl3VIVhO8TdD0SDg4Zz9ggOrinbL
   mKBX9BJwOam7jhr+ybGNJ0W/c31PxZKKHJXoQSNm3HBRRoM8mV/LqSkjN
   gTcdVIzqFStf+uFLhw3F9ICCEs9VvI1zb5gaHV0qZEduweGllAhv87MZ6
   E25zIjriG+wEqyc2//sLo358c2cZ3UQle7vcWrytGOc9hrXuxpbNpPFUZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409543"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="272409543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:00:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567874816"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 19:59:59 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 04/11] iommu/vt-d: Unnecessary spinlock for root table alloc and free
Date:   Wed,  6 Jul 2022 10:55:17 +0800
Message-Id: <20220706025524.2904370-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IOMMU root table is allocated and freed in the IOMMU initialization
code in static boot or hot-remove paths. There's no need for a spinlock.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 77915d61f7ec..ff49c9460ede 100644
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

