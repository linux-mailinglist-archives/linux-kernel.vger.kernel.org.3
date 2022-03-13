Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ACD4D7255
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 04:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbiCMDku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 22:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMDkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 22:40:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4242714E;
        Sat, 12 Mar 2022 19:39:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C67260EC0;
        Sun, 13 Mar 2022 03:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6414C340ED;
        Sun, 13 Mar 2022 03:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647142776;
        bh=3grix6c5JEW70SAnWuXhRzKY1J3Fk+9KbH2TzPwc3QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRYBJwlhp6nEp5h7zayJkFd+4xG9JHyIbpD/eeCRxexFMvSyA97biWkFn0wMuJmYe
         RfjEOqDo5T6aETVQ0Tyn6AovxZtBw3MoToDVoe7wOCgAvvDcoF5VmO5d5HMg0ZeYiO
         qMdh/bPjMZkYLMkXzIDARJKSCsV1BL6tcHSRfu+mrxTca/nWWJnXSQNJMZ5yWK3M5T
         ugHNxqyWlXfsJ/bccsWD6luFS5IfvYJxadBkzf3BI4qO5gBOxVVemmFlLe2M1s48Ry
         GweReTIxCIL+kqRlU9W63WqEAgu54yl0rR6s66M0bzTszzjclW5f6URLBjT8kIA9yy
         AD6u7ngzyvmAg==
Date:   Sat, 12 Mar 2022 19:39:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v4] random: reseed more often immediately after booting
Message-ID: <Yi1nd4rWI2dzg23J@sol.localdomain>
References: <CAHmME9rkiAquqASMocBtj9VAHXJCTJCwA+_iNVc2R5DKs6eMoQ@mail.gmail.com>
 <20220313014110.54451-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313014110.54451-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 06:41:10PM -0700, Jason A. Donenfeld wrote:
> In order to chip away at the "premature first" problem, we augment our
> existing entropy accounting with more frequent reseedings at boot.
> 
> The idea is that at boot, we're getting entropy from various places, and
> we're not very sure which of early boot entropy is good and which isn't.
> Even when we're crediting the entropy, we're still not totally certain
> that it's any good. Since boot is the one time (aside from a compromise)
> that we have zero entropy, it's important that we shepherd entropy into
> the crng fairly often.
> 
> At the same time, we don't want a "premature next" problem, whereby an
> attacker can brute force individual bits of added entropy. In lieu of
> going full-on Fortuna (for now), we can pick a simpler strategy of just
> reseeding more often during the first 5 minutes after boot. This is
> still bounded by the 256-bit entropy credit requirement, so we'll skip a
> reseeding if we haven't reached that, but in case entropy /is/ coming
> in, this ensures that it makes its way into the crng rather rapidly
> during these early stages.
> 
> Ordinarily we reseed if the previous reseeding is 300 seconds old. This
> commit changes things so that for the first 600 seconds of boot time, we
> reseed if the previous reseeding is uptime / 2 seconds old. That means
> that we'll reseed at the very least double the uptime of the previous
> reseeding.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v4 uses Eric's formulation relative to the last reseed time, rather than
> my prior one relative to boot time alone.
> 
>  drivers/char/random.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 19a602c69f2f..defdba110d1d 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -327,6 +327,28 @@ static void crng_fast_key_erasure(u8 key[CHACHA_KEY_SIZE],
>  	memzero_explicit(first_block, sizeof(first_block));
>  }
>  
> +/*
> + * Return whether the crng seed is considered to be sufficiently
> + * old that a reseeding might be attempted. This happens if the last
> + * reseeding was CRNG_RESEED_INTERVAL ago, or during early boot, at
> + * an interval proportional to the uptime.
> + */
> +static bool crng_has_old_seed(void)
> +{
> +	static bool early_boot = true;
> +	unsigned long interval = CRNG_RESEED_INTERVAL;
> +
> +	if (unlikely(READ_ONCE(early_boot))) {
> +		time64_t uptime = ktime_get_seconds();
> +		if (uptime >= CRNG_RESEED_INTERVAL / HZ * 2)
> +			WRITE_ONCE(early_boot, false);
> +		else
> +			interval = max_t(unsigned int, 5 * HZ,
> +					 (unsigned int)uptime / 2 * HZ);
> +	}
> +	return time_after(jiffies, READ_ONCE(base_crng.birth) + interval);
> +}
> +
>  /*
>   * This function returns a ChaCha state that you may use for generating
>   * random data. It also returns up to 32 bytes on its own of random data
> @@ -360,10 +382,10 @@ static void crng_make_state(u32 chacha_state[CHACHA_STATE_WORDS],
>  	}
>  
>  	/*
> -	 * If the base_crng is more than 5 minutes old, we reseed, which
> -	 * in turn bumps the generation counter that we check below.
> +	 * If the base_crng is old enough, we try to reseed, which in turn
> +	 * bumps the generation counter that we check below.
>  	 */
> -	if (unlikely(time_after(jiffies, READ_ONCE(base_crng.birth) + CRNG_RESEED_INTERVAL)))
> +	if (unlikely(crng_has_old_seed()))
>  		crng_reseed(false);
>  

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
