Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4681C5509FD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiFSLFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFSLFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:05:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D7BCB9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:05:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655636744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ymGi6BUQAxBbWiWCWE8+NWS4jdgouWFwCr9qHH8GEg=;
        b=RUk4xbMFGXqiWDxfqa0BH7o69EbQiRDMRQQlNRqcH4+uIvQVviYA7DVtUYkK/P5qDaAhJG
        A5lWbceX7q5RYoclsbUKO464nEEa3qDxIxM03VdxMPhVRBB+D276KTKTaKuZz3GgmFluD5
        TgIe0PQ8gNkPLPELJuOt4A3ChuFRyGTS+GveIq8QSwW5/E6HHfNPCJz8LXYK+/t6ixK02i
        KHqwzz0UNgor4avAF8a0ECTxwRsD/sPI8ORJHDqsXJa96R759zkTPWIUad/k8qzAKeoV5I
        KkQFdbnC4olyU/1Xgb1vyReehMFoKiSeUC3mWbdfuuYd4e9PmxhacLvFA5fFyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655636744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ymGi6BUQAxBbWiWCWE8+NWS4jdgouWFwCr9qHH8GEg=;
        b=aRTOVa1cNkv2jR9hSSIHHTi73uP4b8hTd9W7+Uq6FvFm020wS4cuUt1bgURCajjzZXrpIP
        pP7NECFU9DgL1jBg==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] printk: allow direct console printing to be enabled always
In-Reply-To: <20220617133847.27517-1-Jason@zx2c4.com>
References: <YqyDqMAPHIxjA/xZ@zx2c4.com>
 <20220617133847.27517-1-Jason@zx2c4.com>
Date:   Sun, 19 Jun 2022 13:11:43 +0206
Message-ID: <87a6a8syk8.fsf@jogness.linutronix.de>
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

On 2022-06-17, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> In 5.19, there are some changes in printk message ordering /
> interleaving which leads to confusion. The most obvious (and benign)
> example appears on system boot, in which the "Run /init as init process"
> message gets intermixed with the messages that init actually writes() to
> stdout. For example, here's a snippet from build.wireguard.com:
>
>     [    0.469732] Freeing unused kernel image (initmem) memory: 4576K
>     [    0.469738] Write protecting the kernel read-only data: 10240k
>     [    0.473823] Freeing unused kernel image (text/rodata gap) memory: 2044K
>     [    0.475228] Freeing unused kernel image (rodata/data gap) memory: 1136K
>     [    0.475236] Run /init as init process
>
>         WireGuard Test Suite on Linux 5.19.0-rc2+ x86_64
>
>     [+] Mounting filesystems...
>     [+] Module self-tests:
>      *  allowedips self-tests: pass
>      *  nonce counter self-tests: pass
>      *  ratelimiter self-tests: pass
>     [+] Enabling logging...
>     [+] Launching tests...
>     [    0.475237]   with arguments:
>     [    0.475238]     /init
>     [    0.475238]   with environment:
>     [    0.475239]     HOME=/
>     [    0.475240]     TERM=linux
>     [+] ip netns add wg-test-46-0
>     [+] ip netns add wg-test-46-1

As Petr mentioned, this issue is not new. But with kthreads it has
become the common case.

> +	printk.always_direct=

Do we need the word "always" in there? I would prefer the simplied:
printk.direct=

> +			Rather than using kthreads for printk output, always
> +			write to the console immediately. This has performance

The "best effort" part needs to be in there. Perhaps:

Rather than using kthreads for printk output, always attempt to write to
the console immediately.

> +			implications, but will result in a more faithful
> +			ordering and interleaving with other processes writing
> +			to the console.

My main concern is that "direct printing" is not synchronous. Since
2.4.10 it has not been printk's goal to be synchronous. Your patch is
making the issue less likely again, but not solving it. And since this
is the first time we are documenting the printk printing behavior, we
should be careful to not mislead users to think it is truly direct.

The planned solution is atomic consoles, which are able to provide a
truly synchronous printk. But they are not yet available mainline.

> diff --git a/init/Kconfig b/init/Kconfig
> index c7900e8975f1..7676897f2321 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -798,6 +798,18 @@ config PRINTK_INDEX
>  
>  	  There is no additional runtime cost to printk with this enabled.
>  
> +config PRINTK_ALWAYS_DIRECT

(perhaps)
config PRINTK_DIRECT

> +	bool "Flush printk output immediately"

Attempt to flush printk output immediately

> +	depends on PRINTK
> +	help
> +	  Rather than using kthreads for printk output, always write to the

always attempt to write

> +	  console immediately. This has performance implications, but will
> +	  result in a more faithful ordering and interleaving with other
> +	  processes writing to the console.
> +
> +	  Say N here unless you really need this. This may also be controlled
> +	  at boot time with printk.always_direct=0/1.

(perhaps)
printk.direct=0/1

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ea3dd55709e7..d9f419a88429 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -471,6 +479,10 @@ void printk_prefer_direct_exit(void)
>   */
>  static inline bool allow_direct_printing(void)
>  {
> +	/* If the user has explicitly enabled this to be on always. */
> +	if (always_direct_printk)
> +		return true;

There is no reason to start the threads if they won't be used. Perhaps
something like this instead:

-------- BEGIN HUNK -------
@@ -3602,11 +3610,13 @@ static int __init printk_activate_kthreads(void)
 {
 	struct console *con;
 
-	console_lock();
-	printk_kthreads_available = true;
-	for_each_console(con)
-		printk_start_kthread(con);
-	console_unlock();
+	if (!always_direct_printk) {
+		console_lock();
+		printk_kthreads_available = true;
+		for_each_console(con)
+			printk_start_kthread(con);
+		console_unlock();
+	}
 
 	return 0;
 }
-------- END HUNK -------

Some general comments from me...

Direct printing has a lot of technical issues. It is sometimes directly
responsible for kernels dying. It is sometimes directly responsible for
preventing important information from being made available at crash
time. For the fbcon, direct printing is a ticking timebomb. And in many
cases it isn't even truly doing direct printing anyway.

Direct printing (in its current form) must be phased out at some
point. We are working to bring true synchronous console printing
mainline.

Aside from my above comments, I have no problems with this patch.

John Ogness
