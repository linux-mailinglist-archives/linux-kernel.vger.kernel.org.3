Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACAF49E3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbiA0Ni0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:38:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42644 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242172AbiA0Ngt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:36:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2E7961C2A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF29C340E4;
        Thu, 27 Jan 2022 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643290608;
        bh=F9Lanb3MeXhx6oTm0RnhfrOZTdSI4PVnjIBtYmMfTyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rYhwfCBh8kuMsZ/Hq3OY89hCboiUPMld7e3/cMHTJSpgI+zu3QSxPtvjD4+qxok7t
         ia7Lv2Zu81A01mzFbfauTXyNYhnJEZaa6fWWlnsqnX6F6N8EoJDPE8PQ3//pHRngz7
         fsFyIgsNi8zd+j05EMVB2t0y50F+Ya0suL9r6ERiYptt+tVsYgihgA70O7CNfw7Xmp
         s5QkyUQGFNw3BVK3hiozx5ObbawbuSQEcV9We0bpQlzRbmvLChhA2MLTx/x8GZbezT
         LnyINsFPNNzwxUEq2lW6tVM40jWnK2V4Pf1h7p9KU+5JAcHOHWg2OG3dvD51WmBoID
         sqnuxUDBq/jJA==
Date:   Thu, 27 Jan 2022 15:36:39 +0200
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
Subject: Re: [PATCH 1/6] mm, memory_hotplug: make arch_alloc_nodedata
 independent on CONFIG_MEMORY_HOTPLUG
Message-ID: <YfKf57Mz6cwaVMTb@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127085305.20890-2-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 09:53:00AM +0100, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> This is a preparatory patch and it doesn't introduce any functional
> change. It merely pulls out arch_alloc_nodedata (and co) outside of
> CONFIG_MEMORY_HOTPLUG because the following patch will need to call this
> from the generic MM code.
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/ia64/mm/discontig.c       |   2 -
>  include/linux/memory_hotplug.h | 119 ++++++++++++++++-----------------
>  2 files changed, 59 insertions(+), 62 deletions(-)
> 
> diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
> index 791d4176e4a6..8dc8a554f774 100644
> --- a/arch/ia64/mm/discontig.c
> +++ b/arch/ia64/mm/discontig.c
> @@ -608,7 +608,6 @@ void __init paging_init(void)
>  	zero_page_memmap_ptr = virt_to_page(ia64_imva(empty_zero_page));
>  }
>  
> -#ifdef CONFIG_MEMORY_HOTPLUG
>  pg_data_t *arch_alloc_nodedata(int nid)
>  {
>  	unsigned long size = compute_pernodesize(nid);
> @@ -626,7 +625,6 @@ void arch_refresh_nodedata(int update_node, pg_data_t *update_pgdat)
>  	pgdat_list[update_node] = update_pgdat;
>  	scatter_node_data();
>  }
> -#endif
>  
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index be48e003a518..4355983b364d 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -16,6 +16,65 @@ struct memory_group;
>  struct resource;
>  struct vmem_altmap;
>  
> +#ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
> +/*
> + * For supporting node-hotadd, we have to allocate a new pgdat.
> + *
> + * If an arch has generic style NODE_DATA(),
> + * node_data[nid] = kzalloc() works well. But it depends on the architecture.
> + *
> + * In general, generic_alloc_nodedata() is used.
> + * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
> + *
> + */
> +extern pg_data_t *arch_alloc_nodedata(int nid);
> +extern void arch_free_nodedata(pg_data_t *pgdat);
> +extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
> +
> +#else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
> +
> +#define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
> +#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
> +
> +#ifdef CONFIG_NUMA
> +/*
> + * XXX: node aware allocation can't work well to get new node's memory at this time.
> + *	Because, pgdat for the new node is not allocated/initialized yet itself.
> + *	To use new node's memory, more consideration will be necessary.
> + */
> +#define generic_alloc_nodedata(nid)				\
> +({								\
> +	kzalloc(sizeof(pg_data_t), GFP_KERNEL);			\
> +})
> +/*
> + * This definition is just for error path in node hotadd.
> + * For node hotremove, we have to replace this.
> + */
> +#define generic_free_nodedata(pgdat)	kfree(pgdat)
> +
> +extern pg_data_t *node_data[];
> +static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
> +{
> +	node_data[nid] = pgdat;
> +}
> +
> +#else /* !CONFIG_NUMA */
> +
> +/* never called */
> +static inline pg_data_t *generic_alloc_nodedata(int nid)
> +{
> +	BUG();
> +	return NULL;
> +}
> +static inline void generic_free_nodedata(pg_data_t *pgdat)
> +{
> +}
> +static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
> +{
> +}
> +#endif /* CONFIG_NUMA */
> +#endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
> +
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  struct page *pfn_to_online_page(unsigned long pfn);
>  
> @@ -154,66 +213,6 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
>  	      struct mhp_params *params);
>  #endif /* ARCH_HAS_ADD_PAGES */
>  
> -#ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
> -/*
> - * For supporting node-hotadd, we have to allocate a new pgdat.
> - *
> - * If an arch has generic style NODE_DATA(),
> - * node_data[nid] = kzalloc() works well. But it depends on the architecture.
> - *
> - * In general, generic_alloc_nodedata() is used.
> - * Now, arch_free_nodedata() is just defined for error path of node_hot_add.
> - *
> - */
> -extern pg_data_t *arch_alloc_nodedata(int nid);
> -extern void arch_free_nodedata(pg_data_t *pgdat);
> -extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
> -
> -#else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
> -
> -#define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
> -#define arch_free_nodedata(pgdat)	generic_free_nodedata(pgdat)
> -
> -#ifdef CONFIG_NUMA
> -/*
> - * If ARCH_HAS_NODEDATA_EXTENSION=n, this func is used to allocate pgdat.
> - * XXX: kmalloc_node() can't work well to get new node's memory at this time.
> - *	Because, pgdat for the new node is not allocated/initialized yet itself.
> - *	To use new node's memory, more consideration will be necessary.
> - */
> -#define generic_alloc_nodedata(nid)				\
> -({								\
> -	kzalloc(sizeof(pg_data_t), GFP_KERNEL);			\
> -})
> -/*
> - * This definition is just for error path in node hotadd.
> - * For node hotremove, we have to replace this.
> - */
> -#define generic_free_nodedata(pgdat)	kfree(pgdat)
> -
> -extern pg_data_t *node_data[];
> -static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
> -{
> -	node_data[nid] = pgdat;
> -}
> -
> -#else /* !CONFIG_NUMA */
> -
> -/* never called */
> -static inline pg_data_t *generic_alloc_nodedata(int nid)
> -{
> -	BUG();
> -	return NULL;
> -}
> -static inline void generic_free_nodedata(pg_data_t *pgdat)
> -{
> -}
> -static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
> -{
> -}
> -#endif /* CONFIG_NUMA */
> -#endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
> -
>  void get_online_mems(void);
>  void put_online_mems(void);
>  
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
