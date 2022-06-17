Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D254FC5C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383231AbiFQRpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382906AbiFQRp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:45:29 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A8040A34
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:45:28 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id x38so8403881ybd.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xo0wsMMINA3yzwEwjW3AcAjNv+eHoppSo2cLcD394oo=;
        b=JxUZYGgYL8g39LB4vcWAvavYCfjZsgLPxPcTn0Jqb4g8gVEG2YD4e9f6Tf0aXGFoQj
         nCrgRoHibYFhsWdGIm63ah551nUOngi1IOAVkgFRzvTmTk1FK2u5JWavPnYmkdlD4sVH
         pgLJp5i4925lUJGzk8YIfM+CV+b328qJlRFFZcmbs9yZ9ouTJSvqhrxf6Gkf3LJtAfr/
         gIHCH+qKzfVNa8AWQKGd9SHl7OY7gnmsYqUQo+QwYYQT3/smcl3DOQqPbLCNugMyLRLl
         OfdLtEuIp7n0B7DntauqoKY4MaDZHWvsyDYFnGo508DzoRPIXjgr77hrLEha3TlXgrGh
         3VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xo0wsMMINA3yzwEwjW3AcAjNv+eHoppSo2cLcD394oo=;
        b=SEBMUCOy5fTo+lEfu6sLuClO8I30SxCHnFCroAnNYSma81yXz5TgZsp+Ns4sxAOU7o
         gCv7AmB8apCti3+e6/EuZyjHplg4R6NmtA6oBiUTNbiSlbXkX5aPWC0JUU16+Kih1oT+
         D7fQAMR742wGufM+r3u4LVgTVA/ASsNjU2q91SGiCCYUF2b4BkWNgzyknKCCfH4Ym9k3
         y1D9JyVwptyae0NICoYPlyrKeaG/mWPvSlY8ejyigqNFGJwu4upEagcK61Cw+IX9bHWd
         B7S+k80KLtpYvhU3lp/74Tw09jcCYQVnMoBJHP2uFJ4G6bjLJGTUL0BCvJtMQoej9yJ6
         UZJg==
X-Gm-Message-State: AJIora9rQBFcEfFUvCbSXfxdiuA2HfigKqXFnCOCf1s6wLcc2bpGRF56
        kNz8C/O5yIQcU3jUSJONJwKNxSaPZJP5zVQpXetRYA==
X-Google-Smtp-Source: AGRyM1tqmV7KFEdYWfrsaGzZHOGx0zc72FQRzO3XdIcL1J3D2SV76BGavaJr4SAinsOw9ewQkLLGDDq12WvzSIq3lBY=
X-Received: by 2002:a25:5283:0:b0:663:98b0:4a23 with SMTP id
 g125-20020a255283000000b0066398b04a23mr11627867ybb.407.1655487925488; Fri, 17
 Jun 2022 10:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220617091039.2257083-1-eric.dumazet@gmail.com>
 <YqxufxqsnHjVfQOs@worktop.programming.kicks-ass.net> <2dd754f9-3a79-ed17-e423-6b411c3afb69@redhat.com>
 <CALvZod5ijDz=coEE8G8v_haPaKuUa5jHYzEwKvLVxHGphixsFA@mail.gmail.com>
 <2730b855-8f99-5a9e-707e-697d3bd9811d@redhat.com> <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com>
In-Reply-To: <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Jun 2022 19:45:14 +0200
Message-ID: <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
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

On Fri, Jun 17, 2022 at 7:42 PM Waiman Long <longman@redhat.com> wrote:
>
> On 6/17/22 11:24, Eric Dumazet wrote:
> > On Fri, Jun 17, 2022 at 5:00 PM Waiman Long <longman@redhat.com> wrote:
> >> On 6/17/22 10:57, Shakeel Butt wrote:
> >>> On Fri, Jun 17, 2022 at 7:43 AM Waiman Long <longman@redhat.com> wrote:
> >>>> On 6/17/22 08:07, Peter Zijlstra wrote:
> >>>>> On Fri, Jun 17, 2022 at 02:10:39AM -0700, Eric Dumazet wrote:
> >>>>>> --- a/kernel/locking/qrwlock.c
> >>>>>> +++ b/kernel/locking/qrwlock.c
> >>>>>> @@ -23,16 +23,6 @@ void queued_read_lock_slowpath(struct qrwlock *lock)
> >>>>>>        /*
> >>>>>>         * Readers come here when they cannot get the lock without waiting
> >>>>>>         */
> >>>>>> -    if (unlikely(in_interrupt())) {
> >>>>>> -            /*
> >>>>>> -             * Readers in interrupt context will get the lock immediately
> >>>>>> -             * if the writer is just waiting (not holding the lock yet),
> >>>>>> -             * so spin with ACQUIRE semantics until the lock is available
> >>>>>> -             * without waiting in the queue.
> >>>>>> -             */
> >>>>>> -            atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
> >>>>>> -            return;
> >>>>>> -    }
> >>>>>>        atomic_sub(_QR_BIAS, &lock->cnts);
> >>>>>>
> >>>>>>        trace_contention_begin(lock, LCB_F_SPIN | LCB_F_READ);
> >>>>> This is known to break tasklist_lock.
> >>>>>
> >>>> We certainly can't break the current usage of tasklist_lock.
> >>>>
> >>>> I am aware of this problem with networking code and is thinking about
> >>>> either relaxing the check to exclude softirq or provide a
> >>>> read_lock_unfair() variant for networking use.
> >>> read_lock_unfair() for networking use or tasklist_lock use?
> >> I mean to say read_lock_fair(), but it could also be the other way
> >> around. Thanks for spotting that.
> >>
> > If only tasklist_lock is problematic and needs the unfair variant,
> > then changing a few read_lock() for tasklist_lock will be less
> > invasive than ~1000 read_lock() elsewhere....
>
> After a second thought, I think the right way is to introduce a fair
> variant, if needed. If an arch isn't using qrwlock, the native rwlock
> implementation will be unfair. In that sense, unfair rwlock is the
> default. We will only need to change the relevant network read_lock()
> calls to use the fair variant which will still be unfair if qrwlock
> isn't used. We are not going to touch other read_lock call that don't
> care about fair or unfair.
>

Hmm... backporting this kind of invasive change to stable kernels will
be a daunting task.

Were rwlocks always unfair, and we have been lucky ?
