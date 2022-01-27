Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DB249E3B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbiA0NkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiA0NkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:40:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DE7C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D4EAB8218E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DEBC340E4;
        Thu, 27 Jan 2022 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643290803;
        bh=/GQZUk05/9XHayp0BCU3oCR2q6TqLRivsthtfvd3NB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbRe9mSP3Pg1Ss87/IQQJHhNfow0CYWgk0i4/n1LwrfxZNtCPKY134/5e+ZKkOsco
         BlWYFeKOi58ZYFpShB7ZiqnpHSpRzcxbA2Peh8d0lWQ8cb/ITMLUETt94PsAJC3pBm
         NWiJpMHjFeOIwGBNOKCYnL9cDeQZZEbVa/j9H+19wH7k4vEFVfGSfaUlmAQv4jsPmy
         B/Ijtvugteni7kSOo68xOtR0UYDtrRiJgpMiqbHQxYAhfW5EaWxWs19gZ6qAEwbMzz
         NCeAZgsahdXltqGr3gM9MzKTrJk9p1YhdRQ3Zd4Lox8MlhwGU6knqbujKxpDFhAvBX
         ASe1ZwP5YGBaQ==
Date:   Thu, 27 Jan 2022 15:39:55 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 4/6] mm, memory_hotplug: reorganize new pgdat
 initialization
Message-ID: <YfKgq116n7vLRIa7@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-5-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-5-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:03AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> When a !node_online node is brought up it needs a hotplug specific
> initialization because the node could be either uninitialized yet or it
> could have been recycled after previous hotremove. hotadd_init_pgdat is
> responsible for that.
> 
> Internal pgdat state is initialized at two places currently
> 	- hotadd_init_pgdat
> 	- free_area_init_core_hotplug
> There is no real clear cut what should go where but this patch's chosen to
> move the whole internal state initialization into free_area_init_core_hotplug.
> hotadd_init_pgdat is still responsible to pull all the parts together -
> most notably to initialize zonelists because those depend on the overall topology.
> 
> This patch doesn't introduce any functional change.
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/memory_hotplug.h |  2 +-
>  mm/memory_hotplug.c            | 28 +++-------------------------
>  mm/page_alloc.c                | 25 +++++++++++++++++++++++--
>  3 files changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 60f09d3ebb3d..76bf2de86def 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -319,7 +319,7 @@ extern void set_zone_contiguous(struct zone *zone);
>  extern void clear_zone_contiguous(struct zone *zone);
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -extern void __ref free_area_init_core_hotplug(int nid);
> +extern void __ref free_area_init_core_hotplug(struct pglist_data *pgdat);
>  extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>  extern int add_memory_resource(int nid, struct resource *resource,
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 875cdc7ffa58..ddc62f8b591f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1166,39 +1166,16 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  {
>  	struct pglist_data *pgdat;
>  
> -	pgdat = NODE_DATA(nid);
> -
>  	/*
>  	 * NODE_DATA is preallocated (free_area_init) but its internal
>  	 * state is not allocated completely. Add missing pieces.
>  	 * Completely offline nodes stay around and they just need
>  	 * reintialization.
>  	 */
> -	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
> -		pgdat->per_cpu_nodestats =
> -			alloc_percpu(struct per_cpu_nodestat);
> -	} else {
> -		int cpu;
> -		/*
> -		 * Reset the nr_zones, order and highest_zoneidx before reuse.
> -		 * Note that kswapd will init kswapd_highest_zoneidx properly
> -		 * when it starts in the near future.
> -		 */
> -		pgdat->nr_zones = 0;
> -		pgdat->kswapd_order = 0;
> -		pgdat->kswapd_highest_zoneidx = 0;
> -		for_each_online_cpu(cpu) {
> -			struct per_cpu_nodestat *p;
> -
> -			p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> -			memset(p, 0, sizeof(*p));
> -		}
> -	}
> -
> -	pgdat->node_start_pfn = 0;
> +	pgdat = NODE_DATA(nid);
>  
>  	/* init node's zones as empty zones, we don't have any present pages.*/
> -	free_area_init_core_hotplug(nid);
> +	free_area_init_core_hotplug(pgdat);
>  
>  	/*
>  	 * The node we allocated has no zone fallback lists. For avoiding
> @@ -1210,6 +1187,7 @@ static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  	 * When memory is hot-added, all the memory is in offline state. So
>  	 * clear all zones' present_pages because they will be updated in
>  	 * online_pages() and offline_pages().
> +	 * TODO: should be in free_area_init_core_hotplug?
>  	 */
>  	reset_node_managed_pages(pgdat);
>  	reset_node_present_pages(pgdat);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1a05669044d3..32d0189de4c5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7506,12 +7506,33 @@ static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx,
>   * NOTE: this function is only called during memory hotplug
>   */
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -void __ref free_area_init_core_hotplug(int nid)
> +void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  {
> +	int nid = pgdat->node_id;
>  	enum zone_type z;
> -	pg_data_t *pgdat = NODE_DATA(nid);
> +	int cpu;
>  
>  	pgdat_init_internals(pgdat);
> +
> +	if (pgdat->per_cpu_nodestats == &boot_nodestats)
> +		pgdat->per_cpu_nodestats = alloc_percpu(struct per_cpu_nodestat);
> +
> +	/*
> +	 * Reset the nr_zones, order and highest_zoneidx before reuse.
> +	 * Note that kswapd will init kswapd_highest_zoneidx properly
> +	 * when it starts in the near future.
> +	 */
> +	pgdat->nr_zones = 0;
> +	pgdat->kswapd_order = 0;
> +	pgdat->kswapd_highest_zoneidx = 0;
> +	pgdat->node_start_pfn = 0;
> +	for_each_online_cpu(cpu) {
> +		struct per_cpu_nodestat *p;
> +
> +		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> +		memset(p, 0, sizeof(*p));
> +	}

It seems to me that most of this is already done by free_area_init_node()
at boot time anyway. Do I miss something?

> +
>  	for (z = 0; z < MAX_NR_ZONES; z++)
>  		zone_init_internals(&pgdat->node_zones[z], z, nid, 0);
>  }
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
