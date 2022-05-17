Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97B1529D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbiEQJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbiEQJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:05:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2213F316;
        Tue, 17 May 2022 02:05:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F2CF121B85;
        Tue, 17 May 2022 09:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652778299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SjJAc1fpx/bKVG9pAaN910gD3Hx5Dh16hfTJ4aBWaWU=;
        b=LPHd2mU6iRDdIXOUnpLGNlEMimruXBlHV1xA5CoGU5jenvj2sTGsAdOpXP3pLWQbXjGuUA
        r6kDDxFbn+HqqLTYzSxssxlgrHM1rnNZ8O7ClPx56dQCDNJu635D8noTtvYb3azsSj5HoA
        +puYesA/2Iu2PD11iODMdTkNffzTTmI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8805B2C142;
        Tue, 17 May 2022 09:04:58 +0000 (UTC)
Date:   Tue, 17 May 2022 11:04:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] random: remove mostly unused async readiness notifier
Message-ID: <YoNlNs7vGcAy8rU3@alley>
References: <YoD7hn4yBHE0RYUa@zx2c4.com>
 <20220515131927.474097-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220515131927.474097-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-05-15 15:19:27, Jason A. Donenfeld wrote:
> The register_random_ready_notifier() notifier is somewhat complicated,
> and was already recently rewritten to use notifier blocks. It is only
> used now by one consumer in the kernel, vsprintf.c, for which the async
> mechanism is really overly complex for what it actually needs. This
> commit removes register_random_ready_notifier() and unregister_random_
> ready_notifier(), because it just adds complication with little utility,
> and changes vsprintf.c to just check on `!rng_is_initialized() &&
> !rng_has_arch_random()`, which will eventually be true. Performance-
> wise, that code was already using a static branch, so there's basically
> no overhead at all to this change.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c  | 48 --------------------------------
>  include/linux/random.h |  2 --
>  lib/vsprintf.c         | 63 ++++++++++++++----------------------------
>  3 files changed, 20 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 909c23f66fd8..f601856b7b66 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -84,8 +84,6 @@ static DEFINE_STATIC_KEY_FALSE(crng_is_ready);
>  /* Various types of waiters for crng_init->CRNG_READY transition. */
>  static DECLARE_WAIT_QUEUE_HEAD(crng_init_wait);
>  static struct fasync_struct *fasync;
> -static DEFINE_SPINLOCK(random_ready_chain_lock);
> -static RAW_NOTIFIER_HEAD(random_ready_chain);
>  
>  /* Control how we warn userspace. */
>  static struct ratelimit_state urandom_warning =
> @@ -142,51 +140,6 @@ int wait_for_random_bytes(void)
>  }
>  EXPORT_SYMBOL(wait_for_random_bytes);
>  
> -/*
> - * Add a callback function that will be invoked when the input
> - * pool is initialised.
> - *
> - * returns: 0 if callback is successfully added
> - *	    -EALREADY if pool is already initialised (callback not called)
> - */
> -int __cold register_random_ready_notifier(struct notifier_block *nb)
> -{
> -	unsigned long flags;
> -	int ret = -EALREADY;
> -
> -	if (crng_ready())
> -		return ret;
> -
> -	spin_lock_irqsave(&random_ready_chain_lock, flags);
> -	if (!crng_ready())
> -		ret = raw_notifier_chain_register(&random_ready_chain, nb);
> -	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
> -	return ret;
> -}
> -
> -/*
> - * Delete a previously registered readiness callback function.
> - */
> -int __cold unregister_random_ready_notifier(struct notifier_block *nb)
> -{
> -	unsigned long flags;
> -	int ret;
> -
> -	spin_lock_irqsave(&random_ready_chain_lock, flags);
> -	ret = raw_notifier_chain_unregister(&random_ready_chain, nb);
> -	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
> -	return ret;
> -}
> -
> -static void __cold process_random_ready_list(void)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&random_ready_chain_lock, flags);
> -	raw_notifier_call_chain(&random_ready_chain, 0, NULL);
> -	spin_unlock_irqrestore(&random_ready_chain_lock, flags);
> -}
> -
>  #define warn_unseeded_randomness() \
>  	if (IS_ENABLED(CONFIG_WARN_ALL_UNSEEDED_RANDOM) && !crng_ready()) \
>  		printk_deferred(KERN_NOTICE "random: %s called from %pS with crng_init=%d\n", \
> @@ -706,7 +659,6 @@ static void __cold _credit_init_bits(size_t bits)
>  	if (orig < POOL_READY_BITS && new >= POOL_READY_BITS) {
>  		crng_reseed(); /* Sets crng_init to CRNG_READY under base_crng.lock. */
>  		execute_in_process_context(crng_set_ready, &set_ready);
> -		process_random_ready_list();
>  		wake_up_interruptible(&crng_init_wait);
>  		kill_fasync(&fasync, SIGIO, POLL_IN);
>  		pr_notice("crng init done\n");
> diff --git a/include/linux/random.h b/include/linux/random.h
> index 07d93c2a3b5f..fae0c84027fd 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -76,8 +76,6 @@ int __init random_init(const char *command_line);
>  bool rng_is_initialized(void);
>  bool rng_has_arch_random(void);
>  int wait_for_random_bytes(void);
> -int register_random_ready_notifier(struct notifier_block *nb);
> -int unregister_random_ready_notifier(struct notifier_block *nb);
>  
>  /* Calls wait_for_random_bytes() and then calls get_random_bytes(buf, nbytes).
>   * Returns the result of the call to wait_for_random_bytes. */
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 20e9887faaaa..ec67d36abfdb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -750,60 +750,37 @@ static int __init debug_boot_weak_hash_enable(char *str)
>  }
>  early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
>  
> -static DEFINE_STATIC_KEY_TRUE(not_filled_random_ptr_key);
> -static siphash_key_t ptr_key __read_mostly;
> +static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
>  
>  static void enable_ptr_key_workfn(struct work_struct *work)
>  {
> -	get_random_bytes(&ptr_key, sizeof(ptr_key));
> -	/* Needs to run from preemptible context */
> -	static_branch_disable(&not_filled_random_ptr_key);
> +	static_branch_enable(&filled_random_ptr_key);
>  }
>  
> -static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
> -
> -static int fill_random_ptr_key(struct notifier_block *nb,
> -			       unsigned long action, void *data)
> +/* Maps a pointer to a 32 bit unique identifier. */
> +static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
>  {
> -	/* This may be in an interrupt handler. */
> -	queue_work(system_unbound_wq, &enable_ptr_key_work);
> -	return 0;
> -}
> -
> -static struct notifier_block random_ready = {
> -	.notifier_call = fill_random_ptr_key
> -};
> +	static siphash_key_t ptr_key __read_mostly;
> +	unsigned long hashval;
>  
> -static int __init initialize_ptr_random(void)
> -{
> -	int ret;
> +	if (!static_branch_likely(&filled_random_ptr_key)) {
> +		static bool filled = false;
> +		static DEFINE_SPINLOCK(filling);
> +		static DECLARE_WORK(enable_ptr_key_work, enable_ptr_key_workfn);
> +		unsigned long flags;
>  
> -	/* Don't bother waiting for RNG to be ready if RDRAND is mixed in already. */
> -	if (rng_has_arch_random()) {
> -		enable_ptr_key_workfn(&enable_ptr_key_work);
> -		return 0;
> -	}
> +		if (!rng_is_initialized() && !rng_has_arch_random())
> +			return -EAGAIN;
>  
> -	ret = register_random_ready_notifier(&random_ready);
> -	if (!ret) {
> -		return 0;
> -	} else if (ret == -EALREADY) {
> -		/* This is in preemptible context */
> -		enable_ptr_key_workfn(&enable_ptr_key_work);
> -		return 0;
> +		spin_lock_irqsave(&filling, flags);
> +		if (!filled) {
> +			get_random_bytes(&ptr_key, sizeof(ptr_key));
> +			queue_work(system_unbound_wq, &enable_ptr_key_work);
> +			filled = true;
> +		}
> +		spin_unlock_irqrestore(&filling, flags);

I would go even further. The workqueue is needed only because we are not
able to switch the static branch in an atomic context.

But the static branch looks like an over-optimization.
vsprintf() is a slow path. It will be enough to use a normal
variable.

Well, it would be nice to check it without the spinlock to keep it
fast and avoid problems with the spin lock during panic().

What about?

/* Maps a pointer to a 32 bit unique identifier. */
static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
{
	static siphash_key_t ptr_key __read_mostly;
	static boot filled_random_ptr_key __read_mostly;
	unsigned long hashval;

	if (unlikely(!filled_random_ptr_key)) {
		static DEFINE_SPINLOCK(filling_lock);
		unsigned long flags;

		if (!rng_is_initialized() && !rng_has_arch_random())
			return -EAGAIN;

		spin_lock_irqsave(&filling_lock, flags);
		if (!filled_random_ptr_key) {
			get_random_bytes(&ptr_key, sizeof(ptr_key));
			/*
			 * Make sure that ptr_key is initialized before
			 * we tell the word about it.
			 */
			smp_wmb();
			filled_random_ptr_key = true;
		}
		spin_unlock_irqrestore(&filling_lock, flags);
	}

	/*
	 * filled_random_ptr_key was checked without the spin lock
	 * to make it fast and also safe in panic(). Make sure that
	 * we see the initialized ptr_key.
	 */
	 smp_rmb();

#ifdef CONFIG_64BIT
	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);

	...


Alternative solution would be to use an atomic variable and
access it using atomic_read_acquire(&filled_random_ptr_key) and
atomic_set_release(&filled_random_ptr_key). It would hide
the memory barriers.

Well, your approach with static_key is fine as well. Feel free
to use:

Acked-by: Petr Mladek <pmladek@suse.com>

I would personally prefer the variant with the explicit
memory barriers because it seems to be the most easy to understand.
And we do not need to take care of workqueues during early boot.

Best Regards,
Petr
