Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96464909B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbiAQNrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:47:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44622 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiAQNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:47:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 85B6B21122;
        Mon, 17 Jan 2022 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642427227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wOyNSE44kK6xC41+HeY9o5KMHdWeZPag8nufqG7r+kQ=;
        b=a2pt+/qPhTSug69pW6RB6v4uzknMCkQhWVvqoHvVCncCefvImDNkaElNJ+HjVJshxFxXS6
        208ptyY9gfUT9VwlFirdumwjt29oeZObXFMr6a/ndgWUhYbsbqa1vm8iZFMJo6SQNH0caX
        x8Hqmewhq4/7WgAA0lTtRoBGgNeQunI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 432B5A3B88;
        Mon, 17 Jan 2022 13:47:07 +0000 (UTC)
Date:   Mon, 17 Jan 2022 14:47:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YeVzWlrojI1+buQx@dhcp22.suse.cz>
References: <20211230193627.495145-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230193627.495145-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-12-21 11:36:27, Minchan Kim wrote:
> lru_cache_disable involves IPIs to drain pagevec of each core,
> which sometimes takes quite long time to complete depending
> on cpu's business, which makes allocation too slow up to
> sveral hundredth milliseconds. Furthermore, the repeated draining
> in the alloc_contig_range makes thing worse considering caller
> of alloc_contig_range usually tries multiple times in the loop.
>
> This patch makes the lru_cache_disable aware of the fact the
> pagevec was already disabled. With that, user of alloc_contig_range
> can disable the lru cache in advance in their context during the
> repeated trial so they can avoid the multiple costly draining
> in cma allocation.

Do you have any numbers on any improvements?

Now to the change. I do not like this much to be honest. LRU cache
disabling is a complex synchronization scheme implemented in
__lru_add_drain_all now you are stacking another level on top of that.

More fundamentally though. I am not sure I understand the problem TBH.
What prevents you from calling lru_cache_disable at the cma level in the
first place?

> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  * from v1 - https://lore.kernel.org/lkml/20211206221006.946661-1-minchan@kernel.org/
>    * fix lru_cache_disable race - akpm
> 
>  include/linux/swap.h | 14 ++------------
>  mm/cma.c             |  5 +++++
>  mm/swap.c            | 30 ++++++++++++++++++++++++++++--
>  3 files changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index ba52f3a3478e..fe18e86a4f13 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -348,19 +348,9 @@ extern void lru_note_cost_page(struct page *);
>  extern void lru_cache_add(struct page *);
>  extern void mark_page_accessed(struct page *);
>  
> -extern atomic_t lru_disable_count;
> -
> -static inline bool lru_cache_disabled(void)
> -{
> -	return atomic_read(&lru_disable_count);
> -}
> -
> -static inline void lru_cache_enable(void)
> -{
> -	atomic_dec(&lru_disable_count);
> -}
> -
> +extern bool lru_cache_disabled(void);
>  extern void lru_cache_disable(void);
> +extern void lru_cache_enable(void);
>  extern void lru_add_drain(void);
>  extern void lru_add_drain_cpu(int cpu);
>  extern void lru_add_drain_cpu_zone(struct zone *zone);
> diff --git a/mm/cma.c b/mm/cma.c
> index 995e15480937..60be555c5b95 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -30,6 +30,7 @@
>  #include <linux/cma.h>
>  #include <linux/highmem.h>
>  #include <linux/io.h>
> +#include <linux/swap.h>
>  #include <linux/kmemleak.h>
>  #include <trace/events/cma.h>
>  
> @@ -453,6 +454,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	if (bitmap_count > bitmap_maxno)
>  		goto out;
>  
> +	lru_cache_disable();
> +
>  	for (;;) {
>  		spin_lock_irq(&cma->lock);
>  		bitmap_no = bitmap_find_next_zero_area_off(cma->bitmap,
> @@ -492,6 +495,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  		start = bitmap_no + mask + 1;
>  	}
>  
> +	lru_cache_enable();
> +
>  	trace_cma_alloc_finish(cma->name, pfn, page, count, align);
>  
>  	/*
> diff --git a/mm/swap.c b/mm/swap.c
> index af3cad4e5378..5f89d7c9a54e 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -847,7 +847,17 @@ void lru_add_drain_all(void)
>  }
>  #endif /* CONFIG_SMP */
>  
> -atomic_t lru_disable_count = ATOMIC_INIT(0);
> +static atomic_t lru_disable_count = ATOMIC_INIT(0);
> +
> +bool lru_cache_disabled(void)
> +{
> +	return atomic_read(&lru_disable_count) != 0;
> +}
> +
> +void lru_cache_enable(void)
> +{
> +	atomic_dec(&lru_disable_count);
> +}
>  
>  /*
>   * lru_cache_disable() needs to be called before we start compiling
> @@ -859,7 +869,21 @@ atomic_t lru_disable_count = ATOMIC_INIT(0);
>   */
>  void lru_cache_disable(void)
>  {
> -	atomic_inc(&lru_disable_count);
> +	static DEFINE_MUTEX(lock);
> +
> +	/*
> +	 * The lock gaurantees lru_cache is drained when the function
> +	 * returned.
> +	 */
> +	mutex_lock(&lock);
> +	/*
> +	 * If someone is already disabled lru_cache, just return with
> +	 * increasing the lru_disable_count.
> +	 */
> +	if (atomic_inc_not_zero(&lru_disable_count)) {
> +		mutex_unlock(&lock);
> +		return;
> +	}
>  #ifdef CONFIG_SMP
>  	/*
>  	 * lru_add_drain_all in the force mode will schedule draining on
> @@ -873,6 +897,8 @@ void lru_cache_disable(void)
>  #else
>  	lru_add_and_bh_lrus_drain();
>  #endif
> +	atomic_inc(&lru_disable_count);
> +	mutex_unlock(&lock);
>  }
>  
>  /**
> -- 
> 2.34.1.448.ga2b2bfdf31-goog

-- 
Michal Hocko
SUSE Labs
