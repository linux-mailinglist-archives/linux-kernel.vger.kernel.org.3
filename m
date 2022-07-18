Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58E0577945
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiGRB2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiGRB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:28:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ADA13F18
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658107717; x=1689643717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k3ePWk+fUoLUpq8oyDvlEOoSVKymvsGYV9Svvo+EtbE=;
  b=SwLReOzkAVbd9bB+79+oDK0uMAE9xnqwWx5jCoEHSEyiJEhytQC13Xyh
   TD/yyjU5ELaEAiW6E7zzXqX1R1/vEDOKEpOyHLCnqHrMFb6azg7ePmMh+
   EvoOmj5Miv7Lztpiz3i/7VfR55f6Zaz2uiENIel2evSwWjw8PCD0agSX9
   TtvEymPHS9XIgeQJudgBEmKWdHsHiWp7Hf5xxql5kjI09gauqlH+n5U33
   2zQTRppJVBbjbdzWJomiNiELkpUCREXFIYxkMTwpJORrAUuTHn2qiyExW
   iIZwAIbqBaieeChikodEvsXINzvMUfBtJ2rzq/CwVkLIVYpnGsX6Otwy5
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="283673951"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="283673951"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:28:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="547294028"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:28:33 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, Chao Gao <chao.gao@intel.com>
Subject: [RFC v2 1/2] swiotlb: use bitmap to track free slots
Date:   Mon, 18 Jul 2022 09:28:17 +0800
Message-Id: <20220718012818.107051-2-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718012818.107051-1-chao.gao@intel.com>
References: <20220718012818.107051-1-chao.gao@intel.com>
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

Currently, each slot tracks the number of contiguous free slots starting
from itself. It helps to quickly check if there are enough contiguous
entries when dealing with an allocation request. But maintaining this
information can leads to some overhead. Specifically, if a slot is
allocated/freed, preceding slots may need to be updated as the number
of contiguous free slots can change. This process may access memory
scattering over multiple cachelines.

To reduce the overhead of maintaining the number of contiguous free
entries, use a global bitmap to track free slots; each bit represents
if a slot is available. The number of contiguous free slots can be
calculated by counting the number of consecutive 1s in the bitmap.

Tests show that the average cost of freeing slots drops by 120 cycles
while the average cost of allocation increases by 20 cycles. Overall,
100 cycles are saved from a pair of allocation and freeing.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
Ilpo, I didn't add your Reviewed-by as many changes were made due to
conflicts during rebasing.
---
 include/linux/swiotlb.h |  6 ++---
 kernel/dma/swiotlb.c    | 60 +++++++++++++++++++----------------------
 2 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index d3ae03edbbd2..2c8e6f5df610 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -77,8 +77,6 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  *		@end. For default swiotlb, this is command line adjustable via
  *		setup_io_tlb_npages.
  * @used:	The number of used IO TLB block.
- * @list:	The free list describing the number of free entries available
- *		from each index.
  * @orig_addr:	The original address corresponding to a mapped entry.
  * @alloc_size:	Size of the allocated buffer.
  * @debugfs:	The dentry to debugfs.
@@ -87,6 +85,8 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  * @for_alloc:  %true if the pool is used for memory allocation
  * @nareas:  The area number in the pool.
  * @area_nslabs: The slot number in the area.
+ * @bitmap:	The bitmap used to track free entries. 1 in bit X means the slot
+ *		indexed by X is free.
  */
 struct io_tlb_mem {
 	phys_addr_t start;
@@ -104,8 +104,8 @@ struct io_tlb_mem {
 	struct io_tlb_slot {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
-		unsigned int list;
 	} *slots;
+	unsigned long *bitmap;
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 70fd73fc357a..e9803a04459e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -276,7 +276,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	}
 
 	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
+		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 	}
@@ -360,6 +360,11 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	if (!mem->areas)
 		panic("%s: Failed to allocate mem->areas.\n", __func__);
 
+	mem->bitmap = memblock_alloc(BITS_TO_BYTES(nslabs), SMP_CACHE_BYTES);
+	if (!mem->bitmap)
+		panic("%s: Failed to allocate %lu bytes align=0x%x\n",
+		      __func__, BITS_TO_BYTES(nslabs), SMP_CACHE_BYTES);
+
 	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false,
 				default_nareas);
 
@@ -434,6 +439,10 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	if (!mem->areas)
 		goto error_area;
 
+	mem->bitmap = bitmap_zalloc(nslabs, GFP_KERNEL);
+	if (!mem->bitmap)
+		goto error_bitmap;
+
 	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 		get_order(array_size(sizeof(*mem->slots), nslabs)));
 	if (!mem->slots)
@@ -448,6 +457,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 	return 0;
 
 error_slots:
+	bitmap_free(mem->bitmap);
+error_bitmap:
 	free_pages((unsigned long)mem->areas, area_order);
 error_area:
 	free_pages((unsigned long)vstart, order);
@@ -607,7 +618,7 @@ static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int index, wrap, count = 0, i;
+	unsigned int index, wrap, i;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned long flags;
 	unsigned int slot_base;
@@ -626,6 +637,9 @@ static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
 		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
 	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
 
+	/* slots shouldn't cross one segment */
+	max_slots = min_t(unsigned long, max_slots, IO_TLB_SEGSIZE);
+
 	spin_lock_irqsave(&area->lock, flags);
 	if (unlikely(nslots > mem->area_nslabs - area->used))
 		goto not_found;
@@ -651,7 +665,8 @@ static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
 		if (!iommu_is_span_boundary(slot_index, nslots,
 					    nr_slots(tbl_dma_addr),
 					    max_slots)) {
-			if (mem->slots[slot_index].list >= nslots)
+			if (find_next_zero_bit(mem->bitmap, slot_index + nslots,
+					       slot_index) == slot_index + nslots)
 				goto found;
 		}
 		index = wrap_area_index(mem, index + stride);
@@ -663,14 +678,10 @@ static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
 
 found:
 	for (i = slot_index; i < slot_index + nslots; i++) {
-		mem->slots[i].list = 0;
+		__clear_bit(i, mem->bitmap);
 		mem->slots[i].alloc_size = alloc_size - (offset +
 				((i - slot_index) << IO_TLB_SHIFT));
 	}
-	for (i = slot_index - 1;
-	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
-	     mem->slots[i].list; i--)
-		mem->slots[i].list = ++count;
 
 	/*
 	 * Update the indices to avoid searching in the next round.
@@ -775,40 +786,20 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
 	int aindex = index / mem->area_nslabs;
 	struct io_tlb_area *area = &mem->areas[aindex];
-	int count, i;
+	int i;
 
 	/*
-	 * Return the buffer to the free list by setting the corresponding
-	 * entries to indicate the number of contiguous entries available.
-	 * While returning the entries to the free list, we merge the entries
-	 * with slots below and above the pool being returned.
+	 * Return the slots to swiotlb, updating bitmap to indicate
+	 * corresponding entries are free.
 	 */
 	BUG_ON(aindex >= mem->nareas);
-
 	spin_lock_irqsave(&area->lock, flags);
-	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
-		count = mem->slots[index + nslots].list;
-	else
-		count = 0;
-
-	/*
-	 * Step 1: return the slots to the free list, merging the slots with
-	 * superceeding slots
-	 */
 	for (i = index + nslots - 1; i >= index; i--) {
-		mem->slots[i].list = ++count;
+		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 	}
 
-	/*
-	 * Step 2: merge the returned slots with the preceding slots, if
-	 * available (non zero)
-	 */
-	for (i = index - 1;
-	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 && mem->slots[i].list;
-	     i--)
-		mem->slots[i].list = ++count;
 	area->used -= nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
 }
@@ -980,7 +971,10 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			return -ENOMEM;
 
 		mem->slots = kcalloc(nslabs, sizeof(*mem->slots), GFP_KERNEL);
-		if (!mem->slots) {
+		mem->bitmap = bitmap_zalloc(nslabs, GFP_KERNEL);
+		if (!mem->slots || !mem->bitmap) {
+			kfree(mem->slots);
+			bitmap_free(mem->bitmap);
 			kfree(mem);
 			return -ENOMEM;
 		}
-- 
2.25.1

