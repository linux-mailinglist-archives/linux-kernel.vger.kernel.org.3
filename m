Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B8753A5E1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347557AbiFANWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbiFANW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:22:27 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE04FC40
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:22:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2ef5380669cso18070777b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhusuxvebQeqIphuHKHIUuQtEdSN4sp1zhl3QpbUxns=;
        b=YVxD9TPOCfh1WNfBWubBysJ8IwakpXPCIrSFx+JDGiMo41+fexBw54QsiegVVeULTa
         NRyH2RMc4g1/XmDyCiJfnU4nRVD5jl9XeCmsQSx6Yf1e4I83h7I8XMXwvDQerk4iRMop
         FrSSFm85U6rXhVd0NFs+inKQUtiXr5aWqz3i83D4VtjKdA3rnMnB9pwZx9m+tqKVfgey
         phqHSwsGphl4ens97yGIWYIdRDkLVnMZZGl7nqD9PpJmaEcwqc3r/4ugaEXG/eXC5kKC
         5Tw/8QU5QdRhTN9Dhaii+4f/ojJ83Ah4zFPfqNPt9Bb1DJo0Dj2/V+nWR3PA7nzlygba
         9I1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhusuxvebQeqIphuHKHIUuQtEdSN4sp1zhl3QpbUxns=;
        b=rbhMmMSB7To+tAHZZHTUGrLSHRkM4cq8/cdoe+C/R8c9YLWOJvaxQpEta6YKKJCuvG
         V8ANzLpcFOYToykqy1Wt+9FOKT5lijq0+ZqPzAb1DClXprBIoaTjzzGdYlnyripESgC0
         5mlqWcP3jTmegLpWY+HvmRdFhH5owAiaCv6iMT6iCdFmTX6jGv2/YxOFIG/9/MDZkk2+
         Qjx1zBDQHwD+szpe27jmTp/PAEUCBOviz3OpZ6vBvS0wcA1wTCcPb9toAF40G0Jr3SCc
         B772fZml+h23P6aMNW/ZcnjAgojYe7N5hC894/Q5Y1Iq32UIQKyMtu80nS/w3P2Uehje
         xRLg==
X-Gm-Message-State: AOAM531+b7kxJhoJiLsGK8gpwLUkNLW72/p24YZXUky+RboEO8PE+q1i
        xZ4lLVi45ePnQuYTNwTZRmn3VweyJe1vtVDIJIH5SA==
X-Google-Smtp-Source: ABdhPJwJkD2o+tUMBt3iBFEPAW7htjoMwWR0vQrC/Lhd9n5ey4SmVO9dop14EBdFhurPVkN4pnK4mQ8SMFdy15dYahs=
X-Received: by 2002:a81:6189:0:b0:2eb:deb5:9f63 with SMTP id
 v131-20020a816189000000b002ebdeb59f63mr66706723ywb.319.1654089744536; Wed, 01
 Jun 2022 06:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220601021848.76943-1-zhouchengming@bytedance.com>
In-Reply-To: <20220601021848.76943-1-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 1 Jun 2022 15:22:12 +0200
Message-ID: <CAKfTPtBTj4u-NW4NDUORdWfdxsHwoMxzqEO4jAKVZDjyCKxL4w@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: optimize and simplify rq leaf_cfs_rq_list
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com
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

On Wed, 1 Jun 2022 at 04:19, Chengming Zhou <zhouchengming@bytedance.com> wrote:
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

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v4:
>  - make sure the attach/detach is propagated down up to
>    the throttled cfs_rq. Thanks Vincent.
>
> v3:
>  - fix !CONFIG_FAIR_GROUP_SCHED build error, reported by
>    kernel test robot <lkp@intel.com>
>
> v2:
>  - move throttled_hierarchy() outside list_add_leaf_cfs_rq(),
>    suggested by Vincent.
> ---
>  kernel/sched/fair.c | 92 ++++++++++++++-------------------------------
>  1 file changed, 28 insertions(+), 64 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 77b2048a9326..b3371fa40548 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3144,6 +3144,8 @@ void reweight_task(struct task_struct *p, int prio)
>         load->inv_weight = sched_prio_to_wmult[prio];
>  }
>
> +static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  #ifdef CONFIG_SMP
>  /*
> @@ -3254,8 +3256,6 @@ static long calc_group_shares(struct cfs_rq *cfs_rq)
>  }
>  #endif /* CONFIG_SMP */
>
> -static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
> -
>  /*
>   * Recomputes the group entity based on the current state of its group
>   * runqueue.
> @@ -4368,16 +4368,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
> @@ -4992,11 +4987,18 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
> @@ -5034,31 +5036,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
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
> @@ -5713,13 +5696,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
> @@ -5743,21 +5719,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
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
> @@ -11287,9 +11248,13 @@ static inline bool vruntime_normalized(struct task_struct *p)
>   */
>  static void propagate_entity_cfs_rq(struct sched_entity *se)
>  {
> -       struct cfs_rq *cfs_rq;
> +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +
> +       if (cfs_rq_throttled(cfs_rq))
> +               return;
>
> -       list_add_leaf_cfs_rq(cfs_rq_of(se));
> +       if (!throttled_hierarchy(cfs_rq))
> +               list_add_leaf_cfs_rq(cfs_rq);
>
>         /* Start to propagate at parent */
>         se = se->parent;
> @@ -11297,14 +11262,13 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>         for_each_sched_entity(se) {
>                 cfs_rq = cfs_rq_of(se);
>
> -               if (!cfs_rq_throttled(cfs_rq)){
> -                       update_load_avg(cfs_rq, se, UPDATE_TG);
> -                       list_add_leaf_cfs_rq(cfs_rq);
> -                       continue;
> -               }
> +               update_load_avg(cfs_rq, se, UPDATE_TG);
>
> -               if (list_add_leaf_cfs_rq(cfs_rq))
> +               if (cfs_rq_throttled(cfs_rq))
>                         break;
> +
> +               if (!throttled_hierarchy(cfs_rq))
> +                       list_add_leaf_cfs_rq(cfs_rq);
>         }
>  }
>  #else
> --
> 2.36.1
>
