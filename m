Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B8D479481
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbhLQTDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:03:52 -0500
Received: from foss.arm.com ([217.140.110.172]:33588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235807AbhLQTDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:03:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 880B812FC;
        Fri, 17 Dec 2021 11:03:50 -0800 (PST)
Received: from bogus (unknown [10.57.36.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 914A53F774;
        Fri, 17 Dec 2021 11:03:48 -0800 (PST)
Date:   Fri, 17 Dec 2021 19:03:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/6] cacheinfo: Set cache 'id' based on DT data
Message-ID: <20211217190345.kskfhnelqg3yx4j7@bogus>
References: <20211216233125.1130793-1-robh@kernel.org>
 <20211216233125.1130793-3-robh@kernel.org>
 <881f056d-d1ed-c6de-c09d-6e84d8b14530@arm.com>
 <CAL_JsqKKx5-ep5=FVA5OHM+t=T-9GTuf6Sf9P6ZDUs7RD9=c8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKKx5-ep5=FVA5OHM+t=T-9GTuf6Sf9P6ZDUs7RD9=c8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:14:22PM -0600, Rob Herring wrote:
> On Fri, Dec 17, 2021 at 10:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > Hi Rob,
> >
> > On 2021-12-16 23:31, Rob Herring wrote:
> > > Use the minimum CPU h/w id of the CPUs associated with the cache for the
> > > cache 'id'. This will provide a stable id value for a given system. As

I am trying to follow the code. IIUC, the level one(I$ and D$) are skipped
in this logic and the private unified cache if any will get the cpu hwid as
the cache id which is all fine. But what happens if there are 2 levels of
unified private cache ? I am assuming we only care about shared caches for
MPAM and ignore private caches which sounds OK but I just wanted to confirm.

> > > we need to check all possible CPUs, we can't use the shared_cpu_map
> > > which is just online CPUs. There's not a cache to CPUs mapping in DT, so
> > > we have to walk all CPU nodes and then walk cache levels.

I would have preferred to add the cache IDs in DT similar to ACPI but I see
you have certain concerns with that which are valid as well.

> >
> > I believe another expected use of the cache ID exposed in sysfs is to
> > program steering tags for cache stashing (typically in VFIO-based
> > userspace drivers like DPDK so we can't realistically mediate it any
> > other way). There were plans afoot last year to ensure that ACPI PPTT
> > could provide the necessary ID values for arm64 systems which will
> > typically be fairly arbitrary (but unique) due to reflecting underlying
> > interconnect routing IDs. Assuming that there will eventually be some
> > interest in cache stashing on DT-based systems too, we probably want to
> > allow for an explicit ID property on DT cache nodes in a similar manner.
> 
> If you have a suggestion for ID values that correspond to the h/w,
> then we can add them. I'd like a bit more than just trusting that ID
> is something real.
>

I agree, probably architecture must do better job at defining these. But
generated IDs IMO might cause issues especial if we have to change the
logic without breaking the backward compatibility.

> While the ACPI folks may be willing to take an arbitrary index, it's
> something we (mostly) avoid for DT.
>

Not sure if we can call that *arbitrary* 😄, in that case we can imagine
the same at several places in the firmware.

> > That said, I think it does make sense to have some kind of
> > auto-generated fallback scheme *as well*, since I'm sure there will be
> > plenty systems which care about MPAM but don't support stashing, and
> > therefore wouldn't have a meaningful set of IDs to populate their DT
> > with. Conversely I think that might also matter for ACPI too - one point
> > I remember from previous discussions is that PPTT may use a compact
> > representation where a single entry represents all equivalent caches at
> > that level, so I'm not sure we can necessarily rely on IDs out of that
> > path being unique either.
> 
> AIUI, cache ids break the compact representation.
>

IIRC, a note was added to avoid compaction if an implementation requires
any cache instance to be referenced uniquely.

-- 
Regards,
Sudeep
