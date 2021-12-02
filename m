Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDFC4664EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358418AbhLBOQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:16:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48618 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbhLBOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:15:59 -0500
Date:   Thu, 02 Dec 2021 14:12:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638454355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuFwk2J9Qv7//sgGcuDGt+74MdZfbJfLkF7V7ZFfUj8=;
        b=UONw5YVZquomqts/OANcejsap657H387QhVSJGh/5abTpG4+y8kTixsEwaDrGHaiJ6SMlC
        L7rS04kml13r0ogWUc03FM/9gNo0ilMue75F7YJBkbYdLUjm9qZzgmMR1EVHTfLLwRMzMs
        NDYjkBlQ5nktNEcZTFeYFlruKFwBFc9wORFOtW3mdvX/AFaeVfoFOaFQyAVGaUkvktPWpN
        XgZgpx7CyYMEP8AuG90i1WsA8s22VWDZBNXSdQzwqIb1urvzwagxcPS3rt8L7QmiTclt3S
        0dB91AYFjP/EGtWzr9YOYR9F4Mug07nhUFGueKcxLGestSpCFLFUVoipTzW9Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638454355;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuFwk2J9Qv7//sgGcuDGt+74MdZfbJfLkF7V7ZFfUj8=;
        b=JXQtZ9F9dz/vPCO+bY4GzO7xP+R0C4FvhcqEZnz6JOfhYX04woFE3chKqaJwSN9rH3MLlP
        l0DTb/TNjRCizXAw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/cputime: Fix getrusage(RUSAGE_THREAD) with
 nohz_full
Cc:     Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Phil Auld <pauld@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026141055.57358-3-frederic@kernel.org>
References: <20211026141055.57358-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <163845435389.11128.15096993127413247810.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e7f2be115f0746b969c0df14c0d182f65f005ca5
Gitweb:        https://git.kernel.org/tip/e7f2be115f0746b969c0df14c0d182f65f005ca5
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 26 Oct 2021 16:10:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 02 Dec 2021 15:08:22 +01:00

sched/cputime: Fix getrusage(RUSAGE_THREAD) with nohz_full

getrusage(RUSAGE_THREAD) with nohz_full may return shorter utime/stime
than the actual time.

task_cputime_adjusted() snapshots utime and stime and then adjust their
sum to match the scheduler maintained cputime.sum_exec_runtime.
Unfortunately in nohz_full, sum_exec_runtime is only updated once per
second in the worst case, causing a discrepancy against utime and stime
that can be updated anytime by the reader using vtime.

To fix this situation, perform an update of cputime.sum_exec_runtime
when the cputime snapshot reports the task as actually running while
the tick is disabled. The related overhead is then contained within the
relevant situations.

Reported-by: Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Hasegawa Hitomi <hasegawa-hitomi@fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Acked-by: Phil Auld <pauld@redhat.com>
Link: https://lore.kernel.org/r/20211026141055.57358-3-frederic@kernel.org

---
 include/linux/sched/cputime.h |  5 +++--
 kernel/sched/cputime.c        | 12 +++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
index 6c9f19a..ce3c582 100644
--- a/include/linux/sched/cputime.h
+++ b/include/linux/sched/cputime.h
@@ -18,15 +18,16 @@
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
-extern void task_cputime(struct task_struct *t,
+extern bool task_cputime(struct task_struct *t,
 			 u64 *utime, u64 *stime);
 extern u64 task_gtime(struct task_struct *t);
 #else
-static inline void task_cputime(struct task_struct *t,
+static inline bool task_cputime(struct task_struct *t,
 				u64 *utime, u64 *stime)
 {
 	*utime = t->utime;
 	*stime = t->stime;
+	return false;
 }
 
 static inline u64 task_gtime(struct task_struct *t)
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 872e481..9392aea 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -615,7 +615,8 @@ void task_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
 		.sum_exec_runtime = p->se.sum_exec_runtime,
 	};
 
-	task_cputime(p, &cputime.utime, &cputime.stime);
+	if (task_cputime(p, &cputime.utime, &cputime.stime))
+		cputime.sum_exec_runtime = task_sched_runtime(p);
 	cputime_adjust(&cputime, &p->prev_cputime, ut, st);
 }
 EXPORT_SYMBOL_GPL(task_cputime_adjusted);
@@ -828,19 +829,21 @@ u64 task_gtime(struct task_struct *t)
  * add up the pending nohz execution time since the last
  * cputime snapshot.
  */
-void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
+bool task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 {
 	struct vtime *vtime = &t->vtime;
 	unsigned int seq;
 	u64 delta;
+	int ret;
 
 	if (!vtime_accounting_enabled()) {
 		*utime = t->utime;
 		*stime = t->stime;
-		return;
+		return false;
 	}
 
 	do {
+		ret = false;
 		seq = read_seqcount_begin(&vtime->seqcount);
 
 		*utime = t->utime;
@@ -850,6 +853,7 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		if (vtime->state < VTIME_SYS)
 			continue;
 
+		ret = true;
 		delta = vtime_delta(vtime);
 
 		/*
@@ -861,6 +865,8 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 		else
 			*utime += vtime->utime + delta;
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
+
+	return ret;
 }
 
 static int vtime_state_fetch(struct vtime *vtime, int cpu)
