Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0038E4B3132
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 00:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354039AbiBKXXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 18:23:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353966AbiBKXXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:23:54 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF8ECEC;
        Fri, 11 Feb 2022 15:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644621832; x=1676157832;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=aj2EOG9ZouL6YKsRhVCJcocmnf4igxufIIxojrrM+/U=;
  b=vI0HW/4Dls93MSUjPf10P8p0iUnQS2A/4TF8pbCDxB7llrKZ2967eaKq
   ykiy5hUg+DGd60LpwWPlM7JMeBN6rTU3ESdBCSuuRYF1enrdzboDr8zjo
   //LFJdYoNLmvlw0dcUNMsw7dCvsYW4Fw6FfJvtixYjNc44QSTejNxaG/J
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Feb 2022 15:23:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 15:23:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 15:23:50 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 11 Feb 2022 15:23:49 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_khsieh@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/msm: populate intf_audio_select() base on hardware capability
Date:   Fri, 11 Feb 2022 15:23:42 -0800
Message-ID: <1644621822-25407-1-git-send-email-quic_khsieh@quicinc.com>
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

intf_audio_select() callback function use to configure
HDMI_DP_CORE_SELECT to decide audio output routes to HDMI or DP
interface. HDMI is obsoleted at newer chipset. To keep supporting
legacy hdmi application, intf_audio_select call back function have
to be populated base on hardware chip capability where legacy
chipsets have has_audio_select flag set to true.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c     | 9 ++++++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 272b14b..23680e7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -201,6 +201,7 @@ static const struct dpu_caps sdm845_dpu_caps = {
 	.has_dim_layer = true,
 	.has_idle_pc = true,
 	.has_3d_merge = true,
+	.has_audio_select = true,
 	.max_linewidth = DEFAULT_DPU_OUTPUT_LINE_WIDTH,
 	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
 	.max_hdeci_exp = MAX_HORZ_DECIMATION,
@@ -229,6 +230,7 @@ static const struct dpu_caps sm8150_dpu_caps = {
 	.has_dim_layer = true,
 	.has_idle_pc = true,
 	.has_3d_merge = true,
+	.has_audio_select = true,
 	.max_linewidth = 4096,
 	.pixel_ram_size = DEFAULT_PIXEL_RAM_SIZE,
 	.max_hdeci_exp = MAX_HORZ_DECIMATION,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index e5a96d6..b33f91b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -357,6 +357,7 @@ struct dpu_caps {
 	bool has_dim_layer;
 	bool has_idle_pc;
 	bool has_3d_merge;
+	bool has_audio_select;
 	/* SSPP limits */
 	u32 max_linewidth;
 	u32 pixel_ram_size;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
index 282e3c6..e608f4d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
@@ -261,14 +261,17 @@ static void dpu_hw_intf_audio_select(struct dpu_hw_mdp *mdp)
 }
 
 static void _setup_mdp_ops(struct dpu_hw_mdp_ops *ops,
-		unsigned long cap)
+		unsigned long cap,
+		const struct dpu_mdss_cfg *m)
 {
 	ops->setup_split_pipe = dpu_hw_setup_split_pipe;
 	ops->setup_clk_force_ctrl = dpu_hw_setup_clk_force_ctrl;
 	ops->get_danger_status = dpu_hw_get_danger_status;
 	ops->setup_vsync_source = dpu_hw_setup_vsync_source;
 	ops->get_safe_status = dpu_hw_get_safe_status;
-	ops->intf_audio_select = dpu_hw_intf_audio_select;
+
+	if (m->caps->has_audio_select)
+		ops->intf_audio_select = dpu_hw_intf_audio_select;
 }
 
 static const struct dpu_mdp_cfg *_top_offset(enum dpu_mdp mdp,
@@ -320,7 +323,7 @@ struct dpu_hw_mdp *dpu_hw_mdptop_init(enum dpu_mdp idx,
 	 */
 	mdp->idx = idx;
 	mdp->caps = cfg;
-	_setup_mdp_ops(&mdp->ops, mdp->caps->features);
+	_setup_mdp_ops(&mdp->ops, mdp->caps->features, m);
 
 	return mdp;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

