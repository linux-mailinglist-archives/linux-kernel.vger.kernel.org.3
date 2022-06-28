Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C06255E462
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346359AbiF1NVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346345AbiF1NU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:20:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0735859
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:19:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id o23so14847391ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7CgIFPap6ypTTXSUzce/TyUpcucDj1PHP0T/IiacRoQ=;
        b=R8forfurDLJ8yEQgrK1Gb8Cki0g4DIuH6+lLE3aUUOOdS/aY/oXjNGR0fzVW9mLNjJ
         XcfLSibgmOBtdLOH/eN5bD1zWDVQq34FCmc7r1gYS6vGTTQG9EgADIrv3nOm2BaiYJvR
         1W4prJNUBjLUZB5Jvrt9DFKOmCKZ+U+0oDN9cagMPv4KmjvX1HmYR7w5byLWFnfBhiYV
         poW6VnkixBeyNVgz2/5UVaxhnaCjkNhgB/9+oChXvfat6z6Pvp6lL1+NW5ikOzf6URfN
         JRluS+dz6OmwTzJZN9K49xuyyV9loFwNp4XGsGbnrHsUkR8kDLo8TWrzjaNOxdIRj2RT
         HJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7CgIFPap6ypTTXSUzce/TyUpcucDj1PHP0T/IiacRoQ=;
        b=0xMurv8QQ7mcXj7Q6H+Y6MSON5RVPszJEUx2VNPpTfqT3MHp7AMS6nu9a7bUQzFI9Z
         pJZjw6AnhTq9TeXpotyDi4xXXnhm5V9eQQFGOWOmO7SLyGkKpiV1QZpAocXxC0z5UiB9
         mtXFhg8g/cfT9A/YfuVks9PXo6+fc8tFW2lJNB07We88/O6rB8ssIggYnjUEzCfv5jYG
         ASx/ElmVQKRiI2mcGm6Opu2QwNTMFCPGt9ybhFBOCZfuBUCu686OLlNwE6DP8zQmelii
         EVlT4raHMQe5vBSe6P75MMtXtaUFEETNRKWmPUNnSoB093QjyW9G9xX7PCeC2IEY1Z3W
         8/Uw==
X-Gm-Message-State: AJIora9xBUo4M/waYduVSGzYgneaZ5nlOWxmJ+3X8TNbuDok5I+lbHfB
        JHycNd2xkMCy36odbIU3z3RLd5VK0v577LqBJW2icA==
X-Google-Smtp-Source: AGRyM1toA86paItas3f13uK/yq9WZLgGB0nO/w6rvEGOTkkNC1CL8Nyv0K6R1K9zXSkuslE6c4fhWr9A82lz4OkaLP4=
X-Received: by 2002:a2e:9004:0:b0:25a:6dee:4ae2 with SMTP id
 h4-20020a2e9004000000b0025a6dee4ae2mr9881452ljg.33.1656422341451; Tue, 28 Jun
 2022 06:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-8-elver@google.com>
In-Reply-To: <20220628095833.2579903-8-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Jun 2022 15:18:49 +0200
Message-ID: <CACT4Y+aqRgBpuah8Ab3E134cCBimAmW2kUpJ7rR-e95HpS4aFg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] perf/hw_breakpoint: Remove useless code related
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
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

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * Also remove struct bp_busy_slots, and simplify functions.
> ---
>  kernel/events/hw_breakpoint.c | 57 +++++++++++------------------------
>  1 file changed, 17 insertions(+), 40 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index a124786e3ade..63e39dc836bd 100644
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
