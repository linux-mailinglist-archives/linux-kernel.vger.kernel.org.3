Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E7584EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiG2Ke6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiG2Keu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:34:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9527974368
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:34:49 -0700 (PDT)
Date:   Fri, 29 Jul 2022 12:34:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659090887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wjKEfFoBLpJFt2YF9dVqJ/jX3GLUdZNKUnxCD/vP2U=;
        b=WdK32WKmR764zOr9uTC5dH/mB097scq2HOTJmpd6/amAP12jMqt5l06CFPAWb6Y/UFDe1K
        aLBc5h2FvGlCzELDTtGdNIBr7oNHQ/qFq7zT0+TSNv3w0uX7FOluK9+B9+ZpRTgiUW1bOx
        miCFGSgm44YFY5Z+EPR/9ftkeWxDxrNiZaB+oo+OUy3LaBPo+vjd6pHL0a5ceWu1mHioAC
        9nAEfFeRWN1YXjGQv19/JDKfRsDuD4cNAAAecFqd5jc2NDKa7q0EEMWzHXl/9r6mrDsdA1
        yc557HG/y0xpZO0Bs69KpR8USRJthXkk3pT0TEXQUn9l3XuLlC5s7FPeoQ/u8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659090887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wjKEfFoBLpJFt2YF9dVqJ/jX3GLUdZNKUnxCD/vP2U=;
        b=WVnf+1hZ0YFVmKOGk4NY0XUs6g0r8NJEnz4OvAkq4qv5lk9GC1u9w4T6tWAr3k4su/L1KE
        PYWtie4lxKwTd1AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Initialize vsprintf's pointer hash once the
 random core is ready.
Message-ID: <YuO3xmYr/UsKxten@linutronix.de>
References: <YuOf6qu453dOkR+S@linutronix.de>
 <YuO00GBXXNBhU4yL@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YuO00GBXXNBhU4yL@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-29 12:22:08 [+0200], Petr Mladek wrote:
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -221,10 +222,15 @@ static void crng_reseed(void)
> >  		++next_gen;
> >  	WRITE_ONCE(base_crng.generation, next_gen);
> >  	WRITE_ONCE(base_crng.birth, jiffies);
> > -	if (!static_branch_likely(&crng_is_ready))
> > +	if (!static_branch_likely(&crng_is_ready)) {
> >  		crng_init =3D CRNG_READY;
> > +		init_hash_pointer =3D true;
>=20
> I am not familiar with the crng code. I wonder if the following would wor=
k:
>=20
> 	if (!static_branch_likely(&crng_is_ready) && crng_init !=3D CRNG_READY) {
> 		crng_init =3D CRNG_READY;
> 		init_hash_pointer =3D true;
> 	}
>=20
> The point is that vsprintf_init_hash_pointer() will be called only by
> the first caller. It would allow to remove the @filling spin lock.

Not sure about the resulting code gen but crng_is_ready is swapped with
"crng_init =3D=3D CRNG_READY" and this patch already put init_hash_pointer
in an unlikely path so it might already what you suggest.

> > +	}
> >  	spin_unlock_irqrestore(&base_crng.lock, flags);
> >  	memzero_explicit(key, sizeof(key));
> > +
> > +	if (init_hash_pointer)
> > +		vsprintf_init_hash_pointer();
> >  }
> > =20
> >  /*
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index 3c1853a9d1c09..6fa2ebb9f9b9e 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -751,36 +751,30 @@ static int __init debug_boot_weak_hash_enable(cha=
r *str)
> >  early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
> > =20
> >  static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
> > +static siphash_key_t ptr_key __read_mostly;
> > =20
> > -static void enable_ptr_key_workfn(struct work_struct *work)
> > +void vsprintf_init_hash_pointer(void)
> >  {
> > -	static_branch_enable(&filled_random_ptr_key);
> > +	static DEFINE_SPINLOCK(filling);
> > +	unsigned long flags;
> > +	static bool filled;
> > +
> > +	spin_lock_irqsave(&filling, flags);
> > +	if (!filled) {
> > +		get_random_bytes(&ptr_key, sizeof(ptr_key));
> > +		filled =3D true;
> > +		static_branch_enable(&filled_random_ptr_key);
>=20
> This can't be called in an atomic context. Is crng_reseed() always
> called in a non-atomic context?

Since a "recent" change, get_random_bytes() and friends can't be called
=66rom an explicit IRQ-off/preempt-off region. There was a little bit of
fallout on the RT side with this change including lockdep and something
else I don't recall. So two users that invoked that from an IRQ-off
region on RT which is in general not the rule and the code was altered.

This (vsprintf) popped up recently since there isn't much that uses %p.
And since printk can (and should) be invoked everywhere I would like to
keep that working.

> That said, the static branch is an overkill. vsprintf() is a slow
> path. It should be enough to use a simple boolean. It might require
> a simple memory barrier to serialize @ptr_key and the new boolean
> read&write.

I could do that if it is preferred. It was already there, this isn't
something I just added=E2=80=A6

> > +	}
> > +	spin_unlock_irqrestore(&filling, flags);
> >  }
>=20
> Best Regards,
> Petr

Sebastian
