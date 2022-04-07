Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877CF4F7935
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiDGIO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiDGIOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:14:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAA2100A5A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649319177; x=1680855177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AjVgvE/DkaKviw97JGgJFD73gnHwnDL+e+OjQnruVKI=;
  b=cA2R46CE85fJhSIo1VC/fHT6gb+XrL1zgBlrU/mMtSEGUMyuDxefKmX5
   Kqo6TEyAe1E9gNxXMYEw5sRn6MirFM0xZOhFh6Y4YMW51pI2uYtrxmqHg
   u2vIXsbPD9LZCYuMW4+8JvHVoMT7VfJ+14yB/k1/5TOI9Mt6J95pF6I5K
   e5RSIUsWe5AojiKoocJ39D2KN0WsiZ42Vsi82UUJCq1XVlVyA4tIRviXA
   pNCouIWEDdeXhYK8b4DrDF7TtnC3jZNN540ua0LhApY1AaK6Ee36j4xiM
   /Gm1m+s7S+Le6VQJTers9J2CfoUlESmfMOZ0sUWCaxlTBC+FKmu/yu9wk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="248783335"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="248783335"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 01:12:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="722864004"
Received: from ziqianlu-desk.sh.intel.com (HELO ziqianlu-nuc9qn) ([10.238.5.244])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 01:12:54 -0700
Date:   Thu, 7 Apr 2022 16:13:00 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     ying.huang@intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
Message-ID: <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
References: <20220407020953.475626-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407020953.475626-1-shy828301@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 07:09:53PM -0700, Yang Shi wrote:
> The swap devices are linked to per node priority lists, the swap device
> closer to the node has higher priority on that node's priority list.
> This is supposed to improve I/O latency, particularly for some fast
> devices.  But the current code gets nid by calling numa_node_id() which
> actually returns the nid that the reclaimer is running on instead of the
> nid that the page belongs to.
>

Right.

> Pass the page's nid dow to get_swap_pages() in order to pick up the
> right swap device.  But it doesn't work for the swap slots cache which
> is per cpu.  We could skip swap slots cache if the current node is not
> the page's node, but it may be overkilling. So keep using the current
> node's swap slots cache.  The issue was found by visual code inspection
> so it is not sure how much improvement could be achieved due to lack of
> suitable testing device.  But anyway the current code does violate the
> design.
>

I intentionally used the reclaimer's nid because I think when swapping
out to a device, it is faster when the device is on the same node as
the cpu.

Anyway, I think I can make a test case where the workload allocates all
its memory on the remote node and its workingset memory is larger then
the available memory so swap is triggered, then we can see which way
achieves better performance. Sounds reasonable to you?

> Cc: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/swap.h | 3 ++-
>  mm/swap_slots.c      | 7 ++++---
>  mm/swapfile.c        | 5 ++---
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 27093b477c5f..e442cf6b61ea 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -497,7 +497,8 @@ extern void si_swapinfo(struct sysinfo *);
>  extern swp_entry_t get_swap_page(struct page *page);
>  extern void put_swap_page(struct page *page, swp_entry_t entry);
>  extern swp_entry_t get_swap_page_of_type(int);
> -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
> +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size,
> +			  int node);
>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>  extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 2b5531840583..a1c5cf6a4302 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>  	cache->cur = 0;
>  	if (swap_slot_cache_active)
>  		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
> -					   cache->slots, 1);
> +					   cache->slots, 1, numa_node_id());
>  
>  	return cache->nr;
>  }
> @@ -305,12 +305,13 @@ swp_entry_t get_swap_page(struct page *page)
>  {
>  	swp_entry_t entry;
>  	struct swap_slots_cache *cache;
> +	int nid = page_to_nid(page);
>  
>  	entry.val = 0;
>  
>  	if (PageTransHuge(page)) {
>  		if (IS_ENABLED(CONFIG_THP_SWAP))
> -			get_swap_pages(1, &entry, HPAGE_PMD_NR);
> +			get_swap_pages(1, &entry, HPAGE_PMD_NR, nid);
>  		goto out;
>  	}
>  
> @@ -342,7 +343,7 @@ swp_entry_t get_swap_page(struct page *page)
>  			goto out;
>  	}
>  
> -	get_swap_pages(1, &entry, 1);
> +	get_swap_pages(1, &entry, 1, nid);
>  out:
>  	if (mem_cgroup_try_charge_swap(page, entry)) {
>  		put_swap_page(page, entry);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 63c61f8b2611..151fffe0fd60 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1036,13 +1036,13 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>  	swap_range_free(si, offset, SWAPFILE_CLUSTER);
>  }
>  
> -int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
> +int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size,
> +		   int node)
>  {
>  	unsigned long size = swap_entry_size(entry_size);
>  	struct swap_info_struct *si, *next;
>  	long avail_pgs;
>  	int n_ret = 0;
> -	int node;
>  
>  	/* Only single cluster request supported */
>  	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
> @@ -1060,7 +1060,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  	atomic_long_sub(n_goal * size, &nr_swap_pages);
>  
>  start_over:
> -	node = numa_node_id();
>  	plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
>  		/* requeue si to after same-priority siblings */
>  		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
> -- 
> 2.26.3
> 
> 
