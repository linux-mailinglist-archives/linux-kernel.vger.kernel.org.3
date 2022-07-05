Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA05E566CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiGEMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiGEMJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:09:13 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9230418374;
        Tue,  5 Jul 2022 05:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657022952; x=1688558952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kQsY5dppdnct/ZNtz2heoo4zsfgJCzMJGLniMhE5u8c=;
  b=Sg4VJt7UF0VTTDbWCyGdk4JNVYCXZS6AiZ+niFKpK+iAnBIp9tztGktf
   eTNA7SQ2vn6aFJh2EaDX5y9Udv9P1ESj0ofS/rPrw2tCt5O/kv0eteYwe
   73hVrCxV97SOKBVbZiM4OUxEmww2pgHRmB4AHlSXHRHr+v61clolLHKjK
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 05 Jul 2022 05:09:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:08:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 05:08:56 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 05:08:53 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [V3 5/7] remoteproc: q6v5: Set q6 state to offline on receiving wdog irq
Date:   Tue, 5 Jul 2022 17:38:18 +0530
Message-ID: <1657022900-2049-6-git-send-email-quic_sibis@quicinc.com>
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

From: Siddharth Gupta <sidgup@codeaurora.org>

Due to firmware bugs on the Q6 the hardware watchdog irq can be triggered
multiple times. As the remoteproc framework schedules work items for the
recovery process, if the other threads do not get a chance to run before
recovery is completed the proceeding threads will see the state of the
remoteproc as running and kill the remoteproc while it is running. This
can result in various SMMU and NOC errors. This change sets the state of
the remoteproc to offline whenever a watchdog irq is received.

Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 5280ec9b5449..497acfb33f8f 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -112,6 +112,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
 	else
 		dev_err(q6v5->dev, "watchdog without message\n");
 
+	q6v5->running = false;
 	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
 
 	return IRQ_HANDLED;
@@ -123,6 +124,9 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
 	size_t len;
 	char *msg;
 
+	if (!q6v5->running)
+		return IRQ_HANDLED;
+
 	msg = qcom_smem_get(QCOM_SMEM_HOST_ANY, q6v5->crash_reason, &len);
 	if (!IS_ERR(msg) && len > 0 && msg[0])
 		dev_err(q6v5->dev, "fatal error received: %s\n", msg);
-- 
2.7.4

