Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E184C1026
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbiBWKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbiBWKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:20:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF49B8BF24
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:19:44 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9987F1F43D;
        Wed, 23 Feb 2022 10:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645611583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NOuY1k8iqSiB0qSb8P6YipaThLsTq9Oq8Ifqn73sWKo=;
        b=gNx8CIDbXQok7BvcKgzCNTZd+DRohPC5//xq1hA43L34IWt3bPwrjFNzdyVPM6AoW2GrWQ
        tSApwu7rVBfI0ogN7w7XKd5QqliQpNqSyx7Q5l8AArZfVbSsCR4AY95X3bLQYJcjM99goW
        jhnLWJIuiEMsPaiFhe1kgU+380R9pYg=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6DDE2A3B84;
        Wed, 23 Feb 2022 10:19:43 +0000 (UTC)
Date:   Wed, 23 Feb 2022 11:19:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <YhYKP/UuSKENGwfj@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:21, John Ogness wrote:
> Rather than console_lock() callers holding the per-console mutex
> for the duration of the console lock, the per-console mutex is only
> taken in order to set a new CON_PAUSED flag, which is checked by
> the kthread printers. This avoids any issues due to nested locking
> between the various per-console mutexes.
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 0f94b1771df8..c51c7f5507a5 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -16,6 +16,7 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/types.h>
> +#include <linux/mutex.h>
>  
>  struct vc_data;
>  struct console_font_op;
> @@ -136,6 +137,7 @@ static inline int con_debug_leave(void)
>  #define CON_ANYTIME	(16) /* Safe to call before per-cpu resources ready */
>  #define CON_BRL		(32) /* Used for a braille device */
>  #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
> +#define CON_PAUSED	(128) /* Sleep while console is locked */

I was few times confused by the name. It sounds like that the console
does not show any messages as all. I mean that it is something as
console_suspend().

It is not easy to find a good short name explaining that it is only
about kthreads. What about CON_DIRECT?

>  
>  struct console {
>  	char	name[16];
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e182f31fec58..135fbe647092 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -214,6 +214,26 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>  /* Number of registered extended console drivers. */
>  static int nr_ext_console_drivers;
>  
> +/*
> + * Used to synchronize printing kthreads against direct printing via
> + * console_trylock/console_unlock.
> + *
> + * Values:
> + * -1 = console locked (via trylock), kthreads will not print
> + *  0 = no kthread printing, console not locked (via trylock)
> + * >0 = kthread(s) actively printing
> + *
> + * Note: For synchronizing against direct printing via
> + *       console_lock/console_unlock, see the @lock variable in
> + *       struct console.
> + */
> +static atomic_t console_lock_count = ATOMIC_INIT(0);

I am getting lost in all the variables called lock.

What about calling this "console_kthreads_active"? The counter is
incremented when a kthread is actively printing.

> +#define console_excl_trylock() (atomic_cmpxchg(&console_lock_count, 0, -1) == 0)
> +#define console_excl_unlock() atomic_cmpxchg(&console_lock_count, -1, 0)
> +#define console_printer_tryenter() atomic_inc_unless_negative(&console_lock_count)
> +#define console_printer_exit() atomic_dec(&console_lock_count)

Similar here. What about the following

#define console_kthreads_atomic_tryblock() (atomic_cmpxchg(&console_kthreads_active, 0, -1) == 0)
#define console_kthreads_atomic_unblock() atomic_cmpxchg(&console_kthreads_active, -1, 0)
#define console_kthread_tryenter() atomic_inc_unless_negative(&console_kthreads_active)
#define console_kthread_exit() atomic_dec(&console_kthreads_active)

It is more clear that it is an "atomic" way to block/pause the "kthreads".

I do not resist on the word "block". I somehow like it more than
"pause". But "pause" is good as well when used together with "kthreads".


> +
>  /*
>   * Helper macros to handle lockdep when locking/unlocking console_sem. We use
>   * macros instead of functions so that _RET_IP_ contains useful information.
> @@ -256,6 +276,37 @@ static void __up_console_sem(unsigned long ip)
>  }
>  #define up_console_sem() __up_console_sem(_RET_IP_)
>  
> +/*
> + * Tracks whether kthread printers are all paused. A value of true implies
> + * that the console is locked via console_lock() or the console is suspended.
> + * Reading and writing to this variable requires holding @console_sem.
> + */
> +static bool consoles_paused;
> +
> +/*
> + * Pause or unpause all kthread printers.
> + *
> + * Requires the console_lock.
> + */
> +static void __pause_all_consoles(bool do_pause)

Again. It feels like no consoles will work anymore. What about

     console_kthreads_block().

> +{
> +	struct console *con;
> +
> +	for_each_console(con) {
> +		mutex_lock(&con->lock);
> +		if (do_pause)
> +			con->flags |= CON_PAUSED;
> +		else
> +			con->flags &= ~CON_PAUSED;
> +		mutex_unlock(&con->lock);
> +	}
> +
> +	consoles_paused = do_pause;
> +}
> +
> +#define pause_all_consoles() __pause_all_consoles(true)
> +#define unpause_all_consoles() __pause_all_consoles(false)
> +
>  /*
>   * This is used for debugging the mess that is the VT code by
>   * keeping track if we have the console semaphore held. It's
> @@ -2568,15 +2616,45 @@ int console_trylock(void)
>  		up_console_sem();
>  		return 0;
>  	}
> +	if (!console_excl_trylock()) {
> +		up_console_sem();
> +		return 0;
> +	}
>  	console_locked = 1;
>  	console_may_schedule = 0;
>  	return 1;
>  }
>  EXPORT_SYMBOL(console_trylock);
>  
> +/*
> + * A variant of console_trylock() that allows specifying if the context may
> + * sleep. If yes, a trylock on @console_sem is attempted and if successful,
> + * the threaded printers are paused. This is important to ensure that
> + * sleepable contexts do not become involved in console_lock handovers and
> + * will call cond_resched() during the printing loop.
> + */
> +static int console_trylock_sched(bool may_schedule)
> +{
> +	if (!may_schedule)
> +		return console_trylock();
> +
> +	might_sleep();
> +
> +	if (down_trylock_console_sem())
> +		return 0;
> +	if (console_suspended) {
> +		up_console_sem();
> +		return 0;
> +	}
> +	pause_all_consoles();

This is weird. Any trylock function should be fast and non-blocking.
But pause_all_consoles() uses mutex_lock().

My expectation would be that console_trylock_sched() behaves
excatly the same as console_trylock() except that it will
set console_may_schedule by the given parameter.

I would do it the other way. Rename console_trylock() and
implement:

int console_trylock(void)
{
	return console_trylock_sched(false);
}

LATER: I got it. It is used by console_trylock_sched() called
       in console_unlock() when "do_cond_resched == true". In this
       case, the trylock might wait for the mutexes. It will prevent
       transfering console_lock from schedulable to atomic context
       by the check in console_emit_next_record().

       Hmm, I would still prefer to keep console_trylock_sched()
       behavior sane: non-blocking in all situations. It means
       that we actually do not need it and console_trylock()
       is enough.

       It will allow to steal console_lock() from schedulable
       context. But it is not a regression. And it is only
       a corner case when console_unlock() re-takes the semaphore
       after releasing it.

       We could do the same optimization in console_unlock() by
       calling console_emit_next_record() with NULL handover pointer
       when do_cond_resched == true. But we should do it
       as a separate patch later.


> +	console_locked = 1;
> +	console_may_schedule = 1;
> +	return 1;
> +}
> +
>  int is_console_locked(void)
>  {
> -	return console_locked;
> +	return (console_locked || atomic_read(&console_lock_count));
>  }
>  EXPORT_SYMBOL(is_console_locked);
>  
> @@ -2610,6 +2688,19 @@ static inline bool console_is_usable(struct console *con)
>  static void __console_unlock(void)
>  {
>  	console_locked = 0;
> +
> +	/*
> +	 * Depending on whether console_lock() or console_trylock() was used,
> +	 * appropriately allow the kthread printers to continue.
> +	 */
> +	if (consoles_paused)
> +		unpause_all_consoles();
> +	else
> +		console_excl_unlock();

This is a good example when the meaning of console_excl_lock() is not
obvious. IHMO, the following is easier to understand:

	if (console_kthreads_blocked)
		console_kthreads_unblock();
	else
		console_kthreads_atomic_unblock();

> +
> +	/* Wake the kthread printers. */
> +	wake_up_klogd();
> +
>  	up_console_sem();
>  }
>  
> @@ -2632,7 +2723,8 @@ static void __console_unlock(void)
>   *
>   * @handover will be set to true if a printk waiter has taken over the
>   * console_lock, in which case the caller is no longer holding the
> - * console_lock. Otherwise it is set to false.
> + * console_lock. Otherwise it is set to false. A NULL pointer may be provided
> + * to disable allowing the console_lock to be taken over by a printk waiter.
>   */
>  static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
>  				     char *dropped_text, bool *handover)
> @@ -2640,12 +2732,14 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
>  	struct printk_info info;
>  	struct printk_record r;
>  	unsigned long flags;
> +	bool allow_handover;
>  	char *write_text;
>  	size_t len;
>  
>  	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
>  
> -	*handover = false;
> +	if (handover)
> +		*handover = false;
>  
>  	if (!prb_read_valid(prb, con->seq, &r))
>  		return false;
> @@ -2671,18 +2765,23 @@ static bool console_emit_next_record(struct console *con, char *text, char *ext_
>  		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
>  	}
>  
> -	/*
> -	 * While actively printing out messages, if another printk()
> -	 * were to occur on another CPU, it may wait for this one to
> -	 * finish. This task can not be preempted if there is a
> -	 * waiter waiting to take over.
> -	 *
> -	 * Interrupts are disabled because the hand over to a waiter
> -	 * must not be interrupted until the hand over is completed
> -	 * (@console_waiter is cleared).
> -	 */
> -	printk_safe_enter_irqsave(flags);
> -	console_lock_spinning_enable();
> +	/* Handovers may only happen between trylock contexts. */
> +	allow_handover = (handover && atomic_read(&console_lock_count) == -1);

It is far from obvious why the check for console_lock_count is needed.
I found the reason only after removing the check and seeing the
warning about using mutex_unlock() in atomic context.

I suggest something like:

	/*
	 * Allow to handover the lock only from atomic context. The handover
	 * is used to transfer console owner between more printk() callers.
	 * They are not allowed to unblock the console kthreads by mutexes
	 * in atomic context.
	 */
	allow_handover = (handover && console_kthreads_atomically_blocked());

> +
> +	if (allow_handover) {
> +		/*
> +		 * While actively printing out messages, if another printk()
> +		 * were to occur on another CPU, it may wait for this one to
> +		 * finish. This task can not be preempted if there is a
> +		 * waiter waiting to take over.
> +		 *
> +		 * Interrupts are disabled because the hand over to a waiter
> +		 * must not be interrupted until the hand over is completed
> +		 * (@console_waiter is cleared).
> +		 */
> +		printk_safe_enter_irqsave(flags);
> +		console_lock_spinning_enable();
> +	}
>  
>  	stop_critical_timings();	/* don't trace print latency */
>  	call_console_driver(con, write_text, len, dropped_text);
> @@ -2825,7 +2926,7 @@ void console_unlock(void)
>  		 * Re-check if there is a new record to flush. If the trylock
>  		 * fails, another context is already handling the printing.
>  		 */
> -	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
> +	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock_sched(do_cond_resched));
>  }
>  EXPORT_SYMBOL(console_unlock);
>  
> @@ -2856,6 +2957,10 @@ void console_unblank(void)
>  	if (oops_in_progress) {
>  		if (down_trylock_console_sem() != 0)
>  			return;
> +		if (!console_excl_trylock()) {
> +			up_console_sem();
> +			return;
> +		}

It would be better to use

 	if (oops_in_progress) {
		if (!console_trylock())
			return;

>  	} else {
>  		pr_flush(1000, true);
>  		console_lock();
> @@ -3397,16 +3502,17 @@ static bool printer_should_wake(struct console *con, u64 seq)
>  	if (kthread_should_stop())
>  		return true;
>  
> -	if (console_suspended)
> -		return false;
> -
>  	/*
>  	 * This is an unsafe read to con->flags, but false positives
>  	 * are not an issue as long as they are rare.
>  	 */
>  	flags = data_race(READ_ONCE(con->flags));
> -	if (!(flags & CON_ENABLED))
> +
> +	if (!(flags & CON_ENABLED) ||
> +	    (flags & CON_PAUSED) ||
> +	    atomic_read(&console_lock_count) == -1) {
>  		return false;
> +	}

I would remove also this and do the after waking up. I think
that it is actually already being discussed in another patch.

>  
>  	return prb_read_valid(prb, seq, NULL);
>  }

Otherwise, it looks good.

This must have been hard to invent. Great job!

Best Regards,
Petr
