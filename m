Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB395A6083
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiH3KRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiH3KQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:16:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F2C14D08
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:13:59 -0700 (PDT)
Date:   Tue, 30 Aug 2022 12:13:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661854426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h656qOglZP5ZEOAhpkk5W+yJJBlsn97qeVFnhz5DLrk=;
        b=aqyAOMNiwUtl8rYZXLOztoFtHVhwDu6Mcv1mT/3YauAAcQhoMGbM1Ax+C3qq2tTtPKukiB
        kPw9XZxt3fSPnpCHB2msL7vyKNt+ZSbm/aBV+lEOy4XD1Px1JAdJKpm3zVeQvNQH3jcuRI
        rVXHAekNTAQiNZoPOLTkWj4kaw+G4yUycfmgPAEGT/yCOVPgT3EslH4TPev+mXvoX6IzlL
        EisBajnuUzPP15YRd4Pstsk3p+2fmorIBNqWF+KRzZ3fR1gTP2mcrRSA3YOcY3TWG5fFkq
        u8GSP0PZ7A/Gio8hfX53s0iW8uUOeZ7SX2c92tSjshk9TqKtgTIFxi5/mVTcBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661854426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h656qOglZP5ZEOAhpkk5W+yJJBlsn97qeVFnhz5DLrk=;
        b=n4V6CtNKE3l5KazHGGQbjnU8WeAM70jAetcC1wXOVJYA3oTBXgeZ3brHNmi2ELIg1wuxoG
        f8RLqaYBWYMYb+AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] random: use raw spinlocks for use on RT
Message-ID: <Yw3i2N8J7yz3jnyt@linutronix.de>
References: <20220801142530.133007-1-Jason@zx2c4.com>
 <YufkZU9kGkHHUhAK@linutronix.de>
 <YvRKm/IpbUID18FK@zx2c4.com>
 <YvSsf5uds7zGgWPX@linutronix.de>
 <YvUQJTDREXSAA9J6@zx2c4.com>
 <Yw0XRtgh2dmSM+T1@linutronix.de>
 <Yw0Z1jvwHEQQq8Zw@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Yw0Z1jvwHEQQq8Zw@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-29 15:56:06 [-0400], Jason A. Donenfeld wrote:
> Hi Sebastian,
Hi,

> On Mon, Aug 29, 2022 at 09:45:10PM +0200, Sebastian Andrzej Siewior wrote:
> > > So why don't we actually fix this, so we don't have to keep coming up
> > > with hacks? The question is: does using raw spinlocks over this code
> > > result in any real issue for RT latency? If so, I'd like to know wher=
e,
> > > and maybe I can do something about that (or maybe I can't). If not, t=
hen
> > > this is a non problem and I'll apply this patch with your blessing.
> >=20
> > It depends on what you do define as hacks. I suggested an explicit init
> > during boot for everyone. The only "hacky" thing might be the reschedule
> > of the worker every two secs in case random-core isn't ready yet.
>=20
> The worker solution you proposed before was problematic in that it
> changes RNG semantics by making jitter entropy run early on at boot
> before even attempting to get entropy from later. Maybe that's an okay
> change, or maybe it's not, but either way it isn't one that should be
> forced by wacky vnsprintf changes.

The first patch did so yes. The second simply retried in two secs and
this shouldn't be problematic.

> Okay but this on-demand aspect of vnsprintf() is clearly a place where
> it makes sense to do it from the occasional irq context.
>=20
> > So that local_lock_t is still breaking things since it can not be
> > acquired from blocking context. So in order to continue this needs to be
> > replaced somehow and checked again=E2=80=A6
> > Assuming this has been done, round #2:
> >=20
> > get_random_bytes()
> > -> _get_random_bytes()
> >   -> crng_make_state()
> >     -> crng_reseed()
> >       -> extract_entropy()
> >         -> blake2s_final()
> > 	  -> blake2s_compress()
> > 	    -> kernel_fpu_begin()=E2=80=A6
>=20
> kernel_fpu_begin() is no longer used from IRQ context, since there's no
> longer SIMD in IRQ context. So this callgraph isn't representative.

hard-IRQ context yes. But it is still used in preemptible context under
a raw_spinlock_t or with disabled interrupts/ preemption.
In the vsprintf/printk case it is invoked from preemptible context with
disabled interrupts.

> > This blake2s_compress() can be called again within this callchain (via
> > blake2s()). The problem here is that kernel_fpu_begin() disables
> > preemption and the following SIMD operation can be expensive (not to
> > mention the onetime register store) and so it is attempted to have a
> > scheduling point on a regular basis.
> > Invoking this call chain from an already preempt-disabled section would
> > not allow any scheduling at this point (and so build up the max. latency
> > worst case).
>=20
> Irrelevant, since kernel_fpu_begin() shouldn't be called in this context
> any more, right?

wrong, see above. It only excludes the in-hardirq users.=20

> > After looking at this after a break, while writing this and paging
> > everything in, I still think that initialising the random number at boot
> > up for vsprintf's sake is the easiest thing. One init for RT and non-RT
> > from an initcall. No hack, just one plain and simple init with no need
> > to perform anything later on demand.=20
>=20
> The "once at boot time" thing does not work here, as I've said over and
> over, if what we're talking about is the workqueued get_random_bytes_wait=
()
> call. The much smarter thing to do is let entropy be collected for as
> long as possible, and when the RNG is initialized, initialize the
> siphash secret, which is exactly what the current code does. So I think
> the current vnsprintf code can stay the same. What needs fixing, rather,
> are the lack of raw spinlocks in random.c...

Not get_random_bytes_wait() but get_random_bytes() + reschedule, see
	https://lkml.kernel.org/r/YueeIgPGUJgsnsAh@linutronix.de

> In light of my note on kernel_fpu_begin() not being used from IRQ
> context, can you now consider this raw spinlock patch?

No because it gives the wrong motivation to use this without fear from
section with disabled interrupts/ preemption as it is the case in the
current printk example. So it extends the runtime without the need for
it since it could have been upfront at a lower price.

I intend to resend the previously mentioned patch where there is _no_
get_random_bytes_wait() so I don't see how this can be a problem. Do you
see still one?

> Jason

Sebastian
