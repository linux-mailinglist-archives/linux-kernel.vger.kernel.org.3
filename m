Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8DB49538B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiATRu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:50:26 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57540 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232699AbiATRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:50:22 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20KHoIRS017126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 12:50:19 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 60B5F15C41B6; Thu, 20 Jan 2022 12:50:18 -0500 (EST)
Date:   Thu, 20 Jan 2022 12:50:18 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: use named fields for adjusting chacha state
Message-ID: <Yemg2rWLqmYNzcDF@mit.edu>
References: <CAHmME9pxJFBv-ZZ3bPMJdmxUO4oeY-wS4BtW34w1ncbeeU=MeA@mail.gmail.com>
 <20220120150734.509125-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120150734.509125-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:07:34PM +0100, Jason A. Donenfeld wrote:
> @@ -750,13 +756,13 @@ static bool crng_init_try_arch(struct crng_state *crng)
>  	bool arch_init = true;
>  	unsigned long rv;
>  
> -	for (i = 4; i < 16; i++) {
> +	for (i = 0; i < ARRAY_SIZE(crng->key); i++) {
>  		if (!arch_get_random_seed_long(&rv) &&
>  		    !arch_get_random_long(&rv)) {
>  			rv = random_get_entropy();
>  			arch_init = false;
>  		}
> -		crng->state[i] ^= rv;
> +		crng->key[i] ^= rv;
>  	}

This change means that we're only initializing the key, but we're not
initializing the counter/nonce (well, IV) value.  Could you fix this,
please?  

> @@ -768,13 +774,13 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
>  	bool arch_init = true;
>  	unsigned long rv;
>  
> -	for (i = 4; i < 16; i++) {
> +	for (i = 0; i < ARRAY_SIZE(crng->key); i++) {
>  		if (!arch_get_random_seed_long_early(&rv) &&
>  		    !arch_get_random_long_early(&rv)) {
>  			rv = random_get_entropy();
>  			arch_init = false;
>  		}
> -		crng->state[i] ^= rv;
> +		crng->key[i] ^= rv;
>  	}

Same issue here.

> @@ -783,14 +789,14 @@ static bool __init crng_init_try_arch_early(struct crng_state *crng)
>  static void crng_initialize_secondary(struct crng_state *crng)
>  {
>  	chacha_init_consts(crng->state);
> -	_get_random_bytes(&crng->state[4], sizeof(u32) * 12);
> +	_get_random_bytes(&crng->key, sizeof(crng->key));
>  	crng_init_try_arch(crng);
>  	crng->init_time = jiffies - CRNG_RESEED_INTERVAL - 1;
>  }

.... and here....


>  static void __init crng_initialize_primary(struct crng_state *crng)
>  {
> -	_extract_entropy(&crng->state[4], sizeof(u32) * 12);
> +	_extract_entropy(&crng->key, sizeof(crng->key));
>  	if (crng_init_try_arch_early(crng) && trust_cpu && crng_init < 2) {
>  		invalidate_batched_entropy();
>  		numa_crng_init();
> @@ -892,7 +898,7 @@ static size_t crng_fast_load(const u8 *cp, size_t len)

And here....

> @@ -994,9 +1000,9 @@ static void _extract_crng(struct crng_state *crng, u8 out[CHACHA_BLOCK_SIZE])
>  			crng_reseed(crng, crng == &primary_crng);
>  	}
>  	spin_lock_irqsave(&crng->lock, flags);
> -	chacha20_block(&crng->state[0], out);
> -	if (crng->state[12] == 0)
> -		crng->state[13]++;
> +	chacha20_block(crng->state, out);
> +	if (unlikely(!crng->counter[0] && !++crng->counter[1]))
> +		++crng->nonce;
>  	spin_unlock_irqrestore(&crng->lock, flags);
>  }

Minor nit, but I might do this as:

	if (unlikely(!crng->counter[0]) && !++crng->counter[1])
		++crng->nonce;


Cheers,

						- Ted
