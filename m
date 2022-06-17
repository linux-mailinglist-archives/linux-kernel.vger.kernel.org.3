Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6C554F9BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382932AbiFQO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiFQO6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:58:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA72513DED
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:58:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so4366178pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWtdrm84cofa37y/5Wk/OuCDbNuVtKJaXoVsA3BpW7U=;
        b=gIWqcVUsvuwkg+3zcqGL0SiF/T5r+/KT4xb2Hqm33+ecd2cCzCafq1bWpGQd2TKpga
         +DYu9GsUBDJ16Ys79OuVXNusJhcJ0ACi77++ld9crdO75VZ1t9HKxJwNwE+Oq4LLbvq0
         rjuD+zIMwvoBCWresnmgJ4dbvHTUePnXGdE45Gnvdg8WAgA2W2FV3bRm7HCs2JCxHBNJ
         tz9dPuVtXlqixShYsGw5bFM7VRg/2OMLWmW5IKVR5c149TBEp0b6/7Z08wPStZAuXCns
         qFpNNYbSJRA8sCiwQh5b6wbjjLlseZ06+GuGtw2WejYMs6c7vEEwTSTrmwYsY/PvDnLT
         Lmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWtdrm84cofa37y/5Wk/OuCDbNuVtKJaXoVsA3BpW7U=;
        b=XgNrsdl2QdMHo8xHC98YgBvbmeQwLGbIGzeLePSvFbioMEdcFQNdy/PbwPiRjgEXPZ
         Sna+++t2vvlvKGFTQSYIYyOzmEwRzbSN8h/f71hSIJ7A3T6K9tX3h23O2Fmxmh1E52fb
         nALC+gxyBxwVZp6icnpk3877p2wvnYj5P0lnJHdFWdabiGfMdgf79Lw+w8NqG7wYCJPu
         PENfgIDTQ9qdwfO4p8+xAE7VQuoRN/qGb3TvA9548k1Jeo5EI4h9FwPjFFmJQR4yftpV
         NqWVWnEoEAvqAh/7Q+3SH6Rf2uEV7gZI+M8302OyisGHQKjvzS/Z97I4U3hUwZbN+Ke8
         hGLQ==
X-Gm-Message-State: AJIora97369EKY6xB+qAITW8LCtY+TypQiaNYJbOtu3b9frbBN4WqNPv
        y5IoByANzaprDndChMUMpjIsf4a6hm3e7kLgZw3coA==
X-Google-Smtp-Source: AGRyM1tOut+UF+OvFzq5mQ2egyXO12IXbJ1UezsmcFbbGhqM5rwLjJ6YdheCyJv8dDtjjbeY3bJag+k5CZMf9nQhkC0=
X-Received: by 2002:a17:902:f68a:b0:167:52ee:2c00 with SMTP id
 l10-20020a170902f68a00b0016752ee2c00mr9991463plg.106.1655477884963; Fri, 17
 Jun 2022 07:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
In-Reply-To: <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Jun 2022 07:57:53 -0700
Message-ID: <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Roman Penyaev <rpenyaev@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 7:43 AM Waiman Long <longman@redhat.com> wrote:
>
> On 6/17/22 08:07, Peter Zijlstra wrote:
> > On Fri, Jun 17, 2022 at 02:10:39AM -0700, Eric Dumazet wrote:
> >> --- a/kernel/locking/qrwlock.c
> >> +++ b/kernel/locking/qrwlock.c
> >> @@ -23,16 +23,6 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
> >>      /*
> >>       * Readers come here when they cannot get the lock without waiting
> >>       */
> >> -    if (unlikely(in_interrupt())) {
> >> -            /*
> >> -             * Readers in interrupt context will get the lock immediately
> >> -             * if the writer is just waiting (not holding the lock yet),
> >> -             * so spin with ACQUIRE semantics until the lock is available
> >> -             * without waiting in the queue.
> >> -             */
> >> -            atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
> >> -            return;
> >> -    }
> >>      atomic_sub(_QR_BIAS, &lock->cnts);
> >>
> >>      trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
> > This is known to break tasklist_lock.
> >
> We certainly can't break the current usage of tasklist_lock.
>
> I am aware of this problem with networking code and is thinking about
> either relaxing the check to exclude softirq or provide a
> read_lock_unfair() variant for networking use.

read_lock_unfair() for networking use or tasklist_lock use?

> I think tasklist_lock
> isn't taken from softirq context, but I may be wrong. Providing a
> read_lock_unfair() will require quite a bit of work in the supporting
> infrastructure as well.
>
> Cheers,
> Longman
>
