Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698DE59D1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbiHWHGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbiHWHGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:06:48 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4445F103
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:06:47 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3321c2a8d4cso355694527b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/VZ+8gqWMc5SuiAW7cn4NthDTzYEkNKTRNy3A9FXCw8=;
        b=qcQhAQwZS5+iwwm9CEo4+94Wm5hSo1vdDpyEz6lmSJLKEdKtiAbxIieGVphEtCBMjW
         3DxNA9M/1SSPa4hNvPF9gKe1lXFnK4m4mFWJl2n9M8u0+Wvce64u0yS4ZeLuSmdLkptB
         NGf66sCSSxmE+Y2vsiQ7u1t0qcA1JhIIVU+GHHg5gVAs4rApfzzCUt8EXs4A6I1UM9Qb
         BghKwY2+TbkApv1trDpCJBIz0QC8ajAtdTqxgcSrClXATyTIKanPvj9A8pyfvBtJ+BTc
         BZJNu7Yeup7sAugh/u08cD0+vYEJFmeGCLb7s0agBUvjN5tuJNNoNCKLBUcfCkMlpT1f
         I5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/VZ+8gqWMc5SuiAW7cn4NthDTzYEkNKTRNy3A9FXCw8=;
        b=5j4ryPTOzBUuORz+TRJ04b56g3ffKf8rnvW3CqwisikyO/4hNLtZoUqvq5AkwB2RZG
         ye1HtX2u73lYc91rr+ZB6j1uaH3xpz/DiBsNO3wuUQqm6CRjSCu2QEedPxPxlpaIUban
         6D6bQJ5BTRXQURjcUgZXvmTPPulIxbAtRsTu9uU9JfYlTaI3sfMR71F+80RGBgpuon4C
         h+I4TaLlFdjxf+sg2vI1t9aOXd7B0low4tudQ53+YwBXHnXAAUy7UOriFAEyxFOyd6Pt
         a41tFVT+AWiHatorAe2Yq2y8QF8olZ9Doz9J+L6JYaKkXLEowRHdUJPu+WLwRONsNpql
         NJyg==
X-Gm-Message-State: ACgBeo0aeKGfr5xqYT3fQzAjwB665nuE2h64n8Qic2idESAysoWe1HSH
        E20rsH7dMtC46RrU9suPs/sHIOFoCi6vTqOtGj/Pm53i6Gw=
X-Google-Smtp-Source: AA6agR7DEETjpcUroRTP9Dc3/p7nAUpJQGJR/2SDvwgzFbAym/184htae0CZzwEGYahSMz1yvUsLlu8l6YN1hFirU7U=
X-Received: by 2002:a25:2fca:0:b0:68f:aa4f:4a41 with SMTP id
 v193-20020a252fca000000b0068faa4f4a41mr22744327ybv.403.1661238406276; Tue, 23
 Aug 2022 00:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220818124805.601-1-zhouchengming@bytedance.com> <20220818124805.601-7-zhouchengming@bytedance.com>
In-Reply-To: <20220818124805.601-7-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Aug 2022 09:06:34 +0200
Message-ID: <CAKfTPtBXcei4P3iEhyJJdqL-FwW9kaZkHh3_rB51mBQgRVszDA@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] sched/fair: fix another detach on unattached task
 corner case
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     dietmar.eggemann@arm.com, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 at 14:48, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> commit 7dc603c9028e ("sched/fair: Fix PELT integrity for new tasks")
> fixed two load tracking problems for new task, including detach on
> unattached new task problem.
>
> There still left another detach on unattached task problem for the task
> which has been woken up by try_to_wake_up() and waiting for actually
> being woken up by sched_ttwu_pending().
>
> try_to_wake_up(p)
>   cpu = select_task_rq(p)
>   if (task_cpu(p) != cpu)
>     set_task_cpu(p, cpu)
>       migrate_task_rq_fair()
>         remove_entity_load_avg()       --> unattached
>         se->avg.last_update_time = 0;
>       __set_task_cpu()
>   ttwu_queue(p, cpu)
>     ttwu_queue_wakelist()
>       __ttwu_queue_wakelist()
>
> task_change_group_fair()
>   detach_task_cfs_rq()
>     detach_entity_cfs_rq()
>       detach_entity_load_avg()   --> detach on unattached task
>   set_task_rq()
>   attach_task_cfs_rq()
>     attach_entity_cfs_rq()
>       attach_entity_load_avg()
>
> The reason of this problem is similar, we should check in detach_entity_cfs_rq()
> that se->avg.last_update_time != 0, before do detach_entity_load_avg().
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1eb3fb3d95c3..eba8a64f905a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11721,6 +11721,17 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
>  {
>         struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
> +#ifdef CONFIG_SMP
> +       /*
> +        * In case the task sched_avg hasn't been attached:
> +        * - A forked task which hasn't been woken up by wake_up_new_task().
> +        * - A task which has been woken up by try_to_wake_up() but is
> +        *   waiting for actually being woken up by sched_ttwu_pending().
> +        */
> +       if (!se->avg.last_update_time)
> +               return;
> +#endif
> +
>         /* Catch up with the cfs_rq and remove our load when we leave */
>         update_load_avg(cfs_rq, se, 0);
>         detach_entity_load_avg(cfs_rq, se);
> --
> 2.37.2
>
