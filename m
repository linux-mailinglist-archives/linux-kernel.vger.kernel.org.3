Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5262359D2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbiHWHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbiHWHzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:55:12 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973DD399F2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:55:11 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3375488624aso328910747b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=6/q2WYCT6ZfXsEkC9Bz17XJaiUb6hw25Iag20Qx0nsM=;
        b=fE6rur9XiU74c/LSzQNVVhxXHY2TiKtS5JU2ibRkNiYGAnn15hylS30CGx83K1v8Ff
         9Te1WT8tyaYbQbrrLdJmywA0xqVSGzXquxMxVx2dzkgRWFR/sn7sIThwn+tQXyJqLBgZ
         dgT+yBe3n0/KJ9k8hBRDIjTYBYEl3ZJkvKtsJs6A9jXJACS7lVWX2UZJfl0VQtIjvgII
         YWkWPD4UUSuE7OrMJIdtSzfvyrF67SiX+aX7HKPIW/SDIZOSDjTKt/Rfs/fdChhDawqe
         fjwxmfnvWYasVE0ANnsNlYfo0eiTduyizakEJNYT9XZmwt0+GkdVprJP4bg5UmgIJBmi
         tctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=6/q2WYCT6ZfXsEkC9Bz17XJaiUb6hw25Iag20Qx0nsM=;
        b=spUoM/UTrL56kIjcg3B0r5v9Q9SeR3NlJjjn65XwEBO4V7c6HPjEf59jKyfRw4uiPf
         vAGC29+ZTdIr2fO8i89jJlVZVn/g7+7mkMDn7mpQUPB4ijWolL6fLjZv5HDMJ5evu40w
         MEfv7Z3TXMwOi2quAlM1qFjpvhSovEq3R52/rAPcpQDwcAam6ew/pPrXPXvKPzW9wjRR
         GL0WcHx7pKdeQ23gwOq+uiD0Z7WfQCx9R/e+d3PKnEiu1APhsAdpFI693LSG2m8Y/yuw
         UvbRujw0GsvKHevdQQ48howSWkdwpRhWx0DWlvjhBUVBE7i5dfEh47L/oGYMw/XIVUrb
         aZoA==
X-Gm-Message-State: ACgBeo2rFjOInwTsH9o5Lqk0EiGXK6K1QKHG4/FAR422QgMRIR2+1hhm
        LSK10czXphE4E9+YYm6mMbaZdvX5r7cMMhQq3sUqtg==
X-Google-Smtp-Source: AA6agR5X9J1cHStUXD+eWgp+f5ZhGKrx2w+4FpRFxngJ7RRjcrVhOmd1jOonZDjfF8w8UQfXF7JnqhjZRW7BoYvKFP4=
X-Received: by 2002:a25:d3d1:0:b0:690:807c:9e5 with SMTP id
 e200-20020a25d3d1000000b00690807c09e5mr22810541ybf.424.1661241310788; Tue, 23
 Aug 2022 00:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220818124805.601-1-zhouchengming@bytedance.com> <20220818124805.601-8-zhouchengming@bytedance.com>
In-Reply-To: <20220818124805.601-8-zhouchengming@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Aug 2022 09:54:59 +0200
Message-ID: <CAKfTPtAsEpO_11cCfPu=-RRF2mP4V=5CJL2Ek3t2VUY8nz0Euw@mail.gmail.com>
Subject: Re: [PATCH v6 7/9] sched/fair: allow changing cgroup of new forked task
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
> introduce a TASK_NEW state and an unnessary limitation that would fail
> when changing cgroup of new forked task.
>
> Because at that time, we can't handle task_change_group_fair() for new
> forked fair task which hasn't been woken up by wake_up_new_task(),
> which will cause detach on an unattached task sched_avg problem.
>
> This patch delete this unnessary limitation by adding check before do
> detach or attach in task_change_group_fair().
>
> So cpu_cgrp_subsys.can_attach() has nothing to do for fair tasks,
> only define it in #ifdef CONFIG_RT_GROUP_SCHED.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/core.c | 25 +++++--------------------
>  kernel/sched/fair.c |  7 +++++++
>  2 files changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8e3f1c3f0b2c..14819bd66021 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10290,36 +10290,19 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
>         sched_unregister_group(tg);
>  }
>
> +#ifdef CONFIG_RT_GROUP_SCHED
>  static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
>  {
>         struct task_struct *task;
>         struct cgroup_subsys_state *css;
> -       int ret = 0;
>
>         cgroup_taskset_for_each(task, css, tset) {
> -#ifdef CONFIG_RT_GROUP_SCHED
>                 if (!sched_rt_can_attach(css_tg(css), task))
>                         return -EINVAL;
> -#endif
> -               /*
> -                * Serialize against wake_up_new_task() such that if it's
> -                * running, we're sure to observe its full state.
> -                */
> -               raw_spin_lock_irq(&task->pi_lock);
> -               /*
> -                * Avoid calling sched_move_task() before wake_up_new_task()
> -                * has happened. This would lead to problems with PELT, due to
> -                * move wanting to detach+attach while we're not attached yet.
> -                */
> -               if (READ_ONCE(task->__state) == TASK_NEW)
> -                       ret = -EINVAL;
> -               raw_spin_unlock_irq(&task->pi_lock);
> -
> -               if (ret)
> -                       break;
>         }
> -       return ret;
> +       return 0;
>  }
> +#endif
>
>  static void cpu_cgroup_attach(struct cgroup_taskset *tset)
>  {
> @@ -11155,7 +11138,9 @@ struct cgroup_subsys cpu_cgrp_subsys = {
>         .css_released   = cpu_cgroup_css_released,
>         .css_free       = cpu_cgroup_css_free,
>         .css_extra_stat_show = cpu_extra_stat_show,
> +#ifdef CONFIG_RT_GROUP_SCHED
>         .can_attach     = cpu_cgroup_can_attach,
> +#endif
>         .attach         = cpu_cgroup_attach,
>         .legacy_cftypes = cpu_legacy_files,
>         .dfl_cftypes    = cpu_files,
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index eba8a64f905a..c319b0bd2bc1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11840,6 +11840,13 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  static void task_change_group_fair(struct task_struct *p)
>  {
> +       /*
> +        * We couldn't detach or attach a forked task which
> +        * hasn't been woken up by wake_up_new_task().
> +        */
> +       if (READ_ONCE(p->__state) == TASK_NEW)
> +               return;
> +
>         detach_task_cfs_rq(p);
>
>  #ifdef CONFIG_SMP
> --
> 2.37.2
>
