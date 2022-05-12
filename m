Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D145252B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356549AbiELQgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356530AbiELQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:35:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDA1275E7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so8005037wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5LSQF4qQ6PdU2l44s8zh7kHvz3U3R9H2i+FKozzkMrk=;
        b=zn+g1Ycy1XsWOwIRH1IZWmSxoblP7fkC3C+xhRAAZcnQbWJZArprv6QGJwokYaEgI4
         OFjd7l6KuNlcrbz4HNoEWaxKazwlFu6rBI1ebSgc79IBRrEPn1mYEi2rHVgWQeedm4TZ
         89ZCh10ifROHuV/qmJqL1UU4iNigCCVLKvCokb52aSoR/lnP38dl+uDne0gpVVUwRWZs
         gOQJAtUoNAIXFKzAiqEhq6dMXV05Il441S/tO5l4BLMjcj1hmuXlon0+1o3+l/0So3+W
         IUymuBo/d88SX3cij56hjplOgvcLDgmo1t0MrbF4fVZ7p/NgIYq03yr9em8VQIVcGy19
         jdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5LSQF4qQ6PdU2l44s8zh7kHvz3U3R9H2i+FKozzkMrk=;
        b=unkwltldTY174tcwb6jn5+a2Yd79UiTz7TPw16hu/CxqNDgZO4MsZR2kiKvT+4mzAZ
         4rZkskXKJZo9sFncslOSoFZWwtNPLgWzxgSgnIgA+nakSeTXMKLM9aCFB+oH6GrQtBKJ
         tAOEBRW0WOsoteM368D1F7aW0j/asBSfPOgSwNFba67EhKqiFhQ5NwYGpwrv91SIuTWg
         JqpJnwm99asc/DKxv6k+fQa5iAWdDuTecelRWpEiNf+Xbm2ztNwaldbEssaLEDbuqzRk
         HINNJR9wKHJJc5hyzy5EAyfxvrK3du2hW2vr/kzFjrWkkqWalLcUhD/bw4f3Nos26gms
         irGw==
X-Gm-Message-State: AOAM533cDSqEXvF0QcDakI+FzcnxNBnceXdQk4H2m2qOxLEez9lHD1V9
        VSo2coxci9kaoURu8SGAu4VqlQ==
X-Google-Smtp-Source: ABdhPJz42eGyH0dwTt5/MYB8DtEJQeazcoRnR88OzcJR1YmQeSqxE12GDN8WDCVz/BkRBaZMW0HxLQ==
X-Received: by 2002:a5d:6504:0:b0:20c:e8c7:55f7 with SMTP id x4-20020a5d6504000000b0020ce8c755f7mr448731wru.276.1652373355603;
        Thu, 12 May 2022 09:35:55 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:253e:ae0a:544b:2cb1])
        by smtp.gmail.com with ESMTPSA id j25-20020adfa799000000b0020c5253d8dbsm21814wrc.39.2022.05.12.09.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:35:54 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 3/7] sched: Allow sched_{get,set}attr to change latency_nice of the task
Date:   Thu, 12 May 2022 18:35:30 +0200
Message-Id: <20220512163534.2572-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512163534.2572-1-vincent.guittot@linaro.org>
References: <20220512163534.2572-1-vincent.guittot@linaro.org>
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
 kernel/sched/core.c              | 25 +++++++++++++++++++++++++
 tools/include/uapi/linux/sched.h |  4 +++-
 4 files changed, 50 insertions(+), 2 deletions(-)

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
index f2c4589d4dbf..db1e8199e8c8 100644
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
+ * [MIN_LATENCY_NICE..MAX_LATENCY_NICE].
+ *
+ * A task with latency_nice with the value of LATENCY_NICE_MIN can be
+ * taken for a task requiring a lower latency as opposed to the task with
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
index 1f04b815b588..036bd9ff66e9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7200,6 +7200,15 @@ static void __setscheduler_params(struct task_struct *p,
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
+		p->latency_nice = attr->sched_latency_nice;
+	}
 }
 
 /*
@@ -7326,6 +7335,13 @@ static int __sched_setscheduler(struct task_struct *p,
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
 
@@ -7360,6 +7376,9 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
+		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
+		    attr->sched_latency_nice != p->latency_nice)
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		retval = 0;
@@ -7448,6 +7467,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_params(p, attr);
 		__setscheduler_prio(p, newprio);
 	}
+	__setscheduler_latency(p, attr);
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
@@ -7658,6 +7678,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	    size < SCHED_ATTR_SIZE_VER1)
 		return -EINVAL;
 
+	if ((attr->sched_flags & SCHED_FLAG_LATENCY_NICE) &&
+	    size < SCHED_ATTR_SIZE_VER2)
+		return -EINVAL;
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
@@ -7895,6 +7918,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
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

