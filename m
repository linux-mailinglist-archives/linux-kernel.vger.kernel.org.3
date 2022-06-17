Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31354FD7D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiFQTZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiFQTZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:25:28 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9339E1CFE1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:25:27 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3137316bb69so51227547b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQMHAwyimoB61nebQlVxpPs4wt6e0dms7bbM7wg+b94=;
        b=eUoRJb6d0zusXWkcQUyWO/SswYusNZWESJhnSpmi/+80sIw/By+fzNthm6cu1evOyp
         VJXsFHYL/drSHz98D1/t8LaIxkldrFE023gWiQexpHwAzrUyoPtcwL+vNWJ+SAADfKjo
         Bwq0SR5Hpc/WeE9GUSIeCH083JD0Ba4uE47yJdYBgKx5Obqo4MO2qdU2Xg4T8JmAwmly
         UXxYWqB1ZyPMf+/tRga0LeWt9xe/lIvmNpeSx0i9hYf6jW+EH/Yhl9laPgUXZ1EZAaXZ
         Zjv+tw2uTbptGFkIDgZwt5jKZMvRaJCq0BdD5MjkV5/PioJttlbZGu/6UEX6dKDd8Kk2
         4pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQMHAwyimoB61nebQlVxpPs4wt6e0dms7bbM7wg+b94=;
        b=jk5NIoPOr09begw2pNIrZVyU81znaMutApDI4ceFyTn7yCA/3mlIcLQTHO0sjzgEEe
         F3xgaqHmtdnOp1U6mkyPVv7uGsDmssarTMivvy5fG74mCFKwlxrsb22K+OwNMQkwVtbg
         SSO/E0SlwOYy5u3tPwJgffi9hFmy+3ZGHKLDk76Wa9PlunEjsibwRHpxmne2MgKZgS2V
         E7nAzkHVEoArSlPmbpXiYk6cA0skfvMEhAen8foukXDJDqI3FOC1kD7mPfpBWGC1t3ix
         WMo6i4ORO252b6cC1HwqtcKALidweUMO1di0JDN1nN6u6pQSKgc/j81OjX1pwe4FPNFd
         Bmrw==
X-Gm-Message-State: AJIora95qgypjyugJXAXXRdm6VchfxTVRHPyoiJao1gnKcNZeMFwId1H
        /69CKbVdlszpROdgkYeJc8KO2CrVvzEKd1Zcb9YigcoE07qTPg==
X-Google-Smtp-Source: AGRyM1sHeyJb0EIeZfb2ofC9Ge2bRnvz6z7EVqS16b1/GtH0W8Vy+HZTXXZ0mgTvdSwtLAFZroyCdQ7RRRIZNwycfYI=
X-Received: by 2002:a81:3a81:0:b0:317:7dcf:81d4 with SMTP id
 h123-20020a813a81000000b003177dcf81d4mr6319611ywa.47.1655493926519; Fri, 17
 Jun 2022 12:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com> <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com> <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
 <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net> <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
 <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Jun 2022 21:25:15 +0200
Message-ID: <CANn89i+wBM+ewcP9u+ZWDqv3zQeK7ovKB+YJf9S6Om5QkqhLHA@mail.gmail.com>
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

On Fri, Jun 17, 2022 at 9:19 PM Linus Torvalds
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

Interesting...

 I think getrusage(RUSAGE_SELF) is blocking interrupts in the
possible long loop:

do {
      accumulate_thread_rusage(t, r);
} while_each_thread(p, t);



>
> I suspect eventpoll just did the wrong thing.
>
>               Linus
