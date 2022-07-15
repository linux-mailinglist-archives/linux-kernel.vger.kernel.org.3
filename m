Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB7576119
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiGOMCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGOMCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:02:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB7D8AB2E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:02:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A926834D7B;
        Fri, 15 Jul 2022 12:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657886531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=L8s/D1PNvngtvRc/fSkA0pXDsyv9MWiwhDTw8Ussffc=;
        b=mbm6gSwbPBiycDixI6YmXZK/MJCW08Drq1ZerfHvvpmtUswori3Qnl60FXYOYFP0WO4iZm
        fFeTKT7PuudN78ZqWa8vBBw/9worJGV6E6OHOGjSfrk/d54mxc8L+rN0MTnloEFE/cJyEi
        gjumeHGzpkl5TOVE0M06AnA46fNLWyM=
Received: from pathway.suse.cz (pathway.suse.cz [10.100.12.24])
        by relay2.suse.de (Postfix) with ESMTP id 416502C141;
        Fri, 15 Jul 2022 12:02:11 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Johannes Berg <johannes.berg@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] printk: Make console tracepoint safe in NMI() context
Date:   Fri, 15 Jul 2022 14:01:52 +0200
Message-Id: <20220715120152.17760-1-pmladek@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Link: https://lore.kernel.org/r/20220712151655.GU1790663@paulmck-ThinkPad-P17-Gen-1

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/trace/events/printk.h | 11 ++++++++++-
 kernel/printk/printk.c        |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/printk.h b/include/trace/events/printk.h
index 13d405b2fd8b..a3ee720f41b5 100644
--- a/include/trace/events/printk.h
+++ b/include/trace/events/printk.h
@@ -7,11 +7,20 @@
 
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(console,
+TRACE_EVENT_CONDITION(console,
 	TP_PROTO(const char *text, size_t len),
 
 	TP_ARGS(text, len),
 
+	/*
+	 * trace_console_rcuidle() is not working in NMI. printk()
+	 * is used more often in NMI than in rcuidle context.
+	 * Choose the less evil solution here.
+	 *
+	 * raw_smp_processor_id() is reliable in rcuidle context.
+	 */
+	TP_CONDITION(!rcu_is_idle_cpu(raw_smp_processor_id())),
+
 	TP_STRUCT__entry(
 		__dynamic_array(char, msg, len + 1)
 	),
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b49c6ff6dca0..bd76a45ecc7f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2108,7 +2108,7 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 		}
 	}
 
-	trace_console_rcuidle(text, text_len);
+	trace_console(text, text_len);
 
 	return text_len;
 }
-- 
2.35.3

