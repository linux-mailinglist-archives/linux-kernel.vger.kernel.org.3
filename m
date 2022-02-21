Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4644BE2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353225AbiBUKWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:22:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353322AbiBUKWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:22:03 -0500
Received: from outbound-smtp28.blacknight.com (outbound-smtp28.blacknight.com [81.17.249.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A0A11C0C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:41:42 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp28.blacknight.com (Postfix) with ESMTPS id A9844CCE2F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:41:41 +0000 (GMT)
Received: (qmail 32136 invoked from network); 21 Feb 2022 09:41:41 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPA; 21 Feb 2022 09:41:41 -0000
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
Subject: [PATCH 1/1] mm/page_alloc: Do not prefetch buddies during bulk free
Date:   Mon, 21 Feb 2022 09:41:19 +0000
Message-Id: <20220221094119.15282-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220221094119.15282-1-mgorman@techsingularity.net>
References: <20220221094119.15282-1-mgorman@techsingularity.net>
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

free_pcppages_bulk() has taken two passes through the pcp lists since
commit 0a5f4e5b4562 ("mm/free_pcppages_bulk: do not hold lock when picking
pages to free") due to deferring the cost of selecting PCP lists until
the zone lock is held.

As the list processing now takes place under the zone lock, it's less
clear that this will always benefit for two reasons.

1. There is a guaranteed cost to calculating the buddy which definitely
   has to be calculated again. However, as the zone lock is held and
   there is no deferring of buddy merging, there is no guarantee that the
   prefetch will have completed when the second buddy calculation takes
   place and buddies are being merged.  With or without the prefetch, there
   may be further stalls depending on how many pages get merged. In other
   words, a stall due to merging is inevitable and at best only one stall
   might be avoided at the cost of calculating the buddy location twice.

2. As the zone lock is held, prefetch_nr makes less sense as once
   prefetch_nr expires, the cache lines of interest have already been
   merged.

The main concern is that there is a definite cost to calculating the
buddy location early for the prefetch and it is a "maybe win" depending
on whether the CPU prefetch logic and memory is fast enough. Remove the
prefetch logic on the basis that reduced instructions in a path is always
a saving where as the prefetch might save one memory stall depending on
the CPU and memory.

In most cases, this has marginal benefit as the calculations are a small
part of the overall freeing of pages. However, it was detectable on at
least one machine.

                              5.17.0-rc3             5.17.0-rc3
                    mm-highpcplimit-v2r1     mm-noprefetch-v1r1
Min       elapsed      630.00 (   0.00%)      610.00 (   3.17%)
Amean     elapsed      639.00 (   0.00%)      623.00 *   2.50%*
Max       elapsed      660.00 (   0.00%)      660.00 (   0.00%)

Suggested-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index de9f072d23bd..2d5cc098136d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1432,15 +1432,6 @@ static bool bulkfree_pcp_prepare(struct page *page)
 }
 #endif /* CONFIG_DEBUG_VM */
 
-static inline void prefetch_buddy(struct page *page, unsigned int order)
-{
-	unsigned long pfn = page_to_pfn(page);
-	unsigned long buddy_pfn = __find_buddy_pfn(pfn, order);
-	struct page *buddy = page + (buddy_pfn - pfn);
-
-	prefetch(buddy);
-}
-
 /*
  * Frees a number of pages from the PCP lists
  * Assumes all pages on list are in same zone.
@@ -1453,7 +1444,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	int min_pindex = 0;
 	int max_pindex = NR_PCP_LISTS - 1;
 	unsigned int order;
-	int prefetch_nr = READ_ONCE(pcp->batch);
 	bool isolated_pageblocks;
 	struct page *page;
 
@@ -1508,20 +1498,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			if (bulkfree_pcp_prepare(page))
 				continue;
 
-			/*
-			 * We are going to put the page back to the global
-			 * pool, prefetch its buddy to speed up later access
-			 * under zone->lock. It is believed the overhead of
-			 * an additional test and calculating buddy_pfn here
-			 * can be offset by reduced memory latency later. To
-			 * avoid excessive prefetching due to large count, only
-			 * prefetch buddy for the first pcp->batch nr of pages.
-			 */
-			if (prefetch_nr) {
-				prefetch_buddy(page, order);
-				prefetch_nr--;
-			}
-
 			/* MIGRATE_ISOLATE page should not go to pcplists */
 			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
 			/* Pageblock could have been isolated meanwhile */
-- 
2.26.2

