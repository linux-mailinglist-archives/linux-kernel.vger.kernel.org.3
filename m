Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53AF4B39EA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiBMG50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 01:57:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiBMG5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 01:57:10 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860105DE58
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 22:57:05 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 22DCD20140B;
        Sun, 13 Feb 2022 06:57:00 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id E168B80ECF; Sun, 13 Feb 2022 07:55:37 +0100 (CET)
Date:   Sun, 13 Feb 2022 07:55:37 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 3/3] random: use trylock in irq handler rather than
 spinning
Message-ID: <YgiraRIkuKK787YC@owl.dominikbrodowski.net>
References: <20220212231022.679926-1-Jason@zx2c4.com>
 <20220212231022.679926-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212231022.679926-4-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, Feb 13, 2022 at 12:10:22AM +0100 schrieb Jason A. Donenfeld:
> crng_pre_init_inject() (and prior crng_fast_load()) uses a trylock when
> in fast mode, so that it never contends. We should be doing the same
> when grabbing a spinlock for mixing into the entropy pool. So switch to
> doing that before calling the underscored _mix_pool_bytes().
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 9a8e1bb9845d..ca224c3f2561 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1286,13 +1286,10 @@ void add_interrupt_randomness(int irq)
>  			atomic_set(&fast_pool->count, 0);
>  			fast_pool->last = now;
>  
> -			/*
> -			 * Technically this call means that we're using a spinlock_t
> -			 * in the IRQ handler, which isn't terrific for PREEMPT_RT.
> -			 * However, this only happens during boot, and then never
> -			 * again, so we live with it.
> -			 */
> -			mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
> +			if (spin_trylock(&input_pool.lock)) {
> +				_mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
> +				spin_unlock(&input_pool.lock);
> +			}

You're still using a spinlock_t here, so I don't see a need to remove the
comment. Also, I'm not super happy that the count is re-set to 0 but the
input remains unused. Maybe the better approach here is, as discussed in the
other thread, to always use the workqueue mechanism, which would allow us to
streamline the code further.

Thanks,
	Dominik
