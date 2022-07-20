Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E357B99C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiGTPaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiGTP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:29:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A975E6068D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:29:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so1595665wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pOAyhEyNgA3ymBFdHh+7wY08TjYcdJ+OpPeDKrqApfc=;
        b=LGHNIngBYdxoc/OmU5Yn01DsxXEyWQgaIEHo23DBUOM8Zs1UFOGrtNo9OllYxYt4xh
         0xTzrxHAL/Af2iMnHVY6+80cGlqZP2iBEB/q/qvQWFUfd1uXZ61kWZZntckKPd1ixHtp
         l8nbJQ/a44SWRGx2NOQwncZ8s7GyeFSNKV88fFk+AbKgiPzzTk24Bdyalob8CDlhNDxc
         uuHAL8m480W2sAlmE3ZE9xExjQiac9IHRLEW3K0Azah8qfmAepXwHN8jj3K9hkK1ECzV
         KGpMsQnogVFcf6Eg20wzyVYk2D8pfUFsCQ4KPo71AyiOStmnQF71QrBXyDG3ygBgVpXV
         I7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOAyhEyNgA3ymBFdHh+7wY08TjYcdJ+OpPeDKrqApfc=;
        b=KNineAlUH7aUXCa3+7wmOdlcnjsc2rfRRORo7VTeKNsvBYMGSfEJGItZ36FRHyIyLb
         oCxM3Ib8YN6nf5QqHI74RyXT4WvoGv2cGyJ2teoXctZKXSFI6D+ETGWRFM02SXcxmnDm
         h3wHkS6Pw4TbEv5N5KSZTrYONkqisyXoaV1R+VP/l1qco6Jlgjs5hChWfghDtBMMYfYK
         WAoAGLqp9RlJvQpXlSVg6B6PMue4CRHZ44ny8rRv3jx/ooVyrzcLdAz2T7V2IdUZlq4o
         5AhsUIHSxJjIHmyBjzyJ6XuvFSZYH61BpDFXnQYxRFovv8nrcsNKqJQ/JF6rOOlp2Gy2
         bLVw==
X-Gm-Message-State: AJIora/XlrJB+HlzLSxQN30lc2HsZtlILqGPedTMX7OeDQY2rnFh1dPR
        SoMjy5KbgMsjcexbsG14MoBwUbaoivbsKmXnVxOdoA==
X-Google-Smtp-Source: AGRyM1uUelfwn/9RrqoclqOlHzYUQXFSUmQw3gYwIAHFUPb/FZrxQUySX7k1MbQBENyP3AATk/ITk0u47DFtXSjBsIE=
X-Received: by 2002:a7b:c8d3:0:b0:3a2:fe0d:ba2e with SMTP id
 f19-20020a7bc8d3000000b003a2fe0dba2emr4492494wml.115.1658330995019; Wed, 20
 Jul 2022 08:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-5-elver@google.com>
In-Reply-To: <20220704150514.48816-5-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:29:43 -0700
Message-ID: <CAP-5=fXgi_RUOzSvPZvxNh6A14OY0S_oCHgAD0==nSLXzWqFFQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] perf/hw_breakpoint: Optimize list of per-task breakpoints
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
> On a machine with 256 CPUs, running the recently added perf breakpoint
> benchmark results in:
>
>  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
>  |      Total time: 236.418 [sec]
>  |
>  |   123134.794271 usecs/op
>  |  7880626.833333 usecs/op/cpu
>
> The benchmark tests inherited breakpoint perf events across many
> threads.
>
> Looking at a perf profile, we can see that the majority of the time is
> spent in various hw_breakpoint.c functions, which execute within the
> 'nr_bp_mutex' critical sections which then results in contention on that
> mutex as well:
>
>     37.27%  [kernel]       [k] osq_lock
>     34.92%  [kernel]       [k] mutex_spin_on_owner
>     12.15%  [kernel]       [k] toggle_bp_slot
>     11.90%  [kernel]       [k] __reserve_bp_slot
>
> The culprit here is task_bp_pinned(), which has a runtime complexity of
> O(#tasks) due to storing all task breakpoints in the same list and
> iterating through that list looking for a matching task. Clearly, this
> does not scale to thousands of tasks.
>
> Instead, make use of the "rhashtable" variant "rhltable" which stores
> multiple items with the same key in a list. This results in average
> runtime complexity of O(1) for task_bp_pinned().
>
> With the optimization, the benchmark shows:
>
>  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
>  | # Running 'breakpoint/thread' benchmark:
>  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
>  |      Total time: 0.208 [sec]
>  |
>  |      108.422396 usecs/op
>  |     6939.033333 usecs/op/cpu
>
> On this particular setup that's a speedup of ~1135x.
>
> While one option would be to make task_struct a breakpoint list node,
> this would only further bloat task_struct for infrequently used data.
> Furthermore, after all optimizations in this series, there's no evidence
> it would result in better performance: later optimizations make the time
> spent looking up entries in the hash table negligible (we'll reach the
> theoretical ideal performance i.e. no constraints).
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> ---
> v2:
> * Commit message tweaks.
> ---
>  include/linux/perf_event.h    |  3 +-
>  kernel/events/hw_breakpoint.c | 56 ++++++++++++++++++++++-------------
>  2 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 01231f1d976c..e27360436dc6 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -36,6 +36,7 @@ struct perf_guest_info_callbacks {
>  };
>
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> +#include <linux/rhashtable-types.h>
>  #include <asm/hw_breakpoint.h>
>  #endif
>
> @@ -178,7 +179,7 @@ struct hw_perf_event {
>                          * creation and event initalization.
>                          */
>                         struct arch_hw_breakpoint       info;
> -                       struct list_head                bp_list;
> +                       struct rhlist_head              bp_list;

nit: perhaps it would be more intention revealing here to rename this
to bp_hashtable?

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>                 };
>  #endif
>                 struct { /* amd_iommu */
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 6076c6346291..6d09edc80d19 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -26,10 +26,10 @@
>  #include <linux/irqflags.h>
>  #include <linux/kdebug.h>
>  #include <linux/kernel.h>
> -#include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>  #include <linux/percpu.h>
> +#include <linux/rhashtable.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>
> @@ -54,7 +54,13 @@ static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
>  }
>
>  /* Keep track of the breakpoints attached to tasks */
> -static LIST_HEAD(bp_task_head);
> +static struct rhltable task_bps_ht;
> +static const struct rhashtable_params task_bps_ht_params = {
> +       .head_offset = offsetof(struct hw_perf_event, bp_list),
> +       .key_offset = offsetof(struct hw_perf_event, target),
> +       .key_len = sizeof_field(struct hw_perf_event, target),
> +       .automatic_shrinking = true,
> +};
>
>  static int constraints_initialized;
>
> @@ -103,17 +109,23 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
>   */
>  static int task_bp_pinned(int cpu, struct perf_event *bp, enum bp_type_idx type)
>  {
> -       struct task_struct *tsk = bp->hw.target;
> +       struct rhlist_head *head, *pos;
>         struct perf_event *iter;
>         int count = 0;
>
> -       list_for_each_entry(iter, &bp_task_head, hw.bp_list) {
> -               if (iter->hw.target == tsk &&
> -                   find_slot_idx(iter->attr.bp_type) == type &&
> +       rcu_read_lock();
> +       head = rhltable_lookup(&task_bps_ht, &bp->hw.target, task_bps_ht_params);
> +       if (!head)
> +               goto out;
> +
> +       rhl_for_each_entry_rcu(iter, pos, head, hw.bp_list) {
> +               if (find_slot_idx(iter->attr.bp_type) == type &&
>                     (iter->cpu < 0 || cpu == iter->cpu))
>                         count += hw_breakpoint_weight(iter);
>         }
>
> +out:
> +       rcu_read_unlock();
>         return count;
>  }
>
> @@ -186,7 +198,7 @@ static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
>  /*
>   * Add/remove the given breakpoint in our constraint table
>   */
> -static void
> +static int
>  toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
>                int weight)
>  {
> @@ -199,7 +211,7 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
>         /* Pinned counter cpu profiling */
>         if (!bp->hw.target) {
>                 get_bp_info(bp->cpu, type)->cpu_pinned += weight;
> -               return;
> +               return 0;
>         }
>
>         /* Pinned counter task profiling */
> @@ -207,9 +219,9 @@ toggle_bp_slot(struct perf_event *bp, bool enable, enum bp_type_idx type,
>                 toggle_bp_task_slot(bp, cpu, type, weight);
>
>         if (enable)
> -               list_add_tail(&bp->hw.bp_list, &bp_task_head);
> +               return rhltable_insert(&task_bps_ht, &bp->hw.bp_list, task_bps_ht_params);
>         else
> -               list_del(&bp->hw.bp_list);
> +               return rhltable_remove(&task_bps_ht, &bp->hw.bp_list, task_bps_ht_params);
>  }
>
>  __weak int arch_reserve_bp_slot(struct perf_event *bp)
> @@ -307,9 +319,7 @@ static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
>         if (ret)
>                 return ret;
>
> -       toggle_bp_slot(bp, true, type, weight);
> -
> -       return 0;
> +       return toggle_bp_slot(bp, true, type, weight);
>  }
>
>  int reserve_bp_slot(struct perf_event *bp)
> @@ -334,7 +344,7 @@ static void __release_bp_slot(struct perf_event *bp, u64 bp_type)
>
>         type = find_slot_idx(bp_type);
>         weight = hw_breakpoint_weight(bp);
> -       toggle_bp_slot(bp, false, type, weight);
> +       WARN_ON(toggle_bp_slot(bp, false, type, weight));
>  }
>
>  void release_bp_slot(struct perf_event *bp)
> @@ -707,7 +717,7 @@ static struct pmu perf_breakpoint = {
>  int __init init_hw_breakpoint(void)
>  {
>         int cpu, err_cpu;
> -       int i;
> +       int i, ret;
>
>         for (i = 0; i < TYPE_MAX; i++)
>                 nr_slots[i] = hw_breakpoint_slots(i);
> @@ -718,18 +728,24 @@ int __init init_hw_breakpoint(void)
>
>                         info->tsk_pinned = kcalloc(nr_slots[i], sizeof(int),
>                                                         GFP_KERNEL);
> -                       if (!info->tsk_pinned)
> -                               goto err_alloc;
> +                       if (!info->tsk_pinned) {
> +                               ret = -ENOMEM;
> +                               goto err;
> +                       }
>                 }
>         }
>
> +       ret = rhltable_init(&task_bps_ht, &task_bps_ht_params);
> +       if (ret)
> +               goto err;
> +
>         constraints_initialized = 1;
>
>         perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
>
>         return register_die_notifier(&hw_breakpoint_exceptions_nb);
>
> - err_alloc:
> +err:
>         for_each_possible_cpu(err_cpu) {
>                 for (i = 0; i < TYPE_MAX; i++)
>                         kfree(get_bp_info(err_cpu, i)->tsk_pinned);
> @@ -737,7 +753,5 @@ int __init init_hw_breakpoint(void)
>                         break;
>         }
>
> -       return -ENOMEM;
> +       return ret;
>  }
> -
> -
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
