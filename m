Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD06F478D03
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhLQOFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:05:43 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41706 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLQOFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:05:42 -0500
Received: by mail-ot1-f54.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so2960551otl.8;
        Fri, 17 Dec 2021 06:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g03RicGR9jCGgYu9rbOy1z4bhFkncsLW5/9WH5otin0=;
        b=2eRP517p2g/PP87LfQqdBzjdbYgEzvFgiOeFgRBSo6s+sUCF9n7SjKJO2Wt2A+4lm/
         Yr9OIfU44fJrOdeAzlmKtVRTXPsHx7gWTv5OYBlwnm5QIAXi2dKQh1NMc0gDeKVYfu7U
         Ic8sXTsX8GaTg4tlgsLGPjyQEzAcJBM+G3i+RTodPoMzYhAaE2367T9OfghI4MTiVjmT
         8jWwTlK6OUg+PQSxJJ0iWSKTFtZQs4FfmufFG6qxgLjajDkfzCXRNNCtZ9/NTeYWnPt7
         BPvM703SFq18jWSMhMUeHkVBaJlqg7dlGJ6WP0n7Cf61xQ0z5ZMD1otlagvaarTgW29R
         11Rw==
X-Gm-Message-State: AOAM530fD2QL0mrPF9/1Je+rUuh9Dtn1JyRiOqOuJu2cAJIfG/1s1U+B
        W2Vjcz6FsAg58WqgJLTEj5rwMGU5h038i8u1nR0=
X-Google-Smtp-Source: ABdhPJy/IphBLzZjsm4EXAGdbviICYzuhwIIecSgbras0W7fXy8zUbym4G24uZFUv9hMAT1aJFlGLXLsBT0coB58DYU=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr2231331otj.16.1639749941912;
 Fri, 17 Dec 2021 06:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20211130123641.1449041-1-ray.huang@amd.com> <20211130123641.1449041-10-ray.huang@amd.com>
 <CAJZ5v0jbSC1Q1gn2+Hu6bJQN20uDDSbStdM3zHZ+UBR+YKsWQA@mail.gmail.com> <YbxByF9dEGrkR6Kr@amd.com>
In-Reply-To: <YbxByF9dEGrkR6Kr@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Dec 2021 15:05:29 +0100
Message-ID: <CAJZ5v0i_1kNWLeqWCR8_uPetq9o5yCYAxfpyciLn1KF55gb=6g@mail.gmail.com>
Subject: Re: [PATCH v5 09/22] cpufreq: amd: add trace for amd-pstate module
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmins.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 8:53 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Fri, Dec 17, 2021 at 02:12:41AM +0800, Rafael J. Wysocki wrote:
> > On Tue, Nov 30, 2021 at 1:38 PM Huang Rui <ray.huang@amd.com> wrote:
> > >
> > > Add trace event to monitor the performance value changes which is
> > > controlled by cpu governors.
> >
> > This would need an ACK from Steve.
> >
> > >
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > ---
> > >  drivers/cpufreq/Makefile           |  6 ++-
> > >  drivers/cpufreq/amd-pstate-trace.c |  2 +
> > >  drivers/cpufreq/amd-pstate-trace.h | 77 ++++++++++++++++++++++++++++++
> >
> > Why are these two extra files necessary?
>
> Please see below answer.
>
> >
> > >  drivers/cpufreq/amd-pstate.c       |  4 ++
> > >  4 files changed, 88 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/cpufreq/amd-pstate-trace.c
> > >  create mode 100644 drivers/cpufreq/amd-pstate-trace.h
> > >
> > > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > > index c8d307010922..285de70af877 100644
> > > --- a/drivers/cpufreq/Makefile
> > > +++ b/drivers/cpufreq/Makefile
> > > @@ -17,6 +17,10 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)  += cpufreq_governor_attr_set.o
> > >  obj-$(CONFIG_CPUFREQ_DT)               += cpufreq-dt.o
> > >  obj-$(CONFIG_CPUFREQ_DT_PLATDEV)       += cpufreq-dt-platdev.o
> > >
> > > +# Traces
> > > +CFLAGS_amd-pstate-trace.o               := -I$(src)
> > > +amd_pstate-y                           := amd-pstate.o amd-pstate-trace.o
> > > +
> > >  ##################################################################################
> > >  # x86 drivers.
> > >  # Link order matters. K8 is preferred to ACPI because of firmware bugs in early
> > > @@ -25,7 +29,7 @@ obj-$(CONFIG_CPUFREQ_DT_PLATDEV)      += cpufreq-dt-platdev.o
> > >  # speedstep-* is preferred over p4-clockmod.
> > >
> > >  obj-$(CONFIG_X86_ACPI_CPUFREQ)         += acpi-cpufreq.o
> > > -obj-$(CONFIG_X86_AMD_PSTATE)           += amd-pstate.o
> > > +obj-$(CONFIG_X86_AMD_PSTATE)           += amd_pstate.o
> > >  obj-$(CONFIG_X86_POWERNOW_K8)          += powernow-k8.o
> > >  obj-$(CONFIG_X86_PCC_CPUFREQ)          += pcc-cpufreq.o
> > >  obj-$(CONFIG_X86_POWERNOW_K6)          += powernow-k6.o
> > > diff --git a/drivers/cpufreq/amd-pstate-trace.c b/drivers/cpufreq/amd-pstate-trace.c
> > > new file mode 100644
> > > index 000000000000..891b696dcd69
> > > --- /dev/null
> > > +++ b/drivers/cpufreq/amd-pstate-trace.c
> > > @@ -0,0 +1,2 @@
> > > +#define CREATE_TRACE_POINTS
> > > +#include "amd-pstate-trace.h"
> > > diff --git a/drivers/cpufreq/amd-pstate-trace.h b/drivers/cpufreq/amd-pstate-trace.h
> > > new file mode 100644
> > > index 000000000000..647505957d4f
> > > --- /dev/null
> > > +++ b/drivers/cpufreq/amd-pstate-trace.h
> > > @@ -0,0 +1,77 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * amd-pstate-trace.h - AMD Processor P-state Frequency Driver Tracer
> > > + *
> > > + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
> > > + *
> > > + * Author: Huang Rui <ray.huang@amd.com>
> > > + */
> > > +
> > > +#if !defined(_AMD_PSTATE_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _AMD_PSTATE_TRACE_H
> > > +
> > > +#include <linux/cpufreq.h>
> > > +#include <linux/tracepoint.h>
> > > +#include <linux/trace_events.h>
> > > +
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM amd_cpu
> > > +
> > > +#undef TRACE_INCLUDE_FILE
> > > +#define TRACE_INCLUDE_FILE amd-pstate-trace
> > > +
> > > +#define TPS(x)  tracepoint_string(x)
> > > +
> > > +TRACE_EVENT(amd_pstate_perf,
> >
> > Could this be added to include/trace/events/power.h ?
> >
>
> Actually, that is my original idea, but once I move the trace into
> include/trace/events/power.h, the amd-pstate driver cannot build as "ko"
> anymore. This is the early stage, "ko" is friendly and flexible for us to
> switch and compare between amd-pstate and acpi-cpufreq. I can move it into
> "power" trace events once we address the performance issue on shared memory
> solution.

OK, I guess it's fine then, but it still needs an ACK from Steve.
