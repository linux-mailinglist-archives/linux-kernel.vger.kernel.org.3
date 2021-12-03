Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BA4679F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352668AbhLCPLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:11:08 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42806 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245005AbhLCPLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:11:06 -0500
Received: by mail-ot1-f47.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so3559550otv.9;
        Fri, 03 Dec 2021 07:07:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gn2Un0wFspwauwGpTVSrlrVYwQtdrzux5N9Pik1vQ8Q=;
        b=1cQHB9LvyYUBvpQjW1SxczwAegBNu6uWVfiOxnOKekXtFijH8tp2KKBRk0hMlellvN
         24IYPimjSH/5pIaYDFY/KkijlAPKOtcsbzJnedtShbMvpPjTG0SuLwyfH7S3i0CLfRR0
         Q/irp0PKAgudK7kFmPqoyZB8OnZ2oDjPtlU0x8L5Ucg7Z/R2z3fipj1HA74LGwTnPqBI
         4HxKWhlBEd0ehyZIMLsfswdGbH11MKLI6kkDuMIZ1K+YaBtETMPG3i9KIXwkxHWuaF+6
         6w/KgtyV73OukmT1wUiLtdvgx9zXtUgyOuPlcrlxIbzU1ZIvh3QQOw59p2bIt0x4zDhw
         hIgg==
X-Gm-Message-State: AOAM531T2XHFJtPeqh1KdkFrgEmgvM63nfrTJ4n9JhWnxo7lij47mWtv
        dxK0WTumHD3uISWctueF6SagTdF4rrKh2ApKBVo2tP9O
X-Google-Smtp-Source: ABdhPJzkLqFlEiqiMfaTMzViNzPSA0ZYqJnoP9b6cwvp0N+C2SedZyCdSKH53aEzUf8jaEYKfSlitLawN130uNzn7eU=
X-Received: by 2002:a05:6830:348f:: with SMTP id c15mr17262010otu.254.1638544061740;
 Fri, 03 Dec 2021 07:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20211115201010.68567-1-thara.gopinath@linaro.org>
 <CAJZ5v0gezoJZVH69Y7fDwa-uLhE0PaqFrzM=0bequxpE_749zg@mail.gmail.com>
 <8f7397e3-4e92-c84d-9168-087967f4d683@arm.com> <CAJZ5v0iRDtr5yae5UndwU2SmVL4cak=BN0irVGbgNzQiS8K3mA@mail.gmail.com>
 <af59de78-49b0-d2e6-4bf0-7c897c2fccb1@linaro.org> <CAJZ5v0h3O_rSR38X4fV1FC2O2DYQnxzeLbxcSqh1vpnE65Nd+A@mail.gmail.com>
 <20211202105027.GA1180274@e123083-lin> <CAJZ5v0hRvsoEZj45OWe34uhAPj+J1rJWq5Wff4R0f_BYEuU5wA@mail.gmail.com>
 <20211203094734.GA5838@e123083-lin>
In-Reply-To: <20211203094734.GA5838@e123083-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Dec 2021 16:07:30 +0100
Message-ID: <CAJZ5v0iGa=YErmDgLPCO1h=gOjkD6sRVonqPEUN1uf8sxpQ0qQ@mail.gmail.com>
Subject: Re: [PATCH] base: arch_topology: Use policy->max to calculate freq_factor
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 10:48 AM Morten Rasmussen
<morten.rasmussen@arm.com> wrote:
>
> On Thu, Dec 02, 2021 at 05:31:53PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 2, 2021 at 11:50 AM Morten Rasmussen
> > <morten.rasmussen@arm.com> wrote:
> > >
> > > On Wed, Nov 17, 2021 at 06:59:05PM +0100, Rafael J. Wysocki wrote:
> > > > On Wed, Nov 17, 2021 at 6:01 PM Thara Gopinath
> > > > <thara.gopinath@linaro.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On 11/17/21 7:49 AM, Rafael J. Wysocki wrote:
> > > > > > On Wed, Nov 17, 2021 at 11:46 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > > > >>
> > > > > >> Hi Rafael,
> > > > > >>
> > > > > >> On 11/16/21 7:05 PM, Rafael J. Wysocki wrote:
> > > > > >>> On Mon, Nov 15, 2021 at 9:10 PM Thara Gopinath
> > > > > >>> <thara.gopinath@linaro.org> wrote:
> > > > > >>>>
> > > > > >>>> cpuinfo.max_freq can reflect boost frequency if enabled during boot.  Since
> > > > > >>>> we don't consider boost frequencies while calculating cpu capacities, use
> > > > > >>>> policy->max to populate the freq_factor during boot up.
> > > > > >>>
> > > > > >>> I'm not sure about this.  schedutil uses cpuinfo.max_freq as the max frequency.
> > > > > >>
> > > > > >> Agree it's tricky how we treat the boost frequencies and also combine
> > > > > >> them with thermal pressure.
> > > > > >> We probably would have consider these design bits:
> > > > > >> 1. Should thermal pressure include boost frequency?
> > > > > >
> > > > > > Well, I guess so.
> > > > > >
> > > > > > Running at a boost frequency certainly increases thermal pressure.
> > > > > >
> > > > > >> 2. Should max capacity 1024 be a boost frequency so scheduler
> > > > > >>      would see it explicitly?
> > > > > >
> > > > > > That's what it is now if cpuinfo.max_freq is a boost frequency.
> > > > > >
> > > > > >> - if no, then schedutil could still request boost freq thanks to
> > > > > >>     map_util_perf() where we add 25% to the util and then
> > > > > >>     map_util_freq() would return a boost freq when util was > 1024
> > > > > >>
> > > > > >>
> > > > > >> I can see in schedutil only one place when cpuinfo.max_freq is used:
> > > > > >> get_next_freq(). If the value stored in there is a boost,
> > > > > >> then don't we get a higher freq value for the same util?
> > > > > >
> > > > > > Yes. we do, which basically is my point.
> > > > > >
> > > > > > The schedutil's response is proportional to cpuinfo.max_freq and that
> > > > > > needs to be taken into account for the results to be consistent.
> > > > >
> > > > > So IIUC, cpuinfo.max_freq is always supposed to be the highest supported
> > > > > frequency of a cpu, irrespective of whether boost is enabled or not.
> > > > > Where as policy->max is the currently available maximum cpu frequency
> > > > > which can be equal to cpuinfo.max_freq or lower (depending on whether
> > > > > boost is enabled, whether there is a constraint on policy->max placed by
> > > > > thermal etc).
> > > >
> > > > It may also depend on the limit set by user space.
> > > >
> > > > > So in this case isn't it better for schedutil to consider
> > > > > policy->max instead of cpuinfo.max ?
> > > >
> > > > Not really.
> > > >
> > > > In that case setting policy->max to 1/2 of cpuinfo.max_freq would
> > > > cause schedutil to choose 1/4 of cpuinfo.max_freq for 50% utilization
> > > > which would be rather unexpected.
> > > >
> > > > policy->max is a cap, not the current maximum capacity.
> > > >
> > > > > Like you mentioned above same
> > > > > utilization will relate to different frequencies depending on the
> > > > > maximum frequency.
> > > >
> > > > Which is not how it is expected (and defined) to work, though.
> > > >
> > > > If you really want to play with the current maximum capacity, you need
> > > > to change it whenever boost is disabled or enabled - and there is a
> > > > mechanism for updating cpufinfo.max_freq in such cases.
> > >
> > > I don't see why we would want to change max capacity on the fly. It is
> > > not a cheap operation as we would need to normalize the capacity for all
> > > CPUs if the CPU(s) with capacity = 1024 changes its capacity. Worst case
> > > we even have to rebuild the sched_domain hierarchy to update flags. The
> > > update would also temporarily mess with load and utilization signals, so
> > > not a cheap operation.
> >
> > I didn't say it was cheap. :-)
>
> You didn't :-) But I thought it was worth pointing out in case someone
> would think we need to constantly renormalize to the highest achievable
> performance level taking all factors into account, including thermal
> capping.
>
> > However, boost frequencies are not disabled and enabled very often, so
> > it may be acceptable to do it then.  I actually don't know.
>
> Agree.
>
> >
> > The point is that if you set the max capacity to correspond to the max
> > boosted perf and it is never reached (because boost is disabled), the
> > scaling will cause CPUs to appear as underutilized, but in fact there
> > is no spare capacity in the system.
>
> We kind of have the problem already with thermal capping but addressed
> it by having the thermal pressure signal to indicate the some of the
> capacity is unavailable. Perhaps the thermal pressure signal should be extended
> to cover all reasons for capacity being unavailable, or we should have
> another signal to track boost frequencies not being delivered, manually
> disabled or not possible due to system circumstances?

Well, even without boost frequencies, the capacity that's effectively
available may not be the advertised max.  For example,
scaling_max_freq may be set below the advertised max value (and that's
applied after the governor has produced its output), there may be
power capping in place etc.

Taking the thermal pressure in particular into account helps to reduce
it, but that may just be part of the difference between the advertised
max and the effectively available perf, and not even the dominating
one for that matter.

And boost frequencies complicate the picture even further, because
they are more-or-less unsustainable and as a rule there's no
information on how sustainable they are or how much time it takes to
get to the max boost perf (and that may be configurable even).

So IMO the advertised max ought to be treated as the upper bound in
general, but it makes sense to adjust it when it is known to be too
large and it may stay so forever (which is the case when boost
frequencies are disabled).

> > Conversely, if the max capacity corresponds to the max non-boost perf
> > and boost is used very often, the scaling will cause the CPUs to
> > appear to be 100% loaded, but there may be still spare capacity in the
> > system.
>
> It is even worse than that. Allowing delivered performance to exceed the
> CPU capacity will break utilization scale invariance at it will make
> per-task utilization appear smaller than it really is potentially
> leading to wrong task placement.
>
> I think we have to ensure that the full performance range is visible to
> the OS. If part of it is often unachievable we need to track the gap
> between requested and delivered performance and somehow take that into
> account when making task placement decisions.

I generally agree, but let me say that correlating what was asked for
with the delivered perf need not be straightforward.
