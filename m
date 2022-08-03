Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23A588E94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiHCOWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238575AbiHCOW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:22:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD532EFF;
        Wed,  3 Aug 2022 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659536547; x=1691072547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ab1zJS9fWPNKtBxryvC014d7x2EEfYkbWTsZfGv2w4c=;
  b=wJ4I1NQzI/Ph9jkr7rk+WP9e8VkoxRH+bGkg3CwyPbQGwM5gY+hO6lG6
   aEyajIb4D+HUmQxdHOcUQQBHm9p276fkYll03g2VUei+XKx8ttVD+nzoZ
   lIoWNLizpCUpujFSSP+mfXBwiYkKNRIEp2Wagqvj9uj1/OC84PhpIdT3i
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 03 Aug 2022 07:22:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 07:22:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 07:22:26 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 07:22:20 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 8/8] remoteproc: qcom: Update QDSP6 out-of-reset timeout value
Date:   Wed, 3 Aug 2022 19:51:20 +0530
Message-ID: <1659536480-5176-9-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update QDSP6 out-of-reset timeout value to 1 second, as sometimes
ADSP boot failing on SC7280 based platforms with existing value.
Also add few micro seconds sleep after enabling boot core
start register.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index f81da47..1c0adc9 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -34,7 +34,7 @@
 /* time out value */
 #define ACK_TIMEOUT			1000
 #define ACK_TIMEOUT_US			1000000
-#define BOOT_FSM_TIMEOUT		10000
+#define BOOT_FSM_TIMEOUT		1000000
 /* mask values */
 #define EVB_MASK			GENMASK(27, 4)
 /*QDSP6SS register offsets*/
@@ -468,13 +468,14 @@ static int adsp_start(struct rproc *rproc)
 
 	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
 	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
+	usleep_ranage(100, 110);
 
 	/* Trigger boot FSM to start QDSP6 */
 	writel(LPASS_BOOT_CMD_START, adsp->qdsp6ss_base + BOOT_CMD_REG);
 
 	/* Wait for core to come out of reset */
 	ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
-			val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
+			val, (val & BIT(0)) != 0, 100, BOOT_FSM_TIMEOUT);
 	if (ret) {
 		dev_err(adsp->dev, "failed to bootup adsp\n");
 		goto disable_adsp_clks;
-- 
2.7.4

