Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C7552A246
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346677AbiEQM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346768AbiEQM5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:57:09 -0400
Received: from outbound-smtp23.blacknight.com (outbound-smtp23.blacknight.com [81.17.249.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F73EF24
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:57:06 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id CBAC8BED2A
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:57:04 +0100 (IST)
Received: (qmail 20201 invoked from network); 17 May 2022 12:57:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 May 2022 12:57:04 -0000
Date:   Tue, 17 May 2022 13:57:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] mm/page_alloc: Remotely drain per-cpu lists
Message-ID: <20220517125702.GN3441@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
 <20220512085043.5234-7-mgorman@techsingularity.net>
 <20220512123743.5be26b3ad4413f20d5f46564@linux-foundation.org>
 <20220513150402.GJ3441@techsingularity.net>
 <167d30f439d171912b1ef584f20219e67a009de8.camel@redhat.com>
 <20220513182301.GK3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220513182301.GK3441@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 07:23:01PM +0100, Mel Gorman wrote:
> > > You raise a very valid point with Thomas' mail and it is a concern that
> > > the local_lock is no longer strictly local. We still need preemption to
> > > be disabled between the percpu lookup and the lock acquisition but that
> > > can be done with get_cpu_var() to make the scope clear.
> > 
> > This isn't going to work in RT :(
> > 
> > get_cpu_var() disables preemption hampering RT spinlock use. There is more to
> > it in Documentation/locking/locktypes.rst.
> > 
> 
> Bah, you're right.  A helper that called preempt_disable() on !RT
> and migrate_disable() on RT would work although similar to local_lock
> with a different name. I'll look on Monday to see how the code could be
> restructured to always have the get_cpu_var() call immediately before the
> lock acquisition. Once that is done, I'll look what sort of helper that
> "disables preempt/migration, lookup pcp structure, acquire lock, enable
> preempt/migration". It's effectively the magic trick that local_lock uses
> to always lock the right pcpu lock but we want the spinlock semantics
> for remote drain.
> 

Monday was busier than I expected. Alternative to local_lock currently
looks like this but still needs testing. There is some churn because it
was no longer possible to have the CPU pinning separate from the spinlock
acquisition. It still should be possible to potentially make pcp->lock a
normal spinlock but I haven't confirmed that yet.

---8<---
mm/page_alloc: Replace local_lock with normal spinlock

struct per_cpu_pages is no longer strictly local as PCP lists can be
drained remotely using a lock for protection. While the use of local_lock
works, it goes against the intent of local_lock which is for "pure
CPU local concurrency control mechanisms and not suited for inter-CPU
concurrency control" (Documentation/locking/locktypes.rst)

local_lock protects against migration between when the percpu pointer is
accessed and the pcp->lock acquired. The lock acquisition is a preemption
point so in the worst case, a task could migrate to another NUMA node
and accidentally allocate remote memory. The main requirement is to pin
the task to a CPU that is suitable for PREEMPT_RT and !PREEMPT_RT.

Replace local_lock with helpers that pin a task to a CPU, lookup the
per-cpu structure and acquire the embedded lock. It's similar to local_lock
without breaking the intent behind the API.

---
 mm/page_alloc.c | 225 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 120 insertions(+), 105 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0f5a6a5b0302..d9c186bf498d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -125,13 +125,6 @@ typedef int __bitwise fpi_t;
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
 
-struct pagesets {
-	local_lock_t lock;
-};
-static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
-
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /*
  * On SMP, spin_trylock is sufficient protection.
@@ -146,6 +139,80 @@ static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
 #define pcp_trylock_finish(flags)	local_irq_restore(flags)
 #endif
 
+/*
+ * Locking a pcp requires a PCP lookup followed by a spinlock. To avoid
+ * a migration causing the wrong PCP to be locked and remote memory being
+ * potentially allocated, pin the task to the CPU for the lookup+lock.
+ * preempt_disable is used on !RT because it is faster than migrate_disable.
+ * migrate_disable is used on RT because otherwise RT spinlock usage is
+ * interfered with and a high priority task cannot preempt the allocator.
+ */
+#ifndef CONFIG_PREEMPT_RT
+#define pcpu_task_pin()		preempt_disable()
+#define pcpu_task_unpin()	preempt_enable()
+#else
+#define pcpu_task_pin()		migrate_disable()
+#define pcpu_task_unpin()	migrate_enable()
+#endif
+
+/* Generic helper to lookup and a per-cpu variable with an embedded spinlock.
+ * Return value should be used with equivalent unlock helper.
+ */
+#define pcpu_spin_lock(type, member, ptr)				\
+({									\
+	type *_ret;							\
+	pcpu_task_pin();						\
+	_ret = this_cpu_ptr(ptr);					\
+	spin_lock(&_ret->member);					\
+	_ret;								\
+})
+
+#define pcpu_spin_lock_irqsave(type, member, ptr, flags)		\
+({									\
+	type *_ret;							\
+	pcpu_task_pin();						\
+	_ret = this_cpu_ptr(ptr);					\
+	spin_lock_irqsave(&_ret->member, flags);			\
+	_ret;								\
+})
+
+#define pcpu_spin_trylock_irqsave(type, member, ptr, flags)		\
+({									\
+	type *_ret;							\
+	pcpu_task_pin();						\
+	_ret = this_cpu_ptr(ptr);					\
+	if (!spin_trylock_irqsave(&_ret->member, flags))		\
+		_ret = NULL;						\
+	_ret;								\
+})
+
+#define pcpu_spin_unlock(member, ptr)					\
+({									\
+	spin_unlock(&ptr->member);					\
+	pcpu_task_pin();						\
+})
+
+#define pcpu_spin_unlock_irqrestore(member, ptr, flags)			\
+({									\
+	spin_unlock_irqrestore(&ptr->member, flags);			\
+	pcpu_task_unpin();						\
+})
+
+/* struct per_cpu_pages specific helpers. */
+#define pcp_spin_lock(ptr)						\
+	pcpu_spin_lock(struct per_cpu_pages, lock, ptr)
+
+#define pcp_spin_lock_irqsave(ptr, flags)				\
+	pcpu_spin_lock_irqsave(struct per_cpu_pages, lock, ptr, flags)
+
+#define pcp_spin_trylock_irqsave(ptr, flags)				\
+	pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, ptr, flags)
+
+#define pcp_spin_unlock(ptr)						\
+	pcpu_spin_unlock(lock, ptr)
+
+#define pcp_spin_unlock_irqrestore(ptr, flags)				\
+	pcpu_spin_unlock_irqrestore(lock, ptr, flags)
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -1466,10 +1533,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
-	/*
-	 * local_lock_irq held so equivalent to spin_lock_irqsave for
-	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
-	 */
+	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
 	spin_lock(&zone->lock);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
@@ -3037,10 +3101,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
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
@@ -3353,30 +3414,17 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 	return min(READ_ONCE(pcp->batch) << 2, high);
 }
 
-/* Returns true if the page was committed to the per-cpu list. */
-static bool free_unref_page_commit(struct page *page, int migratetype,
-				   unsigned int order, bool locked)
+static void free_unref_page_commit(struct per_cpu_pages *pcp, struct zone *zone,
+				   struct page *page, int migratetype,
+				   unsigned int order)
 {
-	struct zone *zone = page_zone(page);
-	struct per_cpu_pages *pcp;
 	int high;
 	int pindex;
 	bool free_high;
-	unsigned long __maybe_unused UP_flags;
 
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
-
 	list_add(&page->pcp_list, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
 
@@ -3394,13 +3442,6 @@ static bool free_unref_page_commit(struct page *page, int migratetype,
 
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch, free_high), pcp, pindex);
 	}
-
-	if (!locked) {
-		spin_unlock(&pcp->lock);
-		pcp_trylock_finish(UP_flags);
-	}
-
-	return true;
 }
 
 /*
@@ -3408,10 +3449,12 @@ static bool free_unref_page_commit(struct page *page, int migratetype,
  */
 void free_unref_page(struct page *page, unsigned int order)
 {
-	unsigned long flags;
+	struct per_cpu_pages *pcp;
+	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
-	bool freed_pcp = false;
+	unsigned long flags;
+	unsigned long __maybe_unused UP_flags;
 
 	if (!free_unref_page_prepare(page, pfn, order))
 		return;
@@ -3432,12 +3475,16 @@ void free_unref_page(struct page *page, unsigned int order)
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
-	freed_pcp = free_unref_page_commit(page, migratetype, order, false);
-	local_unlock_irqrestore(&pagesets.lock, flags);
-
-	if (unlikely(!freed_pcp))
+	zone = page_zone(page);
+	pcp_trylock_prepare(UP_flags);
+	pcp = pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per_cpu_pageset, flags);
+	if (pcp) {
+		free_unref_page_commit(pcp, zone, page, migratetype, order);
+		pcp_spin_unlock_irqrestore(pcp, flags);
+	} else {
 		free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
+	}
+	pcp_trylock_finish(UP_flags);
 }
 
 /*
@@ -3488,20 +3535,20 @@ void free_unref_page_list(struct list_head *list)
 
 	VM_BUG_ON(in_hardirq());
 
-	local_lock_irqsave(&pagesets.lock, flags);
-
 	page = lru_to_page(list);
 	locked_zone = page_zone(page);
-	pcp = this_cpu_ptr(locked_zone->per_cpu_pageset);
-	spin_lock(&pcp->lock);
+	pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
 
 	list_for_each_entry_safe(page, next, list, lru) {
 		struct zone *zone = page_zone(page);
 
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
+			/* Leave IRQs enabled as a new lock is acquired. */
 			spin_unlock(&pcp->lock);
 			locked_zone = zone;
+
+			/* Preemption disabled by pcp_spin_lock_irqsave. */
 			pcp = this_cpu_ptr(zone->per_cpu_pageset);
 			spin_lock(&pcp->lock);
 		}
@@ -3516,33 +3563,19 @@ void free_unref_page_list(struct list_head *list)
 
 		trace_mm_page_free_batched(page);
 
-		/*
-		 * If there is a parallel drain in progress, free to the buddy
-		 * allocator directly. This is expensive as the zone lock will
-		 * be acquired multiple times but if a drain is in progress
-		 * then an expensive operation is already taking place.
-		 *
-		 * TODO: Always false at the moment due to local_lock_irqsave
-		 *       and is preparation for converting to local_lock.
-		 */
-		if (unlikely(!free_unref_page_commit(page, migratetype, 0, true)))
-			free_one_page(page_zone(page), page, page_to_pfn(page), 0, migratetype, FPI_NONE);
+		free_unref_page_commit(pcp, zone, page, migratetype, 0);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
 		 * a large list of pages to free.
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
-			spin_unlock(&pcp->lock);
-			local_unlock_irqrestore(&pagesets.lock, flags);
+			pcp_spin_unlock_irqrestore(pcp, flags);
 			batch_count = 0;
-			local_lock_irqsave(&pagesets.lock, flags);
-			pcp = this_cpu_ptr(locked_zone->per_cpu_pageset);
-			spin_lock(&pcp->lock);
+			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
 		}
 	}
-	spin_unlock(&pcp->lock);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pcp_spin_unlock_irqrestore(pcp, flags);
 }
 
 /*
@@ -3713,28 +3746,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int migratetype,
 			unsigned int alloc_flags,
 			struct per_cpu_pages *pcp,
-			struct list_head *list,
-			bool locked)
+			struct list_head *list)
 {
 	struct page *page;
-	unsigned long __maybe_unused UP_flags;
-
-	/*
-	 * spin_trylock is not necessary right now due to due to
-	 * local_lock_irqsave and is a preparation step for
-	 * a conversion to local_lock using the trylock to prevent
-	 * IRQ re-entrancy. If pcp->lock cannot be acquired, the caller
-	 * uses rmqueue_buddy.
-	 *
-	 * TODO: Convert local_lock_irqsave to local_lock.
-	 */
-	if (unlikely(!locked)) {
-		pcp_trylock_prepare(UP_flags);
-		if (!spin_trylock(&pcp->lock)) {
-			pcp_trylock_finish(UP_flags);
-			return NULL;
-		}
-	}
 
 	do {
 		if (list_empty(list)) {
@@ -3767,10 +3781,6 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 	} while (check_new_pcp(page, order));
 
 out:
-	if (!locked) {
-		spin_unlock(&pcp->lock);
-		pcp_trylock_finish(UP_flags);
-	}
 
 	return page;
 }
@@ -3785,19 +3795,29 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct list_head *list;
 	struct page *page;
 	unsigned long flags;
+	unsigned long __maybe_unused UP_flags;
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	/*
+	 * spin_trylock_irqsave is not necessary right now as it'll only be
+	 * true when contending with a remote drain. It's in place as a
+	 * preparation step before converting pcp locking to spin_trylock
+	 * to protect against IRQ reentry.
+	 */
+	pcp_trylock_prepare(UP_flags);
+	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	if (!pcp)
+		return NULL;
 
 	/*
 	 * On allocation, reduce the number of pages that are batch freed.
 	 * See nr_pcp_free() where free_factor is increased for subsequent
 	 * frees.
 	 */
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
-	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list, false);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	pcp_spin_unlock_irqrestore(pcp, flags);
+	pcp_trylock_finish(UP_flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone, 1);
@@ -5396,10 +5416,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Attempt the batch allocation */
-	local_lock_irqsave(&pagesets.lock, flags);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	pcp = pcp_spin_lock_irqsave(zone->per_cpu_pageset, flags);
 	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
-	spin_lock(&pcp->lock);
 
 	while (nr_populated < nr_pages) {
 
@@ -5410,13 +5428,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		}
 
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
-							pcp, pcp_list, true);
+							pcp, pcp_list);
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
@@ -5429,8 +5445,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	spin_unlock(&pcp->lock);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pcp_spin_unlock_irqrestore(pcp, flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
@@ -5439,7 +5454,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	return nr_populated;
 
 failed_irq:
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pcp_spin_unlock_irqrestore(pcp, flags);
 
 failed:
 	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
