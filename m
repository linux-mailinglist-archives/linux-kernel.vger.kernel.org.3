Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F124B552D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348396AbiFUIiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347950AbiFUIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:38:51 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0EC2317E;
        Tue, 21 Jun 2022 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655800731; x=1687336731;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=EI6M6wg5GXdJ9TlHRlOGin1RyyW6eaTiHorelcQBSrE=;
  b=hZSzP5dFaG0454iZ8xfdWUd1oRLE1ifwe/YWAQLLKNmpMQjR28STx1mm
   ZV+NVwd0yhfcMzgv4LOheSF7T9x6Wi/9qqutJCKcabeJLYJLsmC/+zyaI
   XYayroUHJmHHzBPmh/oUrpKD1SqGe5kPj9VkmjWzyZ8yqj4GaPgh7wP7L
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Jun 2022 01:38:50 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 01:38:50 -0700
Received: from cbsp-sh-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 01:38:48 -0700
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_jhugo@quicinc.com>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v2 1/1] bus: mhi: Disable IRQs instead of freeing them during power down
Date:   Tue, 21 Jun 2022 16:38:09 +0800
Message-ID: <1655800689-60632-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

MHI device may go down several times while running. So we just do
disable/enable IRQs during the mhi_{power_down/power_up} time and
request/free them when the MHI driver gets installed and removed.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
v1->v2: Rewrite commit text. Remove a random change. Use
        inline enables.

 drivers/bus/mhi/host/init.c | 14 ++++++++++++++
 drivers/bus/mhi/host/pm.c   | 22 ++++++++++++++++------
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index cbb86b2..daf315a 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -179,6 +179,11 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 				   "bhi", mhi_cntrl);
 	if (ret)
 		return ret;
+	/*
+	 * IRQ marked IRQF_SHARED isn't recommended to use IRQ_NOAUTOEN,
+	 * so disable it explicitly.
+	 */
+	disable_irq(mhi_cntrl->irq[0]);
 
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
 		if (mhi_event->offload_ev)
@@ -200,6 +205,8 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 				mhi_cntrl->irq[mhi_event->irq], i);
 			goto error_request;
 		}
+
+		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
 	}
 
 	return 0;
@@ -1003,8 +1010,14 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 
 	mhi_create_debugfs(mhi_cntrl);
 
+	ret = mhi_init_irq_setup(mhi_cntrl);
+	if (ret)
+		goto error_setup_irq;
+
 	return 0;
 
+error_setup_irq:
+	mhi_destroy_debugfs(mhi_cntrl);
 err_release_dev:
 	put_device(&mhi_dev->dev);
 err_ida_free:
@@ -1027,6 +1040,7 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
 	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
 	unsigned int i;
 
+	mhi_deinit_free_irq(mhi_cntrl);
 	mhi_destroy_debugfs(mhi_cntrl);
 
 	destroy_workqueue(mhi_cntrl->hiprio_wq);
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index dc2e8ff..eec2d1d 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -500,7 +500,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
 		if (mhi_event->offload_ev)
 			continue;
-		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
+		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
 		tasklet_kill(&mhi_event->task);
 	}
 
@@ -1060,12 +1060,13 @@ static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
 
 int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 {
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
 	enum mhi_state state;
 	enum mhi_ee_type current_ee;
 	enum dev_st_transition next_state;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	u32 interval_us = 25000; /* poll register field every 25 milliseconds */
-	int ret;
+	int ret, i;
 
 	dev_info(dev, "Requested to power ON\n");
 
@@ -1117,9 +1118,18 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
 		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
 	}
 
-	ret = mhi_init_irq_setup(mhi_cntrl);
-	if (ret)
-		goto error_exit;
+	/*
+	 * IRQs have been reuqested during probe,
+	 * so we just need to enable them.
+	 */
+	enable_irq(mhi_cntrl->irq[0]);
+
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->offload_ev)
+			continue;
+
+		enable_irq(mhi_cntrl->irq[mhi_event->irq]);
+	}
 
 	/* Transition to next state */
 	next_state = MHI_IN_PBL(current_ee) ?
@@ -1182,7 +1192,7 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 	/* Wait for shutdown to complete */
 	flush_work(&mhi_cntrl->st_worker);
 
-	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+	disable_irq(mhi_cntrl->irq[0]);
 }
 EXPORT_SYMBOL_GPL(mhi_power_down);
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

