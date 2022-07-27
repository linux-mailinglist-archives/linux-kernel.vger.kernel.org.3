Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC7581D45
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 03:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiG0BlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 21:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbiG0BlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 21:41:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB14DF1B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 18:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658886063; x=1690422063;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=8EBi7nNa68CmVosNBGTMYgDxai1rNPv2j5x659bztqM=;
  b=eAJsUlNlXIWrLa80FfVWeQwF/qkgBkMSKbJ+1jx+nBQmEb5/ecFER9B/
   OTWyEfieNEDjBwdL3spqxF/x4s4WgzIu+jy/M034s0AaPPP2fiLfUttYd
   OvROWFvtXvQMDSU4GohJVYDJ4zYpRtift9iFZmPwrwWWDXOn30Qe40CWL
   Icu/xTTuB0q3c+Rs+bKkRMKmE3hysLSXzcuELZFzi4YHjLOgNCJjAcAOD
   ErfYBElyiOo63eYJdCUqnqnQ7qCZimoNYRFkNEDivBhQdIcC/q017rEJu
   7UWrQzdlK5KcJcsuhHMNGVp+YGmjo7gFqZeozPUkAItQJSS+2S2AIGLgv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="288129931"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="288129931"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:41:03 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575760689"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 18:40:59 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
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
Subject: Re: [PATCH v10 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
        <20220720025920.1373558-6-aneesh.kumar@linux.ibm.com>
        <871qu8wc6c.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <9f14814c-cb08-8032-caff-edcd0594ad41@linux.ibm.com>
Date:   Wed, 27 Jul 2022 09:40:55 +0800
In-Reply-To: <9f14814c-cb08-8032-caff-edcd0594ad41@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Tue, 26 Jul 2022 18:00:09 +0530")
Message-ID: <87h733uyc8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 7/26/22 1:14 PM, Huang, Ying wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> This patch switch the demotion target building logic to use memory tiers
>>> instead of NUMA distance. All N_MEMORY NUMA nodes will be placed in the
>>> default memory tier and additional memory tiers will be added by drivers like
>>> dax kmem.
>>>
>>> This patch builds the demotion target for a NUMA node by looking at all
>>> memory tiers below the tier to which the NUMA node belongs. The closest node
>>> in the immediately following memory tier is used as a demotion target.
>>>
>>> Since we are now only building demotion target for N_MEMORY NUMA nodes
>>> the CPU hotplug calls are removed in this patch.
>>>
>>> A new memory tier can be inserted into the tier hierarchy for a new set of nodes
>>> without affecting the node assignment of any existing memtier, provided that
>>> there is enough gap in the performance level values for the new memtier.
>>>
>>> The absolute value of performance level of a memtier doesn't necessarily carry
>>> any meaning. Its value relative to other memtiers decides the level of this
>>> memtier in the tier hierarchy.
>> 
>> The above 2 paragraphs appear not related to the patch.
>> 
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> ---
>>>  include/linux/memory-tiers.h |  12 ++
>>>  include/linux/migrate.h      |  13 --
>>>  mm/memory-tiers.c            | 218 ++++++++++++++++++-
>>>  mm/migrate.c                 | 394 -----------------------------------
>>>  mm/vmstat.c                  |   4 -
>>>  5 files changed, 229 insertions(+), 412 deletions(-)
>>>
>>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>>> index 3d5f14d57ae6..852e86bd0a23 100644
>>> --- a/include/linux/memory-tiers.h
>>> +++ b/include/linux/memory-tiers.h
>>> @@ -17,9 +17,21 @@
>>>  #define MEMTIER_HOTPLUG_PRIO	100
>>>  
>>>  extern bool numa_demotion_enabled;
>>> +#ifdef CONFIG_MIGRATION
>>> +int next_demotion_node(int node);
>>> +#else
>>> +static inline int next_demotion_node(int node)
>>> +{
>>> +	return NUMA_NO_NODE;
>>> +}
>>> +#endif
>>>  
>>>  #else
>>>  
>>>  #define numa_demotion_enabled	false
>>> +static inline int next_demotion_node(int node)
>>> +{
>>> +	return NUMA_NO_NODE;
>>> +}
>>>  #endif	/* CONFIG_NUMA */
>>>  #endif  /* _LINUX_MEMORY_TIERS_H */
>>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>>> index 43e737215f33..93fab62e6548 100644
>>> --- a/include/linux/migrate.h
>>> +++ b/include/linux/migrate.h
>>> @@ -75,19 +75,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>>>  
>>>  #endif /* CONFIG_MIGRATION */
>>>  
>>> -#if defined(CONFIG_MIGRATION) && defined(CONFIG_NUMA)
>>> -extern void set_migration_target_nodes(void);
>>> -extern void migrate_on_reclaim_init(void);
>>> -extern int next_demotion_node(int node);
>>> -#else
>>> -static inline void set_migration_target_nodes(void) {}
>>> -static inline void migrate_on_reclaim_init(void) {}
>>> -static inline int next_demotion_node(int node)
>>> -{
>>> -        return NUMA_NO_NODE;
>>> -}
>>> -#endif
>>> -
>>>  #ifdef CONFIG_COMPACTION
>>>  extern int PageMovable(struct page *page);
>>>  extern void __SetPageMovable(struct page *page, struct address_space *mapping);
>>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>>> index cc3a47ec18e4..a8cfe2ca3903 100644
>>> --- a/mm/memory-tiers.c
>>> +++ b/mm/memory-tiers.c
>>> @@ -6,17 +6,88 @@
>>>  #include <linux/moduleparam.h>
>>>  #include <linux/node.h>
>>>  #include <linux/memory.h>
>>> +#include <linux/random.h>
>>>  #include <linux/memory-tiers.h>
>>>  
>>> +#include "internal.h"
>>> +
>>>  struct memory_tier {
>>>  	struct list_head list;
>>>  	int perf_level;
>>>  	nodemask_t nodelist;
>>>  };
>>>  
>>> +struct demotion_nodes {
>>> +	nodemask_t preferred;
>>> +};
>>> +
>>>  static LIST_HEAD(memory_tiers);
>>>  static DEFINE_MUTEX(memory_tier_lock);
>>>  
>>> +#ifdef CONFIG_MIGRATION
>>> +/*
>>> + * node_demotion[] examples:
>>> + *
>>> + * Example 1:
>>> + *
>>> + * Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM nodes.
>>> + *
>>> + * node distances:
>>> + * node   0    1    2    3
>>> + *    0  10   20   30   40
>>> + *    1  20   10   40   30
>>> + *    2  30   40   10   40
>>> + *    3  40   30   40   10
>>> + *
>>> + * memory_tiers[0] = <empty>
>>> + * memory_tiers[1] = 0-1
>>> + * memory_tiers[2] = 2-3
>> 
>> We don't have memory_tiers array now, and we don't use static memory
>> tier ID too.  So I suggest to change the above to,
>> 
>> memory_tier0: 0-1
>> memory_tier1: 2-3
>> 
>>> + *
>>> + * node_demotion[0].preferred = 2
>>> + * node_demotion[1].preferred = 3
>>> + * node_demotion[2].preferred = <empty>
>>> + * node_demotion[3].preferred = <empty>
>>> + *
>>> + * Example 2:
>>> + *
>>> + * Node 0 & 1 are CPU + DRAM nodes, node 2 is memory-only DRAM node.
>>> + *
>>> + * node distances:
>>> + * node   0    1    2
>>> + *    0  10   20   30
>>> + *    1  20   10   30
>>> + *    2  30   30   10
>>> + *
>>> + * memory_tiers[0] = <empty>
>>> + * memory_tiers[1] = 0-2
>>> + * memory_tiers[2] = <empty>
>>> + *
>>> + * node_demotion[0].preferred = <empty>
>>> + * node_demotion[1].preferred = <empty>
>>> + * node_demotion[2].preferred = <empty>
>>> + *
>>> + * Example 3:
>>> + *
>>> + * Node 0 is CPU + DRAM nodes, Node 1 is HBM node, node 2 is PMEM node.
>>> + *
>>> + * node distances:
>>> + * node   0    1    2
>>> + *    0  10   20   30
>>> + *    1  20   10   40
>>> + *    2  30   40   10
>>> + *
>>> + * memory_tiers[0] = 1
>>> + * memory_tiers[1] = 0
>>> + * memory_tiers[2] = 2
>>> + *
>>> + * node_demotion[0].preferred = 2
>>> + * node_demotion[1].preferred = 0
>>> + * node_demotion[2].preferred = <empty>
>>> + *
>>> + */
>>> +static struct demotion_nodes *node_demotion __read_mostly;
>>> +#endif /* CONFIG_MIGRATION */
>>> +
>>>  /*
>>>   * For now let's have 4 memory tier below default DRAM tier.
>>>   */
>>> @@ -76,6 +147,136 @@ static struct memory_tier *__node_get_memory_tier(int node)
>>>  	return NULL;
>>>  }
>>>  
>>> +#ifdef CONFIG_MIGRATION
>>> +/**
>>> + * next_demotion_node() - Get the next node in the demotion path
>>> + * @node: The starting node to lookup the next node
>>> + *
>>> + * Return: node id for next memory node in the demotion path hierarchy
>>> + * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
>>> + * @node online or guarantee that it *continues* to be the next demotion
>>> + * target.
>>> + */
>>> +int next_demotion_node(int node)
>>> +{
>>> +	struct demotion_nodes *nd;
>>> +	int target;
>>> +
>>> +	if (!node_demotion)
>>> +		return NUMA_NO_NODE;
>>> +
>>> +	nd = &node_demotion[node];
>>> +
>>> +	/*
>>> +	 * node_demotion[] is updated without excluding this
>>> +	 * function from running.
>>> +	 *
>>> +	 * Make sure to use RCU over entire code blocks if
>>> +	 * node_demotion[] reads need to be consistent.
>>> +	 */
>>> +	rcu_read_lock();
>>> +	/*
>>> +	 * If there are multiple target nodes, just select one
>>> +	 * target node randomly.
>>> +	 *
>>> +	 * In addition, we can also use round-robin to select
>>> +	 * target node, but we should introduce another variable
>>> +	 * for node_demotion[] to record last selected target node,
>>> +	 * that may cause cache ping-pong due to the changing of
>>> +	 * last target node. Or introducing per-cpu data to avoid
>>> +	 * caching issue, which seems more complicated. So selecting
>>> +	 * target node randomly seems better until now.
>>> +	 */
>>> +	target = node_random(&nd->preferred);
>> 
>> In one of the most common cases, nodes_weight(&nd->preferred) == 1.
>> Where, get_random_int() in node_random() just wastes CPU cycles and
>> random entropy.  So the original struct demotion_nodes implementation
>> appears better.
>> 
>>   struct demotion_nodes {
>>          unsigned short nr;
>>          short nodes[DEMOTION_TARGET_NODES];
>>   };
>> 
>
>
> Is that measurable difference? using nodemask_t makes it much easier with respect to
> implementation. IMHO if we observe the usage of node_random() to have performance impact
> with nodes_weight() == 1 we should fix node_random() to handle that? If you strongly
> feel we should fix this, i can opencode node_random to special case node_weight() == 1?

If there's no much difference, why not just use the existing code?
IMHO, it's your responsibility to prove your new implementation is
better via numbers, for example, reduced code lines, with better or same
performance.

Another policy is just to use the existing code in the first version.
Then change it based on measurement.

In general, I care more about the most common cases, that is, 0 or 1
demotion target.

> -	target = node_random(&nd->preferred);
> +	node_weight = nodes_weight(nd->preferred);
> +	switch (node_weight) {
> +	case 0:
> +		target = NUMA_NO_NODE;
> +		break;
> +	case 1:
> +		target = first_node(nd->preferred);
> +		break;
> +	default:
> +		target = bitmap_ord_to_pos(nd->preferred.bits,
> +					   get_random_int() % node_weight, MAX_NUMNODES);
> +		break;
> +	}
>  
>
>>> +	rcu_read_unlock();
>>> +
>>> +	return target;
>>> +}
>>> +
>>> +/* Disable reclaim-based migration. */
>>> +static void __disable_all_migrate_targets(void)
>> 
>> How about rename "migrate" to "demote" to make it more specific?
>> 
>>> +{
>>> +	int node;
>>> +
>>> +	for_each_node_state(node, N_MEMORY)
>>> +		node_demotion[node].preferred = NODE_MASK_NONE;
>>> +}
>>> +
>>> +static void disable_all_migrate_targets(void)
>>> +{
>>> +	__disable_all_migrate_targets();
>>> +
>>> +	/*
>>> +	 * Ensure that the "disable" is visible across the system.
>>> +	 * Readers will see either a combination of before+disable
>>> +	 * state or disable+after.  They will never see before and
>>> +	 * after state together.
>>> +	 */
>>> +	synchronize_rcu();
>>> +}
>>> +/*
>>> + * Find an automatic demotion target for all memory
>>> + * nodes. Failing here is OK.  It might just indicate
>>> + * being at the end of a chain.
>>> + */
>>> +static void establish_migration_targets(void)
>>> +{
>>> +	struct memory_tier *memtier;
>>> +	struct demotion_nodes *nd;
>>> +	int target = NUMA_NO_NODE, node;
>>> +	int distance, best_distance;
>>> +	nodemask_t used;
>>> +
>>> +	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))
>>> +		return;
>>> +
>>> +	disable_all_migrate_targets();
>>> +
>>> +	for_each_node_state(node, N_MEMORY) {
>>> +		best_distance = -1;
>>> +		nd = &node_demotion[node];
>>> +
>>> +		memtier = __node_get_memory_tier(node);
>>> +		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
>>> +			continue;
>>> +		/*
>>> +		 * Get the next memtier to find the  demotion node list.
>>> +		 */
>>> +		memtier = list_next_entry(memtier, list);
>>> +
>>> +		/*
>>> +		 * find_next_best_node, use 'used' nodemask as a skip list.
>>> +		 * Add all memory nodes except the selected memory tier
>>> +		 * nodelist to skip list so that we find the best node from the
>>> +		 * memtier nodelist.
>>> +		 */
>>> +		nodes_andnot(used, node_states[N_MEMORY], memtier->nodelist);
>>> +
>>> +		/*
>>> +		 * Find all the nodes in the memory tier node list of same best distance.
>>> +		 * add them to the preferred mask. We randomly select between nodes
>>> +		 * in the preferred mask when allocating pages during demotion.
>>> +		 */
>>> +		do {
>>> +			target = find_next_best_node(node, &used);
>>> +			if (target == NUMA_NO_NODE)
>>> +				break;
>>> +
>>> +			distance = node_distance(node, target);
>>> +			if (distance == best_distance || best_distance == -1) {
>>> +				best_distance = distance;
>>> +				node_set(target, nd->preferred);
>>> +			} else {
>>> +				break;
>>> +			}
>>> +		} while (1);
>>> +	}
>>> +}
>>> +#else
>>> +static inline void disable_all_migrate_targets(void) {}
>>> +static inline void establish_migration_targets(void) {}
>>> +#endif /* CONFIG_MIGRATION */
>>> +
>>>  static void init_node_memory_tier(int node)
>>>  {
>>>  	int perf_level;
>>> @@ -84,11 +285,19 @@ static void init_node_memory_tier(int node)
>>>  	mutex_lock(&memory_tier_lock);
>>>  
>>>  	memtier = __node_get_memory_tier(node);
>>> +	/*
>>> +	 * if node is already part of the tier proceed with the
>>> +	 * current tier value, because we might want to establish
>>> +	 * new migration paths now. The node might be added to a tier
>>> +	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
>>> +	 * will have skipped this node.
>>> +	 */
>>>  	if (!memtier) {
>>>  		perf_level = node_devices[node]->perf_level;
>>>  		memtier = find_create_memory_tier(perf_level);
>>>  		node_set(node, memtier->nodelist);
>>>  	}
>>> +	establish_migration_targets();
>> 
>> Why combines memory tiers establishing with demotion targets building?
>> I think that it's better to separate them.   For example, if we move a
>> set of NUMA node from one memory tier to another memory tier, we only
>> need to run establish_migration_targets() once after moving all nodes.
>> 
>
> Yes agree. I am not sure I followed your comment here. 
>
> Demotion target rebuilding is a separate helper. Any update to memory tiers needs rebuilding
> of demotion targets. Also any change in node mask of memory tier needs
> demotion target rebuild. Can you clarify the code change you are suggesting here?

I think we should call establish_migration_targets() in
migrate_on_reclaim_callback() directly.  As the example I mentioned
above, sometimes, we don't need to call establish_migration_targets()
for each node changing.

>>>  	mutex_unlock(&memory_tier_lock);
>>>  }
>>>  
>>> @@ -98,8 +307,10 @@ static void clear_node_memory_tier(int node)
>>>  
>>>  	mutex_lock(&memory_tier_lock);
>>>  	memtier = __node_get_memory_tier(node);
>>> -	if (memtier)
>>> +	if (memtier) {
>>>  		node_clear(node, memtier->nodelist);
>>> +		establish_migration_targets();
>>> +	}
>>>  	mutex_unlock(&memory_tier_lock);
>>>  }
>>>  
>>> @@ -134,6 +345,11 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>>>  
>>>  static void __init migrate_on_reclaim_init(void)
>>>  {
>>> +	if (IS_ENABLED(CONFIG_MIGRATION)) {
>>> +		node_demotion = kcalloc(MAX_NUMNODES, sizeof(struct demotion_nodes),
>> 
>> Why allocate MAX_NUMNODES instead of nr_node_ids as before?
>> 
>>> +					GFP_KERNEL);
>>> +		WARN_ON(!node_demotion);
>>> +	}
>>>  	hotplug_memory_notifier(migrate_on_reclaim_callback, MEMTIER_HOTPLUG_PRIO);
>>>  }
>>>  
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index fce7d4a9e940..c758c9c21d7d 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -2117,398 +2117,4 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>>>  	return 0;
>>>  }
>>>  #endif /* CONFIG_NUMA_BALANCING */
>>> -
>>> -/*
>>> - * node_demotion[] example:
>>> - *
>>> - * Consider a system with two sockets.  Each socket has
>>> - * three classes of memory attached: fast, medium and slow.
>>> - * Each memory class is placed in its own NUMA node.  The
>>> - * CPUs are placed in the node with the "fast" memory.  The
>>> - * 6 NUMA nodes (0-5) might be split among the sockets like
>>> - * this:
>>> - *
>>> - *	Socket A: 0, 1, 2
>>> - *	Socket B: 3, 4, 5
>>> - *
>>> - * When Node 0 fills up, its memory should be migrated to
>>> - * Node 1.  When Node 1 fills up, it should be migrated to
>>> - * Node 2.  The migration path start on the nodes with the
>>> - * processors (since allocations default to this node) and
>>> - * fast memory, progress through medium and end with the
>>> - * slow memory:
>>> - *
>>> - *	0 -> 1 -> 2 -> stop
>>> - *	3 -> 4 -> 5 -> stop
>>> - *
>>> - * This is represented in the node_demotion[] like this:
>>> - *
>>> - *	{  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
>>> - *	{  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
>>> - *	{  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
>>> - *	{  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
>>> - *	{  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
>>> - *	{  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
>>> - *
>>> - * Moreover some systems may have multiple slow memory nodes.
>>> - * Suppose a system has one socket with 3 memory nodes, node 0
>>> - * is fast memory type, and node 1/2 both are slow memory
>>> - * type, and the distance between fast memory node and slow
>>> - * memory node is same. So the migration path should be:
>>> - *
>>> - *	0 -> 1/2 -> stop
>>> - *
>>> - * This is represented in the node_demotion[] like this:
>>> - *	{ nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
>>> - *	{ nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
>>> - *	{ nr=0, nodes[0]=-1, }, // Node 2 does not migrate
>>> - */
>>> -
>>> -/*
>>> - * Writes to this array occur without locking.  Cycles are
>>> - * not allowed: Node X demotes to Y which demotes to X...
>>> - *
>>> - * If multiple reads are performed, a single rcu_read_lock()
>>> - * must be held over all reads to ensure that no cycles are
>>> - * observed.
>>> - */
>>> -#define DEFAULT_DEMOTION_TARGET_NODES 15
>>> -
>>> -#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
>>> -#define DEMOTION_TARGET_NODES	(MAX_NUMNODES - 1)
>>> -#else
>>> -#define DEMOTION_TARGET_NODES	DEFAULT_DEMOTION_TARGET_NODES
>>> -#endif
>>> -
>>> -struct demotion_nodes {
>>> -	unsigned short nr;
>>> -	short nodes[DEMOTION_TARGET_NODES];
>>> -};
>>> -
>>> -static struct demotion_nodes *node_demotion __read_mostly;
>>> -
>>> -/**
>>> - * next_demotion_node() - Get the next node in the demotion path
>>> - * @node: The starting node to lookup the next node
>>> - *
>>> - * Return: node id for next memory node in the demotion path hierarchy
>>> - * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
>>> - * @node online or guarantee that it *continues* to be the next demotion
>>> - * target.
>>> - */
>>> -int next_demotion_node(int node)
>>> -{
>>> -	struct demotion_nodes *nd;
>>> -	unsigned short target_nr, index;
>>> -	int target;
>>> -
>>> -	if (!node_demotion)
>>> -		return NUMA_NO_NODE;
>>> -
>>> -	nd = &node_demotion[node];
>>> -
>>> -	/*
>>> -	 * node_demotion[] is updated without excluding this
>>> -	 * function from running.  RCU doesn't provide any
>>> -	 * compiler barriers, so the READ_ONCE() is required
>>> -	 * to avoid compiler reordering or read merging.
>>> -	 *
>>> -	 * Make sure to use RCU over entire code blocks if
>>> -	 * node_demotion[] reads need to be consistent.
>>> -	 */
>>> -	rcu_read_lock();
>>> -	target_nr = READ_ONCE(nd->nr);
>>> -
>>> -	switch (target_nr) {
>>> -	case 0:
>>> -		target = NUMA_NO_NODE;
>>> -		goto out;
>>> -	case 1:
>>> -		index = 0;
>>> -		break;
>>> -	default:
>>> -		/*
>>> -		 * If there are multiple target nodes, just select one
>>> -		 * target node randomly.
>>> -		 *
>>> -		 * In addition, we can also use round-robin to select
>>> -		 * target node, but we should introduce another variable
>>> -		 * for node_demotion[] to record last selected target node,
>>> -		 * that may cause cache ping-pong due to the changing of
>>> -		 * last target node. Or introducing per-cpu data to avoid
>>> -		 * caching issue, which seems more complicated. So selecting
>>> -		 * target node randomly seems better until now.
>>> -		 */
>>> -		index = get_random_int() % target_nr;
>>> -		break;
>>> -	}
>>> -
>>> -	target = READ_ONCE(nd->nodes[index]);
>>> -
>>> -out:
>>> -	rcu_read_unlock();
>>> -	return target;
>>> -}
>>> -
>>> -/* Disable reclaim-based migration. */
>>> -static void __disable_all_migrate_targets(void)
>>> -{
>>> -	int node, i;
>>> -
>>> -	if (!node_demotion)
>>> -		return;
>>> -
>>> -	for_each_online_node(node) {
>>> -		node_demotion[node].nr = 0;
>>> -		for (i = 0; i < DEMOTION_TARGET_NODES; i++)
>>> -			node_demotion[node].nodes[i] = NUMA_NO_NODE;
>>> -	}
>>> -}
>>> -
>>> -static void disable_all_migrate_targets(void)
>>> -{
>>> -	__disable_all_migrate_targets();
>>> -
>>> -	/*
>>> -	 * Ensure that the "disable" is visible across the system.
>>> -	 * Readers will see either a combination of before+disable
>>> -	 * state or disable+after.  They will never see before and
>>> -	 * after state together.
>>> -	 *
>>> -	 * The before+after state together might have cycles and
>>> -	 * could cause readers to do things like loop until this
>>> -	 * function finishes.  This ensures they can only see a
>>> -	 * single "bad" read and would, for instance, only loop
>>> -	 * once.
>>> -	 */
>>> -	synchronize_rcu();
>>> -}
>>> -
>>> -/*
>>> - * Find an automatic demotion target for 'node'.
>>> - * Failing here is OK.  It might just indicate
>>> - * being at the end of a chain.
>>> - */
>>> -static int establish_migrate_target(int node, nodemask_t *used,
>>> -				    int best_distance)
>>> -{
>>> -	int migration_target, index, val;
>>> -	struct demotion_nodes *nd;
>>> -
>>> -	if (!node_demotion)
>>> -		return NUMA_NO_NODE;
>>> -
>>> -	nd = &node_demotion[node];
>>> -
>>> -	migration_target = find_next_best_node(node, used);
>>> -	if (migration_target == NUMA_NO_NODE)
>>> -		return NUMA_NO_NODE;
>>> -
>>> -	/*
>>> -	 * If the node has been set a migration target node before,
>>> -	 * which means it's the best distance between them. Still
>>> -	 * check if this node can be demoted to other target nodes
>>> -	 * if they have a same best distance.
>>> -	 */
>>> -	if (best_distance != -1) {
>>> -		val = node_distance(node, migration_target);
>>> -		if (val > best_distance)
>>> -			goto out_clear;
>>> -	}
>>> -
>>> -	index = nd->nr;
>>> -	if (WARN_ONCE(index >= DEMOTION_TARGET_NODES,
>>> -		      "Exceeds maximum demotion target nodes\n"))
>>> -		goto out_clear;
>>> -
>>> -	nd->nodes[index] = migration_target;
>>> -	nd->nr++;
>>> -
>>> -	return migration_target;
>>> -out_clear:
>>> -	node_clear(migration_target, *used);
>>> -	return NUMA_NO_NODE;
>>> -}
>>> -
>>> -/*
>>> - * When memory fills up on a node, memory contents can be
>>> - * automatically migrated to another node instead of
>>> - * discarded at reclaim.
>>> - *
>>> - * Establish a "migration path" which will start at nodes
>>> - * with CPUs and will follow the priorities used to build the
>>> - * page allocator zonelists.
>>> - *
>>> - * The difference here is that cycles must be avoided.  If
>>> - * node0 migrates to node1, then neither node1, nor anything
>>> - * node1 migrates to can migrate to node0. Also one node can
>>> - * be migrated to multiple nodes if the target nodes all have
>>> - * a same best-distance against the source node.
>>> - *
>>> - * This function can run simultaneously with readers of
>>> - * node_demotion[].  However, it can not run simultaneously
>>> - * with itself.  Exclusion is provided by memory hotplug events
>>> - * being single-threaded.
>>> - */
>>> -static void __set_migration_target_nodes(void)
>>> -{
>>> -	nodemask_t next_pass;
>>> -	nodemask_t this_pass;
>>> -	nodemask_t used_targets = NODE_MASK_NONE;
>>> -	int node, best_distance;
>>> -
>>> -	/*
>>> -	 * Avoid any oddities like cycles that could occur
>>> -	 * from changes in the topology.  This will leave
>>> -	 * a momentary gap when migration is disabled.
>>> -	 */
>>> -	disable_all_migrate_targets();
>>> -
>>> -	/*
>>> -	 * Allocations go close to CPUs, first.  Assume that
>>> -	 * the migration path starts at the nodes with CPUs.
>>> -	 */
>>> -	next_pass = node_states[N_CPU];
>>> -again:
>>> -	this_pass = next_pass;
>>> -	next_pass = NODE_MASK_NONE;
>>> -	/*
>>> -	 * To avoid cycles in the migration "graph", ensure
>>> -	 * that migration sources are not future targets by
>>> -	 * setting them in 'used_targets'.  Do this only
>>> -	 * once per pass so that multiple source nodes can
>>> -	 * share a target node.
>>> -	 *
>>> -	 * 'used_targets' will become unavailable in future
>>> -	 * passes.  This limits some opportunities for
>>> -	 * multiple source nodes to share a destination.
>>> -	 */
>>> -	nodes_or(used_targets, used_targets, this_pass);
>>> -
>>> -	for_each_node_mask(node, this_pass) {
>>> -		best_distance = -1;
>>> -
>>> -		/*
>>> -		 * Try to set up the migration path for the node, and the target
>>> -		 * migration nodes can be multiple, so doing a loop to find all
>>> -		 * the target nodes if they all have a best node distance.
>>> -		 */
>>> -		do {
>>> -			int target_node =
>>> -				establish_migrate_target(node, &used_targets,
>>> -							 best_distance);
>>> -
>>> -			if (target_node == NUMA_NO_NODE)
>>> -				break;
>>> -
>>> -			if (best_distance == -1)
>>> -				best_distance = node_distance(node, target_node);
>>> -
>>> -			/*
>>> -			 * Visit targets from this pass in the next pass.
>>> -			 * Eventually, every node will have been part of
>>> -			 * a pass, and will become set in 'used_targets'.
>>> -			 */
>>> -			node_set(target_node, next_pass);
>>> -		} while (1);
>>> -	}
>>> -	/*
>>> -	 * 'next_pass' contains nodes which became migration
>>> -	 * targets in this pass.  Make additional passes until
>>> -	 * no more migrations targets are available.
>>> -	 */
>>> -	if (!nodes_empty(next_pass))
>>> -		goto again;
>>> -}
>>> -
>>> -/*
>>> - * For callers that do not hold get_online_mems() already.
>>> - */
>>> -void set_migration_target_nodes(void)
>>> -{
>>> -	get_online_mems();
>>> -	__set_migration_target_nodes();
>>> -	put_online_mems();
>>> -}
>>> -
>>> -/*
>>> - * This leaves migrate-on-reclaim transiently disabled between
>>> - * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
>>> - * whether reclaim-based migration is enabled or not, which
>>> - * ensures that the user can turn reclaim-based migration at
>>> - * any time without needing to recalculate migration targets.
>>> - *
>>> - * These callbacks already hold get_online_mems().  That is why
>>> - * __set_migration_target_nodes() can be used as opposed to
>>> - * set_migration_target_nodes().
>>> - */
>>> -#ifdef CONFIG_MEMORY_HOTPLUG
>>> -static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>>> -						 unsigned long action, void *_arg)
>>> -{
>>> -	struct memory_notify *arg = _arg;
>>> -
>>> -	/*
>>> -	 * Only update the node migration order when a node is
>>> -	 * changing status, like online->offline.  This avoids
>>> -	 * the overhead of synchronize_rcu() in most cases.
>>> -	 */
>>> -	if (arg->status_change_nid < 0)
>>> -		return notifier_from_errno(0);
>>> -
>>> -	switch (action) {
>>> -	case MEM_GOING_OFFLINE:
>>> -		/*
>>> -		 * Make sure there are not transient states where
>>> -		 * an offline node is a migration target.  This
>>> -		 * will leave migration disabled until the offline
>>> -		 * completes and the MEM_OFFLINE case below runs.
>>> -		 */
>>> -		disable_all_migrate_targets();
>>> -		break;
>>> -	case MEM_OFFLINE:
>>> -	case MEM_ONLINE:
>>> -		/*
>>> -		 * Recalculate the target nodes once the node
>>> -		 * reaches its final state (online or offline).
>>> -		 */
>>> -		__set_migration_target_nodes();
>>> -		break;
>>> -	case MEM_CANCEL_OFFLINE:
>>> -		/*
>>> -		 * MEM_GOING_OFFLINE disabled all the migration
>>> -		 * targets.  Reenable them.
>>> -		 */
>>> -		__set_migration_target_nodes();
>>> -		break;
>>> -	case MEM_GOING_ONLINE:
>>> -	case MEM_CANCEL_ONLINE:
>>> -		break;
>>> -	}
>>> -
>>> -	return notifier_from_errno(0);
>>> -}
>>> -#endif
>>> -
>>> -void __init migrate_on_reclaim_init(void)
>>> -{
>>> -	node_demotion = kcalloc(nr_node_ids,
>>> -				sizeof(struct demotion_nodes),
>>> -				GFP_KERNEL);
>>> -	WARN_ON(!node_demotion);
>>> -#ifdef CONFIG_MEMORY_HOTPLUG
>>> -	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
>>> -#endif
>>> -	/*
>>> -	 * At this point, all numa nodes with memory/CPus have their state
>>> -	 * properly set, so we can build the demotion order now.
>>> -	 * Let us hold the cpu_hotplug lock just, as we could possibily have
>>> -	 * CPU hotplug events during boot.
>>> -	 */
>>> -	cpus_read_lock();
>>> -	set_migration_target_nodes();
>>> -	cpus_read_unlock();
>>> -}
>>>  #endif /* CONFIG_NUMA */
>>> -
>>> -
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index 373d2730fcf2..35c6ff97cf29 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -28,7 +28,6 @@
>>>  #include <linux/mm_inline.h>
>>>  #include <linux/page_ext.h>
>>>  #include <linux/page_owner.h>
>>> -#include <linux/migrate.h>
>>>  
>>>  #include "internal.h"
>>>  
>>> @@ -2060,7 +2059,6 @@ static int vmstat_cpu_online(unsigned int cpu)
>>>  
>>>  	if (!node_state(cpu_to_node(cpu), N_CPU)) {
>>>  		node_set_state(cpu_to_node(cpu), N_CPU);
>>> -		set_migration_target_nodes();
>>>  	}
>> 
>> "{" and "}" can be removed too?
>> 
>
> I will update  the patch incorporating other changes you suggested.

Thanks!

Best Regards,
Huang, Ying
