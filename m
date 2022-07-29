Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68BD584C12
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiG2GgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiG2GgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:36:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C196C80480
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659076559; x=1690612559;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=JhXDcVbuvz5m4uJbr8UTNujOosjRIVAQtJ4tR2nmxdc=;
  b=lkmR6sQMEUKtdKSxRCfnd1H3PIEE4VjKhY5fy4Kr9HWvYr4rX6Vs5nd9
   7WgF4S0LnkDAOm+i5UDnLHyUZ5nDwJN9a1t1BzOLBjCdg4Ge1fQb/Rm9Z
   GJGqL4dJe7FXnJDzc+GX3OEH8Al1gqCeRro98y5g+ECBj59xRe+QuQXtM
   klCPNQrKweM9/BWt3I86i9argvl7kY8qkg9HXoPktk6B7qmsN4pdA8pEj
   nt8UX7dYoXr1+Va+glITlw0wgJ3CWtmICdIQoohKOFM604dxAkJu7Hlzb
   rG9FH3KMjb77KrM8dnr8+AyfTyx2pRuSZHEaCPQGZJOzi6rYR/4xZGz9A
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289474600"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="289474600"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:35:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="scan'208";a="576834149"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 23:35:55 -0700
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v11 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
        <20220728190436.858458-6-aneesh.kumar@linux.ibm.com>
Date:   Fri, 29 Jul 2022 14:35:51 +0800
In-Reply-To: <20220728190436.858458-6-aneesh.kumar@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 29 Jul 2022 00:34:33 +0530")
Message-ID: <87wnbwl92w.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> This patch switch the demotion target building logic to use memory tiers
> instead of NUMA distance. All N_MEMORY NUMA nodes will be placed in the
> default memory tier and additional memory tiers will be added by drivers like
> dax kmem.
>
> This patch builds the demotion target for a NUMA node by looking at all
> memory tiers below the tier to which the NUMA node belongs. The closest node
> in the immediately following memory tier is used as a demotion target.
>
> Since we are now only building demotion target for N_MEMORY NUMA nodes
> the CPU hotplug calls are removed in this patch.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h |  13 ++
>  include/linux/migrate.h      |  13 --
>  mm/memory-tiers.c            | 221 +++++++++++++++++++-
>  mm/migrate.c                 | 394 -----------------------------------
>  mm/vmstat.c                  |   4 -
>  5 files changed, 233 insertions(+), 412 deletions(-)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 4f4baf0bf430..e56a57c6ef78 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -31,6 +31,14 @@ struct memory_dev_type {
>  #ifdef CONFIG_NUMA
>  extern bool numa_demotion_enabled;
>  struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *default_type);
> +#ifdef CONFIG_MIGRATION
> +int next_demotion_node(int node);
> +#else
> +static inline int next_demotion_node(int node)
> +{
> +	return NUMA_NO_NODE;
> +}
> +#endif
>  
>  #else
>  
> @@ -39,5 +47,10 @@ static inline struct memory_dev_type *init_node_memory_type(int node, struct mem
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> +
> +static inline int next_demotion_node(int node)
> +{
> +	return NUMA_NO_NODE;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 43e737215f33..93fab62e6548 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -75,19 +75,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>  
>  #endif /* CONFIG_MIGRATION */
>  
> -#if defined(CONFIG_MIGRATION) && defined(CONFIG_NUMA)
> -extern void set_migration_target_nodes(void);
> -extern void migrate_on_reclaim_init(void);
> -extern int next_demotion_node(int node);
> -#else
> -static inline void set_migration_target_nodes(void) {}
> -static inline void migrate_on_reclaim_init(void) {}
> -static inline int next_demotion_node(int node)
> -{
> -        return NUMA_NO_NODE;
> -}
> -#endif
> -
>  #ifdef CONFIG_COMPACTION
>  extern int PageMovable(struct page *page);
>  extern void __SetPageMovable(struct page *page, struct address_space *mapping);
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 109be75fa554..60845aa74afc 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -2,8 +2,11 @@
>  #include <linux/slab.h>
>  #include <linux/lockdep.h>
>  #include <linux/memory.h>
> +#include <linux/random.h>
>  #include <linux/memory-tiers.h>
>  
> +#include "internal.h"
> +
>  struct memory_tier {
>  	/* hierarchy of memory tiers */
>  	struct list_head list;
> @@ -17,9 +20,74 @@ struct memory_tier {
>  	int adistance_start;
>  };
>  
> +struct demotion_nodes {
> +	nodemask_t preferred;
> +};
> +
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
>  struct memory_dev_type *node_memory_types[MAX_NUMNODES];
> +#ifdef CONFIG_MIGRATION
> +/*
> + * node_demotion[] examples:
> + *
> + * Example 1:
> + *
> + * Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM nodes.
> + *
> + * node distances:
> + * node   0    1    2    3
> + *    0  10   20   30   40
> + *    1  20   10   40   30
> + *    2  30   40   10   40
> + *    3  40   30   40   10
> + *
> + * memory_tiers0 = 0-1
> + * memory_tiers1 = 2-3
> + *
> + * node_demotion[0].preferred = 2
> + * node_demotion[1].preferred = 3
> + * node_demotion[2].preferred = <empty>
> + * node_demotion[3].preferred = <empty>
> + *
> + * Example 2:
> + *
> + * Node 0 & 1 are CPU + DRAM nodes, node 2 is memory-only DRAM node.
> + *
> + * node distances:
> + * node   0    1    2
> + *    0  10   20   30
> + *    1  20   10   30
> + *    2  30   30   10
> + *
> + * memory_tiers0 = 0-2
> + *
> + * node_demotion[0].preferred = <empty>
> + * node_demotion[1].preferred = <empty>
> + * node_demotion[2].preferred = <empty>
> + *
> + * Example 3:
> + *
> + * Node 0 is CPU + DRAM nodes, Node 1 is HBM node, node 2 is PMEM node.
> + *
> + * node distances:
> + * node   0    1    2
> + *    0  10   20   30
> + *    1  20   10   40
> + *    2  30   40   10
> + *
> + * memory_tiers0 = 1
> + * memory_tiers1 = 0
> + * memory_tiers2 = 2
> + *
> + * node_demotion[0].preferred = 2
> + * node_demotion[1].preferred = 0
> + * node_demotion[2].preferred = <empty>
> + *
> + */
> +static struct demotion_nodes *node_demotion __read_mostly;
> +#endif /* CONFIG_MIGRATION */
> +
>  /*
>   * For now let's have 4 memory tier below default DRAM tier.
>   */
> @@ -82,6 +150,144 @@ static struct memory_tier *__node_get_memory_tier(int node)
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_MIGRATION
> +/**
> + * next_demotion_node() - Get the next node in the demotion path
> + * @node: The starting node to lookup the next node
> + *
> + * Return: node id for next memory node in the demotion path hierarchy
> + * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
> + * @node online or guarantee that it *continues* to be the next demotion
> + * target.
> + */
> +int next_demotion_node(int node)
> +{
> +	struct demotion_nodes *nd;
> +	int target;
> +
> +	if (!node_demotion)
> +		return NUMA_NO_NODE;
> +
> +	nd = &node_demotion[node];
> +
> +	/*
> +	 * node_demotion[] is updated without excluding this
> +	 * function from running.
> +	 *
> +	 * Make sure to use RCU over entire code blocks if
> +	 * node_demotion[] reads need to be consistent.
> +	 */
> +	rcu_read_lock();
> +	/*
> +	 * If there are multiple target nodes, just select one
> +	 * target node randomly.
> +	 *
> +	 * In addition, we can also use round-robin to select
> +	 * target node, but we should introduce another variable
> +	 * for node_demotion[] to record last selected target node,
> +	 * that may cause cache ping-pong due to the changing of
> +	 * last target node. Or introducing per-cpu data to avoid
> +	 * caching issue, which seems more complicated. So selecting
> +	 * target node randomly seems better until now.
> +	 */
> +	target = node_random(&nd->preferred);

Don't find code to optimize node_random() for weight == 1 case, forget
to do that?

Best Regards,
Huang, Ying

> +	rcu_read_unlock();
> +
> +	return target;
> +}
> +
> +static void disable_all_demotion_targets(void)
> +{
> +	int node;
> +
> +	for_each_node_state(node, N_MEMORY)
> +		node_demotion[node].preferred = NODE_MASK_NONE;
> +	/*
> +	 * Ensure that the "disable" is visible across the system.
> +	 * Readers will see either a combination of before+disable
> +	 * state or disable+after.  They will never see before and
> +	 * after state together.
> +	 */
> +	synchronize_rcu();
> +}
> +
> +static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
> +{
> +	nodemask_t nodes = NODE_MASK_NONE;
> +	struct memory_dev_type *memtype;
> +
> +	list_for_each_entry(memtype, &memtier->memory_types, tier_sibiling)
> +		nodes_or(nodes, nodes, memtype->nodes);
> +
> +	return nodes;
> +}
> +
> +/*
> + * Find an automatic demotion target for all memory
> + * nodes. Failing here is OK.  It might just indicate
> + * being at the end of a chain.
> + */
> +static void establish_demotion_targets(void)
> +{
> +	struct memory_tier *memtier;
> +	struct demotion_nodes *nd;
> +	int target = NUMA_NO_NODE, node;
> +	int distance, best_distance;
> +	nodemask_t tier_nodes;
> +
> +	lockdep_assert_held_once(&memory_tier_lock);
> +
> +	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))
> +		return;
> +
> +	disable_all_demotion_targets();
> +
> +	for_each_node_state(node, N_MEMORY) {
> +		best_distance = -1;
> +		nd = &node_demotion[node];
> +
> +		memtier = __node_get_memory_tier(node);
> +		if (!memtier || list_is_first(&memtier->list, &memory_tiers))
> +			continue;
> +		/*
> +		 * Get the lower memtier to find the  demotion node list.
> +		 */
> +		memtier = list_prev_entry(memtier, list);
> +		tier_nodes = get_memtier_nodemask(memtier);
> +		/*
> +		 * find_next_best_node, use 'used' nodemask as a skip list.
> +		 * Add all memory nodes except the selected memory tier
> +		 * nodelist to skip list so that we find the best node from the
> +		 * memtier nodelist.
> +		 */
> +		nodes_andnot(tier_nodes, node_states[N_MEMORY], tier_nodes);
> +
> +		/*
> +		 * Find all the nodes in the memory tier node list of same best distance.
> +		 * add them to the preferred mask. We randomly select between nodes
> +		 * in the preferred mask when allocating pages during demotion.
> +		 */
> +		do {
> +			target = find_next_best_node(node, &tier_nodes);
> +			if (target == NUMA_NO_NODE)
> +				break;
> +
> +			distance = node_distance(node, target);
> +			if (distance == best_distance || best_distance == -1) {
> +				best_distance = distance;
> +				node_set(target, nd->preferred);
> +			} else {
> +				break;
> +			}
> +		} while (1);
> +	}
> +}
> +
> +#else
> +static inline void disable_all_demotion_targets(void) {}
> +static inline void establish_demotion_targets(void) {}
> +#endif /* CONFIG_MIGRATION */
> +
>  static void init_node_memory_tier(int node)
>  {
>  	struct memory_tier *memtier;
> @@ -89,6 +295,13 @@ static void init_node_memory_tier(int node)
>  	mutex_lock(&memory_tier_lock);
>  
>  	memtier = __node_get_memory_tier(node);
> +	/*
> +	 * if node is already part of the tier proceed with the
> +	 * current tier value, because we might want to establish
> +	 * new migration paths now. The node might be added to a tier
> +	 * before it was made part of N_MEMORY, hence estabilish_demotion_targets
> +	 * will have skipped this node.
> +	 */
>  	if (!memtier) {
>  		struct memory_dev_type *memtype;
>  
> @@ -99,6 +312,7 @@ static void init_node_memory_tier(int node)
>  		memtype = node_memory_types[node];
>  		memtier = find_create_memory_tier(memtype);
>  	}
> +	establish_demotion_targets();
>  	mutex_unlock(&memory_tier_lock);
>  }
>  
> @@ -125,6 +339,7 @@ static void clear_node_memory_tier(int node)
>  			if (list_empty(&current_memtier->memory_types))
>  				destroy_memory_tier(current_memtier);
>  		}
> +		establish_demotion_targets();
>  	}
>  	mutex_unlock(&memory_tier_lock);
>  }
> @@ -182,7 +397,11 @@ static int __init memory_tier_init(void)
>  		panic("%s() failed to register memory tier: %ld\n",
>  		      __func__, PTR_ERR(memtier));
>  	mutex_unlock(&memory_tier_lock);
> -
> +#ifdef CONFIG_MIGRATION
> +	node_demotion = kcalloc(MAX_NUMNODES, sizeof(struct demotion_nodes),
> +				GFP_KERNEL);
> +	WARN_ON(!node_demotion);
> +#endif
>  	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRIO);
>  	return 0;
>  }
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fce7d4a9e940..c758c9c21d7d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2117,398 +2117,4 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  	return 0;
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
> -
> -/*
> - * node_demotion[] example:
> - *
> - * Consider a system with two sockets.  Each socket has
> - * three classes of memory attached: fast, medium and slow.
> - * Each memory class is placed in its own NUMA node.  The
> - * CPUs are placed in the node with the "fast" memory.  The
> - * 6 NUMA nodes (0-5) might be split among the sockets like
> - * this:
> - *
> - *	Socket A: 0, 1, 2
> - *	Socket B: 3, 4, 5
> - *
> - * When Node 0 fills up, its memory should be migrated to
> - * Node 1.  When Node 1 fills up, it should be migrated to
> - * Node 2.  The migration path start on the nodes with the
> - * processors (since allocations default to this node) and
> - * fast memory, progress through medium and end with the
> - * slow memory:
> - *
> - *	0 -> 1 -> 2 -> stop
> - *	3 -> 4 -> 5 -> stop
> - *
> - * This is represented in the node_demotion[] like this:
> - *
> - *	{  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
> - *	{  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
> - *	{  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
> - *	{  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
> - *	{  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
> - *	{  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
> - *
> - * Moreover some systems may have multiple slow memory nodes.
> - * Suppose a system has one socket with 3 memory nodes, node 0
> - * is fast memory type, and node 1/2 both are slow memory
> - * type, and the distance between fast memory node and slow
> - * memory node is same. So the migration path should be:
> - *
> - *	0 -> 1/2 -> stop
> - *
> - * This is represented in the node_demotion[] like this:
> - *	{ nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
> - *	{ nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
> - *	{ nr=0, nodes[0]=-1, }, // Node 2 does not migrate
> - */
> -
> -/*
> - * Writes to this array occur without locking.  Cycles are
> - * not allowed: Node X demotes to Y which demotes to X...
> - *
> - * If multiple reads are performed, a single rcu_read_lock()
> - * must be held over all reads to ensure that no cycles are
> - * observed.
> - */
> -#define DEFAULT_DEMOTION_TARGET_NODES 15
> -
> -#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
> -#define DEMOTION_TARGET_NODES	(MAX_NUMNODES - 1)
> -#else
> -#define DEMOTION_TARGET_NODES	DEFAULT_DEMOTION_TARGET_NODES
> -#endif
> -
> -struct demotion_nodes {
> -	unsigned short nr;
> -	short nodes[DEMOTION_TARGET_NODES];
> -};
> -
> -static struct demotion_nodes *node_demotion __read_mostly;
> -
> -/**
> - * next_demotion_node() - Get the next node in the demotion path
> - * @node: The starting node to lookup the next node
> - *
> - * Return: node id for next memory node in the demotion path hierarchy
> - * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
> - * @node online or guarantee that it *continues* to be the next demotion
> - * target.
> - */
> -int next_demotion_node(int node)
> -{
> -	struct demotion_nodes *nd;
> -	unsigned short target_nr, index;
> -	int target;
> -
> -	if (!node_demotion)
> -		return NUMA_NO_NODE;
> -
> -	nd = &node_demotion[node];
> -
> -	/*
> -	 * node_demotion[] is updated without excluding this
> -	 * function from running.  RCU doesn't provide any
> -	 * compiler barriers, so the READ_ONCE() is required
> -	 * to avoid compiler reordering or read merging.
> -	 *
> -	 * Make sure to use RCU over entire code blocks if
> -	 * node_demotion[] reads need to be consistent.
> -	 */
> -	rcu_read_lock();
> -	target_nr = READ_ONCE(nd->nr);
> -
> -	switch (target_nr) {
> -	case 0:
> -		target = NUMA_NO_NODE;
> -		goto out;
> -	case 1:
> -		index = 0;
> -		break;
> -	default:
> -		/*
> -		 * If there are multiple target nodes, just select one
> -		 * target node randomly.
> -		 *
> -		 * In addition, we can also use round-robin to select
> -		 * target node, but we should introduce another variable
> -		 * for node_demotion[] to record last selected target node,
> -		 * that may cause cache ping-pong due to the changing of
> -		 * last target node. Or introducing per-cpu data to avoid
> -		 * caching issue, which seems more complicated. So selecting
> -		 * target node randomly seems better until now.
> -		 */
> -		index = get_random_int() % target_nr;
> -		break;
> -	}
> -
> -	target = READ_ONCE(nd->nodes[index]);
> -
> -out:
> -	rcu_read_unlock();
> -	return target;
> -}
> -
> -/* Disable reclaim-based migration. */
> -static void __disable_all_migrate_targets(void)
> -{
> -	int node, i;
> -
> -	if (!node_demotion)
> -		return;
> -
> -	for_each_online_node(node) {
> -		node_demotion[node].nr = 0;
> -		for (i = 0; i < DEMOTION_TARGET_NODES; i++)
> -			node_demotion[node].nodes[i] = NUMA_NO_NODE;
> -	}
> -}
> -
> -static void disable_all_migrate_targets(void)
> -{
> -	__disable_all_migrate_targets();
> -
> -	/*
> -	 * Ensure that the "disable" is visible across the system.
> -	 * Readers will see either a combination of before+disable
> -	 * state or disable+after.  They will never see before and
> -	 * after state together.
> -	 *
> -	 * The before+after state together might have cycles and
> -	 * could cause readers to do things like loop until this
> -	 * function finishes.  This ensures they can only see a
> -	 * single "bad" read and would, for instance, only loop
> -	 * once.
> -	 */
> -	synchronize_rcu();
> -}
> -
> -/*
> - * Find an automatic demotion target for 'node'.
> - * Failing here is OK.  It might just indicate
> - * being at the end of a chain.
> - */
> -static int establish_migrate_target(int node, nodemask_t *used,
> -				    int best_distance)
> -{
> -	int migration_target, index, val;
> -	struct demotion_nodes *nd;
> -
> -	if (!node_demotion)
> -		return NUMA_NO_NODE;
> -
> -	nd = &node_demotion[node];
> -
> -	migration_target = find_next_best_node(node, used);
> -	if (migration_target == NUMA_NO_NODE)
> -		return NUMA_NO_NODE;
> -
> -	/*
> -	 * If the node has been set a migration target node before,
> -	 * which means it's the best distance between them. Still
> -	 * check if this node can be demoted to other target nodes
> -	 * if they have a same best distance.
> -	 */
> -	if (best_distance != -1) {
> -		val = node_distance(node, migration_target);
> -		if (val > best_distance)
> -			goto out_clear;
> -	}
> -
> -	index = nd->nr;
> -	if (WARN_ONCE(index >= DEMOTION_TARGET_NODES,
> -		      "Exceeds maximum demotion target nodes\n"))
> -		goto out_clear;
> -
> -	nd->nodes[index] = migration_target;
> -	nd->nr++;
> -
> -	return migration_target;
> -out_clear:
> -	node_clear(migration_target, *used);
> -	return NUMA_NO_NODE;
> -}
> -
> -/*
> - * When memory fills up on a node, memory contents can be
> - * automatically migrated to another node instead of
> - * discarded at reclaim.
> - *
> - * Establish a "migration path" which will start at nodes
> - * with CPUs and will follow the priorities used to build the
> - * page allocator zonelists.
> - *
> - * The difference here is that cycles must be avoided.  If
> - * node0 migrates to node1, then neither node1, nor anything
> - * node1 migrates to can migrate to node0. Also one node can
> - * be migrated to multiple nodes if the target nodes all have
> - * a same best-distance against the source node.
> - *
> - * This function can run simultaneously with readers of
> - * node_demotion[].  However, it can not run simultaneously
> - * with itself.  Exclusion is provided by memory hotplug events
> - * being single-threaded.
> - */
> -static void __set_migration_target_nodes(void)
> -{
> -	nodemask_t next_pass;
> -	nodemask_t this_pass;
> -	nodemask_t used_targets = NODE_MASK_NONE;
> -	int node, best_distance;
> -
> -	/*
> -	 * Avoid any oddities like cycles that could occur
> -	 * from changes in the topology.  This will leave
> -	 * a momentary gap when migration is disabled.
> -	 */
> -	disable_all_migrate_targets();
> -
> -	/*
> -	 * Allocations go close to CPUs, first.  Assume that
> -	 * the migration path starts at the nodes with CPUs.
> -	 */
> -	next_pass = node_states[N_CPU];
> -again:
> -	this_pass = next_pass;
> -	next_pass = NODE_MASK_NONE;
> -	/*
> -	 * To avoid cycles in the migration "graph", ensure
> -	 * that migration sources are not future targets by
> -	 * setting them in 'used_targets'.  Do this only
> -	 * once per pass so that multiple source nodes can
> -	 * share a target node.
> -	 *
> -	 * 'used_targets' will become unavailable in future
> -	 * passes.  This limits some opportunities for
> -	 * multiple source nodes to share a destination.
> -	 */
> -	nodes_or(used_targets, used_targets, this_pass);
> -
> -	for_each_node_mask(node, this_pass) {
> -		best_distance = -1;
> -
> -		/*
> -		 * Try to set up the migration path for the node, and the target
> -		 * migration nodes can be multiple, so doing a loop to find all
> -		 * the target nodes if they all have a best node distance.
> -		 */
> -		do {
> -			int target_node =
> -				establish_migrate_target(node, &used_targets,
> -							 best_distance);
> -
> -			if (target_node == NUMA_NO_NODE)
> -				break;
> -
> -			if (best_distance == -1)
> -				best_distance = node_distance(node, target_node);
> -
> -			/*
> -			 * Visit targets from this pass in the next pass.
> -			 * Eventually, every node will have been part of
> -			 * a pass, and will become set in 'used_targets'.
> -			 */
> -			node_set(target_node, next_pass);
> -		} while (1);
> -	}
> -	/*
> -	 * 'next_pass' contains nodes which became migration
> -	 * targets in this pass.  Make additional passes until
> -	 * no more migrations targets are available.
> -	 */
> -	if (!nodes_empty(next_pass))
> -		goto again;
> -}
> -
> -/*
> - * For callers that do not hold get_online_mems() already.
> - */
> -void set_migration_target_nodes(void)
> -{
> -	get_online_mems();
> -	__set_migration_target_nodes();
> -	put_online_mems();
> -}
> -
> -/*
> - * This leaves migrate-on-reclaim transiently disabled between
> - * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
> - * whether reclaim-based migration is enabled or not, which
> - * ensures that the user can turn reclaim-based migration at
> - * any time without needing to recalculate migration targets.
> - *
> - * These callbacks already hold get_online_mems().  That is why
> - * __set_migration_target_nodes() can be used as opposed to
> - * set_migration_target_nodes().
> - */
> -#ifdef CONFIG_MEMORY_HOTPLUG
> -static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> -						 unsigned long action, void *_arg)
> -{
> -	struct memory_notify *arg = _arg;
> -
> -	/*
> -	 * Only update the node migration order when a node is
> -	 * changing status, like online->offline.  This avoids
> -	 * the overhead of synchronize_rcu() in most cases.
> -	 */
> -	if (arg->status_change_nid < 0)
> -		return notifier_from_errno(0);
> -
> -	switch (action) {
> -	case MEM_GOING_OFFLINE:
> -		/*
> -		 * Make sure there are not transient states where
> -		 * an offline node is a migration target.  This
> -		 * will leave migration disabled until the offline
> -		 * completes and the MEM_OFFLINE case below runs.
> -		 */
> -		disable_all_migrate_targets();
> -		break;
> -	case MEM_OFFLINE:
> -	case MEM_ONLINE:
> -		/*
> -		 * Recalculate the target nodes once the node
> -		 * reaches its final state (online or offline).
> -		 */
> -		__set_migration_target_nodes();
> -		break;
> -	case MEM_CANCEL_OFFLINE:
> -		/*
> -		 * MEM_GOING_OFFLINE disabled all the migration
> -		 * targets.  Reenable them.
> -		 */
> -		__set_migration_target_nodes();
> -		break;
> -	case MEM_GOING_ONLINE:
> -	case MEM_CANCEL_ONLINE:
> -		break;
> -	}
> -
> -	return notifier_from_errno(0);
> -}
> -#endif
> -
> -void __init migrate_on_reclaim_init(void)
> -{
> -	node_demotion = kcalloc(nr_node_ids,
> -				sizeof(struct demotion_nodes),
> -				GFP_KERNEL);
> -	WARN_ON(!node_demotion);
> -#ifdef CONFIG_MEMORY_HOTPLUG
> -	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> -#endif
> -	/*
> -	 * At this point, all numa nodes with memory/CPus have their state
> -	 * properly set, so we can build the demotion order now.
> -	 * Let us hold the cpu_hotplug lock just, as we could possibily have
> -	 * CPU hotplug events during boot.
> -	 */
> -	cpus_read_lock();
> -	set_migration_target_nodes();
> -	cpus_read_unlock();
> -}
>  #endif /* CONFIG_NUMA */
> -
> -
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 373d2730fcf2..35c6ff97cf29 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -28,7 +28,6 @@
>  #include <linux/mm_inline.h>
>  #include <linux/page_ext.h>
>  #include <linux/page_owner.h>
> -#include <linux/migrate.h>
>  
>  #include "internal.h"
>  
> @@ -2060,7 +2059,6 @@ static int vmstat_cpu_online(unsigned int cpu)
>  
>  	if (!node_state(cpu_to_node(cpu), N_CPU)) {
>  		node_set_state(cpu_to_node(cpu), N_CPU);
> -		set_migration_target_nodes();
>  	}
>  
>  	return 0;
> @@ -2085,7 +2083,6 @@ static int vmstat_cpu_dead(unsigned int cpu)
>  		return 0;
>  
>  	node_clear_state(node, N_CPU);
> -	set_migration_target_nodes();
>  
>  	return 0;
>  }
> @@ -2118,7 +2115,6 @@ void __init init_mm_internals(void)
>  
>  	start_shepherd_timer();
>  #endif
> -	migrate_on_reclaim_init();
>  #ifdef CONFIG_PROC_FS
>  	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
>  	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
