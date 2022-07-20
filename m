Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35C57BA21
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiGTPec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237384AbiGTPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:34:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7643661D6C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:34:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1597270wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypDIzBcK+87vSvCQ9N63jBX4rrxFFdnrF6gevmMUAWM=;
        b=qYpCF0yPZAWVmfn4o1WL3snWCbWfTv0DB4ysf2hEz/gvC0u5IJOl4CSpcrGmqh4oxC
         IpGQouGjcrKjK3wCiFjso+HI61qblzT4/CF3jIQGUCs40hos+O6cny6Ert0tMHHxSPuJ
         ZqItzeMPjOQHLGhDkLprET6IfI7o8WcdEs6WkDtmNFgTkWH19yjL3jvWK0Rn08X/9cR4
         gAXsgcdHH1beMsmPPEqbrtf3Q1QsVVMAjViWT5eZ3R0ygQaKsRTK8sFh8YT6fJQkHsdM
         h4auKtVbICd8hh7Cv4mUv7BkHyoYjNrF5xR88B1Ntx9vU15l5Scb8to8vovUYB3dSAq4
         a2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypDIzBcK+87vSvCQ9N63jBX4rrxFFdnrF6gevmMUAWM=;
        b=sfHMexNpHedPP+ed+58fQGRZoT9LZXEPHefMpjYh7SkGrSn72ngruBgSVPf6R3EgKl
         BC34D8psBvB8tT+2G3VjraUtv8Jxe0rGYmIw/Iv9BUkDrA589dw2wMXC3Hy9ywtqyLrg
         auzDcC/hFcXJ7ZraWHmoVfOUA06GiIcLYCmHaPTWRyC5DSo+G6z6uwtqvGayb8XDCYNC
         DoLZioz5jyho80HGYuPL+7wEWnI487GNGy8D2qCWECbJLKgNL+emW2clQi3ITk3M/u+3
         zZjKj7GSEn869bbO4HpN96WSkDgIyT+POwD+U7RU0dJxrcZghtDhGTjQiRlJsj8D3c9Z
         J1hQ==
X-Gm-Message-State: AJIora9M0fn1fXrim3JLzDW7nptiRWF817HDOzw0AatgsezdjsDKIWLo
        rOlMBnynZm/ksPwpkkv3JV/VhlKzl4dl0dCIfLX/VQ==
X-Google-Smtp-Source: AGRyM1vEh6LRDJ86iiseKEFQLLx7zLjnSV03a10uJiMGUoPTdq4R/2FEPI2563brxrBRwZpS42iuOlXxknZWGctJ1T4=
X-Received: by 2002:a7b:c8d3:0:b0:3a2:fe0d:ba2e with SMTP id
 f19-20020a7bc8d3000000b003a2fe0dba2emr4514304wml.115.1658331264903; Wed, 20
 Jul 2022 08:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-9-elver@google.com>
In-Reply-To: <20220704150514.48816-9-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:34:13 -0700
Message-ID: <CAP-5=fVYaipBhx7hoq25E=tEUua1DNhhh9o5f3tPxoFtqpq4EQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] perf/hw_breakpoint: Remove useless code related
 to flexible breakpoints
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 8:06 AM Marco Elver <elver@google.com> wrote:
>
> Flexible breakpoints have never been implemented, with
> bp_cpuinfo::flexible always being 0. Unfortunately, they still occupy 4
> bytes in each bp_cpuinfo and bp_busy_slots, as well as computing the max
> flexible count in fetch_bp_busy_slots().
>
> This again causes suboptimal code generation, when we always know that
> `!!slots.flexible` will be 0.
>
> Just get rid of the flexible "placeholder" and remove all real code
> related to it. Make a note in the comment related to the constraints
> algorithm but don't remove them from the algorithm, so that if in future
> flexible breakpoints need supporting, it should be trivial to revive
> them (along with reverting this change).
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2:
> * Also remove struct bp_busy_slots, and simplify functions.
> ---
>  kernel/events/hw_breakpoint.c | 57 +++++++++++------------------------
>  1 file changed, 17 insertions(+), 40 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 9c9bf17666a5..8b40fca1a063 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -45,8 +45,6 @@ struct bp_cpuinfo {
>  #else
>         unsigned int    *tsk_pinned;
>  #endif
> -       /* Number of non-pinned cpu/task breakpoints in a cpu */
> -       unsigned int    flexible; /* XXX: placeholder, see fetch_this_slot() */
>  };
>
>  static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
> @@ -67,12 +65,6 @@ static const struct rhashtable_params task_bps_ht_params = {
>
>  static bool constraints_initialized __ro_after_init;
>
> -/* Gather the number of total pinned and un-pinned bp in a cpuset */
> -struct bp_busy_slots {
> -       unsigned int pinned;
> -       unsigned int flexible;
> -};
> -
>  /* Serialize accesses to the above constraints */
>  static DEFINE_MUTEX(nr_bp_mutex);
>
> @@ -190,14 +182,14 @@ static const struct cpumask *cpumask_of_bp(struct perf_event *bp)
>  }
>
>  /*
> - * Report the number of pinned/un-pinned breakpoints we have in
> - * a given cpu (cpu > -1) or in all of them (cpu = -1).
> + * Returns the max pinned breakpoint slots in a given
> + * CPU (cpu > -1) or across all of them (cpu = -1).
>   */
> -static void
> -fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
> -                   enum bp_type_idx type)
> +static int
> +max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
>  {
>         const struct cpumask *cpumask = cpumask_of_bp(bp);
> +       int pinned_slots = 0;
>         int cpu;
>
>         for_each_cpu(cpu, cpumask) {
> @@ -210,24 +202,10 @@ fetch_bp_busy_slots(struct bp_busy_slots *slots, struct perf_event *bp,
>                 else
>                         nr += task_bp_pinned(cpu, bp, type);
>
> -               if (nr > slots->pinned)
> -                       slots->pinned = nr;
> -
> -               nr = info->flexible;
> -               if (nr > slots->flexible)
> -                       slots->flexible = nr;
> +               pinned_slots = max(nr, pinned_slots);
>         }
> -}
>
> -/*
> - * For now, continue to consider flexible as pinned, until we can
> - * ensure no flexible event can ever be scheduled before a pinned event
> - * in a same cpu.
> - */
> -static void
> -fetch_this_slot(struct bp_busy_slots *slots, int weight)
> -{
> -       slots->pinned += weight;
> +       return pinned_slots;
>  }
>
>  /*
> @@ -298,7 +276,12 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
>  }
>
>  /*
> - * Constraints to check before allowing this new breakpoint counter:
> + * Constraints to check before allowing this new breakpoint counter.
> + *
> + * Note: Flexible breakpoints are currently unimplemented, but outlined in the
> + * below algorithm for completeness.  The implementation treats flexible as
> + * pinned due to no guarantee that we currently always schedule flexible events
> + * before a pinned event in a same CPU.
>   *
>   *  == Non-pinned counter == (Considered as pinned for now)
>   *
> @@ -340,8 +323,8 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
>   */
>  static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
>  {
> -       struct bp_busy_slots slots = {0};
>         enum bp_type_idx type;
> +       int max_pinned_slots;
>         int weight;
>         int ret;
>
> @@ -357,15 +340,9 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
>         type = find_slot_idx(bp_type);
>         weight = hw_breakpoint_weight(bp);
>
> -       fetch_bp_busy_slots(&slots, bp, type);
> -       /*
> -        * Simulate the addition of this breakpoint to the constraints
> -        * and see the result.
> -        */
> -       fetch_this_slot(&slots, weight);
> -
> -       /* Flexible counters need to keep at least one slot */
> -       if (slots.pinned + (!!slots.flexible) > hw_breakpoint_slots_cached(type))
> +       /* Check if this new breakpoint can be satisfied across all CPUs. */
> +       max_pinned_slots = max_bp_pinned_slots(bp, type) + weight;
> +       if (max_pinned_slots > hw_breakpoint_slots_cached(type))
>                 return -ENOSPC;
>
>         ret = arch_reserve_bp_slot(bp);
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
