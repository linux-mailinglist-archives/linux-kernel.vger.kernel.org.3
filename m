Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE1C4794C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbhLQT0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:26:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52570 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhLQT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:26:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3E156239F;
        Fri, 17 Dec 2021 19:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD0C36AEB;
        Fri, 17 Dec 2021 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639769208;
        bh=q4A6FOrAjt+9yJyIW72MlxzbcUDgGkya1ZyqIB30WAI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mqisCfIoiBjl3L5i8Bm9MJlJYM4U2vL92cBeZhja2u3GNo+mnzckIj60IksNpey3z
         2Gc6BCyrZbqDSWn6F7G4I+XJ4s4cVKe7Z8dJVTAK/dh+g7ali3u6M3yKf87fszmRnw
         1C1o96QmASYU9yjDz4vyP0XdL85BeQmr4RmYDmPj21RspG10TXKhULxATmX90yDOBC
         BqsrxJ5KWidR8bNBCDnsNakG782j7NqdWIyMx5fa0bv5Dn6TDiZmXoTjuRskrvThiN
         MaraAg+JChjgIct/xs2OGXcsEDuQQuwN/v0yFwyAJugML0Rn+EJ/E0gepttPgJBCXP
         FOfH3+b4q4b0Q==
Received: by mail-ed1-f41.google.com with SMTP id o20so11666869eds.10;
        Fri, 17 Dec 2021 11:26:48 -0800 (PST)
X-Gm-Message-State: AOAM530S5dUX8Z2l8sNar+kXANrzws7gwoCNDf1hyD8w2pWru2h2I+7X
        qSFMROAGFSvmO/ZGY/A5wPo2btNSrjPYLs4HMw==
X-Google-Smtp-Source: ABdhPJxLmBWRFwTGdLwwAfMX41a2Q9rdqcof3g8cm16c6yUU7u3j0zx5JfIEdiqHIz9RYqlrsqwAXKleK7gzFIWQU6U=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr4101222edx.306.1639769206410;
 Fri, 17 Dec 2021 11:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20211216233125.1130793-1-robh@kernel.org> <20211216233125.1130793-3-robh@kernel.org>
 <881f056d-d1ed-c6de-c09d-6e84d8b14530@arm.com> <CAL_JsqKKx5-ep5=FVA5OHM+t=T-9GTuf6Sf9P6ZDUs7RD9=c8g@mail.gmail.com>
 <20211217190345.kskfhnelqg3yx4j7@bogus>
In-Reply-To: <20211217190345.kskfhnelqg3yx4j7@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 17 Dec 2021 13:26:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJSz7D_KO_ueQum51erBHotMkAt+qJfTTctkxSvySWq1w@mail.gmail.com>
Message-ID: <CAL_JsqJSz7D_KO_ueQum51erBHotMkAt+qJfTTctkxSvySWq1w@mail.gmail.com>
Subject: Re: [PATCH 2/6] cacheinfo: Set cache 'id' based on DT data
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 1:03 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Dec 17, 2021 at 12:14:22PM -0600, Rob Herring wrote:
> > On Fri, Dec 17, 2021 at 10:57 AM Robin Murphy <robin.murphy@arm.com> wr=
ote:
> > >
> > > Hi Rob,
> > >
> > > On 2021-12-16 23:31, Rob Herring wrote:
> > > > Use the minimum CPU h/w id of the CPUs associated with the cache fo=
r the
> > > > cache 'id'. This will provide a stable id value for a given system.=
 As
>
> I am trying to follow the code. IIUC, the level one(I$ and D$) are skippe=
d
> in this logic and the private unified cache if any will get the cpu hwid =
as
> the cache id which is all fine. But what happens if there are 2 levels of
> unified private cache ? I am assuming we only care about shared caches fo=
r
> MPAM and ignore private caches which sounds OK but I just wanted to confi=
rm.

The cacheinfo 'id' is only unique to the level and type. It's the
type, level, and ID that gives a unique identifier:

 * struct cacheinfo - represent a cache leaf node
 * @id: This cache's id. It is unique among caches with the same (type, lev=
el).

Maybe ACPI's ID expects/allows globally unique cache IDs?

> > > > we need to check all possible CPUs, we can't use the shared_cpu_map
> > > > which is just online CPUs. There's not a cache to CPUs mapping in D=
T, so
> > > > we have to walk all CPU nodes and then walk cache levels.
>
> I would have preferred to add the cache IDs in DT similar to ACPI but I s=
ee
> you have certain concerns with that which are valid as well.
>
> > >
> > > I believe another expected use of the cache ID exposed in sysfs is to
> > > program steering tags for cache stashing (typically in VFIO-based
> > > userspace drivers like DPDK so we can't realistically mediate it any
> > > other way). There were plans afoot last year to ensure that ACPI PPTT
> > > could provide the necessary ID values for arm64 systems which will
> > > typically be fairly arbitrary (but unique) due to reflecting underlyi=
ng
> > > interconnect routing IDs. Assuming that there will eventually be some
> > > interest in cache stashing on DT-based systems too, we probably want =
to
> > > allow for an explicit ID property on DT cache nodes in a similar mann=
er.
> >
> > If you have a suggestion for ID values that correspond to the h/w,
> > then we can add them. I'd like a bit more than just trusting that ID
> > is something real.
> >
>
> I agree, probably architecture must do better job at defining these. But
> generated IDs IMO might cause issues especial if we have to change the
> logic without breaking the backward compatibility.
>
> > While the ACPI folks may be willing to take an arbitrary index, it's
> > something we (mostly) avoid for DT.
> >
>
> Not sure if we can call that *arbitrary* =F0=9F=98=84, in that case we ca=
n imagine
> the same at several places in the firmware.

By arbitrary, I mean made up by the binding/dts author or
documentation convention (UART0, UART1, etc.). Certainly things like
clock IDs are often made up number spaces, but I don't see how we
avoid that. DT had 'cell-index' which I still see attempted. But that
property traces back to h/w having a single power ctrl register and
cell-index was the bit index for the register. If only h/w was still
that simple.

Rob
