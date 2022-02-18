Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101764BB4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiBRJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:04:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiBRJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:04:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89552BA77F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:04:40 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E595F1F37D;
        Fri, 18 Feb 2022 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645175078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=da51WVZQbbZtQI4xx6YUIAVO+nEkYuxtVw098L1wUuE=;
        b=c2pekESmLtqXCJIecXBJLbcl0gGtqCyZLzoF29mOLciUOQhJB/NFJjFY7ba/L/na0n8QO9
        B44pkUvaYUwV9JAS5OVZSIK/EJ4cfdZCHe4cY90rD0l4xs/FXZfIOnraqoMPYc6VmYla1H
        hTh45jh8e13ozGCDCydWjKfc+vF1A84=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CBB90A3B84;
        Fri, 18 Feb 2022 09:04:38 +0000 (UTC)
Date:   Fri, 18 Feb 2022 10:04:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: start&stop: was: Re: [PATCH printk v1 10/13] printk: add kthread
 console printers
Message-ID: <Yg9hJgFJgoVhgtBu@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:20, John Ogness wrote:
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
> ---
>  include/linux/console.h |   2 +
>  kernel/printk/printk.c  | 159 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 159 insertions(+), 2 deletions(-)
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3114,6 +3145,8 @@ void register_console(struct console *newcon)
>  		/* Begin with next message. */
>  		newcon->seq = prb_next_seq(prb);
>  	}
> +	if (kthreads_started)
> +		start_printk_kthread(newcon);

It is a corner case but we should handle possible error here.

The easiest solution is to stop all other printk kthreads and
use direct printing all the time. It should be enough because
it is a corner case. If kthreads could not be created then
the system is in big troubles anyway.

>  	console_unlock();
>  	console_sysfs_notify();
>  
> @@ -3170,6 +3203,11 @@ int unregister_console(struct console *console)
>  		}
>  	}
>  
> +	if (console->thread) {
> +		kthread_stop(console->thread);

I think that must not be called under console_lock or any other
locks that might be used by the kthread.

kthread_stop() waits until the kthread really exits. It means
that kthread_func() must check kthread_should_stop() and return.

There might be a deadlock when kthread_func() need to take some
locks in the main loop between kthread_should_stop() checks.

> +		console->thread = NULL;
> +	}
> +
>  	if (res)
>  		goto out_disable_unlock;
>  
> @@ -3345,6 +3390,116 @@ bool pr_flush(int timeout_ms, bool
> reset_on_progress)
[...]
> +}
> +
> +static int printk_kthread_func(void *data)
> +{
> +	struct console *con = data;
> +	char *dropped_text = NULL;
> +	char *ext_text = NULL;
> +	bool progress;
> +	bool handover;
> +	u64 seq = 0;
> +	char *text;
> +	int error;
> +
> +	pr_info("%sconsole [%s%d]: printing thread started\n",
> +		(con->flags & CON_BOOT) ? "boot" : "",
> +		con->name, con->index);

This should be printed after the allocations succeeded before entering
the main loop.

> +	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
> +	if (!text)
> +		goto out;
> +
> +	if (con->flags & CON_EXTENDED) {
> +		ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
> +		if (!ext_text)
> +			goto out;
> +	} else {
> +		dropped_text = kmalloc(DROPPED_TEXT_MAX, GFP_KERNEL);
> +		if (!dropped_text)
> +			goto out;
> +	}

here

> +	for (;;) {
> +		error = wait_event_interruptible(log_wait, printer_should_wake(con, seq));
> +
> +		if (kthread_should_stop())
> +			break;
> +
> +		if (error)
> +			continue;
> +
> +		do {

[...]

> +
> +/* Must be called within console_lock(). */
> +static void start_printk_kthread(struct console *con)
> +{
> +	con->thread = kthread_run(printk_kthread_func, con,
> +				  "pr/%s%d", con->name, con->index);
> +	if (IS_ERR(con->thread)) {
> +		con->thread = NULL;
> +		pr_err("%sconsole [%s%d]: unable to start printing thread\n",
> +			(con->flags & CON_BOOT) ? "boot" : "",
> +			con->name, con->index);
> +		return;

We need to pass the error down. The system has to switch to
direct printing off when any printk kthread could not be started.
Otherwise, the related console would not work.

> +	}
> +}
> +
>  /*
>   * Delayed printk version, for scheduler-internal messages:
>   */

Best Regards,
Petr
