Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936784F9B18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbiDHQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbiDHQzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C5B91C7E95
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649436743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pQHDOH1KaEIbfQ7nccmixqGK9w/qtHHrOI8LGKbJW4=;
        b=RtAPVBt4mWEUGy0yoSD1v4yu/vdLrAFTjyDEZQikRJ4kAU9T5IJ6LQmw67eEOxCHGgR8su
        y1c0ovkHQdeWbzCdFyBeJFAwmYL3Pk0abuguuRrEewBWz1pt5UfwaGrptxOQruY7aAD0El
        WWzbFk++zoWy25GcdYGZ074WjzeDp74=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-6kUmQGF3OYy53ruz_2-v0Q-1; Fri, 08 Apr 2022 12:52:22 -0400
X-MC-Unique: 6kUmQGF3OYy53ruz_2-v0Q-1
Received: by mail-wm1-f70.google.com with SMTP id c19-20020a05600c4a1300b0038e6b4a104cso6184570wmp.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 09:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+pQHDOH1KaEIbfQ7nccmixqGK9w/qtHHrOI8LGKbJW4=;
        b=CQxUnxWD1u7amQLyJBbZbEpcCmT/uI8/F3O6/0MRtmTF18+0hEq9GP5UjMxVnJQVbe
         VtLID1AEnRYcYHoLhAEMS2khrkybDvcUdybpTsgOzwi+RzZsl7a3aS+bKhnpruCr0TsX
         L1ig8Ghhh9409jLDdzOtjU6Ga1pslMbbzQuXecAfyy35juJYLOYTre/aOB/+S+g4b5hh
         3fYN98rmeQJlydfAvvzj5Vt0+yXo64ly3pI+YmF2aQy9TLq8bafPHucSOhAkLptZMgH2
         c+7IE0WpcXCcKjumnWdWzWT6UUKNc78Em1x2KkE3k7Ob8/cko/Rv8Nx9uPQO5P/Xhokk
         liSQ==
X-Gm-Message-State: AOAM532xvujo5aueJeob6Vx0lZ9XuSBb7iyL35VZHPd/KMskHr3CaGtn
        wwyAbrLTWLQR6QU2zZ//yc4imDQlheRxy92pmshL/629VlcCDOuSQKDiK5MXMoJhA4kQrMe+hze
        M1ZcxvxJF0eMZPtlQ5HcudLtC
X-Received: by 2002:a5d:44d0:0:b0:207:9ac8:2c3b with SMTP id z16-20020a5d44d0000000b002079ac82c3bmr1879723wrr.688.1649436741332;
        Fri, 08 Apr 2022 09:52:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHTSwJywcTNQxvDd+vdBIWveDs1PBhUSZT/I+wFz4QVunMpzvW2A6Mm8uLqRTgaM0orM5DMw==
X-Received: by 2002:a5d:44d0:0:b0:207:9ac8:2c3b with SMTP id z16-20020a5d44d0000000b002079ac82c3bmr1879708wrr.688.1649436741079;
        Fri, 08 Apr 2022 09:52:21 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b002058631cfacsm20578669wrf.61.2022.04.08.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:52:20 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Huang Ying <ying.huang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] sched,topology: Update sched topology atomically
In-Reply-To: <20220406070159.68111-1-ying.huang@intel.com>
References: <20220406070159.68111-1-ying.huang@intel.com>
Date:   Fri, 08 Apr 2022 17:52:08 +0100
Message-ID: <xhsmhczhrwm9z.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 06/04/22 15:01, Huang Ying wrote:
> When Peter Zijlstra reviewed commit 0fb3978b0aac ("sched/numa: Fix
> NUMA topology for systems with CPU-less nodes") [1], he pointed out
> that sched_domains_numa_distance and sched_domains_numa_masks are made
> separate RCU variables.  That could go side-ways if there were a
> function using both, although there isn't for now.
>
> So we update sched_domains_numa_distance and sched_domains_numa_masks
> and some other related sched topology parameters atomically to address
> the potential issues.
>
> [1] https://lkml.kernel.org/r/20220214121553.582248-1-ying.huang@intel.com
>

I had to re-acquaint myself with [1], but AFAICT this looks mostly
OK. Have some nits/comments below, I haven't actually tested this yet as
I'm still setting stuff up over here...

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/fair.c     |  47 ++++++---
>  kernel/sched/sched.h    |  14 ++-
>  kernel/sched/topology.c | 223 +++++++++++++++++++---------------------
>  3 files changed, 151 insertions(+), 133 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..546e7347fafc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1294,17 +1294,22 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
>                                       int lim_dist, bool task)
>  {
>       unsigned long score = 0;
> -	int node, max_dist;
> +	int node, max_dist, type;
> +	struct sched_numa_topology *topology;
> +
> +	rcu_read_lock();
> +	topology = rcu_dereference(sched_numa_topology);
> +	type = topology->type;
> +	max_dist = topology->max_distance;
> +	rcu_read_unlock();
>

One thing worth pointing out, the NUMA topology type *wasn't* RCU protected
previously, which I think we've been wanting since

  0083242c9375 ("sched/topology: Skip updating masks for non-online nodes")

(before then the topology was init'd once-and-for-all).

Another thing; this pattern is now repeated a handful of times in fair.c,
what about bundling it up? As a bonus it lets us keep the definition of
struct sched_numa_topology internal to topology.c:

void sched_fetch_numa_topology(int *type int *max_distance)
{
        struct sched_numa_topology __rcu *topology;

        rcu_read_lock();
        topology = rcu_dereference(sched_numa_topology);

        if (type)
                *type = topology->type;

        if (max_distance)
                *max_distance = topology->max_distance;


        rcu_read_unlock();
}

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 810750e62118..19523b23034f 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1483,14 +1483,10 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
>  }
>
>  #ifdef CONFIG_NUMA
> -enum numa_topology_type sched_numa_topology_type;
> +struct sched_numa_topology	default_numa_topology;

Shouldn't this be static?

> +struct sched_numa_topology	*sched_numa_topology = &default_numa_topology;

This should also be __rcu (sparse should complain about this)

>
> -static int			sched_domains_numa_levels;
>  static int			sched_domains_curr_level;
> -
> -int				sched_max_numa_distance;
> -static int			*sched_domains_numa_distance;
> -static struct cpumask		***sched_domains_numa_masks;
>  #endif
>
>  /*

> +static void sched_numa_topology_switch(struct sched_numa_topology *topology,
> +				       struct sched_domain_topology_level *tl)
> +{
> +	struct sched_numa_topology *old_topology = sched_numa_topology;
> +	struct sched_domain_topology_level *old_tl = sched_domain_topology;
> +
> +	rcu_assign_pointer(sched_numa_topology, topology);
> +	sched_domain_topology = tl;
> +
> +	if (old_topology == &default_numa_topology)
> +		return;
> +
> +	init_rcu_head(&old_topology->rcu);

I'm not familiar with this and I can find only a handful of users, should
we be doing that for struct sched_domain?

> +	call_rcu(&old_topology->rcu, sched_numa_topology_free_rcu);
> +	kfree(old_tl);
> +}
>
>  #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
>
>  void sched_init_numa(int offline_node)
>  {
>       struct sched_domain_topology_level *tl;
> -	unsigned long *distance_map;
> +	unsigned long *distance_map = NULL;
>       int nr_levels = 0;
>       int i, j;
> -	int *distances;
> -	struct cpumask ***masks;
> +	struct sched_numa_topology *topology;
> +
> +	topology = kzalloc(sizeof(*topology), GFP_KERNEL);
> +	if (!topology)
> +		goto err;
>
>       /*
>        * O(nr_nodes^2) deduplicating selection sort -- in order to find the

> +	return;
> +err:

I was expecting the "usual" multi-label setup, but this seems to be working
too - though not in the most obvious way ;)

> +	bitmap_free(distance_map);
> +	sched_numa_topology_free(topology);
> +	sched_numa_topology_switch(&default_numa_topology,
> +				   sched_domain_topology_default);
>  }
>
>  /*
> @@ -1981,7 +1977,6 @@ void sched_update_numa(int cpu, bool online)
>       if (cpumask_weight(cpumask_of_node(node)) != 1)
>               return;
>
> -	sched_reset_numa();
>       sched_init_numa(online ? NUMA_NO_NODE : node);
>  }
>
> @@ -1990,14 +1985,15 @@ void sched_domains_numa_masks_set(unsigned int cpu)
>       int node = cpu_to_node(cpu);
>       int i, j;
>
> -	for (i = 0; i < sched_domains_numa_levels; i++) {
> +	for (i = 0; i < sched_numa_topology->nr_levels; i++) {
>               for (j = 0; j < nr_node_ids; j++) {
>                       if (!node_state(j, N_CPU))
>                               continue;
>
>                       /* Set ourselves in the remote node's masks */
> -			if (node_distance(j, node) <= sched_domains_numa_distance[i])
> -				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
> +			if (node_distance(j, node) <=
> +			    sched_numa_topology->distances[i])
> +				cpumask_set_cpu(cpu, sched_numa_topology->masks[i][j]);

I'm guessing the assumption here is that this is done in
sched_cpu_{de,}activate(), so we have the hotplug lock and so the masks are
stable... Should we sprinkle in a lockdep_assert_cpus_held() for good
measure?

Having a second look at this, I think the same applies to your change to
sd_numa_mask() - those end up used in the domain rebuild which itself might
be deferred cpuset_hotplug_work, but that should still hold the hotplug
lock...

>               }
>       }
>  }
> @@ -2006,10 +2002,10 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
>  {
>       int i, j;
>
> -	for (i = 0; i < sched_domains_numa_levels; i++) {
> +	for (i = 0; i < sched_numa_topology->nr_levels; i++) {
>               for (j = 0; j < nr_node_ids; j++) {
> -			if (sched_domains_numa_masks[i][j])
> -				cpumask_clear_cpu(cpu, sched_domains_numa_masks[i][j]);
> +			if (sched_numa_topology->masks[i][j])
> +				cpumask_clear_cpu(cpu, sched_numa_topology->masks[i][j]);
>               }
>       }
>  }
> @@ -2025,22 +2021,19 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
>  int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
>  {
>       int i, j = cpu_to_node(cpu), found = nr_cpu_ids;
> -	struct cpumask ***masks;
> +	struct sched_numa_topology *topology;
>
>       rcu_read_lock();
> -	masks = rcu_dereference(sched_domains_numa_masks);
> -	if (!masks)
> -		goto unlock;
> -	for (i = 0; i < sched_domains_numa_levels; i++) {
> -		if (!masks[i][j])
> +	topology = rcu_dereference(sched_numa_topology);
> +	for (i = 0; i < topology->nr_levels; i++) {
> +		if (!topology->masks[i][j])

If I got default_numa_topology right and it's meant to be static,
sched_numa_topology->masks can still be NULL, but here this would be gated
by nr_levels being 0... Did I get that right?

>                       break;
> -		cpu = cpumask_any_and(cpus, masks[i][j]);
> +		cpu = cpumask_any_and(cpus, topology->masks[i][j]);
>               if (cpu < nr_cpu_ids) {
>                       found = cpu;
>                       break;
>               }
>       }
> -unlock:
>       rcu_read_unlock();
>
>       return found;
> --
> 2.30.2

