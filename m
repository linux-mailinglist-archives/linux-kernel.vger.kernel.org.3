Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901734F9334
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiDHKpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiDHKo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:44:57 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D09A31E1D1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:42:54 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z7so10144487iom.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhNxgwmlQMTZU5E2GrSx+tXlenr728RRVvPqUWfxhg8=;
        b=pa8ypfFvLgt/BgUgDylEye1oeYxyhPff8naQbtSDpue+UeyLftsVDhvBY0UqIxjzKT
         phPkNmM/JM4GM0Z5B7QNzXjhhKu2JLzl1am0K1mkBNIltWJzUp7xEtynRJXuNCKAf0rI
         DsyW+NlKhE2i6XYZLcnuTFgp2ySb+fTU7C/tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhNxgwmlQMTZU5E2GrSx+tXlenr728RRVvPqUWfxhg8=;
        b=ajJYOflJfYUhQ8wf+MFB5Aq2asXUdy6jv9Xxc+RGqeUuqJQaRF8riDL8mGgjU0ybEm
         qmqlazDfAjgjzixvNBYyVMWqyOTtgnivcSV+72kK3PR7QrO4+uimwNfLOXKyZ4zKW1y3
         DBJn1kCI+x0r6ccEkVMMR2zxTo+tkQyP9FI01OmNYUu5qrBs+WXicNtd6niuh1w1Jugg
         y3UNH4WMsNj4+kAE0PMbOK34lTQ56Uf9mih2axfHrRvm5oGgzBjYZuuzy1PPdEcFHEwW
         g5OsT+wL1fE9cD3Kfl19NAIAiXMyN6mOF4k2kOp1Kj31fDhwGliXeSR4+cosfpbnHyUh
         Y5LA==
X-Gm-Message-State: AOAM533R4Oh69XOckbt6lLdqMldcWl7YbA/V8vLTQiGHF1ss9v0AJ9Gb
        6e0hA/bmgnCOhwRL1bOK3X97yINyLHkNbiUJbFklRQ==
X-Google-Smtp-Source: ABdhPJw4Cxq8voB+jIPVILROfT2WEn8sJAjhpLpjK0cG9fdENbRHtzhMU1X9Ux+C4JpmzGIlUccwzxOSBTx8Hh5fIZI=
X-Received: by 2002:a02:95ab:0:b0:324:293b:8d83 with SMTP id
 b40-20020a0295ab000000b00324293b8d83mr2948602jai.304.1649414573392; Fri, 08
 Apr 2022 03:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220408045734.1158817-1-kaleshsingh@google.com>
In-Reply-To: <20220408045734.1158817-1-kaleshsingh@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 8 Apr 2022 06:42:42 -0400
Message-ID: <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT kthread_worker
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        kernel-team <kernel-team@android.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        Tim Murray <timmurray@google.com>, Wei Wang <wvw@google.com>,
        Kyle Lin <kylelin@google.com>,
        Chunwei Lu <chunweilu@google.com>,
        Lulu Wang <luluw@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

On Fri, Apr 8, 2022 at 12:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
[...]
> @@ -334,15 +334,13 @@ static bool exp_funnel_lock(unsigned long s)
>   * Select the CPUs within the specified rcu_node that the upcoming
>   * expedited grace period needs to wait for.
>   */
> -static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> +static void __sync_rcu_exp_select_node_cpus(struct rcu_exp_work *rewp)
>  {
>         int cpu;
>         unsigned long flags;
>         unsigned long mask_ofl_test;
>         unsigned long mask_ofl_ipi;
>         int ret;
> -       struct rcu_exp_work *rewp =
> -               container_of(wp, struct rcu_exp_work, rew_work);
>         struct rcu_node *rnp = container_of(rewp, struct rcu_node, rew);
>
>         raw_spin_lock_irqsave_rcu_node(rnp, flags);
> @@ -417,13 +415,119 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
>                 rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
>  }
>
> +static void rcu_exp_sel_wait_wake(unsigned long s);
> +
> +#ifdef CONFIG_RCU_EXP_KTHREAD

Just my 2c:

Honestly, I am not sure if the benefits of duplicating the code to use
normal workqueues outweighs the drawbacks (namely code complexity,
code duplication - which can in turn cause more bugs and maintenance
headaches down the line). The code is harder to read and adding more
30 character function names does not help.

For something as important as expedited GPs, I can't imagine a
scenario where an RT kthread worker would cause "issues". If it does
cause issues, that's what the -rc cycles and the stable releases are
for. I prefer to trust the process than take a one-foot-in-the-door
approach.

So please, can we just keep it simple?

Thanks,

 - Joel


> +static void sync_rcu_exp_select_node_cpus(struct kthread_work *wp)
> +{
> +       struct rcu_exp_work *rewp =
> +               container_of(wp, struct rcu_exp_work, rew_work);
> +
> +       __sync_rcu_exp_select_node_cpus(rewp);
> +}
> +
> +static inline bool rcu_gp_par_worker_started(void)
> +{
> +       return !!READ_ONCE(rcu_exp_par_gp_kworker);
> +}
> +
> +static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
> +{
> +       kthread_init_work(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> +       /*
> +        * Use rcu_exp_par_gp_kworker, because flushing a work item from
> +        * another work item on the same kthread worker can result in
> +        * deadlock.
> +        */
> +       kthread_queue_work(rcu_exp_par_gp_kworker, &rnp->rew.rew_work);
> +}
> +
> +static inline void sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
> +{
> +       kthread_flush_work(&rnp->rew.rew_work);
> +}
> +
> +/*
> + * Work-queue handler to drive an expedited grace period forward.
> + */
> +static void wait_rcu_exp_gp(struct kthread_work *wp)
> +{
> +       struct rcu_exp_work *rewp;
> +
> +       rewp = container_of(wp, struct rcu_exp_work, rew_work);
> +       rcu_exp_sel_wait_wake(rewp->rew_s);
> +}
> +
> +static inline void synchronize_rcu_expedited_queue_work(struct rcu_exp_work *rew)
> +{
> +       kthread_init_work(&rew->rew_work, wait_rcu_exp_gp);
> +       kthread_queue_work(rcu_exp_gp_kworker, &rew->rew_work);
> +}
> +
> +static inline void synchronize_rcu_expedited_destroy_work(struct rcu_exp_work *rew)
> +{
> +}
> +#else /* !CONFIG_RCU_EXP_KTHREAD */
> +static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
> +{
> +       struct rcu_exp_work *rewp =
> +               container_of(wp, struct rcu_exp_work, rew_work);
> +
> +       __sync_rcu_exp_select_node_cpus(rewp);
> +}
> +
> +static inline bool rcu_gp_par_worker_started(void)
> +{
> +       return !!READ_ONCE(rcu_par_gp_wq);
> +}
> +
> +static inline void sync_rcu_exp_select_cpus_queue_work(struct rcu_node *rnp)
> +{
> +       int cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
> +
> +       INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> +       /* If all offline, queue the work on an unbound CPU. */
> +       if (unlikely(cpu > rnp->grphi - rnp->grplo))
> +               cpu = WORK_CPU_UNBOUND;
> +       else
> +               cpu += rnp->grplo;
> +       queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> +}
> +
> +static inline void sync_rcu_exp_select_cpus_flush_work(struct rcu_node *rnp)
> +{
> +       flush_work(&rnp->rew.rew_work);
> +}
> +
> +/*
> + * Work-queue handler to drive an expedited grace period forward.
> + */
> +static void wait_rcu_exp_gp(struct work_struct *wp)
> +{
> +       struct rcu_exp_work *rewp;
> +
> +       rewp = container_of(wp, struct rcu_exp_work, rew_work);
> +       rcu_exp_sel_wait_wake(rewp->rew_s);
> +}
> +
> +static inline void synchronize_rcu_expedited_queue_work(struct rcu_exp_work *rew)
> +{
> +       INIT_WORK_ONSTACK(&rew->rew_work, wait_rcu_exp_gp);
> +       queue_work(rcu_gp_wq, &rew->rew_work);
> +}
> +
> +static inline void synchronize_rcu_expedited_destroy_work(struct rcu_exp_work *rew)
> +{
> +       destroy_work_on_stack(&rew->rew_work);
> +}
> +#endif /* CONFIG_RCU_EXP_KTHREAD */
> +
>  /*
>   * Select the nodes that the upcoming expedited grace period needs
>   * to wait for.
>   */
>  static void sync_rcu_exp_select_cpus(void)
>  {
> -       int cpu;
>         struct rcu_node *rnp;
>
>         trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("reset"));
> @@ -435,28 +539,21 @@ static void sync_rcu_exp_select_cpus(void)
>                 rnp->exp_need_flush = false;
>                 if (!READ_ONCE(rnp->expmask))
>                         continue; /* Avoid early boot non-existent wq. */
> -               if (!READ_ONCE(rcu_par_gp_wq) ||
> +               if (!rcu_gp_par_worker_started() ||
>                     rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
>                     rcu_is_last_leaf_node(rnp)) {
> -                       /* No workqueues yet or last leaf, do direct call. */
> +                       /* No worker started yet or last leaf, do direct call. */
>                         sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
>                         continue;
>                 }
> -               INIT_WORK(&rnp->rew.rew_work, sync_rcu_exp_select_node_cpus);
> -               cpu = find_next_bit(&rnp->ffmask, BITS_PER_LONG, -1);
> -               /* If all offline, queue the work on an unbound CPU. */
> -               if (unlikely(cpu > rnp->grphi - rnp->grplo))
> -                       cpu = WORK_CPU_UNBOUND;
> -               else
> -                       cpu += rnp->grplo;
> -               queue_work_on(cpu, rcu_par_gp_wq, &rnp->rew.rew_work);
> +               sync_rcu_exp_select_cpus_queue_work(rnp);
>                 rnp->exp_need_flush = true;
>         }
>
> -       /* Wait for workqueue jobs (if any) to complete. */
> +       /* Wait for jobs (if any) to complete. */
>         rcu_for_each_leaf_node(rnp)
>                 if (rnp->exp_need_flush)
> -                       flush_work(&rnp->rew.rew_work);
> +                       sync_rcu_exp_select_cpus_flush_work(rnp);
>  }
>
>  /*
> @@ -622,17 +719,6 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
>         rcu_exp_wait_wake(s);
>  }
>
> -/*
> - * Work-queue handler to drive an expedited grace period forward.
> - */
> -static void wait_rcu_exp_gp(struct work_struct *wp)
> -{
> -       struct rcu_exp_work *rewp;
> -
> -       rewp = container_of(wp, struct rcu_exp_work, rew_work);
> -       rcu_exp_sel_wait_wake(rewp->rew_s);
> -}
> -
>  #ifdef CONFIG_PREEMPT_RCU
>
>  /*
> @@ -848,20 +934,19 @@ void synchronize_rcu_expedited(void)
>         } else {
>                 /* Marshall arguments & schedule the expedited grace period. */
>                 rew.rew_s = s;
> -               INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
> -               queue_work(rcu_gp_wq, &rew.rew_work);
> +               synchronize_rcu_expedited_queue_work(&rew);
>         }
>
>         /* Wait for expedited grace period to complete. */
>         rnp = rcu_get_root();
>         wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
>                    sync_exp_work_done(s));
> -       smp_mb(); /* Workqueue actions happen before return. */
> +       smp_mb(); /* Work actions happen before return. */
>
>         /* Let the next expedited grace period start. */
>         mutex_unlock(&rcu_state.exp_mutex);
>
>         if (likely(!boottime))
> -               destroy_work_on_stack(&rew.rew_work);
> +               synchronize_rcu_expedited_destroy_work(&rew);
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
>
> base-commit: 42e7a03d3badebd4e70aea5362d6914dfc7c220b
> --
> 2.35.1.1178.g4f1659d476-goog
>
