Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5B64BB5EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiBRJrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:47:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbiBRJrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:47:37 -0500
Received: from outbound-smtp22.blacknight.com (outbound-smtp22.blacknight.com [81.17.249.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56B939B8E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:47:19 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp22.blacknight.com (Postfix) with ESMTPS id 96DBEBAA29
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:47:18 +0000 (GMT)
Received: (qmail 15748 invoked from network); 18 Feb 2022 09:47:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Feb 2022 09:47:18 -0000
Date:   Fri, 18 Feb 2022 09:47:16 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Free pages in a single pass during
 bulk free
Message-ID: <20220218094716.GY3366@techsingularity.net>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
 <Yg83rppnpmXPbln4@ziqianlu-nuc9qn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Yg83rppnpmXPbln4@ziqianlu-nuc9qn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 02:07:42PM +0800, Aaron Lu wrote:
> > @@ -1498,12 +1508,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  			if (bulkfree_pcp_prepare(page))
> >  				continue;
> >  
> > -			/* Encode order with the migratetype */
> > -			page->index <<= NR_PCP_ORDER_WIDTH;
> > -			page->index |= order;
> > -
> > -			list_add_tail(&page->lru, &head);
> > -
> >  			/*
> >  			 * We are going to put the page back to the global
> >  			 * pool, prefetch its buddy to speed up later access
> > @@ -1517,36 +1521,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  				prefetch_buddy(page, order);
> >  				prefetch_nr--;
> >  			}
> 
> The comment above 'if (prefetch_nr)' says: "We are going to put the page
> back to the global pool, prefetch its buddy to speed up later access
> under zone->lock..." will have to be modified as the prefetch is now
> done inside the lock.
> 

Yes, that was my understanding.

> I remember prefetch_buddy()'s original intent is to fetch the buddy
> page's 'struct page' before acquiring the zone lock to speed up
> operations inside the locked region. Now that the zone lock is acquired
> early, whether to still keep the prefetch_buddy() inside the lock
> becomes questionable.
> 

I agree. I wanted to take it out but worried it might stall (drumroll)
the rest of the series as evaluating prefetch is machine specific. Before
this series I thought it was possible that the prefetched lines would be
flushed if the lists were large enough. Due to free_factor, it's possible
we are 10's of thousands of pages and the prefetched pages would be
evicted. It would require a fairly small cache though.

There are still two reasons why I thought it should go away as a
follow-up to the series.

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

It's point 1 that was my main concern. We are paying a guaranteed cost for
a maybe win if prefetching is fast enough and it would be very difficult to
spot what percentage of prefetches actually helped. It was more clear-cut
when the buddy freeing was deferred as there was more time for the prefetch
to complete.

> After the nr_task=4/16/64 tests finished, I'll also test the effect of
> removing prefetch_buddy() here.
> 

I'd appreciate it. I think the patch is this (build tested only);

--8<--
mm/page_alloc: Do not prefetch buddies during bulk free

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
