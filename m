Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1F6570154
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiGKLyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiGKLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA5275C8;
        Mon, 11 Jul 2022 04:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C7866114C;
        Mon, 11 Jul 2022 11:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D45EC341CD;
        Mon, 11 Jul 2022 11:53:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="MzCw4sK9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657540414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=720mTc1nsSAPrwWFG+973FguSUx8/hicJxk0ef4PlVU=;
        b=MzCw4sK9qZsQsPPK1O23afqypc3QjfcYtfDr5Phr3bgH0rLukZ9+znNizqsFlom/dF4uHM
        4soBx2Yc2m42FPOdZLdHkwPe3k/XNSU4S8HNZlpaf7wFGsuXqBlhq4YjM4rCHDXACMn6jy
        KlLcwb0nbtXoBZIEdZBZhRwd3TtXWlw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f0912a61 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 11 Jul 2022 11:53:34 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id v1so2847305ilg.11;
        Mon, 11 Jul 2022 04:53:34 -0700 (PDT)
X-Gm-Message-State: AJIora9GZFVJ2OWd16ug+6eNkIayYvS4lF7xxZPYUPmBgAPuZX1PaIai
        68cSfPGyYKN1aD9xo4VjkKga5jxNO6lSme3ko5w=
X-Google-Smtp-Source: AGRyM1u5obHWevbMsvQU1IKF5fNjRTUaC3CDj1Mg81SozNPECyRaM6/1pfwyObSD0LHNocgSliRVj9L1FRR/H0CkoSw=
X-Received: by 2002:a05:6e02:164f:b0:2dc:6d38:ff8e with SMTP id
 v15-20020a056e02164f00b002dc6d38ff8emr5606184ilu.16.1657540412032; Mon, 11
 Jul 2022 04:53:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:20e5:0:0:0:0 with HTTP; Mon, 11 Jul 2022 04:53:31
 -0700 (PDT)
In-Reply-To: <xhsmho7xv512f.mognet@vschneid.remote.csb>
References: <Yrw5f8GN2fh2orid@zx2c4.com> <20220629114240.946411-1-Jason@zx2c4.com>
 <87v8s8ubws.fsf@kernel.org> <xhsmho7xv512f.mognet@vschneid.remote.csb>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 11 Jul 2022 13:53:31 +0200
X-Gmail-Original-Message-ID: <CAHmME9q8-1vpV9zFsKkawk+XFm96S6fmug7v-NPJNpQmRoe6-Q@mail.gmail.com>
Message-ID: <CAHmME9q8-1vpV9zFsKkawk+XFm96S6fmug7v-NPJNpQmRoe6-Q@mail.gmail.com>
Subject: Re: [PATCH v8] ath9k: let sleep be interrupted when unregistering hwrng
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Gregory Erwin <gregerwin256@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On 7/11/22, Valentin Schneider <vschneid@redhat.com> wrote:
> On 07/07/22 19:26, Kalle Valo wrote:
>> "Jason A. Donenfeld" <Jason@zx2c4.com> writes:
>>
>>> There are two deadlock scenarios that need addressing, which cause
>>> problems when the computer goes to sleep, the interface is set down, an=
d
>>> hwrng_unregister() is called. When the deadlock is hit, sleep is delaye=
d
>>> for tens of seconds, causing it to fail. These scenarios are:
>>>
>>> 1) The hwrng kthread can't be stopped while it's sleeping, because it
>>>    uses msleep_interruptible() instead of
>>> schedule_timeout_interruptible().
>>>    The fix is a simple moving to the correct function. At the same time=
,
>>>    we should cleanup a common and useless dmesg splat in the same area.
>>>
>>> 2) A normal user thread can't be interrupted by hwrng_unregister() whil=
e
>>>    it's sleeping, because hwrng_unregister() is called from elsewhere.
>>>    The solution here is to keep track of which thread is currently
>>>    reading, and asleep, and signal that thread when it's time to
>>>    unregister. There's a bit of book keeping required to prevent
>>>    lifetime issues on current.
>>>
>>> Reported-by: Gregory Erwin <gregerwin256@gmail.com>
>>> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>> Cc: Kalle Valo <kvalo@kernel.org>
>>> Cc: Rui Salvaterra <rsalvaterra@gmail.com>
>>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>>> Cc: stable@vger.kernel.org
>>> Fixes: fcd09c90c3c5 ("ath9k: use hw_random API instead of directly
>>> dumping into random.c")
>>> Link:
>>> https://lore.kernel.org/all/CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsFGTEj=
s0c00giw@mail.gmail.com/
>>> Link:
>>> https://lore.kernel.org/lkml/CAO+Okf5k+C+SE6pMVfPf-d8MfVPVq4PO7EY8Hys_D=
VXtent3HA@mail.gmail.com/
>>> Link: https://bugs.archlinux.org/task/75138
>>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>> ---
>>> Changes v7->v8:
>>> - Add a missing export_symbol.
>>>
>>>  drivers/char/hw_random/core.c        | 30 ++++++++++++++++++++++++----
>>>  drivers/net/wireless/ath/ath9k/rng.c | 19 +++++++-----------
>>>  kernel/sched/core.c                  |  1 +
>>>  3 files changed, 34 insertions(+), 16 deletions(-)
>>
>> I don't see any acks for the hw_random and the scheduler change, adding
>> more
>> people to CC. Full patch here:
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20220629114240=
.946411-1-Jason@zx2c4.com/
>>
>> Are everyone ok if I take this patch via wireless-next?
>>
>
> Thanks for the Cc.
>
> I'm not hot on the export of wake_up_state(), IMO any wakeup with
> !(state & TASK_NORMAL) should be reserved to kernel internals. Now, here
> IIUC the problem is that the patch uses an inline invoking
>
>   wake_up_state(p, TASK_INTERRUPTIBLE)
>
> so this isn't playing with any 'exotic' task state, thus it shouldn't
> actually need the export.
>
> I've been trying to figure out if this could work with just a
> wake_up_process(), but the sleeping pattern here is not very conforming
> (cf. 'wait loop' pattern in sched/core.c), AFAICT the signal is used to
> circumvent that :/

I don't intend to work on this patch more. If you'd like to ack the
trivial scheduler change (adding EXPORT_SYMBOL), that'd help, and then
this can move forward as planned. Otherwise, if you have particular
opinions about this patch that you want to happen, feel free to pick
up the patch and send your own revisions (though I don't intend to do
further review). Alternatively, I'll just send a patch to remove the
driver entirely. Hopefully you do find this ack-able, though.

Jason
