Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61A648C62A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354161AbiALOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:39:57 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:15587 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344321AbiALOj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641998396; x=1673534396;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=iCgUxcPRWgRfarCkwn197Zs65Kz++fhiEjcJLIhUBEM=;
  b=FTw4liqS6ZgGKLKw+7/tiIfNIeplPky+rR05ZIArR2ijS9xlyXlFUGqD
   FwQFksm+vOHBrw01bA1XI7a+oJqCE4m144kbUBAJjSLCL846doOwO+gTL
   oZglCZsQt8wloDQfrg6Efr3pPc/SezKAXndswPd8p/nMV37idixeejAti
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Jan 2022 06:39:55 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 06:39:55 -0800
Received: from hu-ctheegal-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 12 Jan 2022 06:39:51 -0800
From:   Chitti Babu Theegala <quic_ctheegal@quicinc.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <joel@joelfernandes.org>
CC:     <linux-arm-msm@vger.kernel.org>, <quic_lingutla@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_rjendra@quicinc.com>,
        "Chitti Babu Theegala" <quic_ctheegal@quicinc.com>
Subject: [PATCH] sched/fair: Prefer small idle cores for forkees
Date:   Wed, 12 Jan 2022 20:09:02 +0530
Message-ID: <20220112143902.13239-1-quic_ctheegal@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newly forked threads don't have any useful utilization data yet and
it's not possible to forecast their impact on energy consumption.
These forkees (though very small, most times) end up waking big
cores from deep sleep for that very small durations.

Bias all forkees to small cores to prevent waking big cores from deep
sleep to save power.

Signed-off-by: Chitti Babu Theegala <quic_ctheegal@quicinc.com>
---
 kernel/sched/fair.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6..d407bbc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5976,7 +5976,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 }
 
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag);
 
 /*
  * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
@@ -6063,7 +6063,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		group = find_idlest_group(sd, p, cpu);
+		group = find_idlest_group(sd, p, cpu, sd_flag);
 		if (!group) {
 			sd = sd->child;
 			continue;
@@ -8997,7 +8997,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 static bool update_pick_idlest(struct sched_group *idlest,
 			       struct sg_lb_stats *idlest_sgs,
 			       struct sched_group *group,
-			       struct sg_lb_stats *sgs)
+			       struct sg_lb_stats *sgs,
+			       int sd_flag)
 {
 	if (sgs->group_type < idlest_sgs->group_type)
 		return true;
@@ -9034,6 +9035,11 @@ static bool update_pick_idlest(struct sched_group *idlest,
 		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
 			return false;
 
+		/* Select smaller cpu group for newly woken up forkees */
+		if ((sd_flag & SD_BALANCE_FORK) && (idlest_sgs->idle_cpus &&
+			!capacity_greater(idlest->sgc->max_capacity, group->sgc->max_capacity)))
+			return false;
+
 		/* Select group with lowest group_util */
 		if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
 			idlest_sgs->group_util <= sgs->group_util)
@@ -9062,7 +9068,7 @@ static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
  * Assumes p is allowed on at least one CPU in sd.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag)
 {
 	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
 	struct sg_lb_stats local_sgs, tmp_sgs;
@@ -9097,7 +9103,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 		update_sg_wakeup_stats(sd, group, sgs, p);
 
-		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
+		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs, sd_flag)) {
 			idlest = group;
 			idlest_sgs = *sgs;
 		}
-- 
2.7.4

