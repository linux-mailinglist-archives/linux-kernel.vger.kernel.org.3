Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202254C6465
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiB1IKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiB1IKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:10:12 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAA569480;
        Mon, 28 Feb 2022 00:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646035774; x=1677571774;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=p9K9p80/Kt5ZYVZQzZ80bVW17pYGTl7pqRSVohlsFhU=;
  b=PbVEwk8jZqlvFXcIDK4WxWUpVx5JLcvjPc3D8oMp2d286HzKksCvpbVK
   N2gaDJCe9SBFNPBXYWMneMXaajaiankVBefIJIALWnI7AWgNypfozqqwn
   iAnm2djIioGJ1KD2mF9QrK/gHf9PO29uIwxO2aEnJ6i1Tkaq+XkwV5HNL
   A=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 28 Feb 2022 00:09:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 00:09:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 00:09:32 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 00:09:26 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH] ASoC: qcom: soundwire: Add support for controlling audio CGCR from HLOS
Date:   Mon, 28 Feb 2022 13:39:10 +0530
Message-ID: <1646035750-25635-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Add support for controlling soundwire audio CGCR interface using clock framework
to make hclk ungating with software.
As per new hardware changes, software has to always ungate hclk if soundwire
is operational and keep it running.
This requirement is for latest LPASS chipsets for RX, TX and WSA path to work.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
This patch set depends on:
	-- Clock driver patches with reset control support, yet to be posted.

 drivers/soundwire/qcom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index fb183bd..440aad8 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -12,6 +12,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/slimbus.h>
 #include <linux/soundwire/sdw.h>
@@ -129,6 +130,7 @@ struct qcom_swrm_ctrl {
 	struct device *dev;
 	struct regmap *regmap;
 	void __iomem *mmio;
+	struct reset_control *audio_cgcr;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 #endif
@@ -618,6 +620,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	val = FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK, ctrl->rows_index);
 	val |= FIELD_PREP(SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK, ctrl->cols_index);
 
+	reset_control_reset(ctrl->audio_cgcr);
+
 	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
 
 	/* Enable Auto enumeration */
@@ -1269,6 +1273,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	ctrl->bus.ops = &qcom_swrm_ops;
 	ctrl->bus.port_ops = &qcom_swrm_port_ops;
 	ctrl->bus.compute_params = &qcom_swrm_compute_params;
+	ctrl->audio_cgcr = devm_reset_control_get_exclusive(dev, "swr_audio_cgcr");
+	if (IS_ERR(ctrl->audio_cgcr))
+		dev_err(dev, "Failed to get audio_cgcr reset required for soundwire-v1.6.0\n");
 
 	ret = qcom_swrm_get_port_config(ctrl);
 	if (ret)
-- 
2.7.4

