Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86474AE584
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbiBHXjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiBHXjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:39:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDDEC061576;
        Tue,  8 Feb 2022 15:39:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 568E5B81DA9;
        Tue,  8 Feb 2022 23:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40BDC340E9;
        Tue,  8 Feb 2022 23:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644363558;
        bh=yMY3ujgnw8WZsA6PCk5QbPpvUzsJpDtHkDlAD+YNtSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jw1V4XGmGLZPKaBNrlcMeYT+RbChYEdU3iioIDMSBdIahgjSNL2sBaJ6fAQvc/qEg
         SUH0DV2A+KTjF5SF5RE00QpqntZZ2ChikZ4PwnZBb3r3F7WrPMwmtfJ6oRhsEmyvj7
         QEi/3fNAmt3AiTUXLKaB32hc3gHPY9a3N/5VU3MF3tQis3gccGu3kiTTvCY7M5eW0e
         q6yGo51KxMVU0jnSrIJJhtUZNLiGpTQf5zVnYi3UoLDdcSBynXmnsN/xeDM69oApz1
         omDxU3RktKNwNujLqtSgIiDIFEt1K3c9pBvL0o725OhnQvVNam/krVGx/giv8/2fQV
         WyCpY4yqUO+8g==
Date:   Tue, 8 Feb 2022 15:39:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 6/7] random: use simpler fast key erasure flow on
 per-cpu keys
Message-ID: <YgL/JN+ObjfhEedk@sol.localdomain>
References: <20220208155335.378318-1-Jason@zx2c4.com>
 <20220208155335.378318-7-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208155335.378318-7-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, Feb 08, 2022 at 04:53:34PM +0100, Jason A. Donenfeld wrote:
> Rather than the clunky NUMA full ChaCha state system we had prior, this
> commit is closer to the original "fast key erasure RNG" proposal from
> <https://blog.cr.yp.to/20170723-random.html>, by simply treating ChaCha
> keys on a per-cpu basis.
> 
> All entropy is extracted to a base crng key of 32 bytes. This base crng
> has a birthdate and a generation counter. When we go to take bytes from
> the crng, we first check if the birthdate is too old; if it is, we
> reseed per usual. Then we start working on a per-cpu crng.
> 
> This per-cpu crng makes sure that it has the same generation counter as
> the base crng. If it doesn't, it does fast key erasure with the base
> crng key and uses the output as its new per-cpu key, and then updates
> its local generation counter. Then, using this per-cpu state, we do
> ordinary fast key erasure. Half of this first block is used to overwrite
> the per-cpu crng key for the next call -- this is the fast key erasure
> RNG idea -- and the other half, along with the ChaCha state, is returned
> to the caller. If the caller desires more than this remaining half, it
> can generate more ChaCha blocks, unlocked, using the now detached ChaCha
> state that was just returned. Crypto-wise, this is more or less what we
> were doing before, but this simply makes it more explicit and ensures
> that we always have backtrack protection by not playing games with a
> shared block counter.
> 
> The flow looks like this:
> 
> ──extract()──► base_crng.key ◄──memcpy()───┐
>                    │                       │
>                    └──chacha()──────┬─► new_base_key
>                                     └─► crngs[n].key ◄──memcpy()───┐
>                                               │                    │
>                                               └──chacha()───┬─► new_key
>                                                             └─► random_bytes
>                                                                       │
>                                                                       └────►
> 
> There are a few hairy details around early init. Just as was done
> before, prior to having gathered enough entropy, crng_fast_load() and
> crng_slow_load() dump bytes directly into the base crng, and when we go
> to take bytes from the crng, in that case, we're doing fast key erasure
> with the base crng rather than the fast unlocked per-cpu crngs. This is
> fine as that's only the state of affairs during very early boot; once
> the crng initializes we never use these paths again.
> 
> In the process of all this, the APIs into the crng become a bit simpler:
> we have get_random_bytes(buf, len) and get_random_bytes_user(buf, len),
> which both do what you'd expect. All of the details of fast key erasure
> and per-cpu selection happen only in a very short critical section of
> crng_make_state(), which selects the right per-cpu key, does the fast
> key erasure, and returns a local state to the caller's stack. So, we no
> longer have a need for a separate backtrack function, as this happens
> all at once here. The API then allows us to extend backtrack protection
> to batched entropy without really having to do much at all.
> 
> The result is a bit simpler than before and has fewer foot guns. The
> init time state machine also gets a lot simpler as we don't need to wait
> for workqueues to come online and do deferred work. And the multi-core
> performance should be increased significantly, by virtue of having hardly
> any locking on the fast path.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 278 +++++++++++++++++++++++++-----------------
>  1 file changed, 169 insertions(+), 109 deletions(-)

This looks like a big improvement, thanks.  A few comments below.

>  static void crng_reseed(void)
>  {
>  	unsigned long flags;
> -	int i, entropy_count;
> -	union {
> -		u8 block[CHACHA_BLOCK_SIZE];
> -		u32 key[8];
> -	} buf;
> +	int entropy_count;
> +	unsigned long next_gen;
> +	u8 key[CHACHA_KEY_SIZE];
>  
>  	do {
>  		entropy_count = READ_ONCE(input_pool.entropy_count);
>  		if (entropy_count < POOL_MIN_BITS)
>  			return;
>  	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
> -	extract_entropy(buf.key, sizeof(buf.key));
> +	extract_entropy(key, sizeof(key));
>  	wake_up_interruptible(&random_write_wait);
>  	kill_fasync(&fasync, SIGIO, POLL_OUT);
>  
> -	spin_lock_irqsave(&primary_crng.lock, flags);
> -	for (i = 0; i < 8; i++)
> -		primary_crng.state[i + 4] ^= buf.key[i];
> -	memzero_explicit(&buf, sizeof(buf));
> -	WRITE_ONCE(primary_crng.init_time, jiffies);
> -	spin_unlock_irqrestore(&primary_crng.lock, flags);
> +	spin_lock_irqsave(&base_crng.lock, flags);
> +	memcpy(base_crng.key, key, sizeof(base_crng.key));
> +	next_gen = base_crng.generation + 1;
> +	if (next_gen == ULONG_MAX)
> +		++next_gen;
> +	WRITE_ONCE(base_crng.generation, next_gen);
> +	base_crng.birth = jiffies;
> +	spin_unlock_irqrestore(&base_crng.lock, flags);
> +	memzero_explicit(key, sizeof(key));

Previously, the extracted entropy was being XOR'ed into the ChaCha key.  Now the
key is just being overwritten.  This is the approach we should be aiming for,
but I'm concerned about the fact that add_interrupt_randomness() still sometimes
adds entropy to the ChaCha key directly without mixing it into the entropy pool.
That happens via crng_fast_load() when crng_init == 0.  This new approach will
destroy any entropy that was present in the key only.

The right fix, IMO, would be to always send entropy through the entropy pool.
Until that is done, though, I'm not sure it's a good idea to overwrite the key
like this.

Unrelated: this function could use some comments that explain what is going on.

> +/*
> + * The general form here is based on a "fast key erasure RNG" from:
> + * https://blog.cr.yp.to/20170723-random.html
> + */
> +static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
> +				  u32 chacha_state[CHACHA_STATE_WORDS],
> +				  u8 random_data[32], size_t random_data_len)

Given that random_data is variable-length it should be a 'u8 *'.

Also, the above comment could use some more explanation.  I.e. what does this
function actually *do*.  (I understand it, but a comment will really help any
future readers...)

> + /*
> + * This function returns a ChaCha block that you may use for generating

ChaCha state, not ChaCha block.

> + * random data. It also returns up to 32 bytes on its own of random data
> + * that may be used.
> +*/
> +static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
> +			    u8 random_data[32], size_t random_data_len)

Likewise, it's weird having random_data be declared as length 32 when it's
actually variable-length.

>  {
>  	unsigned long flags;
> -	u32 *s, *d;
> -	int i;
> +	struct crng *crng;
> +
> +	/* For the fast path, we check this unlocked first. */
> +	if (unlikely(!crng_ready())) {
> +		bool not_ready;
> +
> +		spin_lock_irqsave(&base_crng.lock, flags);
> +		/* Now that we're locked, re-check. */
> +		not_ready = !crng_ready();
> +		if (not_ready)
> +			crng_fast_key_erasure(base_crng.key, chacha_state,
> +					      random_data, random_data_len);
> +		spin_unlock_irqrestore(&base_crng.lock, flags);
> +		if (!not_ready)
> +			return;
> +	}

Isn't the '!not_ready' check above backwards?  And in case case, doubly-inverted
logic like that should be avoided.

And again, a few more comments please :-)

>  struct batched_entropy {
>  	union {
> -		u64 entropy_u64[CHACHA_BLOCK_SIZE / sizeof(u64)];
> -		u32 entropy_u32[CHACHA_BLOCK_SIZE / sizeof(u32)];
> +		u64 entropy_u64[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u64))];
> +		u32 entropy_u32[CHACHA_BLOCK_SIZE * 3 / (2 * sizeof(u32))];
>  	};

The above numbers could use an explanation.

>  /*
>   * Get a random word for internal kernel use only. The quality of the random
> - * number is good as /dev/urandom, but there is no backtrack protection, with
> - * the goal of being quite fast and not depleting entropy. In order to ensure
> - * that the randomness provided by this function is okay, the function
> - * wait_for_random_bytes() should be called and return 0 at least once at any
> - * point prior.
> + * number is good as /dev/urandom. In order to ensure that the randomness
> + * provided by this function is okay, the function wait_for_random_bytes()
> + * should be called and return 0 at least once at any point prior.
>   */

There's also a comment at the top of the file that still claims that
get_random_int() et al. don't implement backtracking protection.  That needs to
be updated.

- Eric
