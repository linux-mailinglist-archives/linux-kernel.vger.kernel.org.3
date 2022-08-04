Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9EB58A3D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbiHDXLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHDXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:11:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CFF192BB;
        Thu,  4 Aug 2022 16:11:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659654703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=md+V4qmPB5GX3jqW//qN1hSjLj61/0A3xpvjMhWwG30=;
        b=taCx62Arv59LlsnQmTB5C9Lv1ndUGhbJlGYNLIYqPG5fUWJusO5bn5Ok/ObQSsrew3wGFy
        a/Q+poApdVs5+YYIrPOl37L2qwHpVEPv90yjvr2fSTyu+sClwFNC9+2bbNFMkFHBrMABST
        94r1G4fLLS9N1ZK6N8l+WRejj13kNXuVYsIMBtYN3CNLeA/DeOu+GpzDgVLNw0l7tCHVbM
        9TQYdp4puBJA9FyejfKiuK2ScMyJckEbVNMljkRL35cxdNO4uYlWKRGeVZjUDE0HitY2z0
        EpbH+olfFgmNAbbJ2KHWey/BaGxdT5/iN3XID0FTjhLGVwkS4mtx+U4sSDoFyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659654703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=md+V4qmPB5GX3jqW//qN1hSjLj61/0A3xpvjMhWwG30=;
        b=lqKd79tGnjPFJSXxwfckp0wH64Uh9jXJQYZNQKKMPFaJyZakwNfqhEopdbUgcWvILP24/t
        tnQHKuWo7Tp1TtAQ==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
In-Reply-To: <Yuvki1nU2vJeINNk@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com> <87zggnsqwj.ffs@tglx>
 <Yuhe6IIFXqNMZs5b@zx2c4.com> <87bkt2sqq4.ffs@tglx>
 <YuktqQS7Rb0IbJNh@zx2c4.com> <878ro6smmm.ffs@tglx>
 <CAHmME9pNN6Pc_1NaMDv+hqv_ULXiVUYFXM=Xigu_StvGS_-53A@mail.gmail.com>
 <87zggmqo0w.ffs@tglx> <Yuvki1nU2vJeINNk@zx2c4.com>
Date:   Fri, 05 Aug 2022 01:11:43 +0200
Message-ID: <87mtcjr4cw.ffs@tglx>
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

On Thu, Aug 04 2022 at 17:23, Jason A. Donenfeld wrote:
> On Wed, Aug 03, 2022 at 12:27:43AM +0200, Thomas Gleixner wrote:
>> Not at all. The concept of 'basically same semantics' is a delusion. It
>> does not exist. Either it's the same or it's not.
>> 
>> I really want to see your reaction on a claim that some RNG
>> implementation is basically the same as the existing one. I'm sure you
>> buy that without complaints.
>
> I mean there are some undeniable similarities here.

Similarity yes. Semantically in the sense of an API definitely not.

> We might be arguing over semantics of semantics at this point,
> but... Barring the additional `void *state` argument, they take the
> same inputs and produce the same outputs. Then, most importantly, the
> way they each produce randomness is the same, using the same
> algorithms and same lifetime rules. For all measures that are
> meaningful to me, they're the "same". Yes yes technically that extra
> `void *state` means something is slightly different.  But does that
> matter? I guess your point is that somehow it does matter, and maybe
> that's where we disagree.

The point is that the API is different and you can't provide a API
compatible variant in the VDSO ever.

This matters because it requires auxilliary code outside of the VDSO or
even application changes.

>> >> So you have to go through the whole process of a new ABI whether you
>> >> like it or not.
>> >
>> > Ahh, in that sense. Yea, I'd rather not have to do that too, with the
>> > additional opaque handle passed as the first argument. It'd be nice if
>> > there were some private place where I could store the necessary state,
>> > but I'm not really sure where that might be at the moment. If you have
>> > any ideas, please let me know.
>> 
>> That's exactly the problem. VDSO is a stateless syscall wrapper which
>> has to be self contained for obvious reasons.
>
> Unless each call can import and export any potential state. That is,
> unless there's a `void *state` argument like what I added. Then the code
> itself doesn't refer to any global state, but can still behave in a
> stateful manner.

Which makes it an incompatible API with an untyped pointer which is
sloppy at best.

>> The unwillingness part is just the question:
>> 
>>     Is there a sensible usecase?
>
> In the use case department, by the way, apparently there really is.
> arc4random() is too slow for chronyd:
> https://sourceware.org/bugzilla/show_bug.cgi?id=29437
> And that's on a kernel even with the "newer faster getrandom()".

For a problem which does not require cryptographically secure random
numbers. Truly convincing.

>> Assumed that there is a sensible usecase, there is a way out and that's
>> exactly the library part. You can make that VDSO interface versioned and
>> provide a library in tools/random/ which goes in lockstep with the VDSO
>> changes.
>
> That sounds absolutely dreadful; no way jose. Then we wind up having to
> maintain the data in the vDSO as a particular version, and keep that
> working into the future. That's not going to fly. As I wrote before, I
> don't want to commit the RNG to preserving certain internal semantics
> over time. That's not something I feel comfortable committing to. And
> even if we can "add" new ones with a new version in your hypothetical
> scheme, we'd still have to keep the old ones working, and that could
> prove prohibitive of improvements. So that's not going to work.

That's a complete nonsensical argumentation. If you install a new
kernel, then the new library which exposes the application interface is
installed too. So where is the problem?

That needs obviously some infrastructure so that the kernel install
handles such libraries similar to modules, but that would be a
worthwhile exercise if we want to expose more information through VDSO.

Such a library exposes the API and the interface between the library and
the VDSO is kernel dependent. They are shipped in lockstep.

That way you avoid to implement a ton of syscall fallbacks for this muck
and just treat it as any other regular library. You even can hide the
whole allocation completely and make it a drop in replacement:

  getrandom(....)
        if (!tls->random_state)
           alloc_tls_random_state()
        ....

A real library can do that, VDSO not.

The only version information in that data interface would be:

struct vdso_random_data {
       unsigned int	version;
       ....
};

All other fields are version dependent and you can change them as you
want.

If some tinkerer uses the data interface directly and ignores the
version check, then he can keep the pieces. That's not any different
than the timekeeping data interface of the VDSO.

I've seen code which accesses the timekeeping VDSO data directly just
because some performance expert decided that rdtsc_ordered() is too slow
and a trivial rdtsc() is good enough. That exploded in their face when
we overhauled the VDSO.

Can you prevent that? No.

Does it matter? No.

The data interface is documented to be for the kernel supplied library
only and the version field is only for paranoia reasons to validate that
kernel and library agree.

That means if some tinkerer uses the data interface directly then he
either does a version check and bails out when the version is different
from the expected version or he falls flat on his face.

That's a very simple contract. Versioned interfaces are not required to
be backwards compatible. That's a matter of definition and documentation.

> And again, I don't see how this is any different than gettimeofday() and
> such. Why didn't you just make versioned accessor functions for each one
> of the various struct fields, and then stick some library code into
> tools/timekeeping/ for glibc to copy and paste once and never update
> again? Why isn't this a nightmare you chose to have each time the moon
> is full? Clearly because doing so would be a maintenance disaster and
> would impede future meaningful progress, not to mention proliferating
> wrong means of reading the time.

The time accessors have been proven to be performance critical and the
implementation is a drop in replacement for the syscall so that an extra
library is pointless and less performant.

But you are neither providing a convincing use case nor a drop in
replacement simply because it's technically impossible in the VDSO to
provide that with the features you want to add.

> Just as gettimeofday benefits from being an actual function in the vDSO,
> so too does getrandom().

time*() == vsdo_time*() but getrandom() != vdso_magic_getrandom()

Can you spot the difference?

>> Vs. the storage problem. That yells TLS, but that makes your process
>> wide sharing moot, which might not be the worst of all things IMO.
>
> Yea, TLS is what we want here. The `void *state` argument thing is meant
> for this. You allocate an array of states using that alloc function, and
> then you divvy them up per-thread.

How does the first caller know how many threads are going to use this
and how is the pointer handed over to another thread?. TLS == Thread
Local Storage which unsurprisingly means that such a pointer is thread
private.

Which part of the code is going to do that pointer sharing? Are you
going to hide that in the VDSO library too? You can't.

If you want to use TLS which is the only sensible solution then you have
to do the allocation per thread which avoids all the sharding issues and
screams even more for a lib_getrandom_$kernel_version.so solution.

But before we go there, please provide a sensible use case.

Thanks,

        tglx
