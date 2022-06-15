Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B862354CCA2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349561AbiFOPZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbiFOPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:25:14 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF202F03F;
        Wed, 15 Jun 2022 08:25:13 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me5so23996307ejb.2;
        Wed, 15 Jun 2022 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tkasiz2VdFEx0wIyx22YEN0VIlDwF9mGn+ZZCWxv0X4=;
        b=Ej3+3lHJkoqrYCERFbBloJWL7x0gtbiAOHIPt6xVfXz4N1H4YJxPnXR9311KhRuNfA
         1otorx9Rk1Bivv5kEkcha+wFfp0O+s4SdEyvvrcSz3euOc2TY+Ggp6Qwvp33ProckBkS
         xerfFMqKAmD4fh6qx3THmCtQrnNk0wJXnzFOpg+UTh4CfM5rf4Ynypcjk2XAZxMOBKdr
         ZEyIqLfv0mEGjQebnTr0r78N3wLS51eyhewYAknPGbFjZMhx3GeuUFxZcEUJTKhfKAmv
         GVD5RhwkzS+LqbBenZ2b5wIVYhjGVWlKk05ajsKrPLNGRV+9tmvsGbf1iJmdxFSADzaB
         XNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tkasiz2VdFEx0wIyx22YEN0VIlDwF9mGn+ZZCWxv0X4=;
        b=4a/Qp4Dhu9kzF6FHMDL20p22OfPIinD+slOOFvxzyNE9t6sBFxFxte8exIzYTaz5l/
         yA30F2p4i9rTdEL5Jjg8dmmNh/UGBRWpj6UNz4TokIFBRE6xU9EkHsGCUJ3hMuQZMMYH
         sy3077QsfUOlLGRmP01vF13JfCcEeaMeqUYSf3rzmCWBYxPe/lwqW8PP8EnZtu/ExzM+
         XWlrd0f/aBk/nMb2aOvOvEQGzZh4clDMpfUrpey2R1imNyJLJ074rpnQhfn16UjbZ5ew
         RaGUoHK3GgphJtY10nCDZFC9Afx0h0cODr6m2HzPBOSX8emV6JmxVHPYf9r8+DNM2mEV
         PtQA==
X-Gm-Message-State: AJIora80E4KRMkU5GsmRjHpuIuhoe0cDhNhQZ/TQSBch7W6VeIiY5rK6
        uFkJfubcPN2s8Cl+WbRNF/UFNmMStaQcSA==
X-Google-Smtp-Source: AGRyM1uaw/xtibq0ndbannqRH/v9yCjRHCO8+w5IQ7wp20/tIAiwWj7HTOqMwS6lHcLgs14FDRxUwA==
X-Received: by 2002:a17:907:1694:b0:716:14a4:fba with SMTP id hc20-20020a170907169400b0071614a40fbamr340602ejc.290.1655306711486;
        Wed, 15 Jun 2022 08:25:11 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id f2-20020a056402004200b0042617ba6396sm9567336edu.32.2022.06.15.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:25:10 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] [RFC PATCH] sched: only perform capability check on privileged operation
Date:   Wed, 15 Jun 2022 17:25:04 +0200
Message-Id: <20220615152505.310488-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220502152414.110922-1-cgzones@googlemail.com>
References: <20220502152414.110922-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  incorporate feedback from Peter Zijlstra
  - use is_nice_reduction() in can_nice()
  - adjust indentation
v2:
  add is_nice_reduction() to avoid duplicate capable(CAP_SYS_NICE)
  checks via can_nice()
---
 kernel/sched/core.c | 138 ++++++++++++++++++++++++++------------------
 1 file changed, 83 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bfa7452ca92e..c3647db8872d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6968,17 +6968,29 @@ void set_user_nice(struct task_struct *p, long nice)
 EXPORT_SYMBOL(set_user_nice);
 
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
 	int nice_rlim = nice_to_rlimit(nice);
 
-	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE) ||
-		capable(CAP_SYS_NICE));
+	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE));
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
 
 #ifdef __ARCH_WANT_SYS_NICE
@@ -7257,6 +7269,69 @@ static bool check_same_owner(struct task_struct *p)
 	return match;
 }
 
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
+		unsigned long rlim_rtprio = task_rlimit(p, RLIMIT_RTPRIO);
+
+		/* Can't set/change the rt policy: */
+		if (policy != p->policy && !rlim_rtprio)
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
@@ -7298,58 +7373,11 @@ static int __sched_setscheduler(struct task_struct *p,
 	    (rt_policy(policy) != (attr->sched_priority != 0)))
 		return -EINVAL;
 
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
-			unsigned long rlim_rtprio =
-					task_rlimit(p, RLIMIT_RTPRIO);
-
-			/* Can't set/change the rt policy: */
-			if (policy != p->policy && !rlim_rtprio)
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
+		retval = user_check_sched_setscheduler(p, attr, policy, reset_on_fork);
+		if (retval)
+			return retval;
+
 		if (attr->sched_flags & SCHED_FLAG_SUGOV)
 			return -EINVAL;
 
-- 
2.36.1

