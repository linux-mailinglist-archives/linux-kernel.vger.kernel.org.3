Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA56154FDB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbiFQTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiFQTew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:34:52 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C06F583BE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:34:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gd1so4703177pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BisD5N5Oey4CH21DOLbixSSBEHfSu6Pz0cxd7oqB4tI=;
        b=D5xG+liRbXbK7mctm5XQdwF1hnzDTTVGtQrtLEye1sxucuCY1fZ7400T/G3S8QDgMO
         /app8NIRRFF28jGE5PXJchtd0iKbWu6l7HKMx/OsCZkDCjcZhFT29+ygAOIZvVwrkrYT
         Mwjp5iMhRmqHfvNKasceMsLOf0kjatocgE7KAU8Vi3QBIqjXbL+Pz3L3kNVmXkWzbRfX
         9T5whP1i9LcEfeqkhS3ciNmZnKEkeqGxInlLuM8jD2Cbp2i4zOkPS368170LMBA0nYA/
         C9Ce2KlwFdbAFu0pTMMU721b6BXZMQrPAv6mVq0JEugssEZCCl1wtRJkCJS4VAy8HBsx
         cRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BisD5N5Oey4CH21DOLbixSSBEHfSu6Pz0cxd7oqB4tI=;
        b=Jn/e6PQ3wchvhhuy8ZmRJ2tfHrI6pfHChIOb4moIxYwgi6XTA3WglMARO/JV1czbs8
         it7DpNMLp/tUfe10GhYbBQMdGKxvyFpldrB1uIsqOPXAIG1CuLmD7ZPwWCo8ndcTWqun
         0+fZaT25m13jOjs92jn7iEaw0uOaSlI+40NH3vdYi1VB0H+mBrASVOyoPI/0XeoAEBlA
         ZRY5oqIWhBZH/V5kApYSclRXa0PA8j1/kdWdcvJ7kxwDMpsatskCoQSpIaggJLTTQpFq
         Y6SFHajDJQtSPHp17xfBx5A/86CTFP6KS2+szGYd8d+SgbfVOqCQeiELuU6Ig3jVeMyn
         GdzA==
X-Gm-Message-State: AJIora9tJ0HmXYQxCCZqa9FYVinv3Pb8w7VEbbnM58WgZeezTy/oMJCo
        cLr83a2I0kcwSvG3iTPhs1CCpiuJr5CuWglC++qo4A==
X-Google-Smtp-Source: AGRyM1tCHqaeXUcNi7jyOkwzwiNLa0pSLKKCGa8pz82pIDmTfHgSgU4SEYmCPIIHAVFUt7pORqwIYXw+j3XVgfFLx30=
X-Received: by 2002:a17:902:ba8d:b0:168:ff8f:c1f with SMTP id
 k13-20020a170902ba8d00b00168ff8f0c1fmr10823107pls.6.1655494491195; Fri, 17
 Jun 2022 12:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com> <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com> <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
 <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net> <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
 <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Jun 2022 12:34:40 -0700
Message-ID: <CALvZod4CTHV=M7SmzByNymLWAJKxXg2YNXg=7gFxOhs37UsSsA@mail.gmail.com>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
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

On Fri, Jun 17, 2022 at 12:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Jun 17, 2022 at 2:10 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > So I wonder why we replaced eventpoll spinlock with an rwlock.
>
> Yeah, usually we've actually gone the other way.
>
> Spinning rwlocks are seldom a big win, unless you can get some
> secondary indirect win out of them.
>
> That secondary win is often:
>
>  (a) unfairness is usually very good for throughput (iow, the very
> unfairness that you hit may *be* the reason why it looked good in some
> benchmark, and people decided "ok, let's do this").
>
>  (b) the special case of "interrupts take the lock for reading only"
> thing that allows other readers to not disable interrupts
>
> IOW, the win of a spinning rwlock is not necessarily the "we allow
> multiple concurrent readers" that you'd expect, because if you have
> small sections of code you protect, that just isn't a big deal, and
> the costs are in the lock bouncing etc.
>
> It's also worth pointing out that rwlocks are only unfair *if* they
> hit that "reader from (soft)interrupt" case. Which means that such
> cases *really* had better either have very very short locked regions
> (with interrupts disabled), or they really need that (b) part above.
>
> And yes, the tasklist lock really needs the (b) part above. Disabling
> interrupts for task traversal would be completely and entirely
> unacceptable, because the traversal can actually be fairly expensive
> (lots and lots of threads).
>
> I suspect eventpoll just did the wrong thing.
>

In addition the commit log of commit a218cc491420 has this comment:
"(I assume that write side of a rwlock does not starve, it seems
qrwlock implementation has these guarantees)."

Since this assumption seems incorrect, is there any objection in
reverting the commit a218cc491420? Or do we need more
evidence/arguments/repro?
