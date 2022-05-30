Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77751537612
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiE3HyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbiE3HxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:53:17 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707822FFD6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:52:48 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v106so10739164ybi.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/1zTEBb1GbIzgA4yGuM39deSQDm1bydfJMrXKF33w4=;
        b=Tk6TTLKy1Beg4WI6uk3BASbbJebW9Pu13r1ZLVWgE7Iw5FDk5ke78cDU4Yx2FBAJFa
         ouWYYOYXvmlyySSrm/1OrXn2kpUsF0g023NsETBt4CGZ8KMxQQIIlXnPI6ewSdumz7VM
         iZhehshwlhV4/rOGThYB7ilBRdhk9b7nrnuiyu6kmpO+mH1ULgXnAVbFIzrJAtX/ke9c
         o3vY/E8lzVWinB+CCYRKWh/0c4dBLgnbE1++MN+MclZeTLcfUxuh1PMLPs6ZEmEE+83B
         bbfDKc7Am/F1jZt/i7mef1ylFT+ynnGi8TnaaWgFlWDzA3ycNYMrKxTRzCJrONnZHuk3
         CC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/1zTEBb1GbIzgA4yGuM39deSQDm1bydfJMrXKF33w4=;
        b=LP3gLD3bZ/FP8I2hwoiPNJoutqKGpJwAZdnkADLNo7Yvj6QwIAqdbGJHVWFU2d0o3H
         T/RBGVG8TonXEiBVJPRvOVqplGOPCFuZ/xvA1DZIxyl6XXE6juwJG787asIb4UqPRcSs
         rN/05ruRZTcAoPCs31T0y/+5aesjAqklovcrYnZ07vGJr+F2Um1ZYkZfq0Zp8OimDf27
         PJfi01vVeB9iy+MQIFDE9Hk6ESyN6XuLpy6/S2EXWKJx37DlLyC3ZMgaWJbW9nswU0gf
         O1zPfKTJ6hUj+Wt4g5cJ7Xb6ygQVC+Ll9gr/VWi/m661LXs2+uE0RpBYNA6IojKLxODk
         3+0w==
X-Gm-Message-State: AOAM532B3Um7Txlat9urw26QdZ+6zZa+5TJ3+FhcHLThkcpJhyxB29QK
        Wsx1/kpvXZU1VXnlyJ3t0NypCathjH9nv9KKF23fbQ==
X-Google-Smtp-Source: ABdhPJwSWKlOqZSNsGx8gH/bXidoWACFcjofWglZMwMou7EgpmlJFIIta+gjxSOQL3p4UCQ8VK1t1F0K09u8jEHBwgc=
X-Received: by 2002:a05:6902:514:b0:65c:b28c:f9f8 with SMTP id
 x20-20020a056902051400b0065cb28cf9f8mr7995021ybs.403.1653897167536; Mon, 30
 May 2022 00:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220526103929.14976-1-zhouchengming@bytedance.com> <20220526103929.14976-3-zhouchengming@bytedance.com>
In-Reply-To: <20220526103929.14976-3-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 May 2022 09:52:36 +0200
Message-ID: <CAKfTPtADKqVSvUFmLRPCU_XGVvf3wme0EnnvPf1Q39HEs=VqRw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] sched/fair: optimize and simplify rq leaf_cfs_rq_list
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        odin@uged.al, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
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

On Thu, 26 May 2022 at 12:40, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> We notice the rq leaf_cfs_rq_list has two problems when do bugfix
> backports and some test profiling.
>
> 1. cfs_rqs under throttled subtree could be added to the list, and
>    make their fully decayed ancestors on the list, even though not needed.
>
> 2. #1 also make the leaf_cfs_rq_list management complex and error prone,
>    this is the list of related bugfix so far:
>
>    commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
>    commit fe61468b2cbc ("sched/fair: Fix enqueue_task_fair warning")
>    commit b34cb07dde7c ("sched/fair: Fix enqueue_task_fair() warning some more")
>    commit 39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list")
>    commit 0258bdfaff5b ("sched/fair: Fix unfairness caused by missing load decay")
>    commit a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
>    commit fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
>    commit 2630cde26711 ("sched/fair: Add ancestors of unthrottled undecayed cfs_rq")
>
> commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
> delete every cfs_rq under throttled subtree from rq->leaf_cfs_rq_list,
> and delete the throttled_hierarchy() test in update_blocked_averages(),
> which optimized update_blocked_averages().
>
> But those later bugfix add cfs_rqs under throttled subtree back to
> rq->leaf_cfs_rq_list again, with their fully decayed ancestors, for
> the integrity of rq->leaf_cfs_rq_list.
>
> This patch takes another method, skip all cfs_rqs under throttled
> hierarchy when list_add_leaf_cfs_rq(), to completely make cfs_rqs
> under throttled subtree off the leaf_cfs_rq_list.
>
> So we don't need to consider throttled related things in
> enqueue_entity(), unthrottle_cfs_rq() and enqueue_task_fair(),
> which simplify the code a lot. Also optimize update_blocked_averages()
> since cfs_rqs under throttled hierarchy and their ancestors
> won't be on the leaf_cfs_rq_list.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v3:
>  - fix !CONFIG_FAIR_GROUP_SCHED build error, reported by
>    kernel test robot <lkp@intel.com>
>
> v2:
>  - move throttled_hierarchy() outside list_add_leaf_cfs_rq(),
>    suggested by Vincent.
> ---
>  kernel/sched/fair.c | 81 ++++++++++++---------------------------------
>  1 file changed, 22 insertions(+), 59 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c6da204f3068..48ff4330d68a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3114,6 +3114,8 @@ void reweight_task(struct task_struct *p, int prio)
>         load->inv_weight = sched_prio_to_wmult[prio];
>  }
>
> +static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  #ifdef CONFIG_SMP
>  /*
> @@ -3224,8 +3226,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>  }
>  #endif /* CONFIG_SMP */
>
> -static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
> -
>  /*
>   * Recomputes the group entity based on the current state of its group
>   * runqueue.
> @@ -4338,16 +4338,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>                 __enqueue_entity(cfs_rq, se);
>         se->on_rq = 1;
>
> -       /*
> -        * When bandwidth control is enabled, cfs might have been removed
> -        * because of a parent been throttled but cfs->nr_running > 1. Try to
> -        * add it unconditionally.
> -        */
> -       if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
> -               list_add_leaf_cfs_rq(cfs_rq);
> -
> -       if (cfs_rq->nr_running == 1)
> +       if (cfs_rq->nr_running == 1) {
>                 check_enqueue_throttle(cfs_rq);
> +               if (!throttled_hierarchy(cfs_rq))
> +                       list_add_leaf_cfs_rq(cfs_rq);
> +       }
>  }
>
>  static void __clear_buddies_last(struct sched_entity *se)
> @@ -4962,11 +4957,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>         /* update hierarchical throttle state */
>         walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
>
> -       /* Nothing to run but something to decay (on_list)? Complete the branch */
>         if (!cfs_rq->load.weight) {
> -               if (cfs_rq->on_list)
> -                       goto unthrottle_throttle;
> -               return;
> +               if (!cfs_rq->on_list)
> +                       return;
> +               /*
> +                * Nothing to run but something to decay (on_list)?
> +                * Complete the branch.
> +                */
> +               for_each_sched_entity(se) {
> +                       if (list_add_leaf_cfs_rq(cfs_rq_of(se)))
> +                               break;
> +               }
> +               goto unthrottle_throttle;
>         }
>
>         task_delta = cfs_rq->h_nr_running;
> @@ -5004,31 +5006,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(qcfs_rq))
>                         goto unthrottle_throttle;
> -
> -               /*
> -                * One parent has been throttled and cfs_rq removed from the
> -                * list. Add it back to not break the leaf list.
> -                */
> -               if (throttled_hierarchy(qcfs_rq))
> -                       list_add_leaf_cfs_rq(qcfs_rq);
>         }
>
>         /* At this point se is NULL and we are at root level*/
>         add_nr_running(rq, task_delta);
>
>  unthrottle_throttle:
> -       /*
> -        * The cfs_rq_throttled() breaks in the above iteration can result in
> -        * incomplete leaf list maintenance, resulting in triggering the
> -        * assertion below.
> -        */
> -       for_each_sched_entity(se) {
> -               struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> -
> -               if (list_add_leaf_cfs_rq(qcfs_rq))
> -                       break;
> -       }
> -
>         assert_list_leaf_cfs_rq(rq);
>
>         /* Determine whether we need to wake up potentially idle CPU: */
> @@ -5683,13 +5666,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto enqueue_throttle;
> -
> -               /*
> -                * One parent has been throttled and cfs_rq removed from the
> -                * list. Add it back to not break the leaf list.
> -                */
> -               if (throttled_hierarchy(cfs_rq))
> -                       list_add_leaf_cfs_rq(cfs_rq);
>         }
>
>         /* At this point se is NULL and we are at root level*/
> @@ -5713,21 +5689,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 update_overutilized_status(rq);
>
>  enqueue_throttle:
> -       if (cfs_bandwidth_used()) {
> -               /*
> -                * When bandwidth control is enabled; the cfs_rq_throttled()
> -                * breaks in the above iteration can result in incomplete
> -                * leaf list maintenance, resulting in triggering the assertion
> -                * below.
> -                */
> -               for_each_sched_entity(se) {
> -                       cfs_rq = cfs_rq_of(se);
> -
> -                       if (list_add_leaf_cfs_rq(cfs_rq))
> -                               break;
> -               }
> -       }
> -
>         assert_list_leaf_cfs_rq(rq);
>
>         hrtick_update(rq);
> @@ -11257,9 +11218,10 @@ static inline bool vruntime_normalized(struct task_struct *p)
>   */
>  static void propagate_entity_cfs_rq(struct sched_entity *se)
>  {
> -       struct cfs_rq *cfs_rq;
> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>
> -       list_add_leaf_cfs_rq(cfs_rq_of(se));
> +       if (!throttled_hierarchy(cfs_rq))
> +               list_add_leaf_cfs_rq(cfs_rq);
>
>         /* Start to propagate at parent */
>         se = se->parent;
> @@ -11268,7 +11230,8 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>                 cfs_rq = cfs_rq_of(se);
>

 you can break  if the cfs is throttled because it's sched_entity has
been dequeued. In this case we check if the cfs is throttled not if
the hierarchy is throttled

+               if (cfs_rq_throttled(cfs_rq))
+                       break;

>                 update_load_avg(cfs_rq, se, UPDATE_TG);
> -               list_add_leaf_cfs_rq(cfs_rq);
> +               if (!throttled_hierarchy(cfs_rq))
> +                       list_add_leaf_cfs_rq(cfs_rq);
>         }
>  }
>  #else
> --
> 2.36.1
>
