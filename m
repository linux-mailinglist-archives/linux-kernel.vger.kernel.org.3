Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D57749E3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242078AbiA0NjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242056AbiA0Ni0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:38:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D654C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:37:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBDEAB8218D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E609FC340E4;
        Thu, 27 Jan 2022 13:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643290652;
        bh=1/SmwgiDefImub5WbLopvwdqk3aBVzRX6c4Cijr/1g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cDdFsA8TULGMtvyR9dy+UMlS8vm0KlUWvHi7xxXoz9KGMpusUN73YYDQXOKQxHqhY
         VcK/YK1ZPvXRV6yduYKBSxkxKnKefyOcvfRVeow9//gJOcZvCXjxTpKzdbfbt9zmCd
         ChUc1zVD41w1JGEumOdesZDiY4pLWjhQo7QddZn5sd7Uqu/yzIoWWcg9dSk1kQMSE+
         wWKNeM/l+2jA7XURg2JeDLlslns76878+Thw9ts5SVium4nNgVzP0x7cnD6kdU5FEg
         Vx+2APTVcns7rdzQ1uXbaKC8Ojd7O7gncXXm0KijAqEhu1RXuks48HNdOuRN1d3Oz9
         S7BpECSNudpVA==
Date:   Thu, 27 Jan 2022 15:37:23 +0200
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
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
Message-ID: <YfKgE5hTgbaBeaMa@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-3-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:01AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> We have had several reports [1][2][3] that page allocator blows up when
> an allocation from a possible node is requested. The underlying reason
> is that NODE_DATA for the specific node is not allocated.
> 
> NUMA specific initialization is arch specific and it can vary a lot.
> E.g. x86 tries to initialize all nodes that have some cpu affinity (see
> init_cpu_to_node) but this can be insufficient because the node might be
> cpuless for example.
> 
> One way to address this problem would be to check for !node_online nodes
> when trying to get a zonelist and silently fall back to another node.
> That is unfortunately adding a branch into allocator hot path and it
> doesn't handle any other potential NODE_DATA users.
> 
> This patch takes a different approach (following a lead of [3]) and it
> pre allocates pgdat for all possible nodes in an arch indipendent code
> - free_area_init. All uninitialized nodes are treated as memoryless
> nodes. node_state of the node is not changed because that would lead to
> other side effects - e.g. sysfs representation of such a node and from
> past discussions [4] it is known that some tools might have problems
> digesting that.
> 
> Newly allocated pgdat only gets a minimal initialization and the rest of
> the work is expected to be done by the memory hotplug - hotadd_new_pgdat
> (renamed to hotadd_init_pgdat).
> 
> generic_alloc_nodedata is changed to use the memblock allocator because
> neither page nor slab allocators are available at the stage when all
> pgdats are allocated. Hotplug doesn't allocate pgdat anymore so we can
> use the early boot allocator. The only arch specific implementation is
> ia64 and that is changed to use the early allocator as well.
> 
> Reported-by: Alexey Makhalov <amakhalov@vmware.com>
> Tested-by: Alexey Makhalov <amakhalov@vmware.com>
> Reported-by: Nico Pache <npache@redhat.com>
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Tested-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Some minor nits below, other than that

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> 
> [1] http://lkml.kernel.org/r/20211101201312.11589-1-amakhalov@vmware.com
> [2] http://lkml.kernel.org/r/20211207224013.880775-1-npache@redhat.com
> [3] http://lkml.kernel.org/r/20190114082416.30939-1-mhocko@kernel.org
> [4] http://lkml.kernel.org/r/20200428093836.27190-1-srikar@linux.vnet.ibm.com
> ---
>  arch/ia64/mm/discontig.c       |  4 ++--
>  include/linux/memory_hotplug.h |  2 +-
>  mm/memory_hotplug.c            | 21 +++++++++------------
>  mm/page_alloc.c                | 34 +++++++++++++++++++++++++++++++---
>  4 files changed, 43 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> index 8dc8a554f774..dd0cf4834eaa 100644
> --- a/arch/ia64/mm/discontig.c
> +++ b/arch/ia64/mm/discontig.c
> @@ -608,11 +608,11 @@ void __init paging_init(void)
>  	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
>  }
>  
> -pg_data_t *arch_alloc_nodedata(int nid)
> +pg_data_t * __init arch_alloc_nodedata(int nid)
>  {
>  	unsigned long size = compute_pernodesize(nid);
>  
> -	return kzalloc(size, GFP_KERNEL);
> +	return memblock_alloc(size, SMP_CACHE_BYTES);
>  }
>  
>  void arch_free_nodedata(pg_data_t *pgdat)
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 4355983b364d..cdd66bfdf855 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -44,7 +44,7 @@ extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
>   */
>  #define generic_alloc_nodedata(nid)				\
>  ({								\
> -	kzalloc(sizeof(pg_data_t), GFP_KERNEL);			\
> +	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
>  })
>  /*
>   * This definition is just for error path in node hotadd.
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 2a9627dc784c..fc991831d296 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1162,19 +1162,21 @@ static void reset_node_present_pages(pg_data_t *pgdat)
>  }
>  
>  /* we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG */
> -static pg_data_t __ref *hotadd_new_pgdat(int nid)
> +static pg_data_t __ref *hotadd_init_pgdat(int nid)
>  {
>  	struct pglist_data *pgdat;
>  
>  	pgdat = NODE_DATA(nid);
> -	if (!pgdat) {
> -		pgdat = arch_alloc_nodedata(nid);
> -		if (!pgdat)
> -			return NULL;
>  
> +	/*
> +	 * NODE_DATA is preallocated (free_area_init) but its internal
> +	 * state is not allocated completely. Add missing pieces.
> +	 * Completely offline nodes stay around and they just need
> +	 * reintialization.
> +	 */
> +	if (pgdat->per_cpu_nodestats == &boot_nodestats) {
>  		pgdat->per_cpu_nodestats =
>  			alloc_percpu(struct per_cpu_nodestat);
> -		arch_refresh_nodedata(nid, pgdat);
>  	} else {
>  		int cpu;
>  		/*
> @@ -1193,8 +1195,6 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid)
>  		}
>  	}
>  
> -	/* we can use NODE_DATA(nid) from here */
> -	pgdat->node_id = nid;
>  	pgdat->node_start_pfn = 0;
>  
>  	/* init node's zones as empty zones, we don't have any present pages.*/
> @@ -1246,7 +1246,7 @@ static int __try_online_node(int nid, bool set_node_online)
>  	if (node_online(nid))
>  		return 0;
>  
> -	pgdat = hotadd_new_pgdat(nid);
> +	pgdat = hotadd_init_pgdat(nid);
>  	if (!pgdat) {
>  		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
>  		ret = -ENOMEM;
> @@ -1445,9 +1445,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  
>  	return ret;
>  error:
> -	/* rollback pgdat allocation and others */
> -	if (new_node)
> -		rollback_node_hotadd(nid);
>  	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
>  		memblock_remove(start, size);
>  error_mem_hotplug_end:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589febc6d31..1a05669044d3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6402,7 +6402,11 @@ static void __build_all_zonelists(void *data)
>  	if (self && !node_online(self->node_id)) {
>  		build_zonelists(self);
>  	} else {
> -		for_each_online_node(nid) {
> +		/*
> +		 * All possible nodes have pgdat preallocated
> +		 * free_area_init

Nit: "by free_area_init"

> +		 */
> +		for_each_node(nid) {
>  			pg_data_t *pgdat = NODE_DATA(nid);
>  
>  			build_zonelists(pgdat);
> @@ -8096,8 +8100,32 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  	/* Initialise every node */
>  	mminit_verify_pageflags_layout();
>  	setup_nr_node_ids();
> -	for_each_online_node(nid) {
> -		pg_data_t *pgdat = NODE_DATA(nid);
> +	for_each_node(nid) {
> +		pg_data_t *pgdat;
> +
> +		if (!node_online(nid)) {
> +			pr_warn("Node %d uninitialized by the platform. Please report with boot dmesg.\n", nid);

Do we assume that platform code must allocate node data for all nodes in
the system? Because if we don't this warning is misleading.

> +
> +			/* Allocator not initialized yet */
> +			pgdat = arch_alloc_nodedata(nid);
> +			if (!pgdat) {
> +				pr_err("Cannot allocate %zuB for node %d.\n",
> +						sizeof(*pgdat), nid);
> +				continue;
> +			}
> +			arch_refresh_nodedata(nid, pgdat);
> +			free_area_init_memoryless_node(nid);
> +			/*
> +			 * not marking this node online because we do not want to
> +			 * confuse userspace by sysfs files/directories for node
> +			 * without any memory attached to it (see topology_init)
> +			 * The pgdat will get fully initialized when a memory is
> +			 * hotpluged into it by hotadd_init_pgdat
> +			 */
> +			continue;

This can be made slightly more concise if we fall through after
arch_refresh_nodedata(), e.g. something like

			...

			arch_refresh_nodedata(nid, pgdat);
		}

		pgdat = NODE_DATA(nid);
		free_area_init_node(nid);

		/*
		 * Do not mark memoryless node online because we do not want to
		 * confuse userspace by sysfs files/directories for node
		 * without any memory attached to it (see topology_init)
		 * The pgdat will get fully initialized when a memory is
		 * hotpluged into it by hotadd_init_pgdat
		 */
		if (!pgdat->node_present_pages)
			continue;

but I don't feel strongly about it.

> +		}
> +
> +		pgdat = NODE_DATA(nid);
>  		free_area_init_node(nid);
>  
>  		/* Any memory on that node */
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
