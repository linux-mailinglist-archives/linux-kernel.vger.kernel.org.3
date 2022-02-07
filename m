Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8EA4AB909
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245622AbiBGKta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbiBGKqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:46:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38A1C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:46:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EB1A61258
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81654C340F0;
        Mon,  7 Feb 2022 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644230800;
        bh=JOHuvSu0RQEMIt4Zzch2eeYu1H0BUFLaBbYPrXModLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oj7N1uQJmagKS1uoY/v/7hFNdBVZN6X9pVR61qjGYcJ7hKNM4aCXKSL3aG1s7OemY
         aG7lN2aogxiYfk6ADmBtPQXZCZcEHWGr7XuSKH4SuosXg0it58X2BxBNhLKSB32vcV
         tEcdUGx/0Ac9uTCI7kYSukZttviakQuZExGDKseZt+bLkW8M10uLKNZbbuGVr0KRRL
         ef5Iu92fu8/9ag03BD/ajx95lAI+3y6TrwYGyJjvNKXKGD9c0K2tTCmFvOqnYqnEpK
         ZJ3zJq1UPe4pmzaLxrlSrNU1pyocAFPN1rSzwu0RziLef2Vy4DeaKOEXkaujUg2jrb
         RmL13PiUUAHpQ==
Date:   Mon, 7 Feb 2022 12:46:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 47/75] mm/mlock: Turn mlock_vma_page() into
 mlock_vma_folio()
Message-ID: <YgD4irZcuuD/TWmQ@kernel.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-48-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204195852.1751729-48-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 07:58:24PM +0000, Matthew Wilcox (Oracle) wrote:
> Add mlock_vma_page() back as a wrapper.  Saves a few calls to
> compound_head() and an assertion that the page is not a tail page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/folio-compat.c |  5 +++++
>  mm/internal.h     |  3 ++-
>  mm/mlock.c        | 18 +++++++++---------
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/folio-compat.c b/mm/folio-compat.c
> index bcb037d9cec3..9cb0867d5b38 100644
> --- a/mm/folio-compat.c
> +++ b/mm/folio-compat.c
> @@ -169,3 +169,8 @@ void clear_page_mlock(struct page *page)
>  {
>  	folio_end_mlock(page_folio(page));
>  }
> +
> +void mlock_vma_page(struct page *page)
> +{
> +	mlock_vma_folio(page_folio(page));
> +}

This will make no-mmu unhappy, e.g. arm allnoconfig:

  CC      mm/folio-compat.o
mm/folio-compat.c:174:6: error: redefinition of 'mlock_vma_page'
  174 | void mlock_vma_page(struct page *page)
      |      ^~~~~~~~~~~~~~
In file included from mm/folio-compat.c:11:
mm/internal.h:501:20: note: previous definition of 'mlock_vma_page' was here
  501 | static inline void mlock_vma_page(struct page *page) { }
      |                    ^~~~~~~~~~~~~~
mm/folio-compat.c: In function 'mlock_vma_page':
mm/folio-compat.c:176:2: error: implicit declaration of function 'mlock_vma_folio'; did you mean 'mlock_vma_page'? [-Werror=implicit-function-declaration]
  176 |  mlock_vma_folio(page_folio(page));
      |  ^~~~~~~~~~~~~~~
      |  mlock_vma_page

This also applies to munlock_vma_page() and page_mlock(). 
For some reason no build yelled about clear_page_mlock()...

> diff --git a/mm/internal.h b/mm/internal.h
> index 041c76a4c284..18b024aa7e59 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -411,7 +411,8 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
>  /*
>   * must be called with vma's mmap_lock held for read or write, and page locked.
>   */
> -extern void mlock_vma_page(struct page *page);
> +void mlock_vma_page(struct page *page);
> +void mlock_vma_folio(struct folio *folio);
>  extern unsigned int munlock_vma_page(struct page *page);
>  
>  extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
> diff --git a/mm/mlock.c b/mm/mlock.c
> index ff067d64acc5..d998fd5c84bf 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -94,21 +94,21 @@ void folio_end_mlock(struct folio *folio)
>   * Mark page as mlocked if not already.
>   * If page on LRU, isolate and putback to move to unevictable list.
>   */
> -void mlock_vma_page(struct page *page)
> +void mlock_vma_folio(struct folio *folio)
>  {
>  	/* Serialize with page migration */
> -	BUG_ON(!PageLocked(page));
> +	BUG_ON(!folio_test_locked(folio));
>  
> -	VM_BUG_ON_PAGE(PageTail(page), page);
> -	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
> +	VM_BUG_ON_FOLIO(folio_test_large(folio) && folio_test_double_map(folio),
> +			folio);
>  
> -	if (!TestSetPageMlocked(page)) {
> -		int nr_pages = thp_nr_pages(page);
> +	if (!folio_test_set_mlocked(folio)) {
> +		long nr_pages = folio_nr_pages(folio);
>  
> -		mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
> +		zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
>  		count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
> -		if (!isolate_lru_page(page))
> -			putback_lru_page(page);
> +		if (!folio_isolate_lru(folio))
> +			folio_putback_lru(folio);
>  	}
>  }
>  
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
