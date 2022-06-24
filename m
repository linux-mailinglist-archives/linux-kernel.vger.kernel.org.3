Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E761F5599F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiFXMz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiFXMzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:55:51 -0400
Received: from outbound-smtp08.blacknight.com (outbound-smtp08.blacknight.com [46.22.139.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F1A4FC58
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:55:49 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 7AEDF1C3DAF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 13:55:48 +0100 (IST)
Received: (qmail 9538 invoked from network); 24 Jun 2022 12:55:48 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPA; 24 Jun 2022 12:55:48 -0000
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
Subject: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock
Date:   Fri, 24 Jun 2022 13:54:23 +0100
Message-Id: <20220624125423.6126-8-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220624125423.6126-1-mgorman@techsingularity.net>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
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
without breaking the intent behind the API. It is not a complete API
as only the parts needed for PCP-alloc are implemented but in theory,
the generic helpers could be promoted to a general API if there was
demand for an embedded lock within a per-cpu struct with a guarantee
that the per-cpu structure locked matches the running CPU and cannot use
get_cpu_var due to RT concerns. PCP requires these semantics to avoid
accidentally allocating remote memory.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 139 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 95 insertions(+), 44 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 44e7c29aaa7d..71065b01827b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -126,13 +126,6 @@ typedef int __bitwise fpi_t;
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
 
-struct pagesets {
-	local_lock_t lock;
-};
-static DEFINE_PER_CPU(struct pagesets, pagesets) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
-
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 /*
  * On SMP, spin_trylock is sufficient protection.
@@ -147,6 +140,83 @@ static DEFINE_PER_CPU(struct pagesets, pagesets) = {
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
+/*
+ * Generic helper to lookup and a per-cpu variable with an embedded spinlock.
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
+	if (!spin_trylock_irqsave(&_ret->member, flags)) {		\
+		pcpu_task_unpin();					\
+		_ret = NULL;						\
+	}								\
+	_ret;								\
+})
+
+#define pcpu_spin_unlock(member, ptr)					\
+({									\
+	spin_unlock(&ptr->member);					\
+	pcpu_task_unpin();						\
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
@@ -1481,10 +1551,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
-	/*
-	 * local_lock_irq held so equivalent to spin_lock_irqsave for
-	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
-	 */
+	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
 	spin_lock(&zone->lock);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
@@ -3052,10 +3119,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
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
@@ -3427,18 +3491,16 @@ void free_unref_page(struct page *page, unsigned int order)
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	if (spin_trylock(&pcp->lock)) {
+	pcp = pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per_cpu_pageset, flags);
+	if (pcp) {
 		free_unref_page_commit(zone, pcp, page, migratetype, order);
-		spin_unlock(&pcp->lock);
+		pcp_spin_unlock_irqrestore(pcp, flags);
 	} else {
 		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
 	}
 	pcp_trylock_finish(UP_flags);
-	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
 /*
@@ -3473,17 +3535,16 @@ void free_unref_page_list(struct list_head *list)
 		}
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
 		struct zone *zone = page_zone(page);
 
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
 			if (pcp)
-				spin_unlock(&pcp->lock);
+				pcp_spin_unlock_irqrestore(pcp, flags);
+
 			locked_zone = zone;
-			pcp = this_cpu_ptr(zone->per_cpu_pageset);
-			spin_lock(&pcp->lock);
+			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
 		}
 
 		/*
@@ -3502,18 +3563,14 @@ void free_unref_page_list(struct list_head *list)
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
 
 	if (pcp)
-		spin_unlock(&pcp->lock);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+		pcp_spin_unlock_irqrestore(pcp, flags);
 }
 
 /*
@@ -3728,15 +3785,13 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 
-	local_lock_irqsave(&pagesets.lock, flags);
-
 	/*
 	 * spin_trylock may fail due to a parallel drain. In the future, the
 	 * trylock will also protect against IRQ reentrancy.
 	 */
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp_trylock_prepare(UP_flags);
-	if (!spin_trylock(&pcp->lock)) {
+	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	if (!pcp) {
 		pcp_trylock_finish(UP_flags);
 		return NULL;
 	}
@@ -3749,9 +3804,8 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
-	spin_unlock(&pcp->lock);
+	pcp_spin_unlock_irqrestore(pcp, flags);
 	pcp_trylock_finish(UP_flags);
-	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone, 1);
@@ -5356,10 +5410,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Is a parallel drain in progress? */
-	local_lock_irqsave(&pagesets.lock, flags);
 	pcp_trylock_prepare(UP_flags);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	if (!spin_trylock(&pcp->lock))
+	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	if (!pcp)
 		goto failed_irq;
 
 	/* Attempt the batch allocation */
@@ -5377,7 +5430,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
 			if (!nr_account) {
-				spin_unlock(&pcp->lock);
+				pcp_spin_unlock_irqrestore(pcp, flags);
 				goto failed_irq;
 			}
 			break;
@@ -5392,9 +5445,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	spin_unlock(&pcp->lock);
+	pcp_spin_unlock_irqrestore(pcp, flags);
 	pcp_trylock_finish(UP_flags);
-	local_unlock_irqrestore(&pagesets.lock, flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
@@ -5404,7 +5456,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 failed_irq:
 	pcp_trylock_finish(UP_flags);
-	local_unlock_irqrestore(&pagesets.lock, flags);
 
 failed:
 	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
-- 
2.35.3

