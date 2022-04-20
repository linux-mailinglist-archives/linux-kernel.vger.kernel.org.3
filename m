Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D52508EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381351AbiDTR4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381342AbiDTR4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:56:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E374477D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:53:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F18162112B;
        Wed, 20 Apr 2022 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650477234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fGH9FdJMgDznKesllL476v8fxOKmtY44S9R3LqseiJ0=;
        b=smW+TvVAYOFaUpzX1xbliF3Q2LEuWE2g2H5k1ekdqOelqNluFb83itUiWKfSWWvONp+67N
        G8GHPus0R+5tvzEhDYKex2dVNKsyybOf3Bw7mXWiQDT+qwNh2vE8rEAC2ggaNMV00NqG+k
        MMMPNk4KxxB2tfxuDR6kiKKAfl+tQtc=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BEE392C141;
        Wed, 20 Apr 2022 17:53:54 +0000 (UTC)
Date:   Wed, 20 Apr 2022 19:53:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH printk v3 13/15] printk: add kthread console printers
Message-ID: <YmBIr1mkmIN1Zkb+@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-14-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-14-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 01:52:35, John Ogness wrote:
> Create a kthread for each console to perform console printing. During
> normal operation (@system_state == SYSTEM_RUNNING), the kthread
> printers are responsible for all printing on their respective
> consoles.
> 
> During non-normal operation, console printing is done as it has been:
> within the context of the printk caller or within irqwork triggered
> by the printk caller, referred to as direct printing.
> 
> Since threaded console printers are responsible for all printing
> during normal operation, this also includes messages generated via
> deferred printk calls. If direct printing is in effect during a
> deferred printk call, the queued irqwork will perform the direct
> printing. To make it clear that this is the only time that the
> irqwork will perform direct printing, rename the flag
> PRINTK_PENDING_OUTPUT to PRINTK_PENDING_DIRECT_OUTPUT.
> 
> Threaded console printers synchronize against each other and against
> console lockers by taking the console lock for each message that is
> printed.
> 
> Note that the kthread printers do not care about direct printing.
> They will always try to print if new records are available. They can
> be blocked by direct printing, but will be woken again once direct
> printing is finished.
> 
> Console unregistration is a bit tricky because the associated
> kthread printer cannot be stopped while the console lock is held.
> A policy is implemented that states: whichever task clears
> con->thread (under the console lock) is responsible for stopping
> the kthread. unregister_console() will clear con->thread while
> the console lock is held and then stop the kthread after releasing
> the console lock.
> 
> For consoles that have implemented the exit() callback, the kthread
> is stopped before exit() is called.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -390,6 +397,14 @@ void printk_prefer_direct_exit(void)
>  	WARN_ON(atomic_dec_if_positive(&printk_prefer_direct) < 0);
>  }
>  
> +static inline bool allow_direct_printing(void)
> +{
> +	return (!printk_kthreads_available ||
> +		system_state > SYSTEM_RUNNING ||
> +		oops_in_progress ||
> +		atomic_read(&printk_prefer_direct));
> +}
> +
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  /* All 3 protected by @syslog_lock. */
>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
> @@ -2280,10 +2295,10 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>  
>  	/* If called from the scheduler, we can not call up(). */
> -	if (!in_sched) {
> +	if (!in_sched && allow_direct_printing()) {

allow_direct_printing() is racy here. But I think that we could live
with it, see below.


>  		/*
>  		 * The caller may be holding system-critical or
> -		 * timing-sensitive locks. Disable preemption during
> +		 * timing-sensitive locks. Disable preemption during direct
>  		 * printing of all remaining records to all consoles so that
>  		 * this context can return as soon as possible. Hopefully
>  		 * another printk() caller will take over the printing.

[...]

> @@ -3475,10 +3720,14 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
>  {
>  	int pending = this_cpu_xchg(printk_pending, 0);
>  
> -	if (pending & PRINTK_PENDING_OUTPUT) {
> +	if (pending & PRINTK_PENDING_DIRECT_OUTPUT) {
> +		printk_prefer_direct_enter();
> +
>  		/* If trylock fails, someone else is doing the printing */
>  		if (console_trylock())
>  			console_unlock();
> +
> +		printk_prefer_direct_exit();
>  	}
>  
>  	if (pending & PRINTK_PENDING_WAKEUP)
> @@ -3503,10 +3752,11 @@ static void __wake_up_klogd(int val)
>  	 * prepare_to_wait_event(), which is called after ___wait_event() adds
>  	 * the waiter but before it has checked the wait condition.
>  	 *
> -	 * This pairs with devkmsg_read:A and syslog_print:A.
> +	 * This pairs with devkmsg_read:A, syslog_print:A, and
> +	 * printk_kthread_func:A.
>  	 */
>  	if (wq_has_sleeper(&log_wait) || /* LMM(__wake_up_klogd:A) */
> -	    (val & PRINTK_PENDING_OUTPUT)) {
> +	    (val & PRINTK_PENDING_DIRECT_OUTPUT)) {
>  		this_cpu_or(printk_pending, val);
>  		irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
>  	}
> @@ -3524,7 +3774,16 @@ void defer_console_output(void)
>  	 * New messages may have been added directly to the ringbuffer
>  	 * using vprintk_store(), so wake any waiters as well.
>  	 */
> -	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
> +	int val = PRINTK_PENDING_WAKEUP;
> +
> +	/*
> +	 * If console deferring was called with preferred direct printing,
> +	 * make the irqwork perform the direct printing.
> +	 */
> +	if (atomic_read(&printk_prefer_direct))
> +		val |= PRINTK_PENDING_DIRECT_OUTPUT;

We actually need:

	/*
	 * Make sure that someone will handle the messages when direct
	 * printing is allowed. It happens when the kthreads are less
	 * reliable or unusable at all.
	 */
	if (allow_direct_printing())
		val |= PRINTK_PENDING_DIRECT_OUTPUT;


It is racy. But the same race is also in vprintk_emit().

False positive is fine. console_flush_all() will bail out when
the direct printing gets disabled in the meantime.

False negative is worse. But we will still queue PRINTK_PENDING_WAKEUP
that will try to wake up the kthreads that should still be around.

And it was always problem even with console_trylock() approach.
Failure means an expectation that someone else is doing the printing.
It might be either a kthread or the current console_lock owner.
But it is never guaranteed because both might be sleeping.

We do our best by calling pr_flush() or console_flush_on_panic()
on various places. Also PRINTK_PENDING_WAKEUP will always try to wake
up the kthreads.


Anyway, we should document this somewhere. At least in the commit
message.

My dream is Documentation/core-api/printk-design.rst but I do not
want to force you to do it ;-)


> +	__wake_up_klogd(val);
>  }
>  
>  void printk_trigger_flush(void)

Otherwise, it looks good.

Best Regards,
Petr
