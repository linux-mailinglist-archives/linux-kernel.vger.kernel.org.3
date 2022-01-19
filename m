Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE474940E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbiASTbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:31:15 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:7054 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232837AbiASTbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642620671; x=1674156671;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=M4sInZkOzrVxNr7O+DfC3mK7EDZIxISiULG3Q/UF81o=;
  b=B0mPXnmJg+DUSEfhgBGKwI0r4dVA8G3AOLXz+GJ4Z3Mr5c8SeDTnuJYY
   Bl1v4HXhssWaB9wecUlejwnTliWR5luvThRbV+NeJO80K1X83ljQjx/6H
   mQCF5sjN1POcg1d2Jk6DYP0v5xKmzJNhkAjJHICadj/skn5CsGDsyc/lo
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Jan 2022 11:31:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:31:11 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 19 Jan 2022 11:31:09 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] remoteproc: Use unbounded/high priority workqueue for recovery work
Date:   Thu, 20 Jan 2022 01:00:44 +0530
Message-ID: <1642620644-19297-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be a scenario where there is too much load(n number
of tasks which is affined) on a core on which rproc recovery
is queued. Due to which, it takes number of seconds to complete
the recovery.

If we make this queue unbounded and move it to high priority worker
pool then this work can be attempted to finished in less time.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/remoteproc/remoteproc_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 69f51ac..efb6316 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -59,6 +59,7 @@ static int rproc_release_carveout(struct rproc *rproc,
 
 /* Unique indices for remoteproc devices */
 static DEFINE_IDA(rproc_dev_index);
+static struct workqueue_struct *rproc_recovery_wq;
 
 static const char * const rproc_crash_names[] = {
 	[RPROC_MMUFAULT]	= "mmufault",
@@ -2752,8 +2753,10 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
 	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
 		rproc->name, rproc_crash_to_string(type));
 
-	/* Have a worker handle the error; ensure system is not suspended */
-	queue_work(system_freezable_wq, &rproc->crash_handler);
+	if (rproc_recovery_wq)
+		queue_work(rproc_recovery_wq, &rproc->crash_handler);
+	else
+		queue_work(system_freezable_wq, &rproc->crash_handler);
 }
 EXPORT_SYMBOL(rproc_report_crash);
 
@@ -2802,6 +2805,11 @@ static void __exit rproc_exit_panic(void)
 
 static int __init remoteproc_init(void)
 {
+	rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq", WQ_UNBOUND |
+				WQ_HIGHPRI | WQ_FREEZABLE, 0);
+	if (!rproc_recovery_wq)
+		pr_err("remoteproc: creation of rproc_recovery_wq failed\n");
+
 	rproc_init_sysfs();
 	rproc_init_debugfs();
 	rproc_init_cdev();
@@ -2818,6 +2826,8 @@ static void __exit remoteproc_exit(void)
 	rproc_exit_panic();
 	rproc_exit_debugfs();
 	rproc_exit_sysfs();
+	if (rproc_recovery_wq)
+		destroy_workqueue(rproc_recovery_wq);
 }
 module_exit(remoteproc_exit);
 
-- 
2.7.4

