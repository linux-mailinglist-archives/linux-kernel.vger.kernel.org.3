Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA7B478D00
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhLQODl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 09:03:41 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42794 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLQODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:03:40 -0500
Received: by mail-ot1-f43.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so2948399otv.9;
        Fri, 17 Dec 2021 06:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sGpYh9XkXgt39wJg2erukuW3A/kDQ5iVY4QD4nNriNo=;
        b=Nar117Q41QzvkYArEjHqRUmhrTHBfjMmxxqro3lfe9dhdF6pR3TNqeO2BcR7Ufit/h
         thn+T1AkS8JwhXaBqkvDvMJG2UhjWtgxGSOD0n7XzUedyxsExbs1RLdtghYB57oI4gD8
         Bm+vN78QhNsL4+UACTDtIpKv9QZz1S4Hxyy4DfBfrNxqGfECkNvgXHAPdqpzAzIAIjUy
         kXKtnMr2Z/U97rMyO6NccU6/lVtHfsY0FnXSFollk4mK+bchzJcC88GmTPJeP/A1XiFl
         J4LVc3cs3lRlKmzOhc0MGp466ieYCU1Zb+msa51x/GWSIweFef8xhBrzztdj04fS3yZ3
         7n8g==
X-Gm-Message-State: AOAM530D2SZnAkQ9pn+XHacEJi8LSMGb9hHroX2QGJ5MJIUJNwqt3iQg
        zHhUky8JoYyoBlYboGKJgbr6DapnRpHqTMHciYY=
X-Google-Smtp-Source: ABdhPJzzFulrFnsQr+Wjo30BzG9wpkuUv9b7x3qLRZuZujywR8+3QDzFM8Jg2D+mte5ct5TYF2uWgiCJPz9TLQRkgtw=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr2293986otu.254.1639749819316;
 Fri, 17 Dec 2021 06:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20211130123641.1449041-1-ray.huang@amd.com> <20211130123641.1449041-7-ray.huang@amd.com>
 <CAJZ5v0gxVTJ8KffVpcLUZ=KPVRwinV6Wdq+-s3RO_cv6bevxXQ@mail.gmail.com> <Ybw9nqrrrumSWpli@amd.com>
In-Reply-To: <Ybw9nqrrrumSWpli@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 15:03:27 +0100
Message-ID: <CAJZ5v0hHNfaxGbP2zrU=NOiAcLdEL9mBezJOFF3a6G8AYbjgMw@mail.gmail.com>
Subject: Re: [PATCH v5 06/22] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 8:35 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Fri, Dec 17, 2021 at 01:59:35AM +0800, Rafael J. Wysocki wrote:
> > On Tue, Nov 30, 2021 at 1:37 PM Huang Rui <ray.huang@amd.com> wrote:
> > >
> > > amd-pstate is the AMD CPU performance scaling driver that introduces a
> > > new CPU frequency control mechanism on AMD Zen based CPU series in Linux
> > > kernel. The new mechanism is based on Collaborative processor
> > > performance control (CPPC) which is finer grain frequency management
> > > than legacy ACPI hardware P-States. Current AMD CPU platforms are using
> > > the ACPI P-states driver to manage CPU frequency and clocks with
> > > switching only in 3 P-states. AMD P-States is to replace the ACPI
> > > P-states controls, allows a flexible, low-latency interface for the
> > > Linux kernel to directly communicate the performance hints to hardware.
> > >
> > > "amd-pstate" leverages the Linux kernel governors such as *schedutil*,
> > > *ondemand*, etc. to manage the performance hints which are provided by CPPC
> > > hardware functionality. The first version for amd-pstate is to support one
> > > of the Zen3 processors, and we will support more in future after we verify
> > > the hardware and SBIOS functionalities.
> > >
> > > There are two types of hardware implementations for amd-pstate: one is full
> > > MSR support and another is shared memory support. It can use
> > > X86_FEATURE_CPPC feature flag to distinguish the different types.
> > >
> > > Using the new AMD P-States method + kernel governors (*schedutil*,
> > > *ondemand*, ...) to manage the frequency update is the most appropriate
> > > bridge between AMD Zen based hardware processor and Linux kernel, the
> > > processor is able to adjust to the most efficiency frequency according to
> > > the kernel scheduler loading.
> > >
> > > Please check the detailed CPU feature and MSR register description in
> > > Processor Programming Reference (PPR) for AMD Family 19h Model 51h,
> > > Revision A1 Processors:
> > >
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F56569-A1-PUB.zip&amp;data=04%7C01%7Cray.huang%40amd.com%7C271b150291c64c7e3db808d9c0bdd9b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637752744522397473%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=VlOP2McSZlC11NJSJoVB74alfUqpdyDmoaAgT8Vl2Qc%3D&amp;reserved=0
> > >
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > ---
> > >  drivers/cpufreq/Kconfig.x86  |  17 ++
> > >  drivers/cpufreq/Makefile     |   1 +
> > >  drivers/cpufreq/amd-pstate.c | 398 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 416 insertions(+)
> > >  create mode 100644 drivers/cpufreq/amd-pstate.c
> > >
> > > diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> > > index 92701a18bdd9..21837eb1698b 100644
> > > --- a/drivers/cpufreq/Kconfig.x86
> > > +++ b/drivers/cpufreq/Kconfig.x86
> > > @@ -34,6 +34,23 @@ config X86_PCC_CPUFREQ
> > >
> > >           If in doubt, say N.
> > >
> > > +config X86_AMD_PSTATE
> > > +       tristate "AMD Processor P-State driver"
> > > +       depends on X86
> > > +       select ACPI_PROCESSOR if ACPI
> > > +       select ACPI_CPPC_LIB if X86_64 && ACPI
> > > +       select CPU_FREQ_GOV_SCHEDUTIL if SMP
> > > +       help
> > > +         This driver adds a CPUFreq driver which utilizes a fine grain
> > > +         processor performance frequency control range instead of legacy
> > > +         performance levels. This driver supports the AMD processors with
> > > +         _CPC object in the SBIOS.
> >
> > Well, _CPC needs to be present in the ACPI tables of the system.
>
> Yes, will modify the words.
>
> >
> > > +
> > > +         For details, take a look at:
> > > +         <file:Documentation/admin-guide/pm/amd-pstate.rst>.
> > > +
> > > +         If in doubt, say N.
> > > +
> > >  config X86_ACPI_CPUFREQ
> > >         tristate "ACPI Processor P-States driver"
> > >         depends on ACPI_PROCESSOR
> > > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > > index 48ee5859030c..c8d307010922 100644
> > > --- a/drivers/cpufreq/Makefile
> > > +++ b/drivers/cpufreq/Makefile
> > > @@ -25,6 +25,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)      += cpufreq-dt-platdev.o
> > >  # speedstep-* is preferred over p4-clockmod.
> > >
> > >  obj-$(CONFIG_X86_ACPI_CPUFREQ)         += acpi-cpufreq.o
> > > +obj-$(CONFIG_X86_AMD_PSTATE)           += amd-pstate.o
> > >  obj-$(CONFIG_X86_POWERNOW_K8)          += powernow-k8.o
> > >  obj-$(CONFIG_X86_PCC_CPUFREQ)          += pcc-cpufreq.o
> > >  obj-$(CONFIG_X86_POWERNOW_K6)          += powernow-k6.o
> > > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > > new file mode 100644
> > > index 000000000000..20ffbc30118f
> > > --- /dev/null
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -0,0 +1,398 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * amd-pstate.c - AMD Processor P-state Frequency Driver
> > > + *
> > > + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
> > > + *
> > > + * Author: Huang Rui <ray.huang@amd.com>
> >
> > Given the lack of other documentation, it would be nice to provide at
> > least a brief description of the driver here.
>
> Fine, will add the description in V6.
>
> >
> > > + */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/init.h>
> > > +#include <linux/smp.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/cpufreq.h>
> > > +#include <linux/compiler.h>
> > > +#include <linux/dmi.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/acpi.h>
> > > +#include <linux/io.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/uaccess.h>
> > > +#include <linux/static_call.h>
> > > +
> > > +#include <acpi/processor.h>
> > > +#include <acpi/cppc_acpi.h>
> > > +
> > > +#include <asm/msr.h>
> > > +#include <asm/processor.h>
> > > +#include <asm/cpufeature.h>
> > > +#include <asm/cpu_device_id.h>
> > > +
> > > +#define AMD_PSTATE_TRANSITION_LATENCY  0x20000
> > > +#define AMD_PSTATE_TRANSITION_DELAY    500
> > > +
> > > +static struct cpufreq_driver amd_pstate_driver;
> > > +
> > > +struct amd_cpudata {
> > > +       int     cpu;
> > > +
> > > +       struct freq_qos_request req[2];
> > > +
> > > +       u64     cppc_req_cached;
> > > +
> > > +       u32     highest_perf;
> > > +       u32     nominal_perf;
> > > +       u32     lowest_nonlinear_perf;
> > > +       u32     lowest_perf;
> > > +
> > > +       u32     max_freq;
> > > +       u32     min_freq;
> > > +       u32     nominal_freq;
> > > +       u32     lowest_nonlinear_freq;
> > > +};
> >
> > Please describe the fields of this structure, preferably in a kerneldoc comment.
>
> OK.
>
> >
> > > +
> > > +static inline int pstate_enable(bool enable)
> > > +{
> > > +       return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
> > > +}
> > > +
> > > +DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
> >
> > Why do you need a static call here?
> >
> > It doesn't get updated anywhere below.
>
> Ah, the update behavior is defined in the following patch 8 (shared memory
> support). Sorry to make you confused.
>
> >
> > > +
> > > +static inline int amd_pstate_enable(bool enable)
> > > +{
> > > +       return static_call(amd_pstate_enable)(enable);
> > > +}
> > > +
> > > +static int pstate_init_perf(struct amd_cpudata *cpudata)
> > > +{
> > > +       u64 cap1;
> > > +
> > > +       int ret = rdmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> > > +                                    &cap1);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       /*
> > > +        * TODO: Introduce AMD specific power feature.
> > > +        *
> > > +        * CPPC entry doesn't indicate the highest performance in some ASICs.
> > > +        */
> > > +       WRITE_ONCE(cpudata->highest_perf, amd_get_highest_perf());
> > > +
> > > +       WRITE_ONCE(cpudata->nominal_perf, CAP1_NOMINAL_PERF(cap1));
> > > +       WRITE_ONCE(cpudata->lowest_nonlinear_perf, CAP1_LOWNONLIN_PERF(cap1));
> > > +       WRITE_ONCE(cpudata->lowest_perf, CAP1_LOWEST_PERF(cap1));
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
> >
> > And same here.
> >
> > > +
> > > +static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
> > > +{
> > > +       return static_call(amd_pstate_init_perf)(cpudata);
> > > +}
> > > +
> > > +static void pstate_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
> > > +                              u32 des_perf, u32 max_perf, bool fast_switch)
> > > +{
> > > +       if (fast_switch)
> > > +               wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> > > +       else
> > > +               wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> > > +                             READ_ONCE(cpudata->cppc_req_cached));
> > > +}
> > > +
> > > +DEFINE_STATIC_CALL(amd_pstate_update_perf, pstate_update_perf);
> >
> > Same here.
> >
> > > +
> > > +static inline void amd_pstate_update_perf(struct amd_cpudata *cpudata,
> > > +                                         u32 min_perf, u32 des_perf,
> > > +                                         u32 max_perf, bool fast_switch)
> > > +{
> > > +       static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
> > > +                                           max_perf, fast_switch);
> > > +}
> > > +
> > > +static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
> > > +                             u32 des_perf, u32 max_perf, bool fast_switch)
> > > +{
> > > +       u64 prev = READ_ONCE(cpudata->cppc_req_cached);
> > > +       u64 value = prev;
> > > +
> > > +       value &= ~REQ_MIN_PERF(~0L);
> > > +       value |= REQ_MIN_PERF(min_perf);
> > > +
> > > +       value &= ~REQ_DES_PERF(~0L);
> > > +       value |= REQ_DES_PERF(des_perf);
> > > +
> > > +       value &= ~REQ_MAX_PERF(~0L);
> > > +       value |= REQ_MAX_PERF(max_perf);
> > > +
> > > +       if (value == prev)
> > > +               return;
> > > +
> > > +       WRITE_ONCE(cpudata->cppc_req_cached, value);
> > > +
> > > +       amd_pstate_update_perf(cpudata, min_perf, des_perf,
> > > +                              max_perf, fast_switch);
> > > +}
> > > +
> > > +static int amd_pstate_verify(struct cpufreq_policy_data *policy)
> > > +{
> > > +       cpufreq_verify_within_cpu_limits(policy);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int amd_pstate_target(struct cpufreq_policy *policy,
> > > +                            unsigned int target_freq,
> > > +                            unsigned int relation)
> > > +{
> > > +       struct cpufreq_freqs freqs;
> > > +       struct amd_cpudata *cpudata = policy->driver_data;
> > > +       unsigned long max_perf, min_perf, des_perf, cap_perf;
> > > +
> > > +       if (!cpudata->max_freq)
> > > +               return -ENODEV;
> > > +
> > > +       cap_perf = READ_ONCE(cpudata->highest_perf);
> > > +       min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> > > +       max_perf = cap_perf;
> > > +
> > > +       freqs.old = policy->cur;
> > > +       freqs.new = target_freq;
> > > +
> > > +       des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
> > > +                                    cpudata->max_freq);
> > > +
> > > +       cpufreq_freq_transition_begin(policy, &freqs);
> > > +       amd_pstate_update(cpudata, min_perf, des_perf,
> > > +                         max_perf, false);
> > > +       cpufreq_freq_transition_end(policy, &freqs, false);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int amd_get_min_freq(struct amd_cpudata *cpudata)
> > > +{
> > > +       struct cppc_perf_caps cppc_perf;
> > > +
> > > +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       /* Switch to khz */
> > > +       return cppc_perf.lowest_freq * 1000;
> > > +}
> > > +
> > > +static int amd_get_max_freq(struct amd_cpudata *cpudata)
> > > +{
> > > +       struct cppc_perf_caps cppc_perf;
> > > +       u32 max_perf, max_freq, nominal_freq, nominal_perf;
> > > +       u64 boost_ratio;
> > > +
> > > +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       nominal_freq = cppc_perf.nominal_freq;
> > > +       nominal_perf = READ_ONCE(cpudata->nominal_perf);
> > > +       max_perf = READ_ONCE(cpudata->highest_perf);
> > > +
> > > +       boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
> > > +                             nominal_perf);
> > > +
> > > +       max_freq = nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT;
> > > +
> > > +       /* Switch to khz */
> > > +       return max_freq * 1000;
> > > +}
> > > +
> > > +static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
> > > +{
> > > +       struct cppc_perf_caps cppc_perf;
> > > +
> > > +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       /* Switch to khz */
> > > +       return cppc_perf.nominal_freq * 1000;
> > > +}
> > > +
> > > +static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> > > +{
> > > +       struct cppc_perf_caps cppc_perf;
> > > +       u32 lowest_nonlinear_freq, lowest_nonlinear_perf,
> > > +           nominal_freq, nominal_perf;
> > > +       u64 lowest_nonlinear_ratio;
> > > +
> > > +       int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       nominal_freq = cppc_perf.nominal_freq;
> > > +       nominal_perf = READ_ONCE(cpudata->nominal_perf);
> > > +
> > > +       lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
> > > +
> > > +       lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
> > > +                                        nominal_perf);
> > > +
> > > +       lowest_nonlinear_freq = nominal_freq * lowest_nonlinear_ratio >> SCHED_CAPACITY_SHIFT;
> > > +
> > > +       /* Switch to khz */
> > > +       return lowest_nonlinear_freq * 1000;
> > > +}
> > > +
> > > +static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
> > > +{
> > > +       int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> > > +       struct device *dev;
> > > +       struct amd_cpudata *cpudata;
> > > +
> > > +       dev = get_cpu_device(policy->cpu);
> > > +       if (!dev)
> > > +               return -ENODEV;
> > > +
> > > +       cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
> > > +       if (!cpudata)
> > > +               return -ENOMEM;
> > > +
> > > +       cpudata->cpu = policy->cpu;
> > > +
> > > +       ret = amd_pstate_init_perf(cpudata);
> > > +       if (ret)
> > > +               goto free_cpudata1;
> > > +
> > > +       min_freq = amd_get_min_freq(cpudata);
> > > +       max_freq = amd_get_max_freq(cpudata);
> > > +       nominal_freq = amd_get_nominal_freq(cpudata);
> > > +       lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
> > > +
> > > +       if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> > > +               dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
> > > +                       min_freq, max_freq);
> > > +               ret = -EINVAL;
> > > +               goto free_cpudata1;
> > > +       }
> > > +
> > > +       policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
> > > +       policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
> > > +
> > > +       policy->min = min_freq;
> > > +       policy->max = max_freq;
> > > +
> > > +       policy->cpuinfo.min_freq = min_freq;
> > > +       policy->cpuinfo.max_freq = max_freq;
> > > +
> > > +       /* It will be updated by governor */
> > > +       policy->cur = policy->cpuinfo.min_freq;
> >
> > The freq_qos requests below are never updated in this file.  What are they for?
>
> The freq_qos requests will be updated while we set boost disabled or
> enabled in patch 10. Sorry to make you confused again. Should I move the
> freq_qos requests implementation into patch 10 as well?

Yes, please.
