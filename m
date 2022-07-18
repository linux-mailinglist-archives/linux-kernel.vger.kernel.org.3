Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F87577933
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiGRBQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiGRBQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:16:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E815011A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658106990; x=1689642990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mf+ou5sUbNJrHFghDywBtdNo5AKN4S9liviBGsFpQzU=;
  b=E/SBW7BDBj3sNAI2b0ZvodbLSR2LBixqJuqnMuvKgVthELjKF1g7YAht
   yyY0u4ukW4b+f/qkrDoeo0GV2d2TKmbDKZQxkji1ccUP1QEBmuXhebj/x
   cT4rm/XcoZwvAJilh60yo/bk++uG4n/5twejSgqhlvEji/5tDqWwa3gsU
   /qZmODkDywc//79OHa3Lcn+GFMWyZcJ9j//VdEg/n8nX1xzxrBV8ipqqt
   UjLpwfKa3bdPvrWTIcOAT6nFm31DfvXor4wKNu+oxY1KngRm5NndK2DET
   APxsWE6SCqaErE+pofekyqfKDKaXf5FkKrCbJnwL4SYLSexNJdrIKvhOr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286127491"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="286127491"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624520476"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:28 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [RESEND PATCH 3/3] swiotlb: ensure a segment doesn't cross the area boundary
Date:   Mon, 18 Jul 2022 09:16:07 +0800
Message-Id: <20220718011608.106289-4-chao.gao@intel.com>
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

Free slots tracking assumes that slots in a segment can be allocated to
fulfill a request. This implies that slots in a segment should belong to
the same area. Although the possibility of a violation is low, it is better
to explicitly enforce segments won't span multiple areas by adjusting the
number of slabs when configuring areas.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 kernel/dma/swiotlb.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9ab87d6d47bc..70fd73fc357a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -91,12 +91,21 @@ struct io_tlb_area {
 /*
  * Round up number of slabs to the next power of 2. The last area is going
  * be smaller than the rest if default_nslabs is not power of two.
+ * The number of slot in an area should be a multiple of IO_TLB_SEGSIZE,
+ * otherwise a segment may span two or more areas. It conflicts with free
+ * contiguous slots tracking: free slots are treated contiguous no matter
+ * whether they cross an area boundary.
  *
  * Return true if default_nslabs is rounded up.
  */
 static bool round_up_default_nslabs(void)
 {
-	if (!default_nareas || is_power_of_2(default_nslabs))
+	if (!default_nareas)
+		return false;
+
+	if (default_nslabs < IO_TLB_SEGSIZE * default_nareas)
+		default_nslabs = IO_TLB_SEGSIZE * default_nareas;
+	else if (is_power_of_2(default_nslabs))
 		return false;
 
 	default_nslabs = roundup_pow_of_two(default_nslabs);
-- 
2.25.1

