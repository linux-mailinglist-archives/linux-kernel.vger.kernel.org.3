Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00BB4AA73D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 08:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379558AbiBEHAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 02:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379537AbiBEHAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 02:00:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDC6C061346;
        Fri,  4 Feb 2022 23:00:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4795B83974;
        Sat,  5 Feb 2022 07:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA3CC340EC;
        Sat,  5 Feb 2022 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644044432;
        bh=KV8QhN6XRu/XHDt8nX6cgJHkSVC1Kxqfken2oBekNfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAYODqXTNEsrvV8A+PZfYGiKkYPvIq2S/upi3qW1VnxAEiHhDQfDkyYREfLYYt6Ak
         Imm6zCdstdyrbX9Ay0HLzivfW/4C4B/Mi8sJmdAKbE0fKVNrj+f8ooN+4+7v/wEyx5
         sJilbOYUhxNVwxP2ECaUVgLfI8SE+dimjwM7eJfD2OaEZF8yyslgE5ikuPZfczSKy0
         fqjFzwagNoBPaTkp8yzvaduoi/ys89TRnhizy51Jn1LTpAadDhHAo+SqHbPw+/KCeL
         KXrNLxzviJ1ZiWJnTHB9JawA/l683OfIL/IHdIDPfWqQ8unTA/VEl7Q4BvisYK6Zi/
         K+x3rUAUtmOug==
Date:   Fri, 4 Feb 2022 23:00:30 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Subject: Re: [PATCH v2 3/4] random: use linear min-entropy accumulation
 crediting
Message-ID: <Yf4gjpiGmKzZCnwi@sol.localdomain>
References: <20220204135325.8327-1-Jason@zx2c4.com>
 <20220204135325.8327-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204135325.8327-4-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:53:24PM +0100, Jason A. Donenfeld wrote:
> What if we're wrong and the above is nonsense? It's not, but let's
> assume we don't want the actual _behavior_ of the code to change much.
> Currently that behavior is not extracting from the input pool until it
> has 128 bits of entropy in it. With the old algorithm, we'd hit that
> magic 128 number after roughly 256 calls to credit_entropy_bits(1). So,
> we can retain more or less the old behavior by waiting to extract from
> the input pool until it hits 256 bits of entropy using the new code. For
> people concerned about this change, it means that there's not that much
> practical behavioral change. And for folks actually trying to model
> the behavior rigorously, it means that we have an even higher margin
> against attacks.

I tested this, and it actually was 205 calls prior to patch 1 in this series,
and 267 calls after patch 1.  That's in contrast to 256 calls after this patch.
Not a big difference, but this is going to result in ~25% more single-bit calls
being needed compared to the old version.  It's unclear whether you're arguing
that's basically the same, or whether you thought it was a smaller difference.

> +enum {
>  	POOL_BITS = BLAKE2S_HASH_SIZE * 8,
> -	POOL_BITSHIFT = ilog2(POOL_BITS),
> -	POOL_MIN_BITS = POOL_BITS / 2,
> -
> -	/* To allow fractional bits to be tracked, the entropy_count field is
> -	 * denominated in units of 1/8th bits. */
> -	POOL_ENTROPY_SHIFT = 3,
> -#define POOL_ENTROPY_BITS() (input_pool.entropy_count >> POOL_ENTROPY_SHIFT)
> -	POOL_FRACBITS = POOL_BITS << POOL_ENTROPY_SHIFT,
> -	POOL_MIN_FRACBITS = POOL_MIN_BITS << POOL_ENTROPY_SHIFT
> +	POOL_MIN_BITS = POOL_BITS /* No point in settling for less. */
>  };

Doesn't the default value of random_write_wakeup_bits need to be increased to
this value?  Otherwise, the pool can get stuck with entropy_count greater than
or equal to random_write_wakeup_bits (192) but less than POOL_MIN_BITS (256).

In fact, the only correct value of random_write_wakeup_bits will be 256, i.e.
the entire pool.  Perhaps it should no longer be configurable via /proc/sys?
Note that there's also an off-by one bug that will need to be fixed:
add_hwgenerator_randomness() checks entropy_count <= random_write_wakeup_bits
rather than entropy_count < random_write_wakeup_bits as random_poll() does.

Also: given all these considerations, perhaps the increase in POOL_MIN_BITS is
best done in a separate patch?

> +	do {
> +		entropy_count = orig = READ_ONCE(input_pool.entropy_count);
> +		entropy_count = min(POOL_BITS, entropy_count + nbits);
> +	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);

This can be simplified slightly:

	do {
		orig = READ_ONCE(input_pool.entropy_count);
		entropy_count = min(POOL_BITS, orig + nbits);
	} while (cmpxchg(&input_pool.entropy_count, orig, entropy_count) != orig);

- Eric
