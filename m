Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFFB48E03F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 23:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbiAMW2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 17:28:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51346 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiAMW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 17:28:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D5F7B8239D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B92C36AE3;
        Thu, 13 Jan 2022 22:28:30 +0000 (UTC)
Date:   Thu, 13 Jan 2022 17:28:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Sven Schnelle' <svens@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "deller@gmx.de" <deller@gmx.de>
Subject: Re: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Message-ID: <20220113172828.54b46d7b@gandalf.local.home>
In-Reply-To: <e66911061f9344fa8de2da982ab98a7b@AcuMS.aculab.com>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <7a0fefb7ed3542b4a49dee1e78b1668b@AcuMS.aculab.com>
        <yt9d8rvmt2jq.fsf@linux.ibm.com>
        <20220113125754.0cb5273f@gandalf.local.home>
        <yt9dwnj3wcke.fsf@linux.ibm.com>
        <e66911061f9344fa8de2da982ab98a7b@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 22:11:35 +0000
David Laight <David.Laight@ACULAB.COM> wrote:


> > Too bad that the __user attribute is stripped during a normal compile.
> > But couldn't we add the information whether a pointer belongs to user
> > or kernel space in the trace event definition? For syscall tracing it's
> > easy, because pointer types in SYSCALL_DEFINE() and friends are always
> > userspace pointers?  
> 
> Also, when the __user pointer is saved it MUST be checked for being
> a valid user pointer (eg with access_ok(ptr, 1).

It's rather hard to even know if a pointer is __user or not. It could be
some random address in any event field.


> 
> You really do need to remember whether the pointer is user or kernel
> when you save it.
> 
> I also suspect that you need to check for contexts where 'current'
> isn't really valid (eg any kind on interrupt) and ensure the user
> reads aren't even attempted.

It's not going to crash, even if it is required. The
strncpy_from_user/kernel_nofault() should detect any of that, right? Or are
those functions not safe to call?


> The excuse of being 'root' in order to request/read trace isn't
> really a very good one.

Not sure what you are getting at here? If you are worried about tracing
reading anything, then disable it. There's a lockdown on tracing. for those
that are worried.

Heck I could just do:

 # echo 'p:random_umem __common_interrupt add=+0(@0x7f073a188000):u64' >  /sys/kernel/tracing/kprobe_events
 # trace-cmd start -e random_umem
 # trace-cmd show
# tracer: nop
#
# entries-in-buffer/entries-written: 15/15   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          <idle>-0       [000] d.h1.   844.051612: random_umem: (__common_interrupt+0x0/0x100) add=7291432837672293
          <idle>-0       [000] d.h1.   844.051694: random_umem: (__common_interrupt+0x0/0x100) add=74591483011526501
          <idle>-0       [000] d.H1.   844.051743: random_umem: (__common_interrupt+0x0/0x100) add=21474836483
          <idle>-0       [000] d.h1.   844.383333: random_umem: (__common_interrupt+0x0/0x100) add=115964116992
          <idle>-0       [000] d.h1.   844.383802: random_umem: (__common_interrupt+0x0/0x100) add=1125968626319387
          <idle>-0       [000] d.h1.   844.383864: random_umem: (__common_interrupt+0x0/0x100) add=115964116992
          <idle>-0       [000] d.h1.   844.533321: random_umem: (__common_interrupt+0x0/0x100) add=4032068056083813
          <idle>-0       [000] d.h1.   844.533801: random_umem: (__common_interrupt+0x0/0x100) add=6929886302
     kworker/0:1-15      [000] d.h..   844.900412: random_umem: (__common_interrupt+0x0/0x100) add=17367183
          <idle>-0       [000] d.h1.   844.933428: random_umem: (__common_interrupt+0x0/0x100) add=115964116992
          <idle>-0       [000] d.h1.   844.933818: random_umem: (__common_interrupt+0x0/0x100) add=17367183
          <idle>-0       [000] d.h1.   844.933955: random_umem: (__common_interrupt+0x0/0x100) add=74591483008647173
          <idle>-0       [000] d.h1.   845.364181: random_umem: (__common_interrupt+0x0/0x100) add=1125968626319387
            bash-1759    [000] d.h..   845.364541: random_umem: (__common_interrupt+0x0/0x100) add=13912554418208784
            bash-1759    [000] d.h..   845.364592: random_umem: (__common_interrupt+0x0/0x100) add=18446744071906760329

And at every interrupt I get the memory at: 0x7f073a188000 for the current
running task that was running when the interrupt happened.

As I said. It's an API.

-- Steve
