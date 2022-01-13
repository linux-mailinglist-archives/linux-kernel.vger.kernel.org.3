Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590B748DD05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiAMRjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:39:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60008 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiAMRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:39:30 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8859E1F387;
        Thu, 13 Jan 2022 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642095569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bCkAcKgrnC/b9q8bqFU8gLDr3KlbeFWr6mDBitCqU3g=;
        b=WG57UadtmIk5TSmRJoOZOvqPM9Q/bzLkKQlgfZev4bIMeLnmeg7HVTmL8MkpRAFFjTvomy
        evhsgUZ0gnsKXsf5FdlEA3LS6fz4Id7cOskJXmBLkMVeqITREELzEa4Ei533jymv4ZflnR
        3QeKMC83rh0JQg/MBBbj+/0UkHKWaWI=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3D091A3B88;
        Thu, 13 Jan 2022 17:39:29 +0000 (UTC)
Date:   Thu, 13 Jan 2022 18:39:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panic: disable optimistic spin after halting CPUs
Message-ID: <YeBjzX7Z6J1cVtjC@alley>
References: <20220113005425.74988-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113005425.74988-1-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-12 16:54:25, Stephen Brennan wrote:
> A CPU executing with console lock spinning enabled might be halted
> during a panic. Before console_flush_on_panic(), it's possible for
> console_trylock() to attempt optimistic spinning, deadlocking the panic
> CPU:
> 
> CPU 0 (panic CPU)             CPU 1
> -----------------             ------
>                               printk() {
>                                 vprintk_func() {
>                                   vprintk_default() {
>                                     vprintk_emit() {
>                                       console_unlock() {
>                                         console_lock_spinning_enable();
>                                         ... printing to console ...
> panic() {
>   crash_smp_send_stop() {
>     NMI  -------------------> HALT
>   }
>   atomic_notifier_call_chain() {
>     printk() {
>       ...
>       console_trylock_spinnning() {
>         // optimistic spin infinitely

I see.

> This hang during panic can be induced when a kdump kernel is loaded, and
> crash_kexec_post_notifiers=1 is present on the kernel command line. The
> following script which concurrently writes to /dev/kmsg, and triggers a
> panic, can result in this hang:
> 
>     #!/bin/bash
>     date
>     # 991 chars (based on log buffer size):
>     chars="$(printf 'a%.0s' {1..991})"
>     while :; do
>         echo $chars > /dev/kmsg
>     done &
>     echo c > /proc/sysrq-trigger &
>     date
>     exit
> 
> Below are the hang rates for the above test case, based on v5.16-rc8
> before and after this patch:
> 
> before:  197 hangs / 340 trials - 57.9%
> after :    0 hangs / 245 trials -  0.0%
> 
> Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>  include/linux/console.h |  1 +
>  kernel/panic.c          |  7 +++++++
>  kernel/printk/printk.c  | 17 +++++++++++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> index a97f277cfdfa..4eeb46927d96 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -179,6 +179,7 @@ extern void console_unlock(void);
>  extern void console_conditional_schedule(void);
>  extern void console_unblank(void);
>  extern void console_flush_on_panic(enum con_flush_mode mode);
> +extern void console_lock_spinning_disable_on_panic(void);
>  extern struct tty_driver *console_device(int *);
>  extern void console_stop(struct console *);
>  extern void console_start(struct console *);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index cefd7d82366f..a9340e580b20 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -265,6 +265,13 @@ void panic(const char *fmt, ...)
>  		crash_smp_send_stop();
>  	}
>  
> +	/*
> +	 * Now that we've halted other CPUs, disable optimistic spinning in
> +	 * printk(). This avoids deadlocking in console_trylock(), until we call
> +	 * console_flush_on_panic().
> +	 */
> +	console_lock_spinning_disable_on_panic();

The proposed implementation causes that the panicing CPU takes over
console_lock even when the current owner is in the middle of
call_console_drivers().

It means that calling console drivers from another CPU is not
completely safe. This is why console_flush_on_panic() is called
at end when the console is the only way to see the messages.

We should not do this before kmsg_dump() and __crash_kexec()
that allow to see the messages a "more safe" way.

I suggest to disable the spinning when panic is in progress. I mean
something like:

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1842,6 +1842,10 @@ static int console_trylock_spinning(void)
 	if (console_trylock())
 		return 1;
 
+	/* Spinning is not safe when the system is stopped */
+	if (read_atomic(&panic_cpu) != PANIC_CPU_INVALID)
+		return 0;
+
 	printk_safe_enter_irqsave(flags);
 
 	raw_spin_lock(&console_owner_lock);


It would be also great when the current owner releases console_lock
so that the panicing CPU could take over it.

I think about the following. Well, I am not sure if it would help
in the real life because other CPUs are stopped quite early in panic().

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2646,13 +2650,18 @@ void console_unlock(void)
 
 	for (;;) {
 		size_t ext_len = 0;
-		int handover;
+		int handover, pcpu;
 		size_t len;
 
 skip:
 		if (!prb_read_valid(prb, console_seq, &r))
 			break;
 
+		/* Allow the panic_cpu to take over consoles a safe way. */
+		pcpu = read_atomic(&panic_cpu);
+		if (pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id())
+			break;
+
 		if (console_seq != r.info->seq) {
 			console_dropped += r.info->seq - console_seq;
 			console_seq = r.info->seq;



Note that the above code is not even compile tested. panic_cpu is
local variable in panic.c. If we go this way than I would define
some helpers:

bool panic_in_progress(void)
{
	return read_atomic(&panic_cpu) != PANIC_CPU_INVALID;
}

bool panic_in_progress_on_other_cpu(void)
{
	int pcpu = read_atomic(&panic_cpu);

	if (pcpu == PANIC_CPU_INVALID)
		return false;

	if (pcpu == smp_processor_id())
		return false;

	return true;
}

Best Regards,
Petr
