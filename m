Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13471587D59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiHBNqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiHBNqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:46:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397DD1CB04;
        Tue,  2 Aug 2022 06:46:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659447987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3cV1DF1tJGwCUTznBFQ+3bYEP9ySHgzm2aLZBU2Umsg=;
        b=RRSwfXucPgdcH2vq4hM4k1lXlPMG16dj8gKpeH3k6Ut0ZvZzJq10s3qosgawQ1UQjUNubn
        2MGxfKHlHP4sccaQ2b7OSsZROuhZ62XEK262sCzzAmKLHVPpBky433zXCP5fsW7yOLOvxX
        4riLpiXuN0Us5ntZlNe1Q9MgPsHDomHz3wCF/W2MkqmqERHPb472b6WZrtDGDgFUFZAADy
        EAnWi4/6w6UvUr/SG5O2eim/p7XXEJGzuov82DXtYiRNnnuhKOKxN0lBTbrLfUGzkxZihR
        m2x+39XqYBOhE6j8RcxEyDRaOmFHStoWDCt+dUL4IXNQxQCDDB3o5N4vTyPkig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659447987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3cV1DF1tJGwCUTznBFQ+3bYEP9ySHgzm2aLZBU2Umsg=;
        b=MPl5kGwHqVs9wmVaeXLASu+CN1mJKbtBMkMKD94SoAeoUm+tiRBZ/jst6pYdWGfh4nPRng
        nnKh35x/27tVGICA==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
In-Reply-To: <Yuhe6IIFXqNMZs5b@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com> <87zggnsqwj.ffs@tglx>
 <Yuhe6IIFXqNMZs5b@zx2c4.com>
Date:   Tue, 02 Aug 2022 15:46:27 +0200
Message-ID: <87bkt2sqq4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason!

On Tue, Aug 02 2022 at 01:16, Jason A. Donenfeld wrote:
> On Mon, Aug 01, 2022 at 09:30:20PM +0200, Thomas Gleixner wrote:
>> > So, anyway, if I do muster a v2 of this (perhaps just to see the idea
>> > through), the API might split in two to something like:
>> >
>> >   void *getrandom_allocate_states([inout] size_t *number_of_states, [out] size_t *length_per_state);
>> >   ssize_t getrandom(void *state, void *buffer, size_t len, unsigned long flags);
>> 
>> I'm not seeing any reason to have those functions at all.
>> 
>> The only thing which would be VDSO worthy here is the access to
>> random_state->ready and random_state->generation as that's the
>> information which is otherwise not available to userspace.
>
> I think you might have missed the part of the patch message where I
> discuss this. I'm happy to talk about that more, but it might help the
> discussion to refer to the parts already addressed. Reproduced here:

I did not miss this. I carefully read it.

> To reiterate, I don't want to commit to a particular data API, or even
> to an ideal interplay between kernel random and user random. I'd like to
> retain the latitude to change the semantics there considerably, so that
> Linux isn't locked into one RNG design forever. I think that kind of
> lock in would be a mistake. For example, just the generation counter
> alone won't do it (as I mentioned later on in the message; the RFC patch
> is somewhat incomplete). Rather, the interface I'm fine committing to
> would be the higher level getrandom(), with maybe an added state
> parameter, which doesn't expose any guts about what it's actually doing.
>
> Comex (CC'd) described in a forum comment the idea (and perhaps vDSO in
> general?) as a little more akin to system libraries on Windows or macOS,
> which represent the OS barrier, rather than the raw system call. Such
> libraries then can operate on private data as necessary. So in that
> sense, this patch here isn't very Linuxy (which Comex described as a
> potentially positive thing, but I assume you disagree).
>
> Anyway, I guess it in large part isn't so dissimilar to decisions you
> made around other vDSO functions, where to draw the barrier, etc. Why
> not just have an accessor for each vvar struct member and leave it to
> userspaces to implement? Well, that'd probably be a terrible idea for
> various reasons, and I feel the same way about exposing too many
> getrandom() guts.

I surely understand your goal, but the real question is where we draw
the line and what kind of functionality should go into such a library
and what's the required justification for it.

The concept of system libraries on Windows NT was to provide different
APIs for application programmers: Win32, OS/2, Posix. That allowed to
change the actual syscalls without breaking existing applications. IOW,
it's just a glue layer which translates between application API and
syscall API.

Right now the Linux VDSO functions are 1:1 replacements for system calls
and not adding a magic pile of functionality which is otherwise not
available.

What you are proposing is to have an implementation which is not
available via a regular syscall. Which means you are creating a VDSO
only syscall which still has the same problem as any other syscall in
terms of API design and functionality which needs to be supported
forever.

Thanks,

        tglx








