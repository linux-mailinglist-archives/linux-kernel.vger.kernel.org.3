Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1D5746D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiGNIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiGNIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:34:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197B33D5AF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:34:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b26so1579739wrc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=plBtZ2+Nyx+9JcGj2jq/7Qk4lCI2DqXLKg9fSdCVw/8=;
        b=Encw9npHoGkRGFqRvMXQRR57Zq2qCZudAvWUOnl9c0em3DZRFowHPXIBuTV7nYD/17
         pPfp0VEfWqUYtfUxFjLH54ajLrFPU3dSeMQEViZsVLtCCFhUatnDvo4Tdrc0V1JuN/FH
         eMG/Rlmen2yDBV2743E4HjSaU5iNRQUah65hPJxbgLZYALT+z66idulkBnGBTUqBrOwG
         RdMfmxy11ANe4hLVtvZSVC03LfDe3qPlIssOHcyAcMclG1mn7WaDj1I4TzYKZX1guqWI
         mh457IWXbe5DtQccGCKN3CaM+s0u7T6yyWzElg8b6H0xTFx8fWVl0qGSyxFi53bP7Prg
         nT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=plBtZ2+Nyx+9JcGj2jq/7Qk4lCI2DqXLKg9fSdCVw/8=;
        b=DqLOak0RrC/PtKs+3MI4KcSLsGchgM92ccF3t72FEe9LVAvl7lCrrYeeFOO8zJ64ZT
         2ybSktUTfDZZZLdHg8zSw8e1ec27px9ePwY9MnB0H7rBuq7qBRwXzFkOnF3dnpWdX0jB
         LRLB9BWbj3el7zIqoGpnFgFMv4AQwb+95p8V+j1yGeoMuHmwGsMP1Omv6XWKXBzNy/lB
         zRoIB4tU5Qz4Yq14WYtoOhZtdlysZS+SdZEhxHBe0pd8nULiS3omZaQdgyFmMP7glm/B
         FK6tomtGHv+ioD9nzegtp43B6Y1pl3q93xMPa2Ogt+72U7mHf6LdE7Oom7gxMdQAMBIj
         Ddwg==
X-Gm-Message-State: AJIora/TPUJ9Z9Dr8T1zxP2mg0Q0bo4rBMfue2PWI3I+8Oc0vrimOqTM
        VWbDJCAUdcoPuXjWbUolE4huQJgZ3n6uWVWEbz8=
X-Google-Smtp-Source: AGRyM1uY90hDwMAzJiSEhOS+KxqpEUMEj0PtXguKnyRsoCRLbRPV6uXZehCfsoU2m+a2dj5S+PqTG20d84jl5y6hGN0=
X-Received: by 2002:a05:6000:1a87:b0:21d:b5b9:7666 with SMTP id
 f7-20020a0560001a8700b0021db5b97666mr7401346wry.1.1657787673505; Thu, 14 Jul
 2022 01:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220714031645.28004-1-schspa@gmail.com>
In-Reply-To: <20220714031645.28004-1-schspa@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 14 Jul 2022 16:34:22 +0800
Message-ID: <CAJhGHyD=7t+-Env=Wim-3atq=qJg1j5EKiTvsbqhX1xCdi27Wg@mail.gmail.com>
Subject: Re: [PATCH v3] workqueue: Use active mask for new worker when pool is DISASSOCIATED
To:     Schspa Shi <schspa@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        zhaohui.shi@horizon.ai, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:16 AM Schspa Shi <schspa@gmail.com> wrote:
>
> When CPU-[un]hotplugs, all workers will be bound to active CPU via
> unbind_workers().
>
> But the unbound worker still has a chance to create a new worker, which
> has bound the newly created task to pool->attrs->cpumask. But the CPU has
> been unplugged.
>
> Please refer to the following scenarios.
>
>            CPU0                                  CPU1
> ------------------------------------------------------------------
> sched_cpu_deactivate(cpu_active_mask clear)
> workqueue_offline_cpu(work pool POOL_DISASSOCIATED)
>   -- all worker will migrate to another cpu --
>                                     worker_thread
>                                     -- will create new worker if
>                                        pool->worklist is not empty
>                                        create_worker()
>                                      -- new kworker will bound to CPU0

How will the new kworker bound to CPU0?  Could you give more details?

Since the pool is POOL_DISASSOCIATED and kthread_is_per_cpu() will
be false for the new worker. ttwu() will put it on a fallback CPU IIUC
(see select_task_rq()).

>                                (pool->attrs->cpumask will be mask of CPU0).
>       kworker/0:x will running on rq
>
> sched_cpu_dying
>   if (rq->nr_running != 1 || rq_has_pinned_tasks(rq))
>     WARN(true, "Dying CPU not properly vacated!");
>       ---------OOPS-------------
>


> The stack trace of the bad running task was dumped via the following patch:
> Link: https://lore.kernel.org/all/20220519161125.41144-1-schspa@gmail.com/
> And I think this debug patch needs to be added to the mainline,
> it can help us to debug this kind of problem
>
> To fix it, we can use cpu_active_mask when work pool is DISASSOCIATED.

use wq_unbound_cpumask.

>
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Please solo CC Peter, as:

CC: Peter Zijlstra <peterz@infradead.org>

>
> --
>
> Changelog:
> v1 -> v2:
>         - Move worker task bind to worker_attach_to_pool, remove extra
>         wq_pool_attach_mutex added.
>         - Add a timing diagram to make this question clearer.
> v2 -> v3:
>         - Add missing PF_NO_SETAFFINITY, use cpumask_intersects to
>         avoid setting bad mask for unbound work pool as Lai Jiangshan
>         advised.
>         - Call kthread_set_pre_cpu correctly for unbound worker.
> ---
>  kernel/workqueue.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 1ea50f6be843..b3e9289d9640 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1860,8 +1860,16 @@ static struct worker *alloc_worker(int node)
>  static void worker_attach_to_pool(struct worker *worker,
>                                    struct worker_pool *pool)
>  {
> +       const struct cpumask *cpu_mask;
> +
>         mutex_lock(&wq_pool_attach_mutex);
>
> +       if (cpumask_intersects(pool->attrs->cpumask, cpu_active_mask))
> +               cpu_mask = pool->attrs->cpumask;
> +       else
> +               cpu_mask = wq_unbound_cpumask;
> +
> +       set_cpus_allowed_ptr(worker->task, cpu_mask);
>         /*
>          * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>          * stable across this function.  See the comments above the flag
> @@ -1870,10 +1878,8 @@ static void worker_attach_to_pool(struct worker *worker,
>         if (pool->flags & POOL_DISASSOCIATED)
>                 worker->flags |= WORKER_UNBOUND;
>         else
> -               kthread_set_per_cpu(worker->task, pool->cpu);
> -
> -       if (worker->rescue_wq)
> -               set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> +               kthread_set_per_cpu(worker->task,
> +                               cpu_mask == wq_unbound_cpumask ? -1 : pool->cpu);

Only workers for percpu pool need to set kthread_set_per_cpu().
So it is already handled in the above code, the branch is unneeded.

>
>         list_add_tail(&worker->node, &pool->workers);
>         worker->pool = pool;
> @@ -1952,8 +1958,8 @@ static struct worker *create_worker(struct worker_pool *pool)
>                 goto fail;
>
>         set_user_nice(worker->task, pool->attrs->nice);
> -       kthread_bind_mask(worker->task, pool->attrs->cpumask);
>
> +       worker->task->flags |= PF_NO_SETAFFINITY;
>         /* successful, attach the worker to the pool */
>         worker_attach_to_pool(worker, pool);
>
> --
> 2.29.0
>
