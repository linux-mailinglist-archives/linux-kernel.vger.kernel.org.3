Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519AF4AECAA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiBIIhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:37:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242063AbiBIIg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:36:59 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4DFC03BFD6;
        Wed,  9 Feb 2022 00:36:57 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id B75ED20140B;
        Wed,  9 Feb 2022 08:30:59 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 8D9BE80892; Wed,  9 Feb 2022 09:29:02 +0100 (CET)
Date:   Wed, 9 Feb 2022 09:29:02 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, ebiggers@kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 6/9] random: absorb fast pool into input pool after
 fast load
Message-ID: <YgN7TvD5rs/5i1dQ@owl.dominikbrodowski.net>
References: <20220209011919.493762-1-Jason@zx2c4.com>
 <20220209011919.493762-7-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209011919.493762-7-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, Feb 09, 2022 at 02:19:16AM +0100 schrieb Jason A. Donenfeld:
> During crng_init == 0, we never credit entropy in add_interrupt_
> randomness(), but instead dump it directly into the base_crng. That's
> fine, except for the fact that we then wind up throwing away that
> entropy later when we switch to extracting from the input pool and
> overwriting the base_crng key. The two other early init sites --
> add_hwgenerator_randomness()'s use crng_fast_load() and add_device_
> randomness()'s use of crng_slow_load() -- always additionally give their
> inputs to the input pool. But not add_interrupt_randomness().

Hm, up to this patch there is no base_crng key. So maybe change the ordering
of the patches?

> This commit fixes that shortcoming by calling mix_pool_bytes() after
> crng_fast_load() in add_interrupt_randomness(). That's partially
> verboten on PREEMPT_RT, where it implies taking spinlock_t from an IRQ
> handler. But this also only happens during early boot and then never
> again after that. Should this turn into a larger problem later for some
> esoteric reason, we can always use `if (IS_ENABLED(PREEMPT_RT))` or
> something similar to that. But for now, this should do.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Suggested-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 785a4545c9d7..20374bce9a07 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -864,6 +864,13 @@ void add_interrupt_randomness(int irq)
>  		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
>  			fast_pool->count = 0;
>  			fast_pool->last = now;
> +
> +			/* Technically this call means that we're using a spinlock_t
> +			 * in the IRQ handler, which isn't terrific for PREEMPT_RT.
> +			 * However, this only happens during very early boot, and then

Whether it's only during "very early" boot depends on how fast we progress
to crng_init = 2. So maybe just "during boot"?

Otherwise, all fine, so

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
