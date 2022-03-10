Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5E44D4374
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbiCJJ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbiCJJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:26:54 -0500
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D005B13982A;
        Thu, 10 Mar 2022 01:25:53 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id g17so8366623lfh.2;
        Thu, 10 Mar 2022 01:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5V+wTeIo37PwWFwgFplTYn4oIVdAMfrFbOjnidcQjU=;
        b=FqifI/FvBGLhqHJSeJUeTFoLnDatd9wwyGFfbIzo3luskOrxO4YKKqIktNxMV/hvVJ
         o+VUSf/ORv8bcwarL/h0Yg6GssnyEWHhEUE4RBzEi5bvKodGqxrB8TbcSVL/D4+Vj/ED
         7gnB8Q339TzBh2kLQYHoLu0BRFag8/Oy71xszDsiY2JuSZySpyftLKLC1wT95YGeylS3
         PZJ/kD++ert+iHH4ta2Ic8PHAiP2NRZsLkqkTYgTKANo6WCw9/fIRZCgKYKNWPvcNWwb
         beVwhEuJ0W0P5cYYrt3JVd9uKNrjPf+CZK1F5NPeEbfDdBs7jhkPiujFbpZpSE3Po1N7
         0c6w==
X-Gm-Message-State: AOAM5312T6a2EQLx6n07KnbDg+GYqJy2r6SzARe820hIvRaxjgX8m1dl
        l1q4QjGMJYKOalis6pBMYBIk/Uv1YTb136RV00c=
X-Google-Smtp-Source: ABdhPJwqYawyDJX/GT0RTxkOjNsc7y7aK0QiHQNoA/A3hziNoe7KKMG+ml/bRNOc8V1UDxX/8cwsA46+QjtCZIiYde8=
X-Received: by 2002:a05:6512:ea5:b0:43b:3603:69d9 with SMTP id
 bi37-20020a0565120ea500b0043b360369d9mr2357274lfb.71.1646904351643; Thu, 10
 Mar 2022 01:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20220308135948.55336-1-zhouchengming@bytedance.com>
In-Reply-To: <20220308135948.55336-1-zhouchengming@bytedance.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 10 Mar 2022 01:25:40 -0800
Message-ID: <CAM9d7chsbpmVhhtzBgqD29Agb6xTMpxfwvqUdo6RKx2K1WN-DQ@mail.gmail.com>
Subject: Re: [RFC PATCH] perf/core: fix cpuctx cgrp warning
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 8, 2022 at 6:00 AM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
> in perf_cgroup_switch().
>
> CPU1                                    CPU2
> (in context_switch)                     (attach running task)
> perf_cgroup_sched_out(task, next)
>         if (cgrp1 != cgrp2) True
>                                         task->cgroups = xxx
>                                         perf_cgroup_attach()
> perf_cgroup_sched_in(prev, task)
>         if (cgrp1 != cgrp2) False

But perf_cgroup_switch will be synchronized as the context switch
disables the interrupt.  And right, it still can see the task->cgroups
is changing in the middle.

>
> The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
> context switch code") would save cpuctx switch in/out when the
> perf_cgroup of "prev" and "next" are the same.
>
> But perf_cgroup of task can change in concurrent with context_switch.
> If cgrp1 == cgrp2 in sched_out(), cpuctx won't do switch out, then
> task perf_cgroup changed cause cgrp1 != cgrp2 in sched_in(), cpuctx
> will do switch in, and trigger WARN_ON_ONCE(cpuctx->cgrp).
>
> The perf_cgroup of "prev" and "next" can be changed at any time, so we
> first have to combine perf_cgroup_sched_in() into perf_cgroup_sched_out(),
> so we can get a consistent value of condition (cgrp1 == cgrp2).
>
> And we introduce a percpu "cpu_perf_cgroups" to track the current used
> perf_cgroup, instead of using the unstable perf_cgroup of "prev", which
> maybe not the cpuctx->cgrp we used to schedule cgroup events on cpu.

Is this really needed?  I think the warning comes because the two
cgroups were the same when in sched-out, but they became
different when in sched-in.  So just combining sched-in/out should
be ok, isn't it?

>
> Fixes: a8d757ef076f ("perf events: Fix slow and broken cgroup context
> switch code")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/events/core.c | 95 +++++++++++---------------------------------
>  1 file changed, 23 insertions(+), 72 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6859229497b1..f3bc2841141f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -826,6 +826,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
>         }
>  }
>
> +static DEFINE_PER_CPU(struct perf_cgroup *, cpu_perf_cgroups);
>  static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
>
>  #define PERF_CGROUP_SWOUT      0x1 /* cgroup switch out every event */
> @@ -837,8 +838,9 @@ static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
>   * mode SWOUT : schedule out everything
>   * mode SWIN : schedule in based on cgroup for next

You can remove this comment now.

>   */
> -static void perf_cgroup_switch(struct task_struct *task, int mode)
> +static void perf_cgroup_switch(struct task_struct *task)
>  {
> +       struct perf_cgroup *cgrp;
>         struct perf_cpu_context *cpuctx, *tmp;
>         struct list_head *list;
>         unsigned long flags;
> @@ -849,6 +851,9 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>          */
>         local_irq_save(flags);
>
> +       cgrp = perf_cgroup_from_task(task, NULL);
> +       __this_cpu_write(cpu_perf_cgroups, cgrp);
> +
>         list = this_cpu_ptr(&cgrp_cpuctx_list);
>         list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
>                 WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
> @@ -856,28 +861,15 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>                 perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>                 perf_pmu_disable(cpuctx->ctx.pmu);
>
> -               if (mode & PERF_CGROUP_SWOUT) {
> -                       cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> -                       /*
> -                        * must not be done before ctxswout due
> -                        * to event_filter_match() in event_sched_out()

Unrelated, but I don't see the event_filter_match() in
event_sched_out() anymore.  Does it sched-out all
non-cgroup cpu events here?

> -                        */
> -                       cpuctx->cgrp = NULL;
> -               }
> +               cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> +               /*
> +                * must not be done before ctxswout due
> +                * to event_filter_match() in event_sched_out()
> +                */
> +               cpuctx->cgrp = cgrp;

Maybe we can check cpuctx->cgrp is the same as task's
cgroup before accessing the pmu.  As in the commit message
it can call perf_cgroup_switch() after the context switch so
the cgroup events might be scheduled already.

Thanks,
Namhyung


> +
> +               cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
>
> -               if (mode & PERF_CGROUP_SWIN) {
> -                       WARN_ON_ONCE(cpuctx->cgrp);
> -                       /*
> -                        * set cgrp before ctxsw in to allow
> -                        * event_filter_match() to not have to pass
> -                        * task around
> -                        * we pass the cpuctx->ctx to perf_cgroup_from_task()
> -                        * because cgorup events are only per-cpu
> -                        */
> -                       cpuctx->cgrp = perf_cgroup_from_task(task,
> -                                                            &cpuctx->ctx);
> -                       cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
> -               }
>                 perf_pmu_enable(cpuctx->ctx.pmu);
>                 perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>         }
