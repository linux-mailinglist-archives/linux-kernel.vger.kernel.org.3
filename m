Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB3649AC92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345758AbiAYGpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:45:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46246 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344376AbiAYGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:43:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16DEB60C7D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB0BC340E0;
        Tue, 25 Jan 2022 06:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643092978;
        bh=w9kbu9RHX+YfdS4ykZIbMjfDhh8cJ9Xb1CqqNG1jcCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tzZs5+nE41o0br8nF9/ybm8droXUY+SW74VlHxyIw6kSVJmywLYTShTXqpi3FDr+4
         75+KIkbJh3Tc0cG0Sj23Z9G+m9Sb7i8VtmNCHyYBoFJOfUXOII+WtGJn04bJuK9bf2
         E0umT7Q6dEEuNxsGiAAPyWcq2D1GKoB8gtodl96zRXVkEVHfit5r10X2RfercCAAj4
         htLHdFysSYeWoeAOBfhOAM4fbM4Ng+wCYXv4RXvR8mgGbmCUs24Dkw1xu5ej44h5wq
         fNyoxQZPGJH+cqxsVX3Dqceps2ndNRwPdbgReuC5L0trKinZf6/XOdagg8Gub7Elva
         mNYHxCrNsAOuw==
Date:   Tue, 25 Jan 2022 08:42:49 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: page_alloc: avoid merging non-fallbackable
 pageblocks with others.
Message-ID: <Ye+b6YKiQ6ylEO6M@kernel.org>
References: <20220124175957.1261961-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124175957.1261961-1-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:59:57PM -0500, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> This is done in addition to MIGRATE_ISOLATE pageblock merge avoidance.
> It prepares for the upcoming removal of the MAX_ORDER-1 alignment
> requirement for CMA and alloc_contig_range().
> 
> MIGRARTE_HIGHATOMIC should not merge with other migratetypes like
> MIGRATE_ISOLATE and MIGRARTE_CMA[1], so this commit prevents that too.
> 
> Remove MIGRARTE_CMA and MIGRATE_ISOLATE from fallbacks list, since they
> are never used.
> 
> [1] https://lore.kernel.org/linux-mm/20211130100853.GP3366@techsingularity.net/
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/mmzone.h | 11 +++++++++++
>  mm/page_alloc.c        | 44 ++++++++++++++++++++----------------------
>  2 files changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index aed44e9b5d89..71b77aab748d 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -83,6 +83,17 @@ static inline bool is_migrate_movable(int mt)
>  	return is_migrate_cma(mt) || mt == MIGRATE_MOVABLE;
>  }
>  
> +/*
> + * Check whether a migratetype can be merged with another migratetype.
> + *
> + * It is only mergeable when it can fall back to other migratetypes for
> + * allocation. See fallbacks[MIGRATE_TYPES][3] in page_alloc.c.
> + */
> +static inline bool migratetype_is_mergeable(int mt)
> +{
> +	return mt < MIGRATE_PCPTYPES;
> +}
> +
>  #define for_each_migratetype_order(order, type) \
>  	for (order = 0; order < MAX_ORDER; order++) \
>  		for (type = 0; type < MIGRATE_TYPES; type++)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8dd6399bafb5..5a91d4d9279a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1117,25 +1117,24 @@ static inline void __free_one_page(struct page *page,
>  	}
>  	if (order < MAX_ORDER - 1) {
>  		/* If we are here, it means order is >= pageblock_order.
> -		 * We want to prevent merge between freepages on isolate
> -		 * pageblock and normal pageblock. Without this, pageblock
> -		 * isolation could cause incorrect freepage or CMA accounting.
> +		 * We want to prevent merge between freepages on pageblock
> +		 * without fallbacks and normal pageblock. Without this,
> +		 * pageblock isolation could cause incorrect freepage or CMA
> +		 * accounting or HIGHATOMIC accounting.
>  		 *
>  		 * We don't want to hit this code for the more frequent
>  		 * low-order merging.
>  		 */
> -		if (unlikely(has_isolate_pageblock(zone))) {
> -			int buddy_mt;
> +		int buddy_mt;
>  
> -			buddy_pfn = __find_buddy_pfn(pfn, order);
> -			buddy = page + (buddy_pfn - pfn);
> -			buddy_mt = get_pageblock_migratetype(buddy);
> +		buddy_pfn = __find_buddy_pfn(pfn, order);
> +		buddy = page + (buddy_pfn - pfn);
> +		buddy_mt = get_pageblock_migratetype(buddy);
>  
> -			if (migratetype != buddy_mt
> -					&& (is_migrate_isolate(migratetype) ||
> -						is_migrate_isolate(buddy_mt)))
> -				goto done_merging;
> -		}
> +		if (migratetype != buddy_mt
> +				&& (!migratetype_is_mergeable(migratetype) ||
> +					!migratetype_is_mergeable(buddy_mt)))
> +			goto done_merging;
>  		max_order = order + 1;
>  		goto continue_merging;
>  	}
> @@ -2479,17 +2478,13 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
>  /*
>   * This array describes the order lists are fallen back to when
>   * the free lists for the desirable migrate type are depleted
> + *
> + * The other migratetypes do not have fallbacks.
>   */
>  static int fallbacks[MIGRATE_TYPES][3] = {
>  	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
>  	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
>  	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
> -#ifdef CONFIG_CMA
> -	[MIGRATE_CMA]         = { MIGRATE_TYPES }, /* Never used */
> -#endif
> -#ifdef CONFIG_MEMORY_ISOLATION
> -	[MIGRATE_ISOLATE]     = { MIGRATE_TYPES }, /* Never used */
> -#endif
>  };
>  
>  #ifdef CONFIG_CMA
> @@ -2795,8 +2790,8 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone,
>  
>  	/* Yoink! */
>  	mt = get_pageblock_migratetype(page);
> -	if (!is_migrate_highatomic(mt) && !is_migrate_isolate(mt)
> -	    && !is_migrate_cma(mt)) {
> +	/* Only reserve normal pageblocks (i.e., they can merge with others) */
> +	if (migratetype_is_mergeable(mt)) {
>  		zone->nr_reserved_highatomic += pageblock_nr_pages;
>  		set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
>  		move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);
> @@ -3545,8 +3540,11 @@ int __isolate_free_page(struct page *page, unsigned int order)
>  		struct page *endpage = page + (1 << order) - 1;
>  		for (; page < endpage; page += pageblock_nr_pages) {
>  			int mt = get_pageblock_migratetype(page);
> -			if (!is_migrate_isolate(mt) && !is_migrate_cma(mt)
> -			    && !is_migrate_highatomic(mt))
> +			/*
> +			 * Only change normal pageblocks (i.e., they can merge
> +			 * with others)
> +			 */
> +			if (migratetype_is_mergeable(mt))
>  				set_pageblock_migratetype(page,
>  							  MIGRATE_MOVABLE);
>  		}
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
