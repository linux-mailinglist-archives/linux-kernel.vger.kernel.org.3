Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7E4AECA8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiBIIhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:37:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbiBIIg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:36:59 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE23AC050CE1;
        Wed,  9 Feb 2022 00:36:56 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id CD2E220142C;
        Wed,  9 Feb 2022 08:31:15 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id A0AEC808FB; Wed,  9 Feb 2022 09:30:16 +0100 (CET)
Date:   Wed, 9 Feb 2022 09:30:16 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, ebiggers@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 7/9] random: use simpler fast key erasure flow on
 per-cpu keys
Message-ID: <YgN7mOTtQ03etVJX@owl.dominikbrodowski.net>
References: <20220209011919.493762-1-Jason@zx2c4.com>
 <20220209011919.493762-8-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209011919.493762-8-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nice work, just a few minor queries:

> -static void extract_crng(u8 out[CHACHA_BLOCK_SIZE])
> +/*
> + * The general form here is based on a "fast key erasure RNG" from
> + * <https://blog.cr.yp.to/20170723-random.html>. It generates a ChaCha
> + * block using the provided key, and then immediately overwites that
> + * key with half the block. It returns the resultant ChaCha state to the
> + * user, along with the second half of the block containing 32 bytes of
> + * random data that may be used; random_data_len may not be greater than
> + * 32.
> + */
> +static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
> +				  u32 chacha_state[CHACHA_STATE_WORDS],
> +				  u8 *random_data, size_t random_data_len)
>  {
> -	unsigned long flags, init_time;
> +	u8 first_block[CHACHA_BLOCK_SIZE];

Do we need a BUG_ON(random_data_len > 32) here?

>  
> -	if (crng_ready()) {
> -		init_time = READ_ONCE(primary_crng.init_time);
> -		if (time_after(jiffies, init_time + CRNG_RESEED_INTERVAL))
> -			crng_reseed();
> -	}
> -	spin_lock_irqsave(&primary_crng.lock, flags);
> -	chacha20_block(&primary_crng.state[0], out);
> -	if (primary_crng.state[12] == 0)
> -		primary_crng.state[13]++;
> -	spin_unlock_irqrestore(&primary_crng.lock, flags);
> +	chacha_init_consts(chacha_state);
> +	memcpy(&chacha_state[4], key, CHACHA_KEY_SIZE);
> +	memset(&chacha_state[12], 0, sizeof(u32) * 4);

No IV, no generation counter here? As you already have a generation counter
in use for other purposes, why not use it here as well as some non-zero
starting point?

Otherwise, it looks really nice.

Thanks,
	Dominik
