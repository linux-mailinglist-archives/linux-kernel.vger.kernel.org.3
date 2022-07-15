Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911AB575F81
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiGOKpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiGOKpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:45:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB8785D61
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657881948; x=1689417948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MSWP29tqWJG1PAHv7yFlPylCea0BZGM4/LHBRM52PJQ=;
  b=QQtJflpRfpK9xmKuAyBpMZqcTSVjdWaD8Lp8xKdmCrl9FH9ejTRJYToE
   G11Kj/0vkICFS26PVxYpLCgqGCXx9UVLaIhpd2+W8tWT/AiVMaG5ijog0
   i84qG8dsPMoI1yW3E4IJc0G0FQKoPJronRmNbIZIUAqQTpVDOyIGteSvf
   +jiHhe4iOmG8b1HIICVvoHOQZ2L0NhmRR6yIxL7p8EXmMfUl8NTddmoca
   dzVjiqjd31G0JvtcUwsTN7WvpRcKEaj6JnVHdse2gfZtTakbWcbHAX6gc
   W5VBw/hwQ2aaU4HA4AssONgwFqb7Q2NhtDLvBT5YMXf5KIOeFhTzIvsfZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286500367"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="286500367"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:45:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="654287109"
Received: from spr.sh.intel.com ([10.239.53.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:45:46 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/3] swiotlb: consolidate rounding up default_nslabs
Date:   Fri, 15 Jul 2022 18:45:34 +0800
Message-Id: <20220715104535.1053907-3-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715104535.1053907-1-chao.gao@intel.com>
References: <20220715104535.1053907-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

