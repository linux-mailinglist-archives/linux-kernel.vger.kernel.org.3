Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E686552726
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243347AbiFTWvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244875AbiFTWvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:51:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0667E17580
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:51:13 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655765470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yasrLaFpBryl/IR7pkzvk0DlBR70O0XhpbwE+T4IDw=;
        b=nRQnHZM/5v+w0Jn6G/apVg01DExPqvtNMJQK+67/wV2HhSCNRcNyDe9VT1mahSUgaEtg9N
        +47H3z+vqGGUxbJb44wHB+N7VAB+nfN/4HynxOaoM0GC65/EM+HdqefkiGsbDrYGmb+P0v
        YdZ0lwMkGZiTqBZ1GioNyjr3wrGTRC/kszWw9lOBCY8qVCgazvIztKJCJ/MgBm0RO85fkc
        Xg263aTmv7HwsJXDuxLPdE1UYuELE1QwKwH9wEMgtY/L4hIvdAsgQ3pDa6RBu4Lb2+iszy
        tXTX3e4fQpLVX/c2Dp/n96heEkOF3WsvXoORUjTnPF4AsM+FXQUieJBC4BoG0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655765470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8yasrLaFpBryl/IR7pkzvk0DlBR70O0XhpbwE+T4IDw=;
        b=mpstO48d7+xATh4i12uYp0FjpXSp5rYJk9E2nYlLXD5X3CiJn4lXdFgHczfbZKOTo4cdq2
        yIE3hm8gBwznciAQ==
To:     Petr Mladek <pmladek@suse.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] printk/console: Enable console kthreads only when there
 is no boot console left
In-Reply-To: <YrCO04oNncE1xF5K@alley>
References: <20220619204949.50d9154d@thinkpad>
 <87r13kwawb.fsf@jogness.linutronix.de> <20220620112936.48fcb2a4@thinkpad>
 <YrBdjVwBOVgLfHyb@alley>
 <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
 <YrCDNqsPrY+Hs9ju@alley> <YrCO04oNncE1xF5K@alley>
Date:   Tue, 21 Jun 2022 00:57:09 +0206
Message-ID: <875ykvaqzm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-20, Petr Mladek <pmladek@suse.com> wrote:
> The console kthreads uncovered several races in console drivers.
> All problems were in situation when a console was being properly
> initialized and registered while an early console, using the same
> port, was being used.
>
> These problems are pretty hard to debug because they often result
> into silent boot crashes. It would be nice to fix them but it
> looks like a can of worms.
>
> Prevent these problems by delaying the use of console kthreads
> after all early consoles are gone. It might later be optimized.
> But let's close this can of worms with a big hammer for now
> so that they do not break first impression on the kthreads
> that solve other real problems.

The problem is that there are multiple consoles accessing the same
hardware. The threaded console printing model did not consider this. The
commit message should clearly state the actual problem.

Since early printing does not use the kernel driver model, I do not see
a clear solution at this point. But since using early printing is not a
typical use, I am OK with this patch.

For the commit message I would suggest something like:

Threaded console printing does not take into consideration that boot
consoles may be accessing the same hardware as normal consoles and thus
must not be called in parallel.

Since it is currently not possible to identify which consoles are
accessing the same hardware, delay threaded console printing activation
until it is known that there are no boot consoles registered.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index b095fb5f5f61..c0c5e2b6b91d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3597,23 +3614,18 @@ static int __init printk_late_init(void)
>  					console_cpu_notify, NULL);
>  	WARN_ON(ret < 0);
>  	printk_sysctl_init();
> -	return 0;
> -}
> -late_initcall(printk_late_init);
> -
> -static int __init printk_activate_kthreads(void)
> -{
> -	struct console *con;
>  
> -	console_lock();
> -	printk_kthreads_available = true;
> -	for_each_console(con)
> -		printk_start_kthread(con);
> -	console_unlock();
> +	/*
> +	 * Some console drivers are not ready to use the same port with
> +	 * boot (early) and normal console in parallel. Stay on the safe
> +	 * side and enable kthreads only when there is no boot console.
> +	 */

As with the commit message, this comment is not pointing out the real
issue. I suggest:

	/*
	 * Boot consoles may be accessing the same hardware as normal
	 * consoles and thus must not be called in parallel. Therefore
	 * only activate threaded console printing if it is known that
	 * there are no boot consoles registered.
	 */

> +	if (no_bootcon)
> +		printk_activate_kthreads();
>  
>  	return 0;
>  }
> -early_initcall(printk_activate_kthreads);
> +late_initcall(printk_late_init);
>  
>  #if defined CONFIG_PRINTK
>  /* If @con is specified, only wait for that console. Otherwise wait for all. */

John Ogness
