Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B734AF32A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiBINnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiBINnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:43:35 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EADC0612BE;
        Wed,  9 Feb 2022 05:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644414218; x=1675950218;
  h=from:to:subject:date:message-id:mime-version;
  bh=iuWdGWL4r+alsxzIRmcnsUfqNu62+JTUmJFdnBcCVm0=;
  b=Djp/XgwRLEH7xEMaGDjpNS4HllKNB8SAvxsfme0YnQexWa+pGAk7STG4
   ZOoTXIU/sImK+lHUz5bb4m+1rd+iLIPSF4JpkQggpT2vpD4/TEU+YJBfp
   R9SHqoJo7j/kfHp9DumgRzdbBOgVzS+KRm0bYqyC+L+kJN+Fu8eCWQb12
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Feb 2022 05:43:38 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:43:38 -0800
Received: from hu-ctheegal-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 05:43:34 -0800
From:   Chitti Babu Theegala <quic_ctheegal@quicinc.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <joel@joelfernandes.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_lingutla@quicinc.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/uclamp: New sysctl to tweak boost for uclamp tasks
Date:   Wed, 9 Feb 2022 19:13:19 +0530
Message-ID: <20220209134319.1183-1-quic_ctheegal@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UCLAMP_MIN knob clamps the util_value within uclamp_min & max.
Currently, these uclamped tasks are also boosted to big cores
which can hit power.

Implementing a new knob which can provide an option to turn-off
'boosting to big cores' and just restrict to 'clamping util value'
job. Also, note that big cores affinity can be separately achieved
with cpuset cgroups as well, if required for any critical tasks.

Signed-off-by: Chitti Babu Theegala <quic_ctheegal@quicinc.com>
---
 include/linux/sched/sysctl.h | 1 +
 kernel/sched/core.c          | 8 ++++++++
 kernel/sched/fair.c          | 2 +-
 kernel/sysctl.c              | 9 +++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index be27e725b9285..fa7abecf6cd68 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -54,6 +54,7 @@ extern unsigned int sysctl_sched_dl_period_min;
 extern unsigned int sysctl_sched_uclamp_util_min;
 extern unsigned int sysctl_sched_uclamp_util_max;
 extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
+extern unsigned int sysctl_sched_uclamp_util_min_to_boost;
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 634d571e39d77..55019eb9c83c5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1269,6 +1269,14 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
  */
 unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
 
+/* UCLAMP_MIN knob clamps the util_value within uclamp_min & max. By default,
+ * these uclamped tasks are also boosted to bigger cores which can impact power.
+ *
+ * This knob provides an option to turn-off 'boosting to gold cores' and
+ * just restrict to 'clamping util value' job.
+ */
+unsigned int sysctl_sched_uclamp_util_min_to_boost = 1;
+
 /* All clamps are required to be less or equal than these values */
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7cd316793f4e3..44adcbfa9eb32 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6829,7 +6829,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu, int sy
 		goto unlock;
 
 	latency_sensitive = uclamp_latency_sensitive(p);
-	boosted = uclamp_boosted(p);
+	boosted = sysctl_sched_uclamp_util_min_to_boost && uclamp_boosted(p);
 	target_cap = boosted ? 0 : ULONG_MAX;
 
 	for (; pd; pd = pd->next) {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8f196ed2ec065..6463d60fed84e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1882,6 +1882,15 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_sched_uclamp_handler,
 	},
+	{
+		.procname	= "sched_util_clamp_min_to_boost",
+		.data		= &sysctl_sched_uclamp_util_min_to_boost,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
-- 
2.17.1

