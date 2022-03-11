Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A704D6896
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350261AbiCKSnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346684AbiCKSnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:43:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F021CCB02
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:41:58 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 340D11F441;
        Fri, 11 Mar 2022 18:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647024117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Snz3Pghhpg/aTzJa41kgOJ79VKteKDYBod2RKuprxc=;
        b=feE5lKc1Hj3RBoV2uBlQq/EFjlJYnK4xV8ifc0XwsvZ9FcCLRGc1uRknbfsRIw07U9OHkX
        BfbmYAb86Y9xbECGwXHxTNtEM+j32y3mNFz7iVWP/EJf+zajZiqyd9SeXZvkLLq9jBNomi
        AtFCm+cStWgb0v098IZF7ozQLziV3KE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E2CC6A3B81;
        Fri, 11 Mar 2022 18:41:56 +0000 (UTC)
Date:   Fri, 11 Mar 2022 19:41:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <YiuX8rFkuGpn7gqv@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley>
 <87tuc7xma0.fsf@jogness.linutronix.de>
 <YioMcSe0P0Z7ksiW@alley>
 <87wnh14wp9.fsf@jogness.linutronix.de>
 <Yisj2PEtjZfHMe6N@alley>
 <87czisbotz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czisbotz.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-03-11 14:34:40, John Ogness wrote:
> On 2022-03-11, Petr Mladek <pmladek@suse.com> wrote:
> >>     console_unlock()
> >>     {
> >>  	  [...]
> >>  	  if (may_schedule)
> >>  	      retry = console_lock_reacquire();
> >>  	  else
> >>  	      retry = console_trylock();
> >>     }
> >> 
> 
> [...]
> 
> > OK, it means that the main problem here _is not_ the scheduling context,
> > console_lock() vs. console_trylock(). The main problem _is_ the direct
> > printing vs. the offload to kthreads.
> >
> > Of course, the context is important. It affects how we could re-take
> > the lock. But the main problem is the printing mode. We must make sure
> > that:
> >
> >     1. someone is printing pending messages when the direct mode is needed
> 
> console_trylock() causes difficulties here because it will fail if any
> kthread is active. It is an example of direct mode failure. But is that
> really any different than current mainline console_trylock() failing
> because a console_lock() context is active (and possibly not scheduled
> on a CPU)?

I see. Well, console_lock() does not mean that we are in direct mode.
Yes, it stops kthreads. But it might be called by register_console()
or tty driver. console_unlock() might do nothing when
allow_direct_printing() returns false in console_flush_all().


> >     2. kthreads are woken and can enter the printing mode when the direct
> >        mode is disabled.
> 
> This happens at the end of vprintk_emit() and within __console_unlock(),
> regardless if the printk() was running in direct mode or not.
> 
> > Will console_lock_reacquire() really help here?
> >
> > The API theoretically helps in direct mode when the lock was taken
> > via console_lock().
> 
> console_lock_reacquire() only exists for the console_lock() case.
> 
> > But it does not help when the lock was taken
> > via console_trylock() from printk(). It might mean that
> > the forward progress might not be guaranteed in the direct mode
> > (early boot, panic, ...).
> 
> How is the console_trylock() case different from current mainline now?
> As I mentioned above, the kthreads can block console_trylock(), but so
> can a console_lock() currently in mainline.

It is very different. Failing console_trylock() in the current mainline
means that someone else is responsible for printing all the pending
messages. All should be on the safe side.

Failing console_trylock() in this patch means that some printk
kthread is active but nothing else. The kthread might handle one
message and then go into sleep because someone requested the
direct mode using atomic_inc(). Other kthreads might be sleeping
and ignore everything. The failing console_trylock() will mean
that nobody will handle the rest of the messages. The race
is described in the other reply.

Honestly, handling console_trylock() case looks more important to me
because it is used by printk(). It is the main usecase. While
console_lock() code path should be used rarely, during
console registration. Well, it is used also by tty code but
I am not sure how often it is really called there.

> > Hmm, the forward progress seems to be guaranteed in the direct
> > mode most of the time. console_trylock() can take over
> > the atomic counter because console kthreads are not allowed
> > to enter the printing mode in this case.
> >
> > I used "most of the time" because there might be races when
> > the mode is switched. "printk_direct" is an atomic variable.
> > CON_DIRECT is set under con->mutex but console_trylock()
> > does not take the mutex...
> 
> You are mixing issues here. If CON_DIRECT is set, there is already a
> console_lock() in progress, so console_trylock() fails on @console_sem.

Yes, I am sorry for the confusion. I forgot the meaning of the flag.
I thought that it was set when the direct mode was requested.
But it is not true. It only means that console_lock is taken
and it could do the direct printing.

It would make sense to rename it. It might be part of all the
confusion here. The name creates false feeling about that
the direct mode is requested. I think that I have actually
suggested renaming the flag in an earlier mail.

Best Regards,
Petr
