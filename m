Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3789A526597
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381666AbiEMPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378548AbiEMPEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:04:08 -0400
Received: from outbound-smtp37.blacknight.com (outbound-smtp37.blacknight.com [46.22.139.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41D85251B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:04:05 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 51AE836DD
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:04:04 +0100 (IST)
Received: (qmail 23682 invoked from network); 13 May 2022 15:04:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 May 2022 15:04:04 -0000
Date:   Fri, 13 May 2022 16:04:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] mm/page_alloc: Remotely drain per-cpu lists
Message-ID: <20220513150402.GJ3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-7-mgorman@techsingularity.net>
 <20220512123743.5be26b3ad4413f20d5f46564@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220512123743.5be26b3ad4413f20d5f46564@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:37:43PM -0700, Andrew Morton wrote:
> On Thu, 12 May 2022 09:50:43 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > From: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > 
> > Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
> > drain work queued by __drain_all_pages(). So introduce a new mechanism to
> > remotely drain the per-cpu lists. It is made possible by remotely locking
> > 'struct per_cpu_pages' new per-cpu spinlocks. A benefit of this new scheme
> > is that drain operations are now migration safe.
> > 
> > There was no observed performance degradation vs. the previous scheme.
> > Both netperf and hackbench were run in parallel to triggering the
> > __drain_all_pages(NULL, true) code path around ~100 times per second.
> > The new scheme performs a bit better (~5%), although the important point
> > here is there are no performance regressions vs. the previous mechanism.
> > Per-cpu lists draining happens only in slow paths.
> > 
> > Minchan Kim tested this independently and reported;
> > 
> > 	My workload is not NOHZ CPUs but run apps under heavy memory
> > 	pressure so they goes to direct reclaim and be stuck on
> > 	drain_all_pages until work on workqueue run.
> > 
> > 	unit: nanosecond
> > 	max(dur)        avg(dur)                count(dur)
> > 	166713013       487511.77786438033      1283
> > 
> > 	From traces, system encountered the drain_all_pages 1283 times and
> > 	worst case was 166ms and avg was 487us.
> > 
> > 	The other problem was alloc_contig_range in CMA. The PCP draining
> > 	takes several hundred millisecond sometimes though there is no
> > 	memory pressure or a few of pages to be migrated out but CPU were
> > 	fully booked.
> > 
> > 	Your patch perfectly removed those wasted time.
> 
> I'm not getting a sense here of the overall effect upon userspace
> performance.  As Thomas said last year in
> https://lkml.kernel.org/r/87v92sgt3n.ffs@tglx
> 
> : The changelogs and the cover letter have a distinct void vs. that which
> : means this is just another example of 'scratch my itch' changes w/o
> : proper justification.
> 
> Is there more to all of this than itchiness and if so, well, you know
> the rest ;)
> 

I think Minchan's example is clear-cut.  The draining operation can take
an arbitrary amount of time waiting for the workqueue to run on each CPU
and can cause severe delays under reclaim or CMA and the patch fixes
it. Maybe most users won't even notice but I bet phone users do if a
camera app takes too long to open.

The first paragraphs was written by Nicolas and I did not want to modify
it heavily and still put his Signed-off-by on it. Maybe it could have
been clearer though because "too busy" is vague when the actual intent
is to avoid interfering with RT tasks. Does this sound better to you?

	Some setups, notably NOHZ_FULL CPUs, may be running realtime or
	latency-sensitive applications that cannot tolerate interference
	due to per-cpu drain work queued by __drain_all_pages(). Introduce
	a new mechanism to remotely drain the per-cpu lists. It is made
	possible by remotely locking 'struct per_cpu_pages' new per-cpu
	spinlocks. This has two advantages, the time to drain is more
	predictable and other unrelated tasks are not interrupted.

You raise a very valid point with Thomas' mail and it is a concern that
the local_lock is no longer strictly local. We still need preemption to
be disabled between the percpu lookup and the lock acquisition but that
can be done with get_cpu_var() to make the scope clear.

Assuming this passes testing and review, would something like this be
preferable to you? It removes pcp_trylock_* because spin_trylock_irqsave
does not have the same problems on !SMP as spin_trylock but something like
it would come back if spin_lock_irqsave(pcp) was converted to spin_lock().

--8<--
mm/page_alloc: Replace local_lock with get_cpu_var

struct per_cpu_pages is no longer strictly local as PCP lists can be
drained remotely using a lock for protection. While the use of local_lock
works, it goes against the intent of local_lock which is for "pure
CPU local concurrency control mechanisms and not suited for inter-CPU
concurrency control" (Documentation/locking/locktypes.rst)

local_lock protects against migration between when the percpu pointer is
accessed and the pcp->lock acquired. The lock acquisition is a preemption
point so in the worst case, a task could migrate to another NUMA node
and accidentally allocate remote memory.

Replace local_lock with get_cpu_var to make it clear what disabling
preemption is protecting.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 144 +++++++++++++++++++-------------------------------------
 1 file changed, 48 insertions(+), 96 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0f5a6a5b0302..5c06139d8c5a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -125,27 +125,6 @@ typedef int __bitwise fpi_t;
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
 
-struct pagesets {
-	local_lock_t lock;
-};
-static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
-
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
-/*
- * On SMP, spin_trylock is sufficient protection.
- * On PREEMPT_RT, spin_trylock is equivalent on both SMP and UP.
- */
-#define pcp_trylock_prepare(flags)	do { } while (0)
-#define pcp_trylock_finish(flag)	do { } while (0)
-#else
-
-/* UP spin_trylock always succeeds so disable IRQs to prevent re-entrancy. */
-#define pcp_trylock_prepare(flags)	local_irq_save(flags)
-#define pcp_trylock_finish(flags)	local_irq_restore(flags)
-#endif
-
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -1466,10 +1445,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
-	/*
-	 * local_lock_irq held so equivalent to spin_lock_irqsave for
-	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
-	 */
+	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
 	spin_lock(&zone->lock);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
@@ -3037,10 +3013,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 {
 	int i, allocated = 0;
 
-	/*
-	 * local_lock_irq held so equivalent to spin_lock_irqsave for
-	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
-	 */
+	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
@@ -3354,28 +3327,20 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 }
 
 /* Returns true if the page was committed to the per-cpu list. */
-static bool free_unref_page_commit(struct page *page, int migratetype,
+static bool free_unref_page_commit(struct per_cpu_pages *pcp, struct zone *zone,
+				   struct page *page, int migratetype,
 				   unsigned int order, bool locked)
 {
-	struct zone *zone = page_zone(page);
-	struct per_cpu_pages *pcp;
 	int high;
 	int pindex;
 	bool free_high;
-	unsigned long __maybe_unused UP_flags;
+	unsigned long flags;
 
 	__count_vm_event(PGFREE);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pindex = order_to_pindex(migratetype, order);
 
-	if (!locked) {
-		/* Protect against a parallel drain. */
-		pcp_trylock_prepare(UP_flags);
-		if (!spin_trylock(&pcp->lock)) {
-			pcp_trylock_finish(UP_flags);
-			return false;
-		}
-	}
+	if (!locked && !spin_trylock_irqsave(&pcp->lock, flags))
+		return false;
 
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
@@ -3395,10 +3360,8 @@ static bool free_unref_page_commit(struct page *page, int migratetype,
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch, free_high), pcp, pindex);
 	}
 
-	if (!locked) {
-		spin_unlock(&pcp->lock);
-		pcp_trylock_finish(UP_flags);
-	}
+	if (!locked)
+		spin_unlock_irqrestore(&pcp->lock, flags);
 
 	return true;
 }
@@ -3408,7 +3371,8 @@ static bool free_unref_page_commit(struct page *page, int migratetype,
  */
 void free_unref_page(struct page *page, unsigned int order)
 {
-	unsigned long flags;
+	struct per_cpu_pages *pcp;
+	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
 	bool freed_pcp = false;
@@ -3432,9 +3396,10 @@ void free_unref_page(struct page *page, unsigned int order)
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
-	freed_pcp = free_unref_page_commit(page, migratetype, order, false);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	zone = page_zone(page);
+	pcp = &get_cpu_var(*zone->per_cpu_pageset);
+	freed_pcp = free_unref_page_commit(pcp, zone, page, migratetype, order, false);
+	put_cpu_var(*zone->per_cpu_pageset);
 
 	if (unlikely(!freed_pcp))
 		free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
@@ -3488,20 +3453,21 @@ void free_unref_page_list(struct list_head *list)
 
 	VM_BUG_ON(in_hardirq());
 
-	local_lock_irqsave(&pagesets.lock, flags);
-
 	page = lru_to_page(list);
 	locked_zone = page_zone(page);
-	pcp = this_cpu_ptr(locked_zone->per_cpu_pageset);
-	spin_lock(&pcp->lock);
+	pcp = &get_cpu_var(*locked_zone->per_cpu_pageset);
+	spin_lock_irqsave(&pcp->lock, flags);
 
 	list_for_each_entry_safe(page, next, list, lru) {
 		struct zone *zone = page_zone(page);
 
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
+			/* Leave IRQs enabled as a new lock is acquired. */
 			spin_unlock(&pcp->lock);
 			locked_zone = zone;
+
+			/* Preemption already disabled by get_cpu_var. */
 			pcp = this_cpu_ptr(zone->per_cpu_pageset);
 			spin_lock(&pcp->lock);
 		}
@@ -3522,27 +3488,26 @@ void free_unref_page_list(struct list_head *list)
 		 * be acquired multiple times but if a drain is in progress
 		 * then an expensive operation is already taking place.
 		 *
-		 * TODO: Always false at the moment due to local_lock_irqsave
-		 *       and is preparation for converting to local_lock.
+		 * TODO: Always false at the moment due to spin_lock_irqsave
+		 *       and is preparation for converting to spin_lock.
 		 */
-		if (unlikely(!free_unref_page_commit(page, migratetype, 0, true)))
-			free_one_page(page_zone(page), page, page_to_pfn(page), 0, migratetype, FPI_NONE);
+		if (unlikely(!free_unref_page_commit(pcp, zone, page, migratetype, 0, true)))
+			free_one_page(zone, page, page_to_pfn(page), 0, migratetype, FPI_NONE);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
 		 * a large list of pages to free.
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
-			spin_unlock(&pcp->lock);
-			local_unlock_irqrestore(&pagesets.lock, flags);
+			spin_unlock_irqrestore(&pcp->lock, flags);
+			put_cpu_var(*locked_zone->per_cpu_pageset);
 			batch_count = 0;
-			local_lock_irqsave(&pagesets.lock, flags);
-			pcp = this_cpu_ptr(locked_zone->per_cpu_pageset);
-			spin_lock(&pcp->lock);
+			pcp = &get_cpu_var(*locked_zone->per_cpu_pageset);
+			spin_lock_irqsave(&pcp->lock, flags);
 		}
 	}
-	spin_unlock(&pcp->lock);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	spin_unlock_irqrestore(&pcp->lock, flags);
+	put_cpu_var(*locked_zone->per_cpu_pageset);
 }
 
 /*
@@ -3717,24 +3682,18 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			bool locked)
 {
 	struct page *page;
-	unsigned long __maybe_unused UP_flags;
+	unsigned long flags;
 
 	/*
 	 * spin_trylock is not necessary right now due to due to
-	 * local_lock_irqsave and is a preparation step for
-	 * a conversion to local_lock using the trylock to prevent
-	 * IRQ re-entrancy. If pcp->lock cannot be acquired, the caller
-	 * uses rmqueue_buddy.
+	 * IRQ-safe pcp->lock and is a preparation step for a conversion to
+	 * spin_lock using the trylock to prevent IRQ re-entrancy. If
+	 * pcp->lock cannot be acquired, the caller uses rmqueue_buddy.
 	 *
-	 * TODO: Convert local_lock_irqsave to local_lock.
+	 * TODO: Convert pcp spin_lock_irqsave to spin_lock.
 	 */
-	if (unlikely(!locked)) {
-		pcp_trylock_prepare(UP_flags);
-		if (!spin_trylock(&pcp->lock)) {
-			pcp_trylock_finish(UP_flags);
-			return NULL;
-		}
-	}
+	if (!locked && !spin_trylock_irqsave(&pcp->lock, flags))
+		return NULL;
 
 	do {
 		if (list_empty(list)) {
@@ -3767,10 +3726,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 	} while (check_new_pcp(page, order));
 
 out:
-	if (!locked) {
-		spin_unlock(&pcp->lock);
-		pcp_trylock_finish(UP_flags);
-	}
+	if (!locked)
+		spin_unlock_irqrestore(&pcp->lock, flags);
 
 	return page;
 }
@@ -3784,20 +3741,17 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
 	struct page *page;
-	unsigned long flags;
-
-	local_lock_irqsave(&pagesets.lock, flags);
 
 	/*
 	 * On allocation, reduce the number of pages that are batch freed.
 	 * See nr_pcp_free() where free_factor is increased for subsequent
 	 * frees.
 	 */
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	pcp = &get_cpu_var(*zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list, false);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	put_cpu_var(*zone->per_cpu_pageset);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone, 1);
@@ -5396,10 +5350,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Attempt the batch allocation */
-	local_lock_irqsave(&pagesets.lock, flags);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	pcp = &get_cpu_var(*zone->per_cpu_pageset);
 	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
-	spin_lock(&pcp->lock);
+	spin_lock_irqsave(&pcp->lock, flags);
 
 	while (nr_populated < nr_pages) {
 
@@ -5413,10 +5366,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 							pcp, pcp_list, true);
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
-			if (!nr_populated) {
-				spin_unlock(&pcp->lock);
+			if (!nr_populated)
 				goto failed_irq;
-			}
 			break;
 		}
 		nr_account++;
@@ -5429,8 +5380,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	spin_unlock(&pcp->lock);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	spin_unlock_irqrestore(&pcp->lock, flags);
+	put_cpu_var(*zone->per_cpu_pageset);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
@@ -5439,7 +5390,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	return nr_populated;
 
 failed_irq:
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	spin_unlock_irqrestore(&pcp->lock, flags);
+	put_cpu_var(*zone->per_cpu_pageset);
 
 failed:
 	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);


-- 
Mel Gorman
SUSE Labs
