Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C653B468
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiFBHgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiFBHgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:36:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4BC39693
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654155361; x=1685691361;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v46WxlsCDsQ8VAXwsfcPYJg8T8hnNOd8v8EYOGIZfLs=;
  b=j/sap8kaL0a5SZ0lkbmFZStxSTf6PXJaZQShyTKZ0P8DU6D1gtBFHJr/
   9orI33TWM6/CouKTnBFWdpB+Tb07LDazgwf9PQG3rA9puQLlFB4doS78j
   1ygdSEzunPjU3gJquTygceOHFi9i/OsADewOeyu6ksh9hzJU4eSukLYUu
   E8F/EfykwDQ3nbl8JMZeYF5KhXxFTlQnd1Jb2iOvLLDYR+JadNwyInaz3
   lJtOtTGr3FfkRsqPS4rNOW759xAsmq+3UtiO4I979AhcFAnBAsqjyWCT7
   TSQUoBI9LjtO/iHZ7PvAZJoA+fYeNegNGanMCs9idjNuwmDxnLyL4pBYi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="257928889"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="257928889"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 00:35:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="563184702"
Received: from yanqingl-mobl1.ccr.corp.intel.com ([10.254.212.10])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 00:35:54 -0700
Message-ID: <b102d5773bffd6391283773044f756e810c1f044.camel@intel.com>
Subject: Re: [RFC PATCH v4 7/7] mm/demotion: Demote pages according to
 allocation fallback order
From:   Ying Huang <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Greg Thelen <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Thu, 02 Jun 2022 15:35:51 +0800
In-Reply-To: <20220527122528.129445-8-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
         <20220527122528.129445-8-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 17:55 +0530, Aneesh Kumar K.V wrote:
> From: Jagdish Gediya <jvgediya@linux.ibm.com>
> 
> currently, a higher tier node can only be demoted to selected
> nodes on the next lower tier as defined by the demotion path,
> not any other node from any lower tier.  This strict, hard-coded
> demotion order does not work in all use cases (e.g. some use cases
> may want to allow cross-socket demotion to another node in the same
> demotion tier as a fallback when the preferred demotion node is out
> of space). This demotion order is also inconsistent with the page
> allocation fallback order when all the nodes in a higher tier are
> out of space: The page allocation can fall back to any node from any
> lower tier, whereas the demotion order doesn't allow that currently.
> 
> This patch adds support to get all the allowed demotion targets mask
> for node, also demote_page_list() function is modified to utilize this
> allowed node mask by filling it in migration_target_control structure
> before passing it to migrate_pages().
> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/migrate.h |  5 ++++
>  mm/migrate.c            | 52 +++++++++++++++++++++++++++++++++++++----
>  mm/vmscan.c             | 38 ++++++++++++++----------------
>  3 files changed, 71 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 77c581f47953..1f3cbd5185ca 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -182,6 +182,7 @@ void node_remove_from_memory_tier(int node);
>  int node_get_memory_tier_id(int node);
>  int node_set_memory_tier_rank(int node, int tier);
>  int node_reset_memory_tier(int node, int tier);
> +void node_get_allowed_targets(int node, nodemask_t *targets);
>  #else
>  #define numa_demotion_enabled	false
>  static inline int next_demotion_node(int node)
> @@ -189,6 +190,10 @@ static inline int next_demotion_node(int node)
>  	return NUMA_NO_NODE;
>  }
>  
> 
> 
> 
> +static inline void node_get_allowed_targets(int node, nodemask_t *targets)
> +{
> +	*targets = NODE_MASK_NONE;
> +}
>  #endif	/* CONFIG_TIERED_MEMORY */
>  
> 
> 
> 
>  #endif /* _LINUX_MIGRATE_H */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 114c7428b9f3..84fac477538c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2129,6 +2129,7 @@ struct memory_tier {
>  
> 
> 
> 
>  struct demotion_nodes {
>  	nodemask_t preferred;
> +	nodemask_t allowed;
>  };
>  
> 
> 
> 
>  #define to_memory_tier(device) container_of(device, struct memory_tier, dev)
> @@ -2475,6 +2476,25 @@ int node_set_memory_tier_rank(int node, int rank)
>  }
>  EXPORT_SYMBOL_GPL(node_set_memory_tier_rank);
>  
> 
> 
> 
> +void node_get_allowed_targets(int node, nodemask_t *targets)
> +{
> +	/*
> +	 * node_demotion[] is updated without excluding this
> +	 * function from running.
> +	 *
> +	 * If any node is moving to lower tiers then modifications
> +	 * in node_demotion[] are still valid for this node, if any
> +	 * node is moving to higher tier then moving node may be
> +	 * used once for demotion which should be ok so rcu should
> +	 * be enough here.
> +	 */
> +	rcu_read_lock();
> +
> +	*targets = node_demotion[node].allowed;
> +
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * next_demotion_node() - Get the next node in the demotion path
>   * @node: The starting node to lookup the next node
> @@ -2534,8 +2554,10 @@ static void __disable_all_migrate_targets(void)
>  {
>  	int node;
>  
> 
> 
> 
> -	for_each_node_mask(node, node_states[N_MEMORY])
> +	for_each_node_mask(node, node_states[N_MEMORY]) {
>  		node_demotion[node].preferred = NODE_MASK_NONE;
> +		node_demotion[node].allowed = NODE_MASK_NONE;
> +	}
>  }
>  
> 
> 
> 
>  static void disable_all_migrate_targets(void)
> @@ -2558,12 +2580,11 @@ static void disable_all_migrate_targets(void)
>  */
>  static void establish_migration_targets(void)
>  {
> -	struct list_head *ent;
>  	struct memory_tier *memtier;
>  	struct demotion_nodes *nd;
> -	int tier, target = NUMA_NO_NODE, node;
> +	int target = NUMA_NO_NODE, node;
>  	int distance, best_distance;
> -	nodemask_t used;
> +	nodemask_t used, allowed = NODE_MASK_NONE;
>  
> 
> 
> 
>  	if (!node_demotion)
>  		return;
> @@ -2603,6 +2624,29 @@ static void establish_migration_targets(void)
>  			}
>  		} while (1);
>  	}
> +	/*
> +	 * Now build the allowed mask for each node collecting node mask from
> +	 * all memory tier below it. This allows us to fallback demotion page
> +	 * allocation to a set of nodes that is closer the above selected
> +	 * perferred node.
> +	 */
> +	list_for_each_entry(memtier, &memory_tiers, list)
> +		nodes_or(allowed, allowed, memtier->nodelist);
> +	/*
> +	 * Removes nodes not yet in N_MEMORY.
> +	 */
> +	nodes_and(allowed, node_states[N_MEMORY], allowed);
> +
> +	list_for_each_entry(memtier, &memory_tiers, list) {
> +		/*
> +		 * Keep removing current tier from allowed nodes,
> +		 * This will remove all nodes in current and above
> +		 * memory tier from the allowed mask.
> +		 */
> +		nodes_andnot(allowed, allowed, memtier->nodelist);
> +		for_each_node_mask(node, memtier->nodelist)
> +			node_demotion[node].allowed = allowed;
> +	}
>  }
>  
> 
> 
> 
>  /*
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1678802e03e7..feb994589481 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1454,23 +1454,6 @@ static void folio_check_dirty_writeback(struct folio *folio,
>  		mapping->a_ops->is_dirty_writeback(&folio->page, dirty, writeback);
>  }
>  
> 
> 
> 
> -static struct page *alloc_demote_page(struct page *page, unsigned long node)
> -{
> -	struct migration_target_control mtc = {
> -		/*
> -		 * Allocate from 'node', or fail quickly and quietly.
> -		 * When this happens, 'page' will likely just be discarded
> -		 * instead of migrated.
> -		 */
> -		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> -			    __GFP_THISNODE  | __GFP_NOWARN |
> -			    __GFP_NOMEMALLOC | GFP_NOWAIT,
> -		.nid = node
> -	};
> -
> -	return alloc_migration_target(page, (unsigned long)&mtc);
> -}
> -
>  /*
>   * Take pages on @demote_list and attempt to demote them to
>   * another node.  Pages which are not demoted are left on
> @@ -1481,6 +1464,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>  {
>  	int target_nid = next_demotion_node(pgdat->node_id);
>  	unsigned int nr_succeeded;
> +	nodemask_t allowed_mask;
> +
> +	struct migration_target_control mtc = {
> +		/*
> +		 * Allocate from 'node', or fail quickly and quietly.
> +		 * When this happens, 'page' will likely just be discarded
> +		 * instead of migrated.
> +		 */
> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> +			__GFP_NOMEMALLOC | GFP_NOWAIT,
> +		.nid = target_nid,
> +		.nmask = &allowed_mask
> +	};

IMHO, we should try to allocate from preferred node firstly (which will
kick kswapd of the preferred node if necessary).  If failed, we will
fallback to all allowed node.

As we discussed as follows,

https://lore.kernel.org/lkml/69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com/

That is, something like below,

static struct page *alloc_demote_page(struct page *page, unsigned long node)
{
	struct page *page;
	nodemask_t allowed_mask;
	struct migration_target_control mtc = {
		/*
		 * Allocate from 'node', or fail quickly and quietly.
		 * When this happens, 'page' will likely just be discarded
		 * instead of migrated.
		 */
		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
			    __GFP_THISNODE  | __GFP_NOWARN |
			    __GFP_NOMEMALLOC | GFP_NOWAIT,
		.nid = node
	};

	page = alloc_migration_target(page, (unsigned long)&mtc);
	if (page)
		return page;

	mtc.gfp_mask &= ~__GFP_THISNODE;
	mtc.nmask = &allowed_mask;

	return alloc_migration_target(page, (unsigned long)&mtc);
}

Best Regards,
Huang, Ying

>  	if (list_empty(demote_pages))
>  		return 0;
> @@ -1488,10 +1484,12 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>  	if (target_nid == NUMA_NO_NODE)
>  		return 0;
>  
> 
> 
> 
> +	node_get_allowed_targets(pgdat->node_id, &allowed_mask);
> +
>  	/* Demotion ignores all cpuset and mempolicy settings */
> -	migrate_pages(demote_pages, alloc_demote_page, NULL,
> -			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> -			    &nr_succeeded);
> +	migrate_pages(demote_pages, alloc_migration_target, NULL,
> +		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
> +		      &nr_succeeded);
>  
> 
> 
> 
>  	if (current_is_kswapd())
>  		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);


