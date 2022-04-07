Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D674F8520
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345817AbiDGQqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbiDGQqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:46:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7711C1E6A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:44:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 237B51F85A;
        Thu,  7 Apr 2022 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649349843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qqPzhZ3IRiMem1hQol0HyQl1hPa6KU1MVkQbSghKsiE=;
        b=WVI8rxzxZuEB661yjwfgXJUG+Eu+cVBE61uzdRiSiqy5kLVusdoGE38iZZECHfxSB8aBGS
        qESMVlpQyN1J1slGy4cm7pYNrerRrFzfzWzuy7eo5SrktFAVHDqA+KmYn7w4JcqGhXf4Uu
        1fTtGzLdqeCLyY/K5q9JJpZ1wAFUryE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C4064A3BA6;
        Thu,  7 Apr 2022 16:44:02 +0000 (UTC)
Date:   Thu, 7 Apr 2022 18:43:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: start/stop: was: Re: [PATCH printk v2 10/12] printk: add kthread
 console printers
Message-ID: <Yk8UzzWTbfsPQNx5@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:33, John Ogness wrote:
> Create a kthread for each console to perform console printing. During
> normal operation (@system_state == SYSTEM_RUNNING), the kthread
> printers are responsible for all printing on their respective
> consoles.
> 
> During non-normal operation, console printing is done as it has been:
> within the context of the printk caller or within irq work triggered
> by the printk caller.
> 
> Console printers synchronize against each other and against console
> lockers by taking the console lock for each message that is printed.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 258d02cff140..a3b8b984c9aa 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2988,6 +3028,10 @@ void console_start(struct console *console)
>  	console_lock();
>  	console->flags |= CON_ENABLED;
>  	console_unlock();
> +
> +	/* Wake the newly enabled kthread printer. */
> +	wake_up_klogd();

wake_up_klogd() will wake the kthread only when PRINTK_PENDING_OUTPUT
is set. But this particular console might be far behind the other
kthreads.

I think that we always want to wake up the kthread. In the worst case,
it will just realize that there is nothing to do and will go back to sleep.

> +
>  	__pr_flush(console, 1000, true);
>  }
>  EXPORT_SYMBOL(console_start);
 @@ -3196,6 +3240,8 @@ void register_console(struct console *newcon)
>  		/* Begin with next message. */
>  		newcon->seq = prb_next_seq(prb);
>  	}
> +	if (printk_kthreads_available)
> +		printk_start_kthread(newcon);
>  	console_unlock();
>  	console_sysfs_notify();
>  
> @@ -3222,6 +3268,7 @@ EXPORT_SYMBOL(register_console);
>  
>  int unregister_console(struct console *console)
>  {
> +	struct task_struct *thd = console->thread;
>  	struct console *con;
>  	int res;
>  
> @@ -3233,6 +3280,11 @@ int unregister_console(struct console *console)
>  	if (res > 0)
>  		return 0;
>  
> +	if (thd) {
> +		console->thread = NULL;
> +		kthread_stop(thd);

This feels racy against parallel register_console() and
unregister_console() calls. I guess that it is not much
realistic in the real life but ...

Anyway, printk_start_kthread(newcon) is called under console_lock().
It would be great to stop it under the lock as well so that we
do not need to worry about races.

Hmm, it might cause deadlock at this stage because the kthread
take console_lock() in the main loop.

It should work after introducing the per-console mutexes. They might
be taken when console_lock() is taken. But the kthread will
not do the printing when the console_lock() is taken by anyone else.

A solution might be to add a comment that there is a non-realistic
race that will be removed by introducing per-console mutexes.
And fix it later.

Nit: Also I would prefer to create printk_stop_kthread()
     so that it is easy to find the counterparts.


> +	}
> +
>  	res = -ENODEV;
>  	console_lock();
>  	if (console_drivers == console) {

[...]

> +static int printk_kthread_func(void *data)
> +{
> +	struct console *con = data;
> +	char *dropped_text = NULL;
> +	char *ext_text = NULL;
> +	bool handover;
> +	u64 seq = 0;
> +	char *text;
> +	int error;
> +
> +	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
> +	if (!text) {
> +		printk_console_msg(con, KERN_ERR, "failed to allocate text buffer");
> +		printk_fallback_preferred_direct();
> +		goto out;
> +	}
> +
> +	if (con->flags & CON_EXTENDED) {
> +		ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
> +		if (!ext_text) {
> +			printk_console_msg(con, KERN_ERR, "failed to allocate ext_text buffer");
> +			printk_fallback_preferred_direct();
> +			goto out;
> +		}
> +	} else {
> +		dropped_text = kmalloc(DROPPED_TEXT_MAX, GFP_KERNEL);
> +		if (!dropped_text) {
> +			printk_console_msg(con, KERN_ERR,
> +					   "failed to allocate dropped_text buffer");
> +			printk_fallback_preferred_direct();
> +			goto out;
> +		}
> +	}
> +
> +	printk_console_msg(con, KERN_INFO, "printing thread started");
> +
> +	for (;;) {
> +		/*
> +		 * Guarantee this task is visible on the waitqueue before
> +		 * checking the wake condition.
> +		 *
> +		 * The full memory barrier within set_current_state() of
> +		 * prepare_to_wait_event() pairs with the full memory barrier
> +		 * within wq_has_sleeper().
> +		 *
> +		 * See __wake_up_klogd:A for the pairing memory barrier.
> +		 */
> +		error = wait_event_interruptible(log_wait,
> +				printer_should_wake(con, seq)); /* LMM(printk_kthread_func:A) */
> +
> +		if (kthread_should_stop() || !printk_kthreads_available)
> +			break;

printk_fallback_preferred_direct() is an interesting trick. But I am
not sure if it is a good idea. This approach leaves con->kthread
pointing to exited kthreads.

The following looks cleaner and should work:

void printk_stop_kthread(struct console *con)
{
	struct task_struct *thread = con->thread;

	if (!thread)
		return;

	console->thread = NULL;
	kthread_stop(thread);
}

void printk_deactivate_kthreas()
{
	struct console *con;

	console_lock();
	printk_kthreads_available = false;
	console_unlock();

	for_each_console(con)
		printk_stop_kthread(con);
}

And we could move printk_stop_kthread() under console lock
after introducing the per-console mutex.


Best Regards,
Petr
