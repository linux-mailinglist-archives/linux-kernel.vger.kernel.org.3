Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748E04AC0F6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388960AbiBGOTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389690AbiBGNx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:53:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C63AC0401D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WdC5enyHEX5cT/Hdfk7cPIpuNF5Us7feBKn0FjxV/qc=; b=r05eC816PeaQpyvcJPj2dEiDH2
        5LMXZxa3ZeUW7LtOAkjdj70S38uFdsMEyJTWoSvwxIHdxhngjbKVOm3n8nMCKAN0kdqiQiGTYKRDZ
        NdZe8/0ekqnxzUHGbTjRFjTw48tgR7X/5SbJT1n1rAAueRFhJb4/CKoGnyrW5tzpF6fwO0haElQSi
        Mn07u+JZdJTZFZqje+vDb+BqAXdJSn4AYR31fNhzsAH1YAaDa5xcfENZPG93UruRBwGCwI8Lyfq2u
        +OQY7wZ0TPlJFEYHyOdne8qSiPnUkHURxAX02ae6g2M9sHY0bDUrd/T+UpsQgOXlsIsCWoEIiRL4s
        Jp/sKX2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nH4Rq-0011kd-Om; Mon, 07 Feb 2022 13:52:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FD02986235; Mon,  7 Feb 2022 14:52:53 +0100 (CET)
Date:   Mon, 7 Feb 2022 14:52:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
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
Message-ID: <20220207135253.GF23216@worktop.programming.kicks-ass.net>
References: <20220207034013.599214-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207034013.599214-1-yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 11:40:13AM +0800, Chen Yu wrote:
> It would be ideal to have a crystal ball to predict the success rate
> of finding an idle cpu/core in the LLC. If it is doomed to fail,
> there is no need to search in the LLC domain. There are many potential
> metrics which could be used to predict the success rate. And the
> metric should be carefully chosen that, it should help reduce the
> unnecessary cpu runqueue scan, but meanwhile not give up the opportunity
> to find an idle cpu.
> 
> Choose average cpu utilization as the candidate, since the util_avg is
> a metric of accumulated historic activity, which seems to be more accurate
> than instantaneous metrics(such as rq->nr_running) on calculating the probability
> of find an idle cpu. Only when the average cpu utilization has reaches
> 85% of the total cpu capacity, this domain is regarded as overloaded.
> The reason to choose 85% is that, this is the threshold of an overloaded
> LLC sched group(imbalance_pct = 117, threshold = 100 / 117 * 100%).

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5146163bfabb..1a58befe892d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

> @@ -6280,6 +6281,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  	if (!this_sd)
>  		return -1;
>  
> +	sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
> +	if (sd_share && READ_ONCE(sd_share->overloaded))
> +		return -1;
> +
>  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>  
>  	if (sched_feat(SIS_PROP) && !has_idle_core) {

> @@ -9268,6 +9275,29 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
>  		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
>  	}
> +
> +	/*
> +	 * Check if the LLC domain is overloaded. The overload hint
> +	 * could be used to skip the LLC domain idle cpu search in
> +	 * select_idle_cpu(). The update of this hint occurs during
> +	 * periodic load balancing, rather than frequent newidle balance.
> +	 */
> +	if (env->idle != CPU_NEWLY_IDLE &&
> +	    env->sd->span_weight == per_cpu(sd_llc_size, env->dst_cpu)) {
> +		struct sched_domain_shared *sd_share =
> +			rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
> +
> +		if (!sd_share)
> +			return;
> +
> +		/*
> +		 * Derived from group_is_overloaded(). The default imbalance_pct
> +		 * is 117 on LLC domain, which means the threshold of average
> +		 * utilization is 85%.
> +		 */
> +		WRITE_ONCE(sd_share->overloaded, (sds->total_capacity * 100) <
> +			   (sum_util * env->sd->imbalance_pct));
> +	}
>  }

So the only problem I have with this is that this is somewhat of a
binary toggle. The moment we hit that magical 85% we suddenly change
behaviour.

Would it not be possible to replace the SIS_PROP logic with something
based on this sum_util metric? Such that when sum_util is very low we
scan more, while when sum_util hits 85% we naturally stop scanning
entirely.

That way the behaviour is gradual.
