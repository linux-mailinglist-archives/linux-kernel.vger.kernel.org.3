Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0830B577932
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiGRBQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiGRBQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:16:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A2211A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658106988; x=1689642988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MSWP29tqWJG1PAHv7yFlPylCea0BZGM4/LHBRM52PJQ=;
  b=nVp0z560szE6TW+g1H4fD1bjZvnZ0qs5jOG6HHnZFheWFKAZS92G71Qu
   AGemhHB2aJDqnHh82SzLq+D7AsRleCs6DQEA0DlcXOBTafbcecdQIiGDa
   J3DGLNCvnn+nDNYi1LXufscMHG77/r5AOSCWvgJjA3Px8TC/ey+nD0FeD
   v3YsFUglZ640lT5FSwXbn5vMpaeemY3GKRDjV/PcanoFxdioopFUwpZM3
   AzD4Oj9Hvcmwl7tLlzysOEWYQacqfus9iBZtN/OL925ehpVimnC8DKXNd
   xV1XPJBOt/dLS/zeO8pdnBvt12UC7V4mFi8u1miS1BHqpyBB9uUPx4Tw3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286127481"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="286127481"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624520466"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:26 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [RESEND PATCH 2/3] swiotlb: consolidate rounding up default_nslabs
Date:   Mon, 18 Jul 2022 09:16:06 +0800
Message-Id: <20220718011608.106289-3-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718011608.106289-1-chao.gao@intel.com>
References: <20220718011608.106289-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

default_nslabs are rounded up in two cases with exactly same comments.
Add a simple wrapper to reduce duplicate code/comments. It is preparatory
to adding more logics into the round-up.

No functional change intended.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 kernel/dma/swiotlb.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0d0f99146360..9ab87d6d47bc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -88,6 +88,22 @@ struct io_tlb_area {
 	spinlock_t lock;
 };
 
+/*
+ * Round up number of slabs to the next power of 2. The last area is going
+ * be smaller than the rest if default_nslabs is not power of two.
+ *
+ * Return true if default_nslabs is rounded up.
+ */
+static bool round_up_default_nslabs(void)
+{
+	if (!default_nareas || is_power_of_2(default_nslabs))
+		return false;
+
+	default_nslabs = roundup_pow_of_two(default_nslabs);
+
+	return true;
+}
+
 static void swiotlb_adjust_nareas(unsigned int nareas)
 {
 	if (!is_power_of_2(nareas))
@@ -96,16 +112,9 @@ static void swiotlb_adjust_nareas(unsigned int nareas)
 	default_nareas = nareas;
 
 	pr_info("area num %d.\n", nareas);
-	/*
-	 * Round up number of slabs to the next power of 2.
-	 * The last area is going be smaller than the rest if
-	 * default_nslabs is not power of two.
-	 */
-	if (nareas && !is_power_of_2(default_nslabs)) {
-		default_nslabs = roundup_pow_of_two(default_nslabs);
+	if (round_up_default_nslabs())
 		pr_info("SWIOTLB bounce buffer size roundup to %luMB",
 			(default_nslabs << IO_TLB_SHIFT) >> 20);
-	}
 }
 
 static int __init
@@ -154,17 +163,10 @@ void __init swiotlb_adjust_size(unsigned long size)
 	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
 		return;
 
-	/*
-	 * Round up number of slabs to the next power of 2.
-	 * The last area is going be smaller than the rest if
-	 * default_nslabs is not power of two.
-	 */
 	size = ALIGN(size, IO_TLB_SIZE);
 	default_nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
-	if (default_nareas) {
-		default_nslabs = roundup_pow_of_two(default_nslabs);
+	if (round_up_default_nslabs())
 		size = default_nslabs << IO_TLB_SHIFT;
-	}
 
 	pr_info("SWIOTLB bounce buffer size adjusted to %luMB", size >> 20);
 }
-- 
2.25.1

