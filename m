Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032795599F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiFXMzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiFXMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:55:31 -0400
Received: from outbound-smtp52.blacknight.com (outbound-smtp52.blacknight.com [46.22.136.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023F625A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:55:29 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp52.blacknight.com (Postfix) with ESMTPS id 20F2AFAC5D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:55:28 +0100 (IST)
Received: (qmail 8629 invoked from network); 24 Jun 2022 12:55:27 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 24 Jun 2022 12:55:27 -0000
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
Subject: [PATCH 5/7] mm/page_alloc: Protect PCP lists with a spinlock
Date:   Fri, 24 Jun 2022 13:54:21 +0100
Message-Id: <20220624125423.6126-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220624125423.6126-1-mgorman@techsingularity.net>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

                                     5.19.0-rc3               5.19.0-rc3
                                        vanilla      mm-pcpspinirq-v5r16
Hmean     faults/sec-1   869275.7381 (   0.00%)   874597.5167 *   0.61%*
Hmean     faults/sec-3  2370266.6681 (   0.00%)  2379802.0362 *   0.40%*
Hmean     faults/sec-5  2701099.7019 (   0.00%)  2664889.7003 *  -1.34%*
Hmean     faults/sec-7  3517170.9157 (   0.00%)  3491122.8242 *  -0.74%*
Hmean     faults/sec-8  3965729.6187 (   0.00%)  3939727.0243 *  -0.66%*

There is a small hit in the number of faults per second but given that the
results are more stable, it's borderline noise.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/mmzone.h |   1 +
 mm/page_alloc.c        | 118 +++++++++++++++++++++++++++++++++--------
 2 files changed, 98 insertions(+), 21 deletions(-)

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
index 7fb262eeec2f..3b819c2720f8 100644
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
@@ -3395,17 +3417,15 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 	return min(READ_ONCE(pcp->batch) << 2, high);
 }
 
-static void free_unref_page_commit(struct page *page, int migratetype,
+static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
+				   struct page *page, int migratetype,
 				   unsigned int order)
 {
-	struct zone *zone = page_zone(page);
-	struct per_cpu_pages *pcp;
 	int high;
 	int pindex;
 	bool free_high;
 
 	__count_vm_event(PGFREE);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pindex = order_to_pindex(migratetype, order);
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
@@ -3432,6 +3452,9 @@ static void free_unref_page_commit(struct page *page, int migratetype,
 void free_unref_page(struct page *page, unsigned int order)
 {
 	unsigned long flags;
+	unsigned long __maybe_unused UP_flags;
+	struct per_cpu_pages *pcp;
+	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
 
@@ -3455,7 +3478,16 @@ void free_unref_page(struct page *page, unsigned int order)
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, migratetype, order);
+	zone = page_zone(page);
+	pcp_trylock_prepare(UP_flags);
+	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	if (spin_trylock(&pcp->lock)) {
+		free_unref_page_commit(zone, pcp, page, migratetype, order);
+		spin_unlock(&pcp->lock);
+	} else {
+		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
+	}
+	pcp_trylock_finish(UP_flags);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
@@ -3465,6 +3497,8 @@ void free_unref_page(struct page *page, unsigned int order)
 void free_unref_page_list(struct list_head *list)
 {
 	struct page *page, *next;
+	struct per_cpu_pages *pcp = NULL;
+	struct zone *locked_zone = NULL;
 	unsigned long flags;
 	int batch_count = 0;
 	int migratetype;
@@ -3491,6 +3525,17 @@ void free_unref_page_list(struct list_head *list)
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
+		struct zone *zone = page_zone(page);
+
+		/* Different zone, different pcp lock. */
+		if (zone != locked_zone) {
+			if (pcp)
+				spin_unlock(&pcp->lock);
+			locked_zone = zone;
+			pcp = this_cpu_ptr(zone->per_cpu_pageset);
+			spin_lock(&pcp->lock);
+		}
+
 		/*
 		 * Non-isolated types over MIGRATE_PCPTYPES get added
 		 * to the MIGRATE_MOVABLE pcp list.
@@ -3500,18 +3545,24 @@ void free_unref_page_list(struct list_head *list)
 			migratetype = MIGRATE_MOVABLE;
 
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, migratetype, 0);
+		free_unref_page_commit(zone, pcp, page, migratetype, 0);
 
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
+
+	if (pcp)
+		spin_unlock(&pcp->lock);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
@@ -3725,18 +3776,31 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct list_head *list;
 	struct page *page;
 	unsigned long flags;
+	unsigned long __maybe_unused UP_flags;
 
 	local_lock_irqsave(&pagesets.lock, flags);
 
+	/*
+	 * spin_trylock may fail due to a parallel drain. In the future, the
+	 * trylock will also protect against IRQ reentrancy.
+	 */
+	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	pcp_trylock_prepare(UP_flags);
+	if (!spin_trylock(&pcp->lock)) {
+		pcp_trylock_finish(UP_flags);
+		return NULL;
+	}
+
 	/*
 	 * On allocation, reduce the number of pages that are batch freed.
 	 * See nr_pcp_free() where free_factor is increased for subsequent
 	 * frees.
 	 */
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	spin_unlock(&pcp->lock);
+	pcp_trylock_finish(UP_flags);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
@@ -3771,7 +3835,8 @@ struct page *rmqueue(struct zone *preferred_zone,
 				migratetype != MIGRATE_MOVABLE) {
 			page = rmqueue_pcplist(preferred_zone, zone, order,
 					gfp_flags, migratetype, alloc_flags);
-			goto out;
+			if (likely(page))
+				goto out;
 		}
 	}
 
@@ -5259,6 +5324,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 {
 	struct page *page;
 	unsigned long flags;
+	unsigned long __maybe_unused UP_flags;
 	struct zone *zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
@@ -5339,11 +5405,15 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
-	/* Attempt the batch allocation */
+	/* Is a parallel drain in progress? */
 	local_lock_irqsave(&pagesets.lock, flags);
+	pcp_trylock_prepare(UP_flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
+	if (!spin_trylock(&pcp->lock))
+		goto failed_irq;
 
+	/* Attempt the batch allocation */
+	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
 	while (nr_populated < nr_pages) {
 
 		/* Skip existing pages */
@@ -5356,8 +5426,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 								pcp, pcp_list);
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
@@ -5370,6 +5442,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
+	spin_unlock(&pcp->lock);
+	pcp_trylock_finish(UP_flags);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
@@ -5379,6 +5453,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	return nr_populated;
 
 failed_irq:
+	pcp_trylock_finish(UP_flags);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 
 failed:
@@ -7019,6 +7094,7 @@ static void per_cpu_pages_init(struct per_cpu_pages *pcp, struct per_cpu_zonesta
 	memset(pcp, 0, sizeof(*pcp));
 	memset(pzstats, 0, sizeof(*pzstats));
 
+	spin_lock_init(&pcp->lock);
 	for (pindex = 0; pindex < NR_PCP_LISTS; pindex++)
 		INIT_LIST_HEAD(&pcp->lists[pindex]);
 
-- 
2.35.3

