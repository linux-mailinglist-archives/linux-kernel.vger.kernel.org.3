Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB8D54C034
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbiFODbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbiFODbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:31:05 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC74EDC5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:31:04 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l204so18302371ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vigeld65CL0SN6yz+TUV7phZIEBTM594whgcU4O9Tq0=;
        b=cbh5N9vZrOzrArx1r7lElQ6dOfbHyzkcC+XKhe05J8yj7B42NshNOzN3+5K/gPNxWa
         hio9scvKQ78f8X9UuvuPGO3mAh5YtXgArVHFjoqdEHuytZFdMil8WkUpAJlyFN8HxGOG
         xFYCRdyGpbS/I9UueW9t4ojGax/8ucR5kkDm+4S6nxaFevTny6TYtkhLn7hYrX9S6pCc
         GG5au9XN1cyamsjsIn/8aMOTu6qNAj77XMYGKBipPanpcXvDaP8UgZVKTBJpMcIba6dw
         aBzgI9SX88OBzcIm4eiGFPStVecT4SlH9z/mvwSvDsLogCSYx3gGaG+chxucS72nhNTH
         k1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vigeld65CL0SN6yz+TUV7phZIEBTM594whgcU4O9Tq0=;
        b=FFpyJdH/2Kt1bdD2J26TpZ9/T+VKcBVo9Mh9v/lDxuu1x2Vhg5C9yjXk8dlaZkZ3NT
         K0Y9M3soHO6SUCckAFtChpEkzjYYDfahm1d3ZFRDq613cY5kmY3Rhup6lfn3jsCZrxXH
         +UrE2PxoKYv1u6lKfKzYb69dtxKLNvxhn69HGXdXQmZN/U0z5gxi9oowubL8qi6aoPHy
         8/WvUP7xhR7pJrfc54u6qLtXbfuWDm9+vZKoXAlslNnxiJgt0IeOVSHithqCwSXINYB9
         C4Gu1OEYXdLSC12QhQ2m4NXaowBiseo2DcWqLdAHWB0KLu/WEyVZJ1kCb0w1TVzH5n3K
         Rh5g==
X-Gm-Message-State: AJIora9A82nENrSFJEZVbHdx9LaqX1KSN769i6TIn4fboRb3uTLlWAhm
        2BldGt3kZ5Rs6j0z4F0jKc8cXJF4i87eqxlqk9k=
X-Google-Smtp-Source: AGRyM1tz4e9RDBI7VVrR7qNP1lsk+P8mmG3Hd6lz28U3OXQ9cKA2rhHX9XYQV3pc6cP0V2rBDkNfLbNaX22mlkCDkIM=
X-Received: by 2002:a05:6902:28c:b0:664:85df:5f31 with SMTP id
 v12-20020a056902028c00b0066485df5f31mr8253009ybh.38.1655263863497; Tue, 14
 Jun 2022 20:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220614144443.6566-1-wuchi.zero@gmail.com> <YqiiC+4xES0DoV7X@kroah.com>
In-Reply-To: <YqiiC+4xES0DoV7X@kroah.com>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Wed, 15 Jun 2022 11:30:51 +0800
Message-ID: <CA+tQmHAJbqDenRE47OacSurF5HZ-XWHu6dRBf+A=UqbhiLomAA@mail.gmail.com>
Subject: Re: [PATCH] lib/klist: Remove mb() before wake_up_process
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexios.zavras@intel.com, allison@lohutok.net, armijn@tjaldur.nl,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B46=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C 22:58=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 14, 2022 at 10:44:43PM +0800, wuchi wrote:
> > Function wake_up_process always executes a general memory barrier,
> > so remove the mb() before it.
>
> Really?  On all systems?  I do not see that, where does it happen?
>
As I understand it, it is on all systems.  Please help correct the
mistake, thanks.

1. Follow  Documentation/memory-barriers.txt  line 2128 ~ 2278,
especially line 2187 ~ 2202 snippet:
        A general memory barrier is executed by wake_up() if it wakes
something up.
        If it doesn't wake anything up then a memory barrier may or may not=
 be
        executed; you must not rely on it. The barrier occurs before
the task state
        is accessed, in particular, it sits between the STORE to
indicate the event
        and the STORE to set TASK_RUNNING:
         CPU 1 (Sleeper)                                       CPU 2 (Waker=
)
        =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        set_current_state();                                   STORE
event_indicated
            smp_store_mb();                                   wake_up();
                STORE current->state                           ...
                <general barrier>
<general barrier>
[*1-1*]
         LOAD event_indicated                                  if
((LOAD task->state) & TASK_NORMAL)

            STORE task->state
        where "task" is the thread being woken up and it equals CPU
1's "current".

2. Follow code wake_up_process in kernel/sched/core.c
    wake_up_process
        try_to_wake_up
            ....
            raw_spin_lock_irqsave                   [*2-1*]
            smp_mb__after_spinlock                [*2-2*]
            ....

[*2-1*] and [*2-2*] will match [*1-1*], though smp_mb__after_spinlock
does nothing on most architectures,
but the architectures implement ACQUIRE with an smp_mb() after the
LL/SC loop, Following include/linux/spinlock.h
line 172 ~ 178.

3. Following lib/klist.c
klist_release and klist_remove conform to model "SLEEP AND WAKE-UP
FUNCTIONS" in  Documentation/memory-barriers.txt,
so we do as the patch show.

> > Signed-off-by: wuchi <wuchi.zero@gmail.com>
>
> We need a "real name" for commits.
>
> How did you test this patch?

Sorry, I didn't. Just found the mb before wake_up_process could be
remove when reading the code,
Maybe you can view this as a question I asked.

thanks for your time
