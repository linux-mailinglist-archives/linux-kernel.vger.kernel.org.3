Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A85481E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbhL3RDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:03:47 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:46738 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbhL3RDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:03:45 -0500
Received: by mail-qk1-f182.google.com with SMTP id 202so19446759qkg.13;
        Thu, 30 Dec 2021 09:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJ1d4DWjDI379And7hXBvRjc241CBOgGxTAOgcshwlw=;
        b=39cUWkMdAl+upGvBnUGVGyFdH201dMZ46LU5Q0zj1h8bdZ883DraO8QAho44PamKcJ
         1v96mX/aALAGukGYWXEZED7RHJNDo5PtxF6Wt4u0RsDG94bQtLhi+M5o0kvL7h3IqddZ
         jar1tP6/jqU/AoLGT0lIeXjzTenQoJnIESTP9/lHtGuuEZgDEo3iwOhKHefKRhNTYlUW
         8Iqm2i0TFN8lt+bNP2ksTzyGw30MRMOIE0Eo3JfLONVjTveca1XKufGPNNvsg0t71YiK
         FRSUWevxHEsCX1CkajWI7Sx03iaGFLMzxxHHGiSoSJ8Z+Cfgi5j+c5Hr3Mg0XcI3muOJ
         STqw==
X-Gm-Message-State: AOAM531j0CthoOdQk7UK02NK93/0PupITItRXXGYbQtT8rf9p9CPz56V
        FdzpzFlhRTOByBUWiNc5hda9J4whsfbdR2WMedhZmkU7
X-Google-Smtp-Source: ABdhPJwTBurn5u3bpPRJz28yFhGiA/HCBiw3VAfvYFU/qOgzyomP2bAnZ+cMc1Y/hJjK6KzHox5345z2EWCSzmKZVC4=
X-Received: by 2002:a37:b702:: with SMTP id h2mr22500092qkf.135.1640883824394;
 Thu, 30 Dec 2021 09:03:44 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112172258480.2968@hadrien> <87fsqqu6by.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <87wnk0s0tf.fsf@riseup.net>
 <CAJZ5v0i7gBtm6x+zUUzhxXjmYhPwr=JxvOuMZ0aD9qxnjE9YKw@mail.gmail.com>
 <878rwdse9o.fsf@riseup.net> <alpine.DEB.2.22.394.2112281745240.24929@hadrien>
 <CAJZ5v0i4xnesG=vfx7Y-wyeaGvjDeGcsaOVqhRLnV8YXk-m2gA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112281845180.24929@hadrien> <CAJZ5v0grayg9evWsB5ktKSFq=yA_AHoEWSfpSkQ=MVQ-=butfA@mail.gmail.com>
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2112291012030.24929@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 18:03:33 +0100
Message-ID: <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Francisco Jerez <currojerez@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 10:13 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 28 Dec 2021, Rafael J. Wysocki wrote:
>
> > On Tue, Dec 28, 2021 at 6:46 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > >
> > >
> > > On Tue, 28 Dec 2021, Rafael J. Wysocki wrote:
> > >
> > > > On Tue, Dec 28, 2021 at 5:58 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > >
> > > > > I looked a bit more into why pstate 20 is always using the least energy. I
> > > > > have just one thread spinning for 10 seconds, I use a fixed value for the
> > > > > pstate, and I measure the energy usage with turbostat.
> > > >
> > > > How exactly do you fix the pstate?
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index e7af18857371..19440b15454c 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -400,7 +402,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
> > >                 sg_cpu->util = prev_util;
> > >
> > >         cpufreq_driver_adjust_perf(sg_cpu->cpu, map_util_perf(sg_cpu->bw_dl),
> > > -                                  map_util_perf(sg_cpu->util), sg_cpu->max);
> > > +                                  sysctl_sched_fixedfreq, sg_cpu->max);
> >
> > This is just changing the "target" hint given to the processor which
> > may very well ignore it, though.
> >
> > >
> > >         sg_cpu->sg_policy->last_freq_update_time = time;
> > >  }
> > >
> > > ------------------------------
> > >
> > > sysctl_sched_fixedfreq is a variable that I added to sysfs.
> >
> > If I were trying to fix a pstate, I would set scaling_max_freq and
> > scaling_min_freq in sysfs for all CPUs to the same value.
> >
> > That would cause intel_pstate to set HWP min and max to the same value
> > which should really cause the pstate to be fixed, at least outside the
> > turbo range of pstates.
>
> The effect is the same.  But that approach is indeed simpler than patching
> the kernel.

It is also applicable when intel_pstate runs in the active mode.

As for the results that you have reported, it looks like the package
power on these systems is dominated by package voltage and going from
P-state 20 to P-state 21 causes that voltage to increase significantly
(the observed RAM energy usage pattern is consistent with that).  This
means that running at P-states above 20 is only really justified if
there is a strict performance requirement that can't be met otherwise.

Can you please check what value is there in the base_frequency sysfs
attribute under cpuX/cpufreq/?

I'm guessing that the package voltage level for P-states 10 and 20 is
the same, so the power difference between them is not significant
relative to the difference between P-state 20 and 21 and if increasing
the P-state causes some extra idle time to appear in the workload
(even though there is not enough of it to prevent to overall
utilization from increasing), then the overall power draw when running
at P-state 10 may be greater that for P-state 20.

You can check if there is any C-state residency difference between
these two cases by running the workload under turbostat in each of
them.

Anyway, this is a configuration in which the HWP scaling algorithm
used when intel_pstate runs in the active mode is likely to work
better, because it should take the processor design into account.
That's why it is the default configuration of intel_pstate on systems
with HWP.  There are cases in which schedutil helps, but that's mostly
when HWP without it tends to run the workload too fast, because it
lacks the utilization history provided by PELT.
