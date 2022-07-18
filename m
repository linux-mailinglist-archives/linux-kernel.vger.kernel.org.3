Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F38577946
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiGRB2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiGRB2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:28:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA96D13EB0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 18:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658107721; x=1689643721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6UdrsFkMglmSseu9pu04NsQfmdO+tQ2peISIQFw0LIM=;
  b=CU7On30BnTmZyJx8XIOCwlNd+ZrcN+Krvt1cC7g7WgO/hgi9jzbQITOV
   zXN61Tc/8kPs165y7C0n9nvTD+PRb55onqM2kMjczuwwP8MMVjTSXDer9
   ibmSPERvDKqtIP4cAD+vcxTQfYG3ZMbtNxeedIqNp3N6kkSDzwWEvwaCi
   dbiSagrrA1eoEySJaT6QKrswxu4VkLHY+Staoz/ieVnwgc7XoAgKhLhX/
   CZICtRpHe+CChc4unyP8e0diEqWy4/TpJNqjSS8LBCvhISa2rUK7buRTK
   8NyESm2BabQVG8ZjVvmXU9gciq4dLHGVEgnJuBcIqdLeG/iOIH84M4dv3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="283673959"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="283673959"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:28:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="547294038"
Received: from spr.sh.intel.com ([10.239.53.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:28:37 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, Chao Gao <chao.gao@intel.com>
Subject: [RFC v2 2/2] swiotlb: Allocate memory in a cache-friendly way
Date:   Mon, 18 Jul 2022 09:28:18 +0800
Message-Id: <20220718012818.107051-3-chao.gao@intel.com>
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

Currently, swiotlb uses an index to indicate the starting point of next
search. The index increases from 0 to the number of slots - 1 and then
wraps around. It is straightforward but not cache-friendly because the
"oldest" slot in a swiotlb area is used first.

Freed slots are probably accessed right before being freed, especially
in VM's case (device backends access them in DMA_TO_DEVICE mode; guest
accesses them in other DMA modes). Thus those just freed slots may
reside in cache. Then reusing those just freed slots can reduce cache
misses.

To that end, maintain a free list for free slots and insert freed slots
from the head and searching for free slots always starts from the head.

With this optimization, network throughput of sending data from host to
guest, measured by iperf3, increases by 7%.

A bad side effect of this patch is we cannot use a large stride to skip
unaligned slots when there is an alignment requirement. Currently, a
large stride is used when a) device has an alignment requirement, stride
is calculated according to the requirement; b) the requested size is
larger than PAGE_SIZE. For x86 with 4KB page size, stride is set to 2.

For case a), few devices have an alignment requirement; the impact is
limited. For case b) this patch probably leads to one (or more if page size
is larger than 4K) additional lookup; but as the "io_tlb_slot" struct of
free slots are also accessed when freeing slots, they probably resides in
CPU cache as well and then the overhead is almost negligible.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 include/linux/swiotlb.h |  2 ++
 kernel/dma/swiotlb.c    | 71 +++++++++++++++++------------------------
 2 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 2c8e6f5df610..335a550aeda5 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -79,6 +79,7 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
  * @used:	The number of used IO TLB block.
  * @orig_addr:	The original address corresponding to a mapped entry.
  * @alloc_size:	Size of the allocated buffer.
+ * @node:	Representation of an io_tlb_slot in the per-area free list.
  * @debugfs:	The dentry to debugfs.
  * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
@@ -104,6 +105,7 @@ struct io_tlb_mem {
 	struct io_tlb_slot {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
+		struct list_head node;
 	} *slots;
 	unsigned long *bitmap;
 };
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e9803a04459e..cb04a5c06552 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -78,13 +78,13 @@ static unsigned long default_nareas;
  * This is a single area with a single lock.
  *
  * @used:	The number of used IO TLB block.
- * @index:	The slot index to start searching in this area for next round.
+ * @free_slots: List of free slots.
  * @lock:	The lock to protect the above data structures in the map and
  *		unmap calls.
  */
 struct io_tlb_area {
 	unsigned long used;
-	unsigned int index;
+	struct list_head free_slots;
 	spinlock_t lock;
 };
 
@@ -258,6 +258,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 		unsigned long nslabs, unsigned int flags,
 		bool late_alloc, unsigned int nareas)
 {
+	int aindex;
 	void *vaddr = phys_to_virt(start);
 	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
 
@@ -272,13 +273,16 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 
 	for (i = 0; i < mem->nareas; i++) {
 		spin_lock_init(&mem->areas[i].lock);
-		mem->areas[i].index = 0;
+		INIT_LIST_HEAD(&mem->areas[i].free_slots);
 	}
 
 	for (i = 0; i < mem->nslabs; i++) {
 		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		aindex = i / mem->area_nslabs;
+		list_add_tail(&mem->slots[i].node,
+			      &mem->areas[aindex].free_slots);
 	}
 
 	/*
@@ -595,13 +599,6 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
 	return nr_slots(boundary_mask + 1);
 }
 
-static unsigned int wrap_area_index(struct io_tlb_mem *mem, unsigned int index)
-{
-	if (index >= mem->area_nslabs)
-		return 0;
-	return index;
-}
-
 /*
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
@@ -614,29 +611,19 @@ static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
+	dma_addr_t slot_dma_addr;
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
-	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int index, wrap, i;
+	unsigned int nslots = nr_slots(alloc_size);
+	unsigned int slot_index, i;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned long flags;
-	unsigned int slot_base;
-	unsigned int slot_index;
+	struct io_tlb_slot *slot, *tmp;
 
 	BUG_ON(!nslots);
 	BUG_ON(area_index >= mem->nareas);
 
-	/*
-	 * For mappings with an alignment requirement don't bother looping to
-	 * unaligned slots once we found an aligned one.  For allocations of
-	 * PAGE_SIZE or larger only look for page aligned allocations.
-	 */
-	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
-	if (alloc_size >= PAGE_SIZE)
-		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
-	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
-
 	/* slots shouldn't cross one segment */
 	max_slots = min_t(unsigned long, max_slots, IO_TLB_SEGSIZE);
 
@@ -644,19 +631,27 @@ static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
 	if (unlikely(nslots > mem->area_nslabs - area->used))
 		goto not_found;
 
-	slot_base = area_index * mem->area_nslabs;
-	index = wrap = wrap_area_index(mem, ALIGN(area->index, stride));
-
-	do {
-		slot_index = slot_base + index;
+	list_for_each_entry_safe(slot, tmp, &area->free_slots, node) {
+		slot_index = slot - mem->slots;
+		slot_dma_addr = slot_addr(tbl_dma_addr, slot_index);
 
 		if (orig_addr &&
-		    (slot_addr(tbl_dma_addr, slot_index) &
-		     iotlb_align_mask) != (orig_addr & iotlb_align_mask)) {
-			index = wrap_area_index(mem, index + 1);
+		    (slot_dma_addr & iotlb_align_mask) !=
+			    (orig_addr & iotlb_align_mask)) {
 			continue;
 		}
 
+		/* Ensure requested alignment is met */
+		if (alloc_align_mask && (slot_dma_addr & (alloc_align_mask - 1)))
+			continue;
+
+		/*
+		 * If requested size is larger than a page, ensure allocated
+		 * memory to be page aligned.
+		 */
+		if (alloc_size >= PAGE_SIZE && (slot_dma_addr & ~PAGE_MASK))
+			continue;
+
 		/*
 		 * If we find a slot that indicates we have 'nslots' number of
 		 * contiguous buffers, we allocate the buffers from that slot
@@ -669,8 +664,7 @@ static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
 					       slot_index) == slot_index + nslots)
 				goto found;
 		}
-		index = wrap_area_index(mem, index + stride);
-	} while (index != wrap);
+	}
 
 not_found:
 	spin_unlock_irqrestore(&area->lock, flags);
@@ -681,15 +675,9 @@ static int swiotlb_do_find_slots(struct io_tlb_mem *mem,
 		__clear_bit(i, mem->bitmap);
 		mem->slots[i].alloc_size = alloc_size - (offset +
 				((i - slot_index) << IO_TLB_SHIFT));
+		list_del(&mem->slots[i].node);
 	}
 
-	/*
-	 * Update the indices to avoid searching in the next round.
-	 */
-	if (index + nslots < mem->area_nslabs)
-		area->index = index + nslots;
-	else
-		area->index = 0;
 	area->used += nslots;
 	spin_unlock_irqrestore(&area->lock, flags);
 	return slot_index;
@@ -798,6 +786,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		list_add(&mem->slots[i].node, &mem->areas[aindex].free_slots);
 	}
 
 	area->used -= nslots;
-- 
2.25.1

