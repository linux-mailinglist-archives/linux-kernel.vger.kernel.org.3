Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C8A54FA2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382608AbiFQPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiFQPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:25:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951B727B3E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:25:10 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-317803b61e5so20285727b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gfVkrQT68IwynyaXCuoKWgqHSp1FfeiI6XkEqMD23bM=;
        b=nEk2YJrN2Akb15H5R4cnd5Rd8Q1b8BYl3IbLCzb3eUDRRVJBJk71W4ETNadoAgE1Pf
         /xS8Kz1dbGb22bByG9Df1TfSQyohEBouff2HgiFrbeQFj4+V+FLwTrR94kOg8V74zo9v
         iMXJOsQ/XPDLGL859oozekljIAvKyuvpcsF9swJjuUdUhB6RgzH0U5VGgYO2cRvG2cL7
         WU6HvfMOOOUjcmhXs+O7jaQQwCn550iRuTwQL+j20Tc+LAbwvpfja5CO1kJ7kf1e5rBS
         IgW4uo3cknQrbgNvkCP785ou5OXGoYAycjITKdPt1FZRbffgNHSxwiJDCpzUpDIpXOxa
         VoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gfVkrQT68IwynyaXCuoKWgqHSp1FfeiI6XkEqMD23bM=;
        b=OIeFgFQTsgoZkSdQbl3TXJFlnqP21kG4jVphpc67o41h649codAtSv3o+2wEk9yNhX
         ufHTuI7QpwOzTM/dGFqAgPO3uRzmyHnAqD1ymv1OHD6KHo+j5GxVKoQ1rjwKbpSwPR2p
         0Qih742AcG2y4oZ+QR7KOO9qGd3fs8L/IOOTF1rPcZeSFISTOarv3o98pYawLO/lM8lo
         WoqC602PYcgvLqiZyVHS5HtIvRalUy6I53yBY9Wc1pc3oGz7WmqO+SNVl5sDVDydqfLC
         MUCQ5D/jVgq1mRrDjQ1VB5RHHV/EfwdAy4wArhcLyqSSdngX16DjwNURFWqy9XldKkM1
         OFIQ==
X-Gm-Message-State: AJIora8eMHwRuOvnoTbDaQZSReejYlEMjGGcLxcDwuqS7UulV/FVuST1
        NxUkvfCB+dyiLy+kOf9WwPY/2iBxRkpftHkkyU9Sjw==
X-Google-Smtp-Source: AGRyM1s8gvXIb+dRnkdQG9WhAV9ttR6MjIF44LS8OVWSCXTKPYrDNkHu22WD47ZjkiVYAA854IS31tTioB6cqOFjk8k=
X-Received: by 2002:a81:e93:0:b0:317:8db7:aa8e with SMTP id
 141-20020a810e93000000b003178db7aa8emr1676593ywo.55.1655479509457; Fri, 17
 Jun 2022 08:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com> <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com>
In-Reply-To: <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Jun 2022 17:24:58 +0200
Message-ID: <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
To:     Waiman Long <longman@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Fri, Jun 17, 2022 at 5:00 PM Waiman Long <longman@redhat.com> wrote:
>
> On 6/17/22 10:57, Shakeel Butt wrote:
> > On Fri, Jun 17, 2022 at 7:43 AM Waiman Long <longman@redhat.com> wrote:
> >> On 6/17/22 08:07, Peter Zijlstra wrote:
> >>> On Fri, Jun 17, 2022 at 02:10:39AM -0700, Eric Dumazet wrote:
> >>>> --- a/kernel/locking/qrwlock.c
> >>>> +++ b/kernel/locking/qrwlock.c
> >>>> @@ -23,16 +23,6 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
> >>>>       /*
> >>>>        * Readers come here when they cannot get the lock without waiting
> >>>>        */
> >>>> -    if (unlikely(in_interrupt())) {
> >>>> -            /*
> >>>> -             * Readers in interrupt context will get the lock immediately
> >>>> -             * if the writer is just waiting (not holding the lock yet),
> >>>> -             * so spin with ACQUIRE semantics until the lock is available
> >>>> -             * without waiting in the queue.
> >>>> -             */
> >>>> -            atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
> >>>> -            return;
> >>>> -    }
> >>>>       atomic_sub(_QR_BIAS, &lock->cnts);
> >>>>
> >>>>       trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
> >>> This is known to break tasklist_lock.
> >>>
> >> We certainly can't break the current usage of tasklist_lock.
> >>
> >> I am aware of this problem with networking code and is thinking about
> >> either relaxing the check to exclude softirq or provide a
> >> read_lock_unfair() variant for networking use.
> > read_lock_unfair() for networking use or tasklist_lock use?
>
> I mean to say read_lock_fair(), but it could also be the other way
> around. Thanks for spotting that.
>

If only tasklist_lock is problematic and needs the unfair variant,
then changing a few read_lock() for tasklist_lock will be less
invasive than ~1000 read_lock() elsewhere....
