Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B854225F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiFHEwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiFHEvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:51:51 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8394262E1A;
        Tue,  7 Jun 2022 18:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654651044; x=1686187044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HS2tVe61KzrUqms7DIAgt9EyNPA+XwdzGMJ9STg48/k=;
  b=xkjKm1PU8/e7H+lq9+VpOCWj2t/BX5f/26b8/sA7nLsX1/kdRVLX7RhN
   XInOcAd2LnRbewzALWePTN55YgaJSMFWI2ALotdxBpRAjAs1pyTcGcZ2s
   KD2pq3I362xLtzFjc5fGVF0ioYFcxX/CVn+fNK8IL1r6WF7D+LdnQa1A/
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jun 2022 18:17:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:17:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:20 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:19 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 3/4] rpmsg: glink: Try to send rx done in irq
Date:   Tue, 7 Jun 2022 18:16:44 -0700
Message-ID: <1654651005-15475-4-git-send-email-quic_clew@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
References: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some remote processors and usecases such as audio playback are
sensitive to the response time of rx done. Try to send the rx done cmd
from irq context. If trysend fails, defer the rx done work like before.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 60 ++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 07586514991f..799e602113a1 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -497,12 +497,11 @@ static void qcom_glink_send_close_ack(struct qcom_glink *glink,
 	qcom_glink_tx(glink, &req, sizeof(req), NULL, 0, true);
 }
 
-static void qcom_glink_rx_done_work(struct work_struct *work)
+static int qcom_glink_send_rx_done(struct qcom_glink *glink,
+				struct glink_channel *channel,
+				struct glink_core_rx_intent *intent,
+				bool wait)
 {
-	struct glink_channel *channel = container_of(work, struct glink_channel,
-						     intent_work);
-	struct qcom_glink *glink = channel->glink;
-	struct glink_core_rx_intent *intent, *tmp;
 	struct {
 		u16 id;
 		u16 lcid;
@@ -510,26 +509,41 @@ static void qcom_glink_rx_done_work(struct work_struct *work)
 	} __packed cmd;
 
 	unsigned int cid = channel->lcid;
-	unsigned int iid;
-	bool reuse;
+	unsigned int iid = intent->id;
+	bool reuse = intent->reuse;
+	int ret;
+
+	cmd.id = reuse ? RPM_CMD_RX_DONE_W_REUSE : RPM_CMD_RX_DONE;
+	cmd.lcid = cid;
+	cmd.liid = iid;
+
+	ret = qcom_glink_tx(glink, &cmd, sizeof(cmd), NULL, 0, wait);
+	if (ret)
+		return ret;
+
+	if (!reuse) {
+		kfree(intent->data);
+		kfree(intent);
+	}
+
+	return 0;
+}
+
+static void qcom_glink_rx_done_work(struct work_struct *work)
+{
+	struct glink_channel *channel = container_of(work, struct glink_channel,
+						     intent_work);
+	struct qcom_glink *glink = channel->glink;
+	struct glink_core_rx_intent *intent, *tmp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&channel->intent_lock, flags);
 	list_for_each_entry_safe(intent, tmp, &channel->done_intents, node) {
 		list_del(&intent->node);
 		spin_unlock_irqrestore(&channel->intent_lock, flags);
-		iid = intent->id;
-		reuse = intent->reuse;
 
-		cmd.id = reuse ? RPM_CMD_RX_DONE_W_REUSE : RPM_CMD_RX_DONE;
-		cmd.lcid = cid;
-		cmd.liid = iid;
+		qcom_glink_send_rx_done(glink, channel, intent, true);
 
-		qcom_glink_tx(glink, &cmd, sizeof(cmd), NULL, 0, true);
-		if (!reuse) {
-			kfree(intent->data);
-			kfree(intent);
-		}
 		spin_lock_irqsave(&channel->intent_lock, flags);
 	}
 	spin_unlock_irqrestore(&channel->intent_lock, flags);
@@ -539,6 +553,8 @@ static void qcom_glink_rx_done(struct qcom_glink *glink,
 			       struct glink_channel *channel,
 			       struct glink_core_rx_intent *intent)
 {
+	int ret = -EAGAIN;
+
 	/* We don't send RX_DONE to intentless systems */
 	if (glink->intentless) {
 		kfree(intent->data);
@@ -555,10 +571,14 @@ static void qcom_glink_rx_done(struct qcom_glink *glink,
 
 	/* Schedule the sending of a rx_done indication */
 	spin_lock(&channel->intent_lock);
-	list_add_tail(&intent->node, &channel->done_intents);
-	spin_unlock(&channel->intent_lock);
+	if (list_empty(&channel->done_intents))
+		ret = qcom_glink_send_rx_done(glink, channel, intent, false);
 
-	schedule_work(&channel->intent_work);
+	if (ret) {
+		list_add_tail(&intent->node, &channel->done_intents);
+		schedule_work(&channel->intent_work);
+	}
+	spin_unlock(&channel->intent_lock);
 }
 
 /**
-- 
2.7.4

