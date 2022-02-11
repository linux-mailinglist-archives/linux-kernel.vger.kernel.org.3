Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1D04B2ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351660AbiBKQo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:44:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiBKQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:44:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977C3102;
        Fri, 11 Feb 2022 08:44:21 -0800 (PST)
Date:   Fri, 11 Feb 2022 17:44:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644597860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0A1YAzfFVguyJP3Z4agEv2LMfFbEvYq8NP31pPvmRuM=;
        b=Y205eAYN6GtUImSDfmTa9eAMD3AjxSfoik2fzsehBPIyb5lUHYPcy+9Xo1CyrUZi5gjrnf
        K4mMBahzDzyztjLKz2gcGNKvOZPNg6nk/3mTHeyv1Y2Z3QoWH4WYAfyETK5GfRaMtjCbnX
        QyTsy/Vb+7fO2lu4+IXUx52MW+g/TnEudqfzUykR/iM208tGX8SCjgZp3mxMw8iDhkOnwU
        JYan1ocAZCnbnwy+yXuJDLG+v4aGv9oMkD9d/qS/n5MCJvRRxyuqZv6XHXoxt5b/oNiSlW
        DuYIw2T3uF4YPNSx4TqRYtRaWGtJ/Oz7Mrl9dT4T7ENoiwHADq09r1WiIDYdCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644597860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0A1YAzfFVguyJP3Z4agEv2LMfFbEvYq8NP31pPvmRuM=;
        b=/GiC4jLw0zWz3Pg2Jd+PX0zj+hJXLwZhxY0zFwZX5VtkbzBHLnwWdHLX/vKEo/QYpjAGLh
        fbB5mqNQtIzTtUDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v6] random: defer fast pool mixing to worker
Message-ID: <YgaSYlVEBOxfJbSD@linutronix.de>
References: <YgZ6IEbiDgz5X1ON@linutronix.de>
 <20220211162515.554867-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220211162515.554867-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 17:25:15 [+0100], Jason A. Donenfeld wrote:
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index c42c07a7eb56..20b11a4b6559 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1214,12 +1215,59 @@ static u32 get_reg(struct fast_pool *f, struct pt=
_regs *regs)
>  	return *ptr;
>  }
> =20
> +static void mix_interrupt_randomness(struct work_struct *work)
> +{
> +	struct fast_pool *fast_pool =3D container_of(work, struct fast_pool, mi=
x);
> +	unsigned long pool[ARRAY_SIZE(fast_pool->pool)];
> +	int count;
> +
> +	/* Check to see if we're running on the wrong CPU due to hotplug. */
> +	migrate_disable();
> +	if (fast_pool !=3D this_cpu_ptr(&irq_randomness)) {
> +		migrate_enable();
> +		/*
> +		 * If we are unlucky enough to have been moved to another CPU,

+ "during CPU hotplug while the CPU was shutdown". It should not look
like the worker can be migrated on system without CPU-hotplug involved.

> +		 * then we set our count to zero atomically so that when the
> +		 * CPU comes back online, it can enqueue work again. The
> +		 * _release here pairs with the atomic_inc_return_acquire in
> +		 * add_interrupt_randomness().
> +		 */
> +		atomic_set_release(&fast_pool->count, 0);
> +		return;
> +	}
> +
> +	/*
> +	 * Copy the pool to the stack so that the mixer always has a
> +	 * consistent view. It's extremely unlikely but possible that
> +	 * this 2 or 4 word read is interrupted by an irq, but in case
> +	 * it is, we double check that count stays the same.
> +	 *
> +	 * We set the count to 0 so that irqs can immediately begin to
> +	 * accumulate again after. Since any possible interruptions
> +	 * at this stage are guaranteed to be on the same CPU, we can
> +	 * use cmpxchg_relaxed.
> +	 */
> +	count =3D atomic_read(&fast_pool->count);
> +	do {
> +		memcpy(pool, fast_pool->pool, sizeof(pool));
> +	} while (atomic_try_cmpxchg_relaxed(&fast_pool->count, &count, 0));

I *think* we could drop that "fast_pool !=3D
this_cpu_ptr(&irq_randomness)" check at the top since that cmpxchg will
save us and redo the loop. But if I remember correctly you worried about
fast_pool->pool being modified (which is only a corner case if we are on
the other CPU while the orig CPU is back again). Either way, it would be
random and we would not consume more entropy.

So if we have to keep this then please swap that migrate_disable() with
local_irq_disable(). Otherwise PeterZ will yell at me.

> +	fast_pool->last =3D jiffies;
> +	migrate_enable();
> +
> +	mix_pool_bytes(pool, sizeof(pool));
> +	credit_entropy_bits(1);
> +	memzero_explicit(pool, sizeof(pool));
> +}
> +
=E2=80=A6
> @@ -1235,12 +1283,13 @@ void add_interrupt_randomness(int irq)
>  	}
> =20
>  	fast_mix((u32 *)fast_pool->pool);
> -	++fast_pool->count;
> +	/* The _acquire here pairs with the atomic_set_release in mix_interrupt=
_randomness(). */
> +	new_count =3D (unsigned int)atomic_inc_return_acquire(&fast_pool->count=
);
> =20
>  	if (unlikely(crng_init =3D=3D 0)) {
> -		if (fast_pool->count >=3D 64 &&
> +		if (new_count >=3D 64 &&
>  		    crng_fast_load(fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
> -			fast_pool->count =3D 0;
> +			atomic_set(&fast_pool->count, 0);
>  			fast_pool->last =3D now;

I'm fine if we keep this as is for now.
What do we do here vs RT? I suggested this
  https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/com=
mit/?id=3Da2d2d54409481aa23a3e11ab9559a843e36a79ec

Is this doable?

Sebastian
