Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0C04D2437
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350750AbiCHW0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236364AbiCHW0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:26:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E14583B8;
        Tue,  8 Mar 2022 14:25:24 -0800 (PST)
Date:   Tue, 08 Mar 2022 22:25:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646778323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QB/pjbswHVZkoslsBgW+33JDvfUolZDAradLFmM+WE=;
        b=FUk+Unsgm6yMlTn4npOufVbejd76OW4xZxU4uBZUtbv+Mnc1PNs9t3f/X81MFiElYidqA2
        anlyGagMKAASDHeSSb4+1ZUdjdAJfiWLcLq6DNkZqdimWgrQjBYnCyMgwwavTbej6dW+og
        4bW/lI00GpngshnOGQnOA6qf0CqkQ/UaR+hg3j3E/KOtH1C64A13Cl1AiBcgKvEbwv15Ao
        xwb/RikRY8SNQgjohYYP9rNctzaGRyqiHfSdeY+6h/iCIlXj/jQkQfx5AbvSdBSvqenyNN
        xYD93XkJ5RWn4IozJ4RLOjrz4QoqyTwzOfJ7H4vDtuu1tBmQIiZ6Xs7pvU78ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646778323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QB/pjbswHVZkoslsBgW+33JDvfUolZDAradLFmM+WE=;
        b=F5btkqwLMAFYwT4t5gmalcMCm3E6DVf2G3U1BvJKpQ/gYi/Cog+A4lSeWZ+MPY3fr/ub7b
        hAQQVCg61gS3SlBw==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Merge dl_task_can_attach() and
 dl_cpu_busy()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220302183433.333029-4-dietmar.eggemann@arm.com>
References: <20220302183433.333029-4-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <164677832223.16921.15292131794875687369.tip-bot2@tip-bot2>
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

Commit-ID:     772b6539fdda31462cc08368e78df60b31a58bab
Gitweb:        https://git.kernel.org/tip/772b6539fdda31462cc08368e78df60b31a58bab
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 02 Mar 2022 19:34:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 16:08:39 +01:00

sched/deadline: Merge dl_task_can_attach() and dl_cpu_busy()

Both functions are doing almost the same, that is checking if admission
control is still respected.

With exclusive cpusets, dl_task_can_attach() checks if the destination
cpuset (i.e. its root domain) has enough CPU capacity to accommodate the
task.
dl_cpu_busy() checks if there is enough CPU capacity in the cpuset in
case the CPU is hot-plugged out.

dl_task_can_attach() is used to check if a task can be admitted while
dl_cpu_busy() is used to check if a CPU can be hotplugged out.

Make dl_cpu_busy() able to deal with a task and use it instead of
dl_task_can_attach() in task_can_attach().

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20220302183433.333029-4-dietmar.eggemann@arm.com
---
 kernel/sched/core.c     | 13 ++++++----
 kernel/sched/deadline.c | 52 ++++++++++------------------------------
 kernel/sched/sched.h    |  3 +--
 3 files changed, 24 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d342c4c..68736d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8805,8 +8805,11 @@ int task_can_attach(struct task_struct *p,
 	}
 
 	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
-					      cs_cpus_allowed))
-		ret = dl_task_can_attach(p, cs_cpus_allowed);
+					      cs_cpus_allowed)) {
+		int cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
+
+		ret = dl_cpu_busy(cpu, p);
+	}
 
 out:
 	return ret;
@@ -9090,8 +9093,10 @@ static void cpuset_cpu_active(void)
 static int cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		if (dl_cpu_busy(cpu))
-			return -EBUSY;
+		int ret = dl_cpu_busy(cpu, NULL);
+
+		if (ret)
+			return ret;
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 81bf976..de677b1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2992,41 +2992,6 @@ bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
 }
 
 #ifdef CONFIG_SMP
-int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed)
-{
-	unsigned long flags, cap;
-	unsigned int dest_cpu;
-	struct dl_bw *dl_b;
-	bool overflow;
-	int ret;
-
-	dest_cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
-
-	rcu_read_lock_sched();
-	dl_b = dl_bw_of(dest_cpu);
-	raw_spin_lock_irqsave(&dl_b->lock, flags);
-	cap = dl_bw_capacity(dest_cpu);
-	overflow = __dl_overflow(dl_b, cap, 0, p->dl.dl_bw);
-	if (overflow) {
-		ret = -EBUSY;
-	} else {
-		/*
-		 * We reserve space for this task in the destination
-		 * root_domain, as we can't fail after this point.
-		 * We will free resources in the source root_domain
-		 * later on (see set_cpus_allowed_dl()).
-		 */
-		int cpus = dl_bw_cpus(dest_cpu);
-
-		__dl_add(dl_b, p->dl.dl_bw, cpus);
-		ret = 0;
-	}
-	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
-	rcu_read_unlock_sched();
-
-	return ret;
-}
-
 int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 				 const struct cpumask *trial)
 {
@@ -3048,7 +3013,7 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-bool dl_cpu_busy(unsigned int cpu)
+int dl_cpu_busy(int cpu, struct task_struct *p)
 {
 	unsigned long flags, cap;
 	struct dl_bw *dl_b;
@@ -3058,11 +3023,22 @@ bool dl_cpu_busy(unsigned int cpu)
 	dl_b = dl_bw_of(cpu);
 	raw_spin_lock_irqsave(&dl_b->lock, flags);
 	cap = dl_bw_capacity(cpu);
-	overflow = __dl_overflow(dl_b, cap, 0, 0);
+	overflow = __dl_overflow(dl_b, cap, 0, p ? p->dl.dl_bw : 0);
+
+	if (!overflow && p) {
+		/*
+		 * We reserve space for this task in the destination
+		 * root_domain, as we can't fail after this point.
+		 * We will free resources in the source root_domain
+		 * later on (see set_cpus_allowed_dl()).
+		 */
+		__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
+	}
+
 	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 	rcu_read_unlock_sched();
 
-	return overflow;
+	return overflow ? -EBUSY : 0;
 }
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4dfc3b0..0720cf0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -324,9 +324,8 @@ extern void __setparam_dl(struct task_struct *p, const struct sched_attr *attr);
 extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
-extern int  dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern bool dl_cpu_busy(unsigned int cpu);
+extern int  dl_cpu_busy(int cpu, struct task_struct *p);
 
 #ifdef CONFIG_CGROUP_SCHED
 
