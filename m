Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1F25252BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356558AbiELQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356552AbiELQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:36:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4011326C8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:36:03 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h16so7345040wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VXuzqJ0yrQ0E5lpmc6uKqNtQ+2mUwLYmw3I0HBBF/Vo=;
        b=I9DkGbpG5XHsPitr9+hwa4ckaIoyIXiLoA+R15tt2BZD7flcgpvCWUcMhzOs3enXpd
         sgFCcM8VtMveMQEgUZYOnP0ZeqdKFYB2fyB5OucwP9ePlq1+2EvNPkpIrN0nPtXeC6HZ
         QtclNehTawAN+nr3pJpoMsuQuAKsD1hD7vSIzbFdCyrh7NMtlWB9dCYPJl5MifH1foo4
         4U3okr9icaZmI7oWa06FuGeoMBF5TF2CodpCAaEFg+6m2co0XJpQXZEqSQEHLYUHCKRu
         s69rE6tnuOIytACON2/VU4r65nGifqFZRzo4JqtW8XRK9Da1ar4UZ+n/9Ow1aEoxcvnx
         lKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VXuzqJ0yrQ0E5lpmc6uKqNtQ+2mUwLYmw3I0HBBF/Vo=;
        b=UH0OgK+tqpq08TkuLd8aIsTWRBW/jgOVpNqUIc0EFjWSzBRUa3F3DgoBg5RsYx+z+K
         Ky8qAqqtVEBBTNAJY77A4FUyiTwii7K3IZFCJTG1dlnDG2vZ++aMeFzci9fUsatPR+qz
         GS9JEQUAnDvDxK+1Xh91Z6h9futyFQ/K09J8mK/82UXvybeSX83eOFpESGFedOszwiKm
         poU+hY+DZA9xrvYsT8wGYlL67/WE9kaMSh85U2OdlIenPdzvK325nnYXbeN8kuOkTltL
         NiJkod3//TydDp+5MGE3Dgif+erpjI7WtfrBssydWvMiXBr88I6x5yi5u+okOYYjuh8b
         hS3A==
X-Gm-Message-State: AOAM531o6BFLHYGKTgDmYvc/b4oHhcJvrpT4IAQASAGBb3FUgnlm+jcz
        9EXqFFrABbIvXLlN/o4bHM/jhQ==
X-Google-Smtp-Source: ABdhPJx8Gv7EJFcJrPdRLrLC/+5oW9TLPHvZQQ/TeTId7dAs9mwAVPaZ5tinjAlplZh/Nr1jFGsJaQ==
X-Received: by 2002:a5d:64a6:0:b0:20c:64ef:c9cc with SMTP id m6-20020a5d64a6000000b0020c64efc9ccmr501674wrp.190.1652373362046;
        Thu, 12 May 2022 09:36:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:253e:ae0a:544b:2cb1])
        by smtp.gmail.com with ESMTPSA id j25-20020adfa799000000b0020c5253d8dbsm21814wrc.39.2022.05.12.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 09:36:01 -0700 (PDT)
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
Subject: [PATCH v2 6/7] sched/fair: Add sched group latency support
Date:   Thu, 12 May 2022 18:35:33 +0200
Message-Id: <20220512163534.2572-7-vincent.guittot@linaro.org>
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

Tasks can set its latency priority which is then used to decide to preempt
the current running entity of the cfs but sched group entities still have
the default latency priority.

Add a latency field in task group to set the latency priority of the group
which will be used against other entity in the parent cfs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

For v1, there were dicussions about the best interface to express some latency
constraints for a cfs group. The weight seems to be specific to the wakeup path
and can't be easily reused elsewhere like EAS or idle cpu selection path.
The current proposal of a latency prio ranging from [0:40] seems the simplest
interface but on the other side, it removes the notion of either having latency
constaint with a negative value or relaxing the latency with positive value;
This is an important and easy to understand difference. So I tend to think that
keeping the latency nice is the easiest way to express if a group has latency
constraint (negative value) or don't care about scheduling latency
(positive value). Using a range will then help to order groups' constraint.

I have studied how we can use a duration but this will mainly provide confusion
to the user because whatever the value, we will never be able to ensure it.


 kernel/sched/core.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c  | 32 ++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 ++++
 3 files changed, 71 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ff020b99625c..95f3ef54447e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10798,6 +10798,30 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 {
 	return sched_group_set_idle(css_tg(css), idle);
 }
+
+static s64 cpu_latency_read_s64(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
+{
+	return css_tg(css)->latency_prio;
+}
+
+static int cpu_latency_write_s64(struct cgroup_subsys_state *css,
+				struct cftype *cft, s64 latency_prio)
+{
+	return sched_group_set_latency(css_tg(css), latency_prio);
+}
+
+static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
+			       struct cftype *cft)
+{
+	return LATENCY_TO_NICE(css_tg(css)->latency_prio);
+}
+
+static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
+				struct cftype *cft, s64 latency_nice)
+{
+	return sched_group_set_latency(css_tg(css), NICE_TO_LATENCY(latency_nice));
+}
 #endif
 
 static struct cftype cpu_legacy_files[] = {
@@ -10812,6 +10836,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency",
+		.read_s64 = cpu_latency_nice_read_s64,
+		.write_s64 = cpu_latency_nice_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
@@ -11029,6 +11058,12 @@ static struct cftype cpu_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = cpu_latency_nice_read_s64,
+		.write_s64 = cpu_latency_nice_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3af74f1a79ca..71c0762491c5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11529,6 +11529,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_prio = DEFAULT_LATENCY_PRIO;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -11627,6 +11628,7 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	}
 
 	se->my_q = cfs_rq;
+	se->latency_weight = sched_latency_to_weight[tg->latency_prio];
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
@@ -11757,6 +11759,36 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	return 0;
 }
 
+int sched_group_set_latency(struct task_group *tg, long latency_prio)
+{
+	int i;
+
+	if (tg == &root_task_group)
+		return -EINVAL;
+
+	if (latency_prio < 0 ||
+	    latency_prio > LATENCY_NICE_WIDTH)
+		return -EINVAL;
+
+	mutex_lock(&shares_mutex);
+
+	if (tg->latency_prio == latency_prio) {
+		mutex_unlock(&shares_mutex);
+		return 0;
+	}
+
+	tg->latency_prio = latency_prio;
+
+	for_each_possible_cpu(i) {
+		struct sched_entity *se = tg->se[i];
+
+		WRITE_ONCE(se->latency_weight, sched_latency_to_weight[latency_prio]);
+	}
+
+	mutex_unlock(&shares_mutex);
+	return 0;
+}
+
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
 void free_fair_sched_group(struct task_group *tg) { }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 831b2c8feff1..0c26bb5a742e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -414,6 +414,8 @@ struct task_group {
 
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
+	/* latency priority of the group. */
+	int			latency_prio;
 
 #ifdef	CONFIG_SMP
 	/*
@@ -527,6 +529,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
+extern int sched_group_set_latency(struct task_group *tg, long latency);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-- 
2.17.1

