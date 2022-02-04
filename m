Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25134A9C89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiBDP5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:57:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiBDP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:57:19 -0500
Date:   Fri, 4 Feb 2022 16:57:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643990238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H1SCG2oNEv5W4scfTi2aoSVlrGEsagG8YtlUCrxXMoc=;
        b=txa+5yoi77400sJ+kR49rS2Je7vH/2cXg90NNwmpJixdhgnvyQllNEjVpK2PJISKcVXdow
        Zx2Jkue406jvVTI3YdFq4kpsjfWVE+73YfTfHJM/KO/+wLoaX5b3WN9TvL03k1LXiNcOKj
        aWVbkDIR9ScWYdIK27xoytGmQuITCfWzhWHnRjNE8b3wDos4bh54izbCaOULNKx1VYl3se
        f1iznbXmks8tYUSPjo/lGxUFqQioAjHP+dyUcNfuirk3o6/3Xa/y1DtX1cgyb6vCWQtgzc
        teVeK9wXiKtwDw/C8F67OoW92HhK5+M84Irwo545jzQ+eefWUA/FUIOVEy70nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643990238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H1SCG2oNEv5W4scfTi2aoSVlrGEsagG8YtlUCrxXMoc=;
        b=mMMY6+4ZE7IHnOSHIJOU2dA8h9SK4XnbKUQ+/L+8V+dPtoLhg4bIRTElV9yt36Vpie95QY
        8M39nb8owshZ1XDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] random: remove batched entropy locking
Message-ID: <Yf1M3YGVq71oC9BM@linutronix.de>
References: <CAHmME9pO41uwYExSROc5X2+RE=a5tZfE=c=bAxVbhCHfa7=zSA@mail.gmail.com>
 <20220204155142.56419-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220204155142.56419-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-04 16:51:42 [+0100], Jason A. Donenfeld wrote:
> index 455615ac169a..3e54b90a3ff8 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1759,41 +1762,54 @@ u64 get_random_u64(void)
>  	unsigned long flags;
>  	struct batched_entropy *batch;
>  	static void *previous;
> +	int next_gen;
>  
>  	warn_unseeded_randomness(&previous);
>  
> -	batch = raw_cpu_ptr(&batched_entropy_u64);
> -	spin_lock_irqsave(&batch->batch_lock, flags);
> -	if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
> +	batch = this_cpu_ptr(&batched_entropy_u64);
> +	local_lock_irqsave(&batch->lock, flags);

Does this compile and work? From the looks of it, this should be:

	local_lock_irqsave(&batched_entropy_u64.lock, flags);
	batch = this_cpu_ptr(&batched_entropy_u64);

and we could do s/this_cpu_ptr/raw_cpu_ptr/

Sebastian
