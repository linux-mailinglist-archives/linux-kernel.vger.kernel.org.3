Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C64E71EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354759AbiCYLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354518AbiCYLH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:07:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB78D0AA1;
        Fri, 25 Mar 2022 04:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 29DD0CE2953;
        Fri, 25 Mar 2022 11:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1A5C36AE3;
        Fri, 25 Mar 2022 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648206378;
        bh=omIbZILoo5u9ad9N2EJpz5YKU66lpls9PsTk8/rgTos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrPgZwgufEL1X9gADj86fh89hqf0XSBTP4kchkYps9wyHr/x6P2YlVERGbMOfYt9R
         Nrt/2SI6Wzm8vnDvVgEyNhYaWEIM3qWP3f+GO7YF6yX2mb3Ytnk+/Ju1yPVRH5HRS+
         FkhlTyEWWL0CK9SHcrlDbENphXIwt0GkdAN4a3wKlU8tofunkiHdtYIpZ9/rn1Ihhh
         Ztd9jAnX70UUfo4AFG5GwTM9UW11oPdZYws5RRzOdDuiNNewGE9AwKNh4ArC908PIy
         udrr4qG5m9cXPTfszUaAw7vMNu+NYb4Uqw/JclQ+lr0CWEbkCNjFPQBb6VjyAHs+m+
         iMqa8gX6jwy6Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH v5 02/13] drm/msm/dsi: Pass DSC params to drm_panel
Date:   Fri, 25 Mar 2022 16:35:45 +0530
Message-Id: <20220325110556.275490-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325110556.275490-1-vkoul@kernel.org>
References: <20220325110556.275490-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  2 ++
 drivers/gpu/drm/msm/dsi/dsi.c           |  5 +++++
 drivers/gpu/drm/msm/dsi/dsi.h           |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c      | 22 ++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h           |  8 ++++++++
 include/drm/drm_panel.h                 |  7 +++++++
 6 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 47fe11a84a77..ef6ddac22767 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -578,6 +578,8 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
 			MSM_DISPLAY_CAP_CMD_MODE :
 			MSM_DISPLAY_CAP_VID_MODE;
 
+		info.dsc = msm_dsi_get_dsc_config(priv->dsi[i]);
+
 		if (msm_dsi_is_bonded_dsi(priv->dsi[i]) && priv->dsi[other]) {
 			rc = msm_dsi_modeset_init(priv->dsi[other], dev, encoder);
 			if (rc) {
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 052548883d27..3aeac15e7421 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -20,6 +20,11 @@ bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
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
index 27553194f9fa..7e9913eff724 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2059,9 +2059,24 @@ int msm_dsi_host_modeset_init(struct mipi_dsi_host *host,
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
@@ -2626,3 +2641,10 @@ void msm_dsi_host_test_pattern_en(struct mipi_dsi_host *host)
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
index 384f9bad4760..e7a312edfe67 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -119,6 +119,7 @@ struct msm_display_topology {
  *                      based on num_of_h_tiles
  * @is_te_using_watchdog_timer:  Boolean to indicate watchdog TE is
  *				 used instead of panel TE in cmd mode panels
+ * @dsc:		DSC configuration data for DSC-enabled displays
  */
 struct msm_display_info {
 	int intf_type;
@@ -126,6 +127,7 @@ struct msm_display_info {
 	uint32_t num_of_h_tiles;
 	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
 	bool is_te_using_watchdog_timer;
+	struct msm_display_dsc_config *dsc;
 };
 
 /* Commit/Event thread specific structure */
@@ -365,6 +367,7 @@ void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi
 bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
+struct msm_display_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
 #else
 static inline void __init msm_dsi_register(void)
 {
@@ -393,6 +396,11 @@ static inline bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
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

