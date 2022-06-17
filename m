Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CBF54FDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbiFQTjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbiFQTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:39:17 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39A531513
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:39:15 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id u99so8841696ybi.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSqgzYhEhTmwCEZgsVFvzKQzzLPTMjzLV3IQghkxetY=;
        b=neswoRsAQx+DPNdXI7N2SPE05WwMU+uwfI85AVZh6CnkYRFLwKHV8ZmksHQqhHfuIx
         z0cv4zvkzCe020PpGv/LDF19hAEJdyXd7yK+qO8vYLfurg+p6neDChVW/6e/BWjHTZR6
         Q61wm/EXQewGecJDJiSpJp+r/vGl9MRttd8OgdHLNHMwYkoJVAnxDEPXpk2nmtOYy5Aq
         hvC9iJQCU0mvFP9tl6siWpukTWE8zNpCEHsujvoZJ/3VE8jCRzQxoMwVmF69WDQ8Wcjy
         yor2SgqP+hnOQXJf40kLOEK1RcWbTaxEPar/5c2mcT3SlauMqmh3pZKo2G4cXFW/12Gm
         sx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSqgzYhEhTmwCEZgsVFvzKQzzLPTMjzLV3IQghkxetY=;
        b=XRnich4Yigf7gCwX3aArA+cCj3J2PfbY6KiNMrIg2QVZQPQzIAqClS2nh8/JK/t09t
         is+O/lF30JxjCP2gRJgwB2Xk9f7oXPyOBVlnDIJTlzRWPgWK7eoZAEzFlb8MSxKPhcN/
         xLuIOjazu+8XvRUGKylZB+Hd9QXzhxFiEfHM3Aoe0qA95acKHOjQkTL8jFdS7+WeToR0
         kRb24mQv4unpceDzXgWc2D0TfJBzL/poaQ/lzcCn2KL1M85lETrMssMkNkPQ7j8fjlcw
         fnWiwuNjDeI8uYCXjjAyl2qKQMiLzM+w1kjG5GvIbMoAKH2T+Z5uGOKRGd44y/adFdTZ
         Wn3A==
X-Gm-Message-State: AJIora/fVq2T62SdQ7UvO75I2+g9JIoo/Aq22745kWGZCHUUVXk87qq7
        H9NCZRSwODz7Pic8YKGEmafOnH8q/Ypt8hAqVWw43Q==
X-Google-Smtp-Source: AGRyM1uTJYHzEb6jbhMK4VZbcJr10IsBP1JuFLAet7k0WsaObA+7k08tIH+87mb9YO8lSxTUbLq342fgIPulsyakhB0=
X-Received: by 2002:a25:8181:0:b0:668:c835:eb7c with SMTP id
 p1-20020a258181000000b00668c835eb7cmr3245468ybk.598.1655494754702; Fri, 17
 Jun 2022 12:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com> <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com> <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
 <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net> <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
 <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
 <CANn89i+wBM+ewcP9u+ZWDqv3zQeK7ovKB+YJf9S6Om5QkqhLHA@mail.gmail.com> <CAHk-=wi9ut1VkB=Ja_gYtH67DZ7cc5QBG-uJCPkOpU=MZDJSUw@mail.gmail.com>
In-Reply-To: <CAHk-=wi9ut1VkB=Ja_gYtH67DZ7cc5QBG-uJCPkOpU=MZDJSUw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Jun 2022 21:39:03 +0200
Message-ID: <CANn89iJXeUJRV2+8reUdaeARxYPPbCoG+9atmRFfy4kv0XX00A@mail.gmail.com>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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

On Fri, Jun 17, 2022 at 9:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jun 17, 2022 at 2:25 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > Interesting...
> >
> >  I think getrusage(RUSAGE_SELF) is blocking interrupts in the
> > possible long loop:
>
> Yeah, that looks bad.
>
> It needs that interrupt disable due to sighand->siglock, but normally
> we would expect to *not* have a big loop inside the siglock.
>
> Nasty.
>
> I wonder if this is possibly a situation where we should actually make
> siglock be a rwlock.
>
> But considering that this RUSAGE_SELF is hopefully a special case,
> maybe we could write it differently.
>
> Instead of taking the sighand lock, we might be able to iterate just
> over the regular thread list (using the tasklist lock), and then do
> the "does sighand match" as a one-off check in
> accumulate_thread_rusage().
>
> It's not like we even really need that strict locking there, I suspect.
>
> Anyway, I should have noted in my previous email that my "rwlock is
> often not the win you'd think it is" that that is only true for this
> *spinning* rwlock.
>
> For the actual sleeping reader-writer lock (down_read/down_write and
> friends), the whole "you can have multiple readers" is often a *huge*
> deal and very central to using a rwlock. It's literally just the
> spinning one that is often better as a spinlock unless you have those
> magical reasons to use it.
>

I am converting RAW sockets to RCU.

We will likely need to use RCU in place of rwlock in most networking code.
