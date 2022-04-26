Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBF50FEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347563AbiDZNTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350900AbiDZNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:19:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F12692333
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:16:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3BBD0210F4;
        Tue, 26 Apr 2022 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650978964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8x+8XqjyVG0D0MRWyPaIYxWjcYcFy9j7hzjAUNZpX+s=;
        b=OTg6l/4bHKqFaIAO+w8tO4m+Tv0pDaxTMkW2VVQ/4EwTxtdqW56ghiEUPlrrKLBF56INzz
        6VQZOUG20PsXFgYUyf7iT2NnKWZV/b8+KlUXebEU+X96zo16L/SYulX43VqIY/NSBcCe9H
        JD2MpYwyqBRsXt3cNOcrWADvqrXGQiw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E217F2C141;
        Tue, 26 Apr 2022 13:16:03 +0000 (UTC)
Date:   Tue, 26 Apr 2022 15:16:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Message-ID: <Ymfwk+X0CHq6ex3s@alley>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
 <878rrs6ft7.fsf@jogness.linutronix.de>
 <Ymfgis0EAw0Oxoa5@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymfgis0EAw0Oxoa5@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-26 14:07:42, Petr Mladek wrote:
> On Mon 2022-04-25 23:04:28, John Ogness wrote:
> > Currently threaded console printers synchronize against each
> > other using console_lock(). However, different console drivers
> > are unrelated and do not require any synchronization between
> > each other. Removing the synchronization between the threaded
> > console printers will allow each console to print at its own
> > speed.
> > 
> > But the threaded consoles printers do still need to synchronize
> > against console_lock() callers. Introduce a per-console mutex
> > and a new console boolean field @blocked to provide this
> > synchronization.
> > 
> > console_lock() is modified so that it must acquire the mutex
> > of each console in order to set the @blocked field. Console
> > printing threads will acquire their mutex while printing a
> > record. If @blocked was set, the thread will go back to sleep
> > instead of printing.
> > 
> > The reason for the @blocked boolean field is so that
> > console_lock() callers do not need to acquire multiple console
> > mutexes simultaneously, which would introduce unnecessary
> > complexity due to nested mutex locking. Also, a new field
> > was chosen instead of adding a new @flags value so that the
> > blocked status could be checked without concern of reading
> > inconsistent values due to @flags updates from other contexts.
> > 
> > Threaded console printers also need to synchronize against
> > console_trylock() callers. Since console_trylock() may be
> > called from any context, the per-console mutex cannot be used
> > for this synchronization. (mutex_trylock() cannot be called
> > from atomic contexts.) Introduce a global atomic counter to
> > identify if any threaded printers are active. The threaded
> > printers will also check the atomic counter to identify if the
> > console has been locked by another task via console_trylock().
> > 
> > Note that @console_sem is still used to provide synchronization
> > between console_lock() and console_trylock() callers.
> > 
> > A locking overview for console_lock(), console_trylock(), and the
> > threaded printers is as follows (pseudo code):
> > 
> > console_lock()
> > {
> >         down(&console_sem);
> >         for_each_console(con) {
> >                 mutex_lock(&con->lock);
> >                 con->blocked = true;
> >                 mutex_unlock(&con->lock);
> >         }
> >         /* console_lock acquired */
> > }
> > 
> > console_trylock()
> > {
> >         if (down_trylock(&console_sem) == 0) {
> >                 if (atomic_cmpxchg(&console_kthreads_active, 0, -1) == 0) {
> >                         /* console_lock acquired */
> >                 }
> >         }
> > }
> > 
> > threaded_printer()
> > {
> >         mutex_lock(&con->lock);
> >         if (!con->blocked) {
> > 		/* console_lock() callers blocked */
> > 
> >                 if (atomic_inc_unless_negative(&console_kthreads_active)) {
> >                         /* console_trylock() callers blocked */
> > 
> >                         con->write();
> > 
> >                         atomic_dec(&console_lock_count);
> >                 }
> >         }
> >         mutex_unlock(&con->lock);
> > }
> > 
> > The console owner and waiter logic now only applies between contexts
> > that have taken the console_lock via console_trylock(). Threaded
> > printers never take the console_lock, so they do not have a
> > console_lock to handover. Tasks that have used console_lock() will
> > block the threaded printers using a mutex and if the console_lock
> > is handed over to an atomic context, it would be unable to unblock
> > the threaded printers. However, the console_trylock() case is
> > really the only scenario that is interesting for handovers anyway.
> > 
> > @panic_console_dropped must change to atomic_t since it is no longer
> > protected exclusively by the console_lock.
> > 
> > Since threaded printers remain asleep if they see that the console
> > is locked, they now must be explicitly woken in __console_unlock().
> > This means wake_up_klogd() calls following a console_unlock() are
> > no longer necessary and are removed.
> > 
> > Also note that threaded printers no longer need to check
> > @console_suspended. The check for the @blocked field implicitly
> > covers the suspended console case.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Nice, it it better than v4. I am going to push this for linux-next.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

JFYI, I have just pushed this patch instead of the one
from v4 into printk/linux.git, branch rework/kthreads.

It means that this branch has been rebased. It will be
used in the next refresh of linux-next.

Best Regards,
Petr
