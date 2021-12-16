Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E196476A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhLPGjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:39:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58800 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhLPGjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:39:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 911BC61C4B;
        Thu, 16 Dec 2021 06:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7A7C36AE4;
        Thu, 16 Dec 2021 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639636754;
        bh=9ekW8T7rECRSdH9mcR9emAXbvbK3+tPWosADU9c/Q0c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l3cFr0jvmgiH6GMDRrMtoRt//htTia8ZtcBjXT4Dzc6eOrJsNdj6+7HZdVifUh+fA
         H38Q3bBskbcOLjwp7NE8yl0sHBDvxiwJ0UKsWVudyQ7qGWiclZx7/MdhIE8cZ09bWn
         8YM23jCci38+MoolmmrYlydGWS7dEK2fDV/+7w89todP8XxwvBj8qWenblERDWgnci
         2zOzxHzEeQWrrLPw/KiCet6vcDt3UJfLeUjx7eGFevQE/inhiQQoKgn4ot/wAgNJQn
         rRGGTtH/SAjijWzzWk77+uxyR7FzmCqOHLWZ+UIWx7Sa0ZUq7DqHeDHJAECKYu9Bb9
         eyDnhuL7ilY5A==
Received: by mail-yb1-f179.google.com with SMTP id q74so61838601ybq.11;
        Wed, 15 Dec 2021 22:39:13 -0800 (PST)
X-Gm-Message-State: AOAM531qC3vAGZjTWm/5VztGS8sTDnWg74MZ/KQF9cDZNEaEzELeYHRZ
        fR8IMgQcgdgZW5/AqJjD39qUlFSeQ710HWCZayM=
X-Google-Smtp-Source: ABdhPJxJOEDDDN29qSAuDkFRYlwxtI0W6JN8uJ+VkPGSUJW9QC8sjTIMtxfdkVzNu6/R7SImws5V5841aY42c27nTY8=
X-Received: by 2002:a25:850b:: with SMTP id w11mr11631890ybk.208.1639636753098;
 Wed, 15 Dec 2021 22:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20211214031553.16435-1-yajun.deng@linux.dev> <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <0d07e13a5454dfb03b22e5223d101a1b@linux.dev> <CAPhsuW6T_nqqfOtj_dVn9KV+iUbki2X3WU3pxfo25Ewj3i5ZjA@mail.gmail.com>
 <3ed867e06f7f9bb9d89beaafc50905c8@linux.dev>
In-Reply-To: <3ed867e06f7f9bb9d89beaafc50905c8@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Wed, 15 Dec 2021 22:39:02 -0800
X-Gmail-Original-Message-ID: <CAPhsuW63KawpM0vBPo9gXjgELKMtUtsL0M4DkbwWZTkub2ZDSw@mail.gmail.com>
Message-ID: <CAPhsuW63KawpM0vBPo9gXjgELKMtUtsL0M4DkbwWZTkub2ZDSw@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     stockhausen@collogia.de, open list <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, masahiroy@kernel.org,
        williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 6:15 PM <yajun.deng@linux.dev> wrote:
>
> December 16, 2021 12:52 AM, "Song Liu" <song@kernel.org> wrote:
>
> > On Tue, Dec 14, 2021 at 6:14 PM <yajun.deng@linux.dev> wrote:
> >
> >> December 15, 2021 1:27 AM, "Song Liu" <song@kernel.org> wrote:
> >>
> >> On Mon, Dec 13, 2021 at 7:17 PM Yajun Deng <yajun.deng@linux.dev> wrot=
e:
> >>
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
> >>
> >> We measure the speed of different RAID algorithms.If we don't disable
> >> preempt, the result may be inaccurate, right? IIUC, we only disable pr=
eempt
> >> for 16 jiffies. Why do we see 1.2 second delay?
> >>
> >> Here are the command of my test=EF=BC=9A
> >> Execute "sudo cyclictest -S -p 95 -d 0 -i 1000 -D 24h -m" in one termi=
nal and "sudo modprobe
> >> raid6_pq" in the other terminal.
> >>
> >> Here are the results of my test=EF=BC=9A
> >> CONFIG_PREEMPT_VOLUNTARY=3Dy=EF=BC=8CCONFIG_HZ_250=3Dy
> >> T: 0 ( 3092) P:95 I:1000 C: 8514 Min: 1 Act: 2 Avg: 1 Max: 6
> >> T: 1 ( 3093) P:95 I:1000 C: 8511 Min: 1 Act: 2 Avg: 1 Max: 14
> >
> > I am not very familiar with the RT work, so please forgive me for some
> > rookie questions.
> >
> > From the result, I think the CONFIG_PREEMPT_VOLUNTARY=3Dy and the
> > CONFIG_PREEMPT=3Dy cases failed to preempt during the preempt enabled p=
eriod in
> > raid6_choose_gen(). Is this expected?
> >
>
> No, This is due to disable preemption causing ksoftirqd fail to schedule,=
 we can use bcc tools see that.
>
> > OTOH, the 16ms latency with CONFIG_PREEMPT_RT=3Dy is more or less expec=
ted.
> > Is this acceptable? If not, is 1ms latency acceptable?
> >
>
> Here are the test results after adding patch=EF=BC=9A
> CONFIG_PREEMPT=3Dy  or CONFIG_PREEMPT_RT=3Dy
> T: 0 ( 3167) P:95 I:1000 C:  13958 Min:      1 Act:    2 Avg:    1 Max:  =
     5
> T: 1 ( 3168) P:95 I:1000 C:  13956 Min:      1 Act:    2 Avg:    1 Max:  =
     7
> T: 2 ( 3169) P:95 I:1000 C:  13946 Min:      1 Act:    2 Avg:    1 Max:  =
    12
> T: 3 ( 3170) P:95 I:1000 C:  13951 Min:      1 Act:    2 Avg:    1 Max:  =
     5
> T: 4 ( 3171) P:95 I:1000 C:  13949 Min:      1 Act:    2 Avg:    1 Max:  =
     3
> T: 5 ( 3172) P:95 I:1000 C:  13947 Min:      1 Act:    2 Avg:    1 Max:  =
    16
> T: 6 ( 3173) P:95 I:1000 C:  13945 Min:      1 Act:    2 Avg:    2 Max:  =
     7
> T: 7 ( 3174) P:95 I:1000 C:  13942 Min:      1 Act:    2 Avg:    1 Max:  =
     3
> T: 8 ( 3175) P:95 I:1000 C:  13940 Min:      1 Act:    2 Avg:    1 Max:  =
     3
> T: 9 ( 3176) P:95 I:1000 C:  13938 Min:      1 Act:    1 Avg:    1 Max:  =
     3
> T:10 ( 3177) P:95 I:1000 C:  13936 Min:      1 Act:    2 Avg:    1 Max:  =
     6
> T:11 ( 3178) P:95 I:1000 C:  13933 Min:      1 Act:    2 Avg:    1 Max:  =
     3
> T:12 ( 3179) P:95 I:1000 C:  13931 Min:      1 Act:    2 Avg:    1 Max:  =
     4
> T:13 ( 3180) P:95 I:1000 C:  13929 Min:      1 Act:    2 Avg:    1 Max:  =
     7
> T:14 ( 3181) P:95 I:1000 C:  13927 Min:      1 Act:    2 Avg:    1 Max:  =
     6
> T:15 ( 3182) P:95 I:1000 C:  13925 Min:      1 Act:    2 Avg:    1 Max:  =
     4
> T:16 ( 3183) P:95 I:1000 C:  13923 Min:      1 Act:    2 Avg:    1 Max:  =
     5
> T:17 ( 3184) P:95 I:1000 C:  13921 Min:      1 Act:    2 Avg:    1 Max:  =
     5
> T:18 ( 3185) P:95 I:1000 C:  13919 Min:      1 Act:    2 Avg:    1 Max:  =
     4
> T:19 ( 3186) P:95 I:1000 C:  13916 Min:      1 Act:    2 Avg:    1 Max:  =
     4
> T:20 ( 3187) P:95 I:1000 C:  13914 Min:      1 Act:    2 Avg:    1 Max:  =
     4
> T:21 ( 3188) P:95 I:1000 C:  13912 Min:      1 Act:    2 Avg:    1 Max:  =
    10
> T:22 ( 3189) P:95 I:1000 C:  13910 Min:      1 Act:    2 Avg:    1 Max:  =
     5
> T:23 ( 3190) P:95 I:1000 C:  13908 Min:      1 Act:    2 Avg:    1 Max:  =
     5
> T:24 ( 3191) P:95 I:1000 C:  13906 Min:      1 Act:    2 Avg:    1 Max:  =
    18
> T:25 ( 3192) P:95 I:1000 C:  13904 Min:      1 Act:    2 Avg:    1 Max:  =
     7
> T:26 ( 3193) P:95 I:1000 C:  13902 Min:      1 Act:    2 Avg:    1 Max:  =
     5
> T:27 ( 3194) P:95 I:1000 C:  13900 Min:      1 Act:    1 Avg:    1 Max:  =
    11
> T:28 ( 3195) P:95 I:1000 C:  13898 Min:      1 Act:    2 Avg:    1 Max:  =
     3
> T:29 ( 3196) P:95 I:1000 C:  13896 Min:      1 Act:    2 Avg:    1 Max:  =
     5
> T:30 ( 3197) P:95 I:1000 C:  13894 Min:      1 Act:    2 Avg:    1 Max:  =
     4
> T:31 ( 3198) P:95 I:1000 C:  13892 Min:      1 Act:    2 Avg:    1 Max:  =
     3
>
> we can see the latency will not greater than 100us=EF=BC=8Cso 1ms latency=
 is also too long for CONFIG_PREEMPT=3Dy  or CONFIG_PREEMPT_RT=3Dy.
> use migrate_disable()/migrate_enable() instead of preempt_disable()/preem=
pt_enable() will not affect the speed of different RAID algorithms and the =
latency can be reduced to a reasonable range.

I think allowing preempt may still affect the speed comparison. But
such discrepancy
should be acceptable. I will apply this to md-next.

Thanks,
Song
