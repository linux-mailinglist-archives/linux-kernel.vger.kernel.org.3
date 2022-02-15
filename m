Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549934B6003
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiBOB3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:29:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiBOB3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:29:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE0C127575
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644888546; x=1676424546;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=gF3omRklS4uEw1nEm28dd+ajqp8On37QUsKJ0NVumJE=;
  b=SMh2mc2Q10nASSlC76gwjCx6rx4JxctR6g5qBAZPoMp8ypfCm0GdcIXk
   lrfC8l3PIXt/yfXxkHGqyTDaotmJEYyzB8W/7BTjcjLelLANQhr8W6vNS
   548JarAj6Vj8JV12gHGp5NNouy3G3uvcxJaaCY1wAsfq4yzdgD5CjJ22M
   HRHWbmhVWYOC5J7DH0QXEgp1dqTaxEM2EVd8wiLhQP6xkxx1D+5B4hXnC
   XeukSNbRvHIfkrC2uqViEcAhf4BAsoAyvWZooi07b25jjiU/BAyP6TjSL
   xRZYuwkFvOaz2HtsSyLQIgCkse3pe6d4tqW3hIuZnl1jxwANGudl9DPoN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336652098"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="336652098"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:29:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="496523918"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:29:04 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 1/2] NUMA balancing: fix NUMA topology for systems
 with CPU-less nodes
References: <20220214121553.582248-1-ying.huang@intel.com>
        <YgpvyE7oV1lZDRQL@hirez.programming.kicks-ass.net>
Date:   Tue, 15 Feb 2022 09:29:02 +0800
In-Reply-To: <YgpvyE7oV1lZDRQL@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 14 Feb 2022 16:05:44 +0100")
Message-ID: <87mtisgboh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Feb 14, 2022 at 08:15:52PM +0800, Huang Ying wrote:
>
>> This isn't a practical problem now yet.  Because the PMEM nodes (node
>> 2 and node 3 in example system) are offlined by default during system
>> boot.  So init_numa_topology_type() called during system boot will
>> ignore them and set sched_numa_topology_type to NUMA_DIRECT.  And
>> init_numa_topology_type() is only called at runtime when a CPU of a
>> never-onlined-before node gets plugged in.  And there's no CPU in the
>> PMEM nodes.  But it appears better to fix this to make the code more
>> robust.
>
> IIRC there are pre-existing issues with this; namely the distance_map is
> created for all nodes, online or not, therefore the levels and
> max_distance include the pmem stuff.
>
> At the same time, the numa_topolog_type() uses those values, and the
> only reason it 'worked' is because the combination of arguments fails to
> hit any of the existing types and exits without setting a type,
> defaulting to NUMA_DIRECT by 'accident' of that being type 0 and
> bss/data being 0 initialized.
>
> Also, Power (and possibly other architectures) already have CPU-less
> nodes and are similarly suffering issues.
>
> Anyway, aside from this the patches look like they should do.
>
> There's a few niggles, like using READ_ONCE() on sched_max_numa_distance
> without using WRITE_ONCE() (see below) and having
> sched_domains_numa_distance and sched_domains_numa_masks separate RCU
> variables (that could go side-ways if there were a function using both,
> afaict there isn't and I couldn't be bothered changing that, but it's
> something to keep in mind).

If you think that's necessary, I can work on it with a follow up patch.

> I'll go queue these, thanks!

Thanks!

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1259,11 +1259,10 @@ static bool numa_is_active_node(int nid,
>  
>  /* Handle placement on systems where not all nodes are directly connected. */
>  static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
> -					int maxdist, bool task)
> +					int lim_dist, bool task)
>  {
>  	unsigned long score = 0;
> -	int node;
> -	int sys_max_dist;
> +	int node, max_dist;
>  
>  	/*
>  	 * All nodes are directly connected, and the same distance
> @@ -1273,7 +1272,7 @@ static unsigned long score_nearby_nodes(
>  		return 0;
>  
>  	/* sched_max_numa_distance may be changed in parallel. */
> -	sys_max_dist = READ_ONCE(sched_max_numa_distance);
> +	max_dist = READ_ONCE(sched_max_numa_distance);
>  	/*
>  	 * This code is called for each node, introducing N^2 complexity,
>  	 * which should be ok given the number of nodes rarely exceeds 8.
> @@ -1286,7 +1285,7 @@ static unsigned long score_nearby_nodes(
>  		 * The furthest away nodes in the system are not interesting
>  		 * for placement; nid was already counted.
>  		 */
> -		if (dist >= sys_max_dist || node == nid)
> +		if (dist >= max_dist || node == nid)
>  			continue;
>  
>  		/*
> @@ -1296,8 +1295,7 @@ static unsigned long score_nearby_nodes(
>  		 * "hoplimit", only nodes closer by than "hoplimit" are part
>  		 * of each group. Skip other nodes.
>  		 */
> -		if (sched_numa_topology_type == NUMA_BACKPLANE &&
> -					dist >= maxdist)
> +		if (sched_numa_topology_type == NUMA_BACKPLANE && dist >= lim_dist)
>  			continue;
>  
>  		/* Add up the faults from nearby nodes. */
> @@ -1315,8 +1313,8 @@ static unsigned long score_nearby_nodes(
>  		 * This seems to result in good task placement.
>  		 */
>  		if (sched_numa_topology_type == NUMA_GLUELESS_MESH) {
> -			faults *= (sys_max_dist - dist);
> -			faults /= (sys_max_dist - LOCAL_DISTANCE);
> +			faults *= (max_dist - dist);
> +			faults /= (max_dist - LOCAL_DISTANCE);
>  		}
>  
>  		score += faults;
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1927,7 +1927,7 @@ void sched_init_numa(int offline_node)
>  	sched_domain_topology = tl;
>  
>  	sched_domains_numa_levels = nr_levels;
> -	sched_max_numa_distance = sched_domains_numa_distance[nr_levels - 1];
> +	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
>  
>  	init_numa_topology_type(offline_node);
>  }

Sorry, 0-Day building robot reported another small issue, can you fold
the following patch too?

Best Regards,
Huang, Ying

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 490acd4b835d..d72128151e56 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1947,7 +1947,7 @@ void sched_init_numa(int offline_node)
 		sched_max_numa_distance);
 }
 
-void sched_reset_numa(void)
+static void sched_reset_numa(void)
 {
 	int nr_levels, *distances;
 	struct cpumask ***masks;
-- 
2.30.2

