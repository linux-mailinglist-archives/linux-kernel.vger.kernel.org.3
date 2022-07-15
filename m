Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED8575F80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiGOKpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGOKpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:45:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539A82FA0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657881946; x=1689417946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6wERldfINGotCZB9RRsepryrHDN3FyuIRZkpCQPpjo=;
  b=I+uRVlwCgxQ5Y2rSMPvydEw4ZViZwmCdJ2pdolItvoZ0/ufjAqvo3sKg
   9T9DFcQuxZsg6FzlkIbaiwwYOUTRKcqzfQrr5O42J07J9MDDmiuiNsiha
   SPryIsABhLlet/vBiHbCniH0v57b1UND1c0dpmlHsAlOeOazgck6EAMNu
   4HnohRlvS7zZuiKZJ16o5OmR6hvl/q6nqdb9gVSHr1BI4M+Tvfn+b5xlK
   /8bG7clSK8WQ0HcJbUmB2QkI2218v53C/ua8q2VTAwZwacZHXBJHZk0+z
   YkLTpaE3y34+ere0Y3vZurtz01aL+euVIFbcdes5lzrLHW+qqKCruzIYZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286500357"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="286500357"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:45:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="654287105"
Received: from spr.sh.intel.com ([10.239.53.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 03:45:44 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/3] swiotlb: remove unused fields in io_tlb_mem
Date:   Fri, 15 Jul 2022 18:45:33 +0800
Message-Id: <20220715104535.1053907-2-chao.gao@intel.com>
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

Commit 20347fca71a3 ("swiotlb: split up the global swiotlb lock") splits
io_tlb_mem into multiple areas. Each area has its own lock and index. The
global ones are not used so remove them.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 include/linux/swiotlb.h | 5 -----
 kernel/dma/swiotlb.c    | 2 --
 2 files changed, 7 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f65ff1930120..d3ae03edbbd2 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -79,11 +79,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  * @used:	The number of used IO TLB block.
  * @list:	The free list describing the number of free entries available
  *		from each index.
- * @index:	The index to start searching in the next round.
  * @orig_addr:	The original address corresponding to a mapped entry.
  * @alloc_size:	Size of the allocated buffer.
- * @lock:	The lock to protect the above data structures in the map and
- *		unmap calls.
  * @debugfs:	The dentry to debugfs.
  * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
@@ -97,8 +94,6 @@ struct io_tlb_mem {
 	void *vaddr;
 	unsigned long nslabs;
 	unsigned long used;
-	unsigned int index;
-	spinlock_t lock;
 	struct dentry *debugfs;
 	bool late_alloc;
 	bool force_bounce;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dcf1459ce723..0d0f99146360 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -253,14 +253,12 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->nslabs = nslabs;
 	mem->start = start;
 	mem->end = mem->start + bytes;
-	mem->index = 0;
 	mem->late_alloc = late_alloc;
 	mem->nareas = nareas;
 	mem->area_nslabs = nslabs / mem->nareas;
 
 	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
 
-	spin_lock_init(&mem->lock);
 	for (i = 0; i < mem->nareas; i++) {
 		spin_lock_init(&mem->areas[i].lock);
 		mem->areas[i].index = 0;
-- 
2.25.1

