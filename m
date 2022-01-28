Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2890549FEA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350457AbiA1RIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:08:23 -0500
Received: from foss.arm.com ([217.140.110.172]:54686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350436AbiA1RIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:08:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AEF7113E;
        Fri, 28 Jan 2022 09:08:18 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 597973F793;
        Fri, 28 Jan 2022 09:08:17 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Huang Ying <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/2] NUMA balancing: fix NUMA topology type for memory tiering system
In-Reply-To: <YfQGdqQy/VrEU32N@hirez.programming.kicks-ass.net>
References: <20220128023842.1946583-1-ying.huang@intel.com> <YfQGdqQy/VrEU32N@hirez.programming.kicks-ass.net>
Date:   Fri, 28 Jan 2022 17:08:12 +0000
Message-ID: <87sft7okjn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/22 16:06, Peter Zijlstra wrote:
> On Fri, Jan 28, 2022 at 10:38:41AM +0800, Huang Ying wrote:
>>  kernel/sched/topology.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 9f26e6b651fe..ba975a29d444 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1738,7 +1738,13 @@ void init_numa_topology_type(void)
>>      }
>>
>>      for_each_online_node(a) {
>> +		if (!node_state(a, N_CPU))
>> +			continue;
>> +
>>              for_each_online_node(b) {
>> +			if (!node_state(b, N_CPU))
>> +				continue;
>> +
>>                      /* Find two nodes furthest removed from each other. */
>>                      if (node_distance(a, b) < n)
>>                              continue;
>
> I think you forgot some.. by not skipping CPU-less nodes in
> sched_init_numa() the whole premise of init_numa_topology_type() goes
> out the window as well, by virtue of getting sched_domains_numa_levels
> and sched_max_numa_distance wrong.
>
> Did I get them all?
>

On the topology.c side of things I think so, but I'm thinking
score_nearby_nodes() and preferred_group_nid() would need some updating as
well.

> Do we want something like:
>
> #define for_each_possible_cpu_node(n)	for (n = 0; n < nr_node_ids; n++) if (!node_state(n, N_CPU)) continue; else
> #define for_each_online_cpu_node(n)	for_each_online_node(n) if (!node_state(n, N_CPU)) continue; else
>
> To clean that up?
>

Looks reasonable!

> ---
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1684,8 +1684,12 @@ static void sched_numa_warn(const char *
>
>       for (i = 0; i < nr_node_ids; i++) {
>               printk(KERN_WARNING "  ");
> -		for (j = 0; j < nr_node_ids; j++)
> -			printk(KERN_CONT "%02d ", node_distance(i,j));
> +		for (j = 0; j < nr_node_ids; j++) {
> +			if (!node_state(i, N_CPU) || !node_state(j, N_CPU))
> +				printk(KERN_CONT "(%02d) ", node_distance(i,j));
> +			else
> +				printk(KERN_CONT " %02d  ", node_distance(i,j));
> +		}
>               printk(KERN_CONT "\n");
>       }
>       printk(KERN_WARNING "\n");
> @@ -1737,7 +1741,13 @@ static void init_numa_topology_type(void
>       }
>
>       for_each_online_node(a) {
> +		if (!node_state(a, N_CPU))
> +			continue;
> +
>               for_each_online_node(b) {
> +			if (!node_state(b, N_CPU))
> +				continue;
> +
>                       /* Find two nodes furthest removed from each other. */
>                       if (node_distance(a, b) < n)
>                               continue;
> @@ -1756,6 +1766,9 @@ static void init_numa_topology_type(void
>                       return;
>               }
>       }
> +
> +	pr_err("Failed to find a NUMA topology type, defaulting to DIRECT\n");
> +	sched_numa_topology_type = NUMA_DIRECT;
>  }
>
>
> @@ -1778,9 +1791,15 @@ void sched_init_numa(void)
>
>       bitmap_zero(distance_map, NR_DISTANCE_VALUES);
>       for (i = 0; i < nr_node_ids; i++) {
> +		if (!node_state(i, N_CPU))
> +			continue;
> +
>               for (j = 0; j < nr_node_ids; j++) {
>                       int distance = node_distance(i, j);
>
> +			if (!node_state(j, N_CPU))
> +				continue;
> +
>                       if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
>                               sched_numa_warn("Invalid distance value range");
>                               return;
> @@ -1863,6 +1882,12 @@ void sched_init_numa(void)
>                               if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
>                                       sched_numa_warn("Node-distance not symmetric");
>
> +				if (!node_state(j, N_CPU))
> +					continue;
> +
> +				if (!node_state(j, N_CPU))
> +					continue;
> +
>                               if (node_distance(j, k) > sched_domains_numa_distance[i])
>                                       continue;
>
> @@ -1943,6 +1968,9 @@ static void __sched_domains_numa_masks_s
>                       if (!node_online(j) || node == j)
>                               continue;
>
> +			if (!node_state(j, N_CPU))
> +				continue;
> +
>                       if (node_distance(j, node) > sched_domains_numa_distance[i])
>                               continue;
>
> @@ -1974,6 +2002,9 @@ void sched_domains_numa_masks_set(unsign
>                       if (!node_online(j))
>                               continue;
>
> +			if (!node_state(j, N_CPU))
> +				continue;
> +
>                       /* Set ourselves in the remote node's masks */
>                       if (node_distance(j, node) <= sched_domains_numa_distance[i])
>                               cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
