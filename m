Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F49446460B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 05:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346612AbhLAEpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 23:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhLAEpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 23:45:05 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228B0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:41:45 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 193so29538707qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 20:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/7Syam8Lg1GfDIu/F52hEII5Mhl6jEcJavLYqxecKY=;
        b=i2ScXTvdiWduK7dHq3qFLrT3aVLDLJE7eq2+RQ0gRD1BH4+IgvsGsr+yCXomoaiZ0X
         oCAhslyWpaYrv3IV8vDLFXxyNNUQa47iKymS2V+JJeu/zBUOMdFwPqmZrwIA0+j0VlTE
         S9sfbj8Q5kocqLtqFF68gSzWg98sdn13Pa/7TaySC+UBQsQhaDx580OS5JfaZDGk7K5K
         rbbLWaP4Uo8xfxs9anV9FZ+10uYFJgkXUCBBPQnzO7jkWqJeh4YlYHCYPSc5WI2htDD8
         57zhrSOl+OMqIBYhbHVMWwPdE0AWW14GIeU6lxDh7MTHrwpr2l+jdS95m6USawFSlnLB
         wDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/7Syam8Lg1GfDIu/F52hEII5Mhl6jEcJavLYqxecKY=;
        b=SDhTiyEk/pdIpPJGaITf6gMeG91DammOQR87fPY99kqFb9PGQ8t4mHc51uaGEitjUI
         rwvUmsA0X05pLBFEXu6juB+5LY7eIikudWEK5TfLcXn5YAxosrQ4SAUv1rQ1NGTg7Bvx
         AojgDp6a2wILnSkWVd7hF07cPHyR/p/k4hBM0iPlOB/XMNvszFyAFUZgiWiqfIj4MOw2
         ghZHOtLntU7eu3jIMgon9u8Bxf7EHBPTKOES5il0Rd8m+/3E0i5FBVNQyuSANb1JrrZx
         gSJJXmwnpdXZJk8IY7/YmBkCzu//EkdbHxGdone5ODBe8EDcz/ize1xOUQo++kXW6yPt
         MyAw==
X-Gm-Message-State: AOAM530XMwzIj+8yVurvXKloymYaOhfmufgWr+Qb/KLgftVDye7Utu7M
        nQEqYZAF4cUqhMhCvh99+EO1LYyAtczBvlwIZzSBq7au
X-Google-Smtp-Source: ABdhPJyA2raoKa6fEnfTMiGHSCyPx0CN2vblT04dZHV5+ZMur4Qx+mNKqwmqyXC/nHlMglgP4lFRazFN5WBgnwQHrL0=
X-Received: by 2002:a05:620a:21c2:: with SMTP id h2mr3823436qka.387.1638333704003;
 Tue, 30 Nov 2021 20:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20211117023751.24190-1-feng.tang@intel.com> <20211117023751.24190-2-feng.tang@intel.com>
In-Reply-To: <20211117023751.24190-2-feng.tang@intel.com>
From:   Luming Yu <luming.yu@gmail.com>
Date:   Tue, 30 Nov 2021 23:45:32 -0500
Message-ID: <CAJRGBZxdtRgENVonpfJn-zFoQx_LB0ms=aS3wAJhRJO+_OqYFw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/tsc: skip tsc watchdog checking for qualified platforms
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, paulmck@kernel.org,
        rui.zhang@intel.com, andi.kleen@intel.com,
        Len Brown <len.brown@intel.com>, tim.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 11:18 PM Feng Tang <feng.tang@intel.com> wrote:
>
> There are cases that tsc clocksources are wrongly judged as unstable by
> clocksource watchdogs like hpet, acpi_pm or 'refined-jiffies'. While
> there is hardly a general reliable way to check the validity of a
> watchdog, and to protect the innocent tsc, Thomas Gleixner proposed [1]:
>
> "I'm inclined to lift that requirement when the CPU has:
>
>     1) X86_FEATURE_CONSTANT_TSC
>     2) X86_FEATURE_NONSTOP_TSC
>     3) X86_FEATURE_NONSTOP_TSC_S3
>     4) X86_FEATURE_TSC_ADJUST
>     5) At max. 4 sockets
>

Hi Feng,

We do  need to decouple  tsc from HPET as the current HPET as a
clocksource watchdog for tsc
is only useful to find HPET read skews in some circumstances and the
variations of HPET read come from many different sources. But
none of which really came from the tsc quality, AFAICT.

so this patch is in line with my understanding of the problem.
So , please use  reviewed-by :  luming.yu@intel.com , if it can help
the merge of the patch. : -)

BR
Luming


>  After two decades of horrors we're finally at a point where TSC seems
>  to be halfway reliable and less abused by BIOS tinkerers. TSC_ADJUST
>  was really key as we can now detect even small modifications reliably
>  and the important point is that we can cure them as well (not pretty
>  but better than all other options)."
>
> As feature #3 X86_FEATURE_NONSTOP_TSC_S3 only exists on several generations
> of Atom processor, and is always coupled with X86_FEATURE_CONSTANT_TSC
> and X86_FEATURE_NONSTOP_TSC, skip checking it, and also be more defensive
> to use maxim of 2 sockets.
>
> The check is done inside tsc_init() before registering 'tsc-early' and
> 'tsc' clocksources, as there were cases that both of them had been
> wrongly judged as unreliable.
>
> For more background of tsc/watchdog, there is a good summary in [2]
>
> [1]. https://lore.kernel.org/lkml/87eekfk8bd.fsf@nanos.tec.linutronix.de/
> [2]. https://lore.kernel.org/lkml/87a6pimt1f.ffs@nanos.tec.linutronix.de/
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Change log:
>
>   v3:
>     * rebased against 5.16-rc1
>     * refine commit log
>
>   v2:
>     * Directly skip watchdog check without messing flag
>       'tsc_clocksource_reliable' (Thomas)
>
>  arch/x86/kernel/tsc.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 2e076a459a0c..389511f59101 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1180,6 +1180,12 @@ void mark_tsc_unstable(char *reason)
>
>  EXPORT_SYMBOL_GPL(mark_tsc_unstable);
>
> +static void __init tsc_skip_watchdog_verify(void)
> +{
> +       clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> +       clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> +}
> +
>  static void __init check_system_tsc_reliable(void)
>  {
>  #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
> @@ -1196,6 +1202,17 @@ static void __init check_system_tsc_reliable(void)
>  #endif
>         if (boot_cpu_has(X86_FEATURE_TSC_RELIABLE))
>                 tsc_clocksource_reliable = 1;
> +
> +       /*
> +        * Ideally the socket number should be checked, but this is called
> +        * by tsc_init() which is in early boot phase and the socket numbers
> +        * may not be available. Use 'nr_online_nodes' as a fallback solution
> +        */
> +       if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
> +           boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
> +           boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> +           nr_online_nodes <= 2)
> +               tsc_skip_watchdog_verify();
>  }
>
>  /*
> @@ -1387,9 +1404,6 @@ static int __init init_tsc_clocksource(void)
>         if (tsc_unstable)
>                 goto unreg;
>
> -       if (tsc_clocksource_reliable || no_tsc_watchdog)
> -               clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> -
>         if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
>                 clocksource_tsc.flags |= CLOCK_SOURCE_SUSPEND_NONSTOP;
>
> @@ -1527,7 +1541,7 @@ void __init tsc_init(void)
>         }
>
>         if (tsc_clocksource_reliable || no_tsc_watchdog)
> -               clocksource_tsc_early.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> +               tsc_skip_watchdog_verify();
>
>         clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
>         detect_art();
> --
> 2.27.0
>
