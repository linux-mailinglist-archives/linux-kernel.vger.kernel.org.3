Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2823D4BD4CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 05:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbiBUEeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 23:34:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343819AbiBUEeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 23:34:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F7440E4E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 20:34:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA9B360F55
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3F8C340EB;
        Mon, 21 Feb 2022 04:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645418061;
        bh=69tx/nnQdLaiomHt26LNrxl+X2R5NsiPj72CnBzqBxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLDBIHtaPI+6Jx07XoDbl5FRhS2Tv+UMOxEzOacf9nuP3TlB/WZqPYF+AgIy9G/JG
         7J3p8i9p8z26Kg6QkAq4CtTeJA5Fh7ikb8voBle3Av3klS8pBkNHGqwByv+ngv2i+x
         YNiFB7ek+m8AspMKE5577zQmlKrE2tiVxfKDuR2d+aK0Nvqy9ELEVkc5OUjFBvy758
         I/w/8dbkNFVXYaX8jL76LA/OdSvgxCCw0Vv+t9sJYA4b8hyOu541nEQJtHSJ06GmqT
         hFyOtztbyG5kI3oIVDTwffMfYFYT9MY4hEkA9tsbbkM852AdKD5c4IEVDh04wa1FE5
         hQgXAmgrHIo9A==
Date:   Sun, 20 Feb 2022 20:34:19 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 01/10] random: introduce drain_entropy() helper to
 declutter crng_reseed()
Message-ID: <YhMWS+gxKdrQIFwo@sol.localdomain>
References: <20220212122318.623435-1-Jason@zx2c4.com>
 <20220212122318.623435-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212122318.623435-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:23:09PM +0100, Jason A. Donenfeld wrote:
> In preparation for separating responsibilities, break out the entropy
> count management part of crng_reseed() into its own function.
> 
> No functional changes.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 44a20a1a1b3a..436b146b33be 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -260,6 +260,7 @@ static struct {
>  };
>  
>  static void extract_entropy(void *buf, size_t nbytes);
> +static bool drain_entropy(void *buf, size_t nbytes);
>  
>  static void crng_reseed(void);
>  
> @@ -453,22 +454,13 @@ static void crng_slow_load(const void *cp, size_t len)
>  static void crng_reseed(void)
>  {
>  	unsigned long flags;
> -	int entropy_count;
>  	unsigned long next_gen;
>  	u8 key[CHACHA_KEY_SIZE];
>  	bool finalize_init = false;
>  
> -	/* First we make sure we have POOL_MIN_BITS of entropy in the pool,
> -	 * and then we drain all of it. Only then can we extract a new key.
> -	 */
> -	do {
> -		entropy_count = READ_ONCE(input_pool.entropy_count);
> -		if (entropy_count < POOL_MIN_BITS)
> -			return;
> -	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
> -	extract_entropy(key, sizeof(key));
> -	wake_up_interruptible(&random_write_wait);
> -	kill_fasync(&fasync, SIGIO, POLL_OUT);
> +	/* Only reseed if we can, to prevent brute forcing a small amount of new bits. */
> +	if (!drain_entropy(key, sizeof(key)))
> +		return;
>  
>  	/* We copy the new key into the base_crng, overwriting the old one,
>  	 * and update the generation counter. We avoid hitting ULONG_MAX,
> @@ -893,6 +885,25 @@ static void extract_entropy(void *buf, size_t nbytes)
>  	memzero_explicit(&block, sizeof(block));
>  }
>  
> +/*
> + * First we make sure we have POOL_MIN_BITS of entropy in the pool,
> + * and then we drain all of it. Only then can we extract a new key
> + * with extract_entropy().
> + */
> +static bool drain_entropy(void *buf, size_t nbytes)
> +{
> +	unsigned int entropy_count;
> +	do {
> +		entropy_count = READ_ONCE(input_pool.entropy_count);
> +		if (entropy_count < POOL_MIN_BITS)
> +			return false;
> +	} while (cmpxchg(&input_pool.entropy_count, entropy_count, 0) != entropy_count);
> +	extract_entropy(buf, nbytes);
> +	wake_up_interruptible(&random_write_wait);
> +	kill_fasync(&fasync, SIGIO, POLL_OUT);
> +	return true;
> +}

Looks good, but perhaps the comment should clarify that drain_entropy() doesn't
destroy the entropy in the pool, but rather just extracts it and zeroes out the
entropy counter?

- Eric
