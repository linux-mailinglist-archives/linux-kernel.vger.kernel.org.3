Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A64F782A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242312AbiDGHyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiDGHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:54:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BC418C0E4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:52:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8BC90210EF;
        Thu,  7 Apr 2022 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649317933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zWmpc092tOcya/29a+FKCu5SoYVLPEQ0a1ocdxoIgpU=;
        b=ljLPYDRFHHB+SzzZTc9hlSm2Gj/QtdkeLU18ocSv7uYFV6dW9uZk/9g/R/g1FwXuaICviB
        Rl5iRgu0TJG7LzIwQYdWcC/kjxlZDS9D+wWT7bpxhDTrMQUmd24o2ppC+rkMYmn/yEPb0o
        /sgQLKx5JWJYsmQPKGV/RVhFqpSpeLE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D78DAA3B87;
        Thu,  7 Apr 2022 07:52:07 +0000 (UTC)
Date:   Thu, 7 Apr 2022 09:52:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     ying.huang@intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
Message-ID: <Yk6YKwZR5JjBokOs@dhcp22.suse.cz>
References: <20220407020953.475626-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407020953.475626-1-shy828301@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Aaron who has introduced the per node swap changes]

On Wed 06-04-22 19:09:53, Yang Shi wrote:
> The swap devices are linked to per node priority lists, the swap device
> closer to the node has higher priority on that node's priority list.
> This is supposed to improve I/O latency, particularly for some fast
> devices.  But the current code gets nid by calling numa_node_id() which
> actually returns the nid that the reclaimer is running on instead of the
> nid that the page belongs to.
> 
> Pass the page's nid dow to get_swap_pages() in order to pick up the
> right swap device.  But it doesn't work for the swap slots cache which
> is per cpu.  We could skip swap slots cache if the current node is not
> the page's node, but it may be overkilling. So keep using the current
> node's swap slots cache.  The issue was found by visual code inspection
> so it is not sure how much improvement could be achieved due to lack of
> suitable testing device.  But anyway the current code does violate the
> design.

Do you have any perf numbers for this change?
 
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

-- 
Michal Hocko
SUSE Labs
