Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8746153F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbhK2Mlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:41:36 -0500
Received: from foss.arm.com ([217.140.110.172]:37742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhK2Mjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:39:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90CA111D4;
        Mon, 29 Nov 2021 04:36:15 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 936F33F5A1;
        Mon, 29 Nov 2021 04:36:13 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 2/2] sched/tracing: Add TASK_RTLOCK_WAIT to TASK_REPORT
Date:   Mon, 29 Nov 2021 12:36:01 +0000
Message-Id: <20211129123601.2101873-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129123601.2101873-1-valentin.schneider@arm.com>
References: <20211129123601.2101873-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TASK_RTLOCK_WAIT currently isn't part of TASK_REPORT, thus a task blocking
on an rtlock will appear as having a task state == 0, IOW TASK_RUNNING.

The actual state is saved in p->saved_state, but reading it after reading
p->__state has a few issues:
o that could still be TASK_RUNNING in the case of e.g. rt_spin_lock
o ttwu_state_match() might have changed that to TASK_RUNNING

Add TASK_RTLOCK_WAIT to TASK_REPORT.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 fs/proc/array.c              |  3 ++-
 include/linux/sched.h        | 17 +++++++++--------
 include/trace/events/sched.h |  1 +
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index ff869a66b34e..f4cae65529a6 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -128,9 +128,10 @@ static const char * const task_state_array[] = {
 	"X (dead)",		/* 0x10 */
 	"Z (zombie)",		/* 0x20 */
 	"P (parked)",		/* 0x40 */
+	"L (rt-locked)",        /* 0x80 */
 
 	/* states beyond TASK_REPORT: */
-	"I (idle)",		/* 0x80 */
+	"I (idle)",		/* 0x100 */
 };
 
 static inline const char *get_task_state(struct task_struct *tsk)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d00837d12b9d..18fd77578dae 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -91,13 +91,14 @@ struct task_group;
 #define EXIT_TRACE			(EXIT_ZOMBIE | EXIT_DEAD)
 /* Used in tsk->state again: */
 #define TASK_PARKED			0x0040
-#define TASK_DEAD			0x0080
-#define TASK_WAKEKILL			0x0100
-#define TASK_WAKING			0x0200
-#define TASK_NOLOAD			0x0400
-#define TASK_NEW			0x0800
 /* RT specific auxilliary flag to mark RT lock waiters */
-#define TASK_RTLOCK_WAIT		0x1000
+#define TASK_RTLOCK_WAIT		0x0080
+
+#define TASK_DEAD			0x0100
+#define TASK_WAKEKILL			0x0200
+#define TASK_WAKING			0x0400
+#define TASK_NOLOAD			0x0800
+#define TASK_NEW			0x1000
 #define TASK_STATE_MAX			0x2000
 
 /* Convenience macros for the sake of set_current_state: */
@@ -114,7 +115,7 @@ struct task_group;
 #define TASK_REPORT			(TASK_RUNNING | TASK_INTERRUPTIBLE | \
 					 TASK_UNINTERRUPTIBLE | __TASK_STOPPED | \
 					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
-					 TASK_PARKED)
+					 TASK_PARKED | TASK_RTLOCK_WAIT)
 
 #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
@@ -1636,7 +1637,7 @@ static inline unsigned int task_state_index(struct task_struct *tsk)
 
 static inline char task_index_to_char(unsigned int state)
 {
-	static const char state_char[] = "RSDTtXZPI";
+	static const char state_char[] = "RSDTtXZPLI";
 
 	BUILD_BUG_ON(1 + ilog2(TASK_REPORT_MAX) != sizeof(state_char) - 1);
 
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 65e786756321..f86ec9af19ff 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -261,6 +261,7 @@ TRACE_EVENT(sched_switch,
 				{ EXIT_DEAD, "X" },
 				{ EXIT_ZOMBIE, "Z" },
 				{ TASK_PARKED, "P" },
+				{ TASK_RTLOCK_WAIT, "L" },
 				{ TASK_DEAD, "I" }) :
 		  "R",
 
-- 
2.25.1

