Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360D1525B91
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377319AbiEMG0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377256AbiEMG0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:26:19 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29008275CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:26:08 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A28E02013AF;
        Fri, 13 May 2022 06:26:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 4A5DB80949; Fri, 13 May 2022 08:18:45 +0200 (CEST)
Date:   Fri, 13 May 2022 08:18:45 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: handle latent entropy and command line from
 random_init()
Message-ID: <Yn34RROzSQtHP/rZ@owl.dominikbrodowski.net>
References: <20220512124839.20755-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512124839.20755-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, May 12, 2022 at 02:48:39PM +0200 schrieb Jason A. Donenfeld:
> Currently, start_kernel() adds latent entropy and the command line to
> the entropy bool *after* the RNG has been initialized, deferring when
> it's actually used by things like stack canaries until the next time
> the pool is seeded. This surely is not intended.
> 
> Rather than splitting up which entropy gets added where and when between
> start_kernel() and random_init(), just do everything in random_init(),
> which should eliminate these kinds of bugs in the future.
> 
> While we're at it, rename the awkwardly titled "rand_initialize()" to
> the more standard "random_init()" nomenclature.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c  | 17 ++++++++++-------
>  include/linux/random.h | 17 ++++++++---------
>  init/main.c            |  8 ++------
>  3 files changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index d4bc9beaed2c..bd80d74a7f8c 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -926,12 +926,13 @@ static struct notifier_block pm_notifier = { .notifier_call = random_pm_notifica
>  
>  /*
>   * The first collection of entropy occurs at system boot while interrupts
> - * are still turned off. Here we push in RDSEED, a timestamp, and utsname().
> - * Depending on the above configuration knob, RDSEED may be considered
> - * sufficient for initialization. Note that much earlier setup may already
> - * have pushed entropy into the input pool by the time we get here.
> + * are still turned off. Here we push in latent entropy, RDSEED, a timestamp,
> + * utsname(), and the command line. Depending on the above configuration knob,
> + * RDSEED may be considered sufficient for initialization. Note that much
> + * earlier setup may already have pushed entropy into the input pool by the
> + * time we get here.
>   */
> -int __init rand_initialize(void)
> +int __init random_init(const char *command_line)
>  {
>  	size_t i;
>  	ktime_t now = ktime_get_real();
> @@ -953,6 +954,8 @@ int __init rand_initialize(void)
>  	}
>  	_mix_pool_bytes(&now, sizeof(now));
>  	_mix_pool_bytes(utsname(), sizeof(*(utsname())));
> +	_mix_pool_bytes(command_line, strlen(command_line));
> +	add_latent_entropy();
>  
>  	if (crng_ready()) {
>  		/*
> @@ -1703,8 +1706,8 @@ static struct ctl_table random_table[] = {
>  };
>  
>  /*
> - * rand_initialize() is called before sysctl_init(),
> - * so we cannot call register_sysctl_init() in rand_initialize()
> + * random_init() is called before sysctl_init(),
> + * so we cannot call register_sysctl_init() in random_init()
>   */
>  static int __init random_sysctls_init(void)
>  {
> diff --git a/include/linux/random.h b/include/linux/random.h
> index f673fbb838b3..6eabea6697d0 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -14,22 +14,21 @@ struct notifier_block;
>  
>  extern void add_device_randomness(const void *, size_t);
>  extern void add_bootloader_randomness(const void *, size_t);
> +extern void add_input_randomness(unsigned int type, unsigned int code,
> +				 unsigned int value) __latent_entropy;
> +extern void add_interrupt_randomness(int irq) __latent_entropy;
> +extern void add_hwgenerator_randomness(const void *buffer, size_t count,
> +				       size_t entropy);
>  
>  #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
>  static inline void add_latent_entropy(void)
>  {
> -	add_device_randomness((const void *)&latent_entropy,
> -			      sizeof(latent_entropy));
> +	add_device_randomness((const void *)&latent_entropy, sizeof(latent_entropy));
>  }
>  #else
> -static inline void add_latent_entropy(void) {}
> +static inline void add_latent_entropy(void) { }

Stray change here, which doesn't seem necessary...

Otherwise:

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
