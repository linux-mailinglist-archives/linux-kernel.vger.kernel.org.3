Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5128349520B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376887AbiATQJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376871AbiATQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:09:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7EC06161C;
        Thu, 20 Jan 2022 08:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EoDxyQ5zZysrQvDvpMfLfzo72oIZBXHd0US2ONa2HeA=; b=W1SVLlfvjNw49kXCVDmtetyoaS
        OG+8byKA4715c6elpDeg/wbgm2JC/zo7QUicqBrAPY18AucDUsIPaejraLM+kinfTCi+Oy/nrq1nB
        coeVbNKzbbYmNiCZYcpH1ImI++ddYe9xcdLN4UlzHnVWZXohkh02tngtvToDLBNP9evE8x2UHbfes
        enX3GMeI9dM98zKvAjPR1fhnWoh38cS/0SFtme7+OX8UxGhwCuO54bExgJD6BTwe3/sfkUg+PZW6u
        P/PX2PB5wC0M3U3g69k6+o8e0/fSscsm3z+6IdIkq/bL+/sJPEneccGnxzruBHfvje2Fd+OPVQjP0
        cr0tEZWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAZza-00EQ4F-3H; Thu, 20 Jan 2022 16:08:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B763C300222;
        Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9A08120280188; Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Message-ID: <20220120160822.790430899@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Jan 2022 16:55:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: [RFC][PATCH v2 3/5] sched/umcg: add WF_CURRENT_CPU and externise ttwu
References: <20220120155517.066795336@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@posk.io>

Add WF_CURRENT_CPU wake flag that advices the scheduler to
move the wakee to the current CPU. This is useful for fast on-CPU
context switching use cases such as UMCG.

In addition, make ttwu external rather than static so that
the flag could be passed to it from outside of sched/core.c.

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211122211327.5931-2-posk@google.com
---
 kernel/sched/core.c  |    3 +--
 kernel/sched/fair.c  |    4 ++++
 kernel/sched/sched.h |   17 ++++++++++-------
 3 files changed, 15 insertions(+), 9 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3980,8 +3980,7 @@ bool ttwu_state_match(struct task_struct
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
-static int
-try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
+int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
 	unsigned long flags;
 	int cpu, success = 0;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6838,6 +6838,10 @@ select_task_rq_fair(struct task_struct *
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
+		if ((wake_flags & WF_CURRENT_CPU) &&
+		    cpumask_test_cpu(cpu, p->cpus_ptr))
+			return cpu;
+
 		if (sched_energy_enabled()) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2052,13 +2052,14 @@ static inline int task_on_rq_migrating(s
 }
 
 /* Wake flags. The first three directly map to some SD flag value */
-#define WF_EXEC     0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
-#define WF_FORK     0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
-#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
-
-#define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
-#define WF_MIGRATED 0x20 /* Internal use, task got migrated */
-#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
+#define WF_EXEC         0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK         0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU         0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+
+#define WF_SYNC         0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED     0x20 /* Internal use, task got migrated */
+#define WF_ON_CPU       0x40 /* Wakee is on_cpu */
+#define WF_CURRENT_CPU  0x80 /* Prefer to move the wakee to the current CPU. */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
@@ -3112,6 +3113,8 @@ static inline bool is_per_cpu_kthread(st
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);


