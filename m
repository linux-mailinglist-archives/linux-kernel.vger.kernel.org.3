Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5B50FC81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349765AbiDZMKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346373AbiDZMKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:10:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F67311D211
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:07:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 38BEA210F3;
        Tue, 26 Apr 2022 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650974862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WZQnQfmwOyegbMQMpAkJQ4Cy43WxFPI7uoVWnPe4dQ0=;
        b=MvlBzeEDyX7s+Vk+Urtv4h2bJYWWH/Op4mM1QbV6EB4Wn0XEgONdFeCHNMAg9qTk+fQ7Y8
        50bcIXJ+Zmz6jvDpFNGhIQi25TtuZAtebtUO2Vd9TsCNOtcliS8a2NTyY9IgoTxMVxbHZ4
        WcoJvYtsSNGBXD90wdq2andryF7ym/Q=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D5F352C141;
        Tue, 26 Apr 2022 12:07:41 +0000 (UTC)
Date:   Tue, 26 Apr 2022 14:07:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Message-ID: <Ymfgis0EAw0Oxoa5@alley>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
 <878rrs6ft7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rrs6ft7.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-04-25 23:04:28, John Ogness wrote:
> Currently threaded console printers synchronize against each
> other using console_lock(). However, different console drivers
> are unrelated and do not require any synchronization between
> each other. Removing the synchronization between the threaded
> console printers will allow each console to print at its own
> speed.
> 
> But the threaded consoles printers do still need to synchronize
> against console_lock() callers. Introduce a per-console mutex
> and a new console boolean field @blocked to provide this
> synchronization.
> 
> console_lock() is modified so that it must acquire the mutex
> of each console in order to set the @blocked field. Console
> printing threads will acquire their mutex while printing a
> record. If @blocked was set, the thread will go back to sleep
> instead of printing.
> 
> The reason for the @blocked boolean field is so that
> console_lock() callers do not need to acquire multiple console
> mutexes simultaneously, which would introduce unnecessary
> complexity due to nested mutex locking. Also, a new field
> was chosen instead of adding a new @flags value so that the
> blocked status could be checked without concern of reading
> inconsistent values due to @flags updates from other contexts.
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
>                 con->blocked = true;
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
>         if (!con->blocked) {
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
> @console_suspended. The check for the @blocked field implicitly
> covers the suspended console case.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Nice, it it better than v4. I am going to push this for linux-next.

Reviewed-by: Petr Mladek <pmladek@suse.com>

See below a comment about the possible future direction.

> ---
> 
>  Changes since v4 of this patch:
> 
>  - Use new @blocked field instead of CON_THD_BLOCKED flag.
> 
>  - Remove console_flags_set()/console_flags_clear() macros for
>    updating @flags (and remove their race comments).
> 
>  - For printer_should_wake() and printk_kthread_func(), check
>    @blocked before checking @flags.
> 
>  - Update commit message and comments appropriately.

Excellent work!

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3665,15 +3802,27 @@ static int printk_kthread_func(void *data)
>  		if (error)
>  			continue;
>  
> -		console_lock();
> +		error = mutex_lock_interruptible(&con->lock);
> +		if (error)
> +			continue;
>  
> -		if (console_suspended) {
> -			up_console_sem();
> +		if (con->blocked ||
> +		    !console_kthread_printing_tryenter()) {

It is great that you moved both conditions. I have just realized how
much information and functionality is accumulated here:

    + "con->blocked" is set when anyone else took @console_sem via
      console_lock() or when the console is suspended.

    + console_kthread_printing_tryenter() has two functions. It fails
      when anyone else took @console_sem via console_trylock().
      Also it blocks console_trylock(). Note that console_lock() is
      blocked because it has to wait for con->lock.

I missed the trylock part when proposed the more safe API in the other
thread, see https://lore.kernel.org/r/YmKnp3Ccu7laW3E4@alley

The safe single console lock would need to do something like:

/*
 * Safe way to take con->lock. It makes sure that @console_sem is
 * not taken and blocks anyone from taking @console_sem.
 */
void single_console_lock(struct console *con)
{
try_again:
	error = wait_event_interruptible(con->lock_wait,
			(!con->blocked &&
			 !console_kthreads_atomically_blocked()));

	/* Spurious wakeup */
	if (error)
		goto try_again;

	mutex_lock(&con->lock);

	/*
	 * Check is the console is blocked by @console_sem taken via
	 * console_lock() or if it is suspended.
	 */
	if (con->blocked) {
		mutex_unlock(@con->lock); 
		goto try_again;
	}

	/*
	 * Try to block console_trylock(). Otherwise, we are blocked by
	 * @console_set taken via console_trylock().
	 */
	if (!console_kthread_printing_tryenter()) {
		mutex_unlock(@con->lock); 
		goto try_again;
	}

	/*
	 * Eureka! We own @con->lock and both console_lock() and
	 * console_trylock() are blocked.
	 */
}

Best Regards,
Petr
