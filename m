Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4C559F8A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbiFXRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiFXRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:15:28 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128DD63631;
        Fri, 24 Jun 2022 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656090928; x=1687626928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NddpGk/hbDeyIsIAOJl8eVnfk95qc1EZrjqf8uaTXws=;
  b=Gt027N5ryn7AFUP0kVmtF/Tl+N7ozyN6hpC7Q/u9RlHvoM+QkzHwpIFN
   MxfZyXs8n5yYjBOwf37w7bYoVSxaiMDB17Kg1wd2kplcxnrViWxN6hr4X
   W/KLBYWwLfLqvGoQwzgUEut8uqvM6SVMOoQY204YwRe5m7FFco9M6FyeW
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jun 2022 10:15:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 10:15:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 10:15:26 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 10:15:26 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] drm/msm/dp: decoupling dp->id out of dp controller_id at scxxxx_dp_cfg table
Date:   Fri, 24 Jun 2022 10:15:11 -0700
Message-ID: <1656090912-18074-3-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
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

Current the index (dp->id) of DP descriptor table (scxxxx_dp_cfg[]) are tightly
coupled with DP controller_id. This means DP use controller id 0 must be placed
at first entry of DP descriptor table (scxxxx_dp_cfg[]). Otherwise the internal
INTF will mismatch controller_id. This will cause controller kickoff wrong
interface timing engine and cause dpu_encoder_phys_vid_wait_for_commit_done
vblank timeout error.

This patch add controller_id field into struct msm_dp_desc to break the tightly
coupled relationship between index (dp->id) of DP descriptor table with DP
controller_id.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 16 ++++++++++------
 drivers/gpu/drm/msm/dp/dp_display.c     | 30 +++++++++++++++++++++++-------
 drivers/gpu/drm/msm/msm_drv.h           |  2 ++
 3 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 2b9d931..8feeb89 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -615,7 +615,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 					    struct dpu_kms *dpu_kms)
 {
 	struct drm_encoder *encoder = NULL;
-	struct msm_display_info info;
+	struct msm_display_info *info;
 	int rc;
 	int i;
 
@@ -637,11 +637,15 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 			return rc;
 		}
 
-		info.num_of_h_tiles = 1;
-		info.h_tile_instance[0] = i;
-		info.capabilities = MSM_DISPLAY_CAP_VID_MODE;
-		info.intf_type = encoder->encoder_type;
-		rc = dpu_encoder_setup(dev, encoder, &info);
+		info = &priv->info[i];
+		info->intf_type = encoder->encoder_type;
+		/*
+		 * info->capabilities, info->num_of_h_tiles and
+		 * info->h_tile_instance are populated at
+		 * dp_display_bind()
+		 */
+
+		rc = dpu_encoder_setup(dev, encoder, info);
 		if (rc) {
 			DPU_ERROR("failed to setup DPU encoder %d: rc:%d\n",
 				  encoder->base.id, rc);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index da5c03a..a87a9d8 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -77,6 +77,7 @@ struct dp_display_private {
 	int irq;
 
 	unsigned int id;
+	unsigned int controller_id;
 
 	/* state variables */
 	bool core_initialized;
@@ -123,6 +124,7 @@ struct dp_display_private {
 struct msm_dp_desc {
 	phys_addr_t io_start;
 	unsigned int connector_type;
+	unsigned int controller_id;
 	bool wide_bus_en;
 };
 
@@ -133,31 +135,38 @@ struct msm_dp_config {
 
 static const struct msm_dp_config sc7180_dp_cfg = {
 	.descs = (const struct msm_dp_desc[]) {
-		[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+		{ .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort,
+		.controller_id = MSM_DP_CONTROLLER_0 },
 	},
 	.num_descs = 1,
 };
 
 static const struct msm_dp_config sc7280_dp_cfg = {
 	.descs = (const struct msm_dp_desc[]) {
-		[MSM_DP_CONTROLLER_0] =	{ .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort, .wide_bus_en = true },
-		[MSM_DP_CONTROLLER_1] =	{ .io_start = 0x0aea0000, .connector_type = DRM_MODE_CONNECTOR_eDP, .wide_bus_en = true },
+		{ .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort,
+		.controller_id = MSM_DP_CONTROLLER_0, .wide_bus_en = true },
+		{ .io_start = 0x0aea0000, .connector_type = DRM_MODE_CONNECTOR_eDP, 
+		.controller_id = MSM_DP_CONTROLLER_1, .wide_bus_en = true },
 	},
 	.num_descs = 2,
 };
 
 static const struct msm_dp_config sc8180x_dp_cfg = {
 	.descs = (const struct msm_dp_desc[]) {
-		[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
-		[MSM_DP_CONTROLLER_1] = { .io_start = 0x0ae98000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
-		[MSM_DP_CONTROLLER_2] = { .io_start = 0x0ae9a000, .connector_type = DRM_MODE_CONNECTOR_eDP },
+		{.io_start = 0x0ae9a000, .connector_type = DRM_MODE_CONNECTOR_eDP,
+		.controller_id = MSM_DP_CONTROLLER_2 },
+		{ .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort,
+		.controller_id = MSM_DP_CONTROLLER_0 },
+		{ .io_start = 0x0ae98000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort,
+		.controller_id = MSM_DP_CONTROLLER_1 },
 	},
 	.num_descs = 3,
 };
 
 static const struct msm_dp_config sm8350_dp_cfg = {
 	.descs = (const struct msm_dp_desc[]) {
-		[MSM_DP_CONTROLLER_0] = { .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort },
+		{ .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort,
+		.controller_id = MSM_DP_CONTROLLER_0 },
 	},
 	.num_descs = 1,
 };
@@ -260,10 +269,16 @@ static int dp_display_bind(struct device *dev, struct device *master,
 	struct dp_display_private *dp = dev_get_dp_display_private(dev);
 	struct msm_drm_private *priv = dev_get_drvdata(master);
 	struct drm_device *drm = priv->dev;
+	struct msm_display_info *info;
 
 	dp->dp_display.drm_dev = drm;
 	priv->dp[dp->id] = &dp->dp_display;
 
+	info = &priv->info[dp->id];
+	info->num_of_h_tiles = 1;
+	info->h_tile_instance[0] = dp->controller_id;
+	info->capabilities = MSM_DISPLAY_CAP_VID_MODE;
+	
 	rc = dp->parser->parse(dp->parser);
 	if (rc) {
 		DRM_ERROR("device tree parsing failed\n");
@@ -1308,6 +1323,7 @@ static int dp_display_probe(struct platform_device *pdev)
 	dp->pdev = pdev;
 	dp->name = "drm_dp";
 	dp->dp_display.connector_type = desc->connector_type;
+	dp->controller_id =  desc->controller_id;
 	dp->wide_bus_en = desc->wide_bus_en;
 	dp->dp_display.is_edp =
 		(dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index f9c263b..71ab699 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -150,6 +150,8 @@ struct msm_drm_private {
 
 	struct msm_dp *dp[MSM_DP_CONTROLLER_COUNT];
 
+	struct msm_display_info info[MSM_DP_CONTROLLER_COUNT];
+
 	/* when we have more than one 'msm_gpu' these need to be an array: */
 	struct msm_gpu *gpu;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

