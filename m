Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37CC52B57A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiERIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiERIyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:54:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E8E13C0B6;
        Wed, 18 May 2022 01:54:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 04B6A1F9A4;
        Wed, 18 May 2022 08:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652864063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=06nyVlCgwJloMa3Sgbdy84v4l9AGS+6HLkM9Egdi3zA=;
        b=uDiK6ZQrV58T7Sse8eaWlPU/3YOfscJkXv3EILIbosD7HQybDKyxvcVVoFbmUsqTnGDWOC
        4CJ72erIQVpdbKFsT+vzEs5YDvh5g2rDpQI37Yrwv7EeYQF5L0T6eBevotMPC/qL715vvd
        nBQrLN7qvUP+ufxvplkKEKxxqZ6CM98=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6C56E2C141;
        Wed, 18 May 2022 08:54:22 +0000 (UTC)
Date:   Wed, 18 May 2022 10:54:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] random: remove mostly unused async readiness notifier
Message-ID: <YoS0Pn9IotUrQh01@alley>
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

I thought more about this and there is a small risk of a deadlock
when get_random_bytes() or queue_work() or NMI calls
printk()/vsprintf() with %p here.

A simple solution would be to use trylock():

		if (!spin_trylock_irqsave(&filling, flags))
			return -EDEADLK;

Could we do this change, please?

I do not mind if it will be done by re-spinning the original
patch or another patch on top of it.

Best Regards,
Petr


> +		if (!filled) {
> +			get_random_bytes(&ptr_key, sizeof(ptr_key));
> +			queue_work(system_unbound_wq, &enable_ptr_key_work);
> +			filled = true;
> +		}
> +		spin_unlock_irqrestore(&filling, flags);
>  	}
>  
> -	return ret;
> -}
> -early_initcall(initialize_ptr_random);
> -
> -/* Maps a pointer to a 32 bit unique identifier. */
> -static inline int __ptr_to_hashval(const void *ptr, unsigned long *hashval_out)
> -{
> -	unsigned long hashval;
> -
> -	if (static_branch_unlikely(&not_filled_random_ptr_key))
> -		return -EAGAIN;
>  
>  #ifdef CONFIG_64BIT
>  	hashval = (unsigned long)siphash_1u64((u64)ptr, &ptr_key);
