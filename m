Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1066F4B90C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237900AbiBPSyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:54:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbiBPSyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:54:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8A241DBB;
        Wed, 16 Feb 2022 10:54:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5357861723;
        Wed, 16 Feb 2022 18:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E12EC004E1;
        Wed, 16 Feb 2022 18:54:21 +0000 (UTC)
Date:   Wed, 16 Feb 2022 13:54:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: ftrace startup tests crashing due to missing rcu_synchronize()
Message-ID: <20220216135419.01d96fe1@gandalf.local.home>
In-Reply-To: <yt9dilte4px4.fsf@linux.ibm.com>
References: <yt9dilte4px4.fsf@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 19:39:03 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> Hi Steve,
> 
> in our CI we see the ftrace selftests crashing. It only happens
> in rare cases - for me i can boot the kernel hundred of times and
> it crashes only once. The oops output looks like this:
> 
> [    3.523720] Running postponed tracer tests:
> [    3.524184] Testing tracer function: PASSED
> [    3.801523] Testing dynamic ftrace: PASSED
> [    4.068009] Testing dynamic ftrace ops #1:
> [    4.140142] (1 0 1 0 0)
> [    4.140149] (1 1 2 0 0)
> [    4.200037] (2 1 3 0 822270)
> [    4.200046] (2 2 4 0 822402)
> [    4.232728] (3 2 4 0 1147236)
> [    4.232740] (3 3 5 0 1147377)
> [    4.300835] PASSED
> [    4.300840] Testing dynamic ftrace ops #2:
> [    4.420423] (1 0 1 582267 0)
> [    4.420474] (1 1 2 583259 0)
> [    4.420941] (2 1 3 1 5)
> [    4.420947] (2 2 4 69 73)
> [    4.458483] (3 2 4 494199 491341)
> [    4.458616] (3 3 5 497496 494474)
> [    4.460091] Unable to handle kernel pointer dereference in virtual kernel address space
> [    4.460375] Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803
> [    4.460458] Fault in home space mode while using kernel ASCE.
> [    4.460695] AS:000000008561c007 R3:0000000000000024
> [    4.461143] Oops: 0038 ilc:3 [#1] PREEMPT SMP
> [    4.461162] Modules linked in:
> [    4.461175] CPU: 245 PID: 0 Comm: swapper/245 Not tainted 5.17.0-rc4-00051-gc5d9ae265b10-dirty #4
> [    4.461183] Hardware name: IBM 8561 T01 701 (KVM/Linux)

I this a 390?

> [    4.461194] Krnl PSW : 0404e00180000000 00000000835a1fe6 (arch_ftrace_ops_list_func+0x96/0x1b0)
> [    4.461212]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
> [    4.461226] Krnl GPRS: 0000000000000000 0000000084bbc110 0000000083496f48 00000000834061f2
> [    4.461237]            000000008a70fa00 0000038000d0fba8 0000000000000001 fffffffffffffeff
> [    4.461243]            00000000834061f2 0000038000d0fba8 6b6b6b6b6b6b6b6b 0000000083496f48
> [    4.461250]            0000000000000000 0000000000000000 00000000835a209a 0000038000d0fab8
> [    4.461269] Krnl Code: 00000000835a1fd4: e310a9380224        stg     %r1,10552(%r10)
>                           00000000835a1fda: eb0103a8006a        asi     936,1
>                          #00000000835a1fe0: c4a800b0d094        lgrl    %r10,0000000084bbc108
>                          >00000000835a1fe6: e310a0100004        lg      %r1,16(%r10)  
>                           00000000835a1fec: a7110020            tmll    %r1,32
>                           00000000835a1ff0: a7740012            brc     7,00000000835a2014
>                           00000000835a1ff4: a7114000            tmll    %r1,16384
>                           00000000835a1ff8: a7740031            brc     7,00000000835a205a
> [    4.461383] Call Trace:
> [    4.461388]  [<00000000835a1fe6>] arch_ftrace_ops_list_func+0x96/0x1b0
> [    4.461395] ([<00000000835a200e>] arch_ftrace_ops_list_func+0xbe/0x1b0)
> [    4.461401]  [<00000000841700ec>] ftrace_common+0x1c/0x20
> [    4.461409]  [<0000000083496f4e>] preempt_count_sub+0x6/0x138
> [    4.461418]  [<00000000834061f2>] read_tod_clock+0x4a/0xb0
> [    4.461431]  [<0000000083530818>] ktime_get+0xb8/0x178
> [    4.461441]  [<000000008353ec94>] clockevents_program_event+0x6c/0x138
> [    4.461454]  [<000000008352d206>] hrtimer_start_range_ns+0xc6/0x100
> [    4.461467]  [<0000000083541068>] tick_nohz_idle_stop_tick+0x90/0xf8
> [    4.461479]  [<00000000834a9790>] do_idle+0xf0/0x1b0
> [    4.461495]  [<00000000834a9ad6>] cpu_startup_entry+0x36/0x40
> [    4.461509]  [<000000008416e48e>] restart_int_handler+0x6e/0x90
> [    4.461521] INFO: lockdep is turned off.
> [    4.461527] Last Breaking-Event-Address:
> [    4.461533]  [<00000000835a2026>] arch_ftrace_ops_list_func+0xd6/0x1b0
> [    4.461552] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> The code in question is the ops loop in __ftrace_ops_list_func():
> 
> do_for_each_ftrace_op(op, ftrace_ops_list) {
> /* Stub functions don't need to be called nor tested */
> 	if (op->flags & FTRACE_OPS_FL_STUB)
> 		continue;
> ...
> 
> The register (r10) where op is stored contains 0x6b6b6b6b6b6b6b6b
> (POISON_FREE), so it looks like the list contains a member that is
> already freed.
> 
> Looking at unregister_ftrace_function(), i noticed that
> ftrace_shutdown() is called with 0 as command. Given that the ftrace
> function didn't change and ftrace is still enabled, the
> rcu_synchronize() functions in ftrace_shutdown() are silently skipped.
> So the caller frees ops already before other CPUs have gone through
> quiesce, and may therefore use the old (now freed) list entry.
> 
> To fix this, i wonder whether we should change the code in
> unregister_ftrace_function() to:
> 
> @@ -7827,7 +7837,7 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
>         int ret;
>  
>         mutex_lock(&ftrace_lock);
> -       ret = ftrace_shutdown(ops, 0);
> +       ret = ftrace_shutdown(ops, FTRACE_UPDATE_TRACE_FUNC);

No, the ftrace_shutdown() will add that flag if it is needed.

>         mutex_unlock(&ftrace_lock);
>  
>         return ret;
> 
> I haven't checked whether other callsites of unregister_ftrace_function()
> also need to be adjusted. What do you think about that 'fix'?

But what I'm thinking is, the function is being freed but has yet to be
removed from the list. Or that a synchronization is missed.

That is, shutdown is called, the item is removed from the list and freed,
but something got preempted while on the ftrace trampoline, with a
reference to the item, and then woke up and executed the item that was
freed.

I'll look into it. Thanks for the report.

-- Steve
