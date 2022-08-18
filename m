Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F59598184
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 12:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244086AbiHRKgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 06:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiHRKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 06:36:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D510FFB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HK6eKfRV6xelSLvyS9t2UPPQaR+854+ceNVcMbxLU5M=; b=oPg5QtIsroQwRLZi7yP4hsQYBY
        jsk2N6SBfjfDrNDklmdQIxsYoTseNoU1hpMWWj8wWddScss9qZ+DiWA2OU72te8XxVI01M+q9EgHP
        vw5ifgn/IHsDVkLmci9+rZchQajJHeuFnWYVuoHQ8ivlhgif35oLznmQpYr8mxJxot0oeShZRruza
        dFz3KSSQw8C4Z4w6SS0B5n34zSwQBgpRy5g4xz6/aCJ9dCLHxHusGxIqIO/DDTlUsjfncsO/P6Ta8
        mT7nVONSKlhY1qq+DNNCHlAIUQJM5q5wbfcjCz2FMDRM3137PrBHcyYpPImt9dQjLph1s8LfTvIjG
        TiBt9+Bw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOcsx-003Yhf-AH; Thu, 18 Aug 2022 10:36:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8928980135; Thu, 18 Aug 2022 12:36:21 +0200 (CEST)
Date:   Thu, 18 Aug 2022 12:36:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH v5 7/9] sched/fair: allow changing cgroup of new forked
 task
Message-ID: <Yv4WJQAGw0zgU3nH@worktop.programming.kicks-ass.net>
References: <20220818034343.87625-1-zhouchengming@bytedance.com>
 <20220818034343.87625-8-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818034343.87625-8-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:43:41AM +0800, Chengming Zhou wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8e3f1c3f0b2c..157f7461a08a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4550,11 +4550,11 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  {
>  	__sched_fork(clone_flags, p);
>  	/*
> -	 * We mark the process as NEW here. This guarantees that
> +	 * We mark the process as running here. This guarantees that
>  	 * nobody will actually run it, and a signal or other external
>  	 * event cannot wake it up and insert it on the runqueue either.
>  	 */
> -	p->__state = TASK_NEW;
> +	p->__state = TASK_RUNNING;
>  
>  	/*
>  	 * Make sure we do not leak PI boosting priority to the child.
> @@ -4672,7 +4672,6 @@ void wake_up_new_task(struct task_struct *p)
>  	struct rq *rq;
>  
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> -	WRITE_ONCE(p->__state, TASK_RUNNING);
>  #ifdef CONFIG_SMP
>  	/*
>  	 * Fork balancing, do it here and not earlier because:
> @@ -10290,36 +10289,19 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
>  	sched_unregister_group(tg);
>  }

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index eba8a64f905a..e0d34ecdabae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11840,6 +11840,13 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  static void task_change_group_fair(struct task_struct *p)
>  {
> +	/*
> +	 * We couldn't detach or attach a forked task which
> +	 * hasn't been woken up by wake_up_new_task().
> +	 */
> +	if (!p->on_rq && !p->se.sum_exec_runtime)
> +		return;
> +
>  	detach_task_cfs_rq(p);

Wouldn't that be much clearer when expressed in TASK_NEW ?
