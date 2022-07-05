Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FDA566CA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiGEMRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiGEMJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:09:01 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D1F17E17;
        Tue,  5 Jul 2022 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657022940; x=1688558940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fwRrMl9p2riRRQyGmmFyrVjyUvagNctJ2fZDM2FI/A4=;
  b=KhcGk4UbcRg6dqGj4UzNaAqQ4+bZ4gRkatMadLQqGIYtqpTOUpJDZU4q
   D9U2Sa6z2SDCbQrP0holqCO4izuExr6QRAbnSpjmB7viacjqGYiTzu8QV
   FL+ZTmgRa0SE0rNWh8Hu0KelM18tC2O6YKief6cm6ntA7iJre1Pz2y19w
   4=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2022 05:09:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:09:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 05:08:59 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 05:08:56 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [V3 6/7] remoteproc: sysmon: Wait for SSCTL service to come up
Date:   Tue, 5 Jul 2022 17:38:19 +0530
Message-ID: <1657022900-2049-7-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
References: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

The SSCTL service comes up after a finite time when the remote Q6 comes
out of reset. Any graceful shutdowns requested during this period will
be a NOP and abrupt tearing down of the glink channel might lead to pending
transactions on the remote Q6 side and will ultimately lead to a fatal
error. Fix this by waiting for the SSCTL service when a graceful shutdown
is requested.

Fixes: 1fb82ee806d1 ("remoteproc: qcom: Introduce sysmon")
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
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

