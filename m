Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F350B9D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448525AbiDVOSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448549AbiDVORt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:17:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2374AD6A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:14:54 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650636892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ScEofcAngBttJUjbaPoFXsndGMP9kRPSbXXWkcBMELE=;
        b=j9cbLFKiSXATNqfzi7t6cZ1fME371oGdgUJE1HLkwVmhO9CpkJsdPFnjR7rSu/brzPBbZq
        kEiTh4izYnJVbOwpCdSE4NP9D3v4Fzy4s9bOcJW94fKuD9iPLbVgyZlODqe5JpO8xxnFUD
        OH1uTwvuP0MVzNdXxUd4bEHWjaVlxQYTh4R3L1Oo8w81cctyruQnT1IH+jPJEulb8uYNo6
        XVuXLfVXTRxMC9HfCBsOX0c0P0Sd1tCxagF3dwZ4pzUMUbOgGqlzu6zMx3bjtDlF3a0hF1
        nvG4hwjGFgHAS89jpimtW2eZhTjmFpLObkHIdL+AaiPebxOOVVwR3Z9GZyIO3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650636892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ScEofcAngBttJUjbaPoFXsndGMP9kRPSbXXWkcBMELE=;
        b=KNPltB/HTIIWTnI06jmo4X2QMsdankWZJ2nHLJ9R6TgD6svBNmf7cWKiI/lavwn/nXcK9c
        IhglH9K6HbZsO+Ag==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
In-Reply-To: <YmKnp3Ccu7laW3E4@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-15-john.ogness@linutronix.de>
 <20220421124119.GB11747@pathway.suse.cz>
 <875yn2h5ku.fsf@jogness.linutronix.de> <YmKnp3Ccu7laW3E4@alley>
Date:   Fri, 22 Apr 2022 16:20:52 +0206
Message-ID: <87o80tp5lv.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-22, Petr Mladek <pmladek@suse.com> wrote:
> IMHO, it is actually a generic problem of the complex locking scheme
> when there are too many combinations of the protected data.

Sure. We are in a delicate situation of continuing to support the old
locking scheme while transitioning to a new one.

> In the current state, the problem seems to be only with CON_ENABLED
> flag but there might be other hidden races in the future.
>
> IMHO, it would be much easier when there are the following rules:
>
>    + console_lock() blocks taking con->lock
>    + con->lock blocks taking console_lock()
>    + Different con->lock might be taken in parallel
>
> The result would be:
>
>    + global variables need to be guarded by the big console_lock()
>    + con->lock should be enough to guard per-console variables
>    + the big console_lock() would serialize also access to
>      per-console variables.

It looks like you are talking about nested locking. This was my original
idea but I had problems relating to kthread stopping. However, the code
has changed a lot since then and now when I look at it, it does not look
like it would be a problem. Getting rid of CON_THD_BLOCKED would greatly
simplify the relationship between console_lock and kthreads.

For this we would need the console list to become a list_head so that it
is doubly linked (in order to unlock in reverse order). That probably
would be a good idea anyway. It is a bit bizarre that printk implements
its own linked list.

> Of course, it is not that simple. I am not 100% that we could
> even achieve this.

It just might be that simple. I will explore it again.

> Anyway, I think about the following wrapper:
>
> void single_console_lock(struct console *con)
> {
> 	for (;;) {
> 		error = wait_event_interruptible(log_wait,
> 					con->flags & CON_THB_BLOCKED);
>
> 		if (error)
> 			continue;
>
> 		mutex_lock(&con->lock);
>
> 		if (!con->flags & CON_THB_BLOCKED)
> 			break;
>
> 		mutex_unlock(&con->lock);
> 	}
> }
>
> void single_console_unlock(struct console *con)
> {
> 	mutex_unlock(&con->lock);
> }
>
> We should use it everywhere instead of the simple mutex_lock(con->lock)
> and mutex_lock(con->lock). And we could remove mutex_lock()/unlock()
> from code called under the big console_lock().

Hmmm. Waiting on @log_wait is not correct. A @log_wait wakeup with the
kthread already in the blocked state is unusual. There would need to be
a per-console waitqueue for when the kthread unlocks its mutex.

Maybe something like:

void single_console_lock(struct console *con)
{
	for (;;) {
		error = wait_event_interruptible(con->lock_wait,
				!(con->flags & CON_THB_BLOCKED));
		if (error)
			continue;

		mutex_lock(&con->lock);

		if (!(con->flags & CON_THB_BLOCKED))
			break;

		mutex_unlock(&con->lock);
	}
}

And in printk_kthread_func(), after the kthread unlocks its con->lock,
it calls:

if (wq_has_sleeper(&con->lock_wait))
	wake_up_interruptible_all(&con->lock_wait);

But single_console_lock() would not be allowed to be called under
console_lock(), so I don't see how it is useful. con->flags is always
modified under @console_sem to make sure the console does not disappear.

Anyway, I will first look into the nested locking solution. That seems
more promising to me and it would go a long way to simplify the locking
hierarchy.

John
