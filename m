Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3E757098D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiGKRyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiGKRyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:54:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E026732BA3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:54:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BB3DB81107
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA7CC34115
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:54:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CSgPGV0K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657562050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrpTq1Jbzt9uVswhoPG2nk96sgcF0oXEy9q7NFmCWLo=;
        b=CSgPGV0K6hdrM3JU0cFCErPHV5p+TqkONF8EJHpyLUHMhb+wfe+nBlYjaqGUbybjGpNAFv
        EmbD10pV1ERwYRXPK8Usr1kHKFCGNzR1slsKq6h0g6PALBgTTw5WW3BloM9KqZimMmkRRj
        upyP1BMP/00RIK040EgWdh2DwamqmNU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f5de3380 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 11 Jul 2022 17:54:09 +0000 (UTC)
Received: by mail-io1-f54.google.com with SMTP id l24so5606591ion.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:54:09 -0700 (PDT)
X-Gm-Message-State: AJIora97EVgYcdxudr+IBceJSEg8VknQ/thbNjE5yBq54VpPcgIDg6H5
        A9owhfx3qDJTxo7MzA4qbVEaq/MMcN9LhvPuSG4=
X-Google-Smtp-Source: AGRyM1vyuw0KYA356LvFmJxdezx4bAwE4cvSea1bV3LkxE2YkR2tcj9i/3mj9QOpHp4oibSDz2um99qSuG+1u/hArIU=
X-Received: by 2002:a02:664a:0:b0:33f:5310:35e1 with SMTP id
 l10-20020a02664a000000b0033f531035e1mr3856500jaf.214.1657562048815; Mon, 11
 Jul 2022 10:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <YrslT9h0whngMIhw@zx2c4.com> <20220628161441.892925-1-Jason@zx2c4.com>
 <YsLbggVXONPJcZsn@zx2c4.com>
In-Reply-To: <YsLbggVXONPJcZsn@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 11 Jul 2022 19:53:58 +0200
X-Gmail-Original-Message-ID: <CAHmME9qt9hUTgJQSdv3_Yzkc3e7H8OkhPSv_pUaXV_2AOA1S=g@mail.gmail.com>
Message-ID: <CAHmME9qt9hUTgJQSdv3_Yzkc3e7H8OkhPSv_pUaXV_2AOA1S=g@mail.gmail.com>
Subject: Re: [PATCH v3] signal: break out of wait loops on kthread_stop()
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Eric,

On Mon, Jul 4, 2022 at 2:22 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hey Eric,
>
> On Tue, Jun 28, 2022 at 06:14:41PM +0200, Jason A. Donenfeld wrote:
> > I was recently surprised to learn that msleep_interruptible(),
> > wait_for_completion_interruptible_timeout(), and related functions
> > simply hung when I called kthread_stop() on kthreads using them. The
> > solution to fixing the case with msleep_interruptible() was more simply
> > to move to schedule_timeout_interruptible(). Why?
> >
> > The reason is that msleep_interruptible(), and many functions just like
> > it, has a loop like this:
> >
> >         while (timeout && !signal_pending(current))
> >                 timeout =3D schedule_timeout_interruptible(timeout);
> >
> > The call to kthread_stop() woke up the thread, so schedule_timeout_
> > interruptible() returned early, but because signal_pending() returned
> > true, it went back into another timeout, which was never woken up.
> >
> > This wait loop pattern is common to various pieces of code, and I
> > suspect that the subtle misuse in a kthread that caused a deadlock in
> > the code I looked at last week is also found elsewhere.
> >
> > So this commit causes signal_pending() to return true when
> > kthread_stop() is called, by setting TIF_NOTIFY_SIGNAL.
> >
> > The same also applies to the similar kthread_park() functionality.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Cc: Kalle Valo <kvalo@kernel.org>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  kernel/kthread.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 3c677918d8f2..63d5a1f4cb93 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -661,12 +661,14 @@ int kthread_park(struct task_struct *k)
> >
> >       set_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
> >       if (k !=3D current) {
> > +             test_and_set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
> >               wake_up_process(k);
> >               /*
> >                * Wait for __kthread_parkme() to complete(), this means =
we
> >                * _will_ have TASK_PARKED and are about to call schedule=
().
> >                */
> >               wait_for_completion(&kthread->parked);
> > +             clear_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
> >               /*
> >                * Now wait for that schedule() to complete and the task =
to
> >                * get scheduled out.
> > @@ -704,8 +706,10 @@ int kthread_stop(struct task_struct *k)
> >       kthread =3D to_kthread(k);
> >       set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
> >       kthread_unpark(k);
> > +     test_and_set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
> >       wake_up_process(k);
> >       wait_for_completion(&kthread->exited);
> > +     clear_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
> >       ret =3D kthread->result;
> >       put_task_struct(k);
> >
> > --
> > 2.35.1
> >
>
> Is this more to the tune of what you had in mind in your message [1]?
>
> Jason
>
> [1] https://lore.kernel.org/lkml/877d51udc7.fsf@email.froward.int.ebieder=
m.org/

Paging again...

Jason
