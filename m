Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E965A2717
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbiHZLtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiHZLtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:49:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB111205
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 623D7B830D1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E1DC433C1;
        Fri, 26 Aug 2022 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661514584;
        bh=x4miST/mqjIF58aX8nr+cFh+RaxzmQTYRFbA0Vg7LaI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=tWyW047mMJ3Oxq8S532U+BJKm6qbFaCudNRKZBBs+26w+2jpde/6WULEFKVzZbTpC
         ex74HJKlxJn5wfywY0xPKkNDUzOwaCUOqCgrlid0SvIOfrSUINIB0D1vcajct5h/mG
         uq+EvLdmwSaUCcC9LycHNswbPSAgT//unYxeB+TNh8bbkTSDBBd5XUEIksjCyCSuPn
         2NJfq8HBNff2ExvTFwiNia0EAgltEhcRivUBspPZbqRTgD3qWsx6We9lsJ7Uj5LNff
         xXdJ8lZnq0FeRNMXECsXm5D5b6l2rKYitDguMOMJuraI9+zukHBHT/wdes5rFSQW19
         f++5LS8DsFbQw==
Message-ID: <e5856ab3-3cbc-929a-d885-ceb456b0d3b2@kernel.org>
Date:   Fri, 26 Aug 2022 13:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH] mm: introduce __GFP_TRACKLEAK to track in-kernel
 allocation
Content-Language: en-US
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
References: <1661496048-26410-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <1661496048-26410-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 08:40, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Kthread and drivers could fetch memory via alloc_pages directly which make them
> hard to debug when leaking. Solve this by introducing __GFP_TRACELEAK and reuse
> kmemleak mechanism which unified most of kernel cosuming pages into kmemleak.

Can you expand how exactly this is expected to be used? So you first have to
suspect some concrete allocation and add __GFP_TRACKLEAK to it?

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/gfp.h        | 4 +++-
>  include/linux/page-flags.h | 3 +++
>  mm/kmemleak.c              | 2 +-
>  mm/page_alloc.c            | 6 ++++++
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 2d2ccae..081ab54 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -68,6 +68,7 @@
>  #else
>  #define ___GFP_NOLOCKDEP	0
>  #endif
> +#define ___GFP_TRACKLEAK	0x10000000u
>  /* If the above are modified, __GFP_BITS_SHIFT may need updating */
>  
>  /*
> @@ -259,12 +260,13 @@
>  #define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
>  #define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
>  #define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
> +#define __GFP_TRACKLEAK   ((__force gfp_t)___GFP_TRACKLEAK)
>  
>  /* Disable lockdep for GFP context tracking */
>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>  
>  /* Room for N __GFP_FOO bits */
> -#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
> +#define __GFP_BITS_SHIFT (28 + IS_ENABLED(CONFIG_LOCKDEP))
>  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
>  
>  /**
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index e66f7aa..ef0f814 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -942,6 +942,7 @@ static inline bool is_page_hwpoison(struct page *page)
>  #define PG_offline	0x00000100
>  #define PG_table	0x00000200
>  #define PG_guard	0x00000400
> +#define PG_trackleak	0x00000800
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> @@ -1012,6 +1013,8 @@ static inline int page_has_type(struct page *page)
>   */
>  PAGE_TYPE_OPS(Guard, guard)
>  
> +PAGE_TYPE_OPS(Trackleak, trackleak)
> +
>  extern bool is_free_buddy_page(struct page *page);
>  
>  PAGEFLAG(Isolated, isolated, PF_ANY);
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 422f28f..a182f5d 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1471,7 +1471,7 @@ static void kmemleak_scan(void)
>  			if (page_zone(page) != zone)
>  				continue;
>  			/* only scan if page is in use */
> -			if (page_count(page) == 0 || PageReserved(page))
> +			if (page_count(page) == 0)
>  				continue;
>  			scan_block(page, page + 1, NULL);
>  			if (!(pfn & 63))
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3d..d8995c6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1361,6 +1361,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  		page->mapping = NULL;
>  	if (memcg_kmem_enabled() && PageMemcgKmem(page))
>  		__memcg_kmem_uncharge_page(page, order);
> +	if (PageTrackleak(page))
> +		kmemleak_free(page);
>  	if (check_free)
>  		bad += check_free_page(page);
>  	if (bad)
> @@ -5444,6 +5446,10 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
>  		__free_pages(page, order);
>  		page = NULL;
>  	}
> +	if (gfp & __GFP_TRACKLEAK) {
> +		kmemleak_alloc(page_address(page), PAGE_SIZE << order, 1, gfp & ~__GFP_TRACKLEAK);
> +		__SetPageTrackleak(page);
> +	}
>  
>  	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
>  

