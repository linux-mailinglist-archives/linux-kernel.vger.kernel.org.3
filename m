Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF134AD17A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347233AbiBHGYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347211AbiBHGX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:23:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E363DC0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644301438; x=1675837438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ksyO/XG5S1TxmLSoEC+63z4jbzmugGgFwBxu1yWpqGM=;
  b=MFC+HsXvApF4DY80j4LqjE9nrXbYQvfw9E7LlcZBbNg2qsbVAGe0PTYs
   YyGA+lpTkRmOEgdMgibB4CE6l9XG5Y4LjJHH45xPLx+1HfRaMyWbuda7w
   HeYQJHLONrE9LsMu2qccfX1oc2XE7vTHvFnq4IVT76PpU6XUyyI95wYDT
   zCHjerUjyF04GS1ejpki84wC4ektdUxTjne/Q1yhbYVVyhlM98maQPwFb
   mon+iYiKlOkPXOQZig5n3YC49aVTRyak1X+GnzlIdh5Bj3APuSE3cbL3G
   FKlfAzBgyvl2moil43n1JzCpWsQMk2K9WLhaKPGL/j/NqETz8+jZV42N3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="312180471"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="312180471"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:23:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540463409"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:23:54 -0800
Date:   Tue, 8 Feb 2022 14:24:08 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH][RFC] sched: Stop searching for idle cpu if the LLC
 domain is overloaded
Message-ID: <20220208062408.GA621121@chenyu-desktop>
References: <20220207034013.599214-1-yu.c.chen@intel.com>
 <20220207135253.GF23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207135253.GF23216@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 02:52:53PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 07, 2022 at 11:40:13AM +0800, Chen Yu wrote:
> > It would be ideal to have a crystal ball to predict the success rate
> > of finding an idle cpu/core in the LLC. If it is doomed to fail,
> > there is no need to search in the LLC domain. There are many potential
> > metrics which could be used to predict the success rate. And the
> > metric should be carefully chosen that, it should help reduce the
> > unnecessary cpu runqueue scan, but meanwhile not give up the opportunity
> > to find an idle cpu.
> > 
> > Choose average cpu utilization as the candidate, since the util_avg is
> > a metric of accumulated historic activity, which seems to be more accurate
> > than instantaneous metrics(such as rq->nr_running) on calculating the probability
> > of find an idle cpu. Only when the average cpu utilization has reaches
> > 85% of the total cpu capacity, this domain is regarded as overloaded.
> > The reason to choose 85% is that, this is the threshold of an overloaded
> > LLC sched group(imbalance_pct = 117, threshold = 100 / 117 * 100%).
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 5146163bfabb..1a58befe892d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> 
> > @@ -6280,6 +6281,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >  	if (!this_sd)
> >  		return -1;
> >  
> > +	sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> > +	if (sd_share && READ_ONCE(sd_share->overloaded))
> > +		return -1;
> > +
> >  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >  
> >  	if (sched_feat(SIS_PROP) && !has_idle_core) {
> 
> > @@ -9268,6 +9275,29 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> >  		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
> >  		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
> >  	}
> > +
> > +	/*
> > +	 * Check if the LLC domain is overloaded. The overload hint
> > +	 * could be used to skip the LLC domain idle cpu search in
> > +	 * select_idle_cpu(). The update of this hint occurs during
> > +	 * periodic load balancing, rather than frequent newidle balance.
> > +	 */
> > +	if (env->idle != CPU_NEWLY_IDLE &&
> > +	    env->sd->span_weight == per_cpu(sd_llc_size, env->dst_cpu)) {
> > +		struct sched_domain_shared *sd_share =
> > +			rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
> > +
> > +		if (!sd_share)
> > +			return;
> > +
> > +		/*
> > +		 * Derived from group_is_overloaded(). The default imbalance_pct
> > +		 * is 117 on LLC domain, which means the threshold of average
> > +		 * utilization is 85%.
> > +		 */
> > +		WRITE_ONCE(sd_share->overloaded, (sds->total_capacity * 100) <
> > +			   (sum_util * env->sd->imbalance_pct));
> > +	}
> >  }
> 
> So the only problem I have with this is that this is somewhat of a
> binary toggle. The moment we hit that magical 85% we suddenly change
> behaviour.
> 
> Would it not be possible to replace the SIS_PROP logic with something
> based on this sum_util metric? Such that when sum_util is very low we
> scan more, while when sum_util hits 85% we naturally stop scanning
> entirely.
> 
> That way the behaviour is gradual.
Ok, let me do some evaluation on this, maybe something like nr_to_scan = f(sum_util)

thanks,
Chenyu
