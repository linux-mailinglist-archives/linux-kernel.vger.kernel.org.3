Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724A94A652B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiBATtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiBATtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:49:09 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07368C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:49:09 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a24so1416002uat.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/WPOEcziH5UqRqb9sJkjk1z/koQumE1byOHgxdtZ+w=;
        b=SYyqNdbtLzWD2UqR4sfFq/sVfh265WAYGg1UOqq9DF3ddTpIa844ih2iWoCCPyOKy/
         4JSFHDfuqSZMZW1Ma9UrjzLM2GstD+KcgbTKwmq1JM+849BdKMgVLrl8f41FGsMhFpvm
         kNeIvQpe1l1eYqJqv0lTUE7rcQ1pCsnqHCT74BFDt6tPldxCfCNS5EyUFpuoSI32sMS0
         YW2AiPrGTG3yUGdusVkQM1GBT0rNR/ighzI8R+vvFdCYTwT9jdsnBrBRXeLiaOFALyDB
         rx/juLpHNubUCFOjSI3rPSjW4OIB4JLr0xbXfRfoGqbCxUk3TpRjOCLIQEMrHPOZPOWd
         zSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/WPOEcziH5UqRqb9sJkjk1z/koQumE1byOHgxdtZ+w=;
        b=A8y6Af/RM53WY99L6uRkjjE7kOL07FEvx22Wbl22FuuKxuY7m11rJD6kbc7jbyAGZl
         iaaUi2cPAkU3DHGyfUFTCQCP89Z1yFbPDBvnYgCBcCY7RUxM/YJJYLHX2a5C/VYgJgoW
         6yKcVu/p/J6bt/x72M918B+4gswIARJdbQzmRlhddCZsO9fo0OK3x0pZytORwC/TVO7R
         YY88aMHxqFpwl6MTpNdjN+AiavssTPA8f11qm5nukCvJVInFQnmPydaBm6r1/dzSOv48
         G3RpZWvlBB7S3I60BfIKmTX/KW1YzYrdNpKjC3InlcBg3MiR/ljsVrAjfpoaru4LHu6V
         FgIQ==
X-Gm-Message-State: AOAM530FIPHOHIgIfokCHJFKyFPWW9Npt2Bh4alzfckcEpubIV+kYBk9
        ESxTfUq+fIowXDd9D9osbgmC4lZ/QUlUseq/IMopzw==
X-Google-Smtp-Source: ABdhPJyz7aVnac5n2RcM5g7ZcOY1vF6bKGu67s1QXuQrr3Mo/KffqpQw9xndsiHg+XY6+iPew8iA9NodHFIcGjgWh1E=
X-Received: by 2002:a67:ab43:: with SMTP id k3mr10625892vsh.60.1643744948073;
 Tue, 01 Feb 2022 11:49:08 -0800 (PST)
MIME-Version: 1.0
References: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20220201192540.10439-1-mathieu.desnoyers@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 1 Feb 2022 11:49:05 -0800
Message-ID: <CAFTs51XYWqN6bPbVYh8a9ta+VxS4iBbiWWNO7n1t-4_VLpKGXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] Introduce per thread group current virtual cpu id
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 11:26 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> This feature allows the scheduler to expose a current virtual cpu id
> to user-space. This virtual cpu id is within the possible cpus range,
> and is temporarily (and uniquely) assigned while threads are actively
> running within a thread group. If a thread group has fewer threads than
> cores, or is limited to run on few cores concurrently through sched
> affinity or cgroup cpusets, the virtual cpu ids will be values close
> to 0, thus allowing efficient use of user-space memory for per-cpu
> data structures.

Why per thread group and not per mm? The main use case is for
per-(v)cpu memory allocation logic, so it seems having this feature
per mm is more appropriate?

>
> This feature is meant to be exposed by a new rseq thread area field.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  fs/exec.c                    |  4 +++
>  include/linux/sched.h        |  4 +++
>  include/linux/sched/signal.h | 49 ++++++++++++++++++++++++++++++++++++
>  init/Kconfig                 | 14 +++++++++++
>  kernel/sched/core.c          |  2 ++
>  5 files changed, 73 insertions(+)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 79f2c9483302..bc9a8c5f17f4 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1153,6 +1153,10 @@ static int de_thread(struct task_struct *tsk)
>         sig->group_exec_task = NULL;
>         sig->notify_count = 0;
>
> +       /* Release possibly high vcpu id, get vcpu id 0. */
> +       tg_vcpu_put(tsk);
> +       tg_vcpu_get(tsk);
> +
>  no_thread_group:
>         /* we have changed execution domain */
>         tsk->exit_signal = SIGCHLD;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 838c9e0b4cae..0f199daed26a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1300,6 +1300,10 @@ struct task_struct {
>         unsigned long rseq_event_mask;
>  #endif
>
> +#ifdef CONFIG_SCHED_THREAD_GROUP_VCPU
> +       int                             tg_vcpu;        /* Current vcpu in thread group */
> +#endif
> +
>         struct tlbflush_unmap_batch     tlb_ubc;
>
>         union {
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index b6ecb9fc4cd2..c87e7ad5a1ea 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -244,6 +244,12 @@ struct signal_struct {
>                                                  * and may have inconsistent
>                                                  * permissions.
>                                                  */
> +#ifdef CONFIG_SCHED_THREAD_GROUP_VCPU
> +       /*
> +        * Mask of allocated vcpu ids within the thread group.
> +        */
> +       cpumask_t                       vcpu_mask;

We use a pointer for the mask (in struct mm). Adds complexity around
alloc/free, though. Just FYI.

> +#endif
>  } __randomize_layout;
>
>  /*
> @@ -742,4 +748,47 @@ static inline unsigned long rlimit_max(unsigned int limit)
>         return task_rlimit_max(current, limit);
>  }
>
> +#ifdef CONFIG_SCHED_THREAD_GROUP_VCPU
> +static inline void tg_vcpu_get(struct task_struct *t)
> +{
> +       struct cpumask *cpumask = &t->signal->vcpu_mask;
> +       unsigned int vcpu;
> +
> +       if (t->flags & PF_KTHREAD)
> +               return;
> +       /* Atomically reserve lowest available vcpu number. */
> +       do {
> +               vcpu = cpumask_first_zero(cpumask);
> +               WARN_ON_ONCE(vcpu >= nr_cpu_ids);
> +       } while (cpumask_test_and_set_cpu(vcpu, cpumask));
> +       t->tg_vcpu = vcpu;
> +}
> +
> +static inline void tg_vcpu_put(struct task_struct *t)
> +{
> +       if (t->flags & PF_KTHREAD)
> +               return;
> +       cpumask_clear_cpu(t->tg_vcpu, &t->signal->vcpu_mask);
> +       t->tg_vcpu = 0;
> +}
> +
> +static inline int task_tg_vcpu_id(struct task_struct *t)
> +{
> +       return t->tg_vcpu;
> +}
> +#else
> +static inline void tg_vcpu_get(struct task_struct *t) { }
> +static inline void tg_vcpu_put(struct task_struct *t) { }
> +static inline int task_tg_vcpu_id(struct task_struct *t)
> +{
> +       /*
> +        * Use the processor id as a fall-back when the thread group vcpu
> +        * feature is disabled. This provides functional per-cpu data structure
> +        * accesses in user-space, althrough it won't provide the memory usage
> +        * benefits.
> +        */
> +       return raw_smp_processor_id();
> +}
> +#endif
> +
>  #endif /* _LINUX_SCHED_SIGNAL_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index e9119bf54b1f..5f72b4212a33 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1023,6 +1023,20 @@ config RT_GROUP_SCHED
>
>  endif #CGROUP_SCHED
>
> +config SCHED_THREAD_GROUP_VCPU
> +       bool "Provide per-thread-group virtual cpu id"
> +       depends on SMP
> +       default n
> +       help
> +         This feature allows the scheduler to expose a current virtual cpu id
> +         to user-space. This virtual cpu id is within the possible cpus range,
> +         and is temporarily (and uniquely) assigned while threads are actively
> +         running within a thread group. If a thread group has fewer threads than
> +         cores, or is limited to run on few cores concurrently through sched
> +         affinity or cgroup cpusets, the virtual cpu ids will be values close
> +         to 0, thus allowing efficient use of user-space memory for per-cpu
> +         data structures.
> +
>  config UCLAMP_TASK_GROUP
>         bool "Utilization clamping per group of tasks"
>         depends on CGROUP_SCHED
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2e4ae00e52d1..2690e80977b1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4795,6 +4795,8 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>         sched_info_switch(rq, prev, next);
>         perf_event_task_sched_out(prev, next);
>         rseq_preempt(prev);
> +       tg_vcpu_put(prev);
> +       tg_vcpu_get(next);

Doing this for all tasks on all context switches will most likely be
too expensive. We do it only for tasks that explicitly asked for this
feature during their rseq registration, and still the tight loop in
our equivalent of tg_vcpu_get() is occasionally noticeable (lots of
short wakeups can lead to the loop thrashing around).

Again, our approach is more complicated as a result.

>         fire_sched_out_preempt_notifiers(prev, next);
>         kmap_local_sched_out();
>         prepare_task(next);
> --
> 2.17.1
>
