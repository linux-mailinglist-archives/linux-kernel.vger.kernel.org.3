Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB4509FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385061AbiDUMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385031AbiDUMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:44:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C72F017
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:41:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 72141210E8;
        Thu, 21 Apr 2022 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650544879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wU/1FFNijwr5djTYgV9ByAWBmJFGSrW7WMkz06Xbd6Y=;
        b=GqDP3AW3pJC4fNvZGNJEAK1vTClxOMINy/6LHNQbhu6leduRxWQZsKZE7zNG8nd/a76q4D
        HgoTiNezGGuh5EABR7BQiJMt07D/X0r+ur3zNzljsmSoKxjIYxKS/Z8z/Z/H6CkY+zhLmy
        ju2d90ZsT5RHf+a7irIy5IUhq6mmwMk=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 57F0F2C141;
        Thu, 21 Apr 2022 12:41:19 +0000 (UTC)
Date:   Thu, 21 Apr 2022 14:41:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
Message-ID: <20220421124119.GB11747@pathway.suse.cz>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-15-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-15-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 01:52:36, John Ogness wrote:
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
> console_lock() is modified so that it must acquire the mutex
> of each console in order to set the CON_THD_BLOCKED flag.
> Console printing threads will acquire their mutex while
> printing a record. If CON_THD_BLOCKED was set, the thread will
> go back to sleep instead of printing.
> 
> The reason for the CON_THD_BLOCKED flag is so that
> console_lock() callers do not need to acquire multiple console
> mutexes simultaneously, which would introduce unnecessary
> complexity due to nested mutex locking.
> 
> The per-console mutex is also used to synchronize setting and
> checking the CON_ENABLED flag. A new console_lock() variant is
> introduced, console_lock_single_hold(), that allows acquiring
> @console_sem but only locking (and holding) the mutex of a
> single console. This allows safely enabling and disabling
> consoles without disturbing the other kthread printers. The
> mutex and @console_sem are released with
> console_unlock_single_release().
> 
> Console unregistering now uses console_lock_single_hold() to
> stop the kthread. Thus con->thread is now synchronized by
> the per-console mutex. This allows consoles to be unregistered
> without disturbing the other kthread printers.
> 
> Threaded console printers also need to synchronize against
> console_trylock() callers. Since console_trylock() may be
> called from any context, the per-console mutex cannot be used
> for this synchronization. (mutex_trylock() cannot be called
> from atomic contexts.) Introduce a global atomic counter to
> identify if any threaded printers are active. The threaded
> printers will also check the atomic counter to identify if the
> console has been locked by another task via console_trylock().
> 
> Note that @console_sem is still used to provide synchronization
> between console_lock() and console_trylock() callers.
> 
> A locking overview for console_lock(), console_trylock(), and the
> threaded printers is as follows (pseudo code):
> 
> console_lock()
> {
>         down(&console_sem);
>         for_each_console(con) {
>                 mutex_lock(&con->lock);
>                 con->flags |= CON_THD_BLOCKED;
>                 mutex_unlock(&con->lock);
>         }
>         /* console_lock acquired */
> }
> 
> console_trylock()
> {
>         if (down_trylock(&console_sem) == 0) {
>                 if (atomic_cmpxchg(&console_kthreads_active, 0, -1) == 0) {
>                         /* console_lock acquired */
>                 }
>         }
> }
> 
> threaded_printer()
> {
>         mutex_lock(&con->lock);
>         if (!(con->flags & CON_THD_BLOCKED)) {
> 		/* console_lock() callers blocked */
> 
>                 if (atomic_inc_unless_negative(&console_kthreads_active)) {
>                         /* console_trylock() callers blocked */
> 
>                         con->write();
> 
>                         atomic_dec(&console_lock_count);
>                 }
>         }
>         mutex_unlock(&con->lock);
> }
> 
> The console owner and waiter logic now only applies between contexts
> that have taken the console_lock via console_trylock(). Threaded
> printers never take the console_lock, so they do not have a
> console_lock to handover. Tasks that have used console_lock() will
> block the threaded printers using a mutex and if the console_lock
> is handed over to an atomic context, it would be unable to unblock
> the threaded printers. However, the console_trylock() case is
> really the only scenario that is interesting for handovers anyway.
> 
> @panic_console_dropped must change to atomic_t since it is no longer
> protected exclusively by the console_lock.
> 
> Since threaded printers remain asleep if they see that the console
> is locked, they now must be explicitly woken in __console_unlock().
> This means wake_up_klogd() calls following a console_unlock() are
> no longer necessary and are removed.
> 
> Also note that threaded printers no longer need to check
> @console_suspended. The check for the CON_THD_BLOCKED flag
> implicitly covers the suspended console case.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2603,9 +2666,10 @@ static int console_cpu_notify(unsigned int cpu)
>  		/* If trylock fails, someone else is doing the printing */
>  		if (console_trylock())
>  			console_unlock();
> -
> -		/* Wake kthread printers. Some may have become usable. */
> -		wake_up_klogd();
> +		else {
> +			/* Some kthread printers may have become usable. */
> +			wake_up_klogd();

Do you have any particular scenario in mind, please?
Could CPU hotplug put any printk kthread into a sleep?

> +		}
>  	}
>  	return 0;
>  }
> @@ -2625,11 +2689,33 @@ void console_lock(void)
>  	down_console_sem();
>  	if (console_suspended)
>  		return;
> +	console_kthreads_block();
>  	console_locked = 1;
>  	console_may_schedule = 1;
>  }
>  EXPORT_SYMBOL(console_lock);
>  
> +/*
> + * Lock the console_lock, but rather than blocking all the kthread printers,
> + * lock a specified kthread printer and hold the lock. This is useful if
> + * console flags for a particular console need to be updated.
> + */
> +void console_lock_single_hold(struct console *con)
> +{
> +	might_sleep();
> +	down_console_sem();
> +	mutex_lock(&con->lock);
> +	console_locked = 1;
> +	console_may_schedule = 1;

This looks wrong. It is a global flag that could be modified
only when all consoles are blocked. This API blocks only the single
console. The other consoles are still allowed to print actively.

Another problem will appear with the 15th patch. It will remove
console_locked variable and is_console_locked() will not longer
be aware that this console is locked. We will not know that
it might cause deadlock in the VT code.

> +}
> +
> +static void console_unlock_single_release(struct console *con)
> +{
> +	console_locked = 0;
> +	mutex_unlock(&con->lock);
> +	up_console_sem();
> +}
> +
>  /**
>   * console_trylock - try to lock the console system for exclusive use.
>   *
> @@ -2728,17 +2834,18 @@ static void __console_unlock(void)
>   *
>   * @handover will be set to true if a printk waiter has taken over the
>   * console_lock, in which case the caller is no longer holding the
> - * console_lock. Otherwise it is set to false.
> + * console_lock. Otherwise it is set to false. A NULL pointer may be provided
> + * to disable allowing the console_lock to be taken over by a printk waiter.
>   *
>   * Returns false if the given console has no next record to print, otherwise
>   * true.
>   *
> - * Requires the console_lock.
> + * Requires the console_lock if @handover is non-NULL.

    * Requires con->lock otherwise.

>   */
> -static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
> -				     char *dropped_text, bool *handover)
> +static bool __console_emit_next_record(struct console *con, char *text, char *ext_text,
> +				       char *dropped_text, bool *handover)
>  {
> -	static int panic_console_dropped;
> +	static atomic_t panic_console_dropped = ATOMIC_INIT(0);
>  	struct printk_info info;
>  	struct printk_record r;
>  	unsigned long flags;
> @@ -3261,6 +3401,8 @@ void register_console(struct console *newcon)
>  
>  	newcon->dropped = 0;
>  	newcon->thread = NULL;
> +	newcon->flags |= CON_THD_BLOCKED;

Just to show the complexity added by console_lock_single_hold():

It took me some time to realize that it is correct. The flag
is needed because the console will be added under console_lock().
The flag would not be needed when it was added under
console_lock_single_hold().


> +	mutex_init(&newcon->lock);
>  
>  	if (newcon->flags & CON_PRINTBUFFER) {
>  		/* Get a consistent copy of @syslog_seq. */
> @@ -3314,7 +3456,7 @@ int unregister_console(struct console *console)
>  		return 0;
>  
>  	res = -ENODEV;
> -	console_lock();
> +	console_lock_single_hold(console);
>  	if (console_drivers == console) {
>  		console_drivers=console->next;

Another example of the complexity:

I though that this was not safe. console_drivers is a global list
and console_lock_single_hold() is supposed to block only a single
console. But it is actually safe because console_lock_single_hold()
holds console_sem.

Another question is why console_lock_single_hold() is enough
here and why console_lock() is used in register_console(). I think
that console_lock_single_hold() will be enough even in register_console().

All this is far from obvious. It shows how the API is confusing and
tricky. And it is another motivation to remove console_lock_single_hold().


>  		res = 0;
> @@ -3676,14 +3835,14 @@ static int printk_kthread_func(void *data)
>  	kfree(ext_text);
>  	kfree(text);
>  
> -	console_lock();
> +	mutex_lock(&con->lock);

This is serialized against unregister_console() but not with
register_console() because they use different locking scheme.

>  	/*
>  	 * If this kthread is being stopped by another task, con->thread will
>  	 * already be NULL. That is fine. The important thing is that it is
>  	 * NULL after the kthread exits.
>  	 */
>  	con->thread = NULL;
> -	console_unlock();
> +	mutex_unlock(&con->lock);
>  
>  	return 0;
>  }

Resume:

I would prefer to get rid of console_lock_single_hold() and
console_unlock_single_release() API.

It was definitely an interesting experiment. I agree that it would
be nice to do not block the other kthreads when it is not really
needed. But from my POV, it adds more harm than good at the moment.

It is possible that we will want to do such optimizations
in the future. But it must be easier to understand what exactly
is serialized which way. At least it should be more documented.
Also the same API would need to be used on the related code
paths.

Best Regards,
Petr
