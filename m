Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024A6490FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 18:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbiAQRfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 12:35:02 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:47078 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbiAQRfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 12:35:00 -0500
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id D5DEA2000D7;
        Mon, 17 Jan 2022 17:34:58 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id C5C6C80740; Mon, 17 Jan 2022 18:31:16 +0100 (CET)
Date:   Mon, 17 Jan 2022 18:31:16 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] random: cleanup fractional entropy shift constants
Message-ID: <YeWn5PH1dVay2sg+@owl.dominikbrodowski.net>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220116163547.154991-1-Jason@zx2c4.com>
 <20220116163547.154991-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116163547.154991-2-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Jan 16, 2022 at 05:35:45PM +0100 schrieb Jason A. Donenfeld:
> The entropy estimator is calculated in terms of 1/8 bits, which means
> there are various constants where things are shifted by 3. Move these
> into our pool info enum with the other relevant constants. While we're
> at it, move an English assertion about sizes into a proper BUILD_BUG_ON
> so that the compiler can ensure this invariant.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index de1c14787ae8..7343bff086c5 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -358,16 +358,6 @@
>  
>  /* #define ADD_INTERRUPT_BENCH */
>  
> -/*
> - * To allow fractional bits to be tracked, the entropy_count field is
> - * denominated in units of 1/8th bits.
> - *
> - * 2*(POOL_ENTROPY_SHIFT + poolbitshift) must <= 31, or the multiply in
> - * credit_entropy_bits() needs to be 64 bits wide.
> - */
> -#define POOL_ENTROPY_SHIFT 3
> -#define POOL_ENTROPY_BITS() (input_pool.entropy_count >> POOL_ENTROPY_SHIFT)
> -
>  /*
>   * If the entropy count falls under this number of bits, then we
>   * should wake up processes which are selecting or polling on write
> @@ -425,8 +415,13 @@ enum poolinfo {
>  	POOL_WORDMASK = POOL_WORDS - 1,
>  	POOL_BYTES = POOL_WORDS * sizeof(u32),
>  	POOL_BITS = POOL_BYTES * 8,
> -	POOL_BITSHIFT = ilog2(POOL_WORDS) + 5,
> -	POOL_FRACBITS = POOL_WORDS << (POOL_ENTROPY_SHIFT + 5),
> +	POOL_BITSHIFT = ilog2(POOL_BITS),
> +
> +	/* To allow fractional bits to be tracked, the entropy_count field is
> +	 * denominated in units of 1/8th bits. */
> +	POOL_ENTROPY_SHIFT = 3,
> +#define POOL_ENTROPY_BITS() (input_pool.entropy_count >> POOL_ENTROPY_SHIFT)
> +	POOL_FRACBITS = POOL_BITS << POOL_ENTROPY_SHIFT,


the #define here confuses me a bit, as it is optically breaking the POOL
enum. But that relates to coding style preferences only, so

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
