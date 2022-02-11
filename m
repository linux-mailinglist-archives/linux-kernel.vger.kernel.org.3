Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5564B1FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbiBKIQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:16:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiBKIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:16:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047CD3B4;
        Fri, 11 Feb 2022 00:16:08 -0800 (PST)
Date:   Fri, 11 Feb 2022 09:16:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644567366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+x3qzrthcYbe2N3LUX9yMDD1x1KbRUYFpnIwpgzq/Wg=;
        b=GyXx5qTAPaN0DaWUddLN+Vu7N0BN4cAzQo6OcCMvi21A/y68KkHClCp6xOlSvRzGeXRTWE
        mH3Z82hLjzWPIqt54hurB1df0tu5Dz4jPWe3+KgEoMLG9m4INIP4XwSbH6ohk7daywQlCH
        j02FxceWvD6L84/89t7RdVnaHJrQlweCDqq2kdjZnTkGRIx3lr6ienYBG3LwBl/xE2lcKD
        u1Ao/js4Hl/+RK7pcZjUPapzbFxymh/ZchiFbTzYZFydFUbjeAu5EtfMX2vW+NHLU8MfEv
        WoUZ7FBmjJ70zi6OVwGpSI6yZ636kgShdMVumplybDnFiWN1Niqx04TfC9rTRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644567366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+x3qzrthcYbe2N3LUX9yMDD1x1KbRUYFpnIwpgzq/Wg=;
        b=pp4cx9gUvEs/It6lzD6bKy162M9aD60/7pwQA+l3GiLgYYzljwnzEnqgZ2wtJuXqI50xjd
        UAH/Z16Iq2aJ0yDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] random: ensure mix_interrupt_randomness() is consistent
Message-ID: <YgYbRa+5cC0ivWrK@linutronix.de>
References: <CAHmME9pGwyZKu=9yCben-V30hR+zEjb9iZGWr5_RAE-uXt_Ofw@mail.gmail.com>
 <20220211011446.392673-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220211011446.392673-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-11 02:14:46 [+0100], Jason A. Donenfeld wrote:
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 9c779f1bda34..caaf3c33bb38 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1210,14 +1211,39 @@ static u32 get_reg(struct fast_pool *f, struct pt_regs *regs)
>  static void mix_interrupt_randomness(struct work_struct *work)
>  {
>  	struct fast_pool *fast_pool = container_of(work, struct fast_pool, mix);
> -	u32 pool[ARRAY_SIZE(fast_pool->pool32)];
> +	unsigned long pool[ARRAY_SIZE(fast_pool->pool_long)];
> +	unsigned int count_snapshot;
> +	size_t i;
>  
> -	/* Copy the pool to the stack so that the mixer always has a consistent view. */
> -	memcpy(pool, fast_pool->pool32, sizeof(pool));
> +	/* Check to see if we're running on the wrong CPU due to hotplug. */
> +	migrate_disable();
> +	if (fast_pool != this_cpu_ptr(&irq_randomness)) {

I am not sure that acquire and release semantic is needed and if so a
comment would probably be helpful to explain why.
But I'm trying to avoid the migrate_disable(), so:
To close the racy with losing the workqueue bit, wouldn't it be
sufficient to set it to zero via atomic_cmpxchg()? Also if the counter
before the memcpy() and after (at cmpxchg time) didn't change then the
pool wasn't modified. So basically 

 do {
 	counter = atomic_read(&fast_pool->count); // no need to cast
	memcpy(pool, fast_pool->pool_long, ARRAY_SIZE(pool));
    } while (atomic_cmpxchg(&fast_pool->count, counter, 0) != counter);


then it also shouldn't matter if we are _accidentally_ on the wrong CPU.

> +		migrate_enable();
> +		/*
> +		 * If we are unlucky enough to have been moved to another CPU,
> +		 * then we set our count to zero atomically so that when the
> +		 * CPU comes back online, it can enqueue work again.
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
> +	 */
> +	do {
> +		count_snapshot = (unsigned int)atomic_read(&fast_pool->count);
> +		for (i = 0; i < ARRAY_SIZE(pool); ++i)
> +			pool[i] = READ_ONCE(fast_pool->pool_long[i]);

Why do you avoid memcpy()? Since it is a small memcpy, I'm sure the
compile will inline the register moves.

Sebastian
