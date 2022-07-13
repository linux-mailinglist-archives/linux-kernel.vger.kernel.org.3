Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12446572C00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiGMDrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiGMDrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:47:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F083D860C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 20:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657684035; x=1689220035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GQ/WFbp6QqzRmi3ia7CHLxlH1IRb5fnmp9vJsSIn6JE=;
  b=nanpZtl+2wivTdsoOoI4Zdv6AzWHsST03GS6ElbpStHLtXr7lEP1J8Lo
   NkyVJOwArid/LT6L9t9q6bOiRQOJNZi6CnAEZBGlHfc0qtiodBDb4/r/h
   lkdSxW+udrS80hIke4kRX5/z/2xgxoyvisWZnKvXwSzuTba8Z3jvi/8R4
   JTO7EHd7EnzmUxJ5pI+qpJYe098hKeEUm3TMtoqnKndLOGKZ5fpcDQe//
   mbLcLmDQ4xuuprwsOt+MgR6oLyd7T+rX7AzB25CCZzshrNlKSDuKf572O
   EENiLTVQt31NkC3Vlv6oVJgcLDmJGUJSEODlTCB8lgyMhLbVXyl7+sSlV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="371414512"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="371414512"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 20:47:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="653188428"
Received: from yunliu1-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.171.118])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 20:47:13 -0700
Date:   Wed, 13 Jul 2022 11:47:08 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Message-ID: <20220713034708.GA23431@chenyu5-mobl1>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712082036.5130-2-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:20:32PM +0800, Abel Wu wrote:
> When SIS_UTIL is enabled, SIS domain scan will be skipped if
> the LLC is overloaded. Since the overloaded status is checked
> in the load balancing at LLC level, the interval is llc_size
> miliseconds. The duration might be long enough to affect the
> overall system throughput if idle cores are out of reach in
> SIS domain scan.
The idle core scan was skipped in SIS_UTIL because we saw better
improvement in some benchmarks. But yes, we could make has_idle_core
to scan anyway no matter what the system load is, if we have some
data to support it. I'll test this patch on top of latest sched/core
branch to see if this makes a difference.

thanks,
Chenyu
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>  kernel/sched/fair.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a78d2e3b9d49..cd758b3616bd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6392,16 +6392,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  	struct sched_domain *this_sd;
>  	u64 time = 0;
>  
> -	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> -	if (!this_sd)
> -		return -1;
> -
>  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>  
> -	if (sched_feat(SIS_PROP) && !has_idle_core) {
> +	if (has_idle_core)
> +		goto scan;
> +
> +	if (sched_feat(SIS_PROP)) {
>  		u64 avg_cost, avg_idle, span_avg;
>  		unsigned long now = jiffies;
>  
> +		this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> +		if (!this_sd)
> +			return -1;
> +
>  		/*
>  		 * If we're busy, the assumption that the last idle period
>  		 * predicts the future is flawed; age away the remaining
> @@ -6436,7 +6439,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  				return -1;
>  		}
>  	}
> -
> +scan:
>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
>  		if (has_idle_core) {
>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> -- 
> 2.31.1
> 
