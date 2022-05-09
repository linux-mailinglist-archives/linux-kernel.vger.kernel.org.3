Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A951F2D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiEIDRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiEIDPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:15:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67586AEF;
        Sun,  8 May 2022 20:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652065890; x=1683601890;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=p8urheBXbOU7HRdMjgj249wzbQxrt5Hj0ai6+bM7SsU=;
  b=m0BEsNOyJ2zLwDXAUvQawRsU05SLRNNp3/hzwQNQIy09ww3mA8LfRzhD
   MCBjm1CqSVZyeAiG0Gamwwso16bamP2RmRy9TCPlscTyYou57nkCzzBKc
   gmvgpNeat7b3jztDpW9ubYkzGxO7RcQ4vKI5CD2QjGipPqR4TgN8PmM6a
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 08 May 2022 20:11:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 20:11:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 8 May 2022 20:11:28 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 8 May 2022 20:11:24 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <sboyd@kernel.org>, <agross@kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <mka@chromium.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH] remoteproc: sysmon: Wait for SSCTL service to come up
Date:   Mon, 9 May 2022 08:41:07 +0530
Message-ID: <1652065867-5669-1-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SSCTL service comes up after a finite time when the remote Q6 comes
out of reset. Any graceful shutdowns requested during this period will
be a NOP and abrupt tearing down of the glink channel might lead to pending
transactions on the remote Q6 side and will ultimately lead to a fatal
error. Fix this by waiting for the SSCTL service when a graceful shutdown
is requested.

Fixes: 1fb82ee806d1 ("remoteproc: qcom: Introduce sysmon")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_sysmon.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index 9fca81492863..a9f04dd83ab6 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -41,6 +41,7 @@ struct qcom_sysmon {
 	struct completion comp;
 	struct completion ind_comp;
 	struct completion shutdown_comp;
+	struct completion ssctl_comp;
 	struct mutex lock;
 
 	bool ssr_ack;
@@ -445,6 +446,8 @@ static int ssctl_new_server(struct qmi_handle *qmi, struct qmi_service *svc)
 
 	svc->priv = sysmon;
 
+	complete(&sysmon->ssctl_comp);
+
 	return 0;
 }
 
@@ -501,6 +504,7 @@ static int sysmon_start(struct rproc_subdev *subdev)
 		.ssr_event = SSCTL_SSR_EVENT_AFTER_POWERUP
 	};
 
+	reinit_completion(&sysmon->ssctl_comp);
 	mutex_lock(&sysmon->state_lock);
 	sysmon->state = SSCTL_SSR_EVENT_AFTER_POWERUP;
 	blocking_notifier_call_chain(&sysmon_notifiers, 0, (void *)&event);
@@ -545,6 +549,11 @@ static void sysmon_stop(struct rproc_subdev *subdev, bool crashed)
 	if (crashed)
 		return;
 
+	if (sysmon->ssctl_instance) {
+		if (!wait_for_completion_timeout(&sysmon->ssctl_comp, HZ / 2))
+			dev_err(sysmon->dev, "timeout waiting for ssctl service\n");
+	}
+
 	if (sysmon->ssctl_version)
 		sysmon->shutdown_acked = ssctl_request_shutdown(sysmon);
 	else if (sysmon->ept)
@@ -631,6 +640,7 @@ struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 	init_completion(&sysmon->comp);
 	init_completion(&sysmon->ind_comp);
 	init_completion(&sysmon->shutdown_comp);
+	init_completion(&sysmon->ssctl_comp);
 	mutex_init(&sysmon->lock);
 	mutex_init(&sysmon->state_lock);
 
-- 
2.7.4

