Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A361481EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbhL3R6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:58:55 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:35827 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhL3R6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:58:53 -0500
Received: by mail-qt1-f170.google.com with SMTP id j17so22369386qtx.2;
        Thu, 30 Dec 2021 09:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QD1aj9TXJBpH5UqfHeYs/TFaBUwS5ZRep+k43Zsm2pA=;
        b=xoiRM6UG41s2J0omFxmLhelurGfEZvHALbtfbt0R6KRviAw1tBmD/N+vfcG9iES6qA
         B5OZ8/Uvbz2DGQn7WQPIYcgxPYAdCxM1GPT5hi0pKJlJAPN9TMWfSrfsAvb3Tc5/wdLR
         do++iSr+DDc1nfMaUjEir3oKfgqw2nBwRXAP+U5g7ROy/QWqb0+v/ZVMFksVuEUHEhTP
         1pQZZh6QSbh340arVN3Ws1IHLQuJrDEC2o/FdrM7ikoTMynJt99lbiBBTfBhHq0fQYIG
         zLHUUqHkajLt9UO+/t8caOOBiWhzUX25ZjeJgMkkvjwgRDcD6Fu5KeB7UdvIt8J7JLjn
         S+7w==
X-Gm-Message-State: AOAM530tou0q4VtP2Ivs/UPeG7CCAHCJMRxmYZhR+faUNDy0pDHEIATk
        y/r8k+wpid9xfcpBKD1kqs+z+szgWG9VJQ6Vf5o=
X-Google-Smtp-Source: ABdhPJw6Eojhl7OswwcxNETpAu8SyD6rI1f5FXxp1CgROTbrnGyPWWdgA9SAkHmQTFUo8yrYEGKp4cNBkmeDh4OjLpQ=
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr27446100qtv.80.1640887133120;
 Thu, 30 Dec 2021 09:58:53 -0800 (PST)
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
 <alpine.DEB.2.22.394.2112291012030.24929@hadrien> <CAJZ5v0g5wDxYXA-V=Ex_Md82hgnj5K6Vr0tavFFVz=uBqo8wag@mail.gmail.com>
 <alpine.DEB.2.22.394.2112301840360.15550@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2112301840360.15550@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 18:58:41 +0100
Message-ID: <CAJZ5v0h38jh3gyTp9W0ws0yXyfK=F+TQ7VYRVx4aGXhNeSObEg@mail.gmail.com>
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

On Thu, Dec 30, 2021 at 6:54 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > > The effect is the same.  But that approach is indeed simpler than patching
> > > the kernel.
> >
> > It is also applicable when intel_pstate runs in the active mode.
> >
> > As for the results that you have reported, it looks like the package
> > power on these systems is dominated by package voltage and going from
> > P-state 20 to P-state 21 causes that voltage to increase significantly
> > (the observed RAM energy usage pattern is consistent with that).  This
> > means that running at P-states above 20 is only really justified if
> > there is a strict performance requirement that can't be met otherwise.
> >
> > Can you please check what value is there in the base_frequency sysfs
> > attribute under cpuX/cpufreq/?
>
> 2100000, which should be pstate 21
>
> >
> > I'm guessing that the package voltage level for P-states 10 and 20 is
> > the same, so the power difference between them is not significant
> > relative to the difference between P-state 20 and 21 and if increasing
> > the P-state causes some extra idle time to appear in the workload
> > (even though there is not enough of it to prevent to overall
> > utilization from increasing), then the overall power draw when running
> > at P-state 10 may be greater that for P-state 20.
>
> My impression is that the package voltage level for P-states 10 to 20 is
> high enough that increasing the frequency has little impact.  But the code
> runs twice as fast, which reduces the execution time a lot, saving energy.
>
> My first experiment had only one running thread.  I also tried running 32
> spinning threads for 10 seconds, ie using up one package and leaving the
> other idle.  In this case, instead of staying around 600J for pstates
> 10-20, the pstate rises from 743 to 946.  But there is still a gap between
> 20 and 21, with 21 being 1392J.
>
> > You can check if there is any C-state residency difference between
> > these two cases by running the workload under turbostat in each of
> > them.
>
> The C1 and C6 cases (CPU%c1 and CPU%c6) are about the same between 20 and
> 21, whether with 1 thread or with 32 thread.

I meant to compare P-state 10 and P-state 20.

20 and 21 are really close as far as the performance is concerned, so
I wouldn't expect to see any significant C-state residency difference
between them.
