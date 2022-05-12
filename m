Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690AC5252B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356529AbiELQf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356328AbiELQfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:35:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB91CFC7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i5so7995141wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQbo4HgFP6vPqhCDxYWNs5lOeo46it0h0h0zVYo9+RA=;
        b=jmK+Bau6i8TmbsAapzlpQp3nEwP90D81o13Pj+VeuicGZ97JDtBtjs2+6P2X0B4UxG
         x1fWoTDDblUTr3pGFWF923Ab0FvZ5j7Gau8sIQR52XIapY4/bNZKRgEnIWPdugjwzje1
         Nmay/3mQA55GVh0SDFs5KDIX+Wv9gMYo/GWbqBo5HBdIdN9QSQfr3SKRqkbZKBdQkL05
         6S1bYOa/JsE3YKmJka7bqh08yNdXUh6SK81flRsSNnyIb2cvrhqQKbjHqx9flNHGpiq0
         wxTApQF/i9PgKuAFjvF0nv/4kM7lD+xKPtAYO9nClV+Sv8d20h4LpwsmUtb4pWplMKWC
         I7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQbo4HgFP6vPqhCDxYWNs5lOeo46it0h0h0zVYo9+RA=;
        b=7VF5nC9OvraZujHRzkzUavX0gX9DuDZ2Hoxyqe80Wm8gmo6iKk0xjvVDvxGeIVU0O6
         Xjw/+Pf9bFMJWWeC/b0K07g5dDSwHcNcvnON0idAQidBXfOBzrRHBZTpf7lKtgSIgO74
         onDk9wWG44cl7lDx9S8wOt8FPZHzGEMPqM+/yyaOwsnQ5almESRqAHfJGud/UGj1U8Uy
         K1s+Oda4pwUzbuQhjNZaDuJsf4YOx9oU7iFnuF5VQg4rxVmNuj0EEVEG1CU9dLKFTxci
         eFD6s1SXN05QcgcwB9fd8dk17Gt7QdAkO1AaLpy1LEiAApQjYynQHHcI18nnrO5JwMBM
         kBkQ==
X-Gm-Message-State: AOAM53381K0z5chnAaFSF1QAeyrVTPXlpfiZ7xvXXYb0MQhHLfNsc0lL
        7m821Stb4S3CnSSv80PEZ7E4ng==
X-Google-Smtp-Source: ABdhPJwQvyD9t7CshfMjKcs1Vp2NMWg2mbFbRHh1ugJqD7+x+tZcb4WUP3q0pUx8kXSBxLsqrLlODA==
X-Received: by 2002:a5d:4711:0:b0:20c:d5e0:1971 with SMTP id y17-20020a5d4711000000b0020cd5e01971mr444995wrq.245.1652373351400;
        Thu, 12 May 2022 09:35:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:253e:ae0a:544b:2cb1])
        by smtp.gmail.com with ESMTPSA id j25-20020adfa799000000b0020c5253d8dbsm21814wrc.39.2022.05.12.09.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:35:50 -0700 (PDT)
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
Subject: [PATCH v2 1/7] sched: Introduce latency-nice as a per-task attribute
Date:   Thu, 12 May 2022 18:35:28 +0200
Message-Id: <20220512163534.2572-2-vincent.guittot@linaro.org>
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
[rebase - minor fixes]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/debug.c  |  1 +
 kernel/sched/sched.h  | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a27316f5f737..34c6c9c2797c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -775,6 +775,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
+	int				latency_nice;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index bb3d63bdf4ae..a3f7876217a6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1042,6 +1042,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
+	P(latency_nice);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4784898e8f83..271ecd37c13d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -117,6 +117,24 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
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

