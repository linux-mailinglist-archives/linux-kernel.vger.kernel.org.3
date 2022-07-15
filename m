Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD287575F82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiGOKp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiGOKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:45:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE185D6E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657881950; x=1689417950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mf+ou5sUbNJrHFghDywBtdNo5AKN4S9liviBGsFpQzU=;
  b=mGrV+F8Oi0L6DvAACXGfijOv06kbDXxE8YcyJlN4iJ3XIVJ3Q/dVoPZ4
   XmZHJDiDu4qlcHJHW59fawfmVJ5AebNjq7ey6cp0ocHm+dvL02PJNjx4I
   s0gYQY6Oby5Hp2j1tFwWISNAx8bvrzsQpZf8GDlabfY8Woof+RQmRIFq4
   lT+7oPaaXZRuGGiWpBX+AwrSAuKEMS3tyiYCOHkCl2CNzb8orCj4SvrHP
   2JKvN6Vhb55jPRmRKs3EECn2ro+w4grl71fFMXwrOVzVKmFom/wxvZ4qc
   DI2PphIdAnGZOUvfO72x0O4D6xI2um4OXaPWbA1U8D7Rp1ou9+aId4/1B
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286500373"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="286500373"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:45:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="654287118"
Received: from spr.sh.intel.com ([10.239.53.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:45:48 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 3/3] swiotlb: ensure a segment doesn't cross the area boundary
Date:   Fri, 15 Jul 2022 18:45:35 +0800
Message-Id: <20220715104535.1053907-4-chao.gao@intel.com>
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

