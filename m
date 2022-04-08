Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598CA4F9734
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbiDHNsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiDHNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:48:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3978BF4F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:45:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6EED11F85F;
        Fri,  8 Apr 2022 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649425554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2/pyto4pumlbKOERRI/sbNmVs+jgtuPMB8KKfgBINDk=;
        b=e6h1eGlnBt25PWGTV/BfxFdkI6en50CD0NdfhPAxE+Z6Ph8qJRcf9xSohNtwguFqE5JdDi
        kwUAbQdIHJzGd6ML04jQau9q9xp4af7PlOfCqlUOsKor9ZLWM/Zs1O2DY5nMSS0FBJLhRq
        R2sZpzx9ErHB5EnLlHel4miv1x9TFBU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1C51DA3B89;
        Fri,  8 Apr 2022 13:45:54 +0000 (UTC)
Date:   Fri, 8 Apr 2022 15:45:50 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: guarantee forward progress: was: Re: [PATCH printk v2 11/12] printk:
 extend console_lock for proper kthread support
Message-ID: <YlA8jpuziDrD27A2@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:34, John Ogness wrote:
> Currently threaded console printers synchronize against each
> other using console_lock(). However, different console drivers
> are unrelated and do not require any synchronization between
> each other. Removing the synchronization between the threaded
> console printers will allow each console to print at its own
> speed.
> 
> But the threaded consoles printers do still need to synchronize
> against console_lock() callers. Introduce a per-console mutex
> and a new console flag CON_THD_BLOCKED to provide this
> synchronization.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2691,6 +2760,22 @@ static inline bool console_is_usable(struct console *con)
>  static void __console_unlock(void)
>  {
>  	console_locked = 0;
> +
> +	/*
> +	 * Depending on whether console_lock() or console_trylock() was used,
> +	 * appropriately allow the kthread printers to continue.
> +	 */
> +	if (console_kthreads_blocked)
> +		console_kthreads_unblock();
> +	else
> +		console_kthreads_atomic_unblock();
> +
> +	/*
> +	 * New records may have arrived while the console was locked.
> +	 * Wake the kthread printers to print them.
> +	 */
> +	wake_up_klogd();

Thinking loudly:

Strictly speaking, this is needed only when kthreads are allowed. It
might make sense to do:

	if (!allow_direct_printing())
		wake_up_klogd();

On the other hand, the check is racy. So it might be better to always
call wake_up_klogd() and do not worry about it. The optimization
probably is not worth it.

But this brings the question. How do we actually ensure that either
kthreads or direct printk will handle pending messages.

vprintk_emit() or defer_console_output() make sure that either
direct printkg is used or kthreads are waken. It makes the decision
via the current state of allow_direct_printing(). But it might
change in the meantime.

allow_direct_printing() might change in both directions:

1. printk trigger direct -> kthreads enabled when in direct mode.

   This switch might be handled by the above wake_up_klogd().

   If it is non-conditional, it might handle  also racy
   mutiple direct -> kthread -> direct mode swtiches.


2. printk wakes kthreads -> direct mode allowed when there
   are still pending messages.

   I am afraid that we do not have this path well covered.

   It probably worked "better" in v1 where the kthreads continued
   handling the messages until all were flushed. But I guess that
   there were still races when new messages appeared after some
   kthreads finished the job.

   Hmm, it actually is not enough to call defer_console_output()
   in printk_prefer_direct_enter(). It is because
   wake_up_klogd_work_func() does console_trylock(). It might
   still be blocked by an active kthread. But the other kthreads
   might already sleep.

   I think that we actually need to call defer_console_output()
   after kthread() unblocks console_trylock() and
   the direct mode is preferred(). I mean something like:

static int printk_kthread_func(void *data)
{
[...]
	for (;;) {
[...]
		console_emit_next_record(con, text, ext_text, dropped_text);
		seq = con->seq;

		console_kthread_printing_exit();

+		/*
+		 * This thread does not longer block console_trylock(). Make
+		 * sure that someone will try to flush pending
+		 * messages in the direct mode when it has got preferred
+		 * in the meantime.
+		 */
+		if (allow_direct_printing())
+			deffer_console_output();
+
		mutex_unlock(&con->lock);
	}
[...]
}

Hmm, it is still not enough. We should do it also in printer_should_wake().
It will be needed when the original printk() woke kthreads and
the direct mode got preferred before the kthread started printing.
In this case, the kthreads will do nothing and nobody will handle
the pending messages.

I played a lot with it and it is really hard because:

   + new messages can appear anytime
   + direct mode might get requested anytime
   + only the direct mode knows whether all messages were flushed
     on all consoles

IMHO, ideal logic would be:

   + new messages will always trigger direct printing or wake
     kthreads, newer both

   + direct mode will wake kthreads when kthreads are allowed
     and there are penging messages.

   + (the last) kthread will wake_up direct mode when it is requested
     and there are pending messages.

We could use the trick that the direct mode never gives up when there
are pending messages.

It requires moving printk kthreads into a separate waitqueue:

DECLARE_WAIT_QUEUE_HEAD(printk_kthread_wait);

I suggest to rename the flags in the wake_up_klogd() API

/*
 * Delayed printk version, for scheduler-internal messages:
 */

#define PRINTK_WAKE_UP_LOG		0x01
#define PRINTK_WAKE_UP_KTHREADS		0x02
#define PRINTK_PENDING_DIRECT_OUTPUT	0x04

static DEFINE_PER_CPU(int, printk_pending);

static void wake_up_klogd_work_func(struct irq_work *irq_work)
{
	int pending = this_cpu_xchg(printk_pending, 0);

	if (pending & PRINTK_PENDING_DIRECT_OUTPUT) {
		printk_prefer_direct_enter();

		/* If trylock fails, someone else is doing the printing */
		if (console_trylock())
			console_unlock();

		printk_prefer_direct_exit();
	}

	if (pending & PRINTK_WAKEUP_LOG)
		wake_up_interruptible_all(&log_wait);

	if (pending & PRINTK_WAKEUP_KTHREADS)
		wake_up_interruptible_all(&printk_kthread_wait);
}

static DEFINE_PER_CPU(struct irq_work, printk_wake_up_work) =
	IRQ_WORK_INIT_LAZY(wake_up_klogd_work_func);

static void __printk_wake_up(int val)
{
	if (!printk_percpu_data_ready())
		return;

	preempt_disable();
	/*
	 * Guarantee any new records can be seen by printing threads before
	 * checking if the wait queue is empty.
	 *
	 * The full memory barrier within wq_has_sleeper() pairs with the full
	 * memory barrier within set_current_state() of
	 * prepare_to_wait_event(), which is called after ___wait_event() adds
	 * the waiter but before it has checked the wait condition.
	 *
	 * See printk_kthread_func:A for the pairing memory barrier.
	 */
	 if (wq_has_sleeper(&log_wait) || /* LMM(__printk_wake_up:A) */
	     wq_has_sleeper(&printk_kthread_wait) || /* LMM(__printk_wake_up:B) */
	     (val & PRINTK_PENDING_DIRECT_OUTPUT)) {
		this_cpu_or(printk_pending, val);
		irq_work_queue(this_cpu_ptr(&printk_wake_up_work));
	}
	preempt_enable();
}

void printk_wake_up_klogd(void)
{
	__wake_up_klogd(PRINTK_WAKE_UP_LOG);
}

void printk_wake_up_all(void)
{
	__wake_up_klogd(PRINTK_WAKE_UP_LOG || PRITNK_WAKE_UP_KTHREADS);
}

void defer_console_output(void)
{
	int val = PRINTK_WAKE_UP_LOG;

	/*
	 * If console deferring was called with preferred direct printing,
	 * make the irqwork perform the direct printing.
	 */
	if (atomic_read(&printk_prefer_direct))
		val |= PRINTK_PENDING_DIRECT_OUTPUT;
	else
		val |= PRINTK_WAKE_UP_KTHREADS;

	__wake_up_klogd(val);
}


And do

asmlinkage int vprintk_emit(int facility, int level,
			    const struct dev_printk_info *dev_info,
			    const char *fmt, va_list args)
{
[...]
	/* If called from the scheduler, we can not call up(). */
	if (!in_sched && allow_direct_printing()) {
		preempt_disable();
		if (console_trylock_spinning())
			console_unlock();
		preempt_enable();
		printk_wake_up_klogd();
	} else {
		printk_wake_up_all();
	}

	return printed_len;
}

static bool printer_should_wake(struct console *con, u64 seq)
{
[...]
	if (__allow_direct_printing()) {
		/* Make sure that someone does the direct printing. */
		if (rb_read_valid(prb, next_seq, NULL))
			defer_console_output();

		return false;
	}
[...]
}

void console_unlock(void)
{
	bool do_cond_resched;
	bool handover;
	bool flushed;
	u64 next_seq;

	if (console_suspended) {
		up_console_sem();
		return;
	}

	/*
	 * Console drivers are called with interrupts disabled, so
	 * @console_may_schedule should be cleared before; however, we may
	 * end up dumping a lot of lines, for example, if called from
	 * console registration path, and should invoke cond_resched()
	 * between lines if allowable.  Not doing so can cause a very long
	 * scheduling stall on a slow console leading to RCU stall and
	 * softlockup warnings which exacerbate the issue with more
	 * messages practically incapacitating the system. Therefore, create
	 * a local to use for the printing loop.
	 */
	do_cond_resched = console_may_schedule;

	do {
		console_may_schedule = 0;

		if (!any_usable_console()) {
			__console_unlock();
			break;
		}

		flushed = console_flush_all(do_cond_resched, &next_seq, &handover);
		if (handover)
			return;

		__console_unlock();

		/* Any pending messages? */
		if (!prb_read_valid(prb, next_seq, NULL))
			break ;

		if (!allow_direct_printing()) {
			/*
			 * Make sure that kthreads take over handling
			 * the pending messages.
			 */
			printk_wake_up_kthreads();
			break;
		}

		/* Only panic CPU should handle consoles. */
		if (abandon_console_lock_in_panic())
			break;

		WARN_ONCE(!flushed,
			  "The consoles were not flused in the direct more from unknown reasons\n");

		/*
		 * Try to continue with direct printing. If the trylock fails,
		 * another context is already handling the printing. It is
		 * responsible for flushing everything.
		 */
	} while console_trylock();
}

Note that I have added back any_usable_console(). console_flush_all()
might fail from different reasons. Each reason needs its own handling.
And we need to know that we handled all and use WARN_ONCE().


Uff, I have spent few hours thinking about it and reworked it several
times. The above is the best solution that I was able to come up with.

I send what I have now because I feel tired and do not want to sit
on it. But it is possible that I just have got lost and will see it
on Monday.

>  	up_console_sem();
>  }
>  

Alternative solution would be to go back to v1 and allow kthreads
handling the messages even when direct more is preferred. The direct
mode would be used only when console_trylock() succeeds or when
some code calls console_lock().

Best Regards,
Petr
