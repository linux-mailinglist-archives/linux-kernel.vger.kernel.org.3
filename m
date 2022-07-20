Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE0E57B9BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiGTPch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbiGTPcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:32:20 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9F661D69
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:32:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d8so6684143wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOe56Pal9wpMnCknu1sB4FBOOVOLYGu0YQCW9drNE6o=;
        b=dbCH1rMV5uvKG3/vw97dyMMvZdc3PV8XDPVwZ++yndGluvyO9EmAbxXdO52yLjrkVH
         0IFmAWREWuEK/Ks+OhraP8xLf7NkJnlMAyxsYUGw2dSIqMKgZHw6ogtL1li18dyhF95x
         DDCKyWqvH6nko7tLnr2J3FlrKqYCaal70SQMUGHm2wWWQhEXKYtqVxuKVouF5yZsPLqt
         FjBm3jDzJxOH06Aslq49FCUPQq/OvFuG3fDJTPqC+GuvqZ8v3TWAB/kHEQ968a3iTG7w
         ne/c8hXGzdkcAfp1neQgHXPVRH+vCI8cX3KqvLQaeum4SkVIg3k1TX0C+fnBhMQUExBX
         4scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOe56Pal9wpMnCknu1sB4FBOOVOLYGu0YQCW9drNE6o=;
        b=FlZdHXDqjLMp71VRVq42Sm/KEAnsrpv21rIDGzIpiIjGcc1jVgOrhviEgTQVYhKENQ
         l+JeVi3ElZKl1Os048sDP6j4FTgK6sGP6Fcl1onYLFf0xWMI8d/LshBAZkuN9YTpsRaN
         o1ZnJLU7Y49BEHhD5qXKwiuI/n5U6R5GAf0JKZ7Q54IIKLY9FsM6gcaiwlc9N7RPOnQJ
         Gj1PKTvruRw4lZHFHt6EP8zAZRKgpw04QWkadgWc2ulnSKkX/jHyTBruYuSOKT3xO69/
         hwW1qjr099xIHebjMyGwJDQbb0FYhmHmMV34EjgRD4TKn12x/P6UW5pF2K05dfkHv3Vh
         ojuQ==
X-Gm-Message-State: AJIora+GbUA5rX1hGN/6uxjz7E0zbQz/E6KsHdWiwVM0uKHWvCZ2p7gp
        G5qmCZY/6C6qg61dFeHotz9kIYN+mXptxwtb9zQ68A==
X-Google-Smtp-Source: AGRyM1vsvscoHsqY9LtsaCoUZJbQkkNoTAQtU3YueagNPnGNccjfeNSvIVQDHM8FgHiVTJaiUUkRbZgnN0iqM0ZyAHM=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr30049803wrx.343.1658331129763; Wed, 20
 Jul 2022 08:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-7-elver@google.com>
In-Reply-To: <20220704150514.48816-7-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:31:57 -0700
Message-ID: <CAP-5=fV_maSd0k_WCzxgToN1SYG+XHg0KpTe1m2CTJTT9+KM+w@mail.gmail.com>
Subject: Re: [PATCH v3 06/14] perf/hw_breakpoint: Optimize constant number of
 breakpoint slots
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 8:06 AM Marco Elver <elver@google.com> wrote:
>
> Optimize internal hw_breakpoint state if the architecture's number of
> breakpoint slots is constant. This avoids several kmalloc() calls and
> potentially unnecessary failures if the allocations fail, as well as
> subtly improves code generation and cache locality.
>
> The protocol is that if an architecture defines hw_breakpoint_slots via
> the preprocessor, it must be constant and the same for all types.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/sh/include/asm/hw_breakpoint.h  |  5 +-
>  arch/x86/include/asm/hw_breakpoint.h |  5 +-
>  kernel/events/hw_breakpoint.c        | 94 ++++++++++++++++++----------
>  3 files changed, 63 insertions(+), 41 deletions(-)
>
> diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
> index 199d17b765f2..361a0f57bdeb 100644
> --- a/arch/sh/include/asm/hw_breakpoint.h
> +++ b/arch/sh/include/asm/hw_breakpoint.h
> @@ -48,10 +48,7 @@ struct pmu;
>  /* Maximum number of UBC channels */
>  #define HBP_NUM                2
>
> -static inline int hw_breakpoint_slots(int type)
> -{
> -       return HBP_NUM;
> -}
> +#define hw_breakpoint_slots(type) (HBP_NUM)
>
>  /* arch/sh/kernel/hw_breakpoint.c */
>  extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
> diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
> index a1f0e90d0818..0bc931cd0698 100644
> --- a/arch/x86/include/asm/hw_breakpoint.h
> +++ b/arch/x86/include/asm/hw_breakpoint.h
> @@ -44,10 +44,7 @@ struct arch_hw_breakpoint {
>  /* Total number of available HW breakpoint registers */
>  #define HBP_NUM 4
>
> -static inline int hw_breakpoint_slots(int type)
> -{
> -       return HBP_NUM;
> -}
> +#define hw_breakpoint_slots(type) (HBP_NUM)
>
>  struct perf_event_attr;
>  struct perf_event;
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 7df46b276452..9fb66d358d81 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -40,13 +40,16 @@ struct bp_cpuinfo {
>         /* Number of pinned cpu breakpoints in a cpu */
>         unsigned int    cpu_pinned;
>         /* tsk_pinned[n] is the number of tasks having n+1 breakpoints */
> +#ifdef hw_breakpoint_slots
> +       unsigned int    tsk_pinned[hw_breakpoint_slots(0)];
> +#else
>         unsigned int    *tsk_pinned;
> +#endif
>         /* Number of non-pinned cpu/task breakpoints in a cpu */
>         unsigned int    flexible; /* XXX: placeholder, see fetch_this_slot() */
>  };
>
>  static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
> -static int nr_slots[TYPE_MAX] __ro_after_init;
>
>  static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
>  {
> @@ -73,6 +76,54 @@ struct bp_busy_slots {
>  /* Serialize accesses to the above constraints */
>  static DEFINE_MUTEX(nr_bp_mutex);
>
> +#ifdef hw_breakpoint_slots
> +/*
> + * Number of breakpoint slots is constant, and the same for all types.
> + */
> +static_assert(hw_breakpoint_slots(TYPE_INST) == hw_breakpoint_slots(TYPE_DATA));
> +static inline int hw_breakpoint_slots_cached(int type) { return hw_breakpoint_slots(type); }
> +static inline int init_breakpoint_slots(void)          { return 0; }
> +#else
> +/*
> + * Dynamic number of breakpoint slots.
> + */
> +static int __nr_bp_slots[TYPE_MAX] __ro_after_init;
> +
> +static inline int hw_breakpoint_slots_cached(int type)
> +{
> +       return __nr_bp_slots[type];
> +}
> +
> +static __init int init_breakpoint_slots(void)
> +{
> +       int i, cpu, err_cpu;
> +
> +       for (i = 0; i < TYPE_MAX; i++)
> +               __nr_bp_slots[i] = hw_breakpoint_slots(i);
> +
> +       for_each_possible_cpu(cpu) {
> +               for (i = 0; i < TYPE_MAX; i++) {
> +                       struct bp_cpuinfo *info = get_bp_info(cpu, i);
> +
> +                       info->tsk_pinned = kcalloc(__nr_bp_slots[i], sizeof(int), GFP_KERNEL);
> +                       if (!info->tsk_pinned)
> +                               goto err;
> +               }
> +       }
> +
> +       return 0;
> +err:
> +       for_each_possible_cpu(err_cpu) {
> +               for (i = 0; i < TYPE_MAX; i++)
> +                       kfree(get_bp_info(err_cpu, i)->tsk_pinned);
> +               if (err_cpu == cpu)
> +                       break;
> +       }
> +
> +       return -ENOMEM;
> +}
> +#endif
> +
>  __weak int hw_breakpoint_weight(struct perf_event *bp)
>  {
>         return 1;
> @@ -95,7 +146,7 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
>         unsigned int *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
>         int i;
>
> -       for (i = nr_slots[type] - 1; i >= 0; i--) {
> +       for (i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
>                 if (tsk_pinned[i] > 0)
>                         return i + 1;
>         }
> @@ -312,7 +363,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
>         fetch_this_slot(&slots, weight);
>
>         /* Flexible counters need to keep at least one slot */
> -       if (slots.pinned + (!!slots.flexible) > nr_slots[type])
> +       if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
>                 return -ENOSPC;
>
>         ret = arch_reserve_bp_slot(bp);
> @@ -632,7 +683,7 @@ bool hw_breakpoint_is_used(void)
>                         if (info->cpu_pinned)
>                                 return true;
>
> -                       for (int slot = 0; slot < nr_slots[type]; ++slot) {
> +                       for (int slot = 0; slot < hw_breakpoint_slots_cached(type); ++slot) {
>                                 if (info->tsk_pinned[slot])
>                                         return true;
>                         }
> @@ -716,42 +767,19 @@ static struct pmu perf_breakpoint = {
>
>  int __init init_hw_breakpoint(void)
>  {
> -       int cpu, err_cpu;
> -       int i, ret;
> -
> -       for (i = 0; i < TYPE_MAX; i++)
> -               nr_slots[i] = hw_breakpoint_slots(i);
> -
> -       for_each_possible_cpu(cpu) {
> -               for (i = 0; i < TYPE_MAX; i++) {
> -                       struct bp_cpuinfo *info = get_bp_info(cpu, i);
> -
> -                       info->tsk_pinned = kcalloc(nr_slots[i], sizeof(int),
> -                                                       GFP_KERNEL);
> -                       if (!info->tsk_pinned) {
> -                               ret = -ENOMEM;
> -                               goto err;
> -                       }
> -               }
> -       }
> +       int ret;
>
>         ret = rhltable_init(&task_bps_ht, &task_bps_ht_params);
>         if (ret)
> -               goto err;
> +               return ret;
> +
> +       ret = init_breakpoint_slots();
> +       if (ret)
> +               return ret;
>
>         constraints_initialized = true;
>
>         perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
>
>         return register_die_notifier(&hw_breakpoint_exceptions_nb);
> -
> -err:
> -       for_each_possible_cpu(err_cpu) {
> -               for (i = 0; i < TYPE_MAX; i++)
> -                       kfree(get_bp_info(err_cpu, i)->tsk_pinned);
> -               if (err_cpu == cpu)
> -                       break;
> -       }
> -
> -       return ret;
>  }
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
