Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3D55DDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbiF1HQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240509AbiF1HQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:16:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD14E2C66F;
        Tue, 28 Jun 2022 00:16:44 -0700 (PDT)
Date:   Tue, 28 Jun 2022 07:16:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656400603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5/+Ar4YGnd6aq7P4hg9ChkQU/fiXmjAv+4Y2F4mV78=;
        b=yNk2VvE/MnXEEu6NM0EQZUGjnX693fzHl5AGZ9SK7O5BQnj2Kd1WKwIcT7WdUlSJeaQxwd
        keZj6cVO4R+F9brLk6kckfcaLKFIF2Oa05f0Tnb+3U1TTLmrk7SifoYH4yuDbu3QN/VbWf
        x914+Gh4k5X9Gg9CY9/+L93IOiTIwTxFmHSfbwQ7C7Z/XtckIr6Cd2HtZCT/WVeBSHGvew
        D0kSXSqzH2Z7tH4uL8xI1VU2y0Kgl6svPtbI18wrHi93l3Mp7QYwawq1uQaqFUIS1mT6Cc
        nzQ6G5Lpoj0DVMcem/JBzJPgtSMbb+U3IDnPrpETmu5rp152pFTJwqy6xTeT6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656400603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5/+Ar4YGnd6aq7P4hg9ChkQU/fiXmjAv+4Y2F4mV78=;
        b=6DyCUyyoIn7Wm0uuZR4QjV60q1qny+O7JIu7/9+d2FfjN248pgeURnxfqvsOx+iMhpqMAb
        lo+J0TMkLvG61KDA==
From:   tip-bot2 for Christian =?utf-8?q?G=C3=B6ttsche?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: only perform capability check on privileged
 operation
Cc:     cgzones@googlemail.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220615152505.310488-1-cgzones@googlemail.com>
References: <20220615152505.310488-1-cgzones@googlemail.com>
MIME-Version: 1.0
Message-ID: <165640060228.4207.13227742093247557593.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Commit-ID:     700a78335fc28a59c307f420857fd2d4521549f8
Gitweb:        https://git.kernel.org/tip/700a78335fc28a59c307f420857fd2d4521=
549f8
Author:        Christian G=C3=B6ttsche <cgzones@googlemail.com>
AuthorDate:    Wed, 15 Jun 2022 17:25:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 28 Jun 2022 09:08:29 +02:00

sched: only perform capability check on privileged operation

sched_setattr(2) issues via kernel/sched/core.c:__sched_setscheduler()
a CAP_SYS_NICE audit event unconditionally, even when the requested
operation does not require that capability / is unprivileged, i.e. for
reducing niceness.
This is relevant in connection with SELinux, where a capability check
results in a policy decision and by default a denial message on
insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to allow
     the task the capability CAP_SYS_NICE, while it does not need it,
     violating the principle of least privilege.

Conduct privilged/unprivileged categorization first and perform a
capable test (and at most once) only if needed.

Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220615152505.310488-1-cgzones@googlemail.com
---
 kernel/sched/core.c | 138 +++++++++++++++++++++++++------------------
 1 file changed, 83 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7234526..d3e2c5a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6974,17 +6974,29 @@ out_unlock:
 EXPORT_SYMBOL(set_user_nice);
=20
 /*
- * can_nice - check if a task can reduce its nice value
+ * is_nice_reduction - check if nice value is an actual reduction
+ *
+ * Similar to can_nice() but does not perform a capability check.
+ *
  * @p: task
  * @nice: nice value
  */
-int can_nice(const struct task_struct *p, const int nice)
+static bool is_nice_reduction(const struct task_struct *p, const int nice)
 {
 	/* Convert nice value [19,-20] to rlimit style value [1,40]: */
 	int nice_rlim =3D nice_to_rlimit(nice);
=20
-	return (nice_rlim <=3D task_rlimit(p, RLIMIT_NICE) ||
-		capable(CAP_SYS_NICE));
+	return (nice_rlim <=3D task_rlimit(p, RLIMIT_NICE));
+}
+
+/*
+ * can_nice - check if a task can reduce its nice value
+ * @p: task
+ * @nice: nice value
+ */
+int can_nice(const struct task_struct *p, const int nice)
+{
+	return is_nice_reduction(p, nice) || capable(CAP_SYS_NICE);
 }
=20
 #ifdef __ARCH_WANT_SYS_NICE
@@ -7263,6 +7275,69 @@ static bool check_same_owner(struct task_struct *p)
 	return match;
 }
=20
+/*
+ * Allow unprivileged RT tasks to decrease priority.
+ * Only issue a capable test if needed and only once to avoid an audit
+ * event on permitted non-privileged operations:
+ */
+static int user_check_sched_setscheduler(struct task_struct *p,
+					 const struct sched_attr *attr,
+					 int policy, int reset_on_fork)
+{
+	if (fair_policy(policy)) {
+		if (attr->sched_nice < task_nice(p) &&
+		    !is_nice_reduction(p, attr->sched_nice))
+			goto req_priv;
+	}
+
+	if (rt_policy(policy)) {
+		unsigned long rlim_rtprio =3D task_rlimit(p, RLIMIT_RTPRIO);
+
+		/* Can't set/change the rt policy: */
+		if (policy !=3D p->policy && !rlim_rtprio)
+			goto req_priv;
+
+		/* Can't increase priority: */
+		if (attr->sched_priority > p->rt_priority &&
+		    attr->sched_priority > rlim_rtprio)
+			goto req_priv;
+	}
+
+	/*
+	 * Can't set/change SCHED_DEADLINE policy at all for now
+	 * (safest behavior); in the future we would like to allow
+	 * unprivileged DL tasks to increase their relative deadline
+	 * or reduce their runtime (both ways reducing utilization)
+	 */
+	if (dl_policy(policy))
+		goto req_priv;
+
+	/*
+	 * Treat SCHED_IDLE as nice 20. Only allow a switch to
+	 * SCHED_NORMAL if the RLIMIT_NICE would normally permit it.
+	 */
+	if (task_has_idle_policy(p) && !idle_policy(policy)) {
+		if (!is_nice_reduction(p, task_nice(p)))
+			goto req_priv;
+	}
+
+	/* Can't change other user's priorities: */
+	if (!check_same_owner(p))
+		goto req_priv;
+
+	/* Normal users shall not reset the sched_reset_on_fork flag: */
+	if (p->sched_reset_on_fork && !reset_on_fork)
+		goto req_priv;
+
+	return 0;
+
+req_priv:
+	if (!capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	return 0;
+}
+
 static int __sched_setscheduler(struct task_struct *p,
 				const struct sched_attr *attr,
 				bool user, bool pi)
@@ -7304,58 +7379,11 @@ recheck:
 	    (rt_policy(policy) !=3D (attr->sched_priority !=3D 0)))
 		return -EINVAL;
=20
-	/*
-	 * Allow unprivileged RT tasks to decrease priority:
-	 */
-	if (user && !capable(CAP_SYS_NICE)) {
-		if (fair_policy(policy)) {
-			if (attr->sched_nice < task_nice(p) &&
-			    !can_nice(p, attr->sched_nice))
-				return -EPERM;
-		}
-
-		if (rt_policy(policy)) {
-			unsigned long rlim_rtprio =3D
-					task_rlimit(p, RLIMIT_RTPRIO);
-
-			/* Can't set/change the rt policy: */
-			if (policy !=3D p->policy && !rlim_rtprio)
-				return -EPERM;
-
-			/* Can't increase priority: */
-			if (attr->sched_priority > p->rt_priority &&
-			    attr->sched_priority > rlim_rtprio)
-				return -EPERM;
-		}
-
-		 /*
-		  * Can't set/change SCHED_DEADLINE policy at all for now
-		  * (safest behavior); in the future we would like to allow
-		  * unprivileged DL tasks to increase their relative deadline
-		  * or reduce their runtime (both ways reducing utilization)
-		  */
-		if (dl_policy(policy))
-			return -EPERM;
-
-		/*
-		 * Treat SCHED_IDLE as nice 20. Only allow a switch to
-		 * SCHED_NORMAL if the RLIMIT_NICE would normally permit it.
-		 */
-		if (task_has_idle_policy(p) && !idle_policy(policy)) {
-			if (!can_nice(p, task_nice(p)))
-				return -EPERM;
-		}
-
-		/* Can't change other user's priorities: */
-		if (!check_same_owner(p))
-			return -EPERM;
-
-		/* Normal users shall not reset the sched_reset_on_fork flag: */
-		if (p->sched_reset_on_fork && !reset_on_fork)
-			return -EPERM;
-	}
-
 	if (user) {
+		retval =3D user_check_sched_setscheduler(p, attr, policy, reset_on_fork);
+		if (retval)
+			return retval;
+
 		if (attr->sched_flags & SCHED_FLAG_SUGOV)
 			return -EINVAL;
=20
