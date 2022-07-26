Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBC580ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiGZIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiGZIZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:25:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF90C2F649
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658823905; x=1690359905;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=784n/SI9L6ANiaY4/7ScEbcl+/Ri38FzHCeLcV2dg/M=;
  b=Vvlm84wx5Rnm/Dl6vS9SskZplOnciKl91dMa0n/zoHXyN6On/mn4BIfG
   tlKhnuJOxtrODNe1Zh5InMbkEBkCyw6hpGsqdrA/N+a3x3uiFhUpEOWwP
   CJYP7mAgHTHi3zNyxv8ic4y8Bz33mPQPLMKF+jXFZcYZ/Xc9vQDwpBv1/
   l4OWJ3c3KPU6+ZPmmyWCPRbFbmO0a0j0Z86lu9t6zClKJgCugllB6gJNr
   mAduCvsgC/a26DnxkNDbdvXJ08Sd9h/cT+Pmun1gCVsHi9T1+Y0aEMh55
   A8lEot/8ZKTaLEOOaGumXT9/pA5HGTDmtKBbDqUys2RJmDwgUnz4zqKWx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="274762752"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="274762752"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 01:25:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="632669332"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 01:24:58 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: Re: [PATCH v10 7/8] mm/demotion: Demote pages according to
 allocation fallback order
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-8-aneesh.kumar@linux.ibm.com>
Date:   Tue, 26 Jul 2022 16:24:54 +0800
In-Reply-To: <20220720025920.1373558-8-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Wed, 20 Jul 2022 08:29:19 +0530")
Message-ID: <87sfmouvqh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> From: Jagdish Gediya <jvgediya.oss@gmail.com>
>
> Currently, a higher tier node can only be demoted to selected
> nodes on the next lower tier as defined by the demotion path.
> This strict, hard-coded demotion order does not work in all
> use cases (e.g. some use cases may want to allow cross-socket
> demotion to another node in the same demotion tier as a fallback
> when the preferred demotion node is out of space). This demotion
> order is also inconsistent with the page allocation fallback order
> when all the nodes in a higher tier are out of space: The page
> allocation can fall back to any node from any lower tier, whereas
> the demotion order doesn't allow that currently.
>
> This patch adds support to get all the allowed demotion targets
> for a memory tier. demote_page_list() function is now modified
> to utilize this allowed node mask as the fallback allocation mask.
>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h | 11 +++++++
>  mm/memory-tiers.c            | 54 +++++++++++++++++++++++++++++++--
>  mm/vmscan.c                  | 58 ++++++++++++++++++++++++++----------
>  3 files changed, 106 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 852e86bd0a23..0e58588fa066 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -19,11 +19,17 @@
>  extern bool numa_demotion_enabled;
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
> +void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>  #else
>  static inline int next_demotion_node(int node)
>  {
>  	return NUMA_NO_NODE;
>  }
> +
> +static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
> +{
> +	*targets = NODE_MASK_NONE;
> +}
>  #endif
>  
>  #else
> @@ -33,5 +39,10 @@ static inline int next_demotion_node(int node)
>  {
>  	return NUMA_NO_NODE;
>  }
> +
> +static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
> +{
> +	*targets = NODE_MASK_NONE;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 4715f9b96a44..4a96e4213d66 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -15,6 +15,7 @@ struct memory_tier {
>  	struct list_head list;
>  	int perf_level;
>  	nodemask_t nodelist;
> +	nodemask_t lower_tier_mask;
>  };
>  
>  struct demotion_nodes {
> @@ -153,6 +154,24 @@ static struct memory_tier *__node_get_memory_tier(int node)
>  }
>  
>  #ifdef CONFIG_MIGRATION
> +void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
> +{
> +	struct memory_tier *memtier;
> +
> +	/*
> +	 * pg_data_t.memtier updates includes a synchronize_rcu()
> +	 * which ensures that we either find NULL or a valid memtier
> +	 * in NODE_DATA. protect the access via rcu_read_lock();
> +	 */
> +	rcu_read_lock();
> +	memtier = rcu_dereference(pgdat->memtier);
> +	if (memtier)
> +		*targets = memtier->lower_tier_mask;
> +	else
> +		*targets = NODE_MASK_NONE;
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * next_demotion_node() - Get the next node in the demotion path
>   * @node: The starting node to lookup the next node
> @@ -201,10 +220,19 @@ int next_demotion_node(int node)
>  /* Disable reclaim-based migration. */
>  static void __disable_all_migrate_targets(void)
>  {
> +	struct memory_tier *memtier;
>  	int node;
>  
> -	for_each_node_state(node, N_MEMORY)
> +	for_each_node_state(node, N_MEMORY) {
>  		node_demotion[node].preferred = NODE_MASK_NONE;
> +		/*
> +		 * We are holding memory_tier_lock, it is safe
> +		 * to access pgda->memtier.
> +		 */
> +		memtier = rcu_dereference_check(NODE_DATA(node)->memtier,
> +						lockdep_is_held(&memory_tier_lock));
> +		memtier->lower_tier_mask = NODE_MASK_NONE;
> +	}
>  }
>  
>  static void disable_all_migrate_targets(void)
> @@ -230,7 +258,7 @@ static void establish_migration_targets(void)
>  	struct demotion_nodes *nd;
>  	int target = NUMA_NO_NODE, node;
>  	int distance, best_distance;
> -	nodemask_t used;
> +	nodemask_t used, lower_tier = NODE_MASK_NONE;
>  
>  	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))
>  		return;
> @@ -276,6 +304,28 @@ static void establish_migration_targets(void)
>  			}
>  		} while (1);
>  	}
> +	/*
> +	 * Now build the lower_tier mask for each node collecting node mask from
> +	 * all memory tier below it. This allows us to fallback demotion page
> +	 * allocation to a set of nodes that is closer the above selected
> +	 * perferred node.
> +	 */
> +	list_for_each_entry(memtier, &memory_tiers, list)
> +		nodes_or(lower_tier, lower_tier, memtier->nodelist);
> +	/*
> +	 * Removes nodes not yet in N_MEMORY.
> +	 */
> +	nodes_and(lower_tier, node_states[N_MEMORY], lower_tier);

The above code is equivalent with

        lower_tier = node_states[N_MEMORY];

?

> +
> +	list_for_each_entry(memtier, &memory_tiers, list) {
> +		/*
> +		 * Keep removing current tier from lower_tier nodes,
> +		 * This will remove all nodes in current and above
> +		 * memory tier from the lower_tier mask.
> +		 */
> +		nodes_andnot(lower_tier, lower_tier, memtier->nodelist);
> +		memtier->lower_tier_mask = lower_tier;
> +	}

This is per-memtier instead of per-node.  So we need not run this code
for each node?  That is, move the above code out of for_each_node()
loop?

Best Regards,
Huang, Ying

>  }
>  #else
>  static inline void disable_all_migrate_targets(void) {}
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 3a8f78277f99..60a5235dd639 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1460,21 +1460,34 @@ static void folio_check_dirty_writeback(struct folio *folio,
>  		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
>  }
>  
> -static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +static struct page *alloc_demote_page(struct page *page, unsigned long private)
>  {
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
> +	struct page *target_page;
> +	nodemask_t *allowed_mask;
> +	struct migration_target_control *mtc;
> +
> +	mtc = (struct migration_target_control *)private;
> +
> +	allowed_mask = mtc->nmask;
> +	/*
> +	 * make sure we allocate from the target node first also trying to
> +	 * reclaim pages from the target node via kswapd if we are low on
           ~~~~~~~

demote or reclaim

> +	 * free memory on target node. If we don't do this and if we have low
                                                           ~~~~~~~~~~~~~~~~~~
> +	 * free memory on the target memtier, we would start allocating pages
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

and if we have free memory on the slower(lower) memtier,

> +	 * from higher memory tiers without even forcing a demotion of cold
                ~~~~~~

slower(lower)

> +	 * pages from the target memtier. This can result in the kernel placing
                                 ~~~~~~~

node

> +	 * hotpages in higher memory tiers.
           ~~~~~~~~    ~~~~~~

hot pages

slower(lower)

Best Regards,
Huang, Ying

> +	 */
> +	mtc->nmask = NULL;
> +	mtc->gfp_mask |= __GFP_THISNODE;
> +	target_page = alloc_migration_target(page, (unsigned long)mtc);
> +	if (target_page)
> +		return target_page;
>  
> -	return alloc_migration_target(page, (unsigned long)&mtc);
> +	mtc->gfp_mask &= ~__GFP_THISNODE;
> +	mtc->nmask = allowed_mask;
> +
> +	return alloc_migration_target(page, (unsigned long)mtc);
>  }
>  
>  /*
> @@ -1487,6 +1500,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>  {
>  	int target_nid = next_demotion_node(pgdat->node_id);
>  	unsigned int nr_succeeded;
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
>  
>  	if (list_empty(demote_pages))
>  		return 0;
> @@ -1494,10 +1520,12 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
>  	if (target_nid == NUMA_NO_NODE)
>  		return 0;
>  
> +	node_get_allowed_targets(pgdat, &allowed_mask);
> +
>  	/* Demotion ignores all cpuset and mempolicy settings */
>  	migrate_pages(demote_pages, alloc_demote_page, NULL,
> -			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
> -			    &nr_succeeded);
> +		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
> +		      &nr_succeeded);
>  
>  	if (current_is_kswapd())
>  		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
