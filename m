Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6EB484481
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiADP1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:27:04 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:39426 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiADP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:27:03 -0500
Received: by mail-io1-f51.google.com with SMTP id y11so39334950iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 07:27:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/Vjd+dlEx1FNGNU6cs7r0P09qH5dIexKlHkpN9tmCM=;
        b=O3Jwk5gj5lpAEsv/EaAL/XFsGFf1TLdrTR8I6hWs8sl6rC3C3/++2B4u6+7NLRLrEF
         raddoDADfU84Wf+PnHRZP9toxLOSOobiTaul1fwK4BndqYhtJiRhSDuF7QzWXgy4OqIJ
         YaDWAUO+dzeJOO2CLcFAG6My/ZvEObkrVxGN5Y4RXVpz3yDlyEJh3v2dKOiVHI0aUY90
         DD1CGfP4Hin7fjeppIDR2yRLRp+GSBf6VXfPsPIad3HJBsfYFR9yNrsjImP62j+laxLm
         zMj8emSOFkIq+1+YPbOjG0rKivct4MHfxrKvnWaeLmI9eGZXInqX5Yyc2GK1zsMUZ1s9
         E7lg==
X-Gm-Message-State: AOAM530a2MY6s8/aGMAh0rJvP6aEeGVzHmU7UtfWEO8WwAeSdIfDyImM
        GpFHjZ48MVn66Zl6ZoYhxZM1oySpcgj2hzMl8U0U6Bpr
X-Google-Smtp-Source: ABdhPJwyFxwPnlj58YYHEJMLjzILE6WQaQF/x/PQoE5rCHHm+EhIDlWwl3EM+TCZTHzW3LXeGWAfRXTb12b3BwYbBgU=
X-Received: by 2002:ac8:5f4e:: with SMTP id y14mr43946996qta.305.1641310010379;
 Tue, 04 Jan 2022 07:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20211211163327.3093169-1-srinivas.pandruvada@linux.intel.com> <CAJZ5v0idd=Ey=pDyDgyBZz=SqrPvBkT1SvK30wbVy5myKAR1pg@mail.gmail.com>
In-Reply-To: <CAJZ5v0idd=Ey=pDyDgyBZz=SqrPvBkT1SvK30wbVy5myKAR1pg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jan 2022 16:26:39 +0100
Message-ID: <CAJZ5v0gn7Y_nLQnRHo_irHJk3e-L+pUtYXr26p2ULpVtZSivzw@mail.gmail.com>
Subject: Re: [PATCH] x86: intel_epb: Allow model specific normal EPB value
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 11:00 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Dec 11, 2021 at 5:33 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > The current EPB "normal" is defined as 6 and set whenever power-up EPB
> > value is 0. This setting resulted in the desired out of box power and
> > performance for several CPU generations. But this value is not suitable
> > for AlderLake mobile CPUs, as this resulted in higher uncore power.
> > Since EPB is model specific, this is not unreasonable to have different
> > behavior.
> >
> > Allow a capability where "normal" EPB can be redefined. For AlderLake
> > mobile CPUs this desired normal value is 7.
> >
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

And since there don't seem to be any concerns regarding this, I'm
going to apply it.

> > ---
> >  arch/x86/kernel/cpu/intel_epb.c | 45 +++++++++++++++++++++++----------
> >  1 file changed, 32 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
> > index f4dd73396f28..fbaf12e43f41 100644
> > --- a/arch/x86/kernel/cpu/intel_epb.c
> > +++ b/arch/x86/kernel/cpu/intel_epb.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/syscore_ops.h>
> >  #include <linux/pm.h>
> >
> > +#include <asm/cpu_device_id.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/msr.h>
> >
> > @@ -58,6 +59,22 @@ static DEFINE_PER_CPU(u8, saved_epb);
> >  #define EPB_SAVED      0x10ULL
> >  #define MAX_EPB                EPB_MASK
> >
> > +enum energy_perf_value_index {
> > +       EPB_INDEX_PERFORMANCE,
> > +       EPB_INDEX_BALANCE_PERFORMANCE,
> > +       EPB_INDEX_NORMAL,
> > +       EPB_INDEX_BALANCE_POWERSAVE,
> > +       EPB_INDEX_POWERSAVE,
> > +};
> > +
> > +static u8 energ_perf_values[] = {
> > +       [EPB_INDEX_PERFORMANCE] = ENERGY_PERF_BIAS_PERFORMANCE,
> > +       [EPB_INDEX_BALANCE_PERFORMANCE] = ENERGY_PERF_BIAS_BALANCE_PERFORMANCE,
> > +       [EPB_INDEX_NORMAL] = ENERGY_PERF_BIAS_NORMAL,
> > +       [EPB_INDEX_BALANCE_POWERSAVE] = ENERGY_PERF_BIAS_BALANCE_POWERSAVE,
> > +       [EPB_INDEX_POWERSAVE] = ENERGY_PERF_BIAS_POWERSAVE,
> > +};
> > +
> >  static int intel_epb_save(void)
> >  {
> >         u64 epb;
> > @@ -90,7 +107,7 @@ static void intel_epb_restore(void)
> >                  */
> >                 val = epb & EPB_MASK;
> >                 if (val == ENERGY_PERF_BIAS_PERFORMANCE) {
> > -                       val = ENERGY_PERF_BIAS_NORMAL;
> > +                       val = energ_perf_values[EPB_INDEX_NORMAL];
> >                         pr_warn_once("ENERGY_PERF_BIAS: Set to 'normal', was 'performance'\n");
> >                 }
> >         }
> > @@ -103,18 +120,11 @@ static struct syscore_ops intel_epb_syscore_ops = {
> >  };
> >
> >  static const char * const energy_perf_strings[] = {
> > -       "performance",
> > -       "balance-performance",
> > -       "normal",
> > -       "balance-power",
> > -       "power"
> > -};
> > -static const u8 energ_perf_values[] = {
> > -       ENERGY_PERF_BIAS_PERFORMANCE,
> > -       ENERGY_PERF_BIAS_BALANCE_PERFORMANCE,
> > -       ENERGY_PERF_BIAS_NORMAL,
> > -       ENERGY_PERF_BIAS_BALANCE_POWERSAVE,
> > -       ENERGY_PERF_BIAS_POWERSAVE
> > +       [EPB_INDEX_PERFORMANCE] = "performance",
> > +       [EPB_INDEX_BALANCE_PERFORMANCE] = "balance-performance",
> > +       [EPB_INDEX_NORMAL] = "normal",
> > +       [EPB_INDEX_BALANCE_POWERSAVE] = "balance-power",
> > +       [EPB_INDEX_POWERSAVE] = "power",
> >  };
> >
> >  static ssize_t energy_perf_bias_show(struct device *dev,
> > @@ -193,13 +203,22 @@ static int intel_epb_offline(unsigned int cpu)
> >         return 0;
> >  }
> >
> > +static const struct x86_cpu_id intel_epb_normal[] = {
> > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, 7),
> > +       {}
> > +};
> > +
> >  static __init int intel_epb_init(void)
> >  {
> > +       const struct x86_cpu_id *id = x86_match_cpu(intel_epb_normal);
> >         int ret;
> >
> >         if (!boot_cpu_has(X86_FEATURE_EPB))
> >                 return -ENODEV;
> >
> > +       if (id)
> > +               energ_perf_values[EPB_INDEX_NORMAL] = id->driver_data;
> > +
> >         ret = cpuhp_setup_state(CPUHP_AP_X86_INTEL_EPB_ONLINE,
> >                                 "x86/intel/epb:online", intel_epb_online,
> >                                 intel_epb_offline);
> > --
> > 2.31.1
> >
