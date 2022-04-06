Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC34F60F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiDFOGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiDFOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:06:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C0475846;
        Wed,  6 Apr 2022 02:41:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83F1161629;
        Wed,  6 Apr 2022 09:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718B7C385A8;
        Wed,  6 Apr 2022 09:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649238049;
        bh=x+m2MWCq6qFwh90X4cyqG6Rzi2rBlGxar0o6fHyYx9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNSeNrDj23At6EHMPg1C8m5Oz1arUCkHbccAcgjer2F7/6FHRapW4xfDAHAZYW/Df
         aEIh8Te2D4fRXNsmMgLuApoKtzl/pfOI7BW13H47pqcJxPPjpLAfU1bnnQGDTYXHjU
         EurkrPKnep+qF8WfOUjA9EzY0zUPoaUJBts96en6WJFhJqR5RllepO8IBL0CWkAfPl
         Az3BR9ktB5iE2RjlEx9TGXNpb0CvZc6YWHN/Y0TEpdNbj+Y32U0SGv5gc4Wlxncuc+
         dO0kpvU5ngEHubgD0vmY56ClCoR4EjF1rfHHEvBIVpROYwMo5BTGntacPbwgMtmCT2
         6BgIxgM1ukXRA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH v7 02/14] drm/msm/dsi: Pass DSC params to drm_panel
Date:   Wed,  6 Apr 2022 15:10:19 +0530
Message-Id: <20220406094031.1027376-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220406094031.1027376-1-vkoul@kernel.org>
References: <20220406094031.1027376-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DSC is enabled, we need to get the DSC parameters from the panel
driver, so add a dsc parameter in panel to fetch and pass DSC
configuration for DSI panels to DPU encoder, which will enable and
then configure DSC hardware blocks accordingly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  2 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |  2 ++
 drivers/gpu/drm/msm/dsi/dsi.c               |  5 +++++
 drivers/gpu/drm/msm/dsi/dsi.h               |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c          | 22 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h               |  6 ++++++
 include/drm/drm_panel.h                     |  7 +++++++
 7 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 42db6ce12caf..ef873e5285a0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -27,6 +27,7 @@
  *                      based on num_of_h_tiles
  * @is_te_using_watchdog_timer:  Boolean to indicate watchdog TE is
  *				 used instead of panel TE in cmd mode panels
+ * @dsc:		DSC configuration data for DSC-enabled displays
  */
 struct msm_display_info {
 	int intf_type;
@@ -34,6 +35,7 @@ struct msm_display_info {
 	uint32_t num_of_h_tiles;
 	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
 	bool is_te_using_watchdog_timer;
+	struct msm_display_dsc_config *dsc;
 };
 
 /**
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index e29796c4f27b..e64154407425 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -582,6 +582,8 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
 			MSM_DISPLAY_CAP_CMD_MODE :
 			MSM_DISPLAY_CAP_VID_MODE;
 
+		info.dsc = msm_dsi_get_dsc_config(priv->dsi[i]);
+
 		if (msm_dsi_is_bonded_dsi(priv->dsi[i]) && priv->dsi[other]) {
 			rc = msm_dsi_modeset_init(priv->dsi[other], dev, encoder);
 			if (rc) {
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index c12e66aa42a3..06a76834be52 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -21,6 +21,11 @@ bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
 	return !(host_flags & MIPI_DSI_MODE_VIDEO);
 }
 
+struct msm_display_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
+{
+	return msm_dsi_host_get_dsc_config(msm_dsi->host);
+}
+
 static int dsi_get_phy(struct msm_dsi *msm_dsi)
 {
 	struct platform_device *pdev = msm_dsi->pdev;
diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index c8dedc95428c..16cd9b2fce86 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -152,6 +152,7 @@ int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
 int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
 void msm_dsi_host_snapshot(struct msm_disp_state *disp_state, struct mipi_dsi_host *host);
 void msm_dsi_host_test_pattern_en(struct mipi_dsi_host *host);
+struct msm_display_dsc_config *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host);
 
 /* dsi phy */
 struct msm_dsi_phy;
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 4a8a9b31ce1d..cb2e179127ea 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2061,9 +2061,24 @@ int msm_dsi_host_modeset_init(struct mipi_dsi_host *host,
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
+	struct drm_panel *panel;
 	int ret;
 
 	msm_host->dev = dev;
+	panel = msm_dsi_host_get_panel(&msm_host->base);
+
+	if (panel && panel->dsc) {
+		struct msm_display_dsc_config *dsc = msm_host->dsc;
+
+		if (!dsc) {
+			dsc = devm_kzalloc(&msm_host->pdev->dev, sizeof(*dsc), GFP_KERNEL);
+			if (!dsc)
+				return -ENOMEM;
+			dsc->drm = panel->dsc;
+			msm_host->dsc = dsc;
+		}
+	}
+
 	ret = cfg_hnd->ops->tx_buf_alloc(msm_host, SZ_4K);
 	if (ret) {
 		pr_err("%s: alloc tx gem obj failed, %d\n", __func__, ret);
@@ -2628,3 +2643,10 @@ void msm_dsi_host_test_pattern_en(struct mipi_dsi_host *host)
 		dsi_write(msm_host, REG_DSI_TEST_PATTERN_GEN_CMD_STREAM0_TRIGGER,
 				DSI_TEST_PATTERN_GEN_CMD_STREAM0_TRIGGER_SW_TRIGGER);
 }
+
+struct msm_display_dsc_config *msm_dsi_host_get_dsc_config(struct mipi_dsi_host *host)
+{
+	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
+
+	return msm_host->dsc;
+}
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 57aee75f5022..2a3280df7b12 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -336,6 +336,7 @@ void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi
 bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
+struct msm_display_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
 #else
 static inline void __init msm_dsi_register(void)
 {
@@ -364,6 +365,11 @@ static inline bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
 {
 	return false;
 }
+
+static inline struct msm_display_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
+{
+	return NULL;
+}
 #endif
 
 #ifdef CONFIG_DRM_MSM_DP
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 4602f833eb51..eb8ae9bf32ed 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -171,6 +171,13 @@ struct drm_panel {
 	 * Panel entry in registry.
 	 */
 	struct list_head list;
+
+	/**
+	 * @dsc:
+	 *
+	 * Panel DSC pps payload to be sent
+	 */
+	struct drm_dsc_config *dsc;
 };
 
 void drm_panel_init(struct drm_panel *panel, struct device *dev,
-- 
2.34.1

