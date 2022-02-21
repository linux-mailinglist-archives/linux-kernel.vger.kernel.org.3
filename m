Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F2B4BEB04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiBUTIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:08:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiBUTIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:08:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545BF1A815;
        Mon, 21 Feb 2022 11:08:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA40160AFA;
        Mon, 21 Feb 2022 19:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0627BC340E9;
        Mon, 21 Feb 2022 19:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645470500;
        bh=uJ1xctqupYgShdlN9JXCmYcgnXakV3u7jjYy+e4wd+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hre/vsXPfTZ8xdaa95piF3pIp0LNpldzkBh2GKZ7ftRIza5cMQ/rdZ+UiqhYCcHzx
         XUBJ7XWEJ2ZG8VqeeRU0/avSuyZPUPploQKbqOi2vKFkM/CRJR1m1a4rKI1t7qW3yC
         F3NOagO8mYy+KO0R0+uriC+QDBYZKdCqb9I/3rou+keA2HIi7vKFTdmh1L2FfapEb4
         H+JdJKci+SIgOkjgcvnwlF/mulyci5NvP5C5wECaVj5oZD5SFgfl3TS9bkXVUeggy8
         cgomnWhCpLR+EURWs1RT3pyv44VBLGUS2ZJQ1LTC/9Uro7PLeVyAna1YOqc04bdnYz
         EFHeIFdLX2y0A==
Date:   Mon, 21 Feb 2022 11:08:18 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v4] random: absorb fast pool into input pool after fast
 load
Message-ID: <YhPjIripJMsLynXn@sol.localdomain>
References: <CAHmME9pCGHuhZW-HQD==2h0=YRk=Man0KU6+RAGiT0QD-PCNpg@mail.gmail.com>
 <20220221145816.2278732-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221145816.2278732-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 03:58:16PM +0100, Jason A. Donenfeld wrote:
> During crng_init == 0, we never credit entropy in add_interrupt_
> randomness(), but instead dump it directly into the primary_crng. That's
> fine, except for the fact that we then wind up throwing away that
> entropy later when we switch to extracting from the input pool and
> xoring into (and later in this series overwriting) the primary_crng key.
> The two other early init sites -- add_hwgenerator_randomness()'s use
> crng_fast_load() and add_device_ randomness()'s use of crng_slow_load()
> -- always additionally give their inputs to the input pool. But not
> add_interrupt_randomness().
> 
> This commit fixes that shortcoming by calling mix_pool_bytes() after
> crng_fast_load() in add_interrupt_randomness(). That's partially
> verboten on PREEMPT_RT, where it implies taking spinlock_t from an IRQ
> handler. But this also only happens during early boot and then never
> again after that. Plus it's a trylock so it has the same considerations
> as calling crng_fast_load(), which we're already using.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Suggested-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v4 has no changes except for a commit message nit, per Eric's request.
> 
>  drivers/char/random.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index d31b0b3afe2e..f3179c67010b 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -850,6 +850,10 @@ void add_interrupt_randomness(int irq)
>  		    crng_fast_load((u8 *)fast_pool->pool, sizeof(fast_pool->pool)) > 0) {
>  			fast_pool->count = 0;
>  			fast_pool->last = now;
> +			if (spin_trylock(&input_pool.lock)) {
> +				_mix_pool_bytes(&fast_pool->pool, sizeof(fast_pool->pool));
> +				spin_unlock(&input_pool.lock);
> +			}
>  		}
>  		return;
>  	}
> -- 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
