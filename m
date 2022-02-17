Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A514B9509
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 01:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiBQAZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 19:25:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBQAXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 19:23:48 -0500
Received: from outbound-smtp52.blacknight.com (outbound-smtp52.blacknight.com [46.22.136.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4384717972C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:23:32 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp52.blacknight.com (Postfix) with ESMTPS id E6BC6FAE23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:23:30 +0000 (GMT)
Received: (qmail 23898 invoked from network); 17 Feb 2022 00:23:30 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 17 Feb 2022 00:23:30 -0000
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
Subject: [PATCH 5/6] mm/page_alloc: Free pages in a single pass during bulk free
Date:   Thu, 17 Feb 2022 00:22:26 +0000
Message-Id: <20220217002227.5739-6-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220217002227.5739-1-mgorman@techsingularity.net>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
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
                                 vanilla      mm-reverthighpcp-v1     mm-highpcpopt-v2
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
                                 vanilla    mm-reverthighpcp-v1       mm-highpcpopt-v2
Min       elapsed      510.00 (   0.00%)      500.00 (   1.96%)      500.00 (   1.96%)
Amean     elapsed      529.00 (   0.00%)      521.00 (   1.51%)      510.00 *   3.59%*
Stddev    elapsed       16.63 (   0.00%)       12.87 (  22.64%)       11.55 (  30.58%)
CoeffVar  elapsed        3.14 (   0.00%)        2.47 (  21.46%)        2.26 (  27.99%)
Max       elapsed      550.00 (   0.00%)      540.00 (   1.82%)      530.00 (   3.64%)
BAmean-50 elapsed      516.00 (   0.00%)      512.00 (   0.78%)      500.00 (   3.10%)
BAmean-95 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      507.78 (   3.59%)
BAmean-99 elapsed      526.67 (   0.00%)      518.89 (   1.48%)      507.78 (   3.59%)

The original motivation for multi-passes was will-it-scale page_fault1
using $nr_cpu processes.

2-socket CascadeLake (40 cores, 80 CPUs HT enabled)
                                                    5.17.0-rc3                 5.17.0-rc3
                                                       vanilla           mm-highpcpopt-v2
Hmean     page_fault1-processes-2        2694662.26 (   0.00%)      2695780.35 (   0.04%)
Hmean     page_fault1-processes-5        6425819.34 (   0.00%)      6435544.57 *   0.15%*
Hmean     page_fault1-processes-8        9642169.10 (   0.00%)      9658962.39 (   0.17%)
Hmean     page_fault1-processes-12      12167502.10 (   0.00%)     12190163.79 (   0.19%)
Hmean     page_fault1-processes-21      15636859.03 (   0.00%)     15612447.26 (  -0.16%)
Hmean     page_fault1-processes-30      25157348.61 (   0.00%)     25169456.65 (   0.05%)
Hmean     page_fault1-processes-48      27694013.85 (   0.00%)     27671111.46 (  -0.08%)
Hmean     page_fault1-processes-79      25928742.64 (   0.00%)     25934202.02 (   0.02%) <--
Hmean     page_fault1-processes-110     25730869.75 (   0.00%)     25671880.65 *  -0.23%*
Hmean     page_fault1-processes-141     25626992.42 (   0.00%)     25629551.61 (   0.01%)
Hmean     page_fault1-processes-172     25611651.35 (   0.00%)     25614927.99 (   0.01%)
Hmean     page_fault1-processes-203     25577298.75 (   0.00%)     25583445.59 (   0.02%)
Hmean     page_fault1-processes-234     25580686.07 (   0.00%)     25608240.71 (   0.11%)
Hmean     page_fault1-processes-265     25570215.47 (   0.00%)     25568647.58 (  -0.01%)
Hmean     page_fault1-processes-296     25549488.62 (   0.00%)     25543935.00 (  -0.02%)
Hmean     page_fault1-processes-320     25555149.05 (   0.00%)     25575696.74 (   0.08%)

The differences are mostly within the noise and the difference close to
$nr_cpus is negligible.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/page_alloc.c | 56 +++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 635a4e0f70b4..68e2132717c5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1455,8 +1455,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	unsigned int order;
 	int prefetch_nr = READ_ONCE(pcp->batch);
 	bool isolated_pageblocks;
-	struct page *page, *tmp;
-	LIST_HEAD(head);
+	struct page *page;
 
 	/*
 	 * Ensure proper count is passed which otherwise would stuck in the
@@ -1467,6 +1466,13 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
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
@@ -1489,7 +1495,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
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
@@ -1498,12 +1508,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
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
@@ -1517,36 +1521,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 				prefetch_buddy(page, order);
 				prefetch_nr--;
 			}
-		} while (count > 0 && !list_empty(list));
-	}
 
-	/*
-	 * local_lock_irq held so equivalent to spin_lock_irqsave for
-	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
-	 */
-	spin_lock(&zone->lock);
-	isolated_pageblocks = has_isolate_pageblock(zone);
+			/* MIGRATE_ISOLATE page should not go to pcplists */
+			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
+			/* Pageblock could have been isolated meanwhile */
+			if (unlikely(isolated_pageblocks))
+				mt = get_pageblock_migratetype(page);
 
-	/*
-	 * Use safe version since after __free_one_page(),
-	 * page->lru.next will not point to original list.
-	 */
-	list_for_each_entry_safe(page, tmp, &head, lru) {
-		int mt = get_pcppage_migratetype(page);
-
-		/* mt has been encoded with the order (see above) */
-		order = mt & NR_PCP_ORDER_MASK;
-		mt >>= NR_PCP_ORDER_WIDTH;
-
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

