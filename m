Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC35507315
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352311AbiDSQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbiDSQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:40:21 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D1713EB2;
        Tue, 19 Apr 2022 09:37:38 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id x200so31965552ybe.13;
        Tue, 19 Apr 2022 09:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VJILz0D6wN43Mvz3whrxbRWAuiBviKyt3Egte5MPtc=;
        b=7HDcMYyiP/G6zNKnqrUh6qFIp/OT3jZjR8fUJumKCawvs0AWgHudtQAGWhzouZvt+X
         H0pVRA/WApSKdYSKgkmX9MRFv5smwCWZUXqrxBnM6jsiLITU2BH4KKdUyB17xRPxeCTf
         WHNeOCnsX8bNAt3lrExJLyR+ZyKIGc7CuATJT6NouhyVApqAnUdlW0dT7UDjc4zB8wBz
         uIWPMdsdX2xURaXjNl3tn6lNxRViTD5lU4zEipFkMy48PyITYMHzLGLACTKaSh3pUKN+
         VRI2IHkSBytwhddvjniIarZUb+enpjL7MwzNSihE6kcjVn9f+Ofu69YQ77R4DcG9l5e2
         ik7g==
X-Gm-Message-State: AOAM5314sZ1prNnkx+hieUAVyJ8zlhORM6G+3Nnr/vsXy3bSMmCm5gwB
        IruWP+TdRMQuvxLgmfd74P3LqszOt3JFSyOtW2s=
X-Google-Smtp-Source: ABdhPJwkKAullBGAw9ZlVXtmETbA9O34EM5azvrq1UVQg+ilUqJCTVzT5AoypoSCvOtw1YDpUOZr7CzOl9CyVN0XmZ8=
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr15106699ybs.365.1650386257808; Tue, 19
 Apr 2022 09:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.934040006@linutronix.de>
In-Reply-To: <20220415161206.934040006@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 18:37:27 +0200
Message-ID: <CAJZ5v0iDJ7k5cyZt8GWp4kBVrk8h74+kY_=dh48m1xnf9G3ksQ@mail.gmail.com>
Subject: Re: [patch 10/10] x86/aperfmperf: Replace arch_freq_get_on_cpu()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 9:20 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Reading the current CPU frequency from /sys/..../scaling_cur_freq involves
> in the worst case two IPIs due to the ad hoc sampling.
>
> The frequency invariance infrastructure provides the APERF/MPERF samples
> already. Utilize them and consolidate this with the /proc/cpuinfo readout.
>
> The sample is considered valid for 20ms. So for idle or isolated NOHZ full
> CPUs the function returns 0, which is matching the previous behaviour.
>
> The resulting text size vs. the original APERF/MPERF plus the separate
> frequency invariance code:
>
>   text:         2411    ->   723
>   init.text:       0    ->   767
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

All good AFAICS.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/cpu/aperfmperf.c |   94 ---------------------------------------
>  arch/x86/kernel/cpu/proc.c       |    2
>  2 files changed, 2 insertions(+), 94 deletions(-)
>
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -35,98 +35,6 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(str
>         .seq = SEQCNT_ZERO(cpu_samples.seq)
>  };
>
> -struct aperfmperf_sample {
> -       unsigned int    khz;
> -       atomic_t        scfpending;
> -       ktime_t time;
> -       u64     aperf;
> -       u64     mperf;
> -};
> -
> -static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
> -
> -#define APERFMPERF_CACHE_THRESHOLD_MS  10
> -#define APERFMPERF_REFRESH_DELAY_MS    10
> -#define APERFMPERF_STALE_THRESHOLD_MS  1000
> -
> -/*
> - * aperfmperf_snapshot_khz()
> - * On the current CPU, snapshot APERF, MPERF, and jiffies
> - * unless we already did it within 10ms
> - * calculate kHz, save snapshot
> - */
> -static void aperfmperf_snapshot_khz(void *dummy)
> -{
> -       u64 aperf, aperf_delta;
> -       u64 mperf, mperf_delta;
> -       struct aperfmperf_sample *s = this_cpu_ptr(&samples);
> -       unsigned long flags;
> -
> -       local_irq_save(flags);
> -       rdmsrl(MSR_IA32_APERF, aperf);
> -       rdmsrl(MSR_IA32_MPERF, mperf);
> -       local_irq_restore(flags);
> -
> -       aperf_delta = aperf - s->aperf;
> -       mperf_delta = mperf - s->mperf;
> -
> -       /*
> -        * There is no architectural guarantee that MPERF
> -        * increments faster than we can read it.
> -        */
> -       if (mperf_delta == 0)
> -               return;
> -
> -       s->time = ktime_get();
> -       s->aperf = aperf;
> -       s->mperf = mperf;
> -       s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
> -       atomic_set_release(&s->scfpending, 0);
> -}
> -
> -static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
> -{
> -       s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
> -       struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
> -
> -       /* Don't bother re-computing within the cache threshold time. */
> -       if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
> -               return true;
> -
> -       if (!atomic_xchg(&s->scfpending, 1) || wait)
> -               smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
> -
> -       /* Return false if the previous iteration was too long ago. */
> -       return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
> -}
> -
> -unsigned int arch_freq_get_on_cpu(int cpu)
> -{
> -       struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
> -
> -       if (!cpu_khz)
> -               return 0;
> -
> -       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> -               return 0;
> -
> -       if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
> -               return 0;
> -
> -       if (rcu_is_idle_cpu(cpu))
> -               return 0;
> -
> -       if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
> -               return per_cpu(samples.khz, cpu);
> -
> -       msleep(APERFMPERF_REFRESH_DELAY_MS);
> -       atomic_set(&s->scfpending, 1);
> -       smp_mb(); /* ->scfpending before smp_call_function_single(). */
> -       smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
> -
> -       return per_cpu(samples.khz, cpu);
> -}
> -
>  static void init_counter_refs(void)
>  {
>         u64 aperf, mperf;
> @@ -493,7 +401,7 @@ void arch_scale_freq_tick(void)
>   */
>  #define MAX_SAMPLE_AGE ((unsigned long)HZ / 50)
>
> -unsigned int aperfmperf_get_khz(int cpu)
> +unsigned int arch_freq_get_on_cpu(int cpu)
>  {
>         struct aperfmperf *s = per_cpu_ptr(&cpu_samples, cpu);
>         unsigned long last;
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -84,7 +84,7 @@ static int show_cpuinfo(struct seq_file
>                 seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>
>         if (cpu_has(c, X86_FEATURE_TSC)) {
> -               unsigned int freq = aperfmperf_get_khz(cpu);
> +               unsigned int freq = arch_freq_get_on_cpu(cpu);
>
>                 if (!freq)
>                         freq = cpufreq_quick_get(cpu);
>
