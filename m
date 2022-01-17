Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150C2490CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbiAQQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:47:20 -0500
Received: from foss.arm.com ([217.140.110.172]:60660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237778AbiAQQrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:47:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7FD11063;
        Mon, 17 Jan 2022 08:47:17 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FBA93F766;
        Mon, 17 Jan 2022 08:47:15 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH v2 2/2] sched/tracing: Add TASK_RTLOCK_WAIT to TASK_REPORT
Date:   Mon, 17 Jan 2022 16:46:33 +0000
Message-Id: <20220117164633.322550-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117164633.322550-1-valentin.schneider@arm.com>
References: <20220117164633.322550-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

