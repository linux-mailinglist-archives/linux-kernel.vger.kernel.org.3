Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33344B7233
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiBOOxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:53:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbiBOOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:52:50 -0500
Received: from outbound-smtp57.blacknight.com (outbound-smtp57.blacknight.com [46.22.136.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA44104A60
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:52:04 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id 75B2FFA895
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:52:03 +0000 (GMT)
Received: (qmail 16118 invoked from network); 15 Feb 2022 14:52:03 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 15 Feb 2022 14:52:03 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/5] mm/page_alloc: Free pages in a single pass during bulk free
Date:   Tue, 15 Feb 2022 14:51:10 +0000
Message-Id: <20220215145111.27082-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220215145111.27082-1-mgorman@techsingularity.net>
References: <20220215145111.27082-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_pcppages_bulk() has taken two passes through the pcp lists since
commit 0a5f4e5b4562 ("mm/free_pcppages_bulk: do not hold lock when picking
pages to free") due to deferring the cost of selecting PCP lists until
the zone lock is held. Now that list selection is simplier, the main
cost during selection is bulkfree_pcp_prepare() which in the normal case
is a simple check and prefetching. As the list manipulations have cost
in itself, go back to freeing pages in a single pass.

The series up to this point was evaulated using a trunc microbenchmark
that is truncating sparse files stored in page cache (mmtests config
config-io-trunc). Sparse files were used to limit filesystem interaction.

The results versus a revert of storing high-order pages in the PCP lists is

1-socket Skylake
                              5.17.0-rc3             5.17.0-rc3             5.17.0-rc3
                                 vanilla    mm-reverthighpcp-v1r1     mm-highpcpopt-v1
Min       elapsed      540.00 (   0.00%)      530.00 (   1.85%)      530.00 (   1.85%)
Amean     elapsed      543.00 (   0.00%)      530.00 *   2.39%*      530.00 *   2.39%*
Stddev    elapsed        4.83 (   0.00%)        0.00 ( 100.00%)        0.00 ( 100.00%)
CoeffVar  elapsed        0.89 (   0.00%)        0.00 ( 100.00%)        0.00 ( 100.00%)
Max       elapsed      550.00 (   0.00%)      530.00 (   3.64%)      530.00 (   3.64%)
BAmean-50 elapsed      540.00 (   0.00%)      530.00 (   1.85%)      530.00 (   1.85%)
BAmean-95 elapsed      542.22 (   0.00%)      530.00 (   2.25%)      530.00 (   2.25%)
BAmean-99 elapsed      542.22 (   0.00%)      530.00 (   2.25%)      530.00 (   2.25%)

2-socket CascadeLake
                              5.17.0-rc3             5.17.0-rc3             5.17.0-rc3
                                 vanilla    mm-reverthighpcp-v1       mm-highpcpopt-v1
Min       elapsed      510.00 (   0.00%)      500.00 (   1.96%)      500.00 (   1.96%)
Amean     elapsed      529.00 (   0.00%)      521.00 (   1.51%)      516.00 *   2.46%*
Stddev    elapsed       16.63 (   0.00%)       12.87 (  22.64%)        9.66 (  41.92%)
CoeffVar  elapsed        3.14 (   0.00%)        2.47 (  21.46%)        1.87 (  40.45%)
Max       elapsed      550.00 (   0.00%)      540.00 (   1.82%)      530.00 (   3.64%)
BAmean-50 elapsed      516.00 (   0.00%)      512.00 (   0.78%)      510.00 (   1.16%)
BAmean-95 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      514.44 (   2.32%)
BAmean-99 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      514.44 (   2.32%)

The original motivation for multi-passes was will-it-scale page_fault1
using $nr_cpu processes.

2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
                                                    5.17.0-rc3                 5.17.0-rc3
                                                       vanilla         mm-highpcpopt-v1r4
Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2696801.07 (   0.08%)
Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6426573.21 (   0.01%)
Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9647444.94 (   0.05%)
Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12073323.10 *  -0.77%*
Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15587449.50 *  -0.32%*
Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25111707.15 *  -0.18%*
Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27728568.63 (   0.12%)
Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25920933.41 (  -0.03%) <---
Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25695727.57 *  -0.14%*
Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25675346.68 *   0.19%*
Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25650940.14 *   0.15%*
Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25584848.65 (   0.03%)
Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25601794.52 *   0.08%*
Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25553191.25 (  -0.07%)
Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25530311.58 (  -0.08%)
Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25585059.83 (   0.12%)

The differences are mostly within the noise and the difference close to
$nr_cpus is negligible.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 57 +++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5e8c7cbe7a41..6881175b27df 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1455,14 +1455,21 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	unsigned int order;
 	int prefetch_nr = READ_ONCE(pcp->batch);
 	bool isolated_pageblocks;
-	struct page *page, *tmp;
-	LIST_HEAD(head);
+	struct page *page;
 
 	/*
 	 * Ensure proper count is passed which otherwise would stuck in the
 	 * below while (list_empty(list)) loop.
 	 */
 	count = min(pcp->count, count);
+
+	/*
+	 * local_lock_irq held so equivalent to spin_lock_irqsave for
+	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
+	 */
+	spin_lock(&zone->lock);
+	isolated_pageblocks = has_isolate_pageblock(zone);
+
 	while (count > 0) {
 		struct list_head *list;
 		int nr_pages;
@@ -1485,7 +1492,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		nr_pages = 1 << order;
 		BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_WIDTH));
 		do {
+			int mt;
+
 			page = list_last_entry(list, struct page, lru);
+			mt = get_pcppage_migratetype(page);
+
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->lru);
 			count -= nr_pages;
@@ -1494,12 +1505,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			if (bulkfree_pcp_prepare(page))
 				continue;
 
-			/* Encode order with the migratetype */
-			page->index <<= NR_PCP_ORDER_WIDTH;
-			page->index |= order;
-
-			list_add_tail(&page->lru, &head);
-
 			/*
 			 * We are going to put the page back to the global
 			 * pool, prefetch its buddy to speed up later access
@@ -1513,36 +1518,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 				prefetch_buddy(page, order);
 				prefetch_nr--;
 			}
-		} while (count > 0 && !list_empty(list));
-	}
-
-	/*
-	 * local_lock_irq held so equivalent to spin_lock_irqsave for
-	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
-	 */
-	spin_lock(&zone->lock);
-	isolated_pageblocks = has_isolate_pageblock(zone);
-
-	/*
-	 * Use safe version since after __free_one_page(),
-	 * page->lru.next will not point to original list.
-	 */
-	list_for_each_entry_safe(page, tmp, &head, lru) {
-		int mt = get_pcppage_migratetype(page);
 
-		/* mt has been encoded with the order (see above) */
-		order = mt & NR_PCP_ORDER_MASK;
-		mt >>= NR_PCP_ORDER_WIDTH;
+			/* MIGRATE_ISOLATE page should not go to pcplists */
+			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
+			/* Pageblock could have been isolated meanwhile */
+			if (unlikely(isolated_pageblocks))
+				mt = get_pageblock_migratetype(page);
 
-		/* MIGRATE_ISOLATE page should not go to pcplists */
-		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
-		/* Pageblock could have been isolated meanwhile */
-		if (unlikely(isolated_pageblocks))
-			mt = get_pageblock_migratetype(page);
-
-		__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
-		trace_mm_page_pcpu_drain(page, order, mt);
+			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
+			trace_mm_page_pcpu_drain(page, order, mt);
+		} while (count > 0 && !list_empty(list));
 	}
+
 	spin_unlock(&zone->lock);
 }
 
-- 
2.31.1

