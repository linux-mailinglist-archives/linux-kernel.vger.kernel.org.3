Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C605108EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354114AbiDZT2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353986AbiDZT2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:28:12 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A643DE3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:24:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so2571060pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1gRXhqhj/bM5wwRMAh+OmVjooRqWfpept41xU9+vg70=;
        b=TOFTN7H84kwY6vnbuYIk0C/dboVB39Ds8vAY+DZAx7T/uZfgOApoYgoj/FlFBd8Gtw
         y4uSAgvX3uzwT5w3Qd3420Ctgp/7rZanshzUCbfG5zPF8/hFLvXWithppQ1K3oS4IOvA
         aWMhhi1U2IeS3KSGiehirQKJeOLGieKzycUPAKZiX4TXQyWwElMW7jJ8UetVgd1SastI
         mL7jgr6EN3WCWmEFTvTA7g4cZ2R0YvBp8W/km72mkdYqeOjnk2kek42aZyxoGVZARdUS
         /BGksTZTgNOK7JuKp/cHt0acE7EfsT2CSviVbXGrnK0MMEGI4Lo7a+wbXXgKM5EYV9GJ
         yXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1gRXhqhj/bM5wwRMAh+OmVjooRqWfpept41xU9+vg70=;
        b=4TuDA5R5e4k5/sMfHn6r3oXgHpE9Ba8q1TBVq+cA31yYhf1LdYYqEvzHoJGGxFf9n8
         KCeh4r06Bms5JGYaTAhdXiessCGGuBGdxFa4IYDe7m75eGcKqE+/ahBno6en8wnF+SNW
         hFGyJsvejR1xsI9TWzgOtHcXHvkMnA7R22UupIBPVxkh1vbD5b4ZuiY2MIqrJsRF3S5S
         iNOZeBo7fsJssrYz8Xo3VxzN6d+pyLqKMJSgqx5JErbDxD3pmz2f0GuczxFDzpnAH9Hn
         Nx59V6Zu6gYh1FFSC41rA8lCJvIfo2hoGTOLclz5JKdoEsZx6NYoFSge225POUu+O1w1
         hPaQ==
X-Gm-Message-State: AOAM531uMYxhAVxgpKT8jmic/tojpOkcDWZJEBhmOs20KVw/vll3q1Pf
        Y1xiVduXjg7omHy5A7g0zt9T9FonIo0=
X-Google-Smtp-Source: ABdhPJzBKsUgopZ3q4lNadS+bEUUni4aRgvxc7eVyOiznOGgervr+qKDpvQVQCNJBoD/8fovUSkY3A==
X-Received: by 2002:a17:90b:4a8a:b0:1d2:f7ba:8728 with SMTP id lp10-20020a17090b4a8a00b001d2f7ba8728mr28529353pjb.43.1651001098561;
        Tue, 26 Apr 2022 12:24:58 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:25e7:9cdf:1522:323f])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm17165282pfl.15.2022.04.26.12.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 12:24:58 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 26 Apr 2022 12:24:56 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
Message-ID: <YmhHCHaUy+zARWxi@google.com>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
 <20220420095906.27349-6-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420095906.27349-6-mgorman@techsingularity.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:59:05AM +0100, Mel Gorman wrote:
> Currently the PCP lists are protected by using local_lock_irqsave to
> prevent migration and IRQ reentrancy but this is inconvenient. Remote
> draining of the lists is impossible and a workqueue is required and
> every task allocation/free must disable then enable interrupts which is
> expensive.
> 
> As preparation for dealing with both of those problems, protect the
> lists with a spinlock. The IRQ-unsafe version of the lock is used
> because IRQs are already disabled by local_lock_irqsave. spin_trylock
> is used in preparation for a time when local_lock could be used instead
> of lock_lock_irqsave.
> 
> The per_cpu_pages still fits within the same number of cache lines after
> this patch relative to before the series.
> 
> struct per_cpu_pages {
>         spinlock_t                 lock;                 /*     0     4 */
>         int                        count;                /*     4     4 */
>         int                        high;                 /*     8     4 */
>         int                        batch;                /*    12     4 */
>         short int                  free_factor;          /*    16     2 */
>         short int                  expire;               /*    18     2 */
> 
>         /* XXX 4 bytes hole, try to pack */
> 
>         struct list_head           lists[13];            /*    24   208 */
> 
>         /* size: 256, cachelines: 4, members: 7 */
>         /* sum members: 228, holes: 1, sum holes: 4 */
>         /* padding: 24 */
> } __attribute__((__aligned__(64)));
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/mmzone.h |   1 +
>  mm/page_alloc.c        | 155 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 136 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index abe530748de6..8b5757735428 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -385,6 +385,7 @@ enum zone_watermarks {
>  
>  /* Fields and list protected by pagesets local_lock in page_alloc.c */
>  struct per_cpu_pages {
> +	spinlock_t lock;	/* Protects lists field */
>  	int count;		/* number of pages in the list */
>  	int high;		/* high watermark, emptying needed */
>  	int batch;		/* chunk size for buddy add/remove */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index dc0fdeb3795c..813c84b67c65 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -132,6 +132,17 @@ static DEFINE_PER_CPU(struct pagesets, pagesets) __maybe_unused = {
>  	.lock = INIT_LOCAL_LOCK(lock),
>  };
>  
> +#ifdef CONFIG_SMP
> +/* On SMP, spin_trylock is sufficient protection */
> +#define pcp_trylock_prepare(flags)	do { } while (0)
> +#define pcp_trylock_finish(flag)	do { } while (0)
> +#else
> +
> +/* UP spin_trylock always succeeds so disable IRQs to prevent re-entrancy. */
> +#define pcp_trylock_prepare(flags)	local_irq_save(flags)
> +#define pcp_trylock_finish(flags)	local_irq_restore(flags)
> +#endif
> +
>  #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
>  DEFINE_PER_CPU(int, numa_node);
>  EXPORT_PER_CPU_SYMBOL(numa_node);
> @@ -3082,15 +3093,22 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>   */
>  void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>  {
> -	unsigned long flags;
>  	int to_drain, batch;
>  
> -	local_lock_irqsave(&pagesets.lock, flags);
>  	batch = READ_ONCE(pcp->batch);
>  	to_drain = min(pcp->count, batch);
> -	if (to_drain > 0)
> +	if (to_drain > 0) {
> +		unsigned long flags;
> +
> +		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
> +		local_irq_save(flags);
> +
> +		spin_lock(&pcp->lock);
>  		free_pcppages_bulk(zone, to_drain, pcp, 0);
> -	local_unlock_irqrestore(&pagesets.lock, flags);
> +		spin_unlock(&pcp->lock);
> +
> +		local_irq_restore(flags);
> +	}
>  }
>  #endif
>  
> @@ -3103,16 +3121,21 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
>   */
>  static void drain_pages_zone(unsigned int cpu, struct zone *zone)
>  {
> -	unsigned long flags;
>  	struct per_cpu_pages *pcp;
>  
> -	local_lock_irqsave(&pagesets.lock, flags);
> -
>  	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> -	if (pcp->count)
> +	if (pcp->count) {
> +		unsigned long flags;
> +
> +		/* free_pcppages_bulk expects IRQs disabled for zone->lock */
> +		local_irq_save(flags);
> +
> +		spin_lock(&pcp->lock);
>  		free_pcppages_bulk(zone, pcp->count, pcp, 0);
> +		spin_unlock(&pcp->lock);
>  
> -	local_unlock_irqrestore(&pagesets.lock, flags);
> +		local_irq_restore(flags);
> +	}
>  }
>  
>  /*
> @@ -3380,18 +3403,30 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
>  	return min(READ_ONCE(pcp->batch) << 2, high);
>  }
>  
> -static void free_unref_page_commit(struct page *page, int migratetype,
> -				   unsigned int order)
> +/* Returns true if the page was committed to the per-cpu list. */
> +static bool free_unref_page_commit(struct page *page, int migratetype,
> +				   unsigned int order, bool locked)
>  {
>  	struct zone *zone = page_zone(page);
>  	struct per_cpu_pages *pcp;
>  	int high;
>  	int pindex;
>  	bool free_high;
> +	unsigned long __maybe_unused UP_flags;
>  
>  	__count_vm_event(PGFREE);
>  	pcp = this_cpu_ptr(zone->per_cpu_pageset);
>  	pindex = order_to_pindex(migratetype, order);
> +
> +	if (!locked) {
> +		/* Protect against a parallel drain. */
> +		pcp_trylock_prepare(UP_flags);
> +		if (!spin_trylock(&pcp->lock)) {
> +			pcp_trylock_finish(UP_flags);
> +			return false;
> +		}
> +	}
> +
>  	list_add(&page->pcp_list, &pcp->lists[pindex]);
>  	pcp->count += 1 << order;
>  
> @@ -3409,6 +3444,13 @@ static void free_unref_page_commit(struct page *page, int migratetype,
>  
>  		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch, free_high), pcp, pindex);
>  	}
> +
> +	if (!locked) {
> +		spin_unlock(&pcp->lock);
> +		pcp_trylock_finish(UP_flags);
> +	}
> +
> +	return true;
>  }
>  
>  /*
> @@ -3419,6 +3461,7 @@ void free_unref_page(struct page *page, unsigned int order)
>  	unsigned long flags;
>  	unsigned long pfn = page_to_pfn(page);
>  	int migratetype;
> +	bool freed_pcp = false;
>  
>  	if (!free_unref_page_prepare(page, pfn, order))
>  		return;
> @@ -3440,8 +3483,11 @@ void free_unref_page(struct page *page, unsigned int order)
>  	}
>  
>  	local_lock_irqsave(&pagesets.lock, flags);
> -	free_unref_page_commit(page, migratetype, order);
> +	freed_pcp = free_unref_page_commit(page, migratetype, order, false);
>  	local_unlock_irqrestore(&pagesets.lock, flags);
> +
> +	if (unlikely(!freed_pcp))
> +		free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
>  }
>  
>  /*
> @@ -3450,10 +3496,19 @@ void free_unref_page(struct page *page, unsigned int order)
>  void free_unref_page_list(struct list_head *list)
>  {
>  	struct page *page, *next;
> +	struct per_cpu_pages *pcp;
> +	struct zone *locked_zone;
>  	unsigned long flags;
>  	int batch_count = 0;
>  	int migratetype;
>  
> +	/*
> +	 * An empty list is possible. Check early so that the later
> +	 * lru_to_page() does not potentially read garbage.
> +	 */
> +	if (list_empty(list))
> +		return;
> +
>  	/* Prepare pages for freeing */
>  	list_for_each_entry_safe(page, next, list, lru) {
>  		unsigned long pfn = page_to_pfn(page);
> @@ -3474,8 +3529,26 @@ void free_unref_page_list(struct list_head *list)
>  		}
>  	}
>  
> +	VM_BUG_ON(in_hardirq());

You need to check the list_empty here again and bail out if it is.

> +
>  	local_lock_irqsave(&pagesets.lock, flags);
> +
> +	page = lru_to_page(list);
