Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E273047C5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbhLUSKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:10:17 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:40787 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbhLUSKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:10:16 -0500
Received: by mail-qk1-f172.google.com with SMTP id p4so13374727qkm.7;
        Tue, 21 Dec 2021 10:10:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXvqX8gZjmdUiAACLk+NHfK5SRie0yMpffYTBcnAAmQ=;
        b=G9VZz/ncrplVIJZ8XXkXNslLNGNizcIvREeDnpTs2b2Q2j62cOJH8DfOPahBUwagCg
         0gDgpqPSqJQ+9cIZp7qM4mHLeXUH0MggNUFacTzXBAatk6J9YQ/yYQo95tXvrSEZuDVL
         FmWH2fWGHCExJRyPqmBmQAK/Z0B17nESTEQgbyDF+dzG+NV/0zeW+WgTxipSuDckAM0k
         /VwIznvpn084gjdKpNd/hUYRscIcOciG0AehbjcGiWIMtHtIPeRBl4rMj4eYGrDOitXZ
         bSt5dDVThOn2nmclhV1XcmHjkbEZCZJDsKwMzOZBIYe64RUV6l56i/jycRmvghdjh6vp
         Ss8Q==
X-Gm-Message-State: AOAM5339QHkO+hdcVQVKAxFIgD4E4qWMACTSCDRPiE/EZfkhkV/hWsJ3
        wO4CbWLH9e0qW/BiCIEvsrZW7lRmYQvw7G6ueVGUbwAl
X-Google-Smtp-Source: ABdhPJzcyZJun3zXjXRhVXmeD0Jw4RkQ5Voiwb1xuM8mVeLPIovh+bF7Zdv3FXuhWrVq+0iTHbbT2qp1P7O5RyPP+6o=
X-Received: by 2002:a05:620a:2093:: with SMTP id e19mr2902589qka.516.1640110215740;
 Tue, 21 Dec 2021 10:10:15 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2112132215060.215073@hadrien>
 <CAJZ5v0iBU8gw8+-5nxj2cKzf7tyN=p3Adcm4Z5bn=oVYhU28bQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2112172022100.2968@hadrien> <CAJZ5v0jQysTLSHp533swboHBzX7DVF_0UETLmOqmnc7hTXHWVg@mail.gmail.com>
 <alpine.DEB.2.22.394.2112191751140.3181@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2112191751140.3181@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Dec 2021 19:10:04 +0100
Message-ID: <CAJZ5v0hZ4p9BGiQu1qaOFtDDCxxHWbW=BzXF7z7FCKkAMZ=OsA@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: map utilization into the pstate range
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Sun, Dec 19, 2021 at 6:03 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Sun, 19 Dec 2021, Rafael J. Wysocki wrote:
>
> > On Fri, Dec 17, 2021 at 8:32 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > >
> > >
> > >
> > > On Fri, 17 Dec 2021, Rafael J. Wysocki wrote:
> > >
> > > > On Mon, Dec 13, 2021 at 11:52 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > > > >
> > > > > With HWP, intel_cpufreq_adjust_perf takes the utilization, scales it
> > > > > between 0 and the capacity, and then maps everything below min_pstate to
> > > > > the lowest frequency.
> > > >
> > > > Well, it is not just intel_pstate with HWP.  This is how schedutil
> > > > works in general; see get_next_freq() in there.
> > > >
> > > > > On my Intel Xeon Gold 6130 and Intel Xeon Gold
> > > > > 5218, this means that more than the bottom quarter of utilizations are all
> > > > > mapped to the lowest frequency.  Running slowly doesn't necessarily save
> > > > > energy, because it takes more time.
> > > >
> > > > This is true, but the layout of the available range of performance
> > > > values is a property of the processor, not a driver issue.
> > > >
> > > > Moreover, the role of the driver is not to decide how to respond to
> > > > the given utilization value, that is the role of the governor.  The
> > > > driver is expected to do what it is asked for by the governor.
> > >
> > > OK, but what exactly is the goal of schedutil?
> >
> > The short answer is: minimizing the cost (in terms of energy) of
> > allocating an adequate amount of CPU time for a given workload.
> >
> > Of course, this requires a bit of explanation, so bear with me.
> >
> > It starts with a question:
> >
> > Given a steady workload (ie. a workload that uses approximately the
> > same amount of CPU time to run in every sampling interval), what is
> > the most efficient frequency (or generally, performance level measured
> > in some abstract units) to run it at and still ensure that it will get
> > as much CPU time as it needs (or wants)?
> >
> > To answer this question, let's first assume that
> >
> > (1) Performance is a monotonically increasing (ideally, linear)
> > function of frequency.
> > (2) CPU idle states have not enough impact on the energy usage for
> > them to matter.
> >
> > Both of these assumptions may not be realistic, but that's how it goes.
> >
> > Now, consider the "raw" frequency-dependent utilization
> >
> > util(f) = util_max * (t_{total} - t_{idle}(f)) / t_{total}
> >
> > where
> >
> > t_{total} is the total CPU time available in the given time frame.
> > t_{idle}(f) is the idle CPU time appearing in the workload when run at
> > frequency f in that time frame.
> > util_max is a convenience constant allowing an integer data type to be
> > used for representing util(f) with sufficient approximation.
> >
> > Notice that by assumption (1), util(f) is a monotonically decreasing
> > function, so if util(f_{max}) = util_max (where f_{max} is the maximum
> > frequency available from the hardware), which means that there is no
> > idle CPU time in the workload when run at the max available frequency,
> > there will be no idle CPU time in it when run at any frequency below
> > f_{max}.  Hence, in that case the workload needs to be run at f_{max}.
> >
> > If util(f_{max}) < util_max, there is some idle CPU time in the
> > workload at f_{max} and it may be run at a lower frequency without
> > sacrificing performance.  Moreover, the cost should be minimum when
> > running the workload at the maximum frequency f_e for which
> > t_{idle}(f_e) = 0.  IOW, that is the point at which the workload still
> > gets as much CPU time as needed, but the cost of running it is
> > maximally reduced.
>
> Thanks for the detailed explanation.  I got lost at this point, though.
>
> Idle time can be either due to I/O, or due to waiting for synchronization
> from some other thread perhaps on another core.  How can either of these
> disappear?

I guess the "due to I/O" case needs to be expanded a bit.

If a task waits for new data to appear (which in the steady case is
assumed to happen on a regular basis) and then wakes up, processes
them and goes back to sleep, then the data processing speed can be
adjusted to the rate at which new data appear so as to reduce the
sleep (or idle) time almost down to 0, at least theoretically.

Conversely, if a task submits data for I/O and waits for the I/O to
complete, it may as well start to prepare a new buffer for the next
I/O cycle as soon as the previous one has been submitted.  In that
case, the speed at which the new buffer is prepared can be adjusted to
the time it takes to complete the I/O so as to reduce the task's sleep
(or idle) time, at least in theory.

But, yes, there are cases in which that cannot be done (see below).

> In the I/O case, no matter what the frequency, the idle time
> will be the same (in a simplified world).

Well, not necessarily.

> In the case of waiting for
> another thread on another core, assuming that all the cores are running at
> the same frequency, lowering the frequency will cause the both running
> time and the idle time to increase, and it will cause util(f) to stay the
> same.

The running and idle time can't both increase simultaneously, because
the sum of them is the total CPU time (in each sampling interval)
which can't expand.

Anyway, this case can only be addressed precisely if the exact type of
dependency between the tasks in question is taken into account (eg.
producer-consumer etc).

> Both cases seem to send the application directly to the lowest
> frequency.  I guess that's fine if we also assume that the lowest
> frequency is also the most efficient one.

They may, but this is not what schedutil does.  It simply tries to run
every task at a frequency proportional to its scale-invariant
utilization and the reason why it does that is because in the "steady"
cases where computations can be carried out in parallel with the I/O
doing that corresponds to looking for the maximum speed at which
there's no idle time in the workload.

In the cases in which reducing the speed of computations doesn't cause
the amount of idle time to decrease, the "right" speed to run the
workload depends on its performance requirements (because in practice
running computations at lower speeds is more enerrgy-efficient most of
the time in such cases) and they can be sort of expressed by
increasing scaling_min_freq or through utilization clamping.
