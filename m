Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A86A4A6CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbiBBIgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:36:07 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:35363 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiBBIgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1643790953;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=2RgRSgvZC6fCvmfbCvlnqVQOcprwtpdFnNFaDNwhfRg=;
    b=enQ0Ce67aRW679Rn9BlzDj1a/EFNG7RiHHeOf8bBG5URO9quexbRO0M2HOirRofSTH
    jraK+Wls9jXWbNVt04xA86Js/WS5X5TjEdNje9BUOqitzw6Cw4hLLN/WKYyHZHm2OGHo
    RSl1DxOVQJYQ5LVMIrs4xLkCEPNRU3HJsnaXr0YJIOJIrJovP+AoOze8C3zgmaKe69bm
    YHolmSbk8BVgS5RkLwabh9n1lCdgZIylqhCW94qvTSo0LPPExkKFduYU6Hh177e2y0o/
    qwp7dkUaKaH29mKgeYWoIfbF7pcjdOjqMcNBPyIWVTamWbrqMEnap9XHrCiTd6eg/jFy
    rJdA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zW8BKRp5UFiyGZZ4jof7Xg=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.39.0 AUTH)
    with ESMTPSA id z28df7y128Zr8mk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 2 Feb 2022 09:35:53 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH] random: use computational hash for entropy extraction
Date:   Wed, 02 Feb 2022 09:35:52 +0100
Message-ID: <1920812.EuvsCRJjSr@tauon.chronox.de>
In-Reply-To: <20220201161342.154666-1-Jason@zx2c4.com>
References: <20220201161342.154666-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 1. Februar 2022, 17:13:42 CET schrieb Jason A. Donenfeld:

Hi Jason,

> + * This is an HKDF-like construction for using the hashed collected entropy
> + * as a PRF key, that's then expanded block-by-block.
>   */
> -static void extract_buf(u8 *out)
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
> +	block.counter = 0;
> +	blake2s(next_key, (u8 *)&block, seed, sizeof(next_key), sizeof(block),
> sizeof(seed)); +	blake2s_init_key(&input_pool.hash, BLAKE2S_HASH_SIZE,
> next_key, sizeof(next_key));
> 
> -static ssize_t _extract_entropy(void *buf, size_t nbytes)
> -{
> -	ssize_t ret = 0, i;
> -	u8 tmp[EXTRACT_SIZE];
> +	spin_unlock_irqrestore(&input_pool.lock, flags);
> +	memzero_explicit(next_key, sizeof(next_key));
> 
>  	while (nbytes) {
> -		extract_buf(tmp);
> -		i = min_t(int, nbytes, EXTRACT_SIZE);
> -		memcpy(buf, tmp, i);
> +		i = min_t(size_t, nbytes, BLAKE2S_HASH_SIZE);
> +		/* output = HASHPRF(key, RDRAND || ++counter) */
> +		++block.counter;
> +		blake2s(buf, (u8 *)&block, seed, i, sizeof(block), 
sizeof(seed));

May I ask why this expansion step is needed?

The pool size as denominated by POOL_BITS is equal to the message digest size 
of Blake - this is appropriate as this is the maximum amount of entropy Blake 
can transport if Blake is assumed to be an appropriate hash. Thus, the pool 
cannot generate more data without being reseeded as otherwise Blake is not a 
conditioner but acts as a random number generator "streching" the entropy.

Looking at the invokers of _extract_entropy it looks like all of them invoke 
this function to generate 32 bytes, i.e. BLAKE2S_HASH_SIZE. To me it looks 
like this streching function is not really used.

Even if the caller of this function requests more bytes at one point in time, 
may I ask whether delivering more bits than entropy is can ever be present in 
the pool is appropriate? As Blake acts as a conditioner, shouldn't it limit 
the output size to the maximum entropy it can convey? I.e. at most one Blake 
block should be generated in the extract function. Naturally, it can be 
truncated if the caller requests less data.


Ciao
Stephan


