Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4347B52BCB7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiERMsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiERMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:46:05 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87511632AC;
        Wed, 18 May 2022 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652877785; x=1684413785;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=s1haGoMzWn+D78/Wjs5Eo95uLM9lSkcETlTB2+3u46w=;
  b=hnpwlAkkzVzs23vGtWnOfs/wUZonfu7p2syRxT77kFgjRaBgptaGyWRy
   YYYiBm8r2Oajs5yr+k9fV8Xhg4g7sBXtbvnNC+CC+2Vf3zZNLQg0WYlG3
   dxcU+71xKU3D09DqeYMl7Ix3sgK4GFLhl4PTJQ1/2cnTmDp/Nq87w0ki4
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 May 2022 05:43:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 05:43:03 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 05:43:02 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 05:42:56 -0700
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
Subject: [PATCH v2] ASoC: qcom: soundwire: Add support for controlling audio CGCR from HLOS
Date:   Wed, 18 May 2022 18:12:35 +0530
Message-ID: <1652877755-25120-1-git-send-email-quic_srivasam@quicinc.com>
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

Add support for controlling soundwire audio CGCR interface using clock
framework to make hclk ungating with software. As per new hardware
changes, software has to always ungate hclk if soundwire is operational
and keep it running. This requirement is for latest LPASS chipsets for
RX, TX and WSA path to work.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
This patch set depends on:
    -- Clock driver patches for CGCR reset control support.
	--- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=638002
	--- https://patchwork.kernel.org/project/linux-arm-msm/list/?series=637998	

Changes since v1:
    -- Add audio cgcr reset control in runtime PM resume handler.
    -- Update dependency list.

 drivers/soundwire/qcom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index da1ad7e..445e481 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -13,6 +13,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/slimbus.h>
@@ -142,6 +143,7 @@ struct qcom_swrm_ctrl {
 	struct device *dev;
 	struct regmap *regmap;
 	void __iomem *mmio;
+	struct reset_control *audio_cgcr;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 #endif
@@ -656,6 +658,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, ctrl->rows_index);
 	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, ctrl->cols_index);
 
+	reset_control_reset(ctrl->audio_cgcr);
+
 	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
 
 	/* Enable Auto enumeration */
@@ -1333,6 +1337,10 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	ctrl->bus.compute_params = &qcom_swrm_compute_params;
 	ctrl->bus.clk_stop_timeout = 300;
 
+	ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
+	if (IS_ERR(ctrl->audio_cgcr))
+		dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");
+
 	ret = qcom_swrm_get_port_config(ctrl);
 	if (ret)
 		goto err_clk;
@@ -1486,6 +1494,8 @@ static int __maybe_unused swrm_runtime_resume(struct device *dev)
 		qcom_swrm_get_device_status(ctrl);
 		sdw_handle_slave_status(&ctrl->bus, ctrl->status);
 	} else {
+		reset_control_reset(ctrl->audio_cgcr);
+
 		ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
 		ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR,
 			SWRM_INTERRUPT_STATUS_MASTER_CLASH_DET);
-- 
2.7.4

