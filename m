Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B67D4D65D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiCKQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350151AbiCKQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:15:19 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB98818A798
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:14 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so13646416wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+DjhWNCi1uAUKSxL3o4kQa/u0xQ6TtRjRzuu8WmiLaA=;
        b=SL+WZJnQKpD0l7IOGXck34pr1hW6R496L7GYyFu03/z798wBhFlB76Bu6IUwjmvZfj
         lJ3anW+iAlNt8KPB6/NbTRTwT+rZEPi3Rae1oXXiV/KNNzbB86EfqLn83VSGRO3VNLra
         yhkX7jlBCKuaYv8qQe4U5enUppkW7wT/7Elbtaw68HFwpYz2VSCwS3aYh5fDHdfG6bAm
         9MnLglDvVLr6nxBRefcerGlP+KjTJwGAA0WaHy+Cn6raBL3Y4a4j4EcALzv4/QgxuH12
         Jpbq4/4LGg2XJm5slMrBm5X4cyQXoo9os/bpa9uy5Qn+gxmr1gCukxRWw8Cn+oybayDY
         UPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+DjhWNCi1uAUKSxL3o4kQa/u0xQ6TtRjRzuu8WmiLaA=;
        b=JH/mUnYZLG8tQhwP9dpc+vzXDQ5f6lZcIB7zgyC4Kza/8yYd3uIizG/mX1/M68Sm8R
         aZ0Cu0n20tqHvmComiZRnagNA+i+xPWeRAqlCD33VTxM9uwM3t3z4H4tRFYey8DWcppG
         Gc9TYefKHzlO1s25OBn7jEpdRAyl5Z2a2kVCK+dbrAEGJ7d9dxFUhQKToKbXEZCs07ag
         fPR4siFo9v97bD6HAkfsQkynXSL23Cuw2XaAaAwdCBeiODRiNvrUQ5ffJVGStu9xQ8hT
         +W+qeECF4pt3NbnLqT1U7gun+ThtW2BPXqJ7cNFizL6zsStYAakqCqjV4Y6pfG5CyGEd
         4avg==
X-Gm-Message-State: AOAM530SQbIXwkDWjDgcgUPBdzd7xx/CV8Emo8Sf/3l4XefR4J2GOYgk
        Ke7B41RM8TT3+HjVn/BfOXwAJA==
X-Google-Smtp-Source: ABdhPJyb3fS6K92KyiMuBYFrxj8LkQPEJS4vXwEepSqukiGFEZ2HXo05KkhjqUq9oZ91TVJ8ZARRUw==
X-Received: by 2002:a5d:500e:0:b0:1f0:2509:ee3f with SMTP id e14-20020a5d500e000000b001f02509ee3fmr8180955wrt.381.1647015253226;
        Fri, 11 Mar 2022 08:14:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70d9:405c:a1e4:4d23])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm6464137wry.78.2022.03.11.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:14:12 -0800 (PST)
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
Subject: [PATCH 1/6] sched: Introduce latency-nice as a per-task attribute
Date:   Fri, 11 Mar 2022 17:14:01 +0100
Message-Id: <20220311161406.23497-2-vincent.guittot@linaro.org>
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

Latency-nice indicates the latency requirements of a task with respect
to the other tasks in the system. The value of the attribute can be within
the range of [-20, 19] both inclusive to be in-line with the values just
like task nice values.

latency_nice = -20 indicates the task to have the least latency as
compared to the tasks having latency_nice = +19.

The latency_nice may affect only the CFS SCHED_CLASS by getting
latency requirements from the userspace.

Additionally, add debugging bits for newly added latency_nice attribute.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/debug.c  |  1 +
 kernel/sched/sched.h  | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 508b91d57470..2aa889a59054 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -779,6 +779,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
+	int				latency_nice;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 102d6f70e84d..5d76a8927888 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1043,6 +1043,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
+	P(latency_nice);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9b33ba9c3c42..456ad2159eb1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -105,6 +105,24 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
  */
 #define NS_TO_JIFFIES(TIME)	((unsigned long)(TIME) / (NSEC_PER_SEC / HZ))
 
+/*
+ * Latency nice is meant to provide scheduler hints about the relative
+ * latency requirements of a task with respect to other tasks.
+ * Thus a task with latency_nice == 19 can be hinted as the task with no
+ * latency requirements, in contrast to the task with latency_nice == -20
+ * which should be given priority in terms of lower latency.
+ */
+#define MAX_LATENCY_NICE	19
+#define MIN_LATENCY_NICE	-20
+
+#define LATENCY_NICE_WIDTH	\
+	(MAX_LATENCY_NICE - MIN_LATENCY_NICE + 1)
+
+/*
+ * Default tasks should be treated as a task with latency_nice = 0.
+ */
+#define DEFAULT_LATENCY_NICE	0
+
 /*
  * Increase resolution of nice-level calculations for 64-bit architectures.
  * The extra resolution improves shares distribution and load balancing of
-- 
2.17.1

