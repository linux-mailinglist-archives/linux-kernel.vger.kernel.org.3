Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D174799D5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhLRJB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLRJB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:01:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3DEC061574;
        Sat, 18 Dec 2021 01:01:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 766E9B8076C;
        Sat, 18 Dec 2021 09:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E730C36AE1;
        Sat, 18 Dec 2021 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639818115;
        bh=6RXUUn4K4nJ+YC2rhvRjvYxs0DI6omBIIKV4HoXtehg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g8ZOmxkVO6qRgSizo+D0yGy5sxWWOdU2JeqyCT7GyM0PUIwNW7riYQb2Yogtj/1cF
         aksir2WvX5/eK2Qks9XbrmvJmo8J3WGd2bxTenFxM9hYFY/TQiJIz5ylGa4fRIkDzZ
         o5HSQ8duMiJim/du/kNKWCnG+Lnmyv5YfGtSOHFJQYx88WDEDXijiiyGiQXfUACVGX
         ZbNpnuIvXp6DzZFWw/cBfjqh0W/CNbDtmRHvoEwBtEH3Tf/yMQ9DD+TO1H4Lg0XluC
         iirUNUDJTvepyfK7f0F/+gGeRokT8PhUe0RG976muLFerH3dTMBkrDIxKHeG2Hr19F
         jQBJr5it6svFg==
Received: by mail-yb1-f178.google.com with SMTP id v138so13189986ybb.8;
        Sat, 18 Dec 2021 01:01:55 -0800 (PST)
X-Gm-Message-State: AOAM530YK+CFiyHd69W1ssSMung+16FfU4wApMDoP0WaFbTWFXM7JGjk
        YL480S45PoBtPtPKtIyWY1ifWCD4b+fhGbG2srk=
X-Google-Smtp-Source: ABdhPJwwC7EtrxRJX0YVrcshAR5srK8/AomDt+oJMwdMTybV9IZd2LV1YDqcXaSTSzFDWdj9K6BTRAQzWdh3jDAvVEI=
X-Received: by 2002:a25:3415:: with SMTP id b21mr10192490yba.282.1639818114115;
 Sat, 18 Dec 2021 01:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20211214031553.16435-1-yajun.deng@linux.dev> <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <0d07e13a5454dfb03b22e5223d101a1b@linux.dev> <CAA7rmPEjdV32_2A8zR0OnbG+kG8EpB3XEnBP7dGSJUm0hpnABg@mail.gmail.com>
 <CAA7rmPG7ktzQ1_Xn3hUiC8kfoMM5R=3JqaFsjjSfTH+H2u12Nw@mail.gmail.com>
In-Reply-To: <CAA7rmPG7ktzQ1_Xn3hUiC8kfoMM5R=3JqaFsjjSfTH+H2u12Nw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Sat, 18 Dec 2021 01:01:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7sOV8koFENP-dzfxvah+qu3QUq3FmY7dj_pOGJgcNxRg@mail.gmail.com>
Message-ID: <CAPhsuW7sOV8koFENP-dzfxvah+qu3QUq3FmY7dj_pOGJgcNxRg@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
To:     Daniel Vacek <neelx.g@gmail.com>
Cc:     stockhausen@collogia.de, open list <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>, masahiroy@kernel.org,
        williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 1:43 PM Daniel Vacek <neelx.g@gmail.com> wrote:
>
> Hello,
>
> This is perfectly correct and expected result. Further explanation
> follows down below.
>
> On Wed, Dec 15, 2021 at 8:41 PM <yajun.deng@linux.dev> wrote:
> >
> > December 15, 2021 1:27 AM, "Song Liu" <song@kernel.org> wrote:
> >
> > > On Mon, Dec 13, 2021 at 7:17 PM Yajun Deng <yajun.deng@linux.dev> wro=
te:
> > >
> > >> We found an abnormally high latency when executing modprobe raid6_pq=
, the
> > >> latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=3Dy, grea=
ter than
> > >> 67ms when CONFIG_PREEMPT=3Dy, and greater than 16ms when CONFIG_PREE=
MPT_RT=3Dy.
> > >> This is caused by disable the preemption, this time is too long and
> > >> unreasonable. We just need to disable migration. so used migrate_dis=
able()/
> > >> migrate_enable() instead of preempt_disable()/preempt_enable(). This=
 is
> > >> beneficial for CONFIG_PREEMPT=3Dy or CONFIG_PREEMPT_RT=3Dy, but no e=
ffect for
> > >> CONFIG_PREEMPT_VOLUNTARY=3Dy.
> > >>
> > >> Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delta syndrome functions"=
)
> > >> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > >
> > > We measure the speed of different RAID algorithms.If we don't disable
> > > preempt, the result may be inaccurate, right? IIUC, we only disable p=
reempt
> > > for 16 jiffies. Why do we see 1.2 second delay?
> >
> > Here are the command of my test=EF=BC=9A
> > Execute "sudo cyclictest -S -p 95 -d 0 -i 1000 -D 24h -m" in one termin=
al and "sudo modprobe raid6_pq" in the other terminal.
> >
> > Here are the results of my test=EF=BC=9A
> > CONFIG_PREEMPT_VOLUNTARY=3Dy=EF=BC=8CCONFIG_HZ_250=3Dy
> > T:17 ( 3109) P:95 I:1000 C:   7255 Min:      1 Act:    2 Avg:  170 Max:=
 1220832
>
> No preemption is expected with this config so the CPU is busy and
> occupied for full duration of all the benchmarks.
>
> > CONFIG_PREEMPT=3Dy,CONFIG_HZ_250=3Dy
> > T: 2 ( 2462) P:95 I:1000 C:  49024 Min:      1 Act:    2 Avg:    4 Max:=
   67888
>
> 16 jiffies with 250 Hz equals to 64 ms. So again, this result is
> perfectly expected. The benchmarks can be preempted in between the
> individual measurements with preemptible kernel configuration.
>
> > CONFIG_PREEMPT_RT=3Dy,CONFIG_HZ_1000=3Dy
> > T: 6 ( 2561) P:95 I:1000 C:  25284 Min:      3 Act:    3 Avg:    4 Max:=
   16593
>
> 16 jiffies by 1000 Hz is 16 ms. Ditto. So far so good.


Thanks for the explanation. I misread/misunderstood some of these results.
I dropped the patch from md-next.

Song
