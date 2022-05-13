Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7474A525B82
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377371AbiEMG0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377307AbiEMG0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:26:24 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC322A711;
        Thu, 12 May 2022 23:26:21 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id E5D2B2013F8;
        Fri, 13 May 2022 06:26:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D23B680A2A; Fri, 13 May 2022 08:25:12 +0200 (CEST)
Date:   Fri, 13 May 2022 08:25:12 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: mix in timestamps and reseed on system restore
Message-ID: <Yn35yGyVYT7gwGEq@owl.dominikbrodowski.net>
References: <20220501123849.3858-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501123849.3858-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sun, May 01, 2022 at 02:38:49PM +0200 schrieb Jason A. Donenfeld:
> Since the RNG loses freshness system suspend/hibernation, when we
> resume, immediately reseed using whatever data we can, which for this
> particular case is the various timestamps regarding system suspend time,
> in addition to more generally the RDSEED/RDRAND/RDTSC values that happen
> whenever the crng reseeds.
> 
> On systems that suspend and resume automatically all the time -- such as
> Android -- we skip the reseeding on suspend resumption, since that could
> wind up being far too busy. This is the same trade-off made in
> WireGuard.
> 
> In addition to reseeding upon resumption always mix into the pool these
> various stamps on every power notification event.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 0935a140795e..48eac27214ea 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -53,6 +53,7 @@
>  #include <linux/completion.h>
>  #include <linux/uuid.h>
>  #include <linux/uaccess.h>
> +#include <linux/suspend.h>
>  #include <crypto/chacha.h>
>  #include <crypto/blake2s.h>
>  #include <asm/processor.h>
> @@ -966,6 +967,37 @@ static int __init parse_trust_bootloader(char *arg)
>  early_param("random.trust_cpu", parse_trust_cpu);
>  early_param("random.trust_bootloader", parse_trust_bootloader);
>  
> +static int random_pm_notification(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	unsigned long flags, entropy = random_get_entropy();
> +
> +	/*
> +	 * Encode a representation of how long the system has been suspended,
> +	 * in a way that is distinct from prior system suspends.
> +	 */
> +	ktime_t stamps[] = {
> +		ktime_get(),
> +		ktime_get_boottime(),
> +		ktime_get_real()
> +	};
> +
> +	spin_lock_irqsave(&input_pool.lock, flags);
> +	_mix_pool_bytes(&action, sizeof(action));
> +	_mix_pool_bytes(stamps, sizeof(stamps));
> +	_mix_pool_bytes(&entropy, sizeof(entropy));
> +	spin_unlock_irqrestore(&input_pool.lock, flags);
> +
> +	if (action == PM_RESTORE_PREPARE ||
> +	    (action == PM_POST_SUSPEND &&
> +	     !IS_ENABLED(CONFIG_PM_AUTOSLEEP) && !IS_ENABLED(CONFIG_ANDROID))) {
> +		crng_reseed(true);
> +		pr_notice("crng reseeded on system resumption\n");
> +	}
> +	return 0;
> +}

Should this also wake up any thread waiting in add_hwgenerator_randomness()
/ "use" the input already in store there?

Thanks,
	Dominik
