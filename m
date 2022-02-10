Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234DC4B0604
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiBJGE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:04:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiBJGEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:04:47 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EEA1D9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:04:47 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 27645201427;
        Thu, 10 Feb 2022 06:04:46 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id E935E805A4; Thu, 10 Feb 2022 07:00:33 +0100 (CET)
Date:   Thu, 10 Feb 2022 07:00:33 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: tie batched entropy generation to base_crng
 generation
Message-ID: <YgSqAbggkgdAtkcm@owl.dominikbrodowski.net>
References: <CAHmME9pZB1fWf2nZNwTHw07hrnxZYYymA0_Dy=jauDt9TbF69A@mail.gmail.com>
 <20220209215406.18850-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209215406.18850-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Feb 09, 2022 at 10:54:06PM +0100 schrieb Jason A. Donenfeld:
> Now that we have an explicit base_crng generation counter, we don't need
> a separate one for batched entropy. Rather, we can just move the
> generation forward every time we change crng_init state.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 999f1d164e72..f4d432305869 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -431,8 +431,6 @@ static DEFINE_PER_CPU(struct crng, crngs) = {
>  
>  static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
>  
> -static void invalidate_batched_entropy(void);
> -
>  /*
>   * crng_fast_load() can be called by code in the interrupt service
>   * path.  So we can't afford to dilly-dally. Returns the number of
> @@ -455,7 +453,7 @@ static size_t crng_fast_load(const void *cp, size_t len)
>  		src++; crng_init_cnt++; len--; ret++;
>  	}
>  	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
> -		invalidate_batched_entropy();
> +		++base_crng.generation;
>  		crng_init = 1;
>  	}
>  	spin_unlock_irqrestore(&base_crng.lock, flags);

This will only ever increase base_crng.generation from 0 to 1, and the
proper lock is held. The base_crng.key has changed, so it's appropriate
to state that it has reached a new generation.

> @@ -536,7 +534,6 @@ static void crng_reseed(void)
>  	spin_unlock_irqrestore(&base_crng.lock, flags);
>  	memzero_explicit(key, sizeof(key));
>  	if (finalize_init) {
> -		invalidate_batched_entropy();
>  		process_random_ready_list();
>  		wake_up_interruptible(&crng_init_wait);
>  		kill_fasync(&fasync, SIGIO, POLL_IN);

In crng_reseed(), base_crng.generation is incremented above while holding
the lock, and checked that it doesn't reach ULONG_MAX. OK.

> @@ -1278,7 +1275,7 @@ int __init rand_initialize(void)
>  
>  	extract_entropy(base_crng.key, sizeof(base_crng.key));
>  	if (arch_init && trust_cpu && crng_init < 2) {
> -		invalidate_batched_entropy();
> +		++base_crng.generation;
>  		crng_init = 2;
>  		pr_notice("crng init done (trusting CPU's manufacturer)\n");
>  	}

Here we do not need to take a lock (single-threaded operation), can only be
at generation 0 or 1, and the base_crng.key has changed. Which leads me to
ask: shouldn't we increase the generation counter always (or at least if
arch_init is true)? And just make icnrementing crng_init to 2 depending on
trust_cpu?

To sum it up:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
