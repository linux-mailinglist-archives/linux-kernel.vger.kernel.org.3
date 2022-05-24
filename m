Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1090532FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiEXReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiEXReD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:34:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0546AA63
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38997B81289
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE70DC34100;
        Tue, 24 May 2022 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653413640;
        bh=DfQeIa8sg3OyTlsDBsRb0PPDt5LPIkjP/Wlu9MvxBtA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BFQ2YO8YYMX/SfN7GfiRyJWe5ZwxjoO1BNlRiXPB6EQK8852LrgwKc3FuHp0TfLOa
         yTnIsHr0gBQgjaliCnkE9dMSIfIFCyLEJxYrdl3gn002WZ7E42P3ZPD0UELJGkysUI
         MQbyXxgCO33dUEfXoDAIlBCEGIYpQTZfE8vHRbW32HwsqVwa4/UNG+RJm2ZQVUzgoW
         +tHuopddY+1+kwrrAm28u1OyDoU022xwlILUpSu44usQap1MFItmCXhFRkSTqJfhAG
         8hDSWopdtuPHHaf4FJj1N9vE15rKC4Gn9gJ/uPAbdT8xHPadW7nTVSuLlELCzfj730
         59odG8UHvEpHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B7645C0378; Tue, 24 May 2022 10:33:59 -0700 (PDT)
Date:   Tue, 24 May 2022 10:33:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v6] mm: fix is_pinnable_page against a cma page
Message-ID: <20220524173359.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220524171525.976723-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524171525.976723-1-minchan@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:15:25AM -0700, Minchan Kim wrote:
> Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
> so current is_pinnable_page could miss CMA pages which has MIGRATE_
> ISOLATE. It ends up pinning CMA pages as longterm at pin_user_pages
> APIs so CMA allocation keep failed until the pin is released.
> 
>      CPU 0                                   CPU 1 - Task B
> 
> cma_alloc
> alloc_contig_range
>                                         pin_user_pages_fast(FOLL_LONGTERM)
> change pageblock as MIGRATE_ISOLATE
>                                         internal_get_user_pages_fast
>                                         lockless_pages_from_mm
>                                         gup_pte_range
>                                         try_grab_folio
>                                         is_pinnable_page
>                                           return true;
>                                         So, pinned the page successfully.
> page migration failure with pinned page
>                                         ..
>                                         .. After 30 sec
>                                         unpin_user_page(page)
> 
> CMA allocation succeeded after 30 sec.
> 
> The CMA allocation path protects the migration type change race
> using zone->lock but what GUP path need to know is just whether the
> page is on CMA area or not rather than exact migration type.
> Thus, we don't need zone->lock but just checks migration type in
> either of (MIGRATE_ISOLATE and MIGRATE_CMA).
> 
> Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
> rejecting of pinning pages on MIGRATE_ISOLATE pageblocks even
> though it's neither CMA nor movable zone if the page is temporarily
> unmovable. However, such a migration failure by unexpected temporal
> refcount holding is general issue, not only come from MIGRATE_ISOLATE
> and the MIGRATE_ISOLATE is also transient state like other temporal
> elevated refcount problem.
> 
> Cc: "Paul E . McKenney" <paulmck@kernel.org>

From a memory-ordering viewpoint:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> Cc: David Hildenbrand <david@redhat.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * from v5 - https://lore.kernel.org/all/20220512204143.3961150-1-minchan@kernel.org/
>   * Use READ_ONCE in __get_pfnblock_flags_mask - Jason
>   * adding a comment about READ_ONCE - John
> 
> * from v4 - https://lore.kernel.org/all/20220510211743.95831-1-minchan@kernel.org/
>   * clarification why we need READ_ONCE - Paul
>   * Adding a comment about READ_ONCE - John
> 
> * from v3 - https://lore.kernel.org/all/20220509153430.4125710-1-minchan@kernel.org/
>   * Fix typo and adding more description - akpm
> 
> * from v2 - https://lore.kernel.org/all/20220505064429.2818496-1-minchan@kernel.org/
>   * Use __READ_ONCE instead of volatile - akpm
> 
> * from v1 - https://lore.kernel.org/all/20220502173558.2510641-1-minchan@kernel.org/
>   * fix build warning - lkp
>   * fix refetching issue of migration type
>   * add side effect on !ZONE_MOVABLE and !MIGRATE_CMA in description - david
> 
>  include/linux/mm.h | 9 +++++++--
>  mm/page_alloc.c    | 8 ++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6acca5cecbc5..ba13411b6dca 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1625,8 +1625,13 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>  #ifdef CONFIG_MIGRATION
>  static inline bool is_pinnable_page(struct page *page)
>  {
> -	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
> -		is_zero_pfn(page_to_pfn(page));
> +#ifdef CONFIG_CMA
> +	int mt = get_pageblock_migratetype(page);
> +
> +	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
> +		return false;
> +#endif
> +	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
>  }
>  #else
>  static inline bool is_pinnable_page(struct page *page)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7a2053621e27..348071e5d8d9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -482,8 +482,12 @@ unsigned long __get_pfnblock_flags_mask(const struct page *page,
>  	bitidx = pfn_to_bitidx(page, pfn);
>  	word_bitidx = bitidx / BITS_PER_LONG;
>  	bitidx &= (BITS_PER_LONG-1);
> -
> -	word = bitmap[word_bitidx];
> +	/*
> +	 * This races, without locks, with set_pfnblock_flags_mask(). Ensure
> +	 * a consistent read of the memory array, so that results, even though
> +	 * racy, are not corrupted.
> +	 */
> +	word = READ_ONCE(bitmap[word_bitidx]);
>  	return (word >> bitidx) & mask;
>  }
>  
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 
