Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6784EAA06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiC2JFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiC2JFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:05:42 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDCF227C7F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:03:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 17so22538213ljw.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHqHIDlWyaIt4ObUYDGs677A2WiiBuE3HjIZGSfA4Ag=;
        b=LUBjyN6fGeb3o+FKkRYxO2blHV90suUJ55mf7DVxKxRtYNCkz2c2Ur6tYupkzyF29H
         UBqNGuupjb9Li3WIUoWtUtCrA4TVQvdGIHNjyQwPm9lh/hTi0gt+E2/QixDDz3veAewo
         vMCg0ZDe+X3VcUv2q/ZmpvB69+0VAdiG1TSMECDTizaAgBOYPNWLa8g9eoebTRt9Aofj
         KDqjlGVbsCU2M4UOpfJXb1uliOeORxnxGqSkMskwVRnv7P/KTYTGc9Jer6w2kpuTg8qe
         XMi8aAgcGqY2uTGPkUZLtKcENTzJYhqu4M72Q2oKHzsoYVWoS+bHokHJc5dTq3jGQW8z
         bwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHqHIDlWyaIt4ObUYDGs677A2WiiBuE3HjIZGSfA4Ag=;
        b=GrazTyTUfpXqlPXjEzHM1ZWKWEGW+JzxCGzm5UTTxriogI5xWiptNFF+vLcdKUumb6
         AoemWuON8lAU6Ivo3In4PwznwK6YrbIeNRJqlsr55MwLdUvzh19TQuWAN5ZlEE7QuR5c
         M/roFwHd28drCF7mDV5TNWTClhElRylZzmuMa5d5yKm/HHVenD8QgEBV5UWNMSjkA+zz
         g1p+6b7Vmmo+Rb80oD1rhFc0ivQF7meq7OAi8u1GLCg/6YlNDnDNaSf22ZVAA+Aotivu
         MXa1rfK/Q0EXUdra28OY666ob2rWU2RX7s5de3mq4QuBBOHmKEqKhGbWTsNii8KUIo1j
         OZGw==
X-Gm-Message-State: AOAM532Dc9xqkpOfpjurHnxlonvTaK8xsQtJ/z2pauhW5G0e0Sp1oo9n
        u7zgCvYJAo+Xh3nVP+BuloJm0/Wj+TtX1v1BgGAWIGX0Uwo=
X-Google-Smtp-Source: ABdhPJzLFO14Rab8jf7eqttJ5NTqNlJN0+s8qXi6WEziTrTyBDKBXShwB+Dqchrpbjgo4xJBrxs1qhse5z3yyiERLic=
X-Received: by 2002:a2e:7d05:0:b0:247:ed41:690d with SMTP id
 y5-20020a2e7d05000000b00247ed41690dmr1748161ljc.92.1648544636029; Tue, 29 Mar
 2022 02:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648228023.git.tim.c.chen@linux.intel.com> <f59f1dfeec4692e7a373cc810168912a2d2f8f3c.1648228023.git.tim.c.chen@linux.intel.com>
In-Reply-To: <f59f1dfeec4692e7a373cc810168912a2d2f8f3c.1648228023.git.tim.c.chen@linux.intel.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 29 Mar 2022 11:03:44 +0200
Message-ID: <CAKfTPtBDA1uZ1xvo_uhqnNVg69DPXXJBeo0+aQdVJiosB_qgrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Simple runqueue order on migrate
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>,
        Juri Lelli <juri.lelli@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Walter Mack <walter.mack@intel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
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

On Sat, 26 Mar 2022 at 00:52, Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> There's a number of problems with SMP migration of fair tasks, but
> basically it boils down to a task not receiving equal service on each
> runqueue (consider the trivial 3 tasks 2 cpus infeasible weight
> scenario).
>
> Fully solving that with vruntime placement is 'hard', not least
> because a task might be very under-services on a busy runqueue and
> would need to be placed so far left on the new runqueue that it would
> significantly impact latency on the existing tasks.
>
> Instead do minimal / basic placement instead; when moving to a less
> busy queue place at the front of the queue to receive time sooner.
> When moving to a busier queue, place at the end of the queue to
> receive time later.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> Tested-by: Chen Yu <yu.c.chen@intel.com>
> Tested-by: Walter Mack <walter.mack@intel.com>
> ---
>  kernel/sched/fair.c     | 33 +++++++++++++++++++++++++++++----
>  kernel/sched/features.h |  2 ++
>  2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2498e97804fd..c5d2cb3a8f42 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4223,6 +4223,27 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>         se->vruntime = max_vruntime(se->vruntime, vruntime);
>  }
>
> +static void place_entity_migrate(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +{
> +       if (!sched_feat(PLACE_MIGRATE))
> +               return;
> +
> +       if (cfs_rq->nr_running < se->migrated) {
> +               /*
> +                * Migrated to a shorter runqueue, go first because
> +                * we were under-served on the old runqueue.
> +                */
> +               se->vruntime = cfs_rq->min_vruntime;
> +               return;
> +       }
> +
> +       /*
> +        * Migrated to a longer runqueue, go last because
> +        * we got over-served on the old runqueue.
> +        */
> +       se->vruntime = cfs_rq->min_vruntime + sched_vslice(cfs_rq, se);
> +}
> +
>  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
>
>  static inline bool cfs_bandwidth_used(void);
> @@ -4296,6 +4317,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>
>         if (flags & ENQUEUE_WAKEUP)
>                 place_entity(cfs_rq, se, 0);
> +       else if (se->migrated)
> +               place_entity_migrate(cfs_rq, se);
>
>         check_schedstat_required();
>         update_stats_enqueue_fair(cfs_rq, se, flags);
> @@ -6930,6 +6953,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se);
>   */
>  static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  {
> +       struct sched_entity *se = &p->se;
>         /*
>          * As blocked tasks retain absolute vruntime the migration needs to
>          * deal with this by subtracting the old and adding the new
> @@ -6962,7 +6986,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>                  * rq->lock and can modify state directly.
>                  */
>                 lockdep_assert_rq_held(task_rq(p));
> -               detach_entity_cfs_rq(&p->se);
> +               detach_entity_cfs_rq(se);
>
>         } else {
>                 /*
> @@ -6973,14 +6997,15 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>                  * wakee task is less decayed, but giving the wakee more load
>                  * sounds not bad.
>                  */
> -               remove_entity_load_avg(&p->se);
> +               remove_entity_load_avg(se);
>         }
>
>         /* Tell new CPU we are migrated */
> -       p->se.avg.last_update_time = 0;
> +       se->avg.last_update_time = 0;
>
>         /* We have migrated, no longer consider this task hot */
> -       p->se.migrated = 1;
> +       for_each_sched_entity(se)
> +               se->migrated = READ_ONCE(cfs_rq_of(se)->nr_running) + !se->on_rq;

Why do we need to loop on se ? Isn't p->se enough ?


>
>         update_scan_period(p, new_cpu);
>  }
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 1cf435bbcd9c..681c84fd062c 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -100,3 +100,5 @@ SCHED_FEAT(LATENCY_WARN, false)
>
>  SCHED_FEAT(ALT_PERIOD, true)
>  SCHED_FEAT(BASE_SLICE, true)
> +
> +SCHED_FEAT(PLACE_MIGRATE, true)
> --
> 2.32.0
>
