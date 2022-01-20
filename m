Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9337749512A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376588AbiATPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:14:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54522 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376558AbiATPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:14:38 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D3CDA1F388;
        Thu, 20 Jan 2022 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642691676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WQQEqKNNxbc6s62M7PExlWeVrhf+Ly/6VnETzkVWTFg=;
        b=bTTh5nN9bq+eNCJJAa0qKKrTD1towCdvccoRxAs04SNeqCFd7q6OLqOS01nX4ZtFy36JLC
        fFW6RlEUPCxTvuvmJCeuuiLjnuXtG3kuR/2sltd6hCC1w9TH407L1Du+E4VX3WEts8OsdA
        B4OhSoBzgSzlQguSI/Uo+E18dGRU+2w=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0BBF3A3B90;
        Thu, 20 Jan 2022 15:14:36 +0000 (UTC)
Date:   Thu, 20 Jan 2022 16:14:33 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, bhe@redhat.com,
        vgoyal@redhat.com, stern@rowland.harvard.edu,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, halves@canonical.com, kernel@gpiccoli.net,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Message-ID: <Yel8WQiBn/HNQN83@alley>
References: <20220108153451.195121-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108153451.195121-1-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding some more people into Cc. Some modified the logic in the past.
Some are familiar with some interesting areas where the panic
notfiers are used.

On Sat 2022-01-08 12:34:51, Guilherme G. Piccoli wrote:
> The kernel notifier infrastructure allows function callbacks to be
> added in multiple lists, which are then called in the proper time,
> like in a reboot or panic event. The panic_notifier_list specifically
> contains the callbacks that are executed during a panic event. As any
> other notifier list, the panic one has no filtering and all functions
> previously registered are executed.
> 
> The kdump infrastructure, on the other hand, enables users to set
> a crash kernel that is kexec'ed in a panic event, and vmcore/logs
> are collected in such crash kernel. When kdump is set, by default
> the panic notifiers are ignored - the kexec jumps to the crash kernel
> before the list is checked and callbacks executed.
> 
> There are some cases though in which kdump users might want to
> allow panic notifier callbacks to execute _before_ the kexec to
> the crash kernel, for a variety of reasons - for example, users
> may think kexec is very prone to fail and want to give a chance
> to kmsg dumpers to run (and save logs using pstore),

Yes, this seems to be original intention for the
"crash_kexec_post_notifiers" option, see the commit
f06e5153f4ae2e2f3b0300f ("kernel/panic.c: add
"crash_kexec_post_notifiers" option for kdump after panic_notifiers")


> some panic notifier is required to properly quiesce some hardware
> that must be used to the crash kernel.

Do you have any example, please? The above mentioned commit
says "crash_kexec_post_notifiers" actually increases risk
of kdump failure.

Note that kmsg_dump() is called after the notifiers only because
some are printing more information, see the commit
6723734cdff15211bb78a ("panic: call panic handlers before kmsg_dump").
They might still increase the change that kmsg_dump() will never
be called.


> But there's a problem: currently it's an "all-or-nothing" situation,
> the kdump user choice is either to execute all panic notifiers or
> none of them. Given that panic notifiers may increase the risk of a
> kdump failure, this is a tough decision and may affect the debug of
> hard to reproduce bugs, if for some reason the user choice is to
> enable panic notifiers, but kdump then fails.
>
> So, this patch aims to ease this decision: we hereby introduce a filter
> for the panic notifier list, in which users may select specifically
> which callbacks they wish to run, allowing a safer kdump. The allowlist
> should be provided using the parameter "panic_notifier_filter=a,b,..."
> where a, b are valid callback names. Invalid symbols are discarded.

I am afraid that this is almost unusable solution:

   + requires deep knowledge of what each notifier does
   + might need debugging what notifier causes problems
   + the list might need to be updated when new notifiers are added
   + function names are implementation detail and might change
   + requires kallsyms


It is only workaround for a real problem. The problem is that
"panic_notifier_list" is used for many purposes that break
each other.

I checked some notifiers and found few groups:

   + disable watchdogs:
      + hung_task_panic()
      + rcu_panic()

   + dump information:
      + kernel_offset_notifier()
      + trace_panic_handler()     (duplicate of panic_print=0x10)

   + inform hypervisor
      + xen_panic_event()
      + pvpanic_panic_notify()
      + hyperv_panic_event()

   + misc cleanup / flush / blinking
      + panic_event()   in ipmi_msghandler.c
      + panic_happened()   in heartbeat.c
      + led_trigger_panic_notifier()


IMHO, the right solution is to split the callbacks into 2 or more
notifier list. Then we might rework panic() to do:

void panic(void)
{
	[...]

	/* stop watchdogs + extra info */
	atomic_notifier_call_chain(&panic_disable_watchdogs_notifier_list, 0, buf);
	atomic_notifier_call_chain(&panic_info_notifier_list, 0, buf);
	panic_print_sys_info();

	/* crash_kexec + kmsg_dump in configurable order */
	if (!_crash_kexec_post_kmsg_dump) {
		__crash_kexec(NULL);
		smp_send_stop();
	} else {
		crash_smp_send_stop();
	}

	kmsg_dump();
	if (_crash_kexec_post_kmsg_dump)
		__crash_kexec(NULL);

	/* infinite loop or reboot */
	atomic_notifier_call_chain(&panic_hypervisor_notifier_list, 0, buf);
	atomic_notifier_call_chain(&panic_rest_notifier_list, 0, buf);

	console_flush_on_panic(CONSOLE_FLUSH_PENDING);

	if (panic_timeout >= 0) {
		timeout();
		emergency_restart();
	}

	for (i = 0; ; i += PANIC_TIMER_STEP) {
		if (i >= i_next) {
			i += panic_blink(state ^= 1);
			i_next = i + 3600 / PANIC_BLINK_SPD;
		}
		mdelay(PANIC_TIMER_STEP);
	}
}

Two notifier lists might be enough in the above scenario. I would call
them:

	panic_pre_dump_notifier_list
	panic_post_dump_notifier_list


It is a real solution that will help everyone. It is more complicated now
but it will makes things much easier in the long term. And it might be done
step by step:

     1. introduce the two notifier lists
     2. convert all users: one by one
     3. remove the original notifier list when there is no user

Best Regards,
Petr
