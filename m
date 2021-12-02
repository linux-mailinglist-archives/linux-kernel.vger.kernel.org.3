Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23DE466862
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359491AbhLBQfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:35:32 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33528 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359809AbhLBQf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:35:28 -0500
Received: by mail-ot1-f41.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso450438otf.0;
        Thu, 02 Dec 2021 08:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puf1vYFijievtcSCov0SbjyhrhL/hDVDktUDZuYOXCA=;
        b=SmGADNj9Hc9u89U2HOeoc+A+NFqlevoN/L0V//DZ1RIGXJOs3HpVSesLDDpTphBiso
         uMoZGooooAzutrB3JE6IXbOUQDYTtPiKEr694kTWBHCiOn2NXKeeZ4XV0WF//wd9+TUi
         vJJrT2h26Ge8wFgVailGi31pyoTHd/1pOEVjLfumbkuKa8fSB4fzS+cQnqxd6AdKE5wB
         6q4hJc1vVWT1H4870XIi2l5r0wYyvqZu5o0Q3Hv67/Osjj9LHiaR8LbUh0XfmPsQ2mfp
         vxke5Fzheiuov2eN6qGqbCaVuqOxV8BrHaXUN5fmNgRsh5CEjvfELAEkOU6clm9iXqF2
         0lqw==
X-Gm-Message-State: AOAM532rma5SwqLly2NG0YK7dL2EWQdljf+WL5f6fyy8vc0ENENtHCzZ
        fvf4B6Tw2207RWkiihC2HCIc+8fUtc4N/Hr+Q38=
X-Google-Smtp-Source: ABdhPJzztRvfXpTejpa4p8BiYgUURMlTcY9YBhmQXZowM98RHRgSd6d+nWQuUX2RjJJvhr7RayEAXgc/mJmccAHDHg8=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr12129271otf.198.1638462725118;
 Thu, 02 Dec 2021 08:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20211115201010.68567-1-thara.gopinath@linaro.org>
 <CAJZ5v0gezoJZVH69Y7fDwa-uLhE0PaqFrzM=0bequxpE_749zg@mail.gmail.com>
 <8f7397e3-4e92-c84d-9168-087967f4d683@arm.com> <CAJZ5v0iRDtr5yae5UndwU2SmVL4cak=BN0irVGbgNzQiS8K3mA@mail.gmail.com>
 <af59de78-49b0-d2e6-4bf0-7c897c2fccb1@linaro.org> <CAJZ5v0h3O_rSR38X4fV1FC2O2DYQnxzeLbxcSqh1vpnE65Nd+A@mail.gmail.com>
 <20211202105027.GA1180274@e123083-lin>
In-Reply-To: <20211202105027.GA1180274@e123083-lin>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Dec 2021 17:31:53 +0100
Message-ID: <CAJZ5v0hRvsoEZj45OWe34uhAPj+J1rJWq5Wff4R0f_BYEuU5wA@mail.gmail.com>
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

On Thu, Dec 2, 2021 at 11:50 AM Morten Rasmussen
<morten.rasmussen@arm.com> wrote:
>
> On Wed, Nov 17, 2021 at 06:59:05PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Nov 17, 2021 at 6:01 PM Thara Gopinath
> > <thara.gopinath@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > On 11/17/21 7:49 AM, Rafael J. Wysocki wrote:
> > > > On Wed, Nov 17, 2021 at 11:46 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > >>
> > > >> Hi Rafael,
> > > >>
> > > >> On 11/16/21 7:05 PM, Rafael J. Wysocki wrote:
> > > >>> On Mon, Nov 15, 2021 at 9:10 PM Thara Gopinath
> > > >>> <thara.gopinath@linaro.org> wrote:
> > > >>>>
> > > >>>> cpuinfo.max_freq can reflect boost frequency if enabled during boot.  Since
> > > >>>> we don't consider boost frequencies while calculating cpu capacities, use
> > > >>>> policy->max to populate the freq_factor during boot up.
> > > >>>
> > > >>> I'm not sure about this.  schedutil uses cpuinfo.max_freq as the max frequency.
> > > >>
> > > >> Agree it's tricky how we treat the boost frequencies and also combine
> > > >> them with thermal pressure.
> > > >> We probably would have consider these design bits:
> > > >> 1. Should thermal pressure include boost frequency?
> > > >
> > > > Well, I guess so.
> > > >
> > > > Running at a boost frequency certainly increases thermal pressure.
> > > >
> > > >> 2. Should max capacity 1024 be a boost frequency so scheduler
> > > >>      would see it explicitly?
> > > >
> > > > That's what it is now if cpuinfo.max_freq is a boost frequency.
> > > >
> > > >> - if no, then schedutil could still request boost freq thanks to
> > > >>     map_util_perf() where we add 25% to the util and then
> > > >>     map_util_freq() would return a boost freq when util was > 1024
> > > >>
> > > >>
> > > >> I can see in schedutil only one place when cpuinfo.max_freq is used:
> > > >> get_next_freq(). If the value stored in there is a boost,
> > > >> then don't we get a higher freq value for the same util?
> > > >
> > > > Yes. we do, which basically is my point.
> > > >
> > > > The schedutil's response is proportional to cpuinfo.max_freq and that
> > > > needs to be taken into account for the results to be consistent.
> > >
> > > So IIUC, cpuinfo.max_freq is always supposed to be the highest supported
> > > frequency of a cpu, irrespective of whether boost is enabled or not.
> > > Where as policy->max is the currently available maximum cpu frequency
> > > which can be equal to cpuinfo.max_freq or lower (depending on whether
> > > boost is enabled, whether there is a constraint on policy->max placed by
> > > thermal etc).
> >
> > It may also depend on the limit set by user space.
> >
> > > So in this case isn't it better for schedutil to consider
> > > policy->max instead of cpuinfo.max ?
> >
> > Not really.
> >
> > In that case setting policy->max to 1/2 of cpuinfo.max_freq would
> > cause schedutil to choose 1/4 of cpuinfo.max_freq for 50% utilization
> > which would be rather unexpected.
> >
> > policy->max is a cap, not the current maximum capacity.
> >
> > > Like you mentioned above same
> > > utilization will relate to different frequencies depending on the
> > > maximum frequency.
> >
> > Which is not how it is expected (and defined) to work, though.
> >
> > If you really want to play with the current maximum capacity, you need
> > to change it whenever boost is disabled or enabled - and there is a
> > mechanism for updating cpufinfo.max_freq in such cases.
>
> I don't see why we would want to change max capacity on the fly. It is
> not a cheap operation as we would need to normalize the capacity for all
> CPUs if the CPU(s) with capacity = 1024 changes its capacity. Worst case
> we even have to rebuild the sched_domain hierarchy to update flags. The
> update would also temporarily mess with load and utilization signals, so
> not a cheap operation.

I didn't say it was cheap. :-)

However, boost frequencies are not disabled and enabled very often, so
it may be acceptable to do it then.  I actually don't know.

The point is that if you set the max capacity to correspond to the max
boosted perf and it is never reached (because boost is disabled), the
scaling will cause CPUs to appear as underutilized, but in fact there
is no spare capacity in the system.

Conversely, if the max capacity corresponds to the max non-boost perf
and boost is used very often, the scaling will cause the CPUs to
appear to be 100% loaded, but there may be still spare capacity in the
system.
