Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60C9477B53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbhLPSMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:12:53 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:40849 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhLPSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:12:53 -0500
Received: by mail-oi1-f174.google.com with SMTP id bk14so66796oib.7;
        Thu, 16 Dec 2021 10:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sPiK4/tw8IBy6ftIgt1sfKsE1K72eQlpcI2GW5L144=;
        b=S14pqAsWhEFnBY5W/ihS6Bx5nzgN0GtFvtG7FXWekDg+/BsIqXRJG/0yPtVvySY2zg
         ToV67uCdDRRAsM24qoP1Ggf+IJKtLroADfUz2Ug+LY53ZvkOk1hA13Ec0KOstJKJSyST
         EkrUTKn+oMt9Zcvne6Vu7ayVw/komoAGRT0xPKRBVjsp4c6zl8NpiyPBY51xnXDZ4HAj
         vWl4XVExiBLPzRz2VkLDc7Sw7vwkjHy0wZ/okdkGd5V3NXkh7Y3/4q8q31t3IkL8u3VJ
         ZaOr/bh2fY6SPGVazKhd8gu21z6LllmJNEHT0iqwXONavwKDekKpXB2q73f8lIGb+N1y
         vVLQ==
X-Gm-Message-State: AOAM531ZjxBUgKJyrMB25JTu4hfUazfq2GYo+RzSp6AivYkWOPdysC74
        Onxoho7I1d5jDZ6f3DnBd7FAtKKWbRAblvRyJzs=
X-Google-Smtp-Source: ABdhPJw7ZQUkI1L627EAjZhTxtc3GYk1tc0+6oFtEiAvyMeaegQLO8rFdqGCu1uIG8s5/piyV9AexYRnq/W3CiEE+io=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr5052939oiw.154.1639678372374;
 Thu, 16 Dec 2021 10:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20211130123641.1449041-1-ray.huang@amd.com> <20211130123641.1449041-10-ray.huang@amd.com>
In-Reply-To: <20211130123641.1449041-10-ray.huang@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Dec 2021 19:12:41 +0100
Message-ID: <CAJZ5v0jbSC1Q1gn2+Hu6bJQN20uDDSbStdM3zHZ+UBR+YKsWQA@mail.gmail.com>
Subject: Re: [PATCH v5 09/22] cpufreq: amd: add trace for amd-pstate module
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmins.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 1:38 PM Huang Rui <ray.huang@amd.com> wrote:
>
> Add trace event to monitor the performance value changes which is
> controlled by cpu governors.

This would need an ACK from Steve.

>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/cpufreq/Makefile           |  6 ++-
>  drivers/cpufreq/amd-pstate-trace.c |  2 +
>  drivers/cpufreq/amd-pstate-trace.h | 77 ++++++++++++++++++++++++++++++

Why are these two extra files necessary?

>  drivers/cpufreq/amd-pstate.c       |  4 ++
>  4 files changed, 88 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/cpufreq/amd-pstate-trace.c
>  create mode 100644 drivers/cpufreq/amd-pstate-trace.h
>
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index c8d307010922..285de70af877 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -17,6 +17,10 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)  += cpufreq_governor_attr_set.o
>  obj-$(CONFIG_CPUFREQ_DT)               += cpufreq-dt.o
>  obj-$(CONFIG_CPUFREQ_DT_PLATDEV)       += cpufreq-dt-platdev.o
>
> +# Traces
> +CFLAGS_amd-pstate-trace.o               := -I$(src)
> +amd_pstate-y                           := amd-pstate.o amd-pstate-trace.o
> +
>  ##################################################################################
>  # x86 drivers.
>  # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
> @@ -25,7 +29,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)      += cpufreq-dt-platdev.o
>  # speedstep-* is preferred over p4-clockmod.
>
>  obj-$(CONFIG_X86_ACPI_CPUFREQ)         += acpi-cpufreq.o
> -obj-$(CONFIG_X86_AMD_PSTATE)           += amd-pstate.o
> +obj-$(CONFIG_X86_AMD_PSTATE)           += amd_pstate.o
>  obj-$(CONFIG_X86_POWERNOW_K8)          += powernow-k8.o
>  obj-$(CONFIG_X86_PCC_CPUFREQ)          += pcc-cpufreq.o
>  obj-$(CONFIG_X86_POWERNOW_K6)          += powernow-k6.o
> diff --git a/drivers/cpufreq/amd-pstate-trace.c b/drivers/cpufreq/amd-pstate-trace.c
> new file mode 100644
> index 000000000000..891b696dcd69
> --- /dev/null
> +++ b/drivers/cpufreq/amd-pstate-trace.c
> @@ -0,0 +1,2 @@
> +#define CREATE_TRACE_POINTS
> +#include "amd-pstate-trace.h"
> diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> new file mode 100644
> index 000000000000..647505957d4f
> --- /dev/null
> +++ b/drivers/cpufreq/amd-pstate-trace.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * amd-pstate-trace.h - AMD Processor P-state Frequency Driver Tracer
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Author: Huang Rui <ray.huang@amd.com>
> + */
> +
> +#if !defined(_AMD_PSTATE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _AMD_PSTATE_TRACE_H
> +
> +#include <linux/cpufreq.h>
> +#include <linux/tracepoint.h>
> +#include <linux/trace_events.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM amd_cpu
> +
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE amd-pstate-trace
> +
> +#define TPS(x)  tracepoint_string(x)
> +
> +TRACE_EVENT(amd_pstate_perf,

Could this be added to include/trace/events/power.h ?

> +
> +       TP_PROTO(unsigned long min_perf,
> +                unsigned long target_perf,
> +                unsigned long capacity,
> +                unsigned int cpu_id,
> +                bool changed,
> +                bool fast_switch
> +                ),
> +
> +       TP_ARGS(min_perf,
> +               target_perf,
> +               capacity,
> +               cpu_id,
> +               changed,
> +               fast_switch
> +               ),
> +
> +       TP_STRUCT__entry(
> +               __field(unsigned long, min_perf)
> +               __field(unsigned long, target_perf)
> +               __field(unsigned long, capacity)
> +               __field(unsigned int, cpu_id)
> +               __field(bool, changed)
> +               __field(bool, fast_switch)
> +               ),
> +
> +       TP_fast_assign(
> +               __entry->min_perf = min_perf;
> +               __entry->target_perf = target_perf;
> +               __entry->capacity = capacity;
> +               __entry->cpu_id = cpu_id;
> +               __entry->changed = changed;
> +               __entry->fast_switch = fast_switch;
> +               ),
> +
> +       TP_printk("amd_min_perf=%lu amd_des_perf=%lu amd_max_perf=%lu cpu_id=%u changed=%s fast_switch=%s",
> +                 (unsigned long)__entry->min_perf,
> +                 (unsigned long)__entry->target_perf,
> +                 (unsigned long)__entry->capacity,
> +                 (unsigned int)__entry->cpu_id,
> +                 (__entry->changed) ? "true" : "false",
> +                 (__entry->fast_switch) ? "true" : "false"
> +                )
> +);
> +
> +#endif /* _AMD_PSTATE_TRACE_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +
> +#include <trace/define_trace.h>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 68991c450fd5..72a4e2258fe7 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -31,6 +31,7 @@
>  #include <asm/processor.h>
>  #include <asm/cpufeature.h>
>  #include <asm/cpu_device_id.h>
> +#include "amd-pstate-trace.h"
>
>  #define AMD_PSTATE_TRANSITION_LATENCY  0x20000
>  #define AMD_PSTATE_TRANSITION_DELAY    500
> @@ -189,6 +190,9 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>         value &= ~REQ_MAX_PERF(~0L);
>         value |= REQ_MAX_PERF(max_perf);
>
> +       trace_amd_pstate_perf(min_perf, des_perf, max_perf,
> +                             cpudata->cpu, (value != prev), fast_switch);
> +
>         if (value == prev)
>                 return;
>
> --
> 2.25.1
>
