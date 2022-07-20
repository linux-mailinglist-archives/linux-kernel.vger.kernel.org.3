Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC0057BAAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiGTPm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbiGTPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:42:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE8D61727
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:42:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so1544369wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iA6H9FbTpi/aYLA06konbtgAlr2/KT50OkDviEcMLbs=;
        b=iXpffLiJVtdCttiGIiGR476FbgEvncJynZYRRFaKtNnC14Ee9o1jfns2LKphXmangZ
         EWnyeyPG/xn69I0jb4fcDYQ6YQvz4wlMQ4CzzCaEJdcvlwz6pi2mc6h81eG90tgr88lz
         /oPzNIOkMX0oapWfl9thXpEQWQRklgF9vE94O74BEc4lqET8GwMOe5xIspX/SG1G81f/
         7XfOoCBv/Rvt6NXKRXaTE97WV7eUjlcGKl4Nu7YBbXjeSGJaay5eSqAeGCbTSeW5x7YL
         3Gv7tYShmCX8xv9E6zpZgj/gN9gyStIsWLrBGWi1UigHS002MJ7/oglO2c7XTMT4Ur5M
         /s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iA6H9FbTpi/aYLA06konbtgAlr2/KT50OkDviEcMLbs=;
        b=GPUNLJvfgQFCo0axw/2FZPk9ckCoNKZBTBprZsQ4U/uqaB99lbiymu/g3SU/AkKqjd
         BzRA4eG8fW1yTp9ANcJKimXYsvbwnGVsGwBzU6h5Cc/EX+TDL1IR98AaMpKFPyd6BfAz
         UQbILJOvUy1r+wmCEbhla8riz+uJGaGcKkfFoyRhoqZMX8H0ri/uK+J6wHajV9yit3uI
         5qIxRjN9Fi+sYbbbuYPYzDXJq2A5xlZ+ZNmCLuTo5sKL0i4Gif0J707oaPxnUlCLf6XW
         Gq4YGqkUrH3QxqA4iO0Z/Ro6B9HVerUbOl9rybNBJ9AztZd5GLZJbJaNQqmhSZUwM9hg
         kdWw==
X-Gm-Message-State: AJIora+c/Do6smvLphUlvpFN1D6dcRRZbkSgBcExNu2zxPYf5OVdDvJe
        spP5V+l4EN56XH3fbedUMsuQis24EccDiJvsXg2/1g==
X-Google-Smtp-Source: AGRyM1tC/2QEwTNFQazHf5jpM6MANjmu2PBS3k8EZUWqAOG0aiuCYQuwyfqeLE68lKXUayZ2hy32LTejKodIDCILDK0=
X-Received: by 2002:a7b:c8d3:0:b0:3a2:fe0d:ba2e with SMTP id
 f19-20020a7bc8d3000000b003a2fe0dba2emr4552680wml.115.1658331771692; Wed, 20
 Jul 2022 08:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-14-elver@google.com>
In-Reply-To: <20220704150514.48816-14-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:42:39 -0700
Message-ID: <CAP-5=fX3Ba8pOrnyehzJPfDBMEb-qf0ybj40na0nb4k_KyzeQA@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] perf/hw_breakpoint: Optimize max_bp_pinned_slots()
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

On Mon, Jul 4, 2022 at 8:07 AM Marco Elver <elver@google.com> wrote:
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
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v3:
> * Update hw_breakpoint_is_used() to include global cpu_pinned.
>
> v2:
> * New patch.
> ---
>  kernel/events/hw_breakpoint.c | 57 ++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 03ebecf048c0..a489f31fe147 100644
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
> @@ -804,6 +841,18 @@ bool hw_breakpoint_is_used(void)
>                 }
>         }
>
> +       for (int type = 0; type < TYPE_MAX; ++type) {
> +               for (int slot = 0; slot < hw_breakpoint_slots_cached(type); ++slot) {
> +                       /*
> +                        * Warn, because if there are CPU pinned counters,
> +                        * should never get here; bp_cpuinfo::cpu_pinned should
> +                        * be consistent with the global cpu_pinned histogram.
> +                        */
> +                       if (WARN_ON(atomic_read(&cpu_pinned[type].count[slot])))
> +                               return true;
> +               }
> +       }
> +
>         return false;
>  }
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
