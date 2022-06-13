Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CD549A07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbiFMRb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiFMRbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:31:43 -0400
Received: from outbound-smtp46.blacknight.com (outbound-smtp46.blacknight.com [46.22.136.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1B266210
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:57:27 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id C4404FA770
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:57:25 +0100 (IST)
Received: (qmail 29632 invoked from network); 13 Jun 2022 12:57:24 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 13 Jun 2022 12:57:24 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/7] mm/page_alloc: Protect PCP lists with a spinlock
Date:   Mon, 13 Jun 2022 13:56:20 +0100
Message-Id: <20220613125622.18628-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220613125622.18628-1-mgorman@techsingularity.net>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
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

Currently the PCP lists are protected by using local_lock_irqsave to
prevent migration and IRQ reentrancy but this is inconvenient.  Remote
draining of the lists is impossible and a workqueue is required and every
task allocation/free must disable then enable interrupts which is
expensive.

As preparation for dealing with both of those problems, protect the lists
with a spinlock.  The IRQ-unsafe version of the lock is used because IRQs
are already disabled by local_lock_irqsave.  spin_trylock is used in
preparation for a time when local_lock could be used instead of
lock_lock_irqsave.

The per_cpu_pages still fits within the same number of cache lines after
this patch relative to before the series.

struct per_cpu_pages {
        spinlock_t                 lock;                 /*     0     4 */
        int                        count;                /*     4     4 */
        int                        high;                 /*     8     4 */
        int                        batch;                /*    12     4 */
        short int                  free_factor;          /*    16     2 */
        short int                  expire;               /*    18     2 */

        /* XXX 4 bytes hole, try to pack */

        struct list_head           lists[13];            /*    24   208 */

        /* size: 256, cachelines: 4, members: 7 */
        /* sum members: 228, holes: 1, sum holes: 4 */
        /* padding: 24 */
} __attribute__((__aligned__(64)));

There is overhead in the fast path due to acquiring the spinlock even
though the spinlock is per-cpu and uncontended in the common case.  Page
Fault Test (PFT) running on a 1-socket reported the following results on a
1 socket machine.

                                     5.18.0-rc1               5.18.0-rc1
                                        vanilla         mm-pcpdrain-v2r1
Hmean     faults/sec-1   886331.5718 (   0.00%)   885462.7479 (  -0.10%)
Hmean     faults/sec-3  2337706.1583 (   0.00%)  2332130.4909 *  -0.24%*
Hmean     faults/sec-5  2851594.2897 (   0.00%)  2844123.9307 (  -0.26%)
Hmean     faults/sec-7  3543251.5507 (   0.00%)  3516889.0442 *  -0.74%*
Hmean     faults/sec-8  3947098.0024 (   0.00%)  3916162.8476 *  -0.78%*
Stddev    faults/sec-1     2302.9105 (   0.00%)     2065.0845 (  10.33%)
Stddev    faults/sec-3     7275.2442 (   0.00%)     6033.2620 (  17.07%)
Stddev    faults/sec-5    24726.0328 (   0.00%)    12525.1026 (  49.34%)
Stddev    faults/sec-7     9974.2542 (   0.00%)     9543.9627 (   4.31%)
Stddev    faults/sec-8     9468.0191 (   0.00%)     7958.2607 (  15.95%)
CoeffVar  faults/sec-1        0.2598 (   0.00%)        0.2332 (  10.24%)
CoeffVar  faults/sec-3        0.3112 (   0.00%)        0.2587 (  16.87%)
CoeffVar  faults/sec-5        0.8670 (   0.00%)        0.4404 (  49.21%)
CoeffVar  faults/sec-7        0.2815 (   0.00%)        0.2714 (   3.60%)
CoeffVar  faults/sec-8        0.2399 (   0.00%)        0.2032 (  15.28%)

There is a small hit in the number of faults per second but given that the
results are more stable, it's borderline noise.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: Minchan Kim <minchan@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/mmzone.h |   1 +
 mm/page_alloc.c        | 167 +++++++++++++++++++++++++++++++++++------
 2 files changed, 147 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4e0352cc2fcb..299259cfe462 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -382,6 +382,7 @@ enum zone_watermarks {
 
 /* Fields and list protected by pagesets local_lock in page_alloc.c */
 struct per_cpu_pages {
+	spinlock_t lock;	/* Protects lists field */
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7fb262eeec2f..533fc5527582 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -133,6 +133,20 @@ static DEFINE_PER_CPU(struct pagesets, pagesets) = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+/*
+ * On SMP, spin_trylock is sufficient protection.
+ * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
+ */
+#define pcp_trylock_prepare(flags)	do { } while (0)
+#define pcp_trylock_finish(flag)	do { } while (0)
+#else
+
+/* UP spin_trylock always succeeds so disable IRQs to prevent re-entrancy. */
+#define pcp_trylock_prepare(flags)	local_irq_save(flags)
+#define pcp_trylock_finish(flags)	local_irq_restore(flags)
+#endif
+
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -3097,15 +3111,22 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  */
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
-	unsigned long flags;
 	int to_drain, batch;
 
-	local_lock_irqsave(&pagesets.lock, flags);
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
-	if (to_drain > 0)
+	if (to_drain > 0) {
+		unsigned long flags;
+
+		/*
+		 * free_pcppages_bulk expects IRQs disabled for zone->lock
+		 * so even though pcp->lock is not intended to be IRQ-safe,
+		 * it's needed in this context.
+		 */
+		spin_lock_irqsave(&pcp->lock, flags);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+		spin_unlock_irqrestore(&pcp->lock, flags);
+	}
 }
 #endif
 
@@ -3118,16 +3139,17 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
  */
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
-	unsigned long flags;
 	struct per_cpu_pages *pcp;
 
-	local_lock_irqsave(&pagesets.lock, flags);
-
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	if (pcp->count)
-		free_pcppages_bulk(zone, pcp->count, pcp, 0);
+	if (pcp->count) {
+		unsigned long flags;
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
+		/* See drain_zone_pages on why this is disabling IRQs */
+		spin_lock_irqsave(&pcp->lock, flags);
+		free_pcppages_bulk(zone, pcp->count, pcp, 0);
+		spin_unlock_irqrestore(&pcp->lock, flags);
+	}
 }
 
 /*
@@ -3395,18 +3417,30 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 	return min(READ_ONCE(pcp->batch) << 2, high);
 }
 
-static void free_unref_page_commit(struct page *page, int migratetype,
-				   unsigned int order)
+/* Returns true if the page was committed to the per-cpu list. */
+static bool free_unref_page_commit(struct page *page, int migratetype,
+				   unsigned int order, bool locked)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
 	int high;
 	int pindex;
 	bool free_high;
+	unsigned long __maybe_unused UP_flags;
 
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pindex = order_to_pindex(migratetype, order);
+
+	if (!locked) {
+		/* Protect against a parallel drain. */
+		pcp_trylock_prepare(UP_flags);
+		if (!spin_trylock(&pcp->lock)) {
+			pcp_trylock_finish(UP_flags);
+			return false;
+		}
+	}
+
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
 
@@ -3424,6 +3458,13 @@ static void free_unref_page_commit(struct page *page, int migratetype,
 
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch, free_high), pcp, pindex);
 	}
+
+	if (!locked) {
+		spin_unlock(&pcp->lock);
+		pcp_trylock_finish(UP_flags);
+	}
+
+	return true;
 }
 
 /*
@@ -3434,6 +3475,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
+	bool freed_pcp = false;
 
 	if (!free_unref_page_prepare(page, pfn, order))
 		return;
@@ -3455,8 +3497,11 @@ void free_unref_page(struct page *page, unsigned int order)
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, migratetype, order);
+	freed_pcp = free_unref_page_commit(page, migratetype, order, false);
 	local_unlock_irqrestore(&pagesets.lock, flags);
+
+	if (unlikely(!freed_pcp))
+		free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
 }
 
 /*
@@ -3465,10 +3510,19 @@ void free_unref_page(struct page *page, unsigned int order)
 void free_unref_page_list(struct list_head *list)
 {
 	struct page *page, *next;
+	struct per_cpu_pages *pcp;
+	struct zone *locked_zone;
 	unsigned long flags;
 	int batch_count = 0;
 	int migratetype;
 
+	/*
+	 * An empty list is possible. Check early so that the later
+	 * lru_to_page() does not potentially read garbage.
+	 */
+	if (list_empty(list))
+		return;
+
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_to_pfn(page);
@@ -3489,8 +3543,31 @@ void free_unref_page_list(struct list_head *list)
 		}
 	}
 
+	/*
+	 * Preparation could have drained the list due to failing to prepare
+	 * or all pages are being isolated.
+	 */
+	if (list_empty(list))
+		return;
+
 	local_lock_irqsave(&pagesets.lock, flags);
+
+	page = lru_to_page(list);
+	locked_zone = page_zone(page);
+	pcp = this_cpu_ptr(locked_zone->per_cpu_pageset);
+	spin_lock(&pcp->lock);
+
 	list_for_each_entry_safe(page, next, list, lru) {
+		struct zone *zone = page_zone(page);
+
+		/* Different zone, different pcp lock. */
+		if (zone != locked_zone) {
+			spin_unlock(&pcp->lock);
+			locked_zone = zone;
+			pcp = this_cpu_ptr(zone->per_cpu_pageset);
+			spin_lock(&pcp->lock);
+		}
+
 		/*
 		 * Non-isolated types over MIGRATE_PCPTYPES get added
 		 * to the MIGRATE_MOVABLE pcp list.
@@ -3500,18 +3577,33 @@ void free_unref_page_list(struct list_head *list)
 			migratetype = MIGRATE_MOVABLE;
 
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, migratetype, 0);
+
+		/*
+		 * If there is a parallel drain in progress, free to the buddy
+		 * allocator directly. This is expensive as the zone lock will
+		 * be acquired multiple times but if a drain is in progress
+		 * then an expensive operation is already taking place.
+		 *
+		 * TODO: Always false at the moment due to local_lock_irqsave
+		 *       and is preparation for converting to local_lock.
+		 */
+		if (unlikely(!free_unref_page_commit(page, migratetype, 0, true)))
+			free_one_page(page_zone(page), page, page_to_pfn(page), 0, migratetype, FPI_NONE);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
 		 * a large list of pages to free.
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
+			spin_unlock(&pcp->lock);
 			local_unlock_irqrestore(&pagesets.lock, flags);
 			batch_count = 0;
 			local_lock_irqsave(&pagesets.lock, flags);
+			pcp = this_cpu_ptr(locked_zone->per_cpu_pageset);
+			spin_lock(&pcp->lock);
 		}
 	}
+	spin_unlock(&pcp->lock);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
@@ -3680,9 +3772,28 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int migratetype,
 			unsigned int alloc_flags,
 			struct per_cpu_pages *pcp,
-			struct list_head *list)
+			struct list_head *list,
+			bool locked)
 {
 	struct page *page;
+	unsigned long __maybe_unused UP_flags;
+
+	/*
+	 * spin_trylock is not necessary right now due to due to
+	 * local_lock_irqsave and is a preparation step for
+	 * a conversion to local_lock using the trylock to prevent
+	 * IRQ re-entrancy. If pcp->lock cannot be acquired, the caller
+	 * uses rmqueue_buddy.
+	 *
+	 * TODO: Convert local_lock_irqsave to local_lock.
+	 */
+	if (unlikely(!locked)) {
+		pcp_trylock_prepare(UP_flags);
+		if (!spin_trylock(&pcp->lock)) {
+			pcp_trylock_finish(UP_flags);
+			return NULL;
+		}
+	}
 
 	do {
 		if (list_empty(list)) {
@@ -3703,8 +3814,10 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 					migratetype, alloc_flags);
 
 			pcp->count += alloced << order;
-			if (unlikely(list_empty(list)))
-				return NULL;
+			if (unlikely(list_empty(list))) {
+				page = NULL;
+				goto out;
+			}
 		}
 
 		page = list_first_entry(list, struct page, pcp_list);
@@ -3712,6 +3825,12 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 		pcp->count -= 1 << order;
 	} while (check_new_pcp(page, order));
 
+out:
+	if (!locked) {
+		spin_unlock(&pcp->lock);
+		pcp_trylock_finish(UP_flags);
+	}
+
 	return page;
 }
 
@@ -3736,7 +3855,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
-	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list, false);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
@@ -3771,7 +3890,8 @@ struct page *rmqueue(struct zone *preferred_zone,
 				migratetype != MIGRATE_MOVABLE) {
 			page = rmqueue_pcplist(preferred_zone, zone, order,
 					gfp_flags, migratetype, alloc_flags);
-			goto out;
+			if (likely(page))
+				goto out;
 		}
 	}
 
@@ -5343,6 +5463,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
+	spin_lock(&pcp->lock);
 
 	while (nr_populated < nr_pages) {
 
@@ -5353,11 +5474,13 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		}
 
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
-								pcp, pcp_list);
+							pcp, pcp_list, true);
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
-			if (!nr_account)
+			if (!nr_account) {
+				spin_unlock(&pcp->lock);
 				goto failed_irq;
+			}
 			break;
 		}
 		nr_account++;
@@ -5370,6 +5493,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
+	spin_unlock(&pcp->lock);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
@@ -7019,6 +7143,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	memset(pcp, 0, sizeof(*pcp));
 	memset(pzstats, 0, sizeof(*pzstats));
 
+	spin_lock_init(&pcp->lock);
 	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
 		INIT_LIST_HEAD(&pcp->lists[pindex]);
 
-- 
2.35.3

