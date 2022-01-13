Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E9948D69E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiAMLU3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jan 2022 06:20:29 -0500
Received: from foss.arm.com ([217.140.110.172]:43188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbiAMLU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:20:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66EF66D;
        Thu, 13 Jan 2022 03:20:26 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ECF83F774;
        Thu, 13 Jan 2022 03:20:24 -0800 (PST)
Date:   Thu, 13 Jan 2022 11:20:22 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Add new pr_*_deferred_once() variants
Message-ID: <20220113112022.cvl2gjqkpk3qphv2@e107158-lin.cambridge.arm.com>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
 <20210123233741.3614408-2-qais.yousef@arm.com>
 <YA6fTuFEaCjFQB3h@hirez.programming.kicks-ass.net>
 <87y2gh2shy.fsf@jogness.linutronix.de>
 <Yd2I28a+BuuIdBcv@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Yd2I28a+BuuIdBcv@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/22 15:40, Andy Shevchenko wrote:
> On Mon, Jan 25, 2021 at 12:04:01PM +0106, John Ogness wrote:
> > On 2021-01-25, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Sat, Jan 23, 2021 at 11:37:40PM +0000, Qais Yousef wrote:
> 
> ...
> 
> > > We should be very close to printk not needing this anymore, printk
> > > people?
> > 
> > It will disappear once console printing threads are introduced. We
> > probably still have a few kernel releases until we see that. First we
> > need to finish merging full lockless access, remove the safe buffers,
> > and merge the atomic consoles.
> 
> Where are we now at this?

I think this answer from Peter then the summarizes the problem

	https://lore.kernel.org/lkml/YBBCDw8tBpgMSY3L@hirez.programming.kicks-ass.net/

"""
Note that this is CONFIG_PROVE_RAW_LOCK_NESTING=y which specifically
checks for this.

On current (mainline) kernel configs this is not yet a problem, but the
moment we do land PREEMPT_RT this order will be problematic.
"""

PREEMPT_RT patchset has fixes that should land on mainline eventually and AFAIU
this is a red herring on mainline. Although this might be a new call site that
breaks the rule for PREEMPT_RT and they'd want to know about it.

I wonder if CONFIG_PROVE_RAW_LOCK_NESTING should depend on PREEMPT_RT until the
fixes land - assuming they haven't, I'm not following its state.

HTH.

Cheers

--
Qais Yousef

> 
> I almost easily can reproduce the below at boot time for last several releases
> 
>  cblist_init_generic: Setting adjustable number of callback queues.
> 
>  =============================
>  [ BUG: Invalid wait context ]
>  5.16.0-next-20220111-00101-gb3e9f395c6f1 #28 Not tainted
>  -----------------------------
>  swapper/0/1 is trying to lock:
>  ffffffffb3dce758 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x3a8/0x480
>  other info that might help us debug this:
>  context-{5:5}
>  3 locks held by swapper/0/1:
>   #0: ffffffffb2955e08 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic.constprop.0+0x14/0x1e0
>   #1: ffffffffb2953ec0 (console_lock){+.+.}-{0:0}, at: _printk+0x53/0x6a
>   #2: ffffffffb2873ca0 (console_owner){....}-{0:0}, at: console_unlock+0x157/0x580
>  stack backtrace:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-next-20220111-00101-gb3e9f395c6f1 #28
>  Hardware name: Intel Corporation CHERRYVIEW D0 PLATFORM/Braswell CRB, BIOS BRAS.X64.B082.R00.1507270557 07/27/2015
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x7d
>   __lock_acquire.cold+0xca/0x2e8
>   ? stack_trace_save+0x46/0x70
>   lock_acquire+0xd2/0x300
>   ? serial8250_console_write+0x3a8/0x480
>   _raw_spin_lock_irqsave+0x39/0x50
>   ? serial8250_console_write+0x3a8/0x480
>   serial8250_console_write+0x3a8/0x480
>   console_unlock+0x397/0x580
>   vprintk_emit+0x99/0x2e0
>   _printk+0x53/0x6a
>   cblist_init_generic.constprop.0.cold+0x24/0x31
>   rcu_init_tasks_generic+0x5/0xd9
>   kernel_init_freeable+0x14d/0x294
>   ? rest_init+0x250/0x250
>   kernel_init+0x11/0x110
>   ret_from_fork+0x22/0x30
>   </TASK>
>  cblist_init_generic: Setting shift to 2 and lim to 1.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
