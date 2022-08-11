Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0721158F5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiHKB62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiHKB6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:58:19 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385E783BFA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:58:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id ix21-20020a170902f81500b0016ee5379fe5so10681009plb.18
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=FLncFBunoqFcWEPnYmxStXwzz8mHRnlZmLkagUNSOoE=;
        b=ZoWzBtHNZfLzwYxoOaaSQFc88PCtwTp0I8p0pUNH98wj5LmjktXdLBXFs2N+1mebUY
         4ncMldmXvDjClsmdWV+rgw1ED6bNcby2YvFzEDAbUXFMFMnDwXzw6RIcVXcrE40nu4tH
         Ow2MtQKbdzAOKmdsUUt3vI7evExnqKrm5YfJC3WEMwhHvIMbhOxAwhC+Eg1Ipy8pWbdY
         kqIuKvCNbEd28RSSY1XQ+d1l2V7M0oxbO/z0whQTkSo5aFJpTg8MXPKCJkuojx02R2wN
         UtV6aSgdpyxxiaoKo9K/307c0kfGDu5LWFuqEzJBwLABKl9Xp1Qksi+zdDK/xApqFRzZ
         WgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=FLncFBunoqFcWEPnYmxStXwzz8mHRnlZmLkagUNSOoE=;
        b=s7dgx497oVrxEcVykMiY1KEssv9NsCKhdphBHL81OPNL5b+aCKIc7xxFoBV/5SOFyz
         XxJO+ywR0PXuT/QvGmPVD/MQrzJVeCpGznaK2Y3DuIkS3lm8U6mXNZm90TrJw7pWn2zx
         m4hZqX8PsNbBBuqLpqvNg/W/UNucuRB+XjVXMhfbFOrM3uEfdsEXpyK5H7KVBDP9CDSL
         tBqqUX0ch6nb4V+M5z3V90s/U4ElqNQc2dn3NU9gKkpI0XY+hcRnhJLlP+QzPmTZqpPK
         7L56n+Ah2SSJQ/elLdyIf0cY4b4UfXeOVI1Keu/UYElK1+FMjskT/m2VpH1xyvbKRQin
         S8CA==
X-Gm-Message-State: ACgBeo2fH+g3pDutYqDE/rqIpRnGxVU86N49RJ4Zofr5iVvIMSb99+tH
        kBxJHHCW6BLSDNHLdUmE/KpaotBaTLGsIIMgDhUGB0qAHyXpYe5hIMue6EFBqpQacyia7hcM92H
        VGmsq1yCP5Pp0oYGOw5kETkji2TCt7ydAWBK9j25ybtq6Rt6gr6wIFhzRtfEh84wp1vI+xNc=
X-Google-Smtp-Source: AA6agR4egKetaOgWYLlacK/77mh81m5ohq/10eV6Fc09v5+aGNfvtI07hg/Oc8EAXVE22ylGY4BCcdsOrAWs
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a62:79d1:0:b0:52f:3fda:c3e1 with SMTP id
 u200-20020a6279d1000000b0052f3fdac3e1mr16562011pfc.71.1660183097609; Wed, 10
 Aug 2022 18:58:17 -0700 (PDT)
Date:   Thu, 11 Aug 2022 01:57:58 +0000
In-Reply-To: <20220811015758.3001641-1-jstultz@google.com>
Message-Id: <20220811015758.3001641-3-jstultz@google.com>
Mime-Version: 1.0
References: <20220811015758.3001641-1-jstultz@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [RFC][PATCH 2/2] softirq: defer softirq processing to ksoftirqd if
 CPU is busy with RT
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        "Connor O'Brien" <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        "J . Avila" <elavila@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavankumar Kondeti <pkondeti@codeaurora.org>

Defer the softirq processing to ksoftirqd if a RT task is
running or queued on the current CPU. This complements the RT
task placement algorithm which tries to find a CPU that is not
currently busy with softirqs.

Currently NET_TX, NET_RX, BLOCK and TASKLET softirqs are only
deferred as they can potentially run for long time.

Additionally, this patch stubs out ksoftirqd_running() logic,
in the CONFIG_RT_SOFTIRQ_OPTIMIZATION case, as deferring
potentially long-running softirqs will cause the logic to not
process shorter-running softirqs immediately. By stubbing it out
the potentially long running softirqs are deferred, but the
shorter running ones can still run immediately.

This patch includes folded-in fixes by:
  Lingutla Chandrasekhar <clingutla@codeaurora.org>
  Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
  J. Avila <elavila@google.com>

Cc: John Dias <joaodias@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Rick Yiu <rickyiu@google.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Chris Redpath <chris.redpath@arm.com>,
Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
[satyap@codeaurora.org: trivial merge conflict resolution.]
Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
[elavila: Port to mainline, squash with bugfix]
Signed-off-by: J. Avila <elavila@google.com>
[jstultz: Rebase to linus/HEAD, minor rearranging of code,
 included bug fix Reported-by: Qais Yousef <qais.yousef@arm.com> ]
Signed-off-by: John Stultz <jstultz@google.com>
---
 include/linux/sched.h | 10 ++++++++++
 kernel/sched/cpupri.c | 13 +++++++++++++
 kernel/softirq.c      | 25 +++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758..4a12e638b694 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1814,6 +1814,16 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
+
+#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
+extern bool cpupri_check_rt(void);
+#else
+static inline bool cpupri_check_rt(void)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index fa9ce9d83683..18dc75d16951 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -64,6 +64,19 @@ static int convert_prio(int prio)
 	return cpupri;
 }
 
+#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
+/*
+ * cpupri_check_rt - check if CPU has a RT task
+ * should be called from rcu-sched read section.
+ */
+bool cpupri_check_rt(void)
+{
+	int cpu = raw_smp_processor_id();
+
+	return cpu_rq(cpu)->rd->cpupri.cpu_to_pri[cpu] > CPUPRI_NORMAL;
+}
+#endif
+
 static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 				struct cpumask *lowest_mask, int idx)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 92fa82400a80..b4f879cd421d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -87,6 +87,7 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
+#ifndef CONFIG_RT_SOFTIRQ_OPTIMIZATION
 /*
  * If ksoftirqd is scheduled, we do not want to process pending softirqs
  * right now. Let ksoftirqd handle this at its own rate, to get fairness,
@@ -101,6 +102,9 @@ static bool ksoftirqd_running(unsigned long pending)
 		return false;
 	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
 }
+#else
+#define ksoftirqd_running(pending) (false)
+#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 DEFINE_PER_CPU(int, hardirqs_enabled);
@@ -532,6 +536,17 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
+static __u32 softirq_deferred_for_rt(__u32 *pending)
+{
+	__u32 deferred = 0;
+
+	if (cpupri_check_rt()) {
+		deferred = *pending & LONG_SOFTIRQ_MASK;
+		*pending &= ~LONG_SOFTIRQ_MASK;
+	}
+	return deferred;
+}
+
 asmlinkage __visible void __softirq_entry __do_softirq(void)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
@@ -539,6 +554,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
 	bool in_hardirq;
+	__u32 deferred;
 	__u32 pending;
 	int softirq_bit;
 
@@ -551,13 +567,15 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 	pending = local_softirq_pending();
 
+	deferred = softirq_deferred_for_rt(&pending);
 	softirq_handle_begin();
+
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	set_softirq_pending(0);
+	set_softirq_pending(deferred);
 	__this_cpu_write(active_softirqs, pending);
 
 	local_irq_enable();
@@ -596,13 +614,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	local_irq_disable();
 
 	pending = local_softirq_pending();
+	deferred = softirq_deferred_for_rt(&pending);
+
 	if (pending) {
 		if (time_before(jiffies, end) && !need_resched() &&
 		    --max_restart)
 			goto restart;
+	}
 
+	if (pending | deferred)
 		wakeup_softirqd();
-	}
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-- 
2.37.1.559.g78731f0fdb-goog

