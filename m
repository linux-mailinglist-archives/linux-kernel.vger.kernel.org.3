Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE16589E9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbiHDPYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiHDPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:24:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBB4248CF;
        Thu,  4 Aug 2022 08:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4837661335;
        Thu,  4 Aug 2022 15:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601DFC433D6;
        Thu,  4 Aug 2022 15:24:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="e4y48Q3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659626639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sMG44mdnxu6+rQubJodHON/qjU/x31iB/DQQ9bsXfp4=;
        b=e4y48Q3bc2spBfeM8k40zGRYfXaMDGJKLmUTE/z4OEBXYNpH13xlinIZ52b4xl6tqeQo/L
        VBbY2paH6uBVKnUUngBW9g32k6ihlv0EkYSvgA1dNJhnoCOdX3RrVUytn/4JWicxmC3gyX
        3WSulx8xwotXOIvG8Qpf2vdA5S/bVXo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b0a42e42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 4 Aug 2022 15:23:59 +0000 (UTC)
Date:   Thu, 4 Aug 2022 17:23:55 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
Message-ID: <Yuvki1nU2vJeINNk@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com>
 <87zggnsqwj.ffs@tglx>
 <Yuhe6IIFXqNMZs5b@zx2c4.com>
 <87bkt2sqq4.ffs@tglx>
 <YuktqQS7Rb0IbJNh@zx2c4.com>
 <878ro6smmm.ffs@tglx>
 <CAHmME9pNN6Pc_1NaMDv+hqv_ULXiVUYFXM=Xigu_StvGS_-53A@mail.gmail.com>
 <87zggmqo0w.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zggmqo0w.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 12:27:43AM +0200, Thomas Gleixner wrote:
> Jason!

Thomas!!

> Not at all. The concept of 'basically same semantics' is a delusion. It
> does not exist. Either it's the same or it's not.
> 
> I really want to see your reaction on a claim that some RNG
> implementation is basically the same as the existing one. I'm sure you
> buy that without complaints.

I mean there are some undeniable similarities here. We might be arguing
over semantics of semantics at this point, but... Barring the additional
`void *state` argument, they take the same inputs and produce the same
outputs. Then, most importantly, the way they each produce randomness is
the same, using the same algorithms and same lifetime rules. For all
measures that are meaningful to me, they're the "same". Yes yes
technically that extra `void *state` means something is slightly
different.  But does that matter? I guess your point is that somehow it
does matter, and maybe that's where we disagree.

> >> So you have to go through the whole process of a new ABI whether you
> >> like it or not.
> >
> > Ahh, in that sense. Yea, I'd rather not have to do that too, with the
> > additional opaque handle passed as the first argument. It'd be nice if
> > there were some private place where I could store the necessary state,
> > but I'm not really sure where that might be at the moment. If you have
> > any ideas, please let me know.
> 
> That's exactly the problem. VDSO is a stateless syscall wrapper which
> has to be self contained for obvious reasons.

Unless each call can import and export any potential state. That is,
unless there's a `void *state` argument like what I added. Then the code
itself doesn't refer to any global state, but can still behave in a
stateful manner.

We could even establish this as a "convention" if necessary, and
document it as such. That way upgrading a syscall ABI to a vDSO stateful
ABI always follows some rule, and then this doesn't feel as ad-hoc.
Heck, it could even be an opaque type, `vdso_handle_t state`, which
would just be a unsigned long.

> My previous statement:
> 
>     Everything else is library material, really.
> 
> is based on that fact and not on the unwillingness to add magic muck to
> the VDSO.
> 
> The unwillingness part is just the question:
> 
>     Is there a sensible usecase?

In the use case department, by the way, apparently there really is.
arc4random() is too slow for chronyd:
https://sourceware.org/bugzilla/show_bug.cgi?id=29437
And that's on a kernel even with the "newer faster getrandom()".

> Assumed that there is a sensible usecase, there is a way out and that's
> exactly the library part. You can make that VDSO interface versioned and
> provide a library in tools/random/ which goes in lockstep with the VDSO
> changes.

That sounds absolutely dreadful; no way jose. Then we wind up having to
maintain the data in the vDSO as a particular version, and keep that
working into the future. That's not going to fly. As I wrote before, I
don't want to commit the RNG to preserving certain internal semantics
over time. That's not something I feel comfortable committing to. And
even if we can "add" new ones with a new version in your hypothetical
scheme, we'd still have to keep the old ones working, and that could
prove prohibitive of improvements. So that's not going to work.

And again, I don't see how this is any different than gettimeofday() and
such. Why didn't you just make versioned accessor functions for each one
of the various struct fields, and then stick some library code into
tools/timekeeping/ for glibc to copy and paste once and never update
again? Why isn't this a nightmare you chose to have each time the moon
is full? Clearly because doing so would be a maintenance disaster and
would impede future meaningful progress, not to mention proliferating
wrong means of reading the time.

Just as gettimeofday benefits from being an actual function in the vDSO,
so too does getrandom().

> Vs. the storage problem. That yells TLS, but that makes your process
> wide sharing moot, which might not be the worst of all things IMO.

Yea, TLS is what we want here. The `void *state` argument thing is meant
for this. You allocate an array of states using that alloc function, and
then you divvy them up per-thread.

Jason
