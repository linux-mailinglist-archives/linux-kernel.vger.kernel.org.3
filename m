Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8393D48E84D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbiANKYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:24:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbiANKY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:24:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E7A3121997;
        Fri, 14 Jan 2022 10:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642155867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tn+LN/1sjn/ckaZ7xT4Ooepwr9SqdEKKAyyZdx8V980=;
        b=UguDwM2CADi2hxQKY44C5D7KQkXyk/s5D6b1ef2Qtl1z4KmvZUeod3li02c0V2KumoB1e5
        yDyCj6ytAedVRrZlaCpZznU3TINXbWySJ05PDWUY3heI0gmQBhympqt5iNJJWnUBMjd6lG
        Z7mg6U5OkZWHNQDw0aSCn5M9ipxsPRw=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 91107A3B8A;
        Fri, 14 Jan 2022 10:24:27 +0000 (UTC)
Date:   Fri, 14 Jan 2022 11:24:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: disable optimistic spin after halting CPUs
Message-ID: <20220114102427.GA17817@pathway.suse.cz>
References: <20220113005425.74988-1-stephen.s.brennan@oracle.com>
 <YeBjzX7Z6J1cVtjC@alley>
 <87a6fzxwak.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6fzxwak.fsf@stepbren-lnx.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-13 11:36:35, Stephen Brennan wrote:
> Hi Petr,
> 
> Thanks for taking a look!
> 
> Petr Mladek <pmladek@suse.com> writes:
> > On Wed 2022-01-12 16:54:25, Stephen Brennan wrote:
> >> A CPU executing with console lock spinning enabled might be halted
> >> during a panic. Before console_flush_on_panic(), it's possible for
> >> console_trylock() to attempt optimistic spinning, deadlocking the panic
> >> CPU:
> >> 
> >> CPU 0 (panic CPU)             CPU 1
> >> -----------------             ------
> >>                               printk() {
> >>                                 vprintk_func() {
> >>                                   vprintk_default() {
> >>                                     vprintk_emit() {
> >>                                       console_unlock() {
> >>                                         console_lock_spinning_enable();
> >>                                         ... printing to console ...
> >> panic() {
> >>   crash_smp_send_stop() {
> >>     NMI  -------------------> HALT
> >>   }
> >>   atomic_notifier_call_chain() {
> >>     printk() {
> >>       ...
> >>       console_trylock_spinnning() {
> >>         // optimistic spin infinitely
> >
> > I see.
> >
> >> This hang during panic can be induced when a kdump kernel is loaded, and
> >> crash_kexec_post_notifiers=1 is present on the kernel command line. The
> >> following script which concurrently writes to /dev/kmsg, and triggers a
> >> panic, can result in this hang:
> >> 
> >>     #!/bin/bash
> >>     date
> >>     # 991 chars (based on log buffer size):
> >>     chars="$(printf 'a%.0s' {1..991})"
> >>     while :; do
> >>         echo $chars > /dev/kmsg
> >>     done &
> >>     echo c > /proc/sysrq-trigger &
> >>     date
> >>     exit
> >> 
> >> Below are the hang rates for the above test case, based on v5.16-rc8
> >> before and after this patch:
> >> 
> >> before:  197 hangs / 340 trials - 57.9%
> >> after :    0 hangs / 245 trials -  0.0%
> >> 
> >> Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
> >> 
> >> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> >> Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
> >> ---
> >>  include/linux/console.h |  1 +
> >>  kernel/panic.c          |  7 +++++++
> >>  kernel/printk/printk.c  | 17 +++++++++++++++++
> >>  3 files changed, 25 insertions(+)
> >> 
> >> diff --git a/include/linux/console.h b/include/linux/console.h
> >> index a97f277cfdfa..4eeb46927d96 100644
> >> --- a/include/linux/console.h
> >> +++ b/include/linux/console.h
> >> @@ -179,6 +179,7 @@ extern void console_unlock(void);
> >>  extern void console_conditional_schedule(void);
> >>  extern void console_unblank(void);
> >>  extern void console_flush_on_panic(enum con_flush_mode mode);
> >> +extern void console_lock_spinning_disable_on_panic(void);
> >>  extern struct tty_driver *console_device(int *);
> >>  extern void console_stop(struct console *);
> >>  extern void console_start(struct console *);
> >> diff --git a/kernel/panic.c b/kernel/panic.c
> >> index cefd7d82366f..a9340e580b20 100644
> >> --- a/kernel/panic.c
> >> +++ b/kernel/panic.c
> >> @@ -265,6 +265,13 @@ void panic(const char *fmt, ...)
> >>  		crash_smp_send_stop();
> >>  	}
> >>  
> >> +	/*
> >> +	 * Now that we've halted other CPUs, disable optimistic spinning in
> >> +	 * printk(). This avoids deadlocking in console_trylock(), until we call
> >> +	 * console_flush_on_panic().
> >> +	 */
> >> +	console_lock_spinning_disable_on_panic();
> >
> > The proposed implementation causes that the panicing CPU takes over
> > console_lock even when the current owner is in the middle of
> > call_console_drivers().
> 
> I don't think this is true. All that
> console_lock_spinning_disable_on_panic() does is clear out the
> console_owner and console_owner_lock, signalling that the panicking CPU
> should not attempt to spin and wait for the lock.
>
> The only time this matters is when another task already holds
> console_sem and is executing presently in call_console_drivers(), as you
> said.
> 
> With console_owner set to NULL, console_trylock_spinning() will get
> spin=false, and thus it will bail out, returning 0. Thus, the panicking
> CPU would fail to acquire console_sem, and so in vprintk_emit it will
> not end up going into console_unlock(), or doing call_console_drivers().
> 
> It would not be until console_flush_on_panic() down below (when there is
> no other option than to try to use the console) that the panicking CPU
> actually attempts to call the drivers.

You are right. I should have used drawing board.


> > It means that calling console drivers from another CPU is not
> > completely safe. This is why console_flush_on_panic() is called
> > at end when the console is the only way to see the messages.
> >
> > We should not do this before kmsg_dump() and __crash_kexec()
> > that allow to see the messages a "more safe" way.
> >
> > I suggest to disable the spinning when panic is in progress. I mean
> > something like:
> >
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1842,6 +1842,10 @@ static int console_trylock_spinning(void)
> >  	if (console_trylock())
> >  		return 1;
> >  
> > +	/* Spinning is not safe when the system is stopped */
> > +	if (read_atomic(&panic_cpu) != PANIC_CPU_INVALID)
> > +		return 0;
> > +
> >  	printk_safe_enter_irqsave(flags);
> >  
> >  	raw_spin_lock(&console_owner_lock);
> 
> I think this is pretty much equivalent to my fix, since it also results
> in the panicking CPU failing to acquire console_sem during
> console_trylock_spinning().

Yes.

> I do think this is better than my fix :) since it doesn't clutter up
> panic() even more, nor introduce an additional function. It even avoids
> resetting the console_owner_lock spinlock.

Yes. I agree.

It also looks slightly more straightforward to me. It might be matter
of taste. It is just that I misunderstood the effect of your variant
yesterday ;-)

> I'd be happy to do this as a v2, if you'd prefer?

Yes, please. Go for it.


> > It would be also great when the current owner releases console_lock
> > so that the panicing CPU could take over it.
> >
> > I think about the following. Well, I am not sure if it would help
> > in the real life because other CPUs are stopped quite early in panic().
> >
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2646,13 +2650,18 @@ void console_unlock(void)
> >  
> >  	for (;;) {
> >  		size_t ext_len = 0;
> > -		int handover;
> > +		int handover, pcpu;
> >  		size_t len;
> >  
> >  skip:
> >  		if (!prb_read_valid(prb, console_seq, &r))
> >  			break;
> >  
> > +		/* Allow the panic_cpu to take over consoles a safe way. */
> > +		pcpu = read_atomic(&panic_cpu);
> > +		if (pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id())
> > +			break;
> > +
> >  		if (console_seq != r.info->seq) {
> >  			console_dropped += r.info->seq - console_seq;
> >  			console_seq = r.info->seq;
> >
> 
> I suppose this could help reduce the odds of a CPU getting interrupted
> during call_console_drivers(), and it might reduce the odds of
> console_sem being held by a halted CPU during panic().
> 
> However, it occurs to me that there are two cases:
> 
> 1) a kdump kernel is loaded. In this case, crash_smp_send_stop() is
> used, which (at least on x86_64) sends NMIs. In this case,
> __crash_kexec() will not return (barring any errors) and we won't ever
> really need to get the console_sem.

This is likely the more safe case. NMI will make sure that
the current owner will not mess with the console drivers any longer.


> 2) no kdump kernel is loaded. In this case, smp_send_stop() is used,
> which (again on x86_64) sends regular IPIs. In this case, we know we can
> at least avoid interrupting call_console_drivers(), since that executes
> with local IRQ disabled.

This is probably more dangerous case. Regular IPIs will not stop the
current owner when it is running with IRQ disabled. It means
the it could still manipulate consoles and race with
console_flush_on_panic().

Note that printk() can be called in IRQ disabled context. Also note
that some architectures do not have NMI. They use normal IRQ even
in the 1st case.


> So I'm also unsure how much this would help in the real world. But it's
> a small change and so it doesn't need to help much in order to be a net
> positive :)

I agree that it is a corner case. But I think that it is worth it.

Well, we could do this change separately. I could send the patch
for this part if you would prefer it. But feel free to send it
yourself.

Best Regards,
Petr
