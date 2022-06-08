Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E902C5424A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiFHEwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiFHEvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:51:52 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEA32717AF;
        Tue,  7 Jun 2022 18:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654651044; x=1686187044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=/nNkMm22PKPf3p8/rCKaXGPuNVIxoEoPsdpm5cQPmew=;
  b=LUNehITs6n18Jk2/zguEW3Fc8h1AWTHNOeug5ntjD5T6HHpnzjnycWeD
   8YJ5A/GsWFUym8OuMsxdT3PgPDU7+5Idh5JPX/r8fBlLt23yjeQoTe+K5
   FRJ1m9ByzOMtp1A3oSP1857IRLCbj7/CD3VxdzfiiiCBf6+4BLfNxwMZi
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jun 2022 18:17:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:17:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:20 -0700
Received: from hu-clew-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 18:17:20 -0700
From:   Chris Lew <quic_clew@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH 4/4] rpmsg: glink: Add support for rpmsg_rx_done
Date:   Tue, 7 Jun 2022 18:16:45 -0700
Message-ID: <1654651005-15475-5-git-send-email-quic_clew@quicinc.com>
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

Add the implementation for the hooks of rpmsg_rx_done. If a client
signals they want to hold onto a buffer with RPMSG_DEFER in the rx_cb,
glink will move that intent to a deferred cleanup list. On the new
rpmsg rx_done call, the glink transport will search this deferred
cleanup list for the matching buffer and release the intent.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
---
 drivers/rpmsg/qcom_glink_native.c | 54 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 799e602113a1..db0dcc04f393 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -146,6 +146,7 @@ enum {
  * @riids:	idr of all remote intents
  * @intent_work: worker responsible for transmitting rx_done packets
  * @done_intents: list of intents that needs to be announced rx_done
+ * @defer_intents: list of intents held by the client released by rpmsg_rx_done
  * @buf:	receive buffer, for gathering fragments
  * @buf_offset:	write offset in @buf
  * @buf_size:	size of current @buf
@@ -174,6 +175,7 @@ struct glink_channel {
 	struct idr riids;
 	struct work_struct intent_work;
 	struct list_head done_intents;
+	struct list_head defer_intents;
 
 	struct glink_core_rx_intent *buf;
 	int buf_offset;
@@ -232,6 +234,7 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
 	init_completion(&channel->intent_req_comp);
 
 	INIT_LIST_HEAD(&channel->done_intents);
+	INIT_LIST_HEAD(&channel->defer_intents);
 	INIT_WORK(&channel->intent_work, qcom_glink_rx_done_work);
 
 	idr_init(&channel->liids);
@@ -261,6 +264,12 @@ static void qcom_glink_channel_release(struct kref *ref)
 			kfree(intent);
 		}
 	}
+	list_for_each_entry_safe(intent, tmp, &channel->defer_intents, node) {
+		if (!intent->reuse) {
+			kfree(intent->data);
+			kfree(intent);
+		}
+	}
 
 	idr_for_each_entry(&channel->liids, tmp, iid) {
 		kfree(tmp->data);
@@ -549,9 +558,10 @@ static void qcom_glink_rx_done_work(struct work_struct *work)
 	spin_unlock_irqrestore(&channel->intent_lock, flags);
 }
 
-static void qcom_glink_rx_done(struct qcom_glink *glink,
+static void __qcom_glink_rx_done(struct qcom_glink *glink,
 			       struct glink_channel *channel,
-			       struct glink_core_rx_intent *intent)
+			       struct glink_core_rx_intent *intent,
+			       bool defer)
 {
 	int ret = -EAGAIN;
 
@@ -569,6 +579,14 @@ static void qcom_glink_rx_done(struct qcom_glink *glink,
 		spin_unlock(&channel->intent_lock);
 	}
 
+	/* Move intent to defer list until client calls rpmsg_rx_done */
+	if (defer) {
+		spin_lock(&channel->intent_lock);
+		list_add_tail(&intent->node, &channel->defer_intents);
+		spin_unlock(&channel->intent_lock);
+		return;
+	}
+
 	/* Schedule the sending of a rx_done indication */
 	spin_lock(&channel->intent_lock);
 	if (list_empty(&channel->done_intents))
@@ -581,6 +599,28 @@ static void qcom_glink_rx_done(struct qcom_glink *glink,
 	spin_unlock(&channel->intent_lock);
 }
 
+static int qcom_glink_rx_done(struct rpmsg_endpoint *ept, void *data)
+{
+	struct glink_channel *channel = to_glink_channel(ept);
+	struct qcom_glink *glink = channel->glink;
+	struct glink_core_rx_intent *intent, *tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&channel->intent_lock, flags);
+	list_for_each_entry_safe(intent, tmp, &channel->defer_intents, node) {
+		if (intent->data == data) {
+			list_del(&intent->node);
+			spin_unlock_irqrestore(&channel->intent_lock, flags);
+
+			qcom_glink_send_rx_done(glink, channel, intent, true);
+			return 0;
+		}
+	}
+	spin_unlock_irqrestore(&channel->intent_lock, flags);
+
+	return -EINVAL;
+}
+
 /**
  * qcom_glink_receive_version() - receive version/features from remote system
  *
@@ -841,6 +881,7 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 	} __packed hdr;
 	unsigned int chunk_size;
 	unsigned int left_size;
+	bool rx_done_defer;
 	unsigned int rcid;
 	unsigned int liid;
 	int ret = 0;
@@ -935,7 +976,12 @@ static int qcom_glink_rx_data(struct qcom_glink *glink, size_t avail)
 		intent->offset = 0;
 		channel->buf = NULL;
 
-		qcom_glink_rx_done(glink, channel, intent);
+		if (channel->ept.rx_done && ret == RPMSG_DEFER)
+			rx_done_defer = true;
+		else
+			rx_done_defer = false;
+
+		__qcom_glink_rx_done(glink, channel, intent, rx_done_defer);
 	}
 
 advance_rx:
@@ -1212,6 +1258,7 @@ static struct rpmsg_endpoint *qcom_glink_create_ept(struct rpmsg_device *rpdev,
 	ept->cb = cb;
 	ept->priv = priv;
 	ept->ops = &glink_endpoint_ops;
+	ept->rx_done = true;
 
 	return ept;
 }
@@ -1462,6 +1509,7 @@ static const struct rpmsg_endpoint_ops glink_endpoint_ops = {
 	.sendto = qcom_glink_sendto,
 	.trysend = qcom_glink_trysend,
 	.trysendto = qcom_glink_trysendto,
+	.rx_done = qcom_glink_rx_done,
 };
 
 static void qcom_glink_rpdev_release(struct device *dev)
-- 
2.7.4

