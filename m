Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA414D65DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbiCKQPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350202AbiCKQPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:15:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DE11D0374
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t11so13651649wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7rhgsqV3KMfKxCS9qLfTFgcLJX3t+C452Rt6S9wGKCk=;
        b=dHnTAZY8lk+sp8PiDY+JePLPNcH5273gsKX+kvojcT9GtJloUQBtNRkBxMCqiNXMZA
         c5QQeLbO4kImju6nmq90MTZaRKMTwE1WfCXJhlaLaMNd5jH2Ek1LYXkQYLDgZxPv1pmH
         FZCrRiGQ0XZ+HGyB+yZrOr00ufpgnYjCsxZQeVw4JJre28hVMEVEdGi5kKy/Te3XpmuO
         DmfGMMfkijgfogN7m2AarkVnv4I/WBOxidgrGGb7lc+Hyyby9wNQpr2OQKgswm5kPBBd
         1x5+GupHlijDYZx7mZFdWqaimDG356ig73s2kZD76uxaMALTBV1Ca8hidvTg/DCIhRgZ
         cXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7rhgsqV3KMfKxCS9qLfTFgcLJX3t+C452Rt6S9wGKCk=;
        b=zSCoiZQjT/ExSo2HyAkqmKagCUW+9H9PgkZZ3ioZBZLvecj7RE9ZjIyQuO0eolcKVV
         wsNbSkXOUxx8j0063szcsYhSqyc0Bx2EzHHTweHeJhoV23MroHRYnGxD/UWo8lKDK5i+
         nvfItixylqULypU/bh0FNAcrf0BRbUesRhbLvyjZLiW1uvVD5vrBf/RET47D3WWbVrML
         zbmrlG0DZmigbeyihhDoGfZFI56Gbe+wXh2kdkK4QayWVn0T+Yqwu05f5v2tGmkstLgA
         fnzTvRw1n6MVja4vU77WfwWySI+/cr1x4lBAyqz8R9RWPn15U2qKvMMDJ+hv6+VrXwi2
         +p2Q==
X-Gm-Message-State: AOAM533nJDgnnHgOX33cDP1YladAdxRpyscZrj4LhDPjrAwke70NxtZG
        Ie+dle/OJAv/n5g03E6mMsASBQ==
X-Google-Smtp-Source: ABdhPJzPsNJ2oenReqzj3KbB6ZJjT/f7ZvPQkRptHu7xaCEh+CTyRWyh6r6Tt00oxY17cc9POYIyrw==
X-Received: by 2002:adf:fb47:0:b0:1ed:9f2c:492e with SMTP id c7-20020adffb47000000b001ed9f2c492emr8013720wrs.196.1647015266504;
        Fri, 11 Mar 2022 08:14:26 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70d9:405c:a1e4:4d23])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm6464137wry.78.2022.03.11.08.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:14:25 -0800 (PST)
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
Subject: [RFC 6/6] sched/fair: Add sched group latency support
Date:   Fri, 11 Mar 2022 17:14:06 +0100
Message-Id: <20220311161406.23497-7-vincent.guittot@linaro.org>
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

Tasks can set its latency priority which is then used to decide to preempt
the current running entity of the cfs but sched group entities still have
the default latency priority.

Add a latency field in task group to set the latency priority of the group
which will be used against other entity in the parent cfs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c  | 32 ++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  4 ++++
 3 files changed, 77 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 547b0da01efe..e0668652dd24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10635,6 +10635,30 @@ static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
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
@@ -10649,6 +10673,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency",
+		.read_s64 = cpu_latency_read_s64,
+		.write_s64 = cpu_latency_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
@@ -10866,6 +10895,18 @@ static struct cftype cpu_files[] = {
 		.read_s64 = cpu_idle_read_s64,
 		.write_s64 = cpu_idle_write_s64,
 	},
+	{
+		.name = "latency",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = cpu_latency_read_s64,
+		.write_s64 = cpu_latency_write_s64,
+	},
+	{
+		.name = "latency.nice",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = cpu_latency_nice_read_s64,
+		.write_s64 = cpu_latency_nice_write_s64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 506c482a0e48..cbccef025089 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11496,6 +11496,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		goto err;
 
 	tg->shares = NICE_0_LOAD;
+	tg->latency_prio = DEFAULT_LATENCY_PRIO;
 
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
@@ -11594,6 +11595,7 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 	}
 
 	se->my_q = cfs_rq;
+	se->latency_weight = sched_latency_to_weight[tg->latency_prio];
 	/* guarantee group entities always have weight */
 	update_load_set(&se->load, NICE_0_LOAD);
 	se->parent = parent;
@@ -11724,6 +11726,36 @@ int sched_group_set_idle(struct task_group *tg, long idle)
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
index dd92aa9c36f9..885d1c809329 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -429,6 +429,8 @@ struct task_group {
 
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
+	/* latency priority of the group. */
+	int			latency_prio;
 
 #ifdef	CONFIG_SMP
 	/*
@@ -542,6 +544,8 @@ extern int sched_group_set_shares(struct task_group *tg, unsigned long shares);
 
 extern int sched_group_set_idle(struct task_group *tg, long idle);
 
+extern int sched_group_set_latency(struct task_group *tg, long latency);
+
 #ifdef CONFIG_SMP
 extern void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next);
-- 
2.17.1

