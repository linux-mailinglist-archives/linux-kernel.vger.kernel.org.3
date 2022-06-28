Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11655E6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347303AbiF1P1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347438AbiF1P1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:27:00 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354192DAB3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:26:53 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id o19so16267445ybg.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rF/IoFS6dEefZ50Zn+gGIbvuml2sqcE3qPyHBncFVp4=;
        b=PGj5xqamKGc5GcW/i6XNREBSQGep0PnX2M/fnLRjgXJoeaYVbqcWq9GUj5UpMLRrHV
         rcsykDQ0moamO9cu/KSUduzxryt1E2xTuGXW89l++XMCWh1lrSoDE1aIkH74wLv4+jiR
         4XGgwhFznMuFDSjfnF3KHiaYqDXZiWBMfUQIGFBjxrzN6EiVsXeS0Zgab0AnLtHI+a6v
         CQ+m693NM6/UA8cCBBe/hv1ns27fY0tSf4Qqxg74WHUqMX8j4Hyv2T3ZJC9DJyXMRxSn
         zo7Z7geIgl1GjDEZgZugnkZTNy7TtisFuEzE29HW0o/NDzuCnzPYSxGZ5ZC/EfNXA/50
         qzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rF/IoFS6dEefZ50Zn+gGIbvuml2sqcE3qPyHBncFVp4=;
        b=jpgMRd+KO6iM1AmncDPKSUsqB5GgLXW8uaXt/SSuk/2F7H2M8ZzMU22PqLR4BTu8oE
         IQJ/Vwc4sF0XTgYUDpbcrKk390JbSthEHwssDm1kVUMsTHV00OA/oaHeX6YP1xoT8jvd
         AohdPmpTp5XzFTS361EWDYDd4DmCFmP2zE17YqznnCz0slRSKyicaqSi64oE7ak5lk/W
         TLpdqowNN3MvKRLPcYmnoa+HEQSguzOXsYRRquQ5I3mIH9P11RJzgKjdDuSWtUTeUq1P
         vJx0XkweCNqyxsk4jdbhW8vpvdkMICwN0jZefa6UmfgQgVID4M6G5vL9XubXz0dIvUZz
         1M0A==
X-Gm-Message-State: AJIora+qpjRnNx4kUhw7jDB6dx2/MZSgnDVdW4VQ8wtNMuYTuwckxDTc
        +gt7E4hqfwhX1ODgaGHTMp5nUW4CSN1O/yyfV5BG6g==
X-Google-Smtp-Source: AGRyM1vHN+vAhxiGieH0dQ/W+mfLaS4GSYbuaAviuaEJSIddxoKTMjLhhQ5pnrivWo/d1b4gt79DTHXWkdhPVyAaPxM=
X-Received: by 2002:a05:6902:1501:b0:66d:2ae0:46b5 with SMTP id
 q1-20020a056902150100b0066d2ae046b5mr3925916ybu.225.1656430012308; Tue, 28
 Jun 2022 08:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220620133608.78498-1-zhouchengming@bytedance.com>
In-Reply-To: <20220620133608.78498-1-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 28 Jun 2022 17:26:41 +0200
Message-ID: <CAKfTPtAUrR97jmifveYCUxmaKJ_95v+N_3DDPVdMnBwrgFdRCw@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: combine detach into dequeue when migrating task
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        bsegall@google.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
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

On Mon, 20 Jun 2022 at 15:36, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> When we are migrating task out of the CPU, we can combine detach and
> propagation into dequeue_entity() to save the detach_entity_cfs_rq()
> -> propagate_entity_cfs_rq() call in detach_entity_cfs_rq() in
> migrate_task_rq_fair().
>
> This optimization is like combining DO_ATTACH in the enqueue_entity()
> when migrating task to the CPU.
> -> propagate_entity_cfs_rq() call in detach_entity_cfs_rq() in
> migrate_task_rq_fair().
>
>
> So we don't have to traverse the CFS tree extra time to do the
> detach_entity_cfs_rq() -> propagate_entity_cfs_rq() call, which
> wouldn't be called anymore with this patch's change.
>
> Copied from Dietmar's much clearer comment:

Although It's nice to keep the author of a comment, it should not be
part of the commit message.

> detach_task()
>   deactivate_task()
>     dequeue_task_fair()
>       for_each_sched_entity(se)
>         dequeue_entity()
>           update_load_avg()   /* (1) */
              detach_entity_load_avg()

> set_task_cpu()
>  migrate_task_rq_fair()
>    detach_entity_cfs_rq() /* (2) */
       update_load_avg();
       detach_entity_load_avg();
       propagate_entity_cfs_rq();
         for_each_sched_entity()
           update_load_avg()

Could you add the full call stack so we can see more easily the extra
loop that is saved
>
> This patch save the propagate_entity_cfs_rq(&p->se) call from (2)
> by doing the detach_entity_load_avg(), update_tg_load_avg() for
> a migrating task inside (1) (the task being the first se in the loop)
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Apart the small nit above:

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v4:
>  - change the commit message a little.
>  - remove the forward declaration of detach_entity_cfs_rq()
>  - remove verbose comments in code.
>
> v3:
>  - change to use task_on_rq_migrating() and put Dietmar's much clearer
>    description in the commit message. Thanks!
>
> v2:
>  - fix !CONFIG_SMP build error
> ---
>  kernel/sched/fair.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8bed75757e65..31d53c11e244 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3931,6 +3931,7 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  #define UPDATE_TG      0x1
>  #define SKIP_AGE_LOAD  0x2
>  #define DO_ATTACH      0x4
> +#define DO_DETACH      0x8
>
>  /* Update task and its cfs_rq load average */
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> @@ -3948,7 +3949,14 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>         decayed  = update_cfs_rq_load_avg(now, cfs_rq);
>         decayed |= propagate_entity_load_avg(se);
>
> -       if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
> +       if (flags & DO_DETACH) {
> +               /*
> +                * DO_DETACH means we're here from dequeue_entity()
> +                * and we are migrating task out of the CPU.
> +                */
> +               detach_entity_load_avg(cfs_rq, se);
> +               update_tg_load_avg(cfs_rq);
> +       } else if (!se->avg.last_update_time && (flags & DO_ATTACH)) {
>
>                 /*
>                  * DO_ATTACH means we're here from enqueue_entity().
> @@ -4241,6 +4249,7 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  #define UPDATE_TG      0x0
>  #define SKIP_AGE_LOAD  0x0
>  #define DO_ATTACH      0x0
> +#define DO_DETACH      0x0
>
>  static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
>  {
> @@ -4460,6 +4469,11 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  static void
>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> +       int action = UPDATE_TG;
> +
> +       if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
> +               action |= DO_DETACH;
> +
>         /*
>          * Update run-time statistics of the 'current'.
>          */
> @@ -4473,7 +4487,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>          *   - For group entity, update its weight to reflect the new share
>          *     of its group cfs_rq.
>          */
> -       update_load_avg(cfs_rq, se, UPDATE_TG);
> +       update_load_avg(cfs_rq, se, action);
>         se_update_runnable(se);
>
>         update_stats_dequeue_fair(cfs_rq, se, flags);
> @@ -6938,8 +6952,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>         return new_cpu;
>  }
>
> -static void detach_entity_cfs_rq(struct sched_entity *se);
> -
>  /*
>   * Called immediately before a task is migrated to a new CPU; task_cpu(p) and
>   * cfs_rq_of(p) references at time of call are still valid and identify the
> @@ -6973,15 +6985,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>                 se->vruntime -= min_vruntime;
>         }
>
> -       if (p->on_rq == TASK_ON_RQ_MIGRATING) {
> -               /*
> -                * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
> -                * rq->lock and can modify state directly.
> -                */
> -               lockdep_assert_rq_held(task_rq(p));
> -               detach_entity_cfs_rq(&p->se);
> -
> -       } else {
> +       if (!task_on_rq_migrating(p)) {
>                 /*
>                  * We are supposed to update the task to "current" time, then
>                  * its up to date and ready to go to new CPU/cfs_rq. But we
> --
> 2.36.1
>
