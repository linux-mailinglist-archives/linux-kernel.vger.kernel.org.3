Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC16C517277
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376454AbiEBP2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbiEBP17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:27:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFFB13CCD;
        Mon,  2 May 2022 08:24:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gh6so28500015ejb.0;
        Mon, 02 May 2022 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JlRQCvAcuJPfq+J5yVcoCOkpKkMcU56ENlg86d7ai8=;
        b=pJu49czcNYpe0rC6GeFENSl/WLDwHSVM5d56cL3COHRer/SHDhAc6nvpgSRHmPFvJa
         lGmKgJJp0dXvB8UK4fhxFkske3G4yOY3XV4ys3nXHOTCtWQ4qXwAxJuNnjsXGkOENUKx
         MxGdTes95b970fM0J87w17qIpkvZ0bBMq/ONxlF2Fjtg25O/KHkq1Wlo+EferYDSfljS
         vmA0vGWjPEfhO+tDdaEoCThBtKbtLLVZw+CFiWurUOZvHw4wfWQLDl94qRAWtBL0dpEQ
         T1+smn1nrlEAKC+/dB0HI+tFPzIrlZaOvOw+Fn8AfFaqyBrjMOV2ZeU6ym0mAfIfEX84
         byUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JlRQCvAcuJPfq+J5yVcoCOkpKkMcU56ENlg86d7ai8=;
        b=iKJmR7PBa1I2i+8F7zBvbQoirSM/Gi3xqbIfVMVkQw40UBFtIhHCJED593QxxCby37
         xNsvYgHZBUV2vik9vdgxVDvaAQelO0RI2Rr2/3NyV0KWU1yZxnw208Hk02BiuMqLpZzq
         BdWVG3pCK44bF9dgVm4DqbDLCKKtj9gLq5Ee7tWxIx2fRa3Y29LVjFYj/qA9pwQ4zEYZ
         Gx01wELixpNWVldRbYAIooafZgmLvUi6uoBIYKAoAvAAWGZwOtunmt8Z5HUmMGl2AmvS
         ywLSGCJ8ODgfcycHW+CTqyAkFAhv/ol+BKpD3t9maOtjF8pQ9Y9g5RRLjpG8+9/cIM1I
         ECYg==
X-Gm-Message-State: AOAM533iOqoRwPGf5metbpKgyHJI/bv6aPTdBtnWJg++gIGIjVMEsgfy
        1U7ELKrR1jQQGdnO/PFad8EiIcuGG65JTQ==
X-Google-Smtp-Source: ABdhPJzb+5ieXFsu0eXyyU2x+aSBTk3OL+QJNpbY6q1pm/iOpFUlMnHZ617ZOGJbdaq4srMD4470gw==
X-Received: by 2002:a17:907:6daa:b0:6f4:4822:549d with SMTP id sb42-20020a1709076daa00b006f44822549dmr5737046ejc.322.1651505068151;
        Mon, 02 May 2022 08:24:28 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id hx8-20020a170906846800b006f3ef214dd0sm3641947ejc.54.2022.05.02.08.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 08:24:26 -0700 (PDT)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] [RFC PATCH] sched: only perform capability check on privileged operation
Date:   Mon,  2 May 2022 17:24:14 +0200
Message-Id: <20220502152414.110922-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20200904160031.6444-1-cgzones@googlemail.com>
References: <20200904160031.6444-1-cgzones@googlemail.com>
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
v2:
  add is_nice_reduction() to avoid duplicate capable(CAP_SYS_NICE)
  checks via can_nice()
---
 kernel/sched/core.c | 135 +++++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 51 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d575b4914925..b9c1e67af46f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7211,6 +7211,86 @@ static bool check_same_owner(struct task_struct *p)
 	return match;
 }
 
+/*
+ * is_nice_reduction - check if nice value is an actual reduction
+ *
+ * Similar to can_nice() but does not perform a capability check.
+ *
+ * @p: task
+ * @nice: nice value
+ */
+static bool is_nice_reduction(const struct task_struct *p, const int nice)
+{
+	/* Convert nice value [19,-20] to rlimit style value [1,40]: */
+	int nice_rlim = nice_to_rlimit(nice);
+
+	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE));
+}
+
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
+			!is_nice_reduction(p, attr->sched_nice))
+			goto req_priv;
+	}
+
+	if (rt_policy(policy)) {
+		unsigned long rlim_rtprio =
+		task_rlimit(p, RLIMIT_RTPRIO);
+
+		/* Can't set/change the rt policy: */
+		if (policy != p->policy && !rlim_rtprio)
+			goto req_priv;
+
+		/* Can't increase priority: */
+		if (attr->sched_priority > p->rt_priority &&
+			attr->sched_priority > rlim_rtprio)
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
@@ -7252,58 +7332,11 @@ static int __sched_setscheduler(struct task_struct *p,
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
2.36.0

