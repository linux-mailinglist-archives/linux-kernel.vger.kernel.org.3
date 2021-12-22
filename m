Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3D47D71A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344851AbhLVSpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbhLVSpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:45:42 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC6BC061574;
        Wed, 22 Dec 2021 10:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=RTobEUkTLVHhSZ45tuTt7qIPQYTObJHQibTh5FYQpes=; b=2cqL
        SdyEqRQDW1jCv+4jHh1yg0OXuBz1C7L63ZFOttoiDdedecqAB8kh6RBVKe8Cjxd4LfTejaw8ccjV1
        nO5W+Iys3RwaL+noMJnv2kSDdchcbopa/vEOFPUZWNQwrATljem+cmCkG+FAkZ4u9qp+eqpuqx2ES
        bHR5tHHvAR6f4noV21oQWQlaTyZyCHkAr1Jg+n0BgDc9rPksDmsoO3x1wK+kMN/HcZ+zvWNBTHgPG
        CsLjo118XAYWztw56Dc7Yd1S8L57nUcxPVbx6Z9NNVFhb7/754gFNtUa8x/nnXcP7TSpkRAH6tFEo
        foz+Fxhb7XI4kl1sZ6glINC1hoH5uQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1n06cI-0008Bn-VR; Wed, 22 Dec 2021 18:45:35 +0000
Date:   Wed, 22 Dec 2021 18:45:33 +0000
From:   John Keeping <john@metanate.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RT] BUG in sched/cpupri.c
Message-ID: <20211222184533.4c14868c.john@metanate.com>
In-Reply-To: <31a47e99-6de3-76ec-62ad-9c98d092ead5@arm.com>
References: <Yb3vXx3DcqVOi+EA@donbot>
        <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com>
        <87zgou6iq1.mognet@arm.com>
        <20211221164528.3c84543f.john@metanate.com>
        <31a47e99-6de3-76ec-62ad-9c98d092ead5@arm.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 18:46:57 +0100
Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

> On 21.12.21 17:45, John Keeping wrote:
> > On Tue, 21 Dec 2021 16:11:34 +0000
> > Valentin Schneider <valentin.schneider@arm.com> wrote:
> >   
> >> On 20/12/21 18:35, Dietmar Eggemann wrote:  
> 
> [...]
> 
> >> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> >> index fd7c4f972aaf..7d61ceec1a3b 100644
> >> --- a/kernel/sched/deadline.c
> >> +++ b/kernel/sched/deadline.c
> >> @@ -2467,10 +2467,13 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
> >>  	 * this is the right place to try to pull some other one
> >>  	 * from an overloaded CPU, if any.
> >>  	 */
> >> -	if (!task_on_rq_queued(p) || rq->dl.dl_nr_running)
> >> +	if (!task_on_rq_queued(p))
> >>  		return;
> >>  
> >> -	deadline_queue_pull_task(rq);
> >> +	if (!rq->dl.dl_nr_running)
> >> +		deadline_queue_pull_task(rq);
> >> +	else if (task_current(rq, p) && (p->sched_class < &dl_sched_class))
> >> +		resched_curr(rq);
> >>  }
> >>  
> >>  /*
> >> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> >> index ef8228d19382..1ea2567612fb 100644
> >> --- a/kernel/sched/rt.c
> >> +++ b/kernel/sched/rt.c
> >> @@ -2322,10 +2322,13 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
> >>  	 * we may need to handle the pulling of RT tasks
> >>  	 * now.
> >>  	 */
> >> -	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
> >> +	if (!task_on_rq_queued(p))
> >>  		return;
> >>  
> >> -	rt_queue_pull_task(rq);
> >> +	if (!rq->rt.rt_nr_running)
> >> +		rt_queue_pull_task(rq);
> >> +	else if (task_current(rq, p) && (p->sched_class < &rt_sched_class))
> >> +		resched_curr(rq);  
> 
> switched_from_rt() -> rt_queue_pull_task(, pull_rt_task)
>   pull_rt_task()->tell_cpu_to_push()->irq_work_queue_on(&rq->rd->rto_push_work,)
>     rto_push_irq_work_func() -> push_rt_task(rq, true)
> 
> seems to be the only way with pull=true.
> 
> In my tests, rq->rt.rt_nr_running seems to be 0 when it happens.
> 
> [   22.288537] CPU3 switched_to_rt: p=[ksoftirqd/3 35]
> [   22.288554] rt_mutex_setprio: CPU3 p=[ksoftirqd/3 35] pi_task=[rcu_preempt 11] queued=1 running=0 prio=98 oldprio=120
> [   22.288636] CPU3 switched_from_rt: p=[ksoftirqd/3 35] rq->rt.rt_nr_running=0
>                                                          ^^^^^^^^^^^^^^^^^^^^^^ 
> [   22.288649] rt_mutex_setprio: CPU3 p=[ksoftirqd/3 35] queued=1 running=1 prio=120 oldprio=98
> [   22.288681] CPU3 push_rt_task: next_task=[rcu_preempt 11] migr_dis=1 rq->curr=[ksoftirqd/3 35] pull=1
>                                                              ^^^^^^^^^^                           ^^^^^^ 
> [   22.288698] CPU: 3 PID: 35 Comm: ksoftirqd/3 Not tainted 5.15.10-rt24-dirty #36
> [   22.288711] Hardware name: ARM Juno development board (r0) (DT)
> [   22.288718] Call trace:
> [   22.288722]  dump_backtrace+0x0/0x1ac
> [   22.288747]  show_stack+0x1c/0x70
> [   22.288763]  dump_stack_lvl+0x68/0x84
> [   22.288777]  dump_stack+0x1c/0x38
> [   22.288788]  push_rt_task.part.0+0x364/0x370
> [   22.288805]  rto_push_irq_work_func+0x180/0x190
> [   22.288821]  irq_work_single+0x34/0xa0
> [   22.288836]  flush_smp_call_function_queue+0x138/0x244
> [   22.288852]  generic_smp_call_function_single_interrupt+0x18/0x24
> [   22.288867]  ipi_handler+0xb0/0x15c
> ...
> 
> What about slightly changing the layout in switched_from_rt() (only lightly tested):

I still see the BUG splat with the patch below applied :-(

> @@ -2322,7 +2338,15 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
>          * we may need to handle the pulling of RT tasks
>          * now.
>          */
> -       if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
> +       if (!task_on_rq_queued(p))
> +               return;
> +
> +       if (task_current(rq, p) && (p->sched_class < &rt_sched_class)) {
> +               resched_curr(rq);
> +               return;
> +       }
> +
> +       if (rq->rt.rt_nr_running)
>                 return;
>  
>         rt_queue_pull_task(rq);

