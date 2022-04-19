Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776E5072F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354613AbiDSQag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245372AbiDSQae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:30:34 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEC28990;
        Tue, 19 Apr 2022 09:27:51 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2f19fdba41fso52770367b3.3;
        Tue, 19 Apr 2022 09:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BajyLJKo+lYBWEk+02hYK7E2TFNbTDMyagaWgdA8A6k=;
        b=r/7/mQNegf8KmShq60drH+qLrr++YIobOA1EZEYMd3XXPFHjNlw2ZreGw88+BIRq18
         tCavGoZD7qkNnHsxmTInVyVp1U4iQrUSOVasZHiZSlHHZ4xGYVwLffsb2HTp3GIxTPC3
         C7H7tigF+CiSr0gB19Cm7h4iLNHKYIkx7qrEU7BcrlTUSfbj+gFt6GXoA2fY0QTMyhPJ
         SLa3IvnvWq9Jb+sNKVRcddjFNDREXolumXShrL1QS+ZIzdLpuYHNVp9EDmg4Y0WeBD1T
         0biDXa/No8COB8SPa0X+Isnh8wdpcXHTeNWBRomsCVoXQKuZv5ME9118MhQ5XVYGrPvG
         G10Q==
X-Gm-Message-State: AOAM531pdhMEhUhro7kOynFvI/SjUmj4OS//ghD6Esf5PlmviEkL2akD
        VItakvTB0deSSjnDiQ90AqM+nL5pODQfiY9s2aA=
X-Google-Smtp-Source: ABdhPJxNsHxLR6N4R76caqwXPWY2gXepR2J0KId6Kkp71nv90joE2kM09cftxdu/jS+04a98iM2jNDFrevoM1J53WiY=
X-Received: by 2002:a81:ece:0:b0:2ec:9f8:acba with SMTP id 197-20020a810ece000000b002ec09f8acbamr16671661ywo.149.1650385670291;
 Tue, 19 Apr 2022 09:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.761988704@linutronix.de>
In-Reply-To: <20220415161206.761988704@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 18:27:39 +0200
Message-ID: <CAJZ5v0iovirufvvDQVGbpgdfHftULGRNksvBCsn1kd8+9ntpZw@mail.gmail.com>
Subject: Re: [patch 07/10] x86/aperfmperf: Make parts of the frequency
 invariance code unconditional
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
> The frequency invariance support is currently limited to x86/64 and SMP,
> which is the vast majority of machines.
>
> arch_scale_freq_tick() is called every tick on all CPUs and reads the APERF
> and MPERF MSRs. The CPU frequency getters function do the same via dedicated
> IPIs.
>
> While it could be argued that on systems where frequency invariance support
> is disabled (32bit, !SMP) the per tick read of the APERF and MPERF MSRs can
> be avoided, it does not make sense to keep the extra code and the resulting
> runtime issues of mass IPIs around.
>
> As a first step split out the non frequency invariance specific
> initialization code and the read MSR portion of arch_scale_freq_tick(). The
> rest of the code is still conditional and guarded with a static key.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

All good AFAICS:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/include/asm/cpu.h       |    2 +
>  arch/x86/include/asm/topology.h  |    4 --
>  arch/x86/kernel/cpu/aperfmperf.c |   63 +++++++++++++++++++++++----------------
>  arch/x86/kernel/smpboot.c        |    3 -
>  4 files changed, 41 insertions(+), 31 deletions(-)
>
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -36,6 +36,8 @@ extern int _debug_hotplug_cpu(int cpu, i
>  #endif
>  #endif
>
> +extern void ap_init_aperfmperf(void);
> +
>  int mwait_usable(const struct cpuinfo_x86 *);
>
>  unsigned int x86_family(unsigned int sig);
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -217,13 +217,9 @@ extern void arch_scale_freq_tick(void);
>
>  extern void arch_set_max_freq_ratio(bool turbo_disabled);
>  extern void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled);
> -extern void bp_init_freq_invariance(void);
> -extern void ap_init_freq_invariance(void);
>  #else
>  static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
>  static inline void freq_invariance_set_perf_ratio(u64 ratio, bool turbo_disabled) { }
> -static inline void bp_init_freq_invariance(void) { }
> -static inline void ap_init_freq_invariance(void) { }
>  #endif
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -17,6 +17,7 @@
>  #include <linux/smp.h>
>  #include <linux/syscore_ops.h>
>
> +#include <asm/cpu.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>
> @@ -164,6 +165,17 @@ unsigned int arch_freq_get_on_cpu(int cp
>         return per_cpu(samples.khz, cpu);
>  }
>
> +static void init_counter_refs(void)
> +{
> +       u64 aperf, mperf;
> +
> +       rdmsrl(MSR_IA32_APERF, aperf);
> +       rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +       this_cpu_write(cpu_samples.aperf, aperf);
> +       this_cpu_write(cpu_samples.mperf, mperf);
> +}
> +
>  #if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
>  /*
>   * APERF/MPERF frequency ratio computation.
> @@ -405,17 +417,6 @@ static bool __init intel_set_max_freq_ra
>         return true;
>  }
>
> -static void init_counter_refs(void)
> -{
> -       u64 aperf, mperf;
> -
> -       rdmsrl(MSR_IA32_APERF, aperf);
> -       rdmsrl(MSR_IA32_MPERF, mperf);
> -
> -       this_cpu_write(cpu_samples.aperf, aperf);
> -       this_cpu_write(cpu_samples.mperf, mperf);
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static struct syscore_ops freq_invariance_syscore_ops = {
>         .resume = init_counter_refs,
> @@ -447,13 +448,8 @@ void freq_invariance_set_perf_ratio(u64
>         freq_invariance_enable();
>  }
>
> -void __init bp_init_freq_invariance(void)
> +static void __init bp_init_freq_invariance(void)
>  {
> -       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> -               return;
> -
> -       init_counter_refs();
> -
>         if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>                 return;
>
> @@ -461,12 +457,6 @@ void __init bp_init_freq_invariance(void
>                 freq_invariance_enable();
>  }
>
> -void ap_init_freq_invariance(void)
> -{
> -       if (cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> -               init_counter_refs();
> -}
> -
>  static void disable_freq_invariance_workfn(struct work_struct *work)
>  {
>         static_branch_disable(&arch_scale_freq_key);
> @@ -481,6 +471,9 @@ static void scale_freq_tick(u64 acnt, u6
>  {
>         u64 freq_scale;
>
> +       if (!arch_scale_freq_invariant())
> +               return;
> +
>         if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
>                 goto error;
>
> @@ -501,13 +494,17 @@ static void scale_freq_tick(u64 acnt, u6
>         pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
>         schedule_work(&disable_freq_invariance_work);
>  }
> +#else
> +static inline void bp_init_freq_invariance(void) { }
> +static inline void scale_freq_tick(u64 acnt, u64 mcnt) { }
> +#endif /* CONFIG_X86_64 && CONFIG_SMP */
>
>  void arch_scale_freq_tick(void)
>  {
>         struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
>         u64 acnt, mcnt, aperf, mperf;
>
> -       if (!arch_scale_freq_invariant())
> +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
>                 return;
>
>         rdmsrl(MSR_IA32_APERF, aperf);
> @@ -520,4 +517,20 @@ void arch_scale_freq_tick(void)
>
>         scale_freq_tick(acnt, mcnt);
>  }
> -#endif /* CONFIG_X86_64 && CONFIG_SMP */
> +
> +static int __init bp_init_aperfmperf(void)
> +{
> +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> +               return 0;
> +
> +       init_counter_refs();
> +       bp_init_freq_invariance();
> +       return 0;
> +}
> +early_initcall(bp_init_aperfmperf);
> +
> +void ap_init_aperfmperf(void)
> +{
> +       if (cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> +               init_counter_refs();
> +}
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -186,7 +186,7 @@ static void smp_callin(void)
>          */
>         set_cpu_sibling_map(raw_smp_processor_id());
>
> -       ap_init_freq_invariance();
> +       ap_init_aperfmperf();
>
>         /*
>          * Get our bogomips.
> @@ -1396,7 +1396,6 @@ void __init native_smp_prepare_cpus(unsi
>  {
>         smp_prepare_cpus_common();
>
> -       bp_init_freq_invariance();
>         smp_sanity_check();
>
>         switch (apic_intr_mode) {
>
