Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102D15A92C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiIAJM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiIAJMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:12:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC06110D8A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:12:22 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662023540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaRumsH3KDmkPnek0I9ClyHltDQl827/GSI2YJ5tGmk=;
        b=UMaLYHKJYk7R0Y8kbntlx28LDmUpMYh6Im3Bftl4gjEQBTpMoLzrwLCy0mgE41F72kvM8W
        0JcaF+RNRxkygEQvcQCOb+a5lzUum4ZR3SwyCx+nJzoAxF2pE8iCecKLsb5ScCMyxc49H8
        Updrr2/BSgHUGoQx6jcZq+sqWpvohuvarXhWstR9Xl0F0042eHdL/61XaG/dU525vNqyXU
        zXe5C2rXMllqWtMxszk4DI5GvoZUXXPNU3ShV9+bgA/zBQZb5KauvxdNSvGVvW5lXDHADU
        z7V/2LFOFiN8MtpIMgB2PkA3mW7oNVR0uwvwlkN/WJpWKmk8/uOlUzTB3FqNcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662023540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kaRumsH3KDmkPnek0I9ClyHltDQl827/GSI2YJ5tGmk=;
        b=z0qgClFFWJ0+UUaCJLAVasOOCjJjZx02ljJShf+ooWSzp3OoVUqiVtiK8Xc40jCR63GvSW
        Qz1CF+qoidhmrTAA==
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu 1/2] torture: Optionally flush printk() buffers
 before powering off
In-Reply-To: <20220831182148.2698489-2-paulmck@kernel.org>
References: <20220831182113.GA2697286@paulmck-ThinkPad-P17-Gen-1>
 <20220831182148.2698489-2-paulmck@kernel.org>
Date:   Thu, 01 Sep 2022 11:18:20 +0206
Message-ID: <87tu5rfogb.fsf@jogness.linutronix.de>
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

Added CC the rest of the printk folks since this would be the first use
of pr_flush() outside of the printk subsystem. And it is a controversial
usage, since it is used to work around potential (future) bugs in
printk.

On 2022-08-31, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> The rcutorture test suite produces quite a bit of console output at
> the end of a test.  This means that the new-in-2022 printk() kthreads
> are likely to be in the process of flushing output at the time of the
> torture_shutdown() function's call to kernel_power_off().  Normally,
> rcutorture relies on printk() to flush any pending output upon shutdown,
> the better to detect bugs in this area, for example, the one introduced
> by 8e274732115f ("printk: extend console_lock for per-console locking").
> However, once such a bug is detected and reported, it is necessary to
> test the rest of the system, without noise from the already-reported bug.

Since the printk kthread implementation has been reverted, this is no
longer an issue. When a kthread implementation is re-introduced, this
issue will need to have been considered and handled.

IMHO this patch is premature at this time and hopefully will never
become necessary (in the form of a bug workaround).

> This commit therefore adds a torture.printk_shutdown_bug_workaround
> kernel parameter, which causes torture_shutdown() to invoke pr_flush(),
> and print an informative message on the console, immediately before
> invoking kernel_power_off().  When this kernel parameter is not specified,
> it is up to printk() to flush its own buffers.
>
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>  kernel/torture.c                                | 7 +++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index d7f30902fda02..ba1b8776aab83 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6143,6 +6143,12 @@
>  			are running concurrently, especially on systems
>  			with rotating-rust storage.
>  
> +	torture.printk_shutdown_bug_workaround= [KNL]
> +			Execute pr_flush(1000, true) just before invoking
> +			kernel_power_off() to work around any bugs that
> +			might prevent printk() from flushing its buffers
> +			at shutdown time.
> +
>  	torture.verbose_sleep_frequency= [KNL]
>  			Specifies how many verbose printk()s should be
>  			emitted between each sleep.  The default of zero
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 789aeb0e1159c..7cd2016b02076 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -48,6 +48,9 @@ module_param(disable_onoff_at_boot, bool, 0444);
>  static bool ftrace_dump_at_shutdown;
>  module_param(ftrace_dump_at_shutdown, bool, 0444);
>  
> +static bool printk_shutdown_bug_workaround;
> +module_param(printk_shutdown_bug_workaround, bool, 0444);
> +
>  static int verbose_sleep_frequency;
>  module_param(verbose_sleep_frequency, int, 0444);
>  
> @@ -651,6 +654,10 @@ static int torture_shutdown(void *arg)
>  		VERBOSE_TOROUT_STRING("No torture_shutdown_hook(), skipping.");
>  	if (ftrace_dump_at_shutdown)
>  		rcu_ftrace_dump(DUMP_ALL);
> +	if (printk_shutdown_bug_workaround) {
> +		pr_info("%s: Flushing printk() buffers at power-down time.\n", __func__);
> +		pr_flush(1000, true);
> +	}
>  	kernel_power_off();	/* Shut down the system. */
>  	return 0;
>  }
> -- 
> 2.31.1.189.g2e36527f23

John Ogness
