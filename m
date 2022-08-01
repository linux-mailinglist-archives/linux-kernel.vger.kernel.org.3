Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BEE587174
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiHATbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiHATaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:30:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAD965FC;
        Mon,  1 Aug 2022 12:30:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659382221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCVoqN35XPquvGhrCezKkn75+pkhWZjm/1Cnh7Cbjjk=;
        b=RjzhuQx5633QszrkNIxKCT7aAaRPPXzemzaBIwOMjfX2YZabgHe/r7Lguz6d1Is3f44Ax3
        LKd8mdnTv3nd8Aqvh4iJuabq6cmCskzkUuoemqTUyFXoA1TknueoyXvAir9PZRFCBb2HXY
        bzcy+DznOEC+TxuOUcLQJBamQ0CAFNhawScxdqrSLfG2bdzyRRXNtNdaAns24oT6uSr2Vm
        CAuavR5mlznGm/hWtDda4jaD07/0KaPavXRiU56zbrsmbkgfHCZj2m8svTPCtS4r7nH/Wz
        rkwxVLRRY3MTB1j7GCNGoMezUw1fJFB95i9IaAR3nNA4bxwgvVY/9A3hYjewCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659382221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YCVoqN35XPquvGhrCezKkn75+pkhWZjm/1Cnh7Cbjjk=;
        b=k6boVoGAAXOxRdWveTovBjKjjH+yIoMo1MbINTIwy3XYuV1UdsYLRMTliJs4KGtWBR2jR+
        mu8eRVGKS6DnspAQ==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        x86@kernel.org, Nadia Heninger <nadiah@cs.ucsd.edu>,
        Thomas Ristenpart <ristenpart@cornell.edu>,
        Theodore Ts'o <tytso@mit.edu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH RFC v1] random: implement getrandom() in vDSO
In-Reply-To: <YuXCpyULk6jFgGV5@zx2c4.com>
References: <20220729145525.1729066-1-Jason@zx2c4.com>
 <CAHk-=wiLwz=9h9LD1-_yb1+T+u59a2EjTmMvCiGj4A-ZsPN1wA@mail.gmail.com>
 <YuXCpyULk6jFgGV5@zx2c4.com>
Date:   Mon, 01 Aug 2022 21:30:20 +0200
Message-ID: <87zggnsqwj.ffs@tglx>
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

On Sun, Jul 31 2022 at 01:45, Jason A. Donenfeld wrote:
> Thanks a bunch for chiming in. Indeed this whole thing is kind of crazy,
> so your input is particularly useful here.
>
> On Sat, Jul 30, 2022 at 08:48:42AM -0700, Linus Torvalds wrote:
>> It's just too specialized, and the people who care about performance
>> can - and do - do special things anyway.
>
> To be clear, I really would rather not do this. I'm not really looking
> for more stuff to do, and I don't tend to write (public) code "just
> 'cuz". My worry is that by /not/ doing it, footguns will proliferate.
> The glibc thing was what finally motivated me to want to at least sketch
> out a potential action to make this kind of (apparently common) urge of
> writing a userspace RNG safer.

But the user space tinkering will continue no matter what. They might
then just use the vdso to get access to the ready/generation bits. I've
seen "better" VDSO implementations to access time. :)

> So, anyway, if I do muster a v2 of this (perhaps just to see the idea
> through), the API might split in two to something like:
>
>   void *getrandom_allocate_states([inout] size_t *number_of_states, [out] size_t *length_per_state);
>   ssize_t getrandom(void *state, void *buffer, size_t len, unsigned long flags);

I'm not seeing any reason to have those functions at all.

The only thing which would be VDSO worthy here is the access to
random_state->ready and random_state->generation as that's the
information which is otherwise not available to userspace.

So you can just have:

   int random_check_and_update_generation(u64 *generation);

Everything else is library material, really.

Thanks,

        tglx
