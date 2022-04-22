Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0515750B3F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445864AbiDVJYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377251AbiDVJYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:24:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99BE286E0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:21:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 89952210F4;
        Fri, 22 Apr 2022 09:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650619297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jfo2fRJxRpkTQQSsMLubTHAvzljScKBhRFGVG/gpAc0=;
        b=uO15n954SRZjyyD0E+kboCTd2iIHSqLaO8FwHskW11BIQlajVcKE1F4Cn3AZDVhOljaDQq
        dKEXuWA40P4QgZ4MIqsZdQzi/5WcLC8Ib5KGFTewVH0gDV4cnnBuAWeLHnW00Dm18T8WKH
        3db8P5je3r9tPZPjjfZyOey/l0Fc0/s=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 535AB2C146;
        Fri, 22 Apr 2022 09:21:37 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:21:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 14/15] printk: extend console_lock for proper
 kthread support
Message-ID: <YmJzoSRgmSPkmUIn@alley>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421212250.565456-15-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-04-21 23:28:49, John Ogness wrote:
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

I have finally understood why console_lock_single_hold() solved
the problem with con->flags. We should describe it in the commit
message as well. Something like:

    @con->flags must be updated WRITE_ONCE() under console_lock
    when the related kthread is running. The kthread printers
    read the flags only under con->mutex. They have to see
    the CON_THD_BLOCKED flag when the value might not
    be consistent.

Sigh, I agree that this approach is error prone and kind of ugly.
The approach with console_lock_single_hold() was not ideal either.
I still have to think about it.

Anyway, the approach with READ_ONCE()/WRITE_ONCE() looks good enough
for now.


> Since threaded printers remain asleep if they see that the console
> is locked, they now must be explicitly woken in __console_unlock().
> This means wake_up_klogd() calls following a console_unlock() are
> no longer necessary and are removed.
> 
> Also note that threaded printers no longer need to check
> @console_suspended. The check for the CON_THD_BLOCKED flag
> implicitly covers the suspended console case.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

I do not see any further problem with this patch. So, with
the updated commit message and comment above the macros:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
