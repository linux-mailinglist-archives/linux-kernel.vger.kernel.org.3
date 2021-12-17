Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD644794E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbhLQTfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:35:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56556 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbhLQTfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:35:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E6F7623B6;
        Fri, 17 Dec 2021 19:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFFAC36AE2;
        Fri, 17 Dec 2021 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639769740;
        bh=49JVjD6zwdUgd/08zvEQfOxsegSwa4DYbJGk2AbsrWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YpKqjcLYZDuWu+9S56TOctkK7alGKYNB/jYJb6m+SmKUiKH8Fj4EmTPdCvLj6ta/A
         WgTqUOJuE+5brJF/bs0kPPIAoW/M5uAmLFWNKA2yAkRWQ7JWUodvZZVWnFbCeMT9kF
         EOyGOfoQNWYBMaIHdFcz7draYeBUowsjOunvHbUs4lYpu1eGtgE19AO0z8kx2w5udI
         hKtlGJK6vriNoed5SV6ZfndFOo6fl9sC1POlR9e7vJEmmFGKT5jpm7v6GSjqkXCX5w
         wJQbFxPuFth7mdNNP/+C6A3Cl3intfH+a9r1eQWTr251dL1qE/t9vqyJVSy3ijzhnW
         0l5uX+S0HSXjw==
Received: by mail-ed1-f54.google.com with SMTP id j21so7426016edt.9;
        Fri, 17 Dec 2021 11:35:40 -0800 (PST)
X-Gm-Message-State: AOAM530CJjtRSijIE02GO+E+muoyn0vw1YrKVN8yXni1VNtjtNa9hQyJ
        Pcw3/l0SHcKjgTTyK8lnxbcYOValqNo9+HrQLQ==
X-Google-Smtp-Source: ABdhPJzXJe97CgPyJwacb0b1CZCUoVrWsMBRUm6xjQXNcxxyQ+G6wArbn+I6DMnl0SCOvnOejFFRFTGezWEWpYl/k9c=
X-Received: by 2002:a05:6402:4251:: with SMTP id g17mr4252024edb.89.1639769738751;
 Fri, 17 Dec 2021 11:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20211216233125.1130793-1-robh@kernel.org> <20211216233125.1130793-3-robh@kernel.org>
 <881f056d-d1ed-c6de-c09d-6e84d8b14530@arm.com> <CAL_JsqKKx5-ep5=FVA5OHM+t=T-9GTuf6Sf9P6ZDUs7RD9=c8g@mail.gmail.com>
 <836fd983-463c-040d-beb3-fee3faf215d6@arm.com>
In-Reply-To: <836fd983-463c-040d-beb3-fee3faf215d6@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Dec 2021 13:35:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJM=dDxqEnnwbRLiemLS0XUqEe6RBZViLem8qoiDbPPjw@mail.gmail.com>
Message-ID: <CAL_JsqJM=dDxqEnnwbRLiemLS0XUqEe6RBZViLem8qoiDbPPjw@mail.gmail.com>
Subject: Re: [PATCH 2/6] cacheinfo: Set cache 'id' based on DT data
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 1:08 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-12-17 18:14, Rob Herring wrote:
> > On Fri, Dec 17, 2021 at 10:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> Hi Rob,
> >>
> >> On 2021-12-16 23:31, Rob Herring wrote:
> >>> Use the minimum CPU h/w id of the CPUs associated with the cache for the
> >>> cache 'id'. This will provide a stable id value for a given system. As
> >>> we need to check all possible CPUs, we can't use the shared_cpu_map
> >>> which is just online CPUs. There's not a cache to CPUs mapping in DT, so
> >>> we have to walk all CPU nodes and then walk cache levels.
> >>
> >> I believe another expected use of the cache ID exposed in sysfs is to
> >> program steering tags for cache stashing (typically in VFIO-based
> >> userspace drivers like DPDK so we can't realistically mediate it any
> >> other way). There were plans afoot last year to ensure that ACPI PPTT
> >> could provide the necessary ID values for arm64 systems which will
> >> typically be fairly arbitrary (but unique) due to reflecting underlying
> >> interconnect routing IDs. Assuming that there will eventually be some
> >> interest in cache stashing on DT-based systems too, we probably want to
> >> allow for an explicit ID property on DT cache nodes in a similar manner.
> >
> > If you have a suggestion for ID values that correspond to the h/w,
> > then we can add them. I'd like a bit more than just trusting that ID
> > is something real.
> >
> > While the ACPI folks may be willing to take an arbitrary index, it's
> > something we (mostly) avoid for DT.
>
> Not really. On the CHI side there are two fields - StashNID, which could
> be any node ID value depending on the interconnect layout, plus
> (optionally) StashLPID to address a specific cache within that node if
> it's something like a CPU cluster. However, how a PCIe TLP steering tag
> translates to those fields in the resulting CHI flit is largely up to
> the root complex.

Knowing next to nothing about CHI, this means pretty much nothing to me. :(

I would guess there is a bit more to supporting CHI in DT systems than
just a cache ID.

> I think it's going to be more like a "reg" property than a nice
> validatable index.
>
> >> That said, I think it does make sense to have some kind of
> >> auto-generated fallback scheme *as well*, since I'm sure there will be
> >> plenty systems which care about MPAM but don't support stashing, and
> >> therefore wouldn't have a meaningful set of IDs to populate their DT
> >> with. Conversely I think that might also matter for ACPI too - one point
> >> I remember from previous discussions is that PPTT may use a compact
> >> representation where a single entry represents all equivalent caches at
> >> that level, so I'm not sure we can necessarily rely on IDs out of that
> >> path being unique either.
> >
> > AIUI, cache ids break the compact representation.
>
> Right, firmware authors can't use it if they do want to specify IDs, but
> that also means that if we find we *are* consuming a compact PPTT, then
> chances are we're not getting meaningful IDs out of it for MPAM to rely on.

Sounds like broken firmware is in our future. ;) Or ACPI can default
to the same id scheme.

Rob
