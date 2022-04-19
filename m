Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2BE506A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351216AbiDSL2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349331AbiDSL2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:28:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD7626107;
        Tue, 19 Apr 2022 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650367569; x=1681903569;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=iLiidp+TGadOX0ZPyXvxXxQB0kCJMreyZrDBDHEpvHM=;
  b=YpcaJM+1L/oFsNsMsjU5EcPAdgu8o1FRnZOyisd8gmR1U9qAtNyM1Ef8
   wBSh/yqQpggIALCcYwTpvcBD5SgAZMsdQE1ZSBnpYrwFQzNIBNI4DDTuh
   YDYqq624HXG0ce0LJKp11ZohEld9zzXlcfx7P2bBS3DV/TYoDp8qboQie
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 Apr 2022 04:26:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 04:26:09 -0700
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 04:26:06 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v4 ]  remoteproc: Use unbounded workqueue for recovery work
Date:   Tue, 19 Apr 2022 16:55:54 +0530
Message-ID: <1650367554-15510-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be a scenario when there is too much load on a core
(n number of tasks which is affined) or in a case when multiple
rproc subsystem is going for recovery, they queue their recovery
work to one core so even though subsystem are independent their
recovery will be delayed if one of the subsystem recovery work
is taking more time in completing.

If we make this queue unbounded, the recovery work could be picked
on any cpu. This patch is trying to address this.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v4:
  - Removed fallback option on @sarvana comment
  - Fail the init on workqueue creation failure.
  - modified commit text.

Changes in v3:
  - Add fallback option to go back to earlier path incase recovery wq
    creation fails.

Changes in v2:
  - Removed WQ_HIGHPRI.
  - Updated commit text.


 drivers/remoteproc/remoteproc_core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c510125..c8a1e3e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -59,6 +59,7 @@ static int rproc_release_carveout(struct rproc *rproc,
 
 /* Unique indices for remoteproc devices */
 static DEFINE_IDA(rproc_dev_index);
+static struct workqueue_struct *rproc_recovery_wq;
 
 static const char * const rproc_crash_names[] = {
 	[RPROC_MMUFAULT]	= "mmufault",
@@ -2755,8 +2756,7 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
 	dev_err(&rproc->dev, "crash detected in %s: type %s\n",
 		rproc->name, rproc_crash_to_string(type));
 
-	/* Have a worker handle the error; ensure system is not suspended */
-	queue_work(system_freezable_wq, &rproc->crash_handler);
+	queue_work(rproc_recovery_wq, &rproc->crash_handler);
 }
 EXPORT_SYMBOL(rproc_report_crash);
 
@@ -2805,6 +2805,13 @@ static void __exit rproc_exit_panic(void)
 
 static int __init remoteproc_init(void)
 {
+	rproc_recovery_wq = alloc_workqueue("rproc_recovery_wq",
+						WQ_UNBOUND | WQ_FREEZABLE, 0);
+	if (!rproc_recovery_wq) {
+		pr_err("remoteproc: creation of rproc_recovery_wq failed\n");
+		return -ENOMEM;
+	}
+
 	rproc_init_sysfs();
 	rproc_init_debugfs();
 	rproc_init_cdev();
@@ -2818,9 +2825,13 @@ static void __exit remoteproc_exit(void)
 {
 	ida_destroy(&rproc_dev_index);
 
+	if (!rproc_recovery_wq)
+		return;
+
 	rproc_exit_panic();
 	rproc_exit_debugfs();
 	rproc_exit_sysfs();
+	destroy_workqueue(rproc_recovery_wq);
 }
 module_exit(remoteproc_exit);
 
-- 
2.7.4

