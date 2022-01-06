Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3CC486985
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbiAFSOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiAFSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:14:21 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D72C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:14:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gp5so3170230pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GoH2UN/8qkqabVyCewCEHBZi5Bqh3qhRr5ggOkTJFF4=;
        b=aQxvqSJhcL4KnFJO2E6onDSXG/6X25osguzKHpo2otgIlcDIu7jxz8hG4q7woDNfc3
         ohTukTjB82nmeIRDqvrrOTmeaa0mILoVUemZ8wK/FjPJ1pzXBej44p5GNDLJQwVjc4Bb
         2lYlh5Q4lIkvYynjiPb48LG7zS0HTbAyJb038jyJQC64PI4PiaWzNxpFRD/nIJxCN1ST
         So8uX/VfsET5sQymJzbQ6gki1PDxvdfLl5ltlriMOe+C1LfsSSl7t3C4vXTOVGPo3EOy
         NEb6djaIB22chEKBFUQUoE6AoYRGwXLeaR1T41NzfdDr9xa3XNGYktwSuCzUKHNyomrZ
         7n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GoH2UN/8qkqabVyCewCEHBZi5Bqh3qhRr5ggOkTJFF4=;
        b=OFSMP9KmNCrC7h+DRVeWykM2fd3HnkROpPmzLlg6XpbWppflKhbxpVVkg/+/pUHkHx
         BTydo8nkFU6i6uqFLGqhsdQTHjHKEg9isomLIJoCeR5+ixw8XKiZ41UKKpCfvHlC/+Eu
         sVeAfRMK0gww3EdhArBPJ0x2GHzlEulIXgJSZjVB5IP5M5iFU6slgsfmEAORjfhd8REU
         DKLsblFa5BjQLWpRYH1DbakSE5c+AN82eTgnKA6ljAyFzm1cGld6oYz4xd3vXNGD4SYS
         DGlvpnMwUsewMNqj3+L+tcmzj7zQpNngbrrwtOGFpP5wEytdjBL+GxBFNguzhRynjrnv
         iJhA==
X-Gm-Message-State: AOAM532gkPWv07EpWKcbLfezfF3NRGDk8qU2zTQEbcJEHcM+c3dREOiv
        f2HiMwDJnHb+wcPMpesR9qsXB8go+Pc=
X-Google-Smtp-Source: ABdhPJzWO9L/JV+JRJxU8f2mZoQwRPPTOlhPOIY/mp+2/vFRiWi5b7QYr/uMrLmIH8AlJDVCRRpWtw==
X-Received: by 2002:a17:90b:688:: with SMTP id m8mr5421498pjz.62.1641492860292;
        Thu, 06 Jan 2022 10:14:20 -0800 (PST)
Received: from google.com ([2620:15c:211:201:e32:b92d:27fe:aa55])
        by smtp.gmail.com with ESMTPSA id mw8sm2992238pjb.42.2022.01.06.10.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:14:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Jan 2022 10:14:17 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [RESEND][PATCH v2] mm: don't call lru draining in the nested
 lru_cache_disable
Message-ID: <YdcxeaO+mSnAUqwf@google.com>
References: <20211230193627.495145-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230193627.495145-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 11:36:27AM -0800, Minchan Kim wrote:
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

Hi Folks,

Any comment to proceed the work?

> 
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
> 
