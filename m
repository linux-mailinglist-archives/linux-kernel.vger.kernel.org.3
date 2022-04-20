Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801FC508562
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377430AbiDTKDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242487AbiDTKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:02:58 -0400
Received: from outbound-smtp43.blacknight.com (outbound-smtp43.blacknight.com [46.22.139.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE41ADB8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:00:12 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp43.blacknight.com (Postfix) with ESMTPS id 5A5B2211D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:00:11 +0100 (IST)
Received: (qmail 13237 invoked from network); 20 Apr 2022 10:00:11 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 20 Apr 2022 10:00:11 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
Date:   Wed, 20 Apr 2022 10:59:05 +0100
Message-Id: <20220420095906.27349-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420095906.27349-1-mgorman@techsingularity.net>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the PCP lists are protected by using local_lock_irqsave to
prevent migration and IRQ reentrancy but this is inconvenient. Remote
draining of the lists is impossible and a workqueue is required and
every task allocation/free must disable then enable interrupts which is
expensive.

As preparation for dealing with both of those problems, protect the
lists with a spinlock. The IRQ-unsafe version of the lock is used
because IRQs are already disabled by local_lock_irqsave. spin_trylock
is used in preparation for a time when local_lock could be used instead
of lock_lock_irqsave.

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

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h |   1 +
 mm/page_alloc.c        | 155 +++++++++++++++++++++++++++++++++++------
 2 files changed, 136 insertions(+), 20 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index abe530748de6..8b5757735428 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -385,6 +385,7 @@ enum zone_watermarks {
 
 /* Fields and list protected by pagesets local_lock in page_alloc.c */
 struct per_cpu_pages {
+	spinlock_t lock;	/* Protects lists field */
 	int count;		/* number of pages in the list */
 	int high;		/* high watermark, emptying needed */
 	int batch;		/* chunk size for buddy add/remove */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dc0fdeb3795c..813c84b67c65 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -132,6 +132,17 @@ static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
 
+#ifdef CONFIG_SMP
+/* On SMP, spin_trylock is sufficient protection */
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
@@ -3082,15 +3093,22 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
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
+		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
+		local_irq_save(flags);
+
+		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+		spin_unlock(&pcp->lock);
+
+		local_irq_restore(flags);
+	}
 }
 #endif
 
@@ -3103,16 +3121,21 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
  */
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
-	unsigned long flags;
 	struct per_cpu_pages *pcp;
 
-	local_lock_irqsave(&pagesets.lock, flags);
-
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	if (pcp->count)
+	if (pcp->count) {
+		unsigned long flags;
+
+		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
+		local_irq_save(flags);
+
+		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, pcp->count, pcp, 0);
+		spin_unlock(&pcp->lock);
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
+		local_irq_restore(flags);
+	}
 }
 
 /*
@@ -3380,18 +3403,30 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
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
 
@@ -3409,6 +3444,13 @@ static void free_unref_page_commit(struct page *page, int migratetype,
 
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
@@ -3419,6 +3461,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
+	bool freed_pcp = false;
 
 	if (!free_unref_page_prepare(page, pfn, order))
 		return;
@@ -3440,8 +3483,11 @@ void free_unref_page(struct page *page, unsigned int order)
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
@@ -3450,10 +3496,19 @@ void free_unref_page(struct page *page, unsigned int order)
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
@@ -3474,8 +3529,26 @@ void free_unref_page_list(struct list_head *list)
 		}
 	}
 
+	VM_BUG_ON(in_hardirq());
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
@@ -3485,18 +3558,25 @@ void free_unref_page_list(struct list_head *list)
 			migratetype = MIGRATE_MOVABLE;
 
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, migratetype, 0);
+
+		/* True is dead code at the moment due to local_lock_irqsave. */
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
 
@@ -3668,9 +3748,30 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
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
+	 * TODO: Convert local_lock_irqsave to local_lock. Care
+	 * 	 is needed as the type of local_lock would need a
+	 * 	 PREEMPT_RT version due to threaded IRQs.
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
@@ -3691,8 +3792,10 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 					migratetype, alloc_flags);
 
 			pcp->count += alloced << order;
-			if (unlikely(list_empty(list)))
-				return NULL;
+			if (unlikely(list_empty(list))) {
+				page = NULL;
+				goto out;
+			}
 		}
 
 		page = list_first_entry(list, struct page, lru);
@@ -3700,6 +3803,12 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
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
 
@@ -3724,7 +3833,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
-	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list, false);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
@@ -3759,7 +3868,8 @@ struct page *rmqueue(struct zone *preferred_zone,
 				migratetype != MIGRATE_MOVABLE) {
 			page = rmqueue_pcplist(preferred_zone, zone, order,
 					gfp_flags, migratetype, alloc_flags);
-			goto out;
+			if (likely(page))
+				goto out;
 		}
 	}
 
@@ -5326,6 +5436,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
+	spin_lock(&pcp->lock);
 
 	while (nr_populated < nr_pages) {
 
@@ -5336,11 +5447,13 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		}
 
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
-								pcp, pcp_list);
+							pcp, pcp_list, true);
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
-			if (!nr_populated)
+			if (!nr_populated) {
+				spin_unlock(&pcp->lock);
 				goto failed_irq;
+			}
 			break;
 		}
 		nr_account++;
@@ -5353,6 +5466,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
+	spin_unlock(&pcp->lock);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
@@ -6992,6 +7106,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	memset(pcp, 0, sizeof(*pcp));
 	memset(pzstats, 0, sizeof(*pzstats));
 
+	spin_lock_init(&pcp->lock);
 	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
 		INIT_LIST_HEAD(&pcp->lists[pindex]);
 
-- 
2.34.1

