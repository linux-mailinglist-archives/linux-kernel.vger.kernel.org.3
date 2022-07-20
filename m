Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197DD57BA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiGTPkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbiGTPkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:40:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3524F595
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:40:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a11so4971794wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfOYEoaq+RNfeRfiK+P7IRpz2zKNnjNtUDOpewE84TE=;
        b=fL48WuRKJ2IAhCBtWiy5p2C8r3qQewRFiArnauAI98D5hB9oELk9rDgTgRMJXNni1X
         OQehJnk9lncoGeR+rFFvsxe2DTAvbcUqvuYq/wb/BDn1pqoz6vP57BCn+SC0MaARCQC5
         PDGJTin/egktoOc5erIw4qwU3r0Ptad+4yooIygkNlKbfhokV/KFryOp683rc/s+GLKO
         rrGQQS2HHIAkyMjH89wO5IKNCBVtFpfjjqGk269fH7GnWfooXC73pcy51/kxfZZlsIM4
         nb5xbJwRbNYrqA3Oi19cgbnPFGL8aeB4D7y3WNY1zlWuPtSsiIKvGbK/kJMHA2U7Wmop
         S7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfOYEoaq+RNfeRfiK+P7IRpz2zKNnjNtUDOpewE84TE=;
        b=njmEg8iKhf1zjyVASkxf9gD+/GO9N9ioh/iDttBYBoHVCpbVZSFQJ4W1LJrbDm0mCJ
         sQOyvsfrgNz9doVoFLV14vzeB/FuwTZCQqbMtv7op08styNkvc5mzyuDT6polVDTM5Wg
         wv7cKFgOalpwXkQhAlLEc8KRRm3mNbYQCN1dLOMvFOM3okGw4BNKiYZUnT6qESiFAtYS
         6gB5WpWxdcPqVPansMp57gkHX2cUedi6i/tBeah6N6jMBDeT4Zm9PHa6v6gpHhnoLWp2
         Vg/ATAuqT5ZvIWTM2u4BvWXUQVOysV3/VZqSoyCZUy+OfN7vEk1s68i0twMtLINF28qg
         nCAQ==
X-Gm-Message-State: AJIora/8hQquWoMW0ikKpLd5ZQIe7l5vjYfmMdVLuEMS0hytEUiVq+Mi
        DekvK5KjzJLirE/HTNaPgfE8ZNtw+GXC4eEd684HxA==
X-Google-Smtp-Source: AGRyM1uhhGBhmz3KpJ9bteLNGojXSu5yv+8KEZtSNw29wVTyF/IXrzAs2AbrAjRpbLI9MKrcihbVTALivoYFVkvde7s=
X-Received: by 2002:a7b:ce13:0:b0:3a3:102c:23d3 with SMTP id
 m19-20020a7bce13000000b003a3102c23d3mr4361425wmc.67.1658331612893; Wed, 20
 Jul 2022 08:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-13-elver@google.com>
In-Reply-To: <20220704150514.48816-13-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:40:00 -0700
Message-ID: <CAP-5=fUK6HfWPLLHtFszEdkv_EVuoxgW88jj7xtpRHM8OGSBmg@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] perf/hw_breakpoint: Introduce bp_slots_histogram
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
> Factor out the existing `atomic_t count[N]` into its own struct called
> 'bp_slots_histogram', to generalize and make its intent clearer in
> preparation of reusing elsewhere. The basic idea of bucketing "total
> uses of N slots" resembles a histogram, so calling it such seems most
> intuitive.
>
> No functional change.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v3:
> * Also warn in bp_slots_histogram_add() if count goes below 0.
>
> v2:
> * New patch.
> ---
>  kernel/events/hw_breakpoint.c | 96 +++++++++++++++++++++++------------
>  1 file changed, 63 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index 229c6f4fae75..03ebecf048c0 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -36,19 +36,27 @@
>  #include <linux/slab.h>
>
>  /*
> - * Constraints data
> + * Datastructure to track the total uses of N slots across tasks or CPUs;
> + * bp_slots_histogram::count[N] is the number of assigned N+1 breakpoint slots.
>   */
> -struct bp_cpuinfo {
> -       /* Number of pinned cpu breakpoints in a cpu */
> -       unsigned int    cpu_pinned;
> -       /* tsk_pinned[n] is the number of tasks having n+1 breakpoints */
> +struct bp_slots_histogram {
>  #ifdef hw_breakpoint_slots
> -       atomic_t        tsk_pinned[hw_breakpoint_slots(0)];
> +       atomic_t count[hw_breakpoint_slots(0)];
>  #else
> -       atomic_t        *tsk_pinned;
> +       atomic_t *count;
>  #endif
>  };
>
> +/*
> + * Per-CPU constraints data.
> + */
> +struct bp_cpuinfo {
> +       /* Number of pinned CPU breakpoints in a CPU. */
> +       unsigned int                    cpu_pinned;
> +       /* Histogram of pinned task breakpoints in a CPU. */
> +       struct bp_slots_histogram       tsk_pinned;
> +};
> +
>  static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
>
>  static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
> @@ -159,6 +167,18 @@ static inline int hw_breakpoint_slots_cached(int type)
>         return __nr_bp_slots[type];
>  }
>
> +static __init bool
> +bp_slots_histogram_alloc(struct bp_slots_histogram *hist, enum bp_type_idx type)
> +{
> +       hist->count = kcalloc(hw_breakpoint_slots_cached(type), sizeof(*hist->count), GFP_KERNEL);
> +       return hist->count;
> +}
> +
> +static __init void bp_slots_histogram_free(struct bp_slots_histogram *hist)
> +{
> +       kfree(hist->count);
> +}
> +
>  static __init int init_breakpoint_slots(void)
>  {
>         int i, cpu, err_cpu;
> @@ -170,8 +190,7 @@ static __init int init_breakpoint_slots(void)
>                 for (i = 0; i < TYPE_MAX; i++) {
>                         struct bp_cpuinfo *info = get_bp_info(cpu, i);
>
> -                       info->tsk_pinned = kcalloc(__nr_bp_slots[i], sizeof(atomic_t), GFP_KERNEL);
> -                       if (!info->tsk_pinned)
> +                       if (!bp_slots_histogram_alloc(&info->tsk_pinned, i))
>                                 goto err;
>                 }
>         }
> @@ -180,7 +199,7 @@ static __init int init_breakpoint_slots(void)
>  err:
>         for_each_possible_cpu(err_cpu) {
>                 for (i = 0; i < TYPE_MAX; i++)
> -                       kfree(get_bp_info(err_cpu, i)->tsk_pinned);
> +                       bp_slots_histogram_free(&get_bp_info(err_cpu, i)->tsk_pinned);
>                 if (err_cpu == cpu)
>                         break;
>         }
> @@ -189,6 +208,34 @@ static __init int init_breakpoint_slots(void)
>  }
>  #endif
>
> +static inline void
> +bp_slots_histogram_add(struct bp_slots_histogram *hist, int old, int val)
> +{
> +       const int old_idx = old - 1;
> +       const int new_idx = old_idx + val;
> +
> +       if (old_idx >= 0)
> +               WARN_ON(atomic_dec_return_relaxed(&hist->count[old_idx]) < 0);
> +       if (new_idx >= 0)
> +               WARN_ON(atomic_inc_return_relaxed(&hist->count[new_idx]) < 0);
> +}
> +
> +static int
> +bp_slots_histogram_max(struct bp_slots_histogram *hist, enum bp_type_idx type)
> +{
> +       for (int i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
> +               const int count = atomic_read(&hist->count[i]);
> +
> +               /* Catch unexpected writers; we want a stable snapshot. */
> +               ASSERT_EXCLUSIVE_WRITER(hist->count[i]);
> +               if (count > 0)
> +                       return i + 1;
> +               WARN(count < 0, "inconsistent breakpoint slots histogram");
> +       }
> +
> +       return 0;
> +}
> +
>  #ifndef hw_breakpoint_weight
>  static inline int hw_breakpoint_weight(struct perf_event *bp)
>  {
> @@ -205,13 +252,11 @@ static inline enum bp_type_idx find_slot_idx(u64 bp_type)
>  }
>
>  /*
> - * Report the maximum number of pinned breakpoints a task
> - * have in this cpu
> + * Return the maximum number of pinned breakpoints a task has in this CPU.
>   */
>  static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
>  {
> -       atomic_t *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
> -       int i;
> +       struct bp_slots_histogram *tsk_pinned = &get_bp_info(cpu, type)->tsk_pinned;
>
>         /*
>          * At this point we want to have acquired the bp_cpuinfo_sem as a
> @@ -219,14 +264,7 @@ static unsigned int max_task_bp_pinned(int cpu, enum bp_type_idx type)
>          * toggle_bp_task_slot() to tsk_pinned, and we get a stable snapshot.
>          */
>         lockdep_assert_held_write(&bp_cpuinfo_sem);
> -
> -       for (i = hw_breakpoint_slots_cached(type) - 1; i >= 0; i--) {
> -               ASSERT_EXCLUSIVE_WRITER(tsk_pinned[i]); /* Catch unexpected writers. */
> -               if (atomic_read(&tsk_pinned[i]) > 0)
> -                       return i + 1;
> -       }
> -
> -       return 0;
> +       return bp_slots_histogram_max(tsk_pinned, type);
>  }
>
>  /*
> @@ -300,8 +338,7 @@ max_bp_pinned_slots(struct perf_event *bp, enum bp_type_idx type)
>  static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
>                                 enum bp_type_idx type, int weight)
>  {
> -       atomic_t *tsk_pinned = get_bp_info(cpu, type)->tsk_pinned;
> -       int old_idx, new_idx;
> +       struct bp_slots_histogram *tsk_pinned = &get_bp_info(cpu, type)->tsk_pinned;
>
>         /*
>          * If bp->hw.target, tsk_pinned is only modified, but not used
> @@ -311,14 +348,7 @@ static void toggle_bp_task_slot(struct perf_event *bp, int cpu,
>          * bp_cpuinfo_sem as a writer to stabilize tsk_pinned's value.
>          */
>         lockdep_assert_held_read(&bp_cpuinfo_sem);
> -
> -       old_idx = task_bp_pinned(cpu, bp, type) - 1;
> -       new_idx = old_idx + weight;
> -
> -       if (old_idx >= 0)
> -               atomic_dec(&tsk_pinned[old_idx]);
> -       if (new_idx >= 0)
> -               atomic_inc(&tsk_pinned[new_idx]);
> +       bp_slots_histogram_add(tsk_pinned, task_bp_pinned(cpu, bp, type), weight);
>  }
>
>  /*
> @@ -768,7 +798,7 @@ bool hw_breakpoint_is_used(void)
>                                 return true;
>
>                         for (int slot = 0; slot < hw_breakpoint_slots_cached(type); ++slot) {
> -                               if (atomic_read(&info->tsk_pinned[slot]))
> +                               if (atomic_read(&info->tsk_pinned.count[slot]))
>                                         return true;
>                         }
>                 }
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
