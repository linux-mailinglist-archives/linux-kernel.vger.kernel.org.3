Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485F958E196
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiHIVNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiHIVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:13:29 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E072861118
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 14:13:25 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-10cf9f5b500so15533024fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 14:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=lfraBYkcJOxafcZr1OmRW24wdCOHIUvf+ujVZLDt03M=;
        b=HmROjyprZIi+mKQNF24pr1uBVg0iKnr7qX0h/O5UXJYdc/2hd84TlvZfr7rUNrHA/z
         KGUcL060kK89XCV5m/bK/UWEnLrQVqLZMmzHFCGCPPnX50Z212X9S9Zo3G7kNHxw0qgG
         fvXOJ1KzUBXZkfGaN7GKewWvAhFpzr3Y8vytYOeIsanT9tled9t1jmURO0M69oUXjWpC
         sqIwAU6yIN17zArdVnVZDe0o/BLbgZ3jxfEwm0apcoh7c0RyLPbB2Zs33w2lVL7wbCf6
         vYJdQJG/TUlaggtukkkWpRr/Tpn+En9HzkL9yaZPK1/Q/a1RlLb4KgAX+vLTng46fdvi
         UYsQ==
X-Gm-Message-State: ACgBeo1CO9lSxA82xtbzry9Fddq0s2AMwpWoxMecepMVRw8nbZMLHZfI
        8wqvTwbvb9YUNfgI+2icnSWl2s6P21WMVDfMODI=
X-Google-Smtp-Source: AA6agR7z1vICJC12h0HtAW/YDghUslW80Kj4FbZzeW9nGlj0fY48uND8UW6uWArI6rAeKUBC8J2bDo9qcjzkTAW/3mA=
X-Received: by 2002:a05:6870:5b84:b0:10c:d1fa:2f52 with SMTP id
 em4-20020a0568705b8400b0010cd1fa2f52mr178967oab.92.1660079605147; Tue, 09 Aug
 2022 14:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220808175956.592707-1-namhyung@kernel.org> <7b1c463c-c912-ba08-bac4-99d45e45f7e1@redhat.com>
In-Reply-To: <7b1c463c-c912-ba08-bac4-99d45e45f7e1@redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 9 Aug 2022 14:13:14 -0700
Message-ID: <CAM9d7ciPHi27JwcCbCWAkHnFBn-6PRbpRjBJ1U=cfDN-UcthjA@mail.gmail.com>
Subject: Re: [PATCH] locking: Add __lockfunc to slow path functions
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 9, 2022 at 8:05 AM Waiman Long <longman@redhat.com> wrote:
>
> On 8/8/22 13:59, Namhyung Kim wrote:
> > So that we can skip the functions in the perf lock contention and other
> > places like /proc/PID/wchan.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >   kernel/locking/qrwlock.c   | 4 ++--
> >   kernel/locking/qspinlock.c | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> > index 2e1600906c9f..d2ef312a8611 100644
> > --- a/kernel/locking/qrwlock.c
> > +++ b/kernel/locking/qrwlock.c
> > @@ -18,7 +18,7 @@
> >    * queued_read_lock_slowpath - acquire read lock of a queued rwlock
> >    * @lock: Pointer to queued rwlock structure
> >    */
> > -void queued_read_lock_slowpath(struct qrwlock *lock)
> > +void __lockfunc queued_read_lock_slowpath(struct qrwlock *lock)
> >   {
> >       /*
> >        * Readers come here when they cannot get the lock without waiting
> > @@ -63,7 +63,7 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
> >    * queued_write_lock_slowpath - acquire write lock of a queued rwlock
> >    * @lock : Pointer to queued rwlock structure
> >    */
> > -void queued_write_lock_slowpath(struct qrwlock *lock)
> > +void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
> >   {
> >       int cnts;
> >
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index 65a9a10caa6f..2b23378775fe 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
> >    * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
> >    *   queue               :         ^--'                             :
> >    */
> > -void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> > +void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >   {
> >       struct mcs_spinlock *prev, *next, *node;
> >       u32 old, tail;
>
>
> For completeness, I think you should also add it to the
> __pv_queued_spin_unlock() and __pv_queued_spin_unlock_slowpath()
> function in kernel/locking/qspinlock_paravirt.h. Perhaps even the
> assembly code in arch/x86/include/asm/qspinlock_paravirt.h.

Thanks for your comment.  I'm not sure about the asm part, will this be enough?

--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -36,7 +36,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
  *   rsi = lockval           (second argument)
  *   rdx = internal variable (set to 0)
  */
-asm    (".pushsection .text;"
+asm    (".pushsection .spinlock.text;"
        ".globl " PV_UNLOCK ";"
        ".type " PV_UNLOCK ", @function;"
        ".align 4,0x90;"
