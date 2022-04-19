Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436B9507202
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353967AbiDSPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344187AbiDSPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:43:26 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2937C2650;
        Tue, 19 Apr 2022 08:40:43 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2ec42eae76bso176694687b3.10;
        Tue, 19 Apr 2022 08:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHXxhy+upNQpqkNAFzDFPpY6p3DKTPEkF54eq/c7qaE=;
        b=vFE1KHy4TE/A5UFstSeGBCTJHBzjVJsztWazx6doDCj05BfwYNF+u/E5k/Nu39NTOV
         hePyIzeG8ydLP6i1GERW/KWWjaK4p4a7IxpbV5/sjABMO7s1jpGfcf6IEyqYqVrsywle
         YWWOlvHNKONPKlxPIHtCd3+pJLgNpmjN+PUH36SBx3+O9O36o7l5V+K8Bn/0hbdelDOT
         0AuyoZc7UYVvbHGE3S4ZEWJolK/OSk9XvBHjhLFSeQV8J3c+5R+4K4sugN12ZyW6qvm1
         6glfgH3Pp5oBGmCn9mPqUU4WhIdflqhgV0RORktTI2CMXyDh01Vc5MTJzjLaIA3/qpCX
         sqJg==
X-Gm-Message-State: AOAM533sms3/ryEF5vCu1lAlqLq8SUE6V58W/0V1077nzqOd4TMWJZ/F
        4L+aFpFrChDzrJ1HhXGZ3MedpCFmEca706UnFVM=
X-Google-Smtp-Source: ABdhPJzxDXGnKMrr9mJ9+potcDuYIfuU2wlOZY2NcEXIpNuWTtgz8YKwbZyhUodbbFighRXKYSfvAE6a94KIhQnjIWA=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr16440574ywa.19.1650382842272; Tue, 19
 Apr 2022 08:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.478362457@linutronix.de>
In-Reply-To: <20220415161206.478362457@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 17:40:31 +0200
Message-ID: <CAJZ5v0h_Zed_0ESv2A3XJ+F3e5qAdqu6gR9xiiBnCF59cN4KCQ@mail.gmail.com>
Subject: Re: [patch 02/10] x86/smp: Move APERF/MPERF code where it belongs
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

On Fri, Apr 15, 2022 at 9:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> as this can share code with the preexisting APERF/MPERF code.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/cpu/aperfmperf.c |  366 ++++++++++++++++++++++++++++++++++++++-
>  arch/x86/kernel/smpboot.c        |  355 -------------------------------------
>  2 files changed, 362 insertions(+), 359 deletions(-)
>
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -6,15 +6,19 @@
>   * Copyright (C) 2017 Intel Corp.
>   * Author: Len Brown <len.brown@intel.com>
>   */
> -
> +#include <linux/cpufreq.h>
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
>  #include <linux/math64.h>
>  #include <linux/percpu.h>
> -#include <linux/cpufreq.h>
> -#include <linux/smp.h>
> -#include <linux/sched/isolation.h>
>  #include <linux/rcupdate.h>
> +#include <linux/sched/isolation.h>
> +#include <linux/sched/topology.h>
> +#include <linux/smp.h>
> +#include <linux/syscore_ops.h>
> +
> +#include <asm/cpu_device_id.h>
> +#include <asm/intel-family.h>
>
>  #include "cpu.h"
>
> @@ -152,3 +156,357 @@ unsigned int arch_freq_get_on_cpu(int cp
>
>         return per_cpu(samples.khz, cpu);
>  }
> +
> +#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
> +/*
> + * APERF/MPERF frequency ratio computation.
> + *
> + * The scheduler wants to do frequency invariant accounting and needs a <1
> + * ratio to account for the 'current' frequency, corresponding to
> + * freq_curr / freq_max.
> + *
> + * Since the frequency freq_curr on x86 is controlled by micro-controller and
> + * our P-state setting is little more than a request/hint, we need to observe
> + * the effective frequency 'BusyMHz', i.e. the average frequency over a time
> + * interval after discarding idle time. This is given by:
> + *
> + *   BusyMHz = delta_APERF / delta_MPERF * freq_base
> + *
> + * where freq_base is the max non-turbo P-state.
> + *
> + * The freq_max term has to be set to a somewhat arbitrary value, because we
> + * can't know which turbo states will be available at a given point in time:
> + * it all depends on the thermal headroom of the entire package. We set it to
> + * the turbo level with 4 cores active.
> + *
> + * Benchmarks show that's a good compromise between the 1C turbo ratio
> + * (freq_curr/freq_max would rarely reach 1) and something close to freq_base,
> + * which would ignore the entire turbo range (a conspicuous part, making
> + * freq_curr/freq_max always maxed out).
> + *
> + * An exception to the heuristic above is the Atom uarch, where we choose the
> + * highest turbo level for freq_max since Atom's are generally oriented towards
> + * power efficiency.
> + *
> + * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
> + * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
> + */
> +
> +DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
> +
> +static DEFINE_PER_CPU(u64, arch_prev_aperf);
> +static DEFINE_PER_CPU(u64, arch_prev_mperf);
> +static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
> +static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
> +
> +void arch_set_max_freq_ratio(bool turbo_disabled)
> +{
> +       arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
> +                                       arch_turbo_freq_ratio;
> +}
> +EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
> +
> +static bool turbo_disabled(void)
> +{
> +       u64 misc_en;
> +       int err;
> +
> +       err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
> +       if (err)
> +               return false;
> +
> +       return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> +}
> +
> +static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
> +{
> +       int err;
> +
> +       err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, base_freq);
> +       if (err)
> +               return false;
> +
> +       err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
> +       if (err)
> +               return false;
> +
> +       *base_freq = (*base_freq >> 16) & 0x3F;     /* max P state */
> +       *turbo_freq = *turbo_freq & 0x3F;           /* 1C turbo    */
> +
> +       return true;
> +}
> +
> +#define X86_MATCH(model)                                       \
> +       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,            \
> +               INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
> +
> +static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
> +       X86_MATCH(XEON_PHI_KNL),
> +       X86_MATCH(XEON_PHI_KNM),
> +       {}
> +};
> +
> +static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
> +       X86_MATCH(SKYLAKE_X),
> +       {}
> +};
> +
> +static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
> +       X86_MATCH(ATOM_GOLDMONT),
> +       X86_MATCH(ATOM_GOLDMONT_D),
> +       X86_MATCH(ATOM_GOLDMONT_PLUS),
> +       {}
> +};
> +
> +static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
> +                               int num_delta_fratio)
> +{
> +       int fratio, delta_fratio, found;
> +       int err, i;
> +       u64 msr;
> +
> +       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> +       if (err)
> +               return false;
> +
> +       *base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
> +
> +       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
> +       if (err)
> +               return false;
> +
> +       fratio = (msr >> 8) & 0xFF;
> +       i = 16;
> +       found = 0;
> +       do {
> +               if (found >= num_delta_fratio) {
> +                       *turbo_freq = fratio;
> +                       return true;
> +               }
> +
> +               delta_fratio = (msr >> (i + 5)) & 0x7;
> +
> +               if (delta_fratio) {
> +                       found += 1;
> +                       fratio -= delta_fratio;
> +               }
> +
> +               i += 8;
> +       } while (i < 64);
> +
> +       return true;
> +}
> +
> +static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
> +{
> +       u64 ratios, counts;
> +       u32 group_size;
> +       int err, i;
> +
> +       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> +       if (err)
> +               return false;
> +
> +       *base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
> +
> +       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
> +       if (err)
> +               return false;
> +
> +       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
> +       if (err)
> +               return false;
> +
> +       for (i = 0; i < 64; i += 8) {
> +               group_size = (counts >> i) & 0xFF;
> +               if (group_size >= size) {
> +                       *turbo_freq = (ratios >> i) & 0xFF;
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
> +static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
> +{
> +       u64 msr;
> +       int err;
> +
> +       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> +       if (err)
> +               return false;
> +
> +       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
> +       if (err)
> +               return false;
> +
> +       *base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
> +       *turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
> +
> +       /* The CPU may have less than 4 cores */
> +       if (!*turbo_freq)
> +               *turbo_freq = msr & 0xFF;         /* 1C turbo    */
> +
> +       return true;
> +}
> +
> +static bool intel_set_max_freq_ratio(void)
> +{
> +       u64 base_freq, turbo_freq;
> +       u64 turbo_ratio;
> +
> +       if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
> +               goto out;
> +
> +       if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
> +           skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> +               goto out;
> +
> +       if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
> +           knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> +               goto out;
> +
> +       if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
> +           skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
> +               goto out;
> +
> +       if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
> +               goto out;
> +
> +       return false;
> +
> +out:
> +       /*
> +        * Some hypervisors advertise X86_FEATURE_APERFMPERF
> +        * but then fill all MSR's with zeroes.
> +        * Some CPUs have turbo boost but don't declare any turbo ratio
> +        * in MSR_TURBO_RATIO_LIMIT.
> +        */
> +       if (!base_freq || !turbo_freq) {
> +               pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
> +               return false;
> +       }
> +
> +       turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
> +       if (!turbo_ratio) {
> +               pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
> +               return false;
> +       }
> +
> +       arch_turbo_freq_ratio = turbo_ratio;
> +       arch_set_max_freq_ratio(turbo_disabled());
> +
> +       return true;
> +}
> +
> +static void init_counter_refs(void)
> +{
> +       u64 aperf, mperf;
> +
> +       rdmsrl(MSR_IA32_APERF, aperf);
> +       rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +       this_cpu_write(arch_prev_aperf, aperf);
> +       this_cpu_write(arch_prev_mperf, mperf);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static struct syscore_ops freq_invariance_syscore_ops = {
> +       .resume = init_counter_refs,
> +};
> +
> +static void register_freq_invariance_syscore_ops(void)
> +{
> +       /* Bail out if registered already. */
> +       if (freq_invariance_syscore_ops.node.prev)
> +               return;
> +
> +       register_syscore_ops(&freq_invariance_syscore_ops);
> +}
> +#else
> +static inline void register_freq_invariance_syscore_ops(void) {}
> +#endif
> +
> +void init_freq_invariance(bool secondary, bool cppc_ready)
> +{
> +       bool ret = false;
> +
> +       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> +               return;
> +
> +       if (secondary) {
> +               if (static_branch_likely(&arch_scale_freq_key)) {
> +                       init_counter_refs();
> +               }
> +               return;
> +       }
> +
> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +               ret = intel_set_max_freq_ratio();
> +       else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> +               if (!cppc_ready) {
> +                       return;
> +               }
> +               ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
> +       }
> +
> +       if (ret) {
> +               init_counter_refs();
> +               static_branch_enable(&arch_scale_freq_key);
> +               register_freq_invariance_syscore_ops();
> +               pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
> +       } else {
> +               pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
> +       }
> +}
> +
> +static void disable_freq_invariance_workfn(struct work_struct *work)
> +{
> +       static_branch_disable(&arch_scale_freq_key);
> +}
> +
> +static DECLARE_WORK(disable_freq_invariance_work,
> +                   disable_freq_invariance_workfn);
> +
> +DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
> +
> +void arch_scale_freq_tick(void)
> +{
> +       u64 freq_scale;
> +       u64 aperf, mperf;
> +       u64 acnt, mcnt;
> +
> +       if (!arch_scale_freq_invariant())
> +               return;
> +
> +       rdmsrl(MSR_IA32_APERF, aperf);
> +       rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +       acnt = aperf - this_cpu_read(arch_prev_aperf);
> +       mcnt = mperf - this_cpu_read(arch_prev_mperf);
> +
> +       this_cpu_write(arch_prev_aperf, aperf);
> +       this_cpu_write(arch_prev_mperf, mperf);
> +
> +       if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> +               goto error;
> +
> +       if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
> +               goto error;
> +
> +       freq_scale = div64_u64(acnt, mcnt);
> +       if (!freq_scale)
> +               goto error;
> +
> +       if (freq_scale > SCHED_CAPACITY_SCALE)
> +               freq_scale = SCHED_CAPACITY_SCALE;
> +
> +       this_cpu_write(arch_freq_scale, freq_scale);
> +       return;
> +
> +error:
> +       pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
> +       schedule_work(&disable_freq_invariance_work);
> +}
> +#endif /* CONFIG_X86_64 && CONFIG_SMP */
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -56,7 +56,6 @@
>  #include <linux/numa.h>
>  #include <linux/pgtable.h>
>  #include <linux/overflow.h>
> -#include <linux/syscore_ops.h>
>
>  #include <asm/acpi.h>
>  #include <asm/desc.h>
> @@ -1847,357 +1846,3 @@ void native_play_dead(void)
>  }
>
>  #endif
> -
> -#ifdef CONFIG_X86_64
> -/*
> - * APERF/MPERF frequency ratio computation.
> - *
> - * The scheduler wants to do frequency invariant accounting and needs a <1
> - * ratio to account for the 'current' frequency, corresponding to
> - * freq_curr / freq_max.
> - *
> - * Since the frequency freq_curr on x86 is controlled by micro-controller and
> - * our P-state setting is little more than a request/hint, we need to observe
> - * the effective frequency 'BusyMHz', i.e. the average frequency over a time
> - * interval after discarding idle time. This is given by:
> - *
> - *   BusyMHz = delta_APERF / delta_MPERF * freq_base
> - *
> - * where freq_base is the max non-turbo P-state.
> - *
> - * The freq_max term has to be set to a somewhat arbitrary value, because we
> - * can't know which turbo states will be available at a given point in time:
> - * it all depends on the thermal headroom of the entire package. We set it to
> - * the turbo level with 4 cores active.
> - *
> - * Benchmarks show that's a good compromise between the 1C turbo ratio
> - * (freq_curr/freq_max would rarely reach 1) and something close to freq_base,
> - * which would ignore the entire turbo range (a conspicuous part, making
> - * freq_curr/freq_max always maxed out).
> - *
> - * An exception to the heuristic above is the Atom uarch, where we choose the
> - * highest turbo level for freq_max since Atom's are generally oriented towards
> - * power efficiency.
> - *
> - * Setting freq_max to anything less than the 1C turbo ratio makes the ratio
> - * freq_curr / freq_max to eventually grow >1, in which case we clip it to 1.
> - */
> -
> -DEFINE_STATIC_KEY_FALSE(arch_scale_freq_key);
> -
> -static DEFINE_PER_CPU(u64, arch_prev_aperf);
> -static DEFINE_PER_CPU(u64, arch_prev_mperf);
> -static u64 arch_turbo_freq_ratio = SCHED_CAPACITY_SCALE;
> -static u64 arch_max_freq_ratio = SCHED_CAPACITY_SCALE;
> -
> -void arch_set_max_freq_ratio(bool turbo_disabled)
> -{
> -       arch_max_freq_ratio = turbo_disabled ? SCHED_CAPACITY_SCALE :
> -                                       arch_turbo_freq_ratio;
> -}
> -EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
> -
> -static bool turbo_disabled(void)
> -{
> -       u64 misc_en;
> -       int err;
> -
> -       err = rdmsrl_safe(MSR_IA32_MISC_ENABLE, &misc_en);
> -       if (err)
> -               return false;
> -
> -       return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> -}
> -
> -static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
> -{
> -       int err;
> -
> -       err = rdmsrl_safe(MSR_ATOM_CORE_RATIOS, base_freq);
> -       if (err)
> -               return false;
> -
> -       err = rdmsrl_safe(MSR_ATOM_CORE_TURBO_RATIOS, turbo_freq);
> -       if (err)
> -               return false;
> -
> -       *base_freq = (*base_freq >> 16) & 0x3F;     /* max P state */
> -       *turbo_freq = *turbo_freq & 0x3F;           /* 1C turbo    */
> -
> -       return true;
> -}
> -
> -#define X86_MATCH(model)                                       \
> -       X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,            \
> -               INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
> -
> -static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
> -       X86_MATCH(XEON_PHI_KNL),
> -       X86_MATCH(XEON_PHI_KNM),
> -       {}
> -};
> -
> -static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
> -       X86_MATCH(SKYLAKE_X),
> -       {}
> -};
> -
> -static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
> -       X86_MATCH(ATOM_GOLDMONT),
> -       X86_MATCH(ATOM_GOLDMONT_D),
> -       X86_MATCH(ATOM_GOLDMONT_PLUS),
> -       {}
> -};
> -
> -static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
> -                               int num_delta_fratio)
> -{
> -       int fratio, delta_fratio, found;
> -       int err, i;
> -       u64 msr;
> -
> -       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> -       if (err)
> -               return false;
> -
> -       *base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
> -
> -       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
> -       if (err)
> -               return false;
> -
> -       fratio = (msr >> 8) & 0xFF;
> -       i = 16;
> -       found = 0;
> -       do {
> -               if (found >= num_delta_fratio) {
> -                       *turbo_freq = fratio;
> -                       return true;
> -               }
> -
> -               delta_fratio = (msr >> (i + 5)) & 0x7;
> -
> -               if (delta_fratio) {
> -                       found += 1;
> -                       fratio -= delta_fratio;
> -               }
> -
> -               i += 8;
> -       } while (i < 64);
> -
> -       return true;
> -}
> -
> -static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
> -{
> -       u64 ratios, counts;
> -       u32 group_size;
> -       int err, i;
> -
> -       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> -       if (err)
> -               return false;
> -
> -       *base_freq = (*base_freq >> 8) & 0xFF;      /* max P state */
> -
> -       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &ratios);
> -       if (err)
> -               return false;
> -
> -       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT1, &counts);
> -       if (err)
> -               return false;
> -
> -       for (i = 0; i < 64; i += 8) {
> -               group_size = (counts >> i) & 0xFF;
> -               if (group_size >= size) {
> -                       *turbo_freq = (ratios >> i) & 0xFF;
> -                       return true;
> -               }
> -       }
> -
> -       return false;
> -}
> -
> -static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
> -{
> -       u64 msr;
> -       int err;
> -
> -       err = rdmsrl_safe(MSR_PLATFORM_INFO, base_freq);
> -       if (err)
> -               return false;
> -
> -       err = rdmsrl_safe(MSR_TURBO_RATIO_LIMIT, &msr);
> -       if (err)
> -               return false;
> -
> -       *base_freq = (*base_freq >> 8) & 0xFF;    /* max P state */
> -       *turbo_freq = (msr >> 24) & 0xFF;         /* 4C turbo    */
> -
> -       /* The CPU may have less than 4 cores */
> -       if (!*turbo_freq)
> -               *turbo_freq = msr & 0xFF;         /* 1C turbo    */
> -
> -       return true;
> -}
> -
> -static bool intel_set_max_freq_ratio(void)
> -{
> -       u64 base_freq, turbo_freq;
> -       u64 turbo_ratio;
> -
> -       if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
> -               goto out;
> -
> -       if (x86_match_cpu(has_glm_turbo_ratio_limits) &&
> -           skx_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> -               goto out;
> -
> -       if (x86_match_cpu(has_knl_turbo_ratio_limits) &&
> -           knl_set_max_freq_ratio(&base_freq, &turbo_freq, 1))
> -               goto out;
> -
> -       if (x86_match_cpu(has_skx_turbo_ratio_limits) &&
> -           skx_set_max_freq_ratio(&base_freq, &turbo_freq, 4))
> -               goto out;
> -
> -       if (core_set_max_freq_ratio(&base_freq, &turbo_freq))
> -               goto out;
> -
> -       return false;
> -
> -out:
> -       /*
> -        * Some hypervisors advertise X86_FEATURE_APERFMPERF
> -        * but then fill all MSR's with zeroes.
> -        * Some CPUs have turbo boost but don't declare any turbo ratio
> -        * in MSR_TURBO_RATIO_LIMIT.
> -        */
> -       if (!base_freq || !turbo_freq) {
> -               pr_debug("Couldn't determine cpu base or turbo frequency, necessary for scale-invariant accounting.\n");
> -               return false;
> -       }
> -
> -       turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
> -       if (!turbo_ratio) {
> -               pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
> -               return false;
> -       }
> -
> -       arch_turbo_freq_ratio = turbo_ratio;
> -       arch_set_max_freq_ratio(turbo_disabled());
> -
> -       return true;
> -}
> -
> -static void init_counter_refs(void)
> -{
> -       u64 aperf, mperf;
> -
> -       rdmsrl(MSR_IA32_APERF, aperf);
> -       rdmsrl(MSR_IA32_MPERF, mperf);
> -
> -       this_cpu_write(arch_prev_aperf, aperf);
> -       this_cpu_write(arch_prev_mperf, mperf);
> -}
> -
> -#ifdef CONFIG_PM_SLEEP
> -static struct syscore_ops freq_invariance_syscore_ops = {
> -       .resume = init_counter_refs,
> -};
> -
> -static void register_freq_invariance_syscore_ops(void)
> -{
> -       /* Bail out if registered already. */
> -       if (freq_invariance_syscore_ops.node.prev)
> -               return;
> -
> -       register_syscore_ops(&freq_invariance_syscore_ops);
> -}
> -#else
> -static inline void register_freq_invariance_syscore_ops(void) {}
> -#endif
> -
> -void init_freq_invariance(bool secondary, bool cppc_ready)
> -{
> -       bool ret = false;
> -
> -       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> -               return;
> -
> -       if (secondary) {
> -               if (static_branch_likely(&arch_scale_freq_key)) {
> -                       init_counter_refs();
> -               }
> -               return;
> -       }
> -
> -       if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> -               ret = intel_set_max_freq_ratio();
> -       else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> -               if (!cppc_ready) {
> -                       return;
> -               }
> -               ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
> -       }
> -
> -       if (ret) {
> -               init_counter_refs();
> -               static_branch_enable(&arch_scale_freq_key);
> -               register_freq_invariance_syscore_ops();
> -               pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
> -       } else {
> -               pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
> -       }
> -}
> -
> -static void disable_freq_invariance_workfn(struct work_struct *work)
> -{
> -       static_branch_disable(&arch_scale_freq_key);
> -}
> -
> -static DECLARE_WORK(disable_freq_invariance_work,
> -                   disable_freq_invariance_workfn);
> -
> -DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
> -
> -void arch_scale_freq_tick(void)
> -{
> -       u64 freq_scale;
> -       u64 aperf, mperf;
> -       u64 acnt, mcnt;
> -
> -       if (!arch_scale_freq_invariant())
> -               return;
> -
> -       rdmsrl(MSR_IA32_APERF, aperf);
> -       rdmsrl(MSR_IA32_MPERF, mperf);
> -
> -       acnt = aperf - this_cpu_read(arch_prev_aperf);
> -       mcnt = mperf - this_cpu_read(arch_prev_mperf);
> -
> -       this_cpu_write(arch_prev_aperf, aperf);
> -       this_cpu_write(arch_prev_mperf, mperf);
> -
> -       if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> -               goto error;
> -
> -       if (check_mul_overflow(mcnt, arch_max_freq_ratio, &mcnt) || !mcnt)
> -               goto error;
> -
> -       freq_scale = div64_u64(acnt, mcnt);
> -       if (!freq_scale)
> -               goto error;
> -
> -       if (freq_scale > SCHED_CAPACITY_SCALE)
> -               freq_scale = SCHED_CAPACITY_SCALE;
> -
> -       this_cpu_write(arch_freq_scale, freq_scale);
> -       return;
> -
> -error:
> -       pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
> -       schedule_work(&disable_freq_invariance_work);
> -}
> -#endif /* CONFIG_X86_64 */
>
