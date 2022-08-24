Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA659FD13
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiHXOSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbiHXOSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:18:16 -0400
Received: from outbound-smtp07.blacknight.com (outbound-smtp07.blacknight.com [46.22.139.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB8298D3B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:18:14 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 135151C3D92
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 15:18:13 +0100 (IST)
Received: (qmail 8923 invoked from network); 24 Aug 2022 14:18:12 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 24 Aug 2022 14:18:12 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/1] mm/page_alloc: Leave IRQs enabled for per-cpu page allocations
Date:   Wed, 24 Aug 2022 15:18:02 +0100
Message-Id: <20220824141802.23395-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
allocating from the PCP must not re-enter the allocator from IRQ context.
In each instance where IRQ-reentrancy is possible, the lock is acquired using
pcp_spin_trylock_irqsave() even though IRQs are disabled and re-entrancy
is impossible.

Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
case at the cost of some IRQ allocations taking a slower path. If the PCP
lists need to be refilled, the zone lock still needs to disable IRQs but
that will only happen on PCP refill and drain. If an IRQ is raised when
a PCP allocation is in progress, the trylock will fail and fallback to
using the buddy lists directly. Note that this may not be a universal win
if an interrupt-intensive workload also allocates heavily from interrupt
context and contends heavily on the zone->lock as a result.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 93 +++++++++++++++----------------------------------
 1 file changed, 28 insertions(+), 65 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..6a8f07a0a548 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -169,21 +169,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 	_ret;								\
 })
 
-#define pcpu_spin_lock_irqsave(type, member, ptr, flags)		\
+#define pcpu_spin_trylock(type, member, ptr)				\
 ({									\
 	type *_ret;							\
 	pcpu_task_pin();						\
 	_ret = this_cpu_ptr(ptr);					\
-	spin_lock_irqsave(&_ret->member, flags);			\
-	_ret;								\
-})
-
-#define pcpu_spin_trylock_irqsave(type, member, ptr, flags)		\
-({									\
-	type *_ret;							\
-	pcpu_task_pin();						\
-	_ret = this_cpu_ptr(ptr);					\
-	if (!spin_trylock_irqsave(&_ret->member, flags)) {		\
+	if (!spin_trylock(&_ret->member)) {				\
 		pcpu_task_unpin();					\
 		_ret = NULL;						\
 	}								\
@@ -196,27 +187,16 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 	pcpu_task_unpin();						\
 })
 
-#define pcpu_spin_unlock_irqrestore(member, ptr, flags)			\
-({									\
-	spin_unlock_irqrestore(&ptr->member, flags);			\
-	pcpu_task_unpin();						\
-})
-
 /* struct per_cpu_pages specific helpers. */
 #define pcp_spin_lock(ptr)						\
 	pcpu_spin_lock(struct per_cpu_pages, lock, ptr)
 
-#define pcp_spin_lock_irqsave(ptr, flags)				\
-	pcpu_spin_lock_irqsave(struct per_cpu_pages, lock, ptr, flags)
-
-#define pcp_spin_trylock_irqsave(ptr, flags)				\
-	pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, ptr, flags)
+#define pcp_spin_trylock(ptr)						\
+	pcpu_spin_trylock(struct per_cpu_pages, lock, ptr)
 
 #define pcp_spin_unlock(ptr)						\
 	pcpu_spin_unlock(lock, ptr)
 
-#define pcp_spin_unlock_irqrestore(ptr, flags)				\
-	pcpu_spin_unlock_irqrestore(lock, ptr, flags)
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -1536,6 +1516,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 					struct per_cpu_pages *pcp,
 					int pindex)
 {
+	unsigned long flags;
 	int min_pindex = 0;
 	int max_pindex = NR_PCP_LISTS - 1;
 	unsigned int order;
@@ -1551,8 +1532,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
-	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
-	spin_lock(&zone->lock);
+	spin_lock_irqsave(&zone->lock, flags);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
 	while (count > 0) {
@@ -1601,7 +1581,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (count > 0 && !list_empty(list));
 	}
 
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 static void free_one_page(struct zone *zone,
@@ -3118,10 +3098,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
+	unsigned long flags;
 	int i, allocated = 0;
 
-	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
-	spin_lock(&zone->lock);
+	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
 								alloc_flags);
@@ -3155,7 +3135,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	 * pages added to the pcp list.
 	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 	return allocated;
 }
 
@@ -3172,16 +3152,9 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0) {
-		unsigned long flags;
-
-		/*
-		 * free_pcppages_bulk expects IRQs disabled for zone->lock
-		 * so even though pcp->lock is not intended to be IRQ-safe,
-		 * it's needed in this context.
-		 */
-		spin_lock_irqsave(&pcp->lock, flags);
+		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-		spin_unlock_irqrestore(&pcp->lock, flags);
+		spin_unlock(&pcp->lock);
 	}
 }
 #endif
@@ -3195,12 +3168,9 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	if (pcp->count) {
-		unsigned long flags;
-
-		/* See drain_zone_pages on why this is disabling IRQs */
-		spin_lock_irqsave(&pcp->lock, flags);
+		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, pcp->count, pcp, 0);
-		spin_unlock_irqrestore(&pcp->lock, flags);
+		spin_unlock(&pcp->lock);
 	}
 }
 
@@ -3466,7 +3436,6 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
  */
 void free_unref_page(struct page *page, unsigned int order)
 {
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
@@ -3494,10 +3463,10 @@ void free_unref_page(struct page *page, unsigned int order)
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
 		free_unref_page_commit(zone, pcp, page, migratetype, order);
-		pcp_spin_unlock_irqrestore(pcp, flags);
+		pcp_spin_unlock(pcp);
 	} else {
 		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
 	}
@@ -3512,7 +3481,6 @@ void free_unref_page_list(struct list_head *list)
 	struct page *page, *next;
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
-	unsigned long flags;
 	int batch_count = 0;
 	int migratetype;
 
@@ -3542,10 +3510,10 @@ void free_unref_page_list(struct list_head *list)
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
 			if (pcp)
-				pcp_spin_unlock_irqrestore(pcp, flags);
+				pcp_spin_unlock(pcp);
 
 			locked_zone = zone;
-			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
+			pcp = pcp_spin_lock(locked_zone->per_cpu_pageset);
 		}
 
 		/*
@@ -3564,14 +3532,14 @@ void free_unref_page_list(struct list_head *list)
 		 * a large list of pages to free.
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
-			pcp_spin_unlock_irqrestore(pcp, flags);
+			pcp_spin_unlock(pcp);
 			batch_count = 0;
-			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
+			pcp = pcp_spin_lock(locked_zone->per_cpu_pageset);
 		}
 	}
 
 	if (pcp)
-		pcp_spin_unlock_irqrestore(pcp, flags);
+		pcp_spin_unlock(pcp);
 }
 
 /*
@@ -3783,15 +3751,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
 	struct page *page;
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 
-	/*
-	 * spin_trylock may fail due to a parallel drain. In the future, the
-	 * trylock will also protect against IRQ reentrancy.
-	 */
+	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp) {
 		pcp_trylock_finish(UP_flags);
 		return NULL;
@@ -3805,7 +3769,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
-	pcp_spin_unlock_irqrestore(pcp, flags);
+	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
@@ -5329,7 +5293,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			struct page **page_array)
 {
 	struct page *page;
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 	struct zone *zone;
 	struct zoneref *z;
@@ -5411,9 +5374,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
-	/* Is a parallel drain in progress? */
+	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp)
 		goto failed_irq;
 
@@ -5432,7 +5395,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
 			if (!nr_account) {
-				pcp_spin_unlock_irqrestore(pcp, flags);
+				pcp_spin_unlock(pcp);
 				goto failed_irq;
 			}
 			break;
@@ -5447,7 +5410,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	pcp_spin_unlock_irqrestore(pcp, flags);
+	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-- 
2.35.3

