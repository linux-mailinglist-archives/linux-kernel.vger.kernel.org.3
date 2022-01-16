Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F80D48FD3B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 14:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbiAPNpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 08:45:10 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:53448 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiAPNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 08:45:08 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 539332000D7;
        Sun, 16 Jan 2022 13:45:07 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 055F880312; Sun, 16 Jan 2022 14:24:39 +0100 (CET)
Date:   Sun, 16 Jan 2022 14:24:39 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 1/7] random: cleanup poolinfo abstraction
Message-ID: <YeQcl1q1L4+oKHPc@owl.dominikbrodowski.net>
References: <20220113154413.29513-1-Jason@zx2c4.com>
 <20220113154413.29513-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113154413.29513-2-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, Jan 13, 2022 at 04:44:07PM +0100 schrieb Jason A. Donenfeld:
> Now that we're only using one polynomial, we can cleanup its
> representation into constants, instead of passing around pointers
> dynamically to select different polynomials. This improves the codegen
> and makes the code a bit more straightforward.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

> -} poolinfo_table[] = {
> -	/* was: x^128 + x^103 + x^76 + x^51 +x^25 + x + 1 */
> +enum poolinfo {
> +	POOL_WORDS = 128,
> +	POOL_WORDMASK = POOL_WORDS - 1,
> +	POOL_BYTES = POOL_WORDS * sizeof(u32),
> +	POOL_BITS = POOL_BYTES * 8,
> +	POOL_BITSHIFT = ilog2(POOL_WORDS) + 5,
> +	POOL_FRACBITS = POOL_WORDS << (ENTROPY_SHIFT + 5),
> +
>  	/* x^128 + x^104 + x^76 + x^51 +x^25 + x + 1 */
> -	{ S(128),	104,	76,	51,	25,	1 },
> +	POOL_TAP1 = 104,
> +	POOL_TAP2 = 76,

The only information lost seems to be that POOL_TAP1 used to be 103. But
that comment is still available in git history, so feel free to add:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
