Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F504D5122
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbiCJSDR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Mar 2022 13:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiCJSDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:03:16 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A681986D0;
        Thu, 10 Mar 2022 10:02:15 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id w12so10786195lfr.9;
        Thu, 10 Mar 2022 10:02:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ypo3GEUJC1KtfqbclWSczh3wzzpz31l4v4TAnVFfOKQ=;
        b=HMPW1UUcpFhMy8isEZ7uPELPlk7y95JUUzmszyj38DUcZwzIcG5uz+gkrP08QJe/pZ
         JmhcaqFFl7rppPyMLvInGHH5lZGvM1qgbFHVsHl4RbWZ5zR/Ki/rJ5IQevX/XIaw6Y5G
         wkmbQ3W29O20o23MAWI23WIKUHl+OaK83SFnsS3okv9jVMn4i291npCc/XWkq253SPJ+
         bSjAsp+NKmTy1OcDGaTKvSdN7qBWGQ8DXZjKv8ex8smYSGCRhKYrxeIoqMmn+z8+QcqD
         CBS6qcldmTbctmdysVWu80MDjABHWnqBTq/cGLApPiyCqZqcS/0iCHpjd2NaQd/s+tTe
         YQjg==
X-Gm-Message-State: AOAM532Ns2SI3nAFC+NoET/q78wUPaSvo4xfBDogT3zpCF2AgO9aItrm
        L+JRy12wLF0VOB+bU596vzSBNstY/lXOQ4lIUNI=
X-Google-Smtp-Source: ABdhPJy51eanIMg92+jqiUEtWO4lxZQ1zmy8o8axSpuqYvSemW3E8n7aRNWkH4aVwnoYy70t+XbOHcTavLAu0dbi1G0=
X-Received: by 2002:a05:6512:b9b:b0:448:3a53:e7d9 with SMTP id
 b27-20020a0565120b9b00b004483a53e7d9mr3449708lfv.586.1646935333289; Thu, 10
 Mar 2022 10:02:13 -0800 (PST)
MIME-Version: 1.0
References: <20220308135948.55336-1-zhouchengming@bytedance.com>
 <CAM9d7chsbpmVhhtzBgqD29Agb6xTMpxfwvqUdo6RKx2K1WN-DQ@mail.gmail.com> <e561e36c-cc73-2078-4baa-cb9ab6b6eeac@bytedance.com>
In-Reply-To: <e561e36c-cc73-2078-4baa-cb9ab6b6eeac@bytedance.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Mar 2022 10:02:02 -0800
Message-ID: <CAM9d7ciw+Jj1Z2j5qsz8f5YvAk5yh_w3+pZKO6gTAn2AHKQj2g@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] Re: [RFC PATCH] perf/core: fix cpuctx
 cgrp warning
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 4:01 AM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Hello,
>
> On 2022/3/10 5:25 下午, Namhyung Kim wrote:
> > Hello,
> >
> > On Tue, Mar 8, 2022 at 6:00 AM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
> >> in perf_cgroup_switch().
> >>
> >> CPU1                                    CPU2
> >> (in context_switch)                     (attach running task)
> >> perf_cgroup_sched_out(task, next)
> >>         if (cgrp1 != cgrp2) True
> >>                                         task->cgroups = xxx
> >>                                         perf_cgroup_attach()
> >> perf_cgroup_sched_in(prev, task)
> >>         if (cgrp1 != cgrp2) False
> >
> > But perf_cgroup_switch will be synchronized as the context switch
> > disables the interrupt.  And right, it still can see the task->cgroups
> > is changing in the middle.
> >
> >>
> >> The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
> >> context switch code") would save cpuctx switch in/out when the
> >> perf_cgroup of "prev" and "next" are the same.
> >>
> >> But perf_cgroup of task can change in concurrent with context_switch.
> >> If cgrp1 == cgrp2 in sched_out(), cpuctx won't do switch out, then
> >> task perf_cgroup changed cause cgrp1 != cgrp2 in sched_in(), cpuctx
> >> will do switch in, and trigger WARN_ON_ONCE(cpuctx->cgrp).
> >>
> >> The perf_cgroup of "prev" and "next" can be changed at any time, so we
> >> first have to combine perf_cgroup_sched_in() into perf_cgroup_sched_out(),
> >> so we can get a consistent value of condition (cgrp1 == cgrp2).
> >>
> >> And we introduce a percpu "cpu_perf_cgroups" to track the current used
> >> perf_cgroup, instead of using the unstable perf_cgroup of "prev", which
> >> maybe not the cpuctx->cgrp we used to schedule cgroup events on cpu.
> >
> > Is this really needed?  I think the warning comes because the two
> > cgroups were the same when in sched-out, but they became
> > different when in sched-in.  So just combining sched-in/out should
> > be ok, isn't it?
>
> If we get perf_cgroup from prev->cgroups that can be changed in the
> context_switch(), make the condition (cgrp1 == cgrp2) is true, then
> we won't do sched_out/in. So the events of prev's previous cgrp will
> still be on the CPU.
>
> Even that CPU would receive IPI from perf_cgroup_attach() after
> context_switch(), remote_function() will do nothing because prev task
> is not current running anymore.

Right, so I don't care about changing prev->cgroups.  I can see these
two scenarios.

1. (cgrp1 == cgrp2) --> (cgrp1 != cgrp2)
  This means the next task's cgroup (cgrp2) is the same as the
  previous and it doesn't need to reschedule events even if the
  cgrp1 is changed.

2. (cgrp1 != cgrp2) --> (cgrp1 == cgrp2)
  This will trigger rescheduling anyway, and we are fine.

>
> >
> >>
> >> Fixes: a8d757ef076f ("perf events: Fix slow and broken cgroup context
> >> switch code")
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> ---
> >>  kernel/events/core.c | 95 +++++++++++---------------------------------
> >>  1 file changed, 23 insertions(+), 72 deletions(-)
> >>
> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
> >> index 6859229497b1..f3bc2841141f 100644
> >> --- a/kernel/events/core.c
> >> +++ b/kernel/events/core.c
> >> @@ -826,6 +826,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
> >>         }
> >>  }
> >>
> >> +static DEFINE_PER_CPU(struct perf_cgroup *, cpu_perf_cgroups);
> >>  static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
> >>
> >>  #define PERF_CGROUP_SWOUT      0x1 /* cgroup switch out every event */
> >> @@ -837,8 +838,9 @@ static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
> >>   * mode SWOUT : schedule out everything
> >>   * mode SWIN : schedule in based on cgroup for next
> >
> > You can remove this comment now.
>
> Ok, will do.
>
> >
> >>   */
> >> -static void perf_cgroup_switch(struct task_struct *task, int mode)
> >> +static void perf_cgroup_switch(struct task_struct *task)
> >>  {
> >> +       struct perf_cgroup *cgrp;
> >>         struct perf_cpu_context *cpuctx, *tmp;
> >>         struct list_head *list;
> >>         unsigned long flags;
> >> @@ -849,6 +851,9 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
> >>          */
> >>         local_irq_save(flags);
> >>
> >> +       cgrp = perf_cgroup_from_task(task, NULL);
> >> +       __this_cpu_write(cpu_perf_cgroups, cgrp);
> >> +
> >>         list = this_cpu_ptr(&cgrp_cpuctx_list);
> >>         list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
> >>                 WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> >> @@ -856,28 +861,15 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
> >>                 perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> >>                 perf_pmu_disable(cpuctx->ctx.pmu);
> >>
> >> -               if (mode & PERF_CGROUP_SWOUT) {
> >> -                       cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> >> -                       /*
> >> -                        * must not be done before ctxswout due
> >> -                        * to event_filter_match() in event_sched_out()
> >
> > Unrelated, but I don't see the event_filter_match() in
> > event_sched_out() anymore.  Does it sched-out all
> > non-cgroup cpu events here?
>
> Yes, I review the code and don't find event_filter_match(),
> so cpu_ctx_sched_out() will sched-out all cpu events.
>
> And I find event_filter_match() won't work here too,
> because perf_cgroup_match() return matched for any
> non-cgroup event. Maybe we can add another function
> like perf_cgroup_match_sched_out() to use when sched-out.

And for sched-in too.

But we should consider multiplexing in the timer as well.
In that case it cannot know whether it needs to reschedule
cpu or cgroup events, so it does the job for all events.

But I think cgroup + multiplexing is broken already
because it cannot guarantee it sees the same cgroup
when the timer interrupt happens.

Thanks,
Namhyung

>
> >
> >> -                        */
> >> -                       cpuctx->cgrp = NULL;
> >> -               }
> >> +               cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> >> +               /*
> >> +                * must not be done before ctxswout due
> >> +                * to event_filter_match() in event_sched_out()
> >> +                */
> >> +               cpuctx->cgrp = cgrp;
> >
> > Maybe we can check cpuctx->cgrp is the same as task's
> > cgroup before accessing the pmu.  As in the commit message
> > it can call perf_cgroup_switch() after the context switch so
> > the cgroup events might be scheduled already.
>
> Good point, will do.
>
> Thanks.
>
> >
> > Thanks,
> > Namhyung
> >
> >
> >> +
> >> +               cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
> >>
> >> -               if (mode & PERF_CGROUP_SWIN) {
> >> -                       WARN_ON_ONCE(cpuctx->cgrp);
> >> -                       /*
> >> -                        * set cgrp before ctxsw in to allow
> >> -                        * event_filter_match() to not have to pass
> >> -                        * task around
> >> -                        * we pass the cpuctx->ctx to perf_cgroup_from_task()
> >> -                        * because cgorup events are only per-cpu
> >> -                        */
> >> -                       cpuctx->cgrp = perf_cgroup_from_task(task,
> >> -                                                            &cpuctx->ctx);
> >> -                       cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
> >> -               }
> >>                 perf_pmu_enable(cpuctx->ctx.pmu);
> >>                 perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
> >>         }
