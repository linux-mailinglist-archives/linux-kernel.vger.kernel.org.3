Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3134793A2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbhLQSOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:14:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49400 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhLQSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:14:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 717E662360;
        Fri, 17 Dec 2021 18:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB02CC36AEB;
        Fri, 17 Dec 2021 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639764875;
        bh=fDfjsiKClj8l5BPQYrleynPJWBgNe30LnZ5VqOldyMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KsDa9UrujiNscLmwitieTOYsx1aMEiWxwLIg/9X0W8DRp/7uWEoromcx1JbNhb8JL
         3Brk265D81bULlTzY2nA4RbmgI2upfefhSwSeWVpGqem0KW+IaDwiXW8p+m9KfUN/F
         0ZFpnlCBZez2w0FkS8M6gYXAzqeE7YcoEw7daeXQsV/Ht9OrS4JyRGvylLiVPmk7w/
         qTyJ8dwJ6EVbVW69l0ndYADTBp4jbFqIl2PF8AVYLuOkmZ/lnrL3pTvovx5rhia/HG
         uLIBp8NuUri7BrliqchGmpJz3kgA04hSXBxfAB81emSJRv/+skZ/G+L+kGkRVr5HWN
         985st7nDizmkw==
Received: by mail-ed1-f54.google.com with SMTP id b7so11007955edd.6;
        Fri, 17 Dec 2021 10:14:35 -0800 (PST)
X-Gm-Message-State: AOAM532PyPSKRFO12Fo0JaLQf9SzKj5lxltmKvj9rkRhcLPQ1JVgy49N
        re/+p++f4JyrHYAZpBrYGUPqjglsUdMdQQURug==
X-Google-Smtp-Source: ABdhPJyJDFeaigNXZBdGadznG3V/KXWaK7xMlTQRM2k9AN1d/4Q2rzCU2p6RLWWZg+/CKAXs3U5kWAhRg2Yk94NtO5w=
X-Received: by 2002:a17:906:5284:: with SMTP id c4mr3323018ejm.423.1639764874168;
 Fri, 17 Dec 2021 10:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20211216233125.1130793-1-robh@kernel.org> <20211216233125.1130793-3-robh@kernel.org>
 <881f056d-d1ed-c6de-c09d-6e84d8b14530@arm.com>
In-Reply-To: <881f056d-d1ed-c6de-c09d-6e84d8b14530@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Dec 2021 12:14:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKKx5-ep5=FVA5OHM+t=T-9GTuf6Sf9P6ZDUs7RD9=c8g@mail.gmail.com>
Message-ID: <CAL_JsqKKx5-ep5=FVA5OHM+t=T-9GTuf6Sf9P6ZDUs7RD9=c8g@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 10:57 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Rob,
>
> On 2021-12-16 23:31, Rob Herring wrote:
> > Use the minimum CPU h/w id of the CPUs associated with the cache for the
> > cache 'id'. This will provide a stable id value for a given system. As
> > we need to check all possible CPUs, we can't use the shared_cpu_map
> > which is just online CPUs. There's not a cache to CPUs mapping in DT, so
> > we have to walk all CPU nodes and then walk cache levels.
>
> I believe another expected use of the cache ID exposed in sysfs is to
> program steering tags for cache stashing (typically in VFIO-based
> userspace drivers like DPDK so we can't realistically mediate it any
> other way). There were plans afoot last year to ensure that ACPI PPTT
> could provide the necessary ID values for arm64 systems which will
> typically be fairly arbitrary (but unique) due to reflecting underlying
> interconnect routing IDs. Assuming that there will eventually be some
> interest in cache stashing on DT-based systems too, we probably want to
> allow for an explicit ID property on DT cache nodes in a similar manner.

If you have a suggestion for ID values that correspond to the h/w,
then we can add them. I'd like a bit more than just trusting that ID
is something real.

While the ACPI folks may be willing to take an arbitrary index, it's
something we (mostly) avoid for DT.

> That said, I think it does make sense to have some kind of
> auto-generated fallback scheme *as well*, since I'm sure there will be
> plenty systems which care about MPAM but don't support stashing, and
> therefore wouldn't have a meaningful set of IDs to populate their DT
> with. Conversely I think that might also matter for ACPI too - one point
> I remember from previous discussions is that PPTT may use a compact
> representation where a single entry represents all equivalent caches at
> that level, so I'm not sure we can necessarily rely on IDs out of that
> path being unique either.

AIUI, cache ids break the compact representation.

Rob
