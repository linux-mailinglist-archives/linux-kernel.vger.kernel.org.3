Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE3A577931
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbiGRBQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiGRBQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:16:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE68211826
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658106986; x=1689642986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6wERldfINGotCZB9RRsepryrHDN3FyuIRZkpCQPpjo=;
  b=nKuJnL74KmYRUzwkrL1X+gcWMOINNd1edR1YCTjJxBL5NGaMCf6vAvcZ
   jKTKdyEgmtmEdAyFvyRjroSPHvgfzIksFuSoLWmQHeteblBwQkhLQGUHg
   a394ZWVivVmysHHk9ewQFA5fq6KiYVvm2Wswx6ZoL1rDHuzSzecZZEwLr
   mhIFD2+OooOUYLaJvgRk4Eyg5RirtEAC/qUK6vwQMD8cLJkfBxWHsXhkx
   5/2Celv/zyPUa/lacCQ6hJhY7YpoI/MIzIyZsF1DUsnzA1wA4s27m7UGW
   Lw9DSDcBWYERgJ1bMo1+C8EgGAO7u3tHQ2w61pW6jL05tgnI37RFugRUh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286127475"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="286127475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="624520461"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:16:24 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Chao Gao <chao.gao@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [RESEND PATCH 1/3] swiotlb: remove unused fields in io_tlb_mem
Date:   Mon, 18 Jul 2022 09:16:05 +0800
Message-Id: <20220718011608.106289-2-chao.gao@intel.com>
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

