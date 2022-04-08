Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653504F9755
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiDHNyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiDHNyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:54:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1922FE0AF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:52:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7D4CB215FE;
        Fri,  8 Apr 2022 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649425959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LS0gEzcNZT0UQtVYnc+p/6zJxLEqWkzXT+DS/iR0sfM=;
        b=DKML8jjzeSNYgwnhUlg6AaXm+EnHoqWDjibaQY8QgjC+EvuMXBIjxTGH2tyfHJSxzZTSER
        QR96KZcIDkjjrglx+mlhLEouVfGBdGNazNadrf9UKiqtVOVOkTy5zUuV6mJ0RHIPa2k2iM
        St4V8hHGzpfINmtE4+2PBhZ7AR9MJsc=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 538E9A3B82;
        Fri,  8 Apr 2022 13:52:38 +0000 (UTC)
Date:   Fri, 8 Apr 2022 15:52:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: register_console: was: Re: [PATCH printk v2 11/12] printk: extend
 console_lock for proper kthread support
Message-ID: <YlA+JYC1ohU3LKuR@alley>
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
> However, threaded console printers also need to synchronize
> against console_trylock() callers. Since console_trylock() may
> be called from any context, the per-console mutex cannot be
> used for this synchronization. (mutex_trylock() cannot be
> called from atomic contexts.) Introduce a global atomic counter
> to identify if any threaded printers are active. The threaded
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
>         /* console lock acquired */
> }
> 
> console_trylock()
> {
>         if (down_trylock(&console_sem) == 0) {
>                 if (atomic_cmpxchg(&console_kthreads_active, 0, -1) == 0) {
>                         /* console lock acquired */
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
> that have taken the console lock. Since threaded printers never take
> the console lock, they do not have a console lock to handover to
> other contexts.
> 
> @panic_console_dropped must change to atomic_t since it is no longer
> protected exclusively by the console lock.
> 
> Since threaded printers remain asleep if they see that the console
> is locked, they now must be explicitly woken in __console_unlock().
> This means wake_up_klogd() calls following a console_unlock() are
> no longer necessary and are removed.

BTW: I really like the commit message.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3230,7 +3335,11 @@ void register_console(struct console *newcon)
>  	if (newcon->flags & CON_EXTENDED)
>  		nr_ext_console_drivers++;
>  
> +	if (console_kthreads_blocked)

I think that this is actully always true because it is called under
console_lock().

> +		newcon->flags |= CON_THD_BLOCKED;

> +
>  	newcon->dropped = 0;
> +	mutex_init(&newcon->lock);
>  	if (newcon->flags & CON_PRINTBUFFER) {
>  		/* Get a consistent copy of @syslog_seq. */
>  		mutex_lock(&syslog_lock);

Best Regards,
Petr
