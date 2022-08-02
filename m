Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A522588439
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiHBW1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiHBW1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:27:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D84D4F0;
        Tue,  2 Aug 2022 15:27:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659479264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+8YQaqr4jvBS77GSdetrDQfbpLw2aOVtTCrGN8SWq0=;
        b=f4Fsr/J/7fmIJ2tvX1It3tya28H7xrMMJIXEhiveaI8B56d8Y7ynh+50whCMatb9FWA23I
        DP9ICXxCnxu1bqeqH0KeaObLIY3cJSda2SFuFH4heJVgDqRVbFnwmzZIB3ss+cSOwvo0Q3
        e1dgusOuX7PpaSZhIRWU7HBvLsNpSnb/6Qh4IPMrBUEYhUzPg9Z3qKsEirKdKKpCjObmGf
        T0V2Zuh6On3YOvGT5mXnbOmwEbTRBKdfChjVKtzvfny9zSZy6H+y5DxCN5UWasFGV1XhEW
        afNKWS7pehSl2eNQJCzmBFxB/CnPByq2euTBPqiXgWAlQ/KUsB82/Bj3rx7xFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659479264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+8YQaqr4jvBS77GSdetrDQfbpLw2aOVtTCrGN8SWq0=;
        b=J5odj7yQnMHKp1krceheGfiT050s2V9VWquVety53pBTRT3cFLrw3HOBTdbvUxNHxE124Q
        P8Dvry2qh+yQwpCg==
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
In-Reply-To: <CAHmME9pNN6Pc_1NaMDv+hqv_ULXiVUYFXM=Xigu_StvGS_-53A@mail.gmail.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com> <87zggnsqwj.ffs@tglx>
 <Yuhe6IIFXqNMZs5b@zx2c4.com> <87bkt2sqq4.ffs@tglx>
 <YuktqQS7Rb0IbJNh@zx2c4.com> <878ro6smmm.ffs@tglx>
 <CAHmME9pNN6Pc_1NaMDv+hqv_ULXiVUYFXM=Xigu_StvGS_-53A@mail.gmail.com>
Date:   Wed, 03 Aug 2022 00:27:43 +0200
Message-ID: <87zggmqo0w.ffs@tglx>
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

On Tue, Aug 02 2022 at 17:26, Jason A. Donenfeld wrote:
> On Tue, Aug 2, 2022 at 5:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Seriously no.
>
> Why so serious all at once? :-)

Because you triggered the 'now it gets serious' button with your "it's
the same" sentiment.

>> All existing VDSO functions have exactly the same function
>> signature and semantics as their syscall counterparts. So they are drop
>> in equivalent.
>>
>> But:
>>
>>   ssize_t getrandom(void *, void *, size_t, unsigned int);
>>
>> is very much different than
>>
>>   ssize_t getrandom(void *, size_t, unsigned int);
>>
>> Different signature and different semantics.
>
> Different signature, but basically the same semantics.

Not at all. The concept of 'basically same semantics' is a delusion. It
does not exist. Either it's the same or it's not.

I really want to see your reaction on a claim that some RNG
implementation is basically the same as the existing one. I'm sure you
buy that without complaints.

>> So you have to go through the whole process of a new ABI whether you
>> like it or not.
>
> Ahh, in that sense. Yea, I'd rather not have to do that too, with the
> additional opaque handle passed as the first argument. It'd be nice if
> there were some private place where I could store the necessary state,
> but I'm not really sure where that might be at the moment. If you have
> any ideas, please let me know.

That's exactly the problem. VDSO is a stateless syscall wrapper which
has to be self contained for obvious reasons.

My previous statement:

    Everything else is library material, really.

is based on that fact and not on the unwillingness to add magic muck to
the VDSO.

The unwillingness part is just the question:

    Is there a sensible usecase?

Assumed that there is a sensible usecase, there is a way out and that's
exactly the library part. You can make that VDSO interface versioned and
provide a library in tools/random/ which goes in lockstep with the VDSO
changes.

If the RNG tinkerers abuse that, then so be it. You can't do anything
about it whatever you try. They can abuse your magic vdso functionality
too.

That's very much the same as we have with e.g. perf. The old perf binary
still works, but it does not have access to the latest and greatest
features.

You can do very much the same in a kernel supplied helper library which
either can cope with the version change or falls back to
sys_getrandom().

Vs. the storage problem. That yells TLS, but that makes your process
wide sharing moot, which might not be the worst of all things IMO.

Thanks,

        tglx


