Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30D4495913
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiAUFDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:03:03 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:1667 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbiAUFDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:03:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642741381; x=1674277381;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qsVvbTD+kFXnw/RCOk7A0nqK86MwmdSQ061zu0NFLOY=;
  b=JWljXZNp5+hZiMEzDSxguJyOkOc5szadrLqiDwd7SeqiBDGeU+NP6krN
   59VYhfRnesdDvQKO0QunLzJlJ94R4sG3OijgitPNbj/4s0VEBtSEf/1ZU
   EgOrrycAsAIAarwGkpTc5UPwch2w7xPrfK8JKQzzYyOjnzI7YZv4TgWc1
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jan 2022 21:03:01 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 21:03:01 -0800
Received: from hu-ctheegal-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 20 Jan 2022 21:02:56 -0800
From:   Chitti Babu Theegala <quic_ctheegal@quicinc.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <joel@joelfernandes.org>
CC:     <linux-arm-msm@vger.kernel.org>, <quic_lingutla@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_rjendra@quicinc.com>,
        <vincent.donnefort@arm.com>,
        Chitti Babu Theegala <quic_ctheegal@quicinc.com>
Subject: [PATCH v2] sched/fair: Prefer small idle cores for forkees
Date:   Fri, 21 Jan 2022 10:32:33 +0530
Message-ID: <20220121050233.8708-1-quic_ctheegal@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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
Changes in v2:
1. Enclosed the EAS check for this small core preferring logic
---
 kernel/sched/fair.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c6046446c50b3..72f9ea7c98c05 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5872,7 +5872,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 }
 
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag);
 
 /*
  * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
@@ -5959,7 +5959,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		group = find_idlest_group(sd, p, cpu);
+		group = find_idlest_group(sd, p, cpu, sd_flag);
 		if (!group) {
 			sd = sd->child;
 			continue;
@@ -8885,7 +8885,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 static bool update_pick_idlest(struct sched_group *idlest,
 			       struct sg_lb_stats *idlest_sgs,
 			       struct sched_group *group,
-			       struct sg_lb_stats *sgs)
+			       struct sg_lb_stats *sgs,
+			       int sd_flag)
 {
 	if (sgs->group_type < idlest_sgs->group_type)
 		return true;
@@ -8922,6 +8923,13 @@ static bool update_pick_idlest(struct sched_group *idlest,
 		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
 			return false;
 
+		if (sched_energy_enabled()) {
+		    /* Select smaller cpu group for newly woken up forkees */
+		    if ((sd_flag & SD_BALANCE_FORK) && (idlest_sgs->idle_cpus &&
+		        !capacity_greater(idlest->sgc->max_capacity, group->sgc->max_capacity)))
+			return false;
+		}
+
 		/* Select group with lowest group_util */
 		if (idlest_sgs->idle_cpus == sgs->idle_cpus &&
 			idlest_sgs->group_util <= sgs->group_util)
@@ -8940,7 +8948,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * Assumes p is allowed on at least one CPU in sd.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag)
 {
 	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
 	struct sg_lb_stats local_sgs, tmp_sgs;
@@ -8978,7 +8986,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 		update_sg_wakeup_stats(sd, group, sgs, p);
 
-		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs)) {
+		if (!local_group && update_pick_idlest(idlest, &idlest_sgs, group, sgs, sd_flag)) {
 			idlest = group;
 			idlest_sgs = *sgs;
 		}
-- 
2.17.1

