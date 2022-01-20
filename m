Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F5495299
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377103AbiATQtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:49:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377102AbiATQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:49:00 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1809921923;
        Thu, 20 Jan 2022 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642697339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Txk6Vz7Ny9LN1YX/DQ4WsxLi8C07r/kU4avpvCUkHQ=;
        b=sFL6Qedq0+4MuUE2PHeD3ayspzY4tSG5dTv633sUoRoOZflWbJ0rwEwbPLz28txlNOaShw
        tH/+kf6mOAmD6XEqtR+42/xYgVHhf5d6wyGm1z1AknfGOxdgZmZKDtCmjb04LVSBU6SSki
        VzOEuTVK391FoLqxX5NMgL2akBm2Wu4=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AD29FA3B89;
        Thu, 20 Jan 2022 16:48:58 +0000 (UTC)
Date:   Thu, 20 Jan 2022 17:48:58 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: disable optimistic spin after halting CPUs
Message-ID: <YemSeuzdvFAFd0YK@alley>
References: <20220113005425.74988-1-stephen.s.brennan@oracle.com>
 <YeBjzX7Z6J1cVtjC@alley>
 <87a6fzxwak.fsf@stepbren-lnx.us.oracle.com>
 <20220114102427.GA17817@pathway.suse.cz>
 <877dawy6vk.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dawy6vk.fsf@stepbren-lnx.us.oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-01-18 15:13:51, Stephen Brennan wrote:
> Petr Mladek <pmladek@suse.com> writes:
> > On Thu 2022-01-13 11:36:35, Stephen Brennan wrote:
> Hi Petr,
> 
> Sorry for the delayed response due to the US holiday weekend.

No problem at all :-)

> I switched to your approach, and began running it through my test script
> (from the commit message) on QEMU. However, 14% of the time (200/1409) I
> found that the system fell into an interesting race condition / loop.
> 
> 178 void panic(const char *fmt, ...)
> 179 {
> ...
> 187 	/*
> 188 	 * Disable local interrupts. This will prevent panic_smp_self_stop
> 189 	 * from deadlocking the first cpu that invokes the panic, since
> 190 	 * there is nothing to prevent an interrupt handler (that runs
> 191 	 * after setting panic_cpu) from invoking panic() again.
> 192 	 */
> 193 	local_irq_disable();
> 194 	preempt_disable_notrace();
> ...
> 211 	this_cpu = raw_smp_processor_id();
> 212 	old_cpu  = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
> 213 
> 214 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
> 215 		panic_smp_self_stop();
> ...
> 226 	pr_emerg("Kernel panic - not syncing: %s\n", buf);
> ...
> 250 	if (!_crash_kexec_post_notifiers) {  // <- HALT CPUs
> ...
> 
> We disable IRQ and preemption at the beginning of panic(), then set
> panic_cpu. This opens a window (between lines 212 and 250) where
> printk() spinning is disabled. Then, we go ahead and we use printk()
> during this window, at line 226.
> 
> If another CPU is adding to the log buffer at the right time (concurrent
> with the pr_emerg in line 226), then they can successfully prevent the
> panic CPU from making progress. Since spinning is disabled, the other
> CPU in vprintk_emit() will never get the console_sem, and will just
> leave its buffered contents in the log buffer. And if the other CPU can
> add to the log buffer faster than the panic CPU can drain it... then the
> panic CPU is stuck forever writing into the console. And I do mean
> forever.

Yeah. The console waiter logic helps a bit to avoid this livelock.

> If a watchdog triggers, it will find panic_cpu already set, and
> so it won't be able to do anything!
> 
> Thus I'm now testing the following modification:
> 
> // in console_trylock_spinning()
> if (atomic_read(&panic_cpu) == this_cpu)
>     return 0;
> 
> This would ensure that the panic CPU won't fall into the spin loop, but
> also ensures that other CPUs can't flood the panic CPU with buffered
> messages.

Hmm, I am not sure if we really want it:

    The other CPU will likely become the console_sem owner. If the
    other CPU is running, the current console_sem owner is likely
    running as well and will be able to pass console_sem.

    Yes, it will throttle the other CPU. It will become busy with
    pushing its own messages to the console. So far so good.

    But panic() will stop the other CPU at some stage. And the
    panic CPU will not be able to push the messages to the
    console because @console_sem is owned by the other (stopped) CPU.

    panic CPU will try to get the messages out later in
    console_flush_on_panic(). But it is prone to deadlocks.


We want panic CPU to become console_sem owner and be able to flush
the messages to the consoles a clean way. This is why I proposed
the 2nd patch where the non-panic owner releases console_sem.

I wonder if we could prevent the livelock another way. The livelock
happens when the messages added faster into the log buffer than
they can reach the console. The result must be that some messages
are lost, see in console_unlock():

		if (console_seq != r.info->seq) {
			console_dropped += r.info->seq - console_seq;
			console_seq = r.info->seq;
		}

A solution might be to disable printk() on non-panic CPUs when
some messages are repeatedly dropped during panic. I mean
something like:

void console_unlock(void)
{
[...]
+		static panic_console_dropped;
[...]
		if (console_seq != r.info->seq) {
			console_dropped += r.info->seq - console_seq;
			console_seq = r.info->seq;
+
+			if (read_atomic(&panic_cpu) != PANIC_CPU_INVALID) {
+				if (panic_console_dropped++ > 10)
+					suppress_non_panic_printk = 1;
+			}
		}

, where "suppress_non_panic_printk" will have similar effect as
"supress_printk" except that it will supress only printk
on non-panic CPUs.

I am not completely sure that it is the right approach. But it is not
completely bad:

    + allows the panic() CPU to become clean console_sem owner
    + blocks printk() only when many messages are lost anyway


> > Well, we could do this change separately. I could send the patch
> > for this part if you would prefer it. But feel free to send it
> > yourself.
> 
> I'd be glad to write this patch, put it through my VM stress testing,
> and then send it. I've already got it setup so it might as well get put
> to good use :)

Great, thanks.

Best Regards,
Petr
