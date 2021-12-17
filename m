Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F7479675
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhLQVnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhLQVnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:43:46 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E753C06173F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:43:46 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id p2so6770924uad.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc
         :content-transfer-encoding;
        bh=dLRIfMXscijVwX02/iyxcGJu9iZ9gntA3RrOduhrDRk=;
        b=Ec9FjGri2lsYplifRzflf6w9mo/K6pEenKg49x/3t3NzqywHiG7Nhubkl7Zn8G0OtN
         kBuszAqkpZ3kDZkFcTNn/5di4By/2PbsMtEyARbTas7jk6l4tIxSfF+DwjvH0IZSL15u
         nSJks+lY4zKgupvDgkanH4LkrfRsYURfK3GbO3948L9mNId/elXNtQ6t7JL+Mnp482jE
         Pu8bECHl0kLSWDBACLmRD/udOMnn5Qu58GbqRRIlWzrd7CC4Jnz69OB5aAtY7NutolVW
         NmWN9Vr8bOvR1t3BHQI3CJ/57TNPS5HoJArAlgpHAy1EHZQ5cU62K4nM0vsx/O7i7ozY
         13Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc:content-transfer-encoding;
        bh=dLRIfMXscijVwX02/iyxcGJu9iZ9gntA3RrOduhrDRk=;
        b=xdetVaSDkUE9h6UcaRXSH9Z/dbVbw/KSUQF3KQ4YbXEixS+J3whUe52AKp1Auhkwy0
         B0w1htNvStgACx4WLtcZJjr1QFF3poDUsE/KNkDet97vTe0W4DSePEm2+c8gB9lhdSnZ
         J4sFUgB1kKOD/FC62o4v9/+/xFEk6e46APVrj1wix+k9uGqbjUxk5mU8N9eGuf0DnleX
         IrJ7l0NgEp0OYhXSXQuPuUe2BHsmcF6Rrv0Kcznn4Llwcge+2x4nwBR2bKaDGSJ8Ili7
         tMaI8M0uLUwRJe0uBY3/jPZZqIXqpJeM8nN7VIa1RWd2MEj6MUDNS4mzfBkK2CsDSHor
         02XA==
X-Gm-Message-State: AOAM531J9sVPTlBtZJw2TJq5s2kLR4tVXjAeNfdFhLRcIKaUOWwl5RbN
        oYwuBfK6+ZckBB3xumU5+7KELEiLuhqlXLlCxmg=
X-Received: by 2002:a67:d78c:: with SMTP id q12mt2243499vsj.35.1639777425497;
 Fri, 17 Dec 2021 13:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20211214031553.16435-1-yajun.deng@linux.dev> <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <0d07e13a5454dfb03b22e5223d101a1b@linux.dev> <CAA7rmPEjdV32_2A8zR0OnbG+kG8EpB3XEnBP7dGSJUm0hpnABg@mail.gmail.com>
In-Reply-To: <CAA7rmPEjdV32_2A8zR0OnbG+kG8EpB3XEnBP7dGSJUm0hpnABg@mail.gmail.com>
From:   Daniel Vacek <neelx.g@gmail.com>
Date:   Fri, 17 Dec 2021 22:43:33 +0100
Message-ID: <CAA7rmPG7ktzQ1_Xn3hUiC8kfoMM5R=3JqaFsjjSfTH+H2u12Nw@mail.gmail.com>
Subject: Fwd: [PATCH] lib/raid6: fix abnormally high latency
Cc:     Song Liu <song@kernel.org>, stockhausen@collogia.de,
        open list <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>, masahiroy@kernel.org,
        williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is perfectly correct and expected result. Further explanation
follows down below.

On Wed, Dec 15, 2021 at 8:41 PM <yajun.deng@linux.dev> wrote:
>
> December 15, 2021 1:27 AM, "Song Liu" <song@kernel.org> wrote:
>
> > On Mon, Dec 13, 2021 at 7:17 PM Yajun Deng <yajun.deng@linux.dev> wrote=
:
> >
> >> We found an abnormally high latency when executing modprobe raid6_pq, =
the
> >> latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=3Dy, greate=
r than
> >> 67ms when CONFIG_PREEMPT=3Dy, and greater than 16ms when CONFIG_PREEMP=
T_RT=3Dy.
> >> This is caused by disable the preemption, this time is too long and
> >> unreasonable. We just need to disable migration. so used migrate_disab=
le()/
> >> migrate_enable() instead of preempt_disable()/preempt_enable(). This i=
s
> >> beneficial for CONFIG_PREEMPT=3Dy or CONFIG_PREEMPT_RT=3Dy, but no eff=
ect for
> >> CONFIG_PREEMPT_VOLUNTARY=3Dy.
> >>
> >> Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delta syndrome functions")
> >> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> >
> > We measure the speed of different RAID algorithms.If we don't disable
> > preempt, the result may be inaccurate, right? IIUC, we only disable pre=
empt
> > for 16 jiffies. Why do we see 1.2 second delay?
>
> Here are the command of my test=EF=BC=9A
> Execute "sudo cyclictest -S -p 95 -d 0 -i 1000 -D 24h -m" in one terminal=
 and "sudo modprobe raid6_pq" in the other terminal.
>
> Here are the results of my test=EF=BC=9A
> CONFIG_PREEMPT_VOLUNTARY=3Dy=EF=BC=8CCONFIG_HZ_250=3Dy
> T:17 ( 3109) P:95 I:1000 C:   7255 Min:      1 Act:    2 Avg:  170 Max: 1=
220832

No preemption is expected with this config so the CPU is busy and
occupied for full duration of all the benchmarks.

> CONFIG_PREEMPT=3Dy,CONFIG_HZ_250=3Dy
> T: 2 ( 2462) P:95 I:1000 C:  49024 Min:      1 Act:    2 Avg:    4 Max:  =
 67888

16 jiffies with 250 Hz equals to 64 ms. So again, this result is
perfectly expected. The benchmarks can be preempted in between the
individual measurements with preemptible kernel configuration.

> CONFIG_PREEMPT_RT=3Dy,CONFIG_HZ_1000=3Dy
> T: 6 ( 2561) P:95 I:1000 C:  25284 Min:      3 Act:    3 Avg:    4 Max:  =
 16593

16 jiffies by 1000 Hz is 16 ms. Ditto. So far so good.

The thing is the preemption disabled region is introduced here
precisely to guard the performance measurements and it cannot be
removed. The purpose is to ensure the measurements are protected from
external noise and hence the results are reliable and the best
performing implementation can be selected.
Changing it to migrate disable is incorrect. You can as well just
remove it completely as with preemption enabled (migrate disable does
not disable preemption) the benchmarks can be flawed with external
noise and the results are not reliable anymore.
In other words, the latency is desired here by design. Removing the
preemption disabled region is a BUG.

But really the main thing here is your test scenario is plain wrong.
It's a common misunderstanding that you should never see high latency
spikes. Sometimes you really should. There is an extended set of
operations which should be strictly avoided (with regards to latency
applications). Loading kernel modules is one example of them. It is
not considered a latency safe operation and hence it is not allowed in
production environment!

The application (or operator/the system configuration) should ensure
all the necessary modules are preloaded in setup phase before the
application workload is executed. Ie. before you start the cyclictest.

For example here, all the raid related modules *should* be loaded on
system boot. So that the initialization does not interfere with the
running production application.

Makes sense?

--nX

> >
> > Thanks,
> > Song
> >
> >> ---
> >> lib/raid6/algos.c | 8 ++++----
> >> 1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
> >> index 6d5e5000fdd7..21611d05c34c 100644
> >> --- a/lib/raid6/algos.c
> >> +++ b/lib/raid6/algos.c
> >> @@ -162,7 +162,7 @@ static inline const struct raid6_calls *raid6_choo=
se_gen(
> >>
> >> perf =3D 0;
> >>
> >> - preempt_disable();
> >> + migrate_disable();
> >> j0 =3D jiffies;
> >> while ((j1 =3D jiffies) =3D=3D j0)
> >> cpu_relax();
> >> @@ -171,7 +171,7 @@ static inline const struct raid6_calls *raid6_choo=
se_gen(
> >> (*algo)->gen_syndrome(disks, PAGE_SIZE, *dptrs);
> >> perf++;
> >> }
> >> - preempt_enable();
> >> + migrate_enable();
> >>
> >> if (perf > bestgenperf) {
> >> bestgenperf =3D perf;
> >> @@ -186,7 +186,7 @@ static inline const struct raid6_calls *raid6_choo=
se_gen(
> >>
> >> perf =3D 0;
> >>
> >> - preempt_disable();
> >> + migrate_disable();
> >> j0 =3D jiffies;
> >> while ((j1 =3D jiffies) =3D=3D j0)
> >> cpu_relax();
> >> @@ -196,7 +196,7 @@ static inline const struct raid6_calls *raid6_choo=
se_gen(
> >> PAGE_SIZE, *dptrs);
> >> perf++;
> >> }
> >> - preempt_enable();
> >> + migrate_enable();
> >>
> >> if (best =3D=3D *algo)
> >> bestxorperf =3D perf;
> >> --
> >> 2.32.0
