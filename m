Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236C35072DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351971AbiDSQXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiDSQXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:23:08 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A019C35;
        Tue, 19 Apr 2022 09:20:26 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id f17so31915900ybj.10;
        Tue, 19 Apr 2022 09:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPxp0QI2/nvg9xCByE9gIxfF0d3G+NntnF3jQ+l2Pfc=;
        b=GbEhwVpPvWTuopsxPqXQfMBHuZt06KYgHCRUpVLjX2F5iJWihxTqWWPrdWsyMdEXtE
         l107kp3dHG/C8nFEZcpsUnbdsdLv08mul/5Y5TV5FMhOAmfGBsjhqzSY2P4xFU93MVPM
         S2F7blK8jG0guE/UJtjoMKVC6VNTTfKLg+vEqn3RLAr+UA9G2F64Hdl6Vlwu7qMFdeq5
         pCdpEXOFrpEAw55ID7O68SfO3Su7WS07lUi0ywNUk2txhVpVLMVShN+0OOf0zf97dyYN
         FpL8q9kAARfvRS6NjFcWguaV9iBfgX3PZFph0xrhwgpaVB7j0wDT51PFQ/mV1hBF6ehV
         p5jQ==
X-Gm-Message-State: AOAM5333SbKTlUG7b+J5ahl/BajvpSc+IkY1UobDkQa5eZBCadqLrK8E
        btGOUKUN6sj9wZL2riWUT4KynOF4+Gf4TaqF51tfX+6s
X-Google-Smtp-Source: ABdhPJwwjxvi6MkelW+kIqhBfD671mIGrXxCsHweWDrfM45Gfm/hjPC13hhov6Lj835jBHs5R7MtItbtZCN9qD50WuI=
X-Received: by 2002:a25:ac9b:0:b0:641:3c32:bee7 with SMTP id
 x27-20020a25ac9b000000b006413c32bee7mr14618920ybi.633.1650385225389; Tue, 19
 Apr 2022 09:20:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220415133356.179706384@linutronix.de> <20220415161206.706185092@linutronix.de>
In-Reply-To: <20220415161206.706185092@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Apr 2022 18:20:14 +0200
Message-ID: <CAJZ5v0hWoY9r-8nyo82tVg1hOdEqCditBaGuWtFonkQUZVTXMw@mail.gmail.com>
Subject: Re: [patch 06/10] x86/aperfmperf: Restructure arch_scale_freq_tick()
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
> Preparation for sharing code with the CPU frequency portion of the
> aperf/mperf code.
>
> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

All good AFAICS:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/cpu/aperfmperf.c |   36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -477,22 +477,9 @@ static DECLARE_WORK(disable_freq_invaria
>
>  DEFINE_PER_CPU(unsigned long, arch_freq_scale) = SCHED_CAPACITY_SCALE;
>
> -void arch_scale_freq_tick(void)
> +static void scale_freq_tick(u64 acnt, u64 mcnt)
>  {
> -       struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
> -       u64 aperf, mperf, acnt, mcnt, freq_scale;
> -
> -       if (!arch_scale_freq_invariant())
> -               return;
> -
> -       rdmsrl(MSR_IA32_APERF, aperf);
> -       rdmsrl(MSR_IA32_MPERF, mperf);
> -
> -       acnt = aperf - s->aperf;
> -       mcnt = mperf - s->mperf;
> -
> -       s->aperf = aperf;
> -       s->mperf = mperf;
> +       u64 freq_scale;
>
>         if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
>                 goto error;
> @@ -514,4 +501,23 @@ void arch_scale_freq_tick(void)
>         pr_warn("Scheduler frequency invariance went wobbly, disabling!\n");
>         schedule_work(&disable_freq_invariance_work);
>  }
> +
> +void arch_scale_freq_tick(void)
> +{
> +       struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
> +       u64 acnt, mcnt, aperf, mperf;
> +
> +       if (!arch_scale_freq_invariant())
> +               return;
> +
> +       rdmsrl(MSR_IA32_APERF, aperf);
> +       rdmsrl(MSR_IA32_MPERF, mperf);
> +       acnt = aperf - s->aperf;
> +       mcnt = mperf - s->mperf;
> +
> +       s->aperf = aperf;
> +       s->mperf = mperf;
> +
> +       scale_freq_tick(acnt, mcnt);
> +}
>  #endif /* CONFIG_X86_64 && CONFIG_SMP */
>
