Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F114BBD63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiBRQVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:21:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiBRQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:21:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE982B520F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:20:46 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CEF99219A7;
        Fri, 18 Feb 2022 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645201244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3QRU+kJm2Eoi+9cEQMTp2HUS4jRHAJI7oZ17zlKAKOk=;
        b=aI0xKv6SspTg7trDgNC4MIDFTycwpJVCfW/9ZcR2l0k8Cp7sIdlPwdLvRz0M8usYfu9tDR
        flaZypUOhWORi3kO+dFRXH5DLsb73fjw98+rGLomeA+SQktfuMvdrXCm+Zlr0eyEjzViQK
        /mBG871vlVhBs6Cbve7FJSitHhjYbFw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C214A3B81;
        Fri, 18 Feb 2022 16:20:44 +0000 (UTC)
Date:   Fri, 18 Feb 2022 17:20:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <Yg/HWcifuqLsS6cv@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the solution is very interesting and I am sure that it has many
advantages. But it is also quite complex. I want to be sure
about the motivations before I start discussing details.

On Mon 2022-02-07 20:49:21, John Ogness wrote:
> With non-threaded console printers preemption is disabled while
> holding the console lock in order to avoid the situation where the
> console printer is scheduled away and no other task can lock the
> console (for printing or otherwise).

I guess that you are talking about that vprintk_emit() disables
the preemtion. console_lock() does not disable preemption.

> Disabling preemption is necessary because the console lock is
> implemented purely as a semaphore, which has no owner.

I do not understand this explanation.

The preemtion was added into vprintk_emit() by the commit
fd5f7cde1b85d4c8e09c ("printk: Never set console_may_schedule
in console_trylock()").

It is not really necessary. It actually increases the risk of softlockups.
The motivation was to increase the chance that messages will get
printed. Nobody prints the messages when the owner is sleeping.
We hoped that the console owner steeling will be efficient enough
to prevent the softlockups.


> Like non-threaded console printers, kthread printers use the
> console lock to synchronize during printing. However, since they
> use console_lock() instead of a best-effort console_trylock(), it
> is not possible to disable preemption upon locking.
  ^^^^^^^^^^^^^^^

IMHO, it is possible to disable preemtion. But we propably do
not want to do it, especially on RT.

> Therefore an alternative for synchronizing and avoiding
> the above mentioned situation is needed.

I do not think that preemtion is the reason for an alternative
soluiton.

IMHO, the reason is to handle different consoles independently.
It will allow to handle more consoles in parallel. And more
importantly they will not block each other.


> The kthread printers do not need to synchronize against each other,

yes

> but they do need to synchronize against console_lock() callers.

We should make it more clear why. I see the following reasons:

   + it is needed for switching between direct printing and
     offload to kthreads.

   + another operations on all consoles, e.g. suspend, updating
     list of registered consoles

   + console_lock() has several other external users and their
     dependencies are complicated.


> To provide this synchronization, introduce a per-console mutex. The
> mutex is taken by the kthread printer during printing and is also
> taken by console_lock() callers.

ok

> Since mutexes have owners, when calling console_lock(), the
> scheduler is able to schedule any kthread printers that may have
> been preempted while printing.

I do not userstand the relation between mutex owners and scheduling
kthreads. The mutex can be taken by any process.


> Rather than console_lock() callers holding the per-console mutex
> for the duration of the console lock, the per-console mutex is only
> taken in order to set a new CON_PAUSED flag, which is checked by
> the kthread printers. This avoids any issues due to nested locking
> between the various per-console mutexes.

The flag adds some complexity. The logic will use two locks + one flag
instead of just two locks. IMHO, it deserves a more clear explanation
why it is needed. When can nested locking happen? Will it make the
nested locking safe?

The obvious ordering is to always take con->mutex under console_sem.

Are you afraid that some console driver might need to take console_sem
from con->write() callback? IMHO, this might cause deadlock even when
using CON_PAUSED flag.

CPU0:					CPU1:

console_lock()
  down(&console_sem);
  for_each_console(con)

					kthread_printer()
					  mutex_lock(&con->lock);
					    con->write()
					       down(&console_sem)

      mutex_lock(&con->lock);

DEADLOCK!!!


> The kthread printers must also synchronize against console_trylock()
> callers. Since console_trylock() is non-blocking, a global atomic
> counter will be used to identify if any kthread printers are active.
> The kthread printers will also check the atomic counter to identify
> if the console has been locked by another task via
> console_trylock().

This is another complexity. An easier solution would be to do:

console_trylock()
{
	if (down_trylock(&console_sem))
		return failed;

	for_each_console(con) {
		if (mutext_trylock(&con->lock))
			goto fail;
	}

	// sucess

fail:
	for_each_console(con_fail) {
		if (con_fail == con)
			break;
		mutex_unlock(&con->lock);
}

Of course, the atomic counter is interesting. But it is
also another extra complexity. Is it worth it?

Best Regards,
Petr
