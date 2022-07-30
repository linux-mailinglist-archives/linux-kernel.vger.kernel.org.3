Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73C3585CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 01:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiG3XqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 19:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiG3Xp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 19:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88BCFD3C;
        Sat, 30 Jul 2022 16:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA4260C3F;
        Sat, 30 Jul 2022 23:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74281C433C1;
        Sat, 30 Jul 2022 23:45:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dO1re7dv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659224746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwILLSCMqAC9yTKYmk9zI52N9kG+nfe/r+3/DhFdIhI=;
        b=dO1re7dvN/hABg+89W1Rp8gEpTgrndh2YDPzlk+51ozhnja+DhyWXYBOoLT7yL8M1dWJ7D
        iUPTj393k60Gxkm+VIhoQJN/HtEayKElIQWxB3qlx29lkLwBq2h3CkxLj3B1CEAnmIs7ah
        ZqYVZgSMzFZIgCKwaUf7c97wRV/tT04=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5107785a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 30 Jul 2022 23:45:45 +0000 (UTC)
Date:   Sun, 31 Jul 2022 01:45:43 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
Message-ID: <YuXCpyULk6jFgGV5@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Thanks a bunch for chiming in. Indeed this whole thing is kind of crazy,
so your input is particularly useful here.

On Sat, Jul 30, 2022 at 08:48:42AM -0700, Linus Torvalds wrote:
> It's just too specialized, and the people who care about performance
> can - and do - do special things anyway.

I followed most of your email, but I just wanted to point out that the
"can" part of this isn't quite right, though the "do" part is.
Specifically, I don't think there's currently a good way for userspace
to do this kind of thing and get the same kind of security guarantees
that the syscall has. They "do" it anyway, though (openssl, libgcrypt,
glibc's arc4random() implementation before I tamed it last week, etc),
and this is somewhat concerning.

So my larger intent is, assuming that people will continue to attempt
such things, to just nip the issue in the bud by providing an actually
safe way for it to be done.

To be clear, I really would rather not do this. I'm not really looking
for more stuff to do, and I don't tend to write (public) code "just
'cuz". My worry is that by /not/ doing it, footguns will proliferate.
The glibc thing was what finally motivated me to want to at least sketch
out a potential action to make this kind of (apparently common) urge of
writing a userspace RNG safer.

(Actually coding it up didn't really take much time, which perhaps
shows: that `if (!len)` check needs to be hoisted out of the inner
block!)

> So I'm really not convinced that this kind of thing is something the
> kernel should work that hard to help.
> 
> Your patch fundamentally seems to be about "make it easy to not have
> to care, and still get high performance", but that's _such_ a small
> use-case (the intersection between "don't care" and "really really
> need high performance" would seem to be basically NIL).

So this is "statement (1)" stuff. Namely, userspace apparently wants
faster random numbers. Is this desire justified? Has anybody aside from
Phoronix even benchmarked getrandom() since I did the neat lockless
stuff to it? Is this just for some artificial card shuffling unit tests,
or is generating TLS CBC nonces at scale using getrandom() a real
bottleneck for a real use case?

I'm honestly not quite sure. But I do know that people are building
these userspace RNGs anyway, and will keep building them, and that kind
of worries me.

So either this is a useful thing to have, and people are building it
anyway, so maybe the kernel should get involved. Or it's not a useful
thing to have, BUT people are building it anyway, so maybe the kernel
should [not?] get involved? The latter case is a bit decisionally
hairier.

Anyway, onto the technical feedback:

> And that state allocation in particular looks very random in all the
> wrong ways, with various "if I run out of resources I'll just do a
> system call" things.
> 
> Not to mention that I don't think your patch can work anyway, with
> things like "cmpxchg()" not being something you can do in the vdso
> because it might have the kernel instrumentation in it.

Yea this sharding thing is somewhat faulty. In its current inception, it
also falls over during fork, since the cmpxchg pseudo trylock is
dropped, among other problems Andy and I discussed on IRC. Andy also
suggested not doing the allocation inside of the same function. Florian
brought up the difficulty of even determining the CPU number on arm64.
And also that's a good point about instrumentation on cmpxchg.

So, anyway, if I do muster a v2 of this (perhaps just to see the idea
through), the API might split in two to something like:

  void *getrandom_allocate_states([inout] size_t *number_of_states, [out] size_t *length_per_state);
  ssize_t getrandom(void *state, void *buffer, size_t len, unsigned long flags);

User code will call getrandom_allocate_state(), which will allocate
enough pages to hold *number_of_states, and return the size of each one
in length_per_state and the number actually allocated back in
number_of_states. The result can then be sliced up by that size, and
passed to getrandom(). So glibc or whatever would presumably allocate
one per thread, and handle any reentrancy/locking around it.

Or some other variation on that. I'm sure you hate those function
signatures. Everybody loves to bikeshed APIs, right? There's plenty to
be tweaked. But that's anyhow about where my thinking is for a potential
v2.

Jason
