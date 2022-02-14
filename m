Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DC24B5341
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355119AbiBNO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:26:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344651AbiBNO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:26:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B05090
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:26:19 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:26:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644848778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANNwHcEmklNb9ltMcO9wOVA9vxRmsCTRrzWaq5I/G74=;
        b=GwSWYETWyxBpIVBqUKtpFDGNtQleTMzRu+0fjzb9jXUoGO+S0ia1rK0TYll780tnjCHjea
        0W73KQ/kgKfQPFyYXo3u1KI2PraLLyfvIRDg5eRbZZYyyyggQ95B01GTfKMr/JlR0lYwYU
        vw9jW4xh/8wUf1MnM6f/6OfAA5UT35ugmrfSwPTFuX7DGLYwRZlzWU34ZPhCgKxGEyNbRc
        jjNwWNKRkwnZhXRkmui3F+ZwwCzjitsLwULdiiiMQMQDpYqf7XEjELkUGmPKH5WP2gt+Tn
        ecMMOxhRTaNpgH+0oczvVMGtuJ/Wbr6OVTHdJE82U3h6ihz/+hL6Vs2/CEORfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644848778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ANNwHcEmklNb9ltMcO9wOVA9vxRmsCTRrzWaq5I/G74=;
        b=mCTXLEmUJXQTFFHijKLzCownR39N70jOqdcPxz9p/+iu9HokZr6pj7H92whmLCGn1aL/5f
        7KKIBA+UWI0zqBDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: invalidate crngs and batches on cpuhp teardown
Message-ID: <YgpmiMURsT3OQLtM@linutronix.de>
References: <20220214134838.980159-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220214134838.980159-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 14:48:38 [+0100], Jason A. Donenfeld wrote:
> Now that we have a cpuhp teardown notifier, we can invalidate the keys
> used by the per-cpu crngs and the batches used by per-cpu batched
> entropy, so that if the cpus come back online, and the generation
> counter happens to have cycled all the way around to where it was
> before, it doesn't mistakenly use the old data. The chances of this
> happening are exceedingly rare, but since we now have the notifier
> setup, doing this is basically free.

Wasn't aware that random bits get bad over time ;)

> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sultan Alsawaf <sultan@kerneltoast.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index df5aef93da34..ce199af9bc56 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1225,6 +1225,15 @@ int random_dead_cpu(unsigned int cpu)
>  	 * since the MIX_INFLIGHT flag will be cleared.
>  	 */
>  	per_cpu_ptr(&irq_randomness, cpu)->count = 0;
> +
> +	/*
> +	 * We also want to invalidate per-cpu crngs and batches,
> +	 * so that if the CPU does come back online, it uses
> +	 * fresh entropy.
> +	 */
> +	per_cpu_ptr(&crngs, cpu)->generation = ULONG_MAX;
> +	per_cpu_ptr(&batched_entropy_u32, cpu)->position = UINT_MAX;
> +	per_cpu_ptr(&batched_entropy_u64, cpu)->position = UINT_MAX;

I think if you want to do this, then it would also make sense to put it
into the startup callback. If there is an user doing get_random_u32()
then you would preload the "old" entropy. But on your way "online" you
would preload it with the new entropy.

>  	return 0;
>  }
>  

Sebastian
