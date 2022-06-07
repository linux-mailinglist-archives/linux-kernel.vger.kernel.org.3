Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC41F53FEEC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbiFGMgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243856AbiFGMgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:36:14 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26671C4EB9;
        Tue,  7 Jun 2022 05:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654605372; x=1686141372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fYpPCX6VZdvNlaz5PU1EmmzGezp4ojXcHXRAL2naybc=;
  b=WAdtr08VdHF0FaoCNYSI3IjbIWdRE0OWKShlPAGcCv6s9+LD0IOTMQGe
   /WHZTnK/nb4EjByDLNHFQ8HhHRFLvtEwKVswmKdw80OTqSIjEXobgrC9f
   a/Yk4LGkurTYgvGK7OjYIPjbT4TYADnq8AbFqxu6v2a2XlerKWuJnoR7h
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 07 Jun 2022 05:36:12 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 05:36:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 05:36:10 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 7 Jun 2022 05:36:04 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <vkoul@kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 2/2] ASoC: qcom: soundwire: Add software clock gating requirement check
Date:   Tue, 7 Jun 2022 18:05:34 +0530
Message-ID: <1654605334-32030-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654605334-32030-1-git-send-email-quic_srivasam@quicinc.com>
References: <1654605334-32030-1-git-send-email-quic_srivasam@quicinc.com>
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

Validate software clock gating required or not and do software
clock gating on hclk if soundwire is operational and keep it
running by adding flag in private dat structure.
This is to avoid conflict between older architectures,
where software clock gating is not required and on latest
architectues, where software clock gating is mandatory.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 drivers/soundwire/qcom.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 38c3bf5..4896e92 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -194,6 +194,12 @@ static const struct qcom_swrm_data swrm_v1_5_data = {
 	.default_cols = 16,
 };
 
+static const struct qcom_swrm_data swrm_v1_6_data = {
+	.default_rows = 50,
+	.default_cols = 16,
+	.sw_clk_gate_required = 1,
+};
+
 #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
 
 static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
@@ -659,7 +665,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, ctrl->rows_index);
 	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, ctrl->cols_index);
 
-	reset_control_reset(ctrl->audio_cgcr);
+	if (data->sw_clk_gate_required)
+		reset_control_reset(ctrl->audio_cgcr);
 
 	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
 
@@ -1312,6 +1319,15 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 			return PTR_ERR(ctrl->mmio);
 	}
 
+	if (data->sw_clk_gate_required) {
+		ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
+		if (IS_ERR(ctrl->audio_cgcr)) {
+			dev_err(dev, "Failed to get cgcr reset ctrl required for SW gating\n");
+			ret = PTR_ERR(ctrl->audio_cgcr);
+			goto err_init;
+		}
+	}
+
 	ctrl->irq = of_irq_get(dev->of_node, 0);
 	if (ctrl->irq < 0) {
 		ret = ctrl->irq;
@@ -1337,10 +1353,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	ctrl->bus.compute_params = &qcom_swrm_compute_params;
 	ctrl->bus.clk_stop_timeout = 300;
 
-	ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
-	if (IS_ERR(ctrl->audio_cgcr))
-		dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");
-
 	ret = qcom_swrm_get_port_config(ctrl);
 	if (ret)
 		goto err_clk;
@@ -1494,7 +1506,8 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
 		qcom_swrm_get_device_status(ctrl);
 		sdw_handle_slave_status(&ctrl->bus, ctrl->status);
 	} else {
-		reset_control_reset(ctrl->audio_cgcr);
+		if (data->sw_clk_gate_required)
+			reset_control_reset(ctrl->audio_cgcr);
 
 		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
 		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR,
@@ -1559,7 +1572,7 @@ static const struct dev_pm_ops swrm_dev_pm_ops = {
 static const struct of_device_id qcom_swrm_of_match[] = {
 	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
 	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
-	{ .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_5_data },
+	{ .compatible = "qcom,soundwire-v1.6.0", .data = &swrm_v1_6_data },
 	{/* sentinel */},
 };
 
-- 
2.7.4

