Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE395304BB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbiEVQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbiEVQix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 12:38:53 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B7F381B2
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 09:38:50 -0700 (PDT)
Received: from pop-os.home ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id sobQnlvPfxzw2sobQnis1j; Sun, 22 May 2022 18:38:49 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 22 May 2022 18:38:49 +0200
X-ME-IP: 86.243.180.246
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dan.carpenter@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [RFC PATCH] timers: Optimize usleep_range()
Date:   Sun, 22 May 2022 18:38:38 +0200
Message-Id: <d7fc85736adee02ce52ee88a54fa7477fbd18ed2.1653236802.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the time the 'min' and 'max' parameters of usleep_range() are
constant. We can take advantage of it to pre-compute at compile time
some values used in usleep_range_state().

introduced a new __nsleep_range_delta_state() function that mimics
usleep_range_state() but takes as parameters the pre-computed values.

The main benefit is to save a few instructions, especially 2
multiplications (x1000 when converting us to ns).

A hand simplified diff of the generated asm is given below. It was
produced on a Intel(R) Core(TM) i7-3770, with gcc 11.2.0.

The asm produced in the caller is mostly the same. Only constant values
passed to usleep_range_state() or __nsleep_range_delta_state() are
different. No other instructions or whatever is different.

--- timer.asm	2022-05-22 17:43:09.160513527 +0200
+++ timer2.asm	2022-05-22 17:59:34.791072278 +0200
@@ -7,16 +7,14 @@
 41 56                	push   %r14
 49 c7 c6 00 00 00 00 	mov    $0x0,%r14
 41 55                	push   %r13
-41 89 d5             	mov    %edx,%r13d
+49 89 f5             	mov    %rsi,%r13
 41 54                	push   %r12
-49 89 f4             	mov    %rsi,%r12
+41 89 d4             	mov    %edx,%r12d
 55                   	push   %rbp
-44 89 ed             	mov    %r13d,%ebp
+44 89 e5             	mov    %r12d,%ebp
 53                   	push   %rbx
 48 89 fb             	mov    %rdi,%rbx
 81 e5 cc 00 00 00    	and    $0xcc,%ebp
-49 29 dc             	sub    %rbx,%r12
-4d 69 e4 e8 03 00 00 	imul   $0x3e8,%r12,%r12
 48 83 ec 68          	sub    $0x68,%rsp
 48 c7 44 24 08 b3 8a 	movq   $0x41b58ab3,0x8(%rsp)
 b5 41
@@ -36,18 +34,16 @@
 31 c0                	xor    %eax,%eax
 e8 00 00 00 00       	call
 e8 00 00 00 00       	call
-49 89 c0             	mov    %rax,%r8
-48 69 c3 e8 03 00 00 	imul   $0x3e8,%rbx,%rax
+48 01 d8             	add    %rbx,%rax
+48 89 44 24 28       	mov    %rax,0x28(%rsp)
 65 48 8b 1c 25 00 00 	mov    %gs:0x0,%rbx
 00 00
-4c 01 c0             	add    %r8,%rax
-48 89 44 24 28       	mov    %rax,0x28(%rsp)
 e8 00 00 00 00       	call
 31 ff                	xor    %edi,%edi
 89 ee                	mov    %ebp,%esi
@@ -55,9 +51,9 @@
 4c 89 b3 68 30 00 00 	mov    %r14,0x3068(%rbx)
 48 8d 7b 18          	lea    0x18(%rbx),%rdi
 e8 00 00 00 00       	call
-44 89 6b 18          	mov    %r13d,0x18(%rbx)
+44 89 63 18          	mov    %r12d,0x18(%rbx)
 31 d2                	xor    %edx,%edx
-4c 89 e6             	mov    %r12,%rsi
+4c 89 ee             	mov    %r13,%rsi
 48 8d 7c 24 28       	lea    0x28(%rsp),%rdi
 e8 00 00 00 00       	call
 31 ff                	xor    %edi,%edi
@@ -88,16 +84,11 @@
 89 c1                	mov    %eax,%ecx
 89 c6                	mov    %eax,%esi
 89 c7                	mov    %eax,%edi
-41 89 c0             	mov    %eax,%r8d
 c3                   	ret
 cc                   	int3
 e8 00 00 00 00       	call

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This saves some cycles, okay, but it adds complexity and a new function.
How is the balance?

Apparently multiplications are really fast on recent x86, but maybe on some
other architectures saving some multiplications is great?

My own feeling is that it is sad not to compile-time compute what we can.

I let you decide if it worth it.
---
 include/linux/delay.h | 15 ++++++++++++++-
 kernel/time/timer.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index 039e7e0c7378..e84e7f9c1a47 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -61,10 +61,23 @@ void msleep(unsigned int msecs);
 unsigned long msleep_interruptible(unsigned int msecs);
 void usleep_range_state(unsigned long min, unsigned long max,
 			unsigned int state);
+void __nsleep_range_delta_state(u64 min, u64 delta, unsigned int state);
 
 static inline void usleep_range(unsigned long min, unsigned long max)
 {
-	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
+	/*
+	 * Most of the time min and max are constant, so the time delta and the
+	 * convertion to ns can be computed at compile time.
+	 */
+	if (__builtin_constant_p(min) &&
+	    __builtin_constant_p(max)) {
+		u64 delta = (u64)(max - min) * NSEC_PER_USEC;
+
+		__nsleep_range_delta_state(min * NSEC_PER_USEC, delta,
+					   TASK_UNINTERRUPTIBLE);
+	} else {
+		usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
+	}
 }
 
 static inline void usleep_idle_range(unsigned long min, unsigned long max)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..c71d745f743f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2134,3 +2134,30 @@ void __sched usleep_range_state(unsigned long min, unsigned long max,
 	}
 }
 EXPORT_SYMBOL(usleep_range_state);
+
+/**
+ * __nsleep_range_delta_state - Sleep for an approximate time in a given state
+ * @min:	Minimum time in nsecs to sleep
+ * @delta:	Maximum time in nsecs to sleep
+ * @state:	State of the current task that will be while sleeping
+ *
+ * This function is the same as usleep_range_state(), except that:
+ *   - the time delta is precomputed by the caller
+ *   - the times are given in ns instead of us
+ *
+ * It is not intended to direct use, but is used in a compile-time optimized
+ * path in usleep_range().
+ */
+void __sched __nsleep_range_delta_state(u64 min, u64 delta,
+				        unsigned int state)
+{
+	ktime_t exp = ktime_add_ns(ktime_get(), min);
+
+	for (;;) {
+		__set_current_state(state);
+		/* Do not return before the requested sleep time has elapsed */
+		if (!schedule_hrtimeout_range(&exp, delta, HRTIMER_MODE_ABS))
+			break;
+	}
+}
+EXPORT_SYMBOL(__nsleep_range_delta_state);
-- 
2.34.1

