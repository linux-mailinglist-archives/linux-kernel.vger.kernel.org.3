Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A794EAD15
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiC2M1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiC2M06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:26:58 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE134D637
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:25:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V8Z.XYI_1648556711;
Received: from 30.0.141.87(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V8Z.XYI_1648556711)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Mar 2022 20:25:11 +0800
Message-ID: <b7d1ab3b-e92c-d3aa-72cb-b80cc1a61e85@linux.alibaba.com>
Date:   Tue, 29 Mar 2022 20:26:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220329115222.8923-1-jvgediya@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagdish,

On 3/29/2022 7:52 PM, Jagdish Gediya wrote:
> The current implementation to identify the demotion
> targets limits some of the opportunities to share
> the demotion targets between multiple source nodes.
> 
> Implement a logic to identify the loop in the demotion
> targets such that all the possibilities of demotion can
> be utilized. Don't share the used targets between all
> the nodes, instead create the used targets from scratch
> for each individual node based on for what all node this
> node is a demotion target. This helps to share the demotion
> targets without missing any possible way of demotion.
> 
> e.g. with below NUMA topology, where node 0 & 1 are
> cpu + dram nodes, node 2 & 3 are equally slower memory
> only nodes, and node 4 is slowest memory only node,
> 
> available: 5 nodes (0-4)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus: 2 3
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus:
> node 2 size: n MB
> node 2 free: n MB
> node 3 cpus:
> node 3 size: n MB
> node 3 free: n MB
> node 4 cpus:
> node 4 size: n MB
> node 4 free: n MB
> node distances:
> node   0   1   2   3   4
>    0:  10  20  40  40  80
>    1:  20  10  40  40  80
>    2:  40  40  10  40  80
>    3:  40  40  40  10  80
>    4:  80  80  80  80  10
> 
> The existing implementation gives below demotion targets,
> 
> node    demotion_target
>   0              3, 2
>   1              4
>   2              X
>   3              X
>   4		X
> 
> With this patch applied, below are the demotion targets,
> 
> node    demotion_target
>   0              3, 2
>   1              3, 2
>   2              3
>   3              4
>   4		X

Node 2 and node 3 both are slow memory and have same distance, why node 
2 should demote cold memory to node 3? They should have the same target 
demotion node 4, which is the slowest memory node, right?

> 
> e.g. with below NUMA topology, where node 0, 1 & 2 are
> cpu + dram nodes and node 3 is slow memory node,
> 
> available: 4 nodes (0-3)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus: 2 3
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 4 5
> node 2 size: n MB
> node 2 free: n MB
> node 3 cpus:
> node 3 size: n MB
> node 3 free: n MB
> node distances:
> node   0   1   2   3
>    0:  10  20  20  40
>    1:  20  10  20  40
>    2:  20  20  10  40
>    3:  40  40  40  10
> 
> The existing implementation gives below demotion targets,
> 
> node    demotion_target
>   0              3
>   1              X
>   2              X
>   3              X
> 
> With this patch applied, below are the demotion targets,
> 
> node    demotion_target
>   0              3
>   1              3
>   2              3
>   3              X

Sounds reasonable.

> 
> with below NUMA topology, where node 0 & 2 are cpu + dram
> nodes and node 1 & 3 are slow memory nodes,
> 
> available: 4 nodes (0-3)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus:
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 2 3
> node 2 size: n MB
> node 2 free: n MB
> node 3 cpus:
> node 3 size: n MB
> node 3 free: n MB
> node distances:
> node   0   1   2   3
>    0:  10  40  20  80
>    1:  40  10  80  80
>    2:  20  80  10  40
>    3:  80  80  40  10
> 
> The existing implementation gives below demotion targets,
> 
> node    demotion_target
>   0              3
>   1              X
>   2              3
>   3              X

If I understand correctly, this is not true. The demotion route should 
be as below with existing implementation:
node 0 ---> node 1
node 1 ---> X
node 2 ---> node 3
node 3 ---> X

> 
> With this patch applied, below are the demotion targets,
> 
> node    demotion_target
>   0              1
>   1              3
>   2              3
>   3              X
> 
> As it can be seen above, node 3 can be demotion target for node
> 1 but existing implementation doesn't configure it that way. It
> is better to move pages from node 1 to node 3 instead of moving
> it from node 1 to swap.

Which means node 3 is the slowest memory node?

> 
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   mm/migrate.c | 75 ++++++++++++++++++++++++++++------------------------
>   1 file changed, 41 insertions(+), 34 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 3d60823afd2d..7ec8d934e706 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2381,10 +2381,13 @@ static int establish_migrate_target(int node, nodemask_t *used,
>    */
>   static void __set_migration_target_nodes(void)
>   {
> -	nodemask_t next_pass	= NODE_MASK_NONE;
> -	nodemask_t this_pass	= NODE_MASK_NONE;
>   	nodemask_t used_targets = NODE_MASK_NONE;
>   	int node, best_distance;
> +	nodemask_t *src_nodes;
> +
> +	src_nodes = kcalloc(nr_node_ids, sizeof(nodemask_t), GFP_KERNEL);
> +	if (!src_nodes)
> +		return;
>   
>   	/*
>   	 * Avoid any oddities like cycles that could occur
> @@ -2393,29 +2396,39 @@ static void __set_migration_target_nodes(void)
>   	 */
>   	disable_all_migrate_targets();
>   
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
> +	for_each_online_node(node) {
> +		int tmp_node;
>   
> -	for_each_node_mask(node, this_pass) {
>   		best_distance = -1;
> +		used_targets = NODE_MASK_NONE;
> +
> +		/*
> +		 * Avoid adding same node as the demotion target.
> +		 */
> +		node_set(node, used_targets);
> +
> +		/*
> +		 * Add CPU NUMA nodes to the used target list so that it
> +		 * won't be considered a demotion target.
> +		 */
> +		nodes_or(used_targets, used_targets, node_states[N_CPU]);
> +
> +		/*
> +		 * Add all nodes that has appeared as source node of demotion
> +		 * for this target node.
> +		 *
> +		 * To avoid cycles in the migration "graph", ensure
> +		 * that migration sources are not future targets by
> +		 * setting them in 'used_targets'.
> +		 */
> +		for_each_node_mask(tmp_node, src_nodes[node])
> +			nodes_or(used_targets, used_targets, src_nodes[tmp_node]);
> +
> +		/*
> +		 * Now update the demotion src nodes with other nodes in graph
> +		 * which got computed above.
> +		 */
> +		nodes_or(src_nodes[node], src_nodes[node], used_targets);
>   
>   		/*
>   		 * Try to set up the migration path for the node, and the target
> @@ -2434,20 +2447,14 @@ static void __set_migration_target_nodes(void)
>   				best_distance = node_distance(node, target_node);
>   
>   			/*
> -			 * Visit targets from this pass in the next pass.
> -			 * Eventually, every node will have been part of
> -			 * a pass, and will become set in 'used_targets'.
> +			 * Add this node in the src_nodes list so that we can
> +			 * detect the looping.
>   			 */
> -			node_set(target_node, next_pass);
> +			node_set(node, src_nodes[target_node]);
>   		} while (1);
>   	}
> -	/*
> -	 * 'next_pass' contains nodes which became migration
> -	 * targets in this pass.  Make additional passes until
> -	 * no more migrations targets are available.
> -	 */
> -	if (!nodes_empty(next_pass))
> -		goto again;
> +
> +	kfree(src_nodes);
>   }
>   
>   /*
