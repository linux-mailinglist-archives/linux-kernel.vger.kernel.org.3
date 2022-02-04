Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36C54A956F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 09:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbiBDIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 03:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbiBDIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 03:46:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BC7C061714;
        Fri,  4 Feb 2022 00:46:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B480DCE1B31;
        Fri,  4 Feb 2022 08:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DE7C004E1;
        Fri,  4 Feb 2022 08:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643964364;
        bh=MgwsHUz8xUyNw1Cn8QlvOpQEkb+oPhC2D2TUQ9ZUu9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gs7vVk+FBgSttLm7iIFwTypf16VeMuFVKGjnYoTz+3i215Qtuzm86BHhD9Sek1PN2
         wAwAUmjDmsMle/+DPYecxADPFmw1jGL4xN6PsnoUBOUn12Dqte5inUAQwzDafE/rtn
         E0QgSgx8NOJeqxX8+mZdF3Xb44yG0DJbejWxFZkNIOhch3rdym4s1NsCxRI6PY43o5
         2prJ9AAvLf4fPb7YSz4SWw9yG07XWFBLqanbpq1zyxJaFcNnDfNe6BV/CASe2dMopk
         wvkimeHadneyF/Grg4Igwt4OCz0BUixZn6eRhdSqM9y9+7rDOxemm+pmwxbDKFBj5C
         g9hyl5yh6sozg==
Date:   Fri, 4 Feb 2022 00:46:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
Message-ID: <YfznyWaVCz3Yl1ma@sol.localdomain>
References: <20220201161342.154666-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201161342.154666-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, Feb 01, 2022 at 05:13:42PM +0100, Jason A. Donenfeld wrote:
> This commit replaces the LFSR of mix_pool_bytes() with a straight-
> forward cryptographic hash function, BLAKE2s, which is already in use
> for pool extraction. Universal hashing with a secret seed was considered
> too, something along the lines of <https://eprint.iacr.org/2013/338>,
> but the requirement for a secret seed makes for a chicken & egg problem.
> Instead we go with a formally proven scheme using a computational hash
> function, described in section B.1.8 of <https://eprint.iacr.org/2019/198>.

What this patch does makes sense, but I'm having a hard time seeing how it maps
to the paper cited above.  Your code seems to be treating BLAKE2s as an
arbitrary-length PRF, but "Construction 8" in section B.1 of the paper is
working with the raw compression function of a hash function.  Can you clarify?

> -/*
> - * Originally, we used a primitive polynomial of degree .poolwords
> - * over GF(2).  The taps for various sizes are defined below.  They
> - * were chosen to be evenly spaced except for the last tap, which is 1
> - * to get the twisting happening as fast as possible.
> - *

The "Theory of operation" comment at the top of the file needs to be updated
too.

> +static void _extract_entropy(void *buf, size_t nbytes)
>  {
> -	struct blake2s_state state __aligned(__alignof__(unsigned long));
> -	u8 hash[BLAKE2S_HASH_SIZE];
> -	unsigned long *salt;
>  	unsigned long flags;
> -
> -	blake2s_init(&state, sizeof(hash));
> -
> -	/*
> -	 * If we have an architectural hardware random number
> -	 * generator, use it for BLAKE2's salt & personal fields.
> -	 */
> -	for (salt = (unsigned long *)&state.h[4];
> -	     salt < (unsigned long *)&state.h[8]; ++salt) {
> -		unsigned long v;
> -		if (!arch_get_random_long(&v))
> -			break;
> -		*salt ^= v;
> +	u8 seed[BLAKE2S_HASH_SIZE], next_key[BLAKE2S_HASH_SIZE];
> +	struct {
> +		unsigned long rdrand[32 / sizeof(long)];
> +		size_t counter;
> +	} block;
> +	size_t i;
> +
> +	for (i = 0; i < ARRAY_SIZE(block.rdrand); ++i) {
> +		if (!arch_get_random_long(&block.rdrand[i]))
> +			block.rdrand[i] = random_get_entropy();
>  	}
>  
> -	/* Generate a hash across the pool */
>  	spin_lock_irqsave(&input_pool.lock, flags);
> -	blake2s_update(&state, (const u8 *)input_pool_data, POOL_BYTES);
> -	blake2s_final(&state, hash); /* final zeros out state */
>  
> -	/*
> -	 * We mix the hash back into the pool to prevent backtracking
> -	 * attacks (where the attacker knows the state of the pool
> -	 * plus the current outputs, and attempts to find previous
> -	 * outputs), unless the hash function can be inverted. By
> -	 * mixing at least a hash worth of hash data back, we make
> -	 * brute-forcing the feedback as hard as brute-forcing the
> -	 * hash.
> -	 */
> -	__mix_pool_bytes(hash, sizeof(hash));
> -	spin_unlock_irqrestore(&input_pool.lock, flags);
> +	/* seed = HASHPRF(last_key, entropy_input) */
> +	blake2s_final(&input_pool.hash, seed);
>  
> -	/* Note that EXTRACT_SIZE is half of hash size here, because above
> -	 * we've dumped the full length back into mixer. By reducing the
> -	 * amount that we emit, we retain a level of forward secrecy.
> -	 */
> -	memcpy(out, hash, EXTRACT_SIZE);
> -	memzero_explicit(hash, sizeof(hash));
> -}
> +	/* next_key = HASHPRF(key, RDRAND || 0) */

In the above comment, 'key' should be 'seed'.

>  	while (nbytes) {
> -		extract_buf(tmp);
> -		i = min_t(int, nbytes, EXTRACT_SIZE);
> -		memcpy(buf, tmp, i);
> +		i = min_t(size_t, nbytes, BLAKE2S_HASH_SIZE);
> +		/* output = HASHPRF(key, RDRAND || ++counter) */

Likewise above.

- Eric
