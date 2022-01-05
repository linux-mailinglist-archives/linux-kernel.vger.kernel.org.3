Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EED484F78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiAEInU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:43:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:36350 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiAEInS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:43:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ADCAB21114;
        Wed,  5 Jan 2022 08:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641372197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FT/VuToy2Eu4VS+nNu+XEYvEbdSYRMhgODivdBNNFm0=;
        b=qZu8K+oPNpB7qW4wAC1CC7M3uY1ZQr78I5tFzL/yKwbx2Kfnv27/7D6W9X7Ik11NULl2IN
        R26T3dkfwNC1SAvisyENG5vmSa0+Qp3xM99WUbrr9RxJkeKrsTH76T1to9R2bmpjt3jooQ
        3XN8MPXA1yxAUQigSW6kaUBtBse0CCo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 27CB7A3B87;
        Wed,  5 Jan 2022 08:43:17 +0000 (UTC)
Date:   Wed, 5 Jan 2022 09:43:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] memcg: add per-memcg vmalloc stat
Message-ID: <YdVaJKOnb1IaWcAH@dhcp22.suse.cz>
References: <20220104222341.3972772-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104222341.3972772-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-01-22 14:23:41, Shakeel Butt wrote:
> The kvmalloc* allocation functions can fallback to vmalloc allocations
> and more often on long running machines. In addition the kernel does
> have __GFP_ACCOUNT kvmalloc* calls. So, often on long running machines,
> the memory.stat does not tell the complete picture which type of memory
> is charged to the memcg. So add a per-memcg vmalloc stat.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> 
> ---
> Changes since v3:
> - Removed area->page[0] checks and moved to page by page accounting as
>   suggested by Michal
> 
> Changes since v2:
> - remove cast, per Muchun
> - add area->page[0] check, per Michal
> 
> Changes since v1:
> - page_memcg() within rcu lock as suggested by Muchun.
> 
>  Documentation/admin-guide/cgroup-v2.rst |  3 +++
>  include/linux/memcontrol.h              | 21 +++++++++++++++++++++
>  mm/memcontrol.c                         |  1 +
>  mm/vmalloc.c                            | 13 +++++++++++--
>  4 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 82c8dc91b2be..5aa368d165da 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1314,6 +1314,9 @@ PAGE_SIZE multiple when read back.
>  	  sock (npn)
>  		Amount of memory used in network transmission buffers
>  
> +	  vmalloc (npn)
> +		Amount of memory used for vmap backed memory.
> +
>  	  shmem
>  		Amount of cached filesystem data that is swap-backed,
>  		such as tmpfs, shm segments, shared anonymous mmap()s
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d76dad703580..b72d75141e12 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -33,6 +33,7 @@ enum memcg_stat_item {
>  	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
>  	MEMCG_SOCK,
>  	MEMCG_PERCPU_B,
> +	MEMCG_VMALLOC,
>  	MEMCG_NR_STAT,
>  };
>  
> @@ -944,6 +945,21 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>  	local_irq_restore(flags);
>  }
>  
> +static inline void mod_memcg_page_state(struct page *page,
> +					int idx, int val)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	rcu_read_lock();
> +	memcg = page_memcg(page);
> +	if (memcg)
> +		mod_memcg_state(memcg, idx, val);
> +	rcu_read_unlock();
> +}
> +
>  static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>  {
>  	return READ_ONCE(memcg->vmstats.state[idx]);
> @@ -1399,6 +1415,11 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>  {
>  }
>  
> +static inline void mod_memcg_page_state(struct page *page,
> +					int idx, int val)
> +{
> +}
> +
>  static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>  {
>  	return 0;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 101b22a23096..56ed6b5dd328 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1375,6 +1375,7 @@ static const struct memory_stat memory_stats[] = {
>  	{ "pagetables",			NR_PAGETABLE			},
>  	{ "percpu",			MEMCG_PERCPU_B			},
>  	{ "sock",			MEMCG_SOCK			},
> +	{ "vmalloc",			MEMCG_VMALLOC			},
>  	{ "shmem",			NR_SHMEM			},
>  	{ "file_mapped",		NR_FILE_MAPPED			},
>  	{ "file_dirty",			NR_FILE_DIRTY			},
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index eb6e527a6b77..bdc7222f87d4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -31,6 +31,7 @@
>  #include <linux/kmemleak.h>
>  #include <linux/atomic.h>
>  #include <linux/compiler.h>
> +#include <linux/memcontrol.h>
>  #include <linux/llist.h>
>  #include <linux/bitops.h>
>  #include <linux/rbtree_augmented.h>
> @@ -2624,12 +2625,13 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  
>  	if (deallocate_pages) {
>  		unsigned int page_order = vm_area_page_order(area);
> -		int i;
> +		int i, step = 1U << page_order;
>  
> -		for (i = 0; i < area->nr_pages; i += 1U << page_order) {
> +		for (i = 0; i < area->nr_pages; i += step) {
>  			struct page *page = area->pages[i];
>  
>  			BUG_ON(!page);
> +			mod_memcg_page_state(page, MEMCG_VMALLOC, -step);
>  			__free_pages(page, page_order);
>  			cond_resched();
>  		}
> @@ -2964,6 +2966,13 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		page_order, nr_small_pages, area->pages);
>  
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> +	if (gfp_mask & __GFP_ACCOUNT) {
> +		int i, step = 1U << page_order;
> +
> +		for (i = 0; i < area->nr_pages; i += step)
> +			mod_memcg_page_state(area->pages[i], MEMCG_VMALLOC,
> +					     step);
> +	}
>  
>  	/*
>  	 * If not enough pages were obtained to accomplish an
> -- 
> 2.34.1.448.ga2b2bfdf31-goog

-- 
Michal Hocko
SUSE Labs
