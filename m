Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32014D9648
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346049AbiCOIdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbiCOIcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21004C7AC;
        Tue, 15 Mar 2022 01:31:05 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:31:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eVfC8eoawa//AbKfXkS0usxMRFJRbCwkKkUUe4vn+Lk=;
        b=p57gJxF3f4LJjhpdzd+kTlBIp8A9SnjhXw8eYGL+YKLEPw8aZwji1EIW0lqvV9mZcDc2Gf
        SGcXDWSInX3i0X89ZJivpqceGrIR/CGnb5pOTlUXxWJ1KlRl1cDA3XQKxXWyOoC44bLvQ9
        yPPQ7yC3vDEouGAvw8qhMqyregNsZuVSEVku30YcPL49M9yX1ENoKkUQ5sIjzEYwuy4hhc
        K7Qjzf7mJQ7AYXmTsfRkhbVKbISyzjiBrBucdLC4WTIGYbeDpxoV4KNqPUIdk/++lkmkKc
        bmmQkXhVy+OrEFCJScqKJSSvSm1VXYPqVCXiNnJmzEiPcol8rgybTTgI9NsuGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eVfC8eoawa//AbKfXkS0usxMRFJRbCwkKkUUe4vn+Lk=;
        b=Z1IIpGMzWL8lqu4C3NM1PZes31xQyjcifcSzzjoU71nXi1TsdGnmx3XMyU1eeq2WU6rDDp
        qoVA/HHbwVBJn5Aw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: sched/clock: Mark all functions
 'notrace', remove CC_FLAGS_FTRACE build asymmetry
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733306337.16921.8537336378185224767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fa28abed7a84f5c9902fe28b3bb58f7900583e83
Gitweb:        https://git.kernel.org/tip/fa28abed7a84f5c9902fe28b3bb58f7900583e83
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 21 Jun 2021 08:41:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 08:22:04 +01:00

sched/headers: sched/clock: Mark all functions 'notrace', remove CC_FLAGS_FTRACE build asymmetry

Mark all non-init functions in kernel/sched.c as 'notrace', instead of
turning them all off via CC_FLAGS_FTRACE.

This is going to allow the treatment of this file as any other scheduler
file, and it can be #include-ed in compound compilation units as well.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/Makefile |  3 +---
 kernel/sched/clock.c  | 42 +++++++++++++++++++++---------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index c83b37a..c0c5202 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_clock.o = $(CC_FLAGS_FTRACE)
-endif
 
 # The compilers are complaining about unused variables inside an if(0) scope
 # block. This is daft, shut them up.
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c2b2859..540d0e5 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -61,7 +61,7 @@
  * This is default implementation.
  * Architectures and sub-architectures can override this.
  */
-unsigned long long __weak sched_clock(void)
+notrace unsigned long long __weak sched_clock(void)
 {
 	return (unsigned long long)(jiffies - INITIAL_JIFFIES)
 					* (NSEC_PER_SEC / HZ);
@@ -95,28 +95,28 @@ struct sched_clock_data {
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct sched_clock_data, sched_clock_data);
 
-static inline struct sched_clock_data *this_scd(void)
+notrace static inline struct sched_clock_data *this_scd(void)
 {
 	return this_cpu_ptr(&sched_clock_data);
 }
 
-static inline struct sched_clock_data *cpu_sdc(int cpu)
+notrace static inline struct sched_clock_data *cpu_sdc(int cpu)
 {
 	return &per_cpu(sched_clock_data, cpu);
 }
 
-int sched_clock_stable(void)
+notrace int sched_clock_stable(void)
 {
 	return static_branch_likely(&__sched_clock_stable);
 }
 
-static void __scd_stamp(struct sched_clock_data *scd)
+notrace static void __scd_stamp(struct sched_clock_data *scd)
 {
 	scd->tick_gtod = ktime_get_ns();
 	scd->tick_raw = sched_clock();
 }
 
-static void __set_sched_clock_stable(void)
+notrace static void __set_sched_clock_stable(void)
 {
 	struct sched_clock_data *scd;
 
@@ -151,7 +151,7 @@ static void __set_sched_clock_stable(void)
  * The only way to fully avoid random clock jumps is to boot with:
  * "tsc=unstable".
  */
-static void __sched_clock_work(struct work_struct *work)
+notrace static void __sched_clock_work(struct work_struct *work)
 {
 	struct sched_clock_data *scd;
 	int cpu;
@@ -177,7 +177,7 @@ static void __sched_clock_work(struct work_struct *work)
 
 static DECLARE_WORK(sched_clock_work, __sched_clock_work);
 
-static void __clear_sched_clock_stable(void)
+notrace static void __clear_sched_clock_stable(void)
 {
 	if (!sched_clock_stable())
 		return;
@@ -186,7 +186,7 @@ static void __clear_sched_clock_stable(void)
 	schedule_work(&sched_clock_work);
 }
 
-void clear_sched_clock_stable(void)
+notrace void clear_sched_clock_stable(void)
 {
 	__sched_clock_stable_early = 0;
 
@@ -196,7 +196,7 @@ void clear_sched_clock_stable(void)
 		__clear_sched_clock_stable();
 }
 
-static void __sched_clock_gtod_offset(void)
+notrace static void __sched_clock_gtod_offset(void)
 {
 	struct sched_clock_data *scd = this_scd();
 
@@ -246,12 +246,12 @@ late_initcall(sched_clock_init_late);
  * min, max except they take wrapping into account
  */
 
-static inline u64 wrap_min(u64 x, u64 y)
+notrace static inline u64 wrap_min(u64 x, u64 y)
 {
 	return (s64)(x - y) < 0 ? x : y;
 }
 
-static inline u64 wrap_max(u64 x, u64 y)
+notrace static inline u64 wrap_max(u64 x, u64 y)
 {
 	return (s64)(x - y) > 0 ? x : y;
 }
@@ -262,7 +262,7 @@ static inline u64 wrap_max(u64 x, u64 y)
  *  - filter out backward motion
  *  - use the GTOD tick value to create a window to filter crazy TSC values
  */
-static u64 sched_clock_local(struct sched_clock_data *scd)
+notrace static u64 sched_clock_local(struct sched_clock_data *scd)
 {
 	u64 now, clock, old_clock, min_clock, max_clock, gtod;
 	s64 delta;
@@ -295,7 +295,7 @@ again:
 	return clock;
 }
 
-static u64 sched_clock_remote(struct sched_clock_data *scd)
+notrace static u64 sched_clock_remote(struct sched_clock_data *scd)
 {
 	struct sched_clock_data *my_scd = this_scd();
 	u64 this_clock, remote_clock;
@@ -362,7 +362,7 @@ again:
  *
  * See cpu_clock().
  */
-u64 sched_clock_cpu(int cpu)
+notrace u64 sched_clock_cpu(int cpu)
 {
 	struct sched_clock_data *scd;
 	u64 clock;
@@ -386,7 +386,7 @@ u64 sched_clock_cpu(int cpu)
 }
 EXPORT_SYMBOL_GPL(sched_clock_cpu);
 
-void sched_clock_tick(void)
+notrace void sched_clock_tick(void)
 {
 	struct sched_clock_data *scd;
 
@@ -403,7 +403,7 @@ void sched_clock_tick(void)
 	sched_clock_local(scd);
 }
 
-void sched_clock_tick_stable(void)
+notrace void sched_clock_tick_stable(void)
 {
 	if (!sched_clock_stable())
 		return;
@@ -423,7 +423,7 @@ void sched_clock_tick_stable(void)
 /*
  * We are going deep-idle (irqs are disabled):
  */
-void sched_clock_idle_sleep_event(void)
+notrace void sched_clock_idle_sleep_event(void)
 {
 	sched_clock_cpu(smp_processor_id());
 }
@@ -432,7 +432,7 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_sleep_event);
 /*
  * We just idled; resync with ktime.
  */
-void sched_clock_idle_wakeup_event(void)
+notrace void sched_clock_idle_wakeup_event(void)
 {
 	unsigned long flags;
 
@@ -458,7 +458,7 @@ void __init sched_clock_init(void)
 	local_irq_enable();
 }
 
-u64 sched_clock_cpu(int cpu)
+notrace u64 sched_clock_cpu(int cpu)
 {
 	if (!static_branch_likely(&sched_clock_running))
 		return 0;
@@ -476,7 +476,7 @@ u64 sched_clock_cpu(int cpu)
  * On bare metal this function should return the same as local_clock.
  * Architectures and sub-architectures can override this.
  */
-u64 __weak running_clock(void)
+notrace u64 __weak running_clock(void)
 {
 	return local_clock();
 }
