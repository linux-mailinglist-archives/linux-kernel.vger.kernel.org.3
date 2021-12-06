Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F6B469039
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 06:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbhLFFpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 00:45:32 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60388 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhLFFpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 00:45:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UzVm4kh_1638769301;
Received: from 30.21.164.44(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UzVm4kh_1638769301)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 Dec 2021 13:41:59 +0800
Message-ID: <93c73cd8-3551-5834-84e1-a263ef1b3fa2@linux.alibaba.com>
Date:   Mon, 6 Dec 2021 13:42:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] mm/migrate: move node demotion code to near its user
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Wei Xu <weixugc@google.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <20211206031227.3323097-1-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20211206031227.3323097-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/6 11:12, Huang Ying wrote:
> Now, node_demotion and next_demtion_node() is placed between
> __unmap_and_move() and unmap_and_move().  This hurts the code
> readability.  So, move it to near its user in the file.  There's no
> any functionality change in this patch.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/migrate.c | 265 +++++++++++++++++++++++++--------------------------
>   1 file changed, 132 insertions(+), 133 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c503ef1f4360..d487a399253b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1083,139 +1083,6 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>   	return rc;
>   }
>   
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
>   /*
>    * Obtain the lock on page, remove all ptes and migrate the page
>    * to the newly allocated page in newpage.
> @@ -3035,6 +2902,138 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
>   EXPORT_SYMBOL(migrate_vma_finalize);
>   #endif /* CONFIG_DEVICE_PRIVATE */
>   
> +/*
> + * node_demotion[] example:
> + *
> + * Consider a system with two sockets.  Each socket has
> + * three classes of memory attached: fast, medium and slow.
> + * Each memory class is placed in its own NUMA node.  The
> + * CPUs are placed in the node with the "fast" memory.  The
> + * 6 NUMA nodes (0-5) might be split among the sockets like
> + * this:
> + *
> + *	Socket A: 0, 1, 2
> + *	Socket B: 3, 4, 5
> + *
> + * When Node 0 fills up, its memory should be migrated to
> + * Node 1.  When Node 1 fills up, it should be migrated to
> + * Node 2.  The migration path start on the nodes with the
> + * processors (since allocations default to this node) and
> + * fast memory, progress through medium and end with the
> + * slow memory:
> + *
> + *	0 -> 1 -> 2 -> stop
> + *	3 -> 4 -> 5 -> stop
> + *
> + * This is represented in the node_demotion[] like this:
> + *
> + *	{  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
> + *	{  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
> + *	{  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
> + *	{  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
> + *	{  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
> + *	{  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
> + *
> + * Moreover some systems may have multiple slow memory nodes.
> + * Suppose a system has one socket with 3 memory nodes, node 0
> + * is fast memory type, and node 1/2 both are slow memory
> + * type, and the distance between fast memory node and slow
> + * memory node is same. So the migration path should be:
> + *
> + *	0 -> 1/2 -> stop
> + *
> + * This is represented in the node_demotion[] like this:
> + *	{ nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
> + *	{ nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
> + *	{ nr=0, nodes[0]=-1, }, // Node 2 does not migrate
> + */
> +
> +/*
> + * Writes to this array occur without locking.  Cycles are
> + * not allowed: Node X demotes to Y which demotes to X...
> + *
> + * If multiple reads are performed, a single rcu_read_lock()
> + * must be held over all reads to ensure that no cycles are
> + * observed.
> + */
> +#define DEFAULT_DEMOTION_TARGET_NODES 15
> +
> +#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
> +#define DEMOTION_TARGET_NODES	(MAX_NUMNODES - 1)
> +#else
> +#define DEMOTION_TARGET_NODES	DEFAULT_DEMOTION_TARGET_NODES
> +#endif
> +
> +struct demotion_nodes {
> +	unsigned short nr;
> +	short nodes[DEMOTION_TARGET_NODES];
> +};
> +
> +static struct demotion_nodes *node_demotion __read_mostly;
> +
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
> +	unsigned short target_nr, index;
> +	int target;
> +
> +	if (!node_demotion)
> +		return NUMA_NO_NODE;
> +
> +	nd = &node_demotion[node];
> +
> +	/*
> +	 * node_demotion[] is updated without excluding this
> +	 * function from running.  RCU doesn't provide any
> +	 * compiler barriers, so the READ_ONCE() is required
> +	 * to avoid compiler reordering or read merging.
> +	 *
> +	 * Make sure to use RCU over entire code blocks if
> +	 * node_demotion[] reads need to be consistent.
> +	 */
> +	rcu_read_lock();
> +	target_nr = READ_ONCE(nd->nr);
> +
> +	switch (target_nr) {
> +	case 0:
> +		target = NUMA_NO_NODE;
> +		goto out;
> +	case 1:
> +		index = 0;
> +		break;
> +	default:
> +		/*
> +		 * If there are multiple target nodes, just select one
> +		 * target node randomly.
> +		 *
> +		 * In addition, we can also use round-robin to select
> +		 * target node, but we should introduce another variable
> +		 * for node_demotion[] to record last selected target node,
> +		 * that may cause cache ping-pong due to the changing of
> +		 * last target node. Or introducing per-cpu data to avoid
> +		 * caching issue, which seems more complicated. So selecting
> +		 * target node randomly seems better until now.
> +		 */
> +		index = get_random_int() % target_nr;
> +		break;
> +	}
> +
> +	target = READ_ONCE(nd->nodes[index]);
> +
> +out:
> +	rcu_read_unlock();
> +	return target;
> +}
> +
>   #if defined(CONFIG_HOTPLUG_CPU)
>   /* Disable reclaim-based migration. */
>   static void __disable_all_migrate_targets(void)
> 
