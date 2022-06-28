Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289A355E5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347929AbiF1Plo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347478AbiF1Plm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:41:42 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945E6324
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:41:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id n15so15382852ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=45OuMvop0l12Xy16UbND2bLY50+0LD4yzVw7v19VYg8=;
        b=tixw4tZb7j9f6SMyAeckCFJC+hYJd8xNh7Rx6rUbM/t0yc2+e7419dt2uO+oMHq+zO
         40DQhCgjRzBC8jIJwc5wNZx9n+3dWDxXOv6J405pFrtubNVZkW8D05c4a+3QB2iU1cKU
         PaVPtDne0KNJrhAdHohNCk8fWX5rX9alPL+j7ZBAp1p52k5MI//Ox0NugOMeBvPEqgcJ
         HLIqAy91EnzZgcBxfKGKD9e47TCc4mOEgCkI2sb4rxFOermX2xYbCZXKe9g+ZsvmQVFX
         00l/SHC+TEHX9UHONQpmON3QI6MWzbaUxPMzJN/IMUE/oQY9kXWVIvrpK2EK+4V7H6H1
         xpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45OuMvop0l12Xy16UbND2bLY50+0LD4yzVw7v19VYg8=;
        b=NC3wLTFIefnfnsltWnwPxH5j5Sy6A3EATuW5t6Sm43/MI1QV3umME3AZnln3qMLjQv
         xEUD0lksb4mFomyWKGhTVRdyM1BakjLrz1lW+ZyagCy4neOO4SEohARws9kOksqtyLd6
         NvUtoFHDX1tH/9Pjaq6AnG+KHKe4S3WKu9B3NpXCrdksK6xeHkYdSK6QhrvsoiXvTkLA
         0QThsIsBUGK+mZi3k2xcYXJqqy2NuVbUmRj8VLQJ3qZl4rys379FeDoaKcE+uN5nlDyT
         gSe7VK8B1jaEt24DKMH4N4sxo0oavGi3BdcKPQLRsECwjjTP60uR7N/kXE7fCbCNzqSk
         kFeA==
X-Gm-Message-State: AJIora8K2nuvuxxxVAp/mxUHSeMX94SN/YI1viIfx4uoI4xzWrV3aHbt
        HrfK+A0XBHl1dkS71Es0BpIk3/sOuIBU2XNZM1smvw==
X-Google-Smtp-Source: AGRyM1t8CoDJ/rKg0rWWuralRxMR0DkCBugAQ7kbwNId8MGTrF8HS9iDshsoR/7Luv6iaWw7wW9bZcNDAn9f5DsvrJE=
X-Received: by 2002:a2e:998c:0:b0:25b:b2ae:b2 with SMTP id w12-20020a2e998c000000b0025bb2ae00b2mr8470900lji.92.1656430899134;
 Tue, 28 Jun 2022 08:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-13-elver@google.com>
In-Reply-To: <20220628095833.2579903-13-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 28 Jun 2022 17:41:27 +0200
Message-ID: <CACT4Y+ZAjQa4rh-kq8h+wOmfaURvz+cV2LeU5SHj34OMtMMfow@mail.gmail.com>
Subject: Re: [PATCH v2 12/13] perf/hw_breakpoint: Optimize max_bp_pinned_slots()
 for CPU-independent task targets
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
>
> Running the perf benchmark with (note: more aggressive parameters vs.
> preceding changes, but same 256 CPUs host):
>
>  | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 100 threads with 4 breakpoints and 128 parallelism
>  |      Total time: 1.989 [sec]
>  |
>  |       38.854160 usecs/op
>  |     4973.332500 usecs/op/cpu
>
>     20.43%  [kernel]       [k] queued_spin_lock_slowpath
>     18.75%  [kernel]       [k] osq_lock
>     16.98%  [kernel]       [k] rhashtable_jhash2
>      8.34%  [kernel]       [k] task_bp_pinned
>      4.23%  [kernel]       [k] smp_cfm_core_cond
>      3.65%  [kernel]       [k] bcmp
>      2.83%  [kernel]       [k] toggle_bp_slot
>      1.87%  [kernel]       [k] find_next_bit
>      1.49%  [kernel]       [k] __reserve_bp_slot
>
> We can see that a majority of the time is now spent hashing task
> pointers to index into task_bps_ht in task_bp_pinned().
>
> Obtaining the max_bp_pinned_slots() for CPU-independent task targets
> currently is O(#cpus), and calls task_bp_pinned() for each CPU, even if
> the result of task_bp_pinned() is CPU-independent.
>
> The loop in max_bp_pinned_slots() wants to compute the maximum slots
> across all CPUs. If task_bp_pinned() is CPU-independent, we can do so by
> obtaining the max slots across all CPUs and adding task_bp_pinned().
>
> To do so in O(1), use a bp_slots_histogram for CPU-pinned slots.
>
> After this optimization:
>
>  | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 100 threads with 4 breakpoints and 128 parallelism
>  |      Total time: 1.930 [sec]
>  |
>  |       37.697832 usecs/op
>  |     4825.322500 usecs/op/cpu
>
>     19.13%  [kernel]       [k] queued_spin_lock_slowpath
>     18.21%  [kernel]       [k] rhashtable_jhash2
>     15.46%  [kernel]       [k] osq_lock
>      6.27%  [kernel]       [k] toggle_bp_slot
>      5.91%  [kernel]       [k] task_bp_pinned
>      5.05%  [kernel]       [k] smp_cfm_core_cond
>      1.78%  [kernel]       [k] update_sg_lb_stats
>      1.36%  [kernel]       [k] llist_reverse_order
>      1.34%  [kernel]       [k] find_next_bit
>      1.19%  [kernel]       [k] bcmp
>
> Suggesting that time spent in task_bp_pinned() has been reduced.
> However, we're still hashing too much, which will be addressed in the
> subsequent change.
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * New patch.
> ---
>  kernel/events/hw_breakpoint.c | 45 +++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 18886f115abc..b5180a2ccfbf 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -64,6 +64,9 @@ static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
>         return per_cpu_ptr(bp_cpuinfo + type, cpu);
>  }
>
> +/* Number of pinned CPU breakpoints globally. */
> +static struct bp_slots_histogram cpu_pinned[TYPE_MAX];
> +
>  /* Keep track of the breakpoints attached to tasks */
>  static struct rhltable task_bps_ht;
>  static const struct rhashtable_params task_bps_ht_params = {
> @@ -194,6 +197,10 @@ static __init int init_breakpoint_slots(void)
>                                 goto err;
>                 }
>         }
> +       for (i = 0; i < TYPE_MAX; i++) {
> +               if (!bp_slots_histogram_alloc(&cpu_pinned[i], i))
> +                       goto err;
> +       }
>
>         return 0;
>  err:
> @@ -203,6 +210,8 @@ static __init int init_breakpoint_slots(void)
>                 if (err_cpu == cpu)
>                         break;
>         }
> +       for (i = 0; i < TYPE_MAX; i++)
> +               bp_slots_histogram_free(&cpu_pinned[i]);
>
>         return -ENOMEM;
>  }
> @@ -270,6 +279,9 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
>  /*
>   * Count the number of breakpoints of the same type and same task.
>   * The given event must be not on the list.
> + *
> + * If @cpu is -1, but the result of task_bp_pinned() is not CPU-independent,
> + * returns a negative value.
>   */
>  static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
>  {
> @@ -288,9 +300,18 @@ static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
>                 goto out;
>
>         rhl_for_each_entry_rcu(iter, pos, head, hw.bp_list) {
> -               if (find_slot_idx(iter->attr.bp_type) == type &&
> -                   (iter->cpu < 0 || cpu == iter->cpu))
> -                       count += hw_breakpoint_weight(iter);
> +               if (find_slot_idx(iter->attr.bp_type) != type)
> +                       continue;
> +
> +               if (iter->cpu >= 0) {
> +                       if (cpu == -1) {
> +                               count = -1;
> +                               goto out;
> +                       } else if (cpu != iter->cpu)
> +                               continue;
> +               }
> +
> +               count += hw_breakpoint_weight(iter);
>         }
>
>  out:
> @@ -316,6 +337,19 @@ max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
>         int pinned_slots = 0;
>         int cpu;
>
> +       if (bp->hw.target && bp->cpu < 0) {
> +               int max_pinned = task_bp_pinned(-1, bp, type);
> +
> +               if (max_pinned >= 0) {
> +                       /*
> +                        * Fast path: task_bp_pinned() is CPU-independent and
> +                        * returns the same value for any CPU.
> +                        */
> +                       max_pinned += bp_slots_histogram_max(&cpu_pinned[type], type);
> +                       return max_pinned;
> +               }
> +       }
> +
>         for_each_cpu(cpu, cpumask) {
>                 struct bp_cpuinfo *info = get_bp_info(cpu, type);
>                 int nr;
> @@ -366,8 +400,11 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
>
>         /* Pinned counter cpu profiling */
>         if (!bp->hw.target) {
> +               struct bp_cpuinfo *info = get_bp_info(bp->cpu, type);
> +
>                 lockdep_assert_held_write(&bp_cpuinfo_sem);
> -               get_bp_info(bp->cpu, type)->cpu_pinned += weight;
> +               bp_slots_histogram_add(&cpu_pinned[type], info->cpu_pinned, weight);
> +               info->cpu_pinned += weight;
>                 return 0;
>         }
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
