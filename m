Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4544C50BB77
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449329AbiDVPSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448908AbiDVPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:18:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92D162F5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:15:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9E9A72129B;
        Fri, 22 Apr 2022 15:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650640511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tZpAn7vwl5NxdkUegDfw2pB7KU9327kDjSkpjq1Mgks=;
        b=K5KZu5yPBQ+a5fGQKubuB0QYypr+ihr1wVHc0bI38aFeIxA6oCQDQSewFJR3E08ay4pPIj
        7CvzmPVXOP8IW3ouqxgMy7cWpkkUxOwgNOBjcqu13crGBVpSMEywbcM2LJmSIscaRNebCi
        FIKUAZrQUgfooA345OEsENgE5XLuxmA=
Received: from suse.cz (unknown [10.163.26.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 138942C145;
        Fri, 22 Apr 2022 15:15:11 +0000 (UTC)
Date:   Fri, 22 Apr 2022 17:15:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
Message-ID: <YmLGfuSV5u7xp5BZ@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-15-john.ogness@linutronix.de>
 <20220421124119.GB11747@pathway.suse.cz>
 <875yn2h5ku.fsf@jogness.linutronix.de>
 <YmKnp3Ccu7laW3E4@alley>
 <87o80tp5lv.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o80tp5lv.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-04-22 16:20:52, John Ogness wrote:
> On 2022-04-22, Petr Mladek <pmladek@suse.com> wrote:
> > IMHO, it is actually a generic problem of the complex locking scheme
> > when there are too many combinations of the protected data.
> 
> Sure. We are in a delicate situation of continuing to support the old
> locking scheme while transitioning to a new one.
> 
> > In the current state, the problem seems to be only with CON_ENABLED
> > flag but there might be other hidden races in the future.
> >
> > IMHO, it would be much easier when there are the following rules:
> >
> >    + console_lock() blocks taking con->lock
> >    + con->lock blocks taking console_lock()
> >    + Different con->lock might be taken in parallel
> >
> > The result would be:
> >
> >    + global variables need to be guarded by the big console_lock()
> >    + con->lock should be enough to guard per-console variables
> >    + the big console_lock() would serialize also access to
> >      per-console variables.
> 
> It looks like you are talking about nested locking. This was my original
> idea but I had problems relating to kthread stopping. However, the code
> has changed a lot since then and now when I look at it, it does not look
> like it would be a problem. Getting rid of CON_THD_BLOCKED would greatly
> simplify the relationship between console_lock and kthreads.
>
> For this we would need the console list to become a list_head so that it
> is doubly linked (in order to unlock in reverse order). That probably
> would be a good idea anyway. It is a bit bizarre that printk implements
> its own linked list.

Another problem is that the ordering is not stable. The console
might come and go.


> > Of course, it is not that simple. I am not 100% that we could
> > even achieve this.
> 
> It just might be that simple. I will explore it again.
> 
> > Anyway, I think about the following wrapper:
> >
> > void single_console_lock(struct console *con)
> > {
> > 	for (;;) {
> > 		error = wait_event_interruptible(log_wait,
> > 					con->flags & CON_THB_BLOCKED);
> >
> > 		if (error)
> > 			continue;
> >
> > 		mutex_lock(&con->lock);
> >
> > 		if (!con->flags & CON_THB_BLOCKED)
> > 			break;
> >
> > 		mutex_unlock(&con->lock);
> > 	}
> > }
> >
> > void single_console_unlock(struct console *con)
> > {
> > 	mutex_unlock(&con->lock);
> > }
> >
> > We should use it everywhere instead of the simple mutex_lock(con->lock)
> > and mutex_lock(con->lock). And we could remove mutex_lock()/unlock()
> > from code called under the big console_lock().
> 
> Hmmm. Waiting on @log_wait is not correct. A @log_wait wakeup with the
> kthread already in the blocked state is unusual. There would need to be
> a per-console waitqueue for when the kthread unlocks its mutex.

Yeah, it was a simplification. It would be much better to add extra
waitqueue for this purpose.


> Maybe something like:
> 
> void single_console_lock(struct console *con)
> {
> 	for (;;) {
> 		error = wait_event_interruptible(con->lock_wait,
> 				!(con->flags & CON_THB_BLOCKED));
> 		if (error)
> 			continue;
> 
> 		mutex_lock(&con->lock);
> 
> 		if (!(con->flags & CON_THB_BLOCKED))
> 			break;
> 
> 		mutex_unlock(&con->lock);
> 	}
> }
> 
> And in printk_kthread_func(), after the kthread unlocks its con->lock,
> it calls:
> 
> if (wq_has_sleeper(&con->lock_wait))
> 	wake_up_interruptible_all(&con->lock_wait);

You are right. It will need to be done in two situations:

   + in __console_unlock() when CON_THB_BLOCKED flag is cleared
     and the big console_lock is released.

   + in single_console_unlock() because there might be other
     single_console_lock() waiters.


> But single_console_lock() would not be allowed to be called under
> console_lock(), so I don't see how it is useful.

Yes. The point is that only console_lock(), __console_unlock(),
single_console_lock(), single_console_unlock() will be allowed
to call mutex_lock()/mutex_unlock() directly. Any other code
will need to use these wrappers to get/release the lock.

I mean that the manipulation of the mutex and CON_THB_BLOCKED
flag will be hidden in these wrappers.

We might also want to replace CON_THB_BLOCKED flag with a separate
variable (con->locked) to avoid problems with compiler optimizations.
Otherwise, we might still need to use WRITE_ONCE()/READ_ONCE()
when manipulating con->flags.

Maybe, I should prepare a POC to make it more clear and see if
it could work.


> con->flags is always
> modified under @console_sem to make sure the console does not disappear.
> 
> Anyway, I will first look into the nested locking solution. That seems
> more promising to me and it would go a long way to simplify the locking
> hierarchy.

Please, do not spend too much time on this. The solution must be
simple in principle. If it gets complicated than it will likely
be worse than the current code.

Alternative solution would be to reduce the number of variables
affected by the race. I mean:

   + replace CON_THB_BLOCKED flag with con->blocked to avoid
     the needed of READ_ONCE()/WRITE_ONCE().

   + check con->blocked right after taking con->lock in
     printk_kthread_func() so that all the other accesses are safe.


Something like:

static int printk_kthread_func(void *data)
{
[...]
	for (;;) {
		error = wait_event_interruptible(log_wait,
				printer_should_wake(con, seq)); /* LMM(printk_kthread_func:A) */

		if (kthread_should_stop() || !printk_kthreads_available)
			break;

		if (error)
			continue;

		error = mutex_lock_interruptible(&con->lock);
		if (error)
			continue;

		if (con->locked) {
			mutex_unlock(&con->lock);
			continue;
		}

		/*
		 * Everything below is safe because we know that the console
		 * is not locked by console_lock();
		 */

		if (!console_is_usable(con)) {
			mutex_unlock(&con->lock);
			continue;
		}

		if ((flags & CON_THD_BLOCKED) ||
		    !console_kthread_printing_tryenter()) {
			mutex_unlock(&con->lock);
			continue;
		}

[...]
	{

	console_lock();
	con->kthread = NULL;
	__console_unlock();
[...]
}

But it is basically open-coding of the single_console_lock() wrapper.

Best Regards,
Petr
