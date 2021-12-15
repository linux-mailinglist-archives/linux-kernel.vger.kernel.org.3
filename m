Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51AE7475DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbhLOQw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbhLOQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:52:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0B1C061574;
        Wed, 15 Dec 2021 08:52:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28815619C2;
        Wed, 15 Dec 2021 16:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854C2C36AE3;
        Wed, 15 Dec 2021 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639587142;
        bh=gu0NXiWUgDFrZg3yWV6zoqWRSOaEF70afmPFo6FWlQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ljs1hvcckUbQFv0LK09hIboci+KQM8lTnjHwDkGdTg/Bi1ErCsAiz9oGY2aKsOlf6
         BZmX5h0V9CaHsRrJIHDUsRumrttZZt91MFx5Su+xWaU57ct8SJybjJvDrNiR8w/dIv
         ITwrQ1MTakn/0zokQLYV98Dibn/696m1H1R5cjdvm0jjaVl9pxgj6attGZ7662bOb4
         L7+mRd4AvgV8b45klMvjrFJ0cTfBhOhN50LPe1Z1CTNLSH0/9OBA8Yie+xgQa8Q7Go
         M/NgSmKUB+oMV+p9zmA5nAXrHJEAp196laSwWNkavPdSsaf33lmHauNAv3fGXDp5Mt
         /49rDGnrup59A==
Received: by mail-yb1-f178.google.com with SMTP id 131so56820928ybc.7;
        Wed, 15 Dec 2021 08:52:22 -0800 (PST)
X-Gm-Message-State: AOAM5310pdtVX1TNndFV/DkI8pP0gcfNFUYeK2mrZlHxdgb3HUm7YyFq
        H8PqFVjxaKUoJ02tIlPAji5lmr/8HQ0zNo6U6RQ=
X-Google-Smtp-Source: ABdhPJyCKdltBMj18edFZ70YAKPO+yqbXdbg2IBe3ocP+p2sHYq63xHpS9x6KF3kkF3DZIlsllj8zdXHeOpL+yVHo3Q=
X-Received: by 2002:a25:8284:: with SMTP id r4mr7725979ybk.47.1639587141669;
 Wed, 15 Dec 2021 08:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20211214031553.16435-1-yajun.deng@linux.dev> <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
 <0d07e13a5454dfb03b22e5223d101a1b@linux.dev>
In-Reply-To: <0d07e13a5454dfb03b22e5223d101a1b@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Wed, 15 Dec 2021 08:52:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6T_nqqfOtj_dVn9KV+iUbki2X3WU3pxfo25Ewj3i5ZjA@mail.gmail.com>
Message-ID: <CAPhsuW6T_nqqfOtj_dVn9KV+iUbki2X3WU3pxfo25Ewj3i5ZjA@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
To:     yajun.deng@linux.dev
Cc:     stockhausen@collogia.de, open list <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, masahiroy@kernel.org,
        williams@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 6:14 PM <yajun.deng@linux.dev> wrote:
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
> T: 0 ( 3092) P:95 I:1000 C:   8514 Min:      1 Act:    2 Avg:    1 Max:  =
     6
> T: 1 ( 3093) P:95 I:1000 C:   8511 Min:      1 Act:    2 Avg:    1 Max:  =
    14

I am not very familiar with the RT work, so please forgive me for some
rookie questions.

From the result, I think the CONFIG_PREEMPT_VOLUNTARY=3Dy and the
CONFIG_PREEMPT=3Dy cases failed to preempt during the preempt enabled perio=
d in
raid6_choose_gen(). Is this expected?

OTOH, the 16ms latency with CONFIG_PREEMPT_RT=3Dy is more or less expected.
Is this acceptable? If not, is 1ms latency acceptable?

Thanks,
Song


[...]
