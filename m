Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F94B705B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbiBOO75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:59:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiBOO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:59:49 -0500
Received: from outbound-smtp39.blacknight.com (outbound-smtp39.blacknight.com [46.22.139.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0774F2FFF1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:59:39 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id 3D30F1A88
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:51:53 +0000 (GMT)
Received: (qmail 15449 invoked from network); 15 Feb 2022 14:51:53 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 15 Feb 2022 14:51:52 -0000
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
Subject: [PATCH 3/5] mm/page_alloc: Simplify how many pages are selected per pcp list during bulk free
Date:   Tue, 15 Feb 2022 14:51:09 +0000
Message-Id: <20220215145111.27082-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220215145111.27082-1-mgorman@techsingularity.net>
References: <20220215145111.27082-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_pcppages_bulk() selects pages to free by round-robining between
lists. Originally this was to evenly shrink pages by migratetype
but uneven freeing is inevitable due to high pages. Simplify list
selection by starting with a list that definitely has pages on it in
free_unref_page_commit() and for drain, it does not matter where draining
starts as all pages are removed.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5110fdeb115..5e8c7cbe7a41 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1447,13 +1447,11 @@ static inline void prefetch_buddy(struct page *page, unsigned int order)
  * count is the number of pages to free.
  */
 static void free_pcppages_bulk(struct zone *zone, int count,
-					struct per_cpu_pages *pcp)
+					struct per_cpu_pages *pcp,
+					int pindex)
 {
-	int pindex = 0;
 	int min_pindex = 0;
 	int max_pindex = NR_PCP_LISTS - 1;
-	int batch_free = 0;
-	int nr_freed = 0;
 	unsigned int order;
 	int prefetch_nr = READ_ONCE(pcp->batch);
 	bool isolated_pageblocks;
@@ -1467,16 +1465,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	count = min(pcp->count, count);
 	while (count > 0) {
 		struct list_head *list;
+		int nr_pages;
 
-		/*
-		 * Remove pages from lists in a round-robin fashion. A
-		 * batch_free count is maintained that is incremented when an
-		 * empty list is encountered.  This is so more pages are freed
-		 * off fuller lists instead of spinning excessively around empty
-		 * lists
-		 */
+		/* Remove pages from lists in a round-robin fashion. */
 		do {
-			batch_free++;
 			if (++pindex == NR_PCP_LISTS)
 				pindex = 0;
 			list = &pcp->lists[pindex];
@@ -1489,18 +1481,15 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 				min_pindex++;
 		} while (1);
 
-		/* This is the only non-empty list. Free them all. */
-		if (batch_free >= max_pindex - min_pindex)
-			batch_free = count;
-
 		order = pindex_to_order(pindex);
+		nr_pages = 1 << order;
 		BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_WIDTH));
 		do {
 			page = list_last_entry(list, struct page, lru);
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->lru);
-			nr_freed += 1 << order;
-			count -= 1 << order;
+			count -= nr_pages;
+			pcp->count -= nr_pages;
 
 			if (bulkfree_pcp_prepare(page))
 				continue;
@@ -1524,9 +1513,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 				prefetch_buddy(page, order);
 				prefetch_nr--;
 			}
-		} while (count > 0 && --batch_free && !list_empty(list));
+		} while (count > 0 && !list_empty(list));
 	}
-	pcp->count -= nr_freed;
 
 	/*
 	 * local_lock_irq held so equivalent to spin_lock_irqsave for
@@ -3095,7 +3083,7 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0)
-		free_pcppages_bulk(zone, to_drain, pcp);
+		free_pcppages_bulk(zone, to_drain, pcp, 0);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 #endif
@@ -3116,7 +3104,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	if (pcp->count)
-		free_pcppages_bulk(zone, pcp->count, pcp);
+		free_pcppages_bulk(zone, pcp->count, pcp, 0);
 
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
@@ -3397,7 +3385,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
 	if (pcp->count >= high) {
 		int batch = READ_ONCE(pcp->batch);
 
-		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp);
+		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp, pindex);
 	}
 }
 
-- 
2.31.1

