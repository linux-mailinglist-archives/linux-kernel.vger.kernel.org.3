Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6924FC263
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348619AbiDKQdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348610AbiDKQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:33:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004931226;
        Mon, 11 Apr 2022 09:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649694646; x=1681230646;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0t7/Xk/BGN/6TFZIjOo455dEA7/BKT+i+NbErgmrJVM=;
  b=OWMzAVZSXaI9JJYqdpSGMje+DyOjHRyXsz9D2wAyqR4Cn5UnQpsdkrhH
   kq0xHwoU+jqtfAkHeahfMOHVPgKZ98oR0rXa+QzmLFFoRfH4kZgEqLEVX
   tx4efTvqi8NWtQm4MvHICyHtcC2UaZXnUp+C4uQEUgKVxsvWV9ykzuyaw
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 09:30:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:30:45 -0700
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 09:30:42 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v3 ] remoteproc: Use unbounded workqueue for recovery work
Date:   Mon, 11 Apr 2022 22:00:20 +0530
Message-ID: <1649694620-10070-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be a scenario where there is too much load on a core
(n number of tasks which is affined) or in a case when multiple
rproc subsystem is going for a recovery and they queued recovery
work to one core so even though subsystem are independent there
recovery will be delayed if one of the subsystem recovery work
is taking more time in completing.

If we make this queue unbounded, the recovery work could be picked
on any cpu. This patch try to address this.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v3:
  - Add fallback option to go back to earlier path incase recovery wq
    creation fails.

Changes in v2:
  - Removed WQ_HIGHPRI.
  - Updated commit text.

 drivers/remoteproc/remoteproc_core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c510125..6446c84 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -59,6 +59,7 @@ static int rproc_release_carveout(struct rproc *rproc,
 
 /* Unique indices for remoteproc devices */
 static DEFINE_IDA(rproc_dev_index);
+static struct workqueue_struct *rproc_recovery_wq;
 
 static const char * const rproc_crash_names[] = {
 	[RPROC_MMUFAULT]	= "mmufault",
@@ -2755,8 +2756,11 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
 	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
 		rproc->name, rproc_crash_to_string(type));
 
-	/* Have a worker handle the error; ensure system is not suspended */
-	queue_work(system_freezable_wq, &rproc->crash_handler);
+	if (rproc_recovery_wq)
+		queue_work(rproc_recovery_wq, &rproc->crash_handler);
+	else
+		queue_work(system_freezable_wq, &rproc->crash_handler);
+
 }
 EXPORT_SYMBOL(rproc_report_crash);
 
@@ -2805,6 +2809,11 @@ static void __exit rproc_exit_panic(void)
 
 static int __init remoteproc_init(void)
 {
+	rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq",
+						WQ_UNBOUND | WQ_FREEZABLE, 0);
+	if (!rproc_recovery_wq)
+		pr_err("remoteproc: creation of rproc_recovery_wq failed\n");
+
 	rproc_init_sysfs();
 	rproc_init_debugfs();
 	rproc_init_cdev();
@@ -2821,6 +2830,8 @@ static void __exit remoteproc_exit(void)
 	rproc_exit_panic();
 	rproc_exit_debugfs();
 	rproc_exit_sysfs();
+	if (rproc_recovery_wq)
+		destroy_workqueue(rproc_recovery_wq);
 }
 module_exit(remoteproc_exit);
 
-- 
2.7.4

