Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6310B4E49D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbiCVX4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiCVX4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:56:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9581C5DA0B;
        Tue, 22 Mar 2022 16:55:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36478B81DCB;
        Tue, 22 Mar 2022 23:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74402C340F2;
        Tue, 22 Mar 2022 23:54:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="gGrZMvSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647993296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f8Wt8uBQYGZQhCEfKCpobGBc6rfav6vAiizVahglg7Y=;
        b=gGrZMvSJhpGKwYpEvMw3JXc9i6s5pdiVOJLM+Bunnp5sM9tSMfKiBf2V4fBXATB/GK82My
        yZ4hMzEMg1Ci0b3RNz4rKvEUQ51MCTOltz5eJCOKYMsAjpw8oO/WBUdoC59esVAAAQyqEh
        7i4r41at9nbrOXp2yKSHJkJcaf+yiCg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 541f7814 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 22 Mar 2022 23:54:56 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id j2so36685047ybu.0;
        Tue, 22 Mar 2022 16:54:55 -0700 (PDT)
X-Gm-Message-State: AOAM5334vBd6c+Ymx6c3MDZHsZ5f4N/pVa5ZMOQzlDu6zr64LxrsOCq/
        idMRLy8Kjk7YE3XxfnHavFBi/fsWw4uJ2c3uj3s=
X-Google-Smtp-Source: ABdhPJwhufIrGQCUm2LFHBr+tlbqbyrb24JNhjp3dM/qKs4S8AeovmWrI2Joovd0HAOMldLapu3D7vYgYBJwknWUgcE=
X-Received: by 2002:a5b:782:0:b0:634:683f:310e with SMTP id
 b2-20020a5b0782000000b00634683f310emr294616ybq.398.1647993294612; Tue, 22 Mar
 2022 16:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220322191436.110963-1-Jason@zx2c4.com> <CAHk-=wgSRk_-Nh5gtDKZj_fKya1NKry1Y5jdejfKNPnB+Pr4cw@mail.gmail.com>
In-Reply-To: <CAHk-=wgSRk_-Nh5gtDKZj_fKya1NKry1Y5jdejfKNPnB+Pr4cw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 22 Mar 2022 17:54:43 -0600
X-Gmail-Original-Message-ID: <CAHmME9oWzXeuEJacLoKWHer82LwCtD6+9Kv9gMOKYcZOhhN7pA@mail.gmail.com>
Message-ID: <CAHmME9oWzXeuEJacLoKWHer82LwCtD6+9Kv9gMOKYcZOhhN7pA@mail.gmail.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast init
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Theodore Ts'o" <tytso@mit.edu>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

On Tue, Mar 22, 2022 at 2:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 22, 2022 at 12:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > @@ -1507,6 +1507,8 @@ static int write_pool(const char __user *ubuf, size_t count)
> >                 }
> >                 count -= len;
> >                 ubuf += len;
> > +               if (unlikely(crng_init == 0 && !will_credit))
> > +                       crng_pre_init_inject(block, len, false);
> >                 mix_pool_bytes(block, len);
> >                 cond_resched();
> >         }
>
> Ugh. I hate that whole crng_pre_init_inject() dance.

Yea it's not great, but it's a helluva lot better than what was there
before 5.18, when there were two different ways of mixing into the
crng key, both of which were insecure. At least now it's a hash
function. As I mentioned in that pull request, I tried to shore up the
existing design as much as I could without departing from it in any
large fundamental ways. It may well be time to revisit the pre init
situation though.

Maybe it'd help if I described what the goals are of the current
approach and how it attempts to accomplish that.

The chacha key that's used for random bytes is separate from the input
pool, which is where entropy gets dumped. The reason for that
separation is because it's important that we decide when and under
what conditions to extract from the input pool into a new chacha key.
If we do it too often or prematurely, then we risk updating the chacha
key with very few new bits of entropy. If there aren't enough new
bits, and an attacker knows the old state (say, because the system
just booted), then it's trivial to bruteforce those new bits, since
read access to /dev/urandom is unprivileged. That's very bad.

For that reason, we only reseed when we've collected 256 bits of
entropy, and at a schedule of uptime/2 for the first 10 minutes, and
then every 5 minutes after that.

The question, here, is what to do before we've collected 256 bits of
entropy. 80 bits is still better than 0, for example. The existing
scheme (from Ted) is that we maintain a state variable, crng_init.
When crng_init=0, we direct all entropy into the chacha key directly.
If that entropy is creditable, then we account for up to 64 bytes of
input total, regardless of how many "bits" of entropy we would
otherwise be crediting were it not pre-init phase. That's kinda weird,
but the motivating mantra has always been, "fast init is garbage, but
it's better than nothing." Then, once we hit 64 bytes of fast init
accounting, we transition to crng_init=1. At this stage, we're putting
bytes into the normal input pool and crediting it as usual, not
updating the crng key directly anymore with injection, and the crng is
still blocked. When we hit 256 bits of accounted entropy from the
crng_init=1 stage, then we're ready to go, and we transition to
crng_init=2.

So this patch helps with the crng_init=0 case. It doesn't address the
crng_init=1 case, when the bytes written to /dev/urandom won't be
directly injected as they are for crng_init=0. In any case, the one
thing we're trying to preserve in all of this is that when we do
transition to crng_init=2, it's with a pool that contains 256 bits of
entropy that haven't previously been exposed anywhere, so that they
can't be brute forced.

With that as background, to answer your question:

> Maybe I'm missing something. But it seems kind of silly to use
> base_crng AT ALL before crng_ready(). Why not use the pool we have
> that *is* actually updated (that 'input_pool')?

In this case, base_crng.key is really just doubling as a separate
pool. The "pre init pool", the "fast init pool", the "super terrible
but at least not zero pool", the "all bets are off pool", ... whatever
you want to call it. Why a separate pool for pre init? Because the
real input pool needs to accumulate 256 bits of entropy before it's
safe to use.

Your suggestion is to instead not have a separate pool, but perhaps
just do separate accounting. That might work to some degree, but the
devil is in the details, and that sounds a lot harder and messier to
code. For example, you wrote:

> +               crng_fast_key_erasure(input_pool.key, chacha_state,
> +                                     random_data, random_data_len);

Except there is no input_pool.key, because the input_pool's state is
actually an un-finalized hash function. So what you wind up with
instead is calling extract_entropy() on every read. But then you have
to decide a certain point when you stop doing that, so it can
accumulate 256 bits prior to exposure, and things quickly get
extremely messy. So I don't think your suggestion improves much.

The long term solution to this stuff might be doing away with the
entropy accounting entirely, as I suggested in the other thread. The
shorter term solution, though, might be reimagining how the
crng_init=1/2 states work to begin with. (And the shortest-term "fix"
is this patch, which while not perfect is at least something.)

Just sort of spitballing what the shorter term solution might be, we
could do something exponential, where we get rid of the
pre_init_inject stuff entirely, but call `crng_reseed(force=true)` at
1 bit, 2 bits, 4 bits, 8 bits, 16 bits, 32 bits, ... 256 bits, the
same way we do now with the time. (This is somewhat similar to what NT
does, fwiw.) A downside is that the gap between, say, 64 bits and 128
bits is much "longer" than what we have now with pre_init_inject.

While the above might be an improvement, that doesn't help with our
/dev/urandom problem, though. Perhaps for that we could have some
messy heuristic, like `if (capable(CAP_SYS_ADMIN) && !crng_ready())
crng_reseed(force=true);`. That's sort of ugly too, but it would help
with the /dev/urandom shellscript seeders.

I'll think on it some more, but these two spitball ideas together
might result in a nice simplification by eliminating the fast pool
entirely. Happy to hear more ideas from you too if the above inspires
anything.

Jason
