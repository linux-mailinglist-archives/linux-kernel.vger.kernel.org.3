Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E86585F1A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiGaNTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGaNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:19:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C855EE39
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 06:19:30 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id I8qtohGhMQUcTI8qtoE8A8; Sun, 31 Jul 2022 15:19:28 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 31 Jul 2022 15:19:28 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v4] timers: Optimize usleep_range()
Date:   Sun, 31 Jul 2022 15:19:08 +0200
Message-Id: <f0361b83a0a0b549f8ec5ab8134905001a6f2509.1659126514.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the time the 'min' and 'max' parameters of usleep_range() are
constant. We can take advantage of it to pre-compute at compile time
some values otherwise computed at run-time in usleep_range_state().

Replace usleep_range_state() by a new __nsleep_range_delta_state() function
that takes as parameters the pre-computed values.

The main benefit is to save a few instructions, especially 2
multiplications (x1000 when converting us to ns).


Some hand simplified diff of the generated asm are given below. They were
produced on a Intel(R) Core(TM) i7-3770, with gcc 11.2.0.

drivers/clk/clk-si514.c (taken as an example)
-----------------------
In this driver we have:
   usleep_range(10000, 12000);

  ea0:	45 85 e4             	test   %r12d,%r12d
  ea3:	0f 88 f6 fc ff ff    	js     b9f <si514_set_rate+0x9f>
  ea9:	e8 00 00 00 00       	call   eae <si514_set_rate+0x3ae>
- eae:	be e0 2e 00 00       	mov    $0x2ee0,%esi             ;     12.000
- eb3:	bf 10 27 00 00       	mov    $0x2710,%edi             ;     10.000
+ eae:	be 80 84 1e 00       	mov    $0x1e8480,%esi           ;  2.000.000
+ eb3:	bf 80 96 98 00       	mov    $0x989680,%edi           ; 10.000.000
  eb8:	ba 02 00 00 00       	mov    $0x2,%edx
  ebd:	e8 00 00 00 00       	call   ec2 <si514_set_rate+0x3c2>
  ec2:	44 8b 74 24 30       	mov    0x30(%rsp),%r14d

The asm produced in the caller is mostly the same. Only constant values
passed to usleep_range_state() or __nsleep_range_delta_state() are
different. No other instructions or whatever is different.


kernel/time/timer.c
-------------------
-0000000000000000 <usleep_range_state>:
+0000000000000000 <__nsleep_range_delta_state>:
[...]
  41 56                	push   %r14
  49 c7 c6 00 00 00 00 	mov    $0x0,%r14
  41 55                	push   %r13
- 41 89 d5             	mov    %edx,%r13d
+ 49 89 f5             	mov    %rsi,%r13
  41 54                	push   %r12
- 49 89 f4             	mov    %rsi,%r12
+ 41 89 d4             	mov    %edx,%r12d
  55                   	push   %rbp
- 44 89 ed             	mov    %r13d,%ebp
+ 44 89 e5             	mov    %r12d,%ebp
  53                   	push   %rbx
  48 89 fb             	mov    %rdi,%rbx
  81 e5 cc 00 00 00    	and    $0xcc,%ebp
- 49 29 dc             	sub    %rbx,%r12              ; (max - min)
- 4d 69 e4 e8 03 00 00 	imul   $0x3e8,%r12,%r12       ; us --> ns (x 1000)
  48 83 ec 68          	sub    $0x68,%rsp
  48 c7 44 24 08 b3 8a 	movq   $0x41b58ab3,0x8(%rsp)
  b5 41
[...]
  31 c0                	xor    %eax,%eax
  e8 00 00 00 00       	call   ...
  e8 00 00 00 00       	call   ...
- 49 89 c0             	mov    %rax,%r8
- 48 69 c3 e8 03 00 00 	imul   $0x3e8,%rbx,%rax       ; us --> ns (x 1000)
+ 48 01 d8             	add    %rbx,%rax
+ 48 89 44 24 28       	mov    %rax,0x28(%rsp)
  65 48 8b 1c 25 00 00 	mov    %gs:0x0,%rbx
  00 00
- 4c 01 c0             	add    %r8,%rax
- 48 89 44 24 28       	mov    %rax,0x28(%rsp)
  e8 00 00 00 00       	call   ...
  31 ff                	xor    %edi,%edi
  89 ee                	mov    %ebp,%esi

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: John Stultz <jstultz@google.com>
---
v1 -> v2
  - Simplify and avoid use of __buildint_constant_p()  [John Stultz <jstultz@google.com>]
  - Also update usleep_idle_range()
  - Axe usleep_range_state()  [John Stultz <jstultz@google.com>]
  - Fix kerneldoc  [John Stultz <jstultz@google.com>]
  - Update log message accordingly
https://lore.kernel.org/all/d7fc85736adee02ce52ee88a54fa7477fbd18ed2.1653236802.git.christophe.jaillet@wanadoo.fr/

v2 -> v3
  - Fix checkpatch warning/error  [John Stultz <jstultz@google.com>]
  - Add Acked-by
https://lore.kernel.org/all/a896e176f0f0b819f8ec5ab8935355d01a642506.1659126514.git.christophe.jaillet@wanadoo.fr/

v3 -> v4
  - Simplify the kerneldoc of usleep_range_state() to please "make htmldocs"
    [kernel test robot <lkp@intel.com>]
https://lore.kernel.org/all/c146e183a0f0b819f8ec5ab8934905d01a642506.1659126514.git.christophe.jaillet@wanadoo.fr/
---
 include/linux/delay.h | 17 +++++++++++++----
 kernel/time/timer.c   | 17 ++++++++---------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index 039e7e0c7378..27938a49c701 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -59,17 +59,26 @@ void calibrate_delay(void);
 void __attribute__((weak)) calibration_delay_done(void);
 void msleep(unsigned int msecs);
 unsigned long msleep_interruptible(unsigned int msecs);
-void usleep_range_state(unsigned long min, unsigned long max,
-			unsigned int state);
+void __nsleep_range_delta_state(u64 min, u64 delta, unsigned int state);
 
 static inline void usleep_range(unsigned long min, unsigned long max)
 {
-	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
+	/*
+	 * Most of the time min and max are constant, so the time delta and the
+	 * conversion to ns will be optimized-out at compile time.
+	 */
+	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
+
+	__nsleep_range_delta_state(min * NSEC_PER_USEC, delta,
+				   TASK_UNINTERRUPTIBLE);
 }
 
 static inline void usleep_idle_range(unsigned long min, unsigned long max)
 {
-	usleep_range_state(min, max, TASK_IDLE);
+	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
+
+	__nsleep_range_delta_state(min * NSEC_PER_USEC, delta,
+				   TASK_IDLE);
 }
 
 static inline void ssleep(unsigned int seconds)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14a..475b1c0406d7 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2109,22 +2109,21 @@ unsigned long msleep_interruptible(unsigned int msecs)
 EXPORT_SYMBOL(msleep_interruptible);
 
 /**
- * usleep_range_state - Sleep for an approximate time in a given state
- * @min:	Minimum time in usecs to sleep
- * @max:	Maximum time in usecs to sleep
+ * __nsleep_range_delta_state - Sleep for an approximate time in a given state
+ * @min:	Minimum time in nsecs to sleep
+ * @delta:	Duration in nsecs that can be tolerated after @min
  * @state:	State of the current task that will be while sleeping
  *
  * In non-atomic context where the exact wakeup time is flexible, use
- * usleep_range_state() instead of udelay().  The sleep improves responsiveness
+ * usleep_range() instead of udelay().  The sleep improves responsiveness
  * by avoiding the CPU-hogging busy-wait of udelay(), and the range reduces
  * power usage by allowing hrtimers to take advantage of an already-
  * scheduled interrupt instead of scheduling a new one just for this sleep.
  */
-void __sched usleep_range_state(unsigned long min, unsigned long max,
-				unsigned int state)
+void __sched __nsleep_range_delta_state(u64 min, u64 delta,
+					unsigned int state)
 {
-	ktime_t exp = ktime_add_us(ktime_get(), min);
-	u64 delta = (u64)(max - min) * NSEC_PER_USEC;
+	ktime_t exp = ktime_add_ns(ktime_get(), min);
 
 	for (;;) {
 		__set_current_state(state);
@@ -2133,4 +2132,4 @@ void __sched usleep_range_state(unsigned long min, unsigned long max,
 			break;
 	}
 }
-EXPORT_SYMBOL(usleep_range_state);
+EXPORT_SYMBOL(__nsleep_range_delta_state);
-- 
2.34.1

