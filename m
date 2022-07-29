Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14011584EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiG2KWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiG2KWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:22:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4B277A5C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:22:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C5B7334799;
        Fri, 29 Jul 2022 10:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659090131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AXJurmmWk+dsq+v4DUm1cBaNx/5LOxDT/x9+D4yvHFs=;
        b=f+5N+nfdDu83yRjlcQoriH4yYv8SO2x/2s89DGw/wwYQekraqG8nQ7gPMRHv20hKHVPp+d
        7KymJyQb2YmlPcFCjjOIXeWsJbOGDbQJzBwLNcStPHw9y8Q7x9HuNYGSf8wG0EIa/XnvTc
        jTf7/+gntL00uX8DQoQGCMAERKfgHuQ=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2C8982C141;
        Fri, 29 Jul 2022 10:22:11 +0000 (UTC)
Date:   Fri, 29 Jul 2022 12:22:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] random: Initialize vsprintf's pointer hash once the
 random core is ready.
Message-ID: <YuO00GBXXNBhU4yL@alley>
References: <YuOf6qu453dOkR+S@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuOf6qu453dOkR+S@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-07-29 10:52:58, Sebastian Andrzej Siewior wrote:
> The printk code invokes vnsprintf in order to compute the complete
> string before adding it into its buffer. This happens in an IRQ-off
> region which leads to a warning on PREEMPT_RT in the random code if the
> format strings contains a %p for pointer printing. This happens because
> the random core acquires locks which become sleeping locks on PREEMPT_RT
> which must not be acquired with disabled interrupts and or preemption.
> By default the pointers are hashed which requires a random value on the
> first invocation (either by printk or another user which comes first.
> 
> One could argue that there is no need for printk to disable interrupts
> during the vsprintf() invocation which would fix the just mentioned
> problem. However printk itself can be invoked in a context with
> disabled interrupts which would lead to the very same problem.
> 
> This late init via printk can be avoided by explicitly initializing
> vsprintf's random value once the random-core has been initialized.
> 
> Remove the on demand init from __ptr_to_hashval() and keep the -EAGAIN if
> the init has not yet been performed. Move the actual init bits to
> vsprintf_init_hash_pointer() which are invoked from random-core once it
> has been initialized and get_random_bytes() is available.

> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -221,10 +222,15 @@ static void crng_reseed(void)
>  		++next_gen;
>  	WRITE_ONCE(base_crng.generation, next_gen);
>  	WRITE_ONCE(base_crng.birth, jiffies);
> -	if (!static_branch_likely(&crng_is_ready))
> +	if (!static_branch_likely(&crng_is_ready)) {
>  		crng_init = CRNG_READY;
> +		init_hash_pointer = true;

I am not familiar with the crng code. I wonder if the following would work:

	if (!static_branch_likely(&crng_is_ready) && crng_init != CRNG_READY) {
		crng_init = CRNG_READY;
		init_hash_pointer = true;
	}

The point is that vsprintf_init_hash_pointer() will be called only by
the first caller. It would allow to remove the @filling spin lock.

> +	}
>  	spin_unlock_irqrestore(&base_crng.lock, flags);
>  	memzero_explicit(key, sizeof(key));
> +
> +	if (init_hash_pointer)
> +		vsprintf_init_hash_pointer();
>  }
>  
>  /*
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3c1853a9d1c09..6fa2ebb9f9b9e 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -751,36 +751,30 @@ static int __init debug_boot_weak_hash_enable(char *str)
>  early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
>  
>  static DEFINE_STATIC_KEY_FALSE(filled_random_ptr_key);
> +static siphash_key_t ptr_key __read_mostly;
>  
> -static void enable_ptr_key_workfn(struct work_struct *work)
> +void vsprintf_init_hash_pointer(void)
>  {
> -	static_branch_enable(&filled_random_ptr_key);
> +	static DEFINE_SPINLOCK(filling);
> +	unsigned long flags;
> +	static bool filled;
> +
> +	spin_lock_irqsave(&filling, flags);
> +	if (!filled) {
> +		get_random_bytes(&ptr_key, sizeof(ptr_key));
> +		filled = true;
> +		static_branch_enable(&filled_random_ptr_key);

This can't be called in an atomic context. Is crng_reseed() always
called in a non-atomic context?

That said, the static branch is an overkill. vsprintf() is a slow
path. It should be enough to use a simple boolean. It might require
a simple memory barrier to serialize @ptr_key and the new boolean
read&write.

> +	}
> +	spin_unlock_irqrestore(&filling, flags);
>  }

Best Regards,
Petr
