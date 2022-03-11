Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C914D65D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348843AbiCKQPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350154AbiCKQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:15:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DC2188861
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso5920826wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0fsP3DO6qEug2CZV2Rozajvdffjtp4rs82zcMXC5MzU=;
        b=jYSCxMOgOyBjwOjzHvqFUJmoXxn++ufnpsdxt93OinSWe8HE5yTH+y76KA26mAXNZF
         QpT4zLOGpoKQBl1/VGF4IzxRRQolJC8WJqwNneOzYBUQz+SWoyrq6xUXmYLjkgbJH8LR
         PhvEPPFVUpd7vFRS/uV67SO1D3rQqRDK42xSaQacnrFLgnCN7sxiUB6en2qaZY4zrqFh
         9Jd36H/wJXPbFiVqMInkbZShUgZqYnBOtov4ej1ndfbCFpgjafHUI3Om/zyD8IaY+5vc
         efKSAZCdFv2TrdkoSnXomwXDNR15V3pl2jnHtiy064h3spP44rm/nBIweB4fWUHSd2/4
         oTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0fsP3DO6qEug2CZV2Rozajvdffjtp4rs82zcMXC5MzU=;
        b=ps58wog+8T/rVHEfUJyEWqiOD/1Wwosegrnn5NKf+Q0ppWJVJcVOu4RBC/YI9kPiBN
         2XP+cMTfkBfjNu8ltORRic5AXh3RDrbBISozcqNy+lyPKfAhjAUIgwiCLQY7SLgGFIaa
         ToADPWosp3OpD1sJ6gDJrLAEuFUoB7Yov34e7a6RLgIpOm1VjPSSnTG4MdFOcXpIaHI8
         XwyWT0UB4kF5N2xiV0d9usUepDiza1S7LHELiPHkX1a2rDnwOef5w9gZv17k37qMG6nK
         /wX87oFH8WikYc+ICf72b5WCy/t/q+2EK903aAk6r9oNiVXMTZhBTT10NBkHd3HAmYH/
         rV+g==
X-Gm-Message-State: AOAM5339CswjOchR3shxpebaO0+d0D0V7PC52Z56Mg7EL3Z+6QTfjKrV
        /TW1rhChakUnPLIRDRLRK6iKmg==
X-Google-Smtp-Source: ABdhPJwhWx3LwiFdTcMMaCokFsSLpsM42EhBXcBR6CyF1h6KqCWOgRi7A96jxMKq//S9HTua+eNoxw==
X-Received: by 2002:a7b:c3d5:0:b0:389:a49f:c7e6 with SMTP id t21-20020a7bc3d5000000b00389a49fc7e6mr16156212wmj.99.1647015257151;
        Fri, 11 Mar 2022 08:14:17 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70d9:405c:a1e4:4d23])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm6464137wry.78.2022.03.11.08.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:14:16 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/6] sched: Allow sched_{get,set}attr to change latency_nice of the task
Date:   Fri, 11 Mar 2022 17:14:03 +0100
Message-Id: <20220311161406.23497-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220311161406.23497-1-vincent.guittot@linaro.org>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Introduce the latency_nice attribute to sched_attr and provide a
mechanism to change the value with the use of sched_setattr/sched_getattr
syscall.

Also add new flag "SCHED_FLAG_LATENCY_NICE" to hint the change in
latency_nice of the task on every sched_setattr syscall.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase and add a dedicated __setscheduler_latency ]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/uapi/linux/sched.h       |  4 +++-
 include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
 kernel/sched/core.c              | 26 ++++++++++++++++++++++++++
 tools/include/uapi/linux/sched.h |  4 +++-
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..b2e932c25be6 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -132,6 +132,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_NICE		0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -143,6 +144,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_NICE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index f2c4589d4dbf..0aa4e3b6ed59 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -10,6 +10,7 @@ struct sched_param {
 
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
 #define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
+#define SCHED_ATTR_SIZE_VER2	60	/* add: latency_nice */
 
 /*
  * Extended scheduling parameters data structure.
@@ -98,6 +99,22 @@ struct sched_param {
  * scheduled on a CPU with no more capacity than the specified value.
  *
  * A task utilization boundary can be reset by setting the attribute to -1.
+ *
+ * Latency Tolerance Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes allows to specify the relative latency
+ * requirements of a task with respect to the other tasks running/queued in the
+ * system.
+ *
+ * @ sched_latency_nice	task's latency_nice value
+ *
+ * The latency_nice of a task can have any value in a range of
+ * [LATENCY_NICE_MIN..LATENCY_NICE_MAX].
+ *
+ * A task with latency_nice with the value of LATENCY_NICE_MIN can be
+ * taken for a task with lower latency requirements as opposed to the task with
+ * higher latency_nice.
  */
 struct sched_attr {
 	__u32 size;
@@ -120,6 +137,8 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	/* latency requirement hints */
+	__s32 sched_latency_nice;
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 157eef880d1d..3edba1a38ecb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7219,6 +7219,16 @@ static void __setscheduler_params(struct task_struct *p,
 	p->rt_priority = attr->sched_priority;
 	p->normal_prio = normal_prio(p);
 	set_load_weight(p, true);
+
+}
+
+static void __setscheduler_latency(struct task_struct *p,
+		const struct sched_attr *attr)
+{
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
+		p->latency_prio = NICE_TO_LATENCY(attr->sched_latency_nice);
+		set_latency_weight(p);
+	}
 }
 
 /*
@@ -7345,6 +7355,13 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
+		if (attr->sched_latency_nice > MAX_LATENCY_NICE)
+			return -EINVAL;
+		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
+			return -EINVAL;
+	}
+
 	if (pi)
 		cpuset_read_lock();
 
@@ -7379,6 +7396,9 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
+		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
+		    attr->sched_latency_nice != p->latency_nice)
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		retval = 0;
@@ -7467,6 +7487,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_params(p, attr);
 		__setscheduler_prio(p, newprio);
 	}
+	__setscheduler_latency(p, attr);
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
@@ -7677,6 +7698,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	    size < SCHED_ATTR_SIZE_VER1)
 		return -EINVAL;
 
+	if ((attr->sched_flags & SCHED_FLAG_LATENCY_NICE) &&
+	    size < SCHED_ATTR_SIZE_VER2)
+		return -EINVAL;
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
@@ -7914,6 +7938,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
+	kattr.sched_latency_nice = p->latency_nice;
+
 #ifdef CONFIG_UCLAMP_TASK
 	/*
 	 * This could race with another potential updater, but this is fine
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 3bac0a8ceab2..ecc4884bfe4b 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -132,6 +132,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_NICE		0X80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -143,6 +144,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_NICE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
-- 
2.17.1

