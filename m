Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71B5002CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiDMXwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239266AbiDMXw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:52:27 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486AC4198F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:50:04 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f17so6542547ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5EXZ66vzc8wGGFS0KdCIOr/0vN4p+gJkK4jhufWTWo=;
        b=tOiGJxThxXa5XCh6q8UVUVgTw+/IaL6/n8X9OvaNav/lEOgsd905IckVF9kb2xE9xL
         Y+GyHynroF0g116azUR/a4FwWIvlMAhRwstn9Hl/82lkl1LdlSKSibvCNDAIaQvJaFFv
         vEA0Pt14P49Dgy4V6iyeO2U8M+tHUGjHj63EE3sfJXlxpeHq9+QyxAvcn+zOvqi6ZHik
         UFA/Y67tPsgxeUfhuWcLGq64NAr+RSSYcDHJghIpH1KIS+Zo+S8JxU9hShegcD2O6llC
         NOtoEUIjIYme8Gvap+bDSlRvzmew4/FUmngrL58qPbvcijKRQUWCp5g+3WMnU3mKqzwL
         V3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5EXZ66vzc8wGGFS0KdCIOr/0vN4p+gJkK4jhufWTWo=;
        b=thlILLEt30ADhYu/npfpjDN2S+2zKa8LudNDZtoAH3LBiTF2KYpClf/4I2balsGXoO
         NnpNPate6ijw80+zC7Z/hHenfyUixlEl3KU9Fxw+DZDUdyAQhKb7QNLsKxS7f26y7aBd
         qnbhtdw2QHPf7VcfHnVhnNMIHkTsnrktMYWAtj00SMRtE3ciaNCDMzk68yzlTZdhEI/n
         USetbGZN1PqQzGwaODHnQMTDmyZj5gvziTPijOYKs3UyhaeGOIlFTbyzjI+B5BZ/6AAM
         v5WXKRrCUql+faKDFzgaTXlmdeo5ouj0XAjfxUNvqxcYniht+op6q5CyvTXzMqt9XbG3
         4VVg==
X-Gm-Message-State: AOAM5309pC59sp+TDRSt94Qnyw80gyZ2JyBbL4z2vcN6AkcVn28L6h6t
        VyDu9yCeueSFYGIm9TNw5f6xnc2NYQRqaG0/+pEs/Q==
X-Google-Smtp-Source: ABdhPJwFlbrl7ofnjS1cxV5eVjwrteY0hJYnsUWhyrL07X06SKz9Kfo71uCtg2eGPzBWMc0TYho+C0WwQSSOikcnwpA=
X-Received: by 2002:a25:3744:0:b0:641:28ec:c7a8 with SMTP id
 e65-20020a253744000000b0064128ecc7a8mr1119306yba.560.1649893803087; Wed, 13
 Apr 2022 16:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
 <20220409135104.3733193-2-wuyun.abel@bytedance.com> <CABk29NtBL2WovUVcxXW8cF7Nk+UM_AeEJaX_JbQ4Wue-qMvz_w@mail.gmail.com>
 <56ded56d-f7ad-a49f-c19c-8aa40fb33a29@bytedance.com>
In-Reply-To: <56ded56d-f7ad-a49f-c19c-8aa40fb33a29@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 13 Apr 2022 16:49:52 -0700
Message-ID: <CABk29Nu+6vh825SqyNmSJoWBQmEBgCsk6mcEtWLmXCq_T0xUjg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] sched/fair: filter out overloaded cpus in SIS
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 10:55 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>
> On 4/12/22 9:23 AM, Josh Don Wrote:

> >>   static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
> >>   {
> >>          struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> >> -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
> >> +       int i, cpu, idle_cpu = -1, nr = INT_MAX, nro;
> >>          struct rq *this_rq = this_rq();
> >>          int this = smp_processor_id();
> >>          struct sched_domain *this_sd;
> >> @@ -6301,7 +6310,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>          if (!this_sd)
> >>                  return -1;
> >>
> >> +       nro = atomic_read(&sd->shared->nr_overloaded);
> >> +       if (sched_domain_overloaded(sd, nro))
> >> +               return -1;
> >
> > This early bail out doesn't seem to be related to the main idea of
> > your patch. Apart from deciding the exact heuristic value for what is
>
> I agree that this early check doesn't seem to have a strong bound with
> the idea "filter out the overloaded cpus", but this check is aligned
> with the goal of "search less when becoming more overloaded".
>
> As to the heuristic value, which is about 95%, I think it would be nice
> if I can show more test results? I also have tested sd->imbalance_pct
> and 100% (nro == sd->span_weight), seems like 95% is a better choice.
>
> > considered too unlikely to find an idle cpu, this doesn't work well
> > with tasks constrained by affinity; a task may have a small affinity
> > mask containing idle cpus it may wake onto, even if most of the node
> > is overloaded.
>
> Yes, indeed. And I haven't come to a solution except that remove this
> check entirely. Ideas?

Does this check help that much? Given that you added the filter below
to cut out searching overloaded cpus, I would think that the below is
sufficient.

Another use case that would break with the above:

A few cpus are reserved for a job, so that it always has a couple cpus
dedicated to it. It can run across the entire machine though (no
affinity restriction). If the rest of the machine is very busy, we'd
still want to be able to search for and find the idle reserved cpus
for the job.

> >>          cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> >> +       if (nro)
> >> +               cpumask_andnot(cpus, cpus, sdo_mask(sd->shared));
> >
> > To prevent us from exhausting our search attempts too quickly, this
> > only needs to go under the sched_feat(SIS_PROP) && !has_idle_core case
> > below. But by doing this unconditionally here, I guess your secondary
> > goal is to reduce total search cost in both cases. Just wondering, did
>
> Yes, it's unnecessary to try the overloaded cpus. But this makes sense
> only if the overloaded cpumask is relatively accurate as you pointed
> out below.
>
> > you observe significant time spent here that you are trying to
> > optimize? By reducing our search space by the overload mask, it is
> > important that the mask is relatively up to date, or else we could
> > miss an opportunity to find an idle cpu.
>
> I think that's why Mel asked for the SIS statistics. The result in the
> cover letter shows improvement on the search efficiency, and that is
> what the overhead of the cpumask calculation trade for. Would it be
> better if skip the update when nro is small?

Just pointing out that with a very fast wake/sleep rate, you could hit
cases where you potentially fail to consider waking onto a cpu that is
actually idle. But I think this concern is addressed below.

> >
> >>          if (sched_feat(SIS_PROP) && !has_idle_core) {
> >>                  u64 avg_cost, avg_idle, span_avg;
> >> @@ -7018,6 +7033,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >>
> >>          return newidle_balance(rq, rf) != 0;
> >>   }
> >> +
> >> +static inline bool cfs_rq_overloaded(struct rq *rq)
> >> +{
> >> +       return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
> >> +}
> >
> > Why > 1 instead of > 0? If a cpu is running 1 non-idle task and any
> > number of idle tasks, I'd think it is still "occupied" in the way
> > you've defined. We'd want to steer wakeups to cpus running 0 non-idle
> > tasks.
>
> The idea behind "> 1" is telling the unoccupied cpus to pull non-idle
> tasks from it (in the next patch). Although "> 0" is more efficient in
> wakeup, it blinds us when pulling tasks.

Ok, I was a bit confused because there are different considerations
for >=1 and >=2 non-idle tasks.

So you consider >= 2 non-idle tasks to be "overloaded". TBH I do
prefer this than ">=1" for the wakeup filtering anyway, because if
there are at least two tasks, that makes it less likely for us to race
with seeing a spurious wakeup/sleep causing a cpu to be fully
idle/non-idle (ie. we have more confidence that we can safely filter
out the overload mask).

> > Why are these cpu mask writes not atomic?
>
> They are atomic. The non-atomic version is __cpumask_{set,clear}_cpu.
> Did I miss something?

Ah, I confused these, my bad.

> > I'd caution about using task_tick and pick_next_task_fair as the
> > places we set and clear overload.
> >
> > Some issues with task_tick:
> > - ticks may be disabled in NO_HZ_FULL (an issue if we define overload
> > as > 0 non-idle tasks)
> > - most ticks will have the same state, so somewhat redundant checking.
> > Could use an edge based trigger instead, such as enqueue/dequeue
> > (somewhat similar to rq->rd->overload).
>
> 1. In NO_HZ_FULL, given rq is overloaded, say have non-idle task A and
>     B enqueued, if A is dequeued before next tick then tick will be off
>     and the rq will keep "overloaded" while it's actually not. But this
>     doesn't necessarily be a bad thing because this cpu will be skipped
>     in wakeup path which helps in improving searching efficiency.

Yea this concern is alleviated because overload is actually >=2 tasks
(I had been incorrectly assuming you wanted to mark overload for >=1
non-idle task.

> 2. Yes, that's why I use rq->overloaded to save the last update state.
>     So when the overloaded state doesn't change, what we all do is a
>     simple check on a local variable.
>     The enqueue/dequeue path is not well bounded, and it could be very
>     frequent on short running workloads, which would introduce great
>     overhead to update the LLC shared atomic/cpumask.

Yea, the frequent update would be an issue. I now see the check on the
cpu-local variable.

So the rate limit on updates comes from the fact that
!overloaded->overloaded requires a tick. We can quickly go from
overloaded->!overloaded, but will take another tick until we can go
back to overloaded.

> > With pick_next_task_fair():
> > - there's a window between a thread dequeuing, and then scheduler
> > running through to the end of pick_next_task_fair(), during which we
> > falsely observe the cpu as overloaded
> > - this breaks with core scheduling, since we may use pick_task_fair
> > rather than pick_next_task_fair
>
> 1. I'm afraid I don't understand what the problem is, can you explain
>     more on this? Thanks.

Can ignore this comment, I don't think it is relevant given that this
isn't really a regression vs. the latency between the last thread
dequeuing and available_idle_cpu() returning true.

> 2. Nice catch, I will fix it in next update. (Maybe by updating the
>     overloaded status in do_idle()?)

Ideally can catch it before we actually switch to rq->idle (just
trying to minimize latency to mark as !overloaded).

Thanks,
Josh
