Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8866150727F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354250AbiDSQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244370AbiDSQG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:06:59 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CBE344FF;
        Tue, 19 Apr 2022 09:04:16 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id j2so31958364ybu.0;
        Tue, 19 Apr 2022 09:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gELaQOf9Rj6C8VNSNQ3uNKSPk0ySJbTinIMoZcK7lh4=;
        b=Ih44qOtKjwoUqThTCkb0+nJOa7pIQ7D1itRAo047QkPoZJq7WJBZY/IGMQalPzWPuI
         RIe0sOUdV3L6Md5DA1LbktvulzV9/4zVnJidUkqhhU1u3koApXez160rh5RV1go0XWbY
         4cE7Zi+Bu8cK8D63lwWP8EdaNlXuEMCB0mmqRQBeH8ge6+7/m6nR8vyL0F/c092ZmnGC
         WqBXmNqmoL7WWzOZaPUYa2hdV36rTC540I/KLkvqZllcJEjLiWyjzRCLjCLQ0TIFEiLD
         nPA6rhjPbpBNxPICUdntmu3aV4d4RLhL+noyXOrWZNxxx4+dlmR6m/TnHVd/Gs8AS7ZW
         rpXg==
X-Gm-Message-State: AOAM531+2FXdPJBF6bUxJcVNXNNwW76bfVbRsHBnQXdUYORRivjTfoMp
        vvlSAICZ7YUJDpMw49WCOJzyKU0UXwgJw8aM857Wjvd1t7U=
X-Google-Smtp-Source: ABdhPJySdZu7kJ80ddxqUSt6NhXZwCC1tFB5mB2i3+wMcDWa0g0Nk7Pb1wIM/KMByphQnRkIzRZ+2uzUnTOqWFaVIOs=
X-Received: by 2002:a25:230d:0:b0:641:375c:b5ad with SMTP id
 j13-20020a25230d000000b00641375cb5admr15404846ybj.137.1650384255763; Tue, 19
 Apr 2022 09:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.536733494@linutronix.de>
In-Reply-To: <20220415161206.536733494@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 18:04:04 +0200
Message-ID: <CAJZ5v0h07hXW3WuBq673yk1HOuQLSw7-hJTntX331FDZRh1tDA@mail.gmail.com>
Subject: Re: [patch 03/10] x86/aperfmperf: Separate AP/BP frequency invariance init
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
> This code is convoluted and because it can be invoked post init via the
> ACPI/CPPC code, all of the initialization functionality is built in instead
> of being part of init text and init data.
>
> As a first step create separate calls for the boot and the application
> processors.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/topology.h  |   12 +++++-------
>  arch/x86/kernel/acpi/cppc.c      |    3 ++-
>  arch/x86/kernel/cpu/aperfmperf.c |   23 +++++++++++------------
>  arch/x86/kernel/smpboot.c        |    4 ++--
>  4 files changed, 20 insertions(+), 22 deletions(-)
>
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -216,14 +216,12 @@ extern void arch_scale_freq_tick(void);
>  #define arch_scale_freq_tick arch_scale_freq_tick
>
>  extern void arch_set_max_freq_ratio(bool turbo_disabled);
> -void init_freq_invariance(bool secondary, bool cppc_ready);
> +extern void bp_init_freq_invariance(bool cppc_ready);
> +extern void ap_init_freq_invariance(void);
>  #else
> -static inline void arch_set_max_freq_ratio(bool turbo_disabled)
> -{
> -}
> -static inline void init_freq_invariance(bool secondary, bool cppc_ready)
> -{
> -}
> +static inline void arch_set_max_freq_ratio(bool turbo_disabled) { }
> +static inline void bp_init_freq_invariance(bool cppc_ready) { }
> +static inline void ap_init_freq_invariance(void) { }
>  #endif
>
>  #ifdef CONFIG_ACPI_CPPC_LIB
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -96,7 +96,8 @@ void init_freq_invariance_cppc(void)
>
>         mutex_lock(&freq_invariance_lock);
>
> -       init_freq_invariance(secondary, true);
> +       if (!secondary)
> +               bp_init_freq_invariance(true);
>         secondary = true;
>
>         mutex_unlock(&freq_invariance_lock);
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -428,31 +428,24 @@ static void register_freq_invariance_sys
>  static inline void register_freq_invariance_syscore_ops(void) {}
>  #endif
>
> -void init_freq_invariance(bool secondary, bool cppc_ready)
> +void bp_init_freq_invariance(bool cppc_ready)
>  {
> -       bool ret = false;
> +       bool ret;
>
> -       if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> +       if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
>                 return;
>
> -       if (secondary) {
> -               if (static_branch_likely(&arch_scale_freq_key)) {
> -                       init_counter_refs();
> -               }
> -               return;
> -       }
> +       init_counter_refs();
>
>         if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>                 ret = intel_set_max_freq_ratio();
>         else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
> -               if (!cppc_ready) {
> +               if (!cppc_ready)
>                         return;
> -               }
>                 ret = amd_set_max_freq_ratio(&arch_turbo_freq_ratio);
>         }
>
>         if (ret) {
> -               init_counter_refs();
>                 static_branch_enable(&arch_scale_freq_key);
>                 register_freq_invariance_syscore_ops();
>                 pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
> @@ -461,6 +454,12 @@ void init_freq_invariance(bool secondary
>         }
>  }
>
> +void ap_init_freq_invariance(void)
> +{
> +       if (cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> +               init_counter_refs();

This doesn't check arch_scale_freq_key now which may be a good thing
to mention in the changelog.

I don't see anything questionable in the patch, though, so

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> +}
> +
>  static void disable_freq_invariance_workfn(struct work_struct *work)
>  {
>         static_branch_disable(&arch_scale_freq_key);
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -186,7 +186,7 @@ static void smp_callin(void)
>          */
>         set_cpu_sibling_map(raw_smp_processor_id());
>
> -       init_freq_invariance(true, false);
> +       ap_init_freq_invariance();
>
>         /*
>          * Get our bogomips.
> @@ -1396,7 +1396,7 @@ void __init native_smp_prepare_cpus(unsi
>  {
>         smp_prepare_cpus_common();
>
> -       init_freq_invariance(false, false);
> +       bp_init_freq_invariance(false);
>         smp_sanity_check();
>
>         switch (apic_intr_mode) {
>
