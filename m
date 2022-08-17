Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71178597266
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbiHQPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240798AbiHQPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:02:18 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146CE9F0E2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:01:45 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-32a09b909f6so238493717b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=lbPakXVvf0pO/MDwf2IisRTTaa6FKaazphM5VE7TAqw=;
        b=MXzFRJZXt4TNK1aaqNdUNhpY05oGVv0KX5D0DEliSjE/Gl+cFvhSDrg0cMFMAb9T3I
         F3oDCe2C5D8VBapUphJJyGZMjn2kf6o4h/y/BijdQwpBwZggVu1XzhgpVnynJpaY6pzx
         SbrEFFI9+RAWaK2aogjSrmPXX6CBTGODtoJJ6TsnZWq9cOyJFISs/414xC3PJiDfbrNK
         MSjx/fcYO5HnR02JKhHU4rcZ4xxkMbV5KcDdH8TcYI7kst4/OLWQ7BxvzumuoWRWXkUE
         0Y2nA3v41WOCVqvnT7J1nccIMYYGPKwSoCCyo+lCZJVhBKSEkBp0Y8NCOrWg8qyHuuJc
         XyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lbPakXVvf0pO/MDwf2IisRTTaa6FKaazphM5VE7TAqw=;
        b=4juWOGXwF3+6mP/pxwuvmohTUbntHdRwcud3A7NbJwoqUHVqllV9y8rj0E4HeJc0qf
         pipx/vG04+E674IVx2+IIwKH0qk3ZopS77ruCGH0ovyTNd9Q6+nuSJ5nPmQuUosrbLn1
         fRfWQMYiDbnJUbODBNdqI4yZO2mIZa5QxflNvIrATMQhCa3sivO6f11T/wg/FeDISb26
         DJUDwFaHWxvetpHZUTIaDVe/o3PWQ2awNVf27VeXhNk6A0PGa4HZ8zu+JRta5A7EXvM1
         5GydRgkN9PEE7RBi/866C0aJyHOF8tXSr2wLXHqkNXGXgDsVizA+bHJ658H9ni6gVkd/
         2ZFw==
X-Gm-Message-State: ACgBeo1CuoFuMtW67AldW8WpgYMx0xY2YBP/de34VMr7TU1d6cXH0rBz
        a/UQ2wvc2Tx+Q52HefRQugOlLSN+FnhIpVImCjcKqQ==
X-Google-Smtp-Source: AA6agR6B6Jbbb/VCn5VrLc1G2+Oi5ow/rQauR3QL0RlM0KP8n/cm3bvQEGF39zW8i5JJY9KTi+nDYfOpnkVoI2x+uN0=
X-Received: by 2002:a05:6902:1107:b0:676:ccf5:474a with SMTP id
 o7-20020a056902110700b00676ccf5474amr19952607ybu.300.1660748504528; Wed, 17
 Aug 2022 08:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220808125745.22566-1-zhouchengming@bytedance.com> <20220808125745.22566-7-zhouchengming@bytedance.com>
In-Reply-To: <20220808125745.22566-7-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 17 Aug 2022 17:01:32 +0200
Message-ID: <CAKfTPtBbKoJ0r=tE+9E9KxHkCy1ucev_DxLRqeQrx39ZzizqGA@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] sched/fair: fix another detach on unattached task
 corner case
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2022 at 14:58, Chengming Zhou <zhouchengming@bytedance.com> wrote:
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
> This patch move detach/attach_entity_cfs_rq() functions up to be together
> with other load tracking functions to avoid to use another #ifdef CONFIG_SMP.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  kernel/sched/fair.c | 132 +++++++++++++++++++++++---------------------
>  1 file changed, 68 insertions(+), 64 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f52e7dc7f22d..4bc76d95a99d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -874,9 +874,6 @@ void init_entity_runnable_average(struct sched_entity *se)
>  void post_init_entity_util_avg(struct task_struct *p)
>  {
>  }
> -static void update_tg_load_avg(struct cfs_rq *cfs_rq)
> -{
> -}
>  #endif /* CONFIG_SMP */
>
>  /*
> @@ -3176,6 +3173,7 @@ void reweight_task(struct task_struct *p, int prio)
>         load->inv_weight = sched_prio_to_wmult[prio];
>  }
>
> +static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
>  static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> @@ -4086,6 +4084,71 @@ static void remove_entity_load_avg(struct sched_entity *se)
>         raw_spin_unlock_irqrestore(&cfs_rq->removed.lock, flags);
>  }
>
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +/*
> + * Propagate the changes of the sched_entity across the tg tree to make it
> + * visible to the root
> + */
> +static void propagate_entity_cfs_rq(struct sched_entity *se)
> +{
> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +       if (cfs_rq_throttled(cfs_rq))
> +               return;
> +
> +       if (!throttled_hierarchy(cfs_rq))
> +               list_add_leaf_cfs_rq(cfs_rq);
> +
> +       /* Start to propagate at parent */
> +       se = se->parent;
> +
> +       for_each_sched_entity(se) {
> +               cfs_rq = cfs_rq_of(se);
> +
> +               update_load_avg(cfs_rq, se, UPDATE_TG);
> +
> +               if (cfs_rq_throttled(cfs_rq))
> +                       break;
> +
> +               if (!throttled_hierarchy(cfs_rq))
> +                       list_add_leaf_cfs_rq(cfs_rq);
> +       }
> +}
> +#else
> +static void propagate_entity_cfs_rq(struct sched_entity *se) { }
> +#endif
> +
> +static void detach_entity_cfs_rq(struct sched_entity *se)
> +{
> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +       /*
> +        * In case the task sched_avg hasn't been attached:
> +        * - A forked task which hasn't been woken up by wake_up_new_task().
> +        * - A task which has been woken up by try_to_wake_up() but is
> +        *   waiting for actually being woken up by sched_ttwu_pending().
> +        */
> +       if (!se->avg.last_update_time)
> +               return;

The 2 lines above and the associated comment are the only relevant
part of the patch, aren't they ?
Is everything else just code moving from one place to another one
without change ?

> +
> +       /* Catch up with the cfs_rq and remove our load when we leave */
> +       update_load_avg(cfs_rq, se, 0);
> +       detach_entity_load_avg(cfs_rq, se);
> +       update_tg_load_avg(cfs_rq);
> +       propagate_entity_cfs_rq(se);
> +}
> +
> +static void attach_entity_cfs_rq(struct sched_entity *se)
> +{
> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +       /* Synchronize entity with its cfs_rq */
> +       update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
> +       attach_entity_load_avg(cfs_rq, se);
> +       update_tg_load_avg(cfs_rq);
> +       propagate_entity_cfs_rq(se);
> +}
> +
>  static inline unsigned long cfs_rq_runnable_avg(struct cfs_rq *cfs_rq)
>  {
>         return cfs_rq->avg.runnable_avg;
> @@ -4308,11 +4371,8 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  }
>
>  static inline void remove_entity_load_avg(struct sched_entity *se) {}
> -
> -static inline void
> -attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
> -static inline void
> -detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
> +static inline void detach_entity_cfs_rq(struct sched_entity *se) {}
> +static inline void attach_entity_cfs_rq(struct sched_entity *se) {}
>
>  static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
>  {
> @@ -11519,62 +11579,6 @@ static inline bool vruntime_normalized(struct task_struct *p)
>         return false;
>  }
>
> -#ifdef CONFIG_FAIR_GROUP_SCHED
> -/*
> - * Propagate the changes of the sched_entity across the tg tree to make it
> - * visible to the root
> - */
> -static void propagate_entity_cfs_rq(struct sched_entity *se)
> -{
> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -
> -       if (cfs_rq_throttled(cfs_rq))
> -               return;
> -
> -       if (!throttled_hierarchy(cfs_rq))
> -               list_add_leaf_cfs_rq(cfs_rq);
> -
> -       /* Start to propagate at parent */
> -       se = se->parent;
> -
> -       for_each_sched_entity(se) {
> -               cfs_rq = cfs_rq_of(se);
> -
> -               update_load_avg(cfs_rq, se, UPDATE_TG);
> -
> -               if (cfs_rq_throttled(cfs_rq))
> -                       break;
> -
> -               if (!throttled_hierarchy(cfs_rq))
> -                       list_add_leaf_cfs_rq(cfs_rq);
> -       }
> -}
> -#else
> -static void propagate_entity_cfs_rq(struct sched_entity *se) { }
> -#endif
> -
> -static void detach_entity_cfs_rq(struct sched_entity *se)
> -{
> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -
> -       /* Catch up with the cfs_rq and remove our load when we leave */
> -       update_load_avg(cfs_rq, se, 0);
> -       detach_entity_load_avg(cfs_rq, se);
> -       update_tg_load_avg(cfs_rq);
> -       propagate_entity_cfs_rq(se);
> -}
> -
> -static void attach_entity_cfs_rq(struct sched_entity *se)
> -{
> -       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> -
> -       /* Synchronize entity with its cfs_rq */
> -       update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
> -       attach_entity_load_avg(cfs_rq, se);
> -       update_tg_load_avg(cfs_rq);
> -       propagate_entity_cfs_rq(se);
> -}
> -
>  static void detach_task_cfs_rq(struct task_struct *p)
>  {
>         struct sched_entity *se = &p->se;
> --
> 2.36.1
>
