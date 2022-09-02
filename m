Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0385AB8A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIBS6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIBS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:58:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFB1F32DC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39A3061FC7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 18:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61534C433D6;
        Fri,  2 Sep 2022 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662145120;
        bh=I7EvjmBEJ+PK5VGQFpQlLdq2iNrwiITdaZk9IZZnYao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OP/lQQRO8c9wuvCWYQaoubDsk/jEGHP0zZ229BSegYVU791zGFlwUiZy08YW30rvb
         W8UnxZmh8PWs/dR9SiPM46i7jDQTALOpnSQSFNcm1vaKPE667YbiWrr2jDPatZpMJV
         BGTKtC1fSdKotpwFSIPqt8DFxBEMKjKmTTHpO/yI=
Date:   Fri, 2 Sep 2022 11:58:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [Resend RFC PATCH] mm: introduce __GFP_TRACKLEAK to track
 in-kernel allocation
Message-Id: <20220902115839.1e3fafd159e42d4e7dae90af@linux-foundation.org>
In-Reply-To: <1662116347-17649-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1662116347-17649-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc willy for page-flags changes.

On Fri, 2 Sep 2022 18:59:07 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Kthread and drivers could fetch memory via alloc_pages directly which make them
> hard to debug when leaking. Solve this by introducing __GFP_TRACELEAK and reuse
> kmemleak mechanism which unified most of kernel cosuming pages into kmemleak.
> 
> ...
>

cc wi
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

We'd want this to evaluate to zero at compile time if
CONFIG_HAVE_DEBUG_KMEMLEAK=n

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

Please changelog this alteration.

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

And we'd want __GFP_TRACKLEAK to evaluate to zero at compile time if
CONFIG_HAVE_DEBUG_KMEMLEAK=n.

> +		kmemleak_alloc(page_address(page), PAGE_SIZE << order, 1, gfp & ~__GFP_TRACKLEAK);
> +		__SetPageTrackleak(page);
> +	}
>  
>  	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
>  
> -- 
> 1.9.1
