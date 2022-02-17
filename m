Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AE14B9CC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbiBQKL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:11:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbiBQKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:11:28 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6507F2AAB3D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:11:14 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 23C581F383;
        Thu, 17 Feb 2022 10:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645092673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cyUregw8hAXko0ZRmaRWn7Astnni7nXWdxjsvYQJs/4=;
        b=e8i0Bm1Ax5TGlX4yqI0sNNIIXDYo1UGJuNGmPaHp9NVtUgjkBypLOsEtKUiGy5yP+ycgmS
        yZRoaPG3syvfeyYSgDDI0/GNPj+ofGHW/MEKdjXYlTARN7xfE+m5xqgj4wFbR4agmxeLJa
        gvT1HwNvuV09xG5RpqHUC0sET0wLGcU=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D75D9A3B87;
        Thu, 17 Feb 2022 10:11:12 +0000 (UTC)
Date:   Thu, 17 Feb 2022 11:11:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 08/13] printk: add pr_flush()
Message-ID: <Yg4fQHlli5L/zLQ6@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-9-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:18, John Ogness wrote:
> Provide a might-sleep function to allow waiting for threaded console
> printers to catch up to the latest logged message.
> 
> Use pr_flush() whenever it is desirable to get buffered messages
> printed before continuing: suspend_console(), resume_console(),
> console_stop(), console_start(), console_unblank().
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 02bde45c1149..1e80fd052bd5 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2449,6 +2449,7 @@ void suspend_console(void)
>  	if (!console_suspend_enabled)
>  		return;
>  	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
> +	pr_flush(1000, true);
>  	console_lock();
>  	console_suspended = 1;
>  	up_console_sem();
> @@ -2461,6 +2462,7 @@ void resume_console(void)
>  	down_console_sem();
>  	console_suspended = 0;
>  	console_unlock();
> +	pr_flush(1000, true);
>  }
>  
>  /**
> @@ -2802,8 +2804,10 @@ void console_unblank(void)
>  	if (oops_in_progress) {
>  		if (down_trylock_console_sem() != 0)
>  			return;
> -	} else
> +	} else {
> +		pr_flush(1000, true);

It would make more sense to flush the consoles after they are
unblanked. I mean to move this to the end of the function.

Also it is not obvious why this is not called when oops_in_progress
is set. I guess that it is because trylock is needed in this case.
It should be handled inside pr_flush().

I mean that pr_flush() should internally use trylock when
@oops_in_progress is set. It will make it safe even in this
mode.


>  		console_lock();
> +	}
>  
>  	console_locked = 1;
>  	console_may_schedule = 0;
> @@ -2869,6 +2873,7 @@ struct tty_driver *console_device(int *index)
>   */
>  void console_stop(struct console *console)
>  {
> +	pr_flush(1000, true);

It would be enough to flush just the given @console.

It might be possible to take over the job from the related
kthread and flush it in this context. Well, I am not sure if
it is a good idea.

>  	console_lock();
>  	console->flags &= ~CON_ENABLED;
>  	console_unlock();
> @@ -2880,6 +2885,7 @@ void console_start(struct console *console)
>  	console_lock();
>  	console->flags |= CON_ENABLED;
>  	console_unlock();
> +	pr_flush(1000, true);

Same here.

>  }
>  EXPORT_SYMBOL(console_start);
>  
> @@ -3249,6 +3255,71 @@ static int __init printk_late_init(void)
>  late_initcall(printk_late_init);
>  
>  #if defined CONFIG_PRINTK
> +/**
> + * pr_flush() - Wait for printing threads to catch up.
> + *

Alternative solution would be to take over the job from the kthreads
and flush the consoles in this context. Well, I am not sure
if it is a good idea or not.

> + * @timeout_ms:        The maximum time (in ms) to wait.
> + * @reset_on_progress: Reset the timeout if forward progress is seen.
> + *
> + * A value of 0 for @timeout_ms means no waiting will occur. A value of -1
> + * represents infinite waiting.
> + *
> + * If @reset_on_progress is true, the timeout will be reset whenever any
> + * printer has been seen to make some forward progress.
> + *
> + * Context: Process context. May sleep while acquiring console lock.
> + * Return: true if all enabled printers are caught up.
> + */
> +bool pr_flush(int timeout_ms, bool reset_on_progress)
> +{
> +	int remaining = timeout_ms;
> +	struct console *con;
> +	u64 last_diff = 0;
> +	u64 printk_seq;
> +	u64 diff;
> +	u64 seq;
> +
> +	might_sleep();
> +
> +	seq = prb_next_seq(prb);
> +
> +	for (;;) {
> +		diff = 0;
> +
> +		console_lock();
> +		for_each_console(con) {
> +			if (!console_is_usable(con))
> +				continue;
> +			printk_seq = con->seq;
> +			if (printk_seq < seq)
> +				diff += seq - printk_seq;
> +		}
> +		console_unlock();
> +
> +		if (diff != last_diff && reset_on_progress)
> +			remaining = timeout_ms;
> +
> +		if (diff == 0 || remaining == 0)
> +			break;
> +
> +		if (remaining < 0) {
> +			/* no timeout limit */
> +			msleep(100);
> +		} else if (remaining < 100) {
> +			msleep(remaining);
> +			remaining = 0;
> +		} else {
> +			msleep(100);
> +			remaining -= 100;
> +		}
> +
> +		last_diff = diff;
> +	}
> +
> +	return (diff == 0);
> +}
> +EXPORT_SYMBOL(pr_flush);

Summary:

The pr_flush() API and the optional timeout look reasonable to me.

Please, handle oops_in_progress in pr_flush() and make it safe in this
mode. It will allow to move it at the end of console_unblank() where
it makes more sense.

I do not resist on flushing only the given consoles in console_stop()
and console_start(). It is nice to have and can be done later.

Also I do not resist on doing the flush in the context of the caller.
I am not even sure if it is a good idea. We could play with it
later when there are some problems with the current approach
in practice.

Best Regards,
Petr
