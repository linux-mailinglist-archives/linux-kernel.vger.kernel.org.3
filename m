Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD9E4661BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356693AbhLBKx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:53:59 -0500
Received: from foss.arm.com ([217.140.110.172]:33420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhLBKx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:53:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58759142F;
        Thu,  2 Dec 2021 02:50:35 -0800 (PST)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1383B3F7D7;
        Thu,  2 Dec 2021 02:50:33 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:50:27 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] base: arch_topology: Use policy->max to calculate
 freq_factor
Message-ID: <20211202105027.GA1180274@e123083-lin>
References: <20211115201010.68567-1-thara.gopinath@linaro.org>
 <CAJZ5v0gezoJZVH69Y7fDwa-uLhE0PaqFrzM=0bequxpE_749zg@mail.gmail.com>
 <8f7397e3-4e92-c84d-9168-087967f4d683@arm.com>
 <CAJZ5v0iRDtr5yae5UndwU2SmVL4cak=BN0irVGbgNzQiS8K3mA@mail.gmail.com>
 <af59de78-49b0-d2e6-4bf0-7c897c2fccb1@linaro.org>
 <CAJZ5v0h3O_rSR38X4fV1FC2O2DYQnxzeLbxcSqh1vpnE65Nd+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h3O_rSR38X4fV1FC2O2DYQnxzeLbxcSqh1vpnE65Nd+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 06:59:05PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 17, 2021 at 6:01 PM Thara Gopinath
> <thara.gopinath@linaro.org> wrote:
> >
> > Hi,
> >
> > On 11/17/21 7:49 AM, Rafael J. Wysocki wrote:
> > > On Wed, Nov 17, 2021 at 11:46 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > >>
> > >> Hi Rafael,
> > >>
> > >> On 11/16/21 7:05 PM, Rafael J. Wysocki wrote:
> > >>> On Mon, Nov 15, 2021 at 9:10 PM Thara Gopinath
> > >>> <thara.gopinath@linaro.org> wrote:
> > >>>>
> > >>>> cpuinfo.max_freq can reflect boost frequency if enabled during boot.  Since
> > >>>> we don't consider boost frequencies while calculating cpu capacities, use
> > >>>> policy->max to populate the freq_factor during boot up.
> > >>>
> > >>> I'm not sure about this.  schedutil uses cpuinfo.max_freq as the max frequency.
> > >>
> > >> Agree it's tricky how we treat the boost frequencies and also combine
> > >> them with thermal pressure.
> > >> We probably would have consider these design bits:
> > >> 1. Should thermal pressure include boost frequency?
> > >
> > > Well, I guess so.
> > >
> > > Running at a boost frequency certainly increases thermal pressure.
> > >
> > >> 2. Should max capacity 1024 be a boost frequency so scheduler
> > >>      would see it explicitly?
> > >
> > > That's what it is now if cpuinfo.max_freq is a boost frequency.
> > >
> > >> - if no, then schedutil could still request boost freq thanks to
> > >>     map_util_perf() where we add 25% to the util and then
> > >>     map_util_freq() would return a boost freq when util was > 1024
> > >>
> > >>
> > >> I can see in schedutil only one place when cpuinfo.max_freq is used:
> > >> get_next_freq(). If the value stored in there is a boost,
> > >> then don't we get a higher freq value for the same util?
> > >
> > > Yes. we do, which basically is my point.
> > >
> > > The schedutil's response is proportional to cpuinfo.max_freq and that
> > > needs to be taken into account for the results to be consistent.
> >
> > So IIUC, cpuinfo.max_freq is always supposed to be the highest supported
> > frequency of a cpu, irrespective of whether boost is enabled or not.
> > Where as policy->max is the currently available maximum cpu frequency
> > which can be equal to cpuinfo.max_freq or lower (depending on whether
> > boost is enabled, whether there is a constraint on policy->max placed by
> > thermal etc).
> 
> It may also depend on the limit set by user space.
> 
> > So in this case isn't it better for schedutil to consider
> > policy->max instead of cpuinfo.max ?
> 
> Not really.
> 
> In that case setting policy->max to 1/2 of cpuinfo.max_freq would
> cause schedutil to choose 1/4 of cpuinfo.max_freq for 50% utilization
> which would be rather unexpected.
> 
> policy->max is a cap, not the current maximum capacity.
> 
> > Like you mentioned above same
> > utilization will relate to different frequencies depending on the
> > maximum frequency.
> 
> Which is not how it is expected (and defined) to work, though.
> 
> If you really want to play with the current maximum capacity, you need
> to change it whenever boost is disabled or enabled - and there is a
> mechanism for updating cpufinfo.max_freq in such cases.

I don't see why we would want to change max capacity on the fly. It is
not a cheap operation as we would need to normalize the capacity for all
CPUs if the CPU(s) with capacity = 1024 changes its capacity. Worst case
we even have to rebuild the sched_domain hierarchy to update flags. The
update would also temporarily mess with load and utilization signals, so
not a cheap operation.

Morten
