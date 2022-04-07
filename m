Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62534F8531
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345832AbiDGQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbiDGQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:51:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8214ABF7F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:49:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2DA4A1F85E;
        Thu,  7 Apr 2022 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649350161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uBE8fJw4zie33LCbR+57169pkVLHawLVnL4hY5+yeRE=;
        b=l+833uwnLTunhnm4JDrrsAefFgKIba+JRcfyOlb9gzp50hHqJQY56fBKJSWv7cct68aDoG
        xd6S4L5VBVITJD6EySNOgXASIozwaH+WRaUgzwdlC/+gY2NUkGmavTtsrEMHUUtblCnJ8J
        nA6F51QAbYeJb0qm8cbt/+FHXrpG6LE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0B08EA3B8A;
        Thu,  7 Apr 2022 16:49:21 +0000 (UTC)
Date:   Thu, 7 Apr 2022 18:49:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: console_is_usable() check: was: Re: [PATCH printk v2 10/12] printk:
 add kthread console printers
Message-ID: <Yk8WD2vZEm880fo4@alley>
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
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> +static bool printer_should_wake(struct console *con, u64 seq)
> +{
> +	short flags;
> +
> +	if (kthread_should_stop() || !printk_kthreads_available)
> +		return true;
> +
> +	if (console_suspended)
> +		return false;
> +
> +	if (!con->write)
> +		return false;

Hmm, the kthread for such consoles will never wake up. It probably
does not make sense to create it at all.

On the other hand, it is not a big deal. And we have "bigger" problem
how to make these checks in sync with console_is_usable(), see below.

> +	/*
> +	 * This is an unsafe read to con->flags, but a false positive is not
> +	 * a problem. Worst case it would allow the printer to wake up even
> +	 * when it is disabled. But the printer will notice that itself when
> +	 * attempting to print and instead go back to sleep.
> +	 */
> +	flags = data_race(READ_ONCE(con->flags));
> +	if (!(flags & CON_ENABLED))
> +		return false;
> +
> +	if (atomic_read(&printk_prefer_direct))
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
> +
> +		if (error)
> +			continue;
> +
> +		console_lock();
> +
> +		if (console_suspended) {
> +			__console_unlock();
> +			continue;
> +		}
> +
> +		if (!console_is_usable(con)) {
> +			__console_unlock();
> +			continue;
> +		}

This smells with a busy loop. We should make sure that the same
condition will make printk_kthread_func() return false. The current
approach is hard to maintain.

Hmm, it is not easy because console_is_usable(con) is supposed
to be called under console_lock().

I do not have a good solution for this. But the current approach looks
error prone. What about the following?

static inline bool __console_is_usable(struct console *con)
{
	short flags;

	if (!con->write)
		return false;

	/* Make flags checks consistent when called without console_lock. */
	flags = READ_ONCE(con->flags);

	if (!(con->flags & CON_ENABLED))
		return false;

	/*
	 * Console drivers may assume that per-cpu resources have been
	 * allocated. So unless they're explicitly marked as being able to
	 * cope (CON_ANYTIME) don't call them until this CPU is officially up.
	 */
	if (!cpu_online(raw_smp_processor_id()) &&
	    !(con->flags & CON_ANYTIME))
		return false;

	return true;
}

static inline bool console_is_usable(struct console *con)
{
	WARN_ON_ONCE(!lockdep_assert_held(&console_sem));

	__console_is_usable();
}

Note that we could not use lockdep_assert_held() because we will
later need to check both console_sem and con->mutex. Either of
them will be enough.

> +
> +		/*
> +		 * Even though the printk kthread is always preemptible, it is
> +		 * still not allowed to call cond_resched() from within
> +		 * console drivers. The task may become non-preemptible in the
> +		 * console driver call chain. For example, vt_console_print()
> +		 * takes a spinlock and then can call into fbcon_redraw(),
> +		 * which can conditionally invoke cond_resched().
> +		 */
> +		console_may_schedule = 0;
> +		console_emit_next_record(con, text, ext_text, dropped_text, &handover);
> +		if (handover)
> +			continue;
> +
> +		seq = con->seq;
> +
> +		__console_unlock();
> +	}
> +
> +	printk_console_msg(con, KERN_INFO, "printing thread stopped");
> +out:
> +	kfree(dropped_text);
> +	kfree(ext_text);
> +	kfree(text);
> +	return 0;
> +}

Best Regards,
Petr
