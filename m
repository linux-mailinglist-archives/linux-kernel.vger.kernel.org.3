Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4124E532AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbiEXNOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiEXNOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:14:30 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7209AE43;
        Tue, 24 May 2022 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653398061; x=1684934061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kQsY5dppdnct/ZNtz2heoo4zsfgJCzMJGLniMhE5u8c=;
  b=HSgwXFSEJiHIBK/GhHN1qhBmXp6QlFJSxr2blCz+URKnF61BHkQ8eRhx
   sd3UeGLIEU1TMA4YYveYxZyt0a/hHuUTme4/tfsoyStyY2dYmz89os0jY
   TVhbphgZuuF6cChZyDj0jN1qnmHT7GXreEr/llUeGwH9ooxSkGdZTroE+
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 May 2022 06:14:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:14:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:14:20 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:14:17 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 7/7] remoteproc: q6v5: Set q6 state to offline on receiving wdog irq
Date:   Tue, 24 May 2022 18:43:37 +0530
Message-ID: <1653398017-28426-8-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
References: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
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

