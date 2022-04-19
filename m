Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432115072B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354420AbiDSQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiDSQPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:15:40 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DD2DAA5;
        Tue, 19 Apr 2022 09:12:55 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id d19so3512974ybc.5;
        Tue, 19 Apr 2022 09:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahlkSQ1Q7IVODxbtVnwEVsgusd2F6nnMR0ro7snh+9w=;
        b=XZsPiUVymbZ2iwtN5K18sEgRMkVRqN63e09Vg86iOSOBbAPmAy0m4CqcJXdGl77Oke
         yrJZdz9IwiXpTl5waUUsjfBsVUA8Np9Q6G2GQ6NPLLrCYF6AyDxbk4dflD1KGgfMYHft
         XIKfrmLsNZkzZ2uzUIguwInbdBOD20rMA3yWzjtE2P4ucZpUvqoxzeBYtadOYDi9XFqR
         zGiuvfpERZHQdDSWWaYysOQsB73hDBCP++Q/f7Tp8tPnJidBOY06F3AZtF7JdLWVXRN/
         ldsXrUrFpvApEqiq0S7O8FCwR20K1LovINccRgWASwM08H8W+drvnV9/rcP4cN2pyPbA
         oofw==
X-Gm-Message-State: AOAM531P4GYeevZTTl6bm1fmVO0spbMRKnEjBwqFXUQxnghsyZqDy8bl
        krIol+mVENuDeAeMCEcbH2s7cV+u2cTvs6wQPww=
X-Google-Smtp-Source: ABdhPJzP5BH+FIwAKiepui8YLYzPsx8vy5c+sQY4L5GEPtpE+Gj/EYneweZpgeL9h5VJ8dUGIGiC4WlU2luf2bSJI/M=
X-Received: by 2002:a05:6902:352:b0:63e:94c:883c with SMTP id
 e18-20020a056902035200b0063e094c883cmr14987387ybs.365.1650384774742; Tue, 19
 Apr 2022 09:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.592465719@linutronix.de>
In-Reply-To: <20220415161206.592465719@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 18:12:43 +0200
Message-ID: <CAJZ5v0inX0ATmv8XAqVUwUa1qLCpE_mwbsFHbHqTbZFYq6FyUA@mail.gmail.com>
Subject: Re: [patch 04/10] x86/aperfmperf: Untangle Intel and AMD frequency
 invariance init
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
> AMD boot CPU initialization happens late via ACPI/CPPC which prevents the
> Intel parts from being marked __init.
>
> Split out the common code and provide a dedicated interface for the AMD
> initialization and mark the Intel specific code and data __init.
>
> The remaining text size is almost cut in half:
>
>   text:         2614    ->      1350
>   init.text:       0    ->       786
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

All good AFAICS:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/include/asm/topology.h  |   13 ++------
>  arch/x86/kernel/acpi/cppc.c      |   29 +++++++-----------
>  arch/x86/kernel/cpu/aperfmperf.c |   62 ++++++++++++++++++++-------------------
>  arch/x86/kernel/smpboot.c        |    2 -
>  4 files changed, 49 insertions(+), 57 deletions(-)
>
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -216,24 +216,19 @@ extern void arch_scale_freq_tick(void);
>  #define arch_scale_freq_tick arch_scale_freq_tick
>
>  extern void arch_set_max_freq_ratio(bool turbo_disabled);
> -extern void bp_init_freq_invariance(bool cppc_ready);
> +extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
> +extern void bp_init_freq_invariance(void);
>  extern void ap_init_freq_invariance(void);
>  #else
>  static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
> -static inline void bp_init_freq_invariance(bool cppc_ready) { }
> +static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
> +static inline void bp_init_freq_invariance(void) { }
>  static inline void ap_init_freq_invariance(void) { }
>  #endif
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
>  void init_freq_invariance_cppc(void);
>  #define arch_init_invariance_cppc init_freq_invariance_cppc
> -
> -bool amd_set_max_freq_ratio(u64 *ratio);
> -#else
> -static inline bool amd_set_max_freq_ratio(u64 *ratio)
> -{
> -       return false;
> -}
>  #endif
>
>  #endif /* _ASM_X86_TOPOLOGY_H */
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -50,20 +50,17 @@ int cpc_write_ffh(int cpunum, struct cpc
>         return err;
>  }
>
> -bool amd_set_max_freq_ratio(u64 *ratio)
> +static void amd_set_max_freq_ratio(void)
>  {
>         struct cppc_perf_caps perf_caps;
>         u64 highest_perf, nominal_perf;
>         u64 perf_ratio;
>         int rc;
>
> -       if (!ratio)
> -               return false;
> -
>         rc = cppc_get_perf_caps(0, &perf_caps);
>         if (rc) {
>                 pr_debug("Could not retrieve perf counters (%d)\n", rc);
> -               return false;
> +               return;
>         }
>
>         highest_perf = amd_get_highest_perf();
> @@ -71,7 +68,7 @@ bool amd_set_max_freq_ratio(u64 *ratio)
>
>         if (!highest_perf || !nominal_perf) {
>                 pr_debug("Could not retrieve highest or nominal performance\n");
> -               return false;
> +               return;
>         }
>
>         perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
> @@ -79,26 +76,24 @@ bool amd_set_max_freq_ratio(u64 *ratio)
>         perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
>         if (!perf_ratio) {
>                 pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
> -               return false;
> +               return;
>         }
>
> -       *ratio = perf_ratio;
> -       arch_set_max_freq_ratio(false);
> -
> -       return true;
> +       freq_invariance_set_perf_ratio(perf_ratio, false);
>  }
>
>  static DEFINE_MUTEX(freq_invariance_lock);
>
>  void init_freq_invariance_cppc(void)
>  {
> -       static bool secondary;
> +       static bool init_done;
>
> -       mutex_lock(&freq_invariance_lock);
> -
> -       if (!secondary)
> -               bp_init_freq_invariance(true);
> -       secondary = true;
> +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> +               return;
>
> +       mutex_lock(&freq_invariance_lock);
> +       if (!init_done)
> +               amd_set_max_freq_ratio();
> +       init_done = true;
>         mutex_unlock(&freq_invariance_lock);
>  }
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -206,7 +206,7 @@ void arch_set_max_freq_ratio(bool turbo_
>  }
>  EXPORT_SYMBOL_GPL(arch_set_max_freq_ratio);
>
> -static bool turbo_disabled(void)
> +static bool __init turbo_disabled(void)
>  {
>         u64 misc_en;
>         int err;
> @@ -218,7 +218,7 @@ static bool turbo_disabled(void)
>         return (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
>  }
>
> -static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
> +static bool __init slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
>  {
>         int err;
>
> @@ -240,26 +240,26 @@ static bool slv_set_max_freq_ratio(u64 *
>         X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,            \
>                 INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
>
> -static const struct x86_cpu_id has_knl_turbo_ratio_limits[] = {
> +static const struct x86_cpu_id has_knl_turbo_ratio_limits[] __initconst = {
>         X86_MATCH(XEON_PHI_KNL),
>         X86_MATCH(XEON_PHI_KNM),
>         {}
>  };
>
> -static const struct x86_cpu_id has_skx_turbo_ratio_limits[] = {
> +static const struct x86_cpu_id has_skx_turbo_ratio_limits[] __initconst = {
>         X86_MATCH(SKYLAKE_X),
>         {}
>  };
>
> -static const struct x86_cpu_id has_glm_turbo_ratio_limits[] = {
> +static const struct x86_cpu_id has_glm_turbo_ratio_limits[] __initconst = {
>         X86_MATCH(ATOM_GOLDMONT),
>         X86_MATCH(ATOM_GOLDMONT_D),
>         X86_MATCH(ATOM_GOLDMONT_PLUS),
>         {}
>  };
>
> -static bool knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
> -                               int num_delta_fratio)
> +static bool __init knl_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq,
> +                                         int num_delta_fratio)
>  {
>         int fratio, delta_fratio, found;
>         int err, i;
> @@ -297,7 +297,7 @@ static bool knl_set_max_freq_ratio(u64 *
>         return true;
>  }
>
> -static bool skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
> +static bool __init skx_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq, int size)
>  {
>         u64 ratios, counts;
>         u32 group_size;
> @@ -328,7 +328,7 @@ static bool skx_set_max_freq_ratio(u64 *
>         return false;
>  }
>
> -static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
> +static bool __init core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
>  {
>         u64 msr;
>         int err;
> @@ -351,7 +351,7 @@ static bool core_set_max_freq_ratio(u64
>         return true;
>  }
>
> -static bool intel_set_max_freq_ratio(void)
> +static bool __init intel_set_max_freq_ratio(void)
>  {
>         u64 base_freq, turbo_freq;
>         u64 turbo_ratio;
> @@ -418,40 +418,42 @@ static struct syscore_ops freq_invarianc
>
>  static void register_freq_invariance_syscore_ops(void)
>  {
> -       /* Bail out if registered already. */
> -       if (freq_invariance_syscore_ops.node.prev)
> -               return;
> -
>         register_syscore_ops(&freq_invariance_syscore_ops);
>  }
>  #else
>  static inline void register_freq_invariance_syscore_ops(void) {}
>  #endif
>
> -void bp_init_freq_invariance(bool cppc_ready)
> +static void freq_invariance_enable(void)
> +{
> +       if (static_branch_unlikely(&arch_scale_freq_key)) {
> +               WARN_ON_ONCE(1);
> +               return;
> +       }
> +       static_branch_enable(&arch_scale_freq_key);
> +       register_freq_invariance_syscore_ops();
> +       pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
> +}
> +
> +void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled)
>  {
> -       bool ret;
> +       arch_turbo_freq_ratio = ratio;
> +       arch_set_max_freq_ratio(turbo_disabled);
> +       freq_invariance_enable();
> +}
>
> +void __init bp_init_freq_invariance(void)
> +{
>         if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
>                 return;
>
>         init_counter_refs();
>
> -       if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> -               ret = intel_set_max_freq_ratio();
> -       else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> -               if (!cppc_ready)
> -                       return;
> -               ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
> -       }
> +       if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +               return;
>
> -       if (ret) {
> -               static_branch_enable(&arch_scale_freq_key);
> -               register_freq_invariance_syscore_ops();
> -               pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
> -       } else {
> -               pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
> -       }
> +       if (intel_set_max_freq_ratio())
> +               freq_invariance_enable();
>  }
>
>  void ap_init_freq_invariance(void)
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1396,7 +1396,7 @@ void __init native_smp_prepare_cpus(unsi
>  {
>         smp_prepare_cpus_common();
>
> -       bp_init_freq_invariance(false);
> +       bp_init_freq_invariance();
>         smp_sanity_check();
>
>         switch (apic_intr_mode) {
>
