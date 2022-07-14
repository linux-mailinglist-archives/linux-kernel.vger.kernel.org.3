Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427D457511C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiGNOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiGNOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:53:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A454C83
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:53:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 812911FB5E;
        Thu, 14 Jul 2022 14:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657810405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73o1eBzbI3qd0v81oY29I4k1KUoL3xZ73b9t7xZ4knA=;
        b=Ue6EhNVJ1iqrgiu8z0BIU5mO9u2wQlQab9B/S13yGOlZ72n4p6MkWvsMLQaAyUBfhw/L57
        ZR1zPSOqyHEK99s77KyQXmSiIWGP/nsZCSTvwPf5yiI3dkRfE0DIvJJ+oKfZ6GTu/2tJma
        ht6Gqhr2BlrpuV8e5d1ZUJ3qE9nqyGI=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 15FC42C141;
        Thu, 14 Jul 2022 14:53:25 +0000 (UTC)
Date:   Thu, 14 Jul 2022 16:53:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH -printk] printk, tracing: fix console tracepoint
Message-ID: <20220714145324.GA24338@pathway.suse.cz>
References: <20220712002128.GQ1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220711205319.1aa0d875@gandalf.local.home>
 <20220712025701.GS1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712114954.GA3870114@paulmck-ThinkPad-P17-Gen-1>
 <20220712093940.45012e47@gandalf.local.home>
 <20220712134916.GT1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220712105353.08358450@gandalf.local.home>
 <20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220713112541.GB2737@pathway.suse.cz>
 <20220713140550.GK1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713140550.GK1790663@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-07-13 07:05:50, Paul E. McKenney wrote:
> On Wed, Jul 13, 2022 at 01:25:41PM +0200, Petr Mladek wrote:
> > On Tue 2022-07-12 08:16:55, Paul E. McKenney wrote:
> > > Maybe printk() is supposed to be invoked from noinstr.  It might be a
> > > special case in the tooling.  I have no idea.  ;-)
> > 
> > I think that it is ok to do _not_ support printk() in noinstr parts.
> > 
> > > However, the current SRCU read-side algorithm will tolerate being invoked
> > > from noinstr as long as it is not also an NMI handler.  Much though
> > > debugging tools might (or might not) complain.
> > > 
> > > Don't get me wrong, I can make SRCU tolerate being called while RCU is
> > > not watching.  It is not even all that complicated.  The cost is that
> > > architectures that have NMIs but do not have NMI-safe this_cpu*()
> > > operations have an SRCU reader switch from explicit smp_mb() and
> > > interrupt disabling to a cmpxchg() loop relying on the implicit barriers
> > > in cmpxchg().
> > > 
> > > For arm64, this was reportedly a win.
> > 
> > IMHO, the tracepoint in printk() is not worth slowing down other
> > important fast paths.
> > 
> > The tracepoint was moved into vprintk_store() in 5.19-rc1. It used
> > to be in console_unlock() before. The previous location was not
> > reliable by definition. Old messages might be overridden by new
> > ones before they reach console. Also messages in NMI context
> > used to be stored in per-CPU buffers. There was even bigger
> > risk that they would not reach the console.
> 
> Fair enough, works for me!

The remaining question is how to make the code safe and calm
down the warning.

My understanding is that Peter Zijlstra wants to reduce the scope
of the rcuidle code even more in the future. So, we could
do something like:

From 24c3517dedf2a30efabe72871c188fbfffffd397 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Thu, 14 Jul 2022 14:54:12 +0200
Subject: [PATCH] printk: Make console tracepoint safe in NMI() context

The commit 701850dc0c31bfadf75a0 ("printk, tracing: fix console
tracepoint") moved the tracepoint from console_unlock() to
vprintk_store(). As a result, it might be called in any
context and triggered the following warning:

  WARNING: CPU: 1 PID: 16462 at include/trace/events/printk.h:10 printk_sprint+0x81/0xda
  Modules linked in: ppdev parport_pc parport
  CPU: 1 PID: 16462 Comm: event_benchmark Not tainted 5.19.0-rc5-test+ #5
  Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
  EIP: printk_sprint+0x81/0xda
  Code: 89 d8 e8 88 fc 33 00 e9 02 00 00 00 eb 6b 64 a1 a4 b8 91 c1 e8 fd d6 ff ff 84 c0 74 5c 64 a1 14 08 92 c1 a9 00 00 f0 00 74 02 <0f> 0b 64 ff 05 14 08 92 c1 b8 e0 c4 6b c1 e8 a5 dc 00 00 89 c7 e8
  EAX: 80110001 EBX: c20a52f8 ECX: 0000000c EDX: 6d203036
  ESI: 3df6004c EDI: 00000000 EBP: c61fbd7c ESP: c61fbd70
  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010006
  CR0: 80050033 CR2: b7efc000 CR3: 05b80000 CR4: 001506f0
  Call Trace:
   vprintk_store+0x24b/0x2ff
   vprintk+0x37/0x4d
   _printk+0x14/0x16
   nmi_handle+0x1ef/0x24e
   ? find_next_bit.part.0+0x13/0x13
   ? find_next_bit.part.0+0x13/0x13
   ? function_trace_call+0xd8/0xd9
   default_do_nmi+0x57/0x1af
   ? trace_hardirqs_off_finish+0x2a/0xd9
   ? to_kthread+0xf/0xf
   exc_nmi+0x9b/0xf4
   asm_exc_nmi+0xae/0x29c

It comes from:

  #define __DO_TRACE(name, args, cond, rcuidle) \
  [...]
		/* srcu can't be used from NMI */	\
		WARN_ON_ONCE(rcuidle && in_nmi());	\

It might be possible to make srcu working in NMI. But it
would be slower on some architectures. It is not worth
doing it just because of this tracepoint.

It would be possible to disable this tracepoint in NMI
or in rcuidle context. Where the rcuidle context looks
more rare and thus more acceptable to be ignored.

Alternative solution would be to move the tracepoint
back to console code. But the location is less reliable
by definition. Also the synchronization against other
tracing messages is much worse.

Let's ignore the tracepoint in rcuidle context as the least
evil solution.

There seems to be three possibilities.
Link: https://lore.kernel.org/r/20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b49c6ff6dca0..a13cf3310204 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2108,7 +2108,15 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 		}
 	}
 
-	trace_console_rcuidle(text, text_len);
+	/*
+	 * trace_console_idle() is not working in NMI. printk()
+	 * is used more often in NMI than in rcuidle context.
+	 * Choose the less evil solution here.
+	 *
+	 * smp_processor_id() is reliable in rcuidle context.
+	 */
+	if (!rcu_is_idle_cpu(smp_processor_id()))
+		trace_console(text, text_len);
 
 	return text_len;
 }
-- 
2.35.3

