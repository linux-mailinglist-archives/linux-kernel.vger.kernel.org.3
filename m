Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE3A47A0F4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 15:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhLSOar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 09:30:47 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42848 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhLSOaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 09:30:46 -0500
Received: by mail-oi1-f178.google.com with SMTP id p4so11775027oia.9;
        Sun, 19 Dec 2021 06:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9af47FwWul6o7IH1rtZ+HSandlhBJqTDESORN+oRbv8=;
        b=GH0sCxGlExZFB7T+BdbASzPcaCUUquYUqXJiji5J86+pdw48kfUb0vV4nkla1uGP3v
         Ab94EPee79SDAaIMlNokLKde1M4fX8R2gTaMOQ2Z1fmvrOo4qlpP54qLY1j1OI3Am+kX
         29aW2S+C9lHan5uzeD657jNm7/X9138MCLp2aqYNol7yGKF5DgQ91v64D/iqtV+UdPBz
         Q7SmCY+kshVgZlZxufb7yDKCD9qGQ8zwm3AhHyg6Pg+XtG+Vcyj5tz4SK55Yg6pp7RNt
         02PAbEwoJcS+5kC+tnNyzWPIytbmasCG4k5IWPkyK22XxHawR35j6Pn7/N6WdaSrBkUA
         Zm1w==
X-Gm-Message-State: AOAM53242or7fMF5b/YHXAhrKjDtB8rkNsNWp9clu69j9Js2PKzWnUJb
        C4nsYX8BYJlHiXlzJHAEK8Elfg5X0NwnsUXEN24=
X-Google-Smtp-Source: ABdhPJxsRx+54LStAhl26NuPic23Khf1uKyrooPHzQJBaQ+VxEUHynjCN/86uP7tA9efRuWadXQ8Al/fk6HKuD15/Vc=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr8500618oiw.154.1639924245949;
 Sun, 19 Dec 2021 06:30:45 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <87r1abt1d2.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112172258480.2968@hadrien> <87fsqqu6by.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112180654470.3139@hadrien> <878rwitdu3.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112181138210.3130@hadrien> <871r29tvdj.fsf@riseup.net>
 <alpine.DEB.2.22.394.2112190734070.3181@hadrien> <CAJZ5v0he+_p5qVkx+fGUg7BCBYmm5yRh4q-_9jgJoZLwDf1c2Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0he+_p5qVkx+fGUg7BCBYmm5yRh4q-_9jgJoZLwDf1c2Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 19 Dec 2021 15:30:34 +0100
Message-ID: <CAJZ5v0h98XXvSOpBFn4vV1QivFtsSzzVg8sJGq4v04uf5bi5Jw@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Francisco Jerez <currojerez@riseup.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Sun, Dec 19, 2021 at 3:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Dec 19, 2021 at 7:42 AM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Sat, 18 Dec 2021, Francisco Jerez wrote:
> >
> > > Julia Lawall <julia.lawall@inria.fr> writes:
> > >
> > > > On Sat, 18 Dec 2021, Francisco Jerez wrote:
> > > >
> > > >> Julia Lawall <julia.lawall@inria.fr> writes:
> > > >>
> > > >> >> As you can see in intel_pstate.c, min_pstate is initialized on core
> > > >> >> platforms from MSR_PLATFORM_INFO[47:40], which is "Maximum Efficiency
> > > >> >> Ratio (R/O)".  However that seems to deviate massively from the most
> > > >> >> efficient ratio on your system, which may indicate a firmware bug, some
> > > >> >> sort of clock gating problem, or an issue with the way that
> > > >> >> intel_pstate.c processes this information.
> > > >> >
> > > >> > I'm not sure to understand the bug part.  min_pstate gives the frequency
> > > >> > that I find as the minimum frequency when I look for the specifications of
> > > >> > the CPU.  Should one expect that it should be something different?
> > > >> >
> > > >>
> > > >> I'd expect the minimum frequency on your processor specification to
> > > >> roughly match the "Maximum Efficiency Ratio (R/O)" value from that MSR,
> > > >> since there's little reason to claim your processor can be clocked down
> > > >> to a frequency which is inherently inefficient /and/ slower than the
> > > >> maximum efficiency ratio -- In fact they both seem to match in your
> > > >> system, they're just nowhere close to the frequency which is actually
> > > >> most efficient, which smells like a bug, like your processor
> > > >> misreporting what the most efficient frequency is, or it deviating from
> > > >> the expected one due to your CPU static power consumption being greater
> > > >> than it would be expected to be under ideal conditions -- E.g. due to
> > > >> some sort of clock gating issue, possibly due to a software bug, or due
> > > >> to our scheduling of such workloads with a large amount of lightly
> > > >> loaded threads being unnecessarily inefficient which could also be
> > > >> preventing most of your CPU cores from ever being clock-gated even
> > > >> though your processor may be sitting idle for a large fraction of their
> > > >> runtime.
> > > >
> > > > The original mail has results from two different machines: Intel 6130
> > > > (skylake) and Intel 5218 (cascade lake).  I have access to another cluster
> > > > of 6130s and 5218s.  I can try them.
> > > >
> > > > I tried 5.9 in which I just commented out the schedutil code to make
> > > > frequency requests.  I only tested avrora (tiny pauses) and h2 (longer
> > > > pauses) and in both case the execution is almost entirely in the turbo
> > > > frequencies.
> > > >
> > > > I'm not sure to understand the term "clock-gated".  What C state does that
> > > > correspond to?  The turbostat output for one run of avrora is below.
> > > >
> > >
> > > I didn't have any specific C1+ state in mind, most of the deeper ones
> > > implement some sort of clock gating among other optimizations, I was
> > > just wondering whether some sort of software bug and/or the highly
> > > intermittent CPU utilization pattern of these workloads are preventing
> > > most of your CPU cores from entering deep sleep states.  See below.
> > >
> > > > julia
> > > >
> > > > 78.062895 sec
> > > > Package Core  CPU     Avg_MHz Busy%   Bzy_MHz TSC_MHz IRQ     SMI     POLL    C1      C1E     C6      POLL%   C1%     C1E%    C6%     CPU%c1  CPU%c6  CoreTmp PkgTmp  Pkg%pc2 Pkg%pc6 Pkg_J   RAM_J   PKG_%   RAM_%
> > > > -     -       -       31      2.95    1065    2096    156134  0       1971    155458  2956270 657130  0.00    0.20    4.78    92.26   14.75   82.31   40      41      45.14   0.04    4747.52 2509.05 0.00    0.00
> > > > 0     0       0       13      1.15    1132    2095    11360   0       0       2       39      19209   0.00    0.00    0.01    99.01   8.02    90.83   39      41      90.24   0.04    2266.04 1346.09 0.00    0.00
> > >
> > > This seems suspicious:                                                                                                                                                          ^^^^    ^^^^^^^
> > >
> > > I hadn't understood that you're running this on a dual-socket system
> > > until I looked at these results.
> >
> > Sorry not to have mentioned that.
> >
> > > It seems like package #0 is doing
> > > pretty much nothing according to the stats below, but it's still
> > > consuming nearly half of your energy, apparently because the idle
> > > package #0 isn't entering deep sleep states (Pkg%pc6 above is close to
> > > 0%).  That could explain your unexpectedly high static power consumption
> > > and the deviation of the real maximum efficiency frequency from the one
> > > reported by your processor, since the reported maximum efficiency ratio
> > > cannot possibly take into account the existence of a second CPU package
> > > with dysfunctional idle management.
> >
> > Our assumption was that if anything happens on any core, all of the
> > packages remain in a state that allows them to react in a reasonable
> > amount of time ot any memory request.
> >
> > > I'm guessing that if you fully disable one of your CPU packages and
> > > repeat the previous experiment forcing various P-states between 10 and
> > > 37 you should get a maximum efficiency ratio closer to the theoretical
> > > one for this CPU?
> >
> > OK, but that's not really a natural usage context...  I do have a
> > one-socket Intel 5220.  I'll see what happens there.
> >
> > I did some experiements with forcing different frequencies.  I haven't
> > finished processing the results, but I notice that as the frequency goes
> > up, the utilization (specifically the value of
> > map_util_perf(sg_cpu->util) at the point of the call to
> > cpufreq_driver_adjust_perf in sugov_update_single_perf) goes up as well.
> > Is this expected?
>
> It isn't, as long as the scale-invariance mechanism mentioned in my
> previous message works properly.

But even if it doesn't, the utilization should decrease when the
frequency increases.

Increasing frequency should cause more instructions to be retired per
unit of time and so there should be more idle time in the workload.
