Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB94F5FCC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiDFNI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiDFNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:07:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80265E3C28;
        Wed,  6 Apr 2022 02:41:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24474B821F7;
        Wed,  6 Apr 2022 09:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FD4C385A8;
        Wed,  6 Apr 2022 09:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649238090;
        bh=rzOQqeQjTPMlc735N7xJrYNzCHkjJGD3CLA4kWFFXVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsmLZnAUCJjO+U+L3dKendSoMYuhn2eqy8osmJvvIhBTjLqdB37IWZNzZpA9S73Cg
         3SNg0GLiAsbq4hw25fmQf+7zMTesohfk3usDw4LZafpHNNJqGVu3pYwF8bmyts2xXM
         hDbbOOD7lReLeMch8h6BpX3wI/UWOCIVfzjAVM2Wt5OevqPnkdUbK1QoOjUUcU7AC3
         HySgSOamM/bTmZiJEINAo+FC+If6X9aCs8EII6r0y2ixmu1hPSKRmJIXq4ublR46nm
         0rt1RX1rCwp8irtAfwzMWmf2EkKaq+AiAFBrlDJ/HKmtN0Z83erUqDGYwhIcnyA+Ub
         uH3A4s30e2Bvw==
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
Subject: [PATCH v7 12/14] drm/msm/dsi: add mode valid callback for dsi_mgr
Date:   Wed,  6 Apr 2022 15:10:29 +0530
Message-Id: <20220406094031.1027376-13-vkoul@kernel.org>
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

Add a mode valid callback for dsi_mgr for checking mode being valid in
case of DSC. For DSC the height and width needs to be multiple of slice,
so we check that here

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi.h         |  2 ++
 drivers/gpu/drm/msm/dsi/dsi_host.c    | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 12 ++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 16cd9b2fce86..580a1e6358bf 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -114,6 +114,8 @@ int msm_dsi_host_power_on(struct mipi_dsi_host *host,
 int msm_dsi_host_power_off(struct mipi_dsi_host *host);
 int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
 				  const struct drm_display_mode *mode);
+enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
+					    const struct drm_display_mode *mode);
 struct drm_panel *msm_dsi_host_get_panel(struct mipi_dsi_host *host);
 unsigned long msm_dsi_host_get_mode_flags(struct mipi_dsi_host *host);
 struct drm_bridge *msm_dsi_host_get_bridge(struct mipi_dsi_host *host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index cb2e179127ea..eb0be34add45 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2554,6 +2554,32 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
 	return 0;
 }
 
+enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
+					    const struct drm_display_mode *mode)
+{
+	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
+	struct msm_display_dsc_config *dsc = msm_host->dsc;
+	int pic_width = mode->hdisplay;
+	int pic_height = mode->vdisplay;
+
+	if (!msm_host->dsc)
+		return MODE_OK;
+
+	if (pic_width % dsc->drm->slice_width) {
+		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
+		       pic_width, dsc->drm->slice_width);
+		return MODE_H_ILLEGAL;
+	}
+
+	if (pic_height % dsc->drm->slice_height) {
+		pr_err("DSI: pic_height %d has to be multiple of slice %d\n",
+		       pic_height, dsc->drm->slice_height);
+		return MODE_V_ILLEGAL;
+	}
+
+	return MODE_OK;
+}
+
 struct drm_panel *msm_dsi_host_get_panel(struct mipi_dsi_host *host)
 {
 	return of_drm_find_panel(to_msm_dsi_host(host)->device_node);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 0c1b7dde377c..100a8fcbddee 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -573,6 +573,17 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
 	dsi_mgr_bridge_power_on(bridge);
 }
 
+static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
+						      const struct drm_display_info *info,
+						      const struct drm_display_mode *mode)
+{
+	int id = dsi_mgr_bridge_get_id(bridge);
+	struct msm_dsi *msm_dsi = dsi_mgr_get_dsi(id);
+	struct mipi_dsi_host *host = msm_dsi->host;
+
+	return msm_dsi_host_check_dsc(host, mode);
+}
+
 static const struct drm_connector_funcs dsi_mgr_connector_funcs = {
 	.detect = dsi_mgr_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
@@ -593,6 +604,7 @@ static const struct drm_bridge_funcs dsi_mgr_bridge_funcs = {
 	.disable = dsi_mgr_bridge_disable,
 	.post_disable = dsi_mgr_bridge_post_disable,
 	.mode_set = dsi_mgr_bridge_mode_set,
+	.mode_valid = dsi_mgr_bridge_mode_valid,
 };
 
 /* initialize connector when we're connected to a drm_panel */
-- 
2.34.1

