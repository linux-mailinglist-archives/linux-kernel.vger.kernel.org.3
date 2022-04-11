Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26894FB6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344104AbiDKJDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbiDKJDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:03:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34173EF1F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649667676; x=1681203676;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qLC1HEPbn1civm12DwPQxECjtowdSarXfU/xg6s5sL0=;
  b=hrmSKVvqMxywVI+3kNV877ZV8WsbA6efX/oWD5bWhG3CWrRKUB7O03zW
   PkC+Y1K2bCSfhZu8qZtJHfiP/iGpF924NcnkSxJHsgExTLinNSOJVmiK4
   yGi85QAxJ0yNO5lPedMx2JQH8iXVJQ/HMzwV0GFKPWRJSKxxDKPUqxoal
   K6dl/tEotxqOt0iHd51qOqTdWzLbdVGtALzBJXSlFL2fBLLEKX5ajN1uP
   7SW+DcIRoZKHqGaF7HBw0QvgDfk/gjvO3dv6CI07m68oiETMNsWElESo+
   fD2s34gzP1iY5MQeWJJiRat9CQbEioyRzNkow2oJXWZ1Z/0tPLeDD+Go9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="348508673"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="348508673"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:01:15 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572037302"
Received: from leichu-mobl1.ccr.corp.intel.com ([10.254.213.5])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:01:12 -0700
Message-ID: <78d7993a35e2895894d3a0e2deb1deb78c9ee568.camel@intel.com>
Subject: Re: [PATCH] sched,topology: Update sched topology atomically
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Date:   Mon, 11 Apr 2022 17:01:10 +0800
In-Reply-To: <xhsmhczhrwm9z.mognet@vschneid.remote.csb>
References: <20220406070159.68111-1-ying.huang@intel.com>
         <xhsmhczhrwm9z.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Valentin,

Thanks a lot for review!

On Fri, 2022-04-08 at 17:52 +0100, Valentin Schneider wrote:
> 
> Hi,
> 
> On 06/04/22 15:01, Huang Ying wrote:
> > When Peter Zijlstra reviewed commit 0fb3978b0aac ("sched/numa: Fix
> > NUMA topology for systems with CPU-less nodes") [1], he pointed out
> > that sched_domains_numa_distance and sched_domains_numa_masks are made
> > separate RCU variables.  That could go side-ways if there were a
> > function using both, although there isn't for now.
> > 
> > So we update sched_domains_numa_distance and sched_domains_numa_masks
> > and some other related sched topology parameters atomically to address
> > the potential issues.
> > 
> > [1]  https://lkml.kernel.org/r/20220214121553.582248-1-
> > ying.huang@intel.com
> > 
> 
> I had to re-acquaint myself with [1], but AFAICT this looks mostly
> OK. Have some nits/comments below, I haven't actually tested this yet as
> I'm still setting stuff up over here...
> 
> > Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> >  kernel/sched/fair.c     |  47 ++++++---
> >  kernel/sched/sched.h    |  14 ++-
> >  kernel/sched/topology.c | 223 +++++++++++++++++++---------------------
> >  3 files changed, 151 insertions(+), 133 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d4bd299d67ab..546e7347fafc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1294,17 +1294,22 @@ static unsigned long score_nearby_nodes(struct
> > task_struct *p, int nid,
> >                                       int lim_dist, bool task)
> >  {
> >       unsigned long score = 0;
> > -       int node, max_dist;
> > +       int node, max_dist, type;
> > +       struct sched_numa_topology *topology;
> > +
> > +       rcu_read_lock();
> > +       topology = rcu_dereference(sched_numa_topology);
> > +       type = topology->type;
> > +       max_dist = topology->max_distance;
> > +       rcu_read_unlock();
> > 
> 
> One thing worth pointing out, the NUMA topology type *wasn't* RCU protected
> previously, which I think we've been wanting since
> 
>   0083242c9375 ("sched/topology: Skip updating masks for non-online nodes")
> 
> (before then the topology was init'd once-and-for-all).
> 
> Another thing; this pattern is now repeated a handful of times in fair.c,
> what about bundling it up? As a bonus it lets us keep the definition of
> struct sched_numa_topology internal to topology.c:
> 
> void sched_fetch_numa_topology(int *type int *max_distance)
> {
>         struct sched_numa_topology __rcu *topology;
> 
>         rcu_read_lock();
>         topology = rcu_dereference(sched_numa_topology);
> 
>         if (type)
>                 *type = topology->type;
> 
>         if (max_distance)
>                 *max_distance = topology->max_distance;
> 
> 
>         rcu_read_unlock();
> }
> 

This looks good.  Will use it in the next version.  Thanks!

> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 810750e62118..19523b23034f 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -1483,14 +1483,10 @@ static void claim_allocations(int cpu, struct
> > sched_domain *sd)
> >  }
> > 
> >  #ifdef CONFIG_NUMA
> > -enum numa_topology_type sched_numa_topology_type;
> > +struct sched_numa_topology     default_numa_topology;
> 
> Shouldn't this be static?

Yes.  Will change it in the next version.

> > +struct sched_numa_topology     *sched_numa_topology =
> > &default_numa_topology;
> 
> This should also be __rcu (sparse should complain about this)

Yes.  Will change it in the next version.

> > 
> > -static int                     sched_domains_numa_levels;
> >  static int                     sched_domains_curr_level;
> > -
> > -int                            sched_max_numa_distance;
> > -static int                     *sched_domains_numa_distance;
> > -static struct cpumask          ***sched_domains_numa_masks;
> >  #endif
> > 
> >  /*
> 
> > +static void sched_numa_topology_switch(struct sched_numa_topology
> > *topology,
> > +                                      struct sched_domain_topology_level
> > *tl)
> > +{
> > +       struct sched_numa_topology *old_topology = sched_numa_topology;
> > +       struct sched_domain_topology_level *old_tl =
> > sched_domain_topology;
> > +
> > +       rcu_assign_pointer(sched_numa_topology, topology);
> > +       sched_domain_topology = tl;
> > +
> > +       if (old_topology == &default_numa_topology)
> > +               return;
> > +
> > +       init_rcu_head(&old_topology->rcu);
> 
> I'm not familiar with this and I can find only a handful of users, should
> we be doing that for struct sched_domain?

Per my understanding, this is for debug and we should call it before
call_rcu().  Copying Paul for confirmation.

> 
> > +       call_rcu(&old_topology->rcu, sched_numa_topology_free_rcu);
> > +       kfree(old_tl);
> > +}
> > 
> >  #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
> > 
> >  void sched_init_numa(int offline_node)
> >  {
> >       struct sched_domain_topology_level *tl;
> > -       unsigned long *distance_map;
> > +       unsigned long *distance_map = NULL;
> >       int nr_levels = 0;
> >       int i, j;
> > -       int *distances;
> > -       struct cpumask ***masks;
> > +       struct sched_numa_topology *topology;
> > +
> > +       topology = kzalloc(sizeof(*topology), GFP_KERNEL);
> > +       if (!topology)
> > +               goto err;
> > 
> >       /*
> >        * O(nr_nodes^2) deduplicating selection sort -- in order to find
> > the
> 
> > +       return;
> > +err:
> 
> I was expecting the "usual" multi-label setup, but this seems to be working
> too - though not in the most obvious way ;)

OK.  Will try to convert it to multi-label.

> 
> > +       bitmap_free(distance_map);
> > +       sched_numa_topology_free(topology);
> > +       sched_numa_topology_switch(&default_numa_topology,
> > +                                  sched_domain_topology_default);
> >  }
> > 
> >  /*
> > @@ -1981,7 +1977,6 @@ void sched_update_numa(int cpu, bool online)
> >       if (cpumask_weight(cpumask_of_node(node)) != 1)
> >               return;
> > 
> > -       sched_reset_numa();
> >       sched_init_numa(online ? NUMA_NO_NODE : node);
> >  }
> > 
> > @@ -1990,14 +1985,15 @@ void sched_domains_numa_masks_set(unsigned int
> > cpu)
> >       int node = cpu_to_node(cpu);
> >       int i, j;
> > 
> > -       for (i = 0; i < sched_domains_numa_levels; i++) {
> > +       for (i = 0; i < sched_numa_topology->nr_levels; i++) {
> >               for (j = 0; j < nr_node_ids; j++) {
> >                       if (!node_state(j, N_CPU))
> >                               continue;
> > 
> >                       /* Set ourselves in the remote node's masks */
> > -                       if (node_distance(j, node) <=
> > sched_domains_numa_distance[i])
> > -                               cpumask_set_cpu(cpu,
> > sched_domains_numa_masks[i][j]);
> > +                       if (node_distance(j, node) <=
> > +                           sched_numa_topology->distances[i])
> > +                               cpumask_set_cpu(cpu, sched_numa_topology-
> > >masks[i][j]);
> will be 0 
> I'm guessing the assumption here is that this is done in
> sched_cpu_{de,}activate(), so we have the hotplug lock and so the masks are
> stable... Should we sprinkle in a lockdep_assert_cpus_held() for good
> measure?
> 
> Having a second look at this, I think the same applies to your change to
> sd_numa_mask() - those end up used in the domain rebuild which itself might
> be deferred cpuset_hotplug_work, but that should still hold the hotplug
> lock...

Yes. hotplug lock needs to be held in these places.  Will add
lockdep_assert_cpus_held() in necessary places.

> >               }
> >       }
> >  }
> > @@ -2006,10 +2002,10 @@ void sched_domains_numa_masks_clear(unsigned int
> > cpu)
> >  {
> >       int i, j;
> > 
> > -       for (i = 0; i < sched_domains_numa_levels; i++) {
> > +       for (i = 0; i < sched_numa_topology->nr_levels; i++) {
> >               for (j = 0; j < nr_node_ids; j++) {
> > -                       if (sched_domains_numa_masks[i][j])
> > -                               cpumask_clear_cpu(cpu,
> > sched_domains_numa_masks[i][j]);
> > +                       if (sched_numa_topology->masks[i][j])
> > +                               cpumask_clear_cpu(cpu,
> > sched_numa_topology->masks[i][j]);
> >               }
> >       }
> >  }
> > @@ -2025,22 +2021,19 @@ void sched_domains_numa_masks_clear(unsigned int
> > cpu)
> >  int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
> >  {
> >       int i, j = cpu_to_node(cpu), found = nr_cpu_ids;
> > -       struct cpumask ***masks;
> > +       struct sched_numa_topology *topology;
> > 
> >       rcu_read_lock();
> > -       masks = rcu_dereference(sched_domains_numa_masks);
> > -       if (!masks)
> > -               goto unlock;
> > -       for (i = 0; i < sched_domains_numa_levels; i++) {
> > -               if (!masks[i][j])
> > +       topology = rcu_dereference(sched_numa_topology);
> > +       for (i = 0; i < topology->nr_levels; i++) {
> > +               if (!topology->masks[i][j])
> 
> If I got default_numa_topology right and it's meant to be static,
> sched_numa_topology->masks can still be NULL, but here this would be gated
> by nr_levels being 0... Did I get that right?

Yes. nr_levels in default_numa_topology is 0.

> 
> >                       break;
> > -               cpu = cpumask_any_and(cpus, masks[i][j]);
> > +               cpu = cpumask_any_and(cpus, topology->masks[i][j]);
> >               if (cpu < nr_cpu_ids) {
> >                       found = cpu;
> >                       break;
> >               }
> >       }
> > -unlock:
> >       rcu_read_unlock();
> > 
> >       return found;
> > --
> > 2.30.2
> 

Best Regards,
Huang, Ying


