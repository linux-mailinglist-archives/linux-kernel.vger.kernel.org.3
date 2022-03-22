Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86D54E490E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiCVWUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiCVWU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:20:26 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F6952B28;
        Tue, 22 Mar 2022 15:18:58 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id e16so17941844lfc.13;
        Tue, 22 Mar 2022 15:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHplyqzsigAykQ6ju0My/TTZv6HrrDjwztUdED3YJsE=;
        b=N7FXbOFYFUKA0mcPOntcYjS5CfhPCbKtZy7WyhFN32CDdFFZw0VJkKM6+nb16f8m/2
         kQR2SNFVzoxIxqNpLIlvUQMQju5ZRa8Aa7+pBNiuw4RpK2MVka7yJyHn9ZaBjcrvRz+W
         C9cIuRxd0aTiG4M7MSZ/XqN5ZVz7C5mvgP+2isFfZYLQ8IKOCNqIlOvZMM2MbMDVcCF3
         ZG96lqoqxM7v8CiR7plDwo5udaDUJj/PO5/HXfC9nI0eY5ghzG/LCzZ2Zn0tnaY5oad6
         VZ3zrqzf6gTirfigEh9qh3BuAPDde9kKy+UxAoGNK1F/qDGXRL4kDqFungmkj4st+Bj2
         Gctg==
X-Gm-Message-State: AOAM533cxLdUqgXNCme9Btv7WS+inS66nSPb5oBgubGM2eLSEwz34QjM
        ueyglf77EME2yszl5I+QNAud+XU8AL9pabjfHys=
X-Google-Smtp-Source: ABdhPJytobiUpK7mioUDPuVMYTREZ6VGHaWF5Twu0QGaqe33k8KpikRF0D8XZRuWbzKlt9//GdOztHkeMZhSKBXK94E=
X-Received: by 2002:ac2:4c53:0:b0:44a:4357:c285 with SMTP id
 o19-20020ac24c53000000b0044a4357c285mr2455274lfk.99.1647987536336; Tue, 22
 Mar 2022 15:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220322120834.98637-1-zhouchengming@bytedance.com> <20220322120834.98637-3-zhouchengming@bytedance.com>
In-Reply-To: <20220322120834.98637-3-zhouchengming@bytedance.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Mar 2022 15:18:45 -0700
Message-ID: <CAM9d7cjwuQmuxwMG7HP3QDw0ckKcUqfT5A8JGg2JkcrZuQhWUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] perf/core: Introduce percpu perf_cgroup
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
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
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

On Tue, Mar 22, 2022 at 5:10 AM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Although we don't have incosistency problem any more, we can
> have other problem like:
>
> CPU1                                    CPU2
> (in context_switch)                     (attach running task)
>                                         prev->cgroups = cgrp2
> perf_cgroup_sched_switch(prev, next)
>         cgrp2 == cgrp2 is True
>
> If perf_cgroup of prev task changes from cgrp1 to cgrp2,
> perf_cgroup_sched_switch() will skip perf_cgroup_switch(),
> so the CPU would still schedule the cgrp1 events, but we should
> schedule the cgrp2 events.

Ah ok, now I see the problem in changing prev->cgroup too.

>
> The reason of this problem is that we shouldn't use the changeable
> prev->cgroups to decide whether skip perf_cgroup_switch().
>
> This patch introduces a percpu perf_cgroup to cache the perf_cgroup
> that scheduled in cpuctxes, which later used to compare with the
> perf_cgroup of next task to decide whether skip perf_cgroup_switch().
>
> Since the perf_cgroup_switch() can be called after the context switch,
> the cgroup events might be scheduled already. So we put the comparison
> of perf_cgroups in perf_cgroup_switch(), and delete the unused function
> perf_cgroup_sched_switch().
>
> We must clear the percpu perf_cgroup cache when the last cgroup event
> disabled.
>
> Fixes: a8d757ef076f ("perf events: Fix slow and broken cgroup context switch code")
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/events/core.c | 63 ++++++++++++++++----------------------------
>  1 file changed, 22 insertions(+), 41 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8b5cf2aedfe6..848a3bfa9513 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -826,6 +826,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
>         }
>  }
>
> +static DEFINE_PER_CPU(struct perf_cgroup *, cpu_perf_cgroup);
>  static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
>
>  /*
> @@ -833,6 +834,7 @@ static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
>   */
>  static void perf_cgroup_switch(struct task_struct *task)
>  {
> +       struct perf_cgroup *cgrp;
>         struct perf_cpu_context *cpuctx, *tmp;
>         struct list_head *list;
>         unsigned long flags;
> @@ -843,11 +845,21 @@ static void perf_cgroup_switch(struct task_struct *task)
>          */
>         local_irq_save(flags);
>
> +       cgrp = perf_cgroup_from_task(task, NULL);
> +       if (cgrp == __this_cpu_read(cpu_perf_cgroup))
> +               goto out;
> +
> +       __this_cpu_write(cpu_perf_cgroup, cgrp);
> +
>         list = this_cpu_ptr(&cgrp_cpuctx_list);
>         list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
>                 WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>
>                 perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +
> +               if (cpuctx->cgrp == cgrp)

Missing perf_ctx_unlock().

Thanks,
Namhyung

> +                       continue;
> +
>                 perf_pmu_disable(cpuctx->ctx.pmu);
>
>                 cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> @@ -855,14 +867,11 @@ static void perf_cgroup_switch(struct task_struct *task)
>                  * must not be done before ctxswout due
>                  * to event_filter_match() in event_sched_out()
>                  */
> -               cpuctx->cgrp = perf_cgroup_from_task(task,
> -                                                    &cpuctx->ctx);
> +               cpuctx->cgrp = cgrp;
>                 /*
>                  * set cgrp before ctxsw in to allow
>                  * event_filter_match() to not have to pass
>                  * task around
> -                * we pass the cpuctx->ctx to perf_cgroup_from_task()
> -                * because cgroup events are only per-cpu
>                  */
>                 cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
>
> @@ -870,35 +879,10 @@ static void perf_cgroup_switch(struct task_struct *task)
>                 perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>         }
>
> +out:
>         local_irq_restore(flags);
>  }
