Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFFF5341F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245583AbiEYRFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245580AbiEYRE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:04:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA34BA8880
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kgn59VmUMefvIxlFDCN3FQUJL5gyHgnWCh4Ez8Dv6aU=; b=JQFKKA4mAHbTVDiK31GKWtlyl1
        ziPaZPcsDAJiMZHy3qFUIgFTYzTK9yAVIct1ek+q582OaS4oWHfrW+e8QfZFi1NcIoF9lPJzdPDoI
        vWg/C0g6+Z1v5zlK/nomiKwCSfHrvkiubVxPbNmEjg9MHRwXcf343AYZzJCUp6OtBllknd5mLjl+y
        srfK7JfpyTahvtwjk9TE8HNj6JW593IwcM/x0fkd82A8KfHuP+Mvvk+n4zRfoousSV6X3nnB5/Cx+
        6brfuI/SJ0o7nqKrI8JahhKBPSTCDA3BKgqW+cO3C+hJp+rDVGcyQgjBuglJGYzgwp3knUtZs2V5h
        dLTP2IkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntuR0-000XGd-Ta; Wed, 25 May 2022 17:04:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A360980E04; Wed, 25 May 2022 19:04:34 +0200 (CEST)
Date:   Wed, 25 May 2022 19:04:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bing Huang <huangbing@kylinos.cn>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sche/fair: static cpumasks for load balance
Message-ID: <20220525170434.GK2578@worktop.programming.kicks-ass.net>
References: <20220523094216.1746504-1-huangbing@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523094216.1746504-1-huangbing@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 05:42:16PM +0800, Bing Huang wrote:
> The both cpu mask load_balance_mask and select_idle_mask just only used
> in fair.c, but allocation in core.c in CONFIG_CPUMASK_OFFSTACK=y case,
> and global via declare per cpu variations. More or less, it looks wired.
> 
> Signed-off-by: Bing Huang <huangbing@kylinos.cn>
> ---
>  kernel/sched/core.c  | 13 +++----------
>  kernel/sched/fair.c  | 18 ++++++++++++++++--
>  kernel/sched/sched.h |  4 ++++
>  3 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d58c0389eb23..64934c5e236d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9448,9 +9448,6 @@ LIST_HEAD(task_groups);
>  static struct kmem_cache *task_group_cache __read_mostly;
>  #endif
>  
> -DECLARE_PER_CPU(cpumask_var_t, load_balance_mask);
> -DECLARE_PER_CPU(cpumask_var_t, select_idle_mask);
> -
>  void __init sched_init(void)
>  {
>  	unsigned long ptr = 0;
> @@ -9494,14 +9491,10 @@ void __init sched_init(void)
>  
>  #endif /* CONFIG_RT_GROUP_SCHED */
>  	}
> +
>  #ifdef CONFIG_CPUMASK_OFFSTACK
> -	for_each_possible_cpu(i) {
> -		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> -			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> -		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
> -			cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> -	}
> -#endif /* CONFIG_CPUMASK_OFFSTACK */
> +	init_working_cpumask();
> +#endif

We already have init_sched_fair_class(), can't you use that?

>  
>  	init_rt_bandwidth(&def_rt_bandwidth, global_rt_period(), global_rt_runtime());
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a68482d66535..3a4b0dd1beb5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5831,8 +5831,8 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  #ifdef CONFIG_SMP
>  
>  /* Working cpumask for: load_balance, load_balance_newidle. */
> -DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
> -DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
> +static DEFINE_PER_CPU(cpumask_var_t, load_balance_mask);
> +static DEFINE_PER_CPU(cpumask_var_t, select_idle_mask);
>  
>  #ifdef CONFIG_NO_HZ_COMMON
>  
> @@ -7052,6 +7052,20 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  }
>  #endif /* CONFIG_SMP */
>  
> +#ifdef CONFIG_CPUMASK_OFFSTACK
> +void __init init_working_cpumask(void)
> +{
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> +				cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +		per_cpu(select_idle_mask, i) = (cpumask_var_t)kzalloc_node(
> +				cpumask_size(), GFP_KERNEL, cpu_to_node(i));
> +	}
> +}
> +#endif

If you stick that #ifdef inside the function, you can remove it
everwhere else. Less #ifdef is more better.
