Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297EA49524F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376977AbiATQZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:25:59 -0500
Received: from foss.arm.com ([217.140.110.172]:44070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376986AbiATQZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:25:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62DA71396;
        Thu, 20 Jan 2022 08:25:55 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE9823F73D;
        Thu, 20 Jan 2022 08:25:52 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH v3 2/2] sched/tracing: Report TASK_RTLOCK_WAIT tasks as TASK_UNINTERRUPTIBLE
Date:   Thu, 20 Jan 2022 16:25:20 +0000
Message-Id: <20220120162520.570782-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120162520.570782-1-valentin.schneider@arm.com>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
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

As pointed out by Eric, adding TASK_RTLOCK_WAIT to TASK_REPORT implies
exposing a new state to userspace tools which way not know what to do with
them. The only information that needs to be conveyed here is that a task is
waiting on an rt_mutex, which matches TASK_UNINTERRUPTIBLE - there's no
need for a new state.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 include/linux/sched.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d00837d12b9d..068270ff04b8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1626,6 +1626,14 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 	if (tsk_state == TASK_IDLE)
 		state = TASK_REPORT_IDLE;
 
+	/*
+	 * We're lying here, but rather than expose a completely new task state
+	 * to userspace, we can make this appear as if the task has gone through
+	 * a regular rt_mutex_lock() call.
+	 */
+	if (tsk_state == TASK_RTLOCK_WAIT)
+		state = TASK_UNINTERRUPTIBLE;
+
 	return fls(state);
 }
 
-- 
2.25.1

