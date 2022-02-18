Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF44BB50D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiBRJIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:08:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiBRJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:08:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5441A13B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 01:08:19 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4802A1F383;
        Fri, 18 Feb 2022 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645175298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WALrlzVYoW1+ey/rywCALJO0JwxJ7pJRa7cqfj4GVPg=;
        b=farHPhEmDA1sEplRo3iPQmN7eBdVXgWdxW3adqSKGYFAmcJDLUv9gIQwkByJXnFSquM1D8
        v2dHxlE9OgSZ8v6WyeWtjT5j5D8Nc6G+qswC4/CmcjqJRYvO0E2WtSzxRBQUKTrMAUYaAI
        6+HPKtYxCy91nbFnWaeDVCS78HEejMo=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2E60FA3B84;
        Fri, 18 Feb 2022 09:08:18 +0000 (UTC)
Date:   Fri, 18 Feb 2022 10:08:17 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: main loop: was: Re: [PATCH printk v1 10/13] printk: add kthread
 console printers
Message-ID: <Yg9iAVk5s4dBfDvP@alley>
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
> @@ -3345,6 +3390,116 @@ bool pr_flush(int timeout_ms, bool reset_on_progress)
>  }
>  EXPORT_SYMBOL(pr_flush);
>  
> +static bool printer_should_wake(struct console *con, u64 seq)
> +{
> +	short flags;
> +
> +	if (kthread_should_stop())
> +		return true;
> +
> +	if (console_suspended)
> +		return false;
> +
> +	/*
> +	 * This is an unsafe read to con->flags, but false positives
> +	 * are not an issue as long as they are rare.

This is not convincing. Anyway, it looks like an optimization. I
suggest to do the check under console_lock in the main loop.
printk kthread is a slow path anyway.

Also we should call there the entire console_is_usable().
It should do the same checks as in console_flush_all()
and the direct mode.

> +	 */
> +	flags = data_race(READ_ONCE(con->flags));
> +	if (!(flags & CON_ENABLED))
> +		return false;
> +
> +	return prb_read_valid(prb, seq, NULL);
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
> +
[...]
> +
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
> +			console_lock();
> +			if (console_suspended) {
> +				console_unlock();
> +				break;
> +			}
> +

We should check here also console_is_usable() to be in sync with
console_flush_all().

> +			/*
> +			 * Even though the printk kthread is always preemptible, it is
> +			 * still not allowed to call cond_resched() from within
> +			 * console drivers. The task may become non-preemptible in the
> +			 * console driver call chain. For example, vt_console_print()
> +			 * takes a spinlock and then can call into fbcon_redraw(),
> +			 * which can conditionally invoke cond_resched().
> +			 */
> +			console_may_schedule = 0;

I do not understand the reason. How is this different from console_unlock()
and console_flush_all(), please?

> +			progress = console_emit_next_record(con, text, ext_text,
> +							    dropped_text, &handover);
> +			if (handover)
> +				break;
> +
> +			seq = con->seq;
> +
> +			/* Unlock console without invoking direct printing. */
> +			__console_unlock();
> +		} while (progress);
> +	}
> +out:
> +	kfree(dropped_text);
> +	kfree(ext_text);
> +	kfree(text);
> +	pr_info("%sconsole [%s%d]: printing thread stopped\n",
> +		(con->flags & CON_BOOT) ? "boot" : "",
> +		con->name, con->index);
> +	return 0;
> +}
> +

Best Regards,
Petr
