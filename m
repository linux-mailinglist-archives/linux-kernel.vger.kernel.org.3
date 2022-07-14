Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040B5574C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbiGNLh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiGNLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:37:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E941599DB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KAH0iUDAppZ/OJ9oASzu66n/mZXtxhdds7IokMnhLO8=; b=lJHUzQumlnwCkF6WfTs8FPDUil
        8QBFtDsvC1Riy6znEf+u6exkm9ScBxoqDjSHrqMcI3BSpgW/XbpKa2L44Iwk9KjJDO3A/eKzIx0ou
        6olXiwAa7MlOLNRyjl9uvw9aMSslMxgMaQNbMpRbEz2qktYD19H2luGo/+eWA8DL9X1E0rTQ415/v
        zAco3IxKqeZhJFkC7dwK3dLcZQNOrAfvZj8tcHsGjKntFgD5ddACxWCeiUIqO1jXtS9Uq+MUFSkx9
        Qfy3SKFJUFldvz2Y3uf2NPnepgwhJE4ymi8jFZzshE8Joa+ItqNGybeFBms+/TD8pCyHAEN/UH3p/
        efZgvX9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBx9T-003pH4-IH; Thu, 14 Jul 2022 11:37:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C76498016F; Thu, 14 Jul 2022 13:37:02 +0200 (CEST)
Date:   Thu, 14 Jul 2022 13:37:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] sched/core: Fix the bug that task won't enqueue into
 core tree when update cookie
Message-ID: <Ys//3pspEdzEGg2G@worktop.programming.kicks-ass.net>
References: <1656403045-100840-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com>
 <YsKqf3mnv/aemeuC@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsKqf3mnv/aemeuC@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 10:53:20AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 28, 2022 at 03:57:23PM +0800, Cruz Zhao wrote:
> > In function sched_core_update_cookie(), a task will enqueue into the
> > core tree only when it enqueued before, that is, if an uncookied task
> > is cookied, it will not enqueue into the core tree until it enqueue
> > again, which will result in unnecessary force idle.
> > 
> > Here follows the scenario:
> >   CPU x and CPU y are a pair of SMT siblings.
> >   1. Start task a running on CPU x without sleeping, and task b and
> >      task c running on CPU y without sleeping.
> >   2. We create a cookie and share it to task a and task b, and then
> >      we create another cookie and share it to task c.
> >   3. Simpling core_forceidle_sum of task a and b from /proc/PID/sched
> > 
> > And we will find out that core_forceidle_sum of task a takes 30%
> > time of the sampling period, which shouldn't happen as task a and b
> > have the same cookie.
> > 
> > Then we migrate task a to CPU x', migrate task b and c to CPU y', where
> > CPU x' and CPU y' are a pair of SMT siblings, and sampling again, we
> > will found out that core_forceidle_sum of task a and b are almost zero.
> > 
> > To solve this problem, we enqueue the task into the core tree if it's
> > on rq.
> > 
> > Fixes: 6e33cad0af49("sched: Trivial core scheduling cookie management")
> > Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> > ---
> >  kernel/sched/core_sched.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> > index 38a2cec..ba2466c 100644
> > --- a/kernel/sched/core_sched.c
> > +++ b/kernel/sched/core_sched.c
> > @@ -75,7 +75,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
> >  	old_cookie = p->core_cookie;
> >  	p->core_cookie = cookie;
> >  
> > -	if (enqueued)
> > +	if (task_on_rq_queued(p))
> >  		sched_core_enqueue(rq, p);
> >  
> >  	/*
> 
> Yeah; I suppose that's true. However if we want to consider the
> asymmetric case, we should be complete and also consider the case where
> we clear the cookie.
> 
> And if you remove the second use of @enqueued, having that variable is
> rather redudant, which then leaves me with something like this.

Can you please confirm the below works for you so I can queue it?

> ---
> Subject: sched/core: Fix the bug that task won't enqueue into core tree when update cookie
> From: Cruz Zhao <CruzZhao@linux.alibaba.com>
> Date: Tue, 28 Jun 2022 15:57:23 +0800
> 
> From: Cruz Zhao <CruzZhao@linux.alibaba.com>
> 
> In function sched_core_update_cookie(), a task will enqueue into the
> core tree only when it enqueued before, that is, if an uncookied task
> is cookied, it will not enqueue into the core tree until it enqueue
> again, which will result in unnecessary force idle.
> 
> Here follows the scenario:
>   CPU x and CPU y are a pair of SMT siblings.
>   1. Start task a running on CPU x without sleeping, and task b and
>      task c running on CPU y without sleeping.
>   2. We create a cookie and share it to task a and task b, and then
>      we create another cookie and share it to task c.
>   3. Simpling core_forceidle_sum of task a and b from /proc/PID/sched
> 
> And we will find out that core_forceidle_sum of task a takes 30%
> time of the sampling period, which shouldn't happen as task a and b
> have the same cookie.
> 
> Then we migrate task a to CPU x', migrate task b and c to CPU y', where
> CPU x' and CPU y' are a pair of SMT siblings, and sampling again, we
> will found out that core_forceidle_sum of task a and b are almost zero.
> 
> To solve this problem, we enqueue the task into the core tree if it's
> on rq.
> 
> Fixes: 6e33cad0af49("sched: Trivial core scheduling cookie management")
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/1656403045-100840-2-git-send-email-CruzZhao@linux.alibaba.com
> ---
>  kernel/sched/core_sched.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/kernel/sched/core_sched.c
> +++ b/kernel/sched/core_sched.c
> @@ -56,7 +56,6 @@ static unsigned long sched_core_update_c
>  	unsigned long old_cookie;
>  	struct rq_flags rf;
>  	struct rq *rq;
> -	bool enqueued;
>  
>  	rq = task_rq_lock(p, &rf);
>  
> @@ -68,14 +67,16 @@ static unsigned long sched_core_update_c
>  	 */
>  	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
>  
> -	enqueued = sched_core_enqueued(p);
> -	if (enqueued)
> +	if (sched_core_enqueued(p))
>  		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
>  
>  	old_cookie = p->core_cookie;
>  	p->core_cookie = cookie;
>  
> -	if (enqueued)
> +	/*
> +	 * Consider the cases: !prev_cookie and !cookie.
> +	 */
> +	if (cookie && task_on_rq_queued(p))
>  		sched_core_enqueue(rq, p);
>  
>  	/*
