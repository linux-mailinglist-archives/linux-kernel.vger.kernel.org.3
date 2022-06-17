Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6D54FEB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382725AbiFQUr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359556AbiFQUry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:47:54 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6BE65A4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:47:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x138so5077231pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ByN+wCXaOxi271nnEIZ20wtThFUPoDse0EkNhfr7LCE=;
        b=eIwcGaOBfUoWV4QGJeTDfvsmyotQRYQB6zsaQIRyV1maGpuVoPAlQB3RThmxv4Hos8
         jj4yc7Rufi0MaAymjjwUWqflreOIgzvMyGYd/Z4cQTmiokLd6qUkFa0MYo1Y1nee+b/g
         sf5w340ndmzZ6mbvxm9sfKgndB7bSzaASL6vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByN+wCXaOxi271nnEIZ20wtThFUPoDse0EkNhfr7LCE=;
        b=7IffAy4orfYKo/AA4T2RkHkApDmjVOQAsvq4MNt4gi/UuZi77BAcLM1MiSk7xVaZj+
         eLeFUtAeGodX+1gAFouqPCY0nH5DF+WPFTnW5zKb9+KGXswYVAmbJ6G9kHQTb+PupZTo
         nRX6gWnBedL6B/4XJhRfeQYdirMCrw0EqqqQDRt9CT3q0g8QOmbB8rrmnYpCwzvk7/MJ
         ZGzRZyEIQ1D1QxYA/jdOVS/1/jLDcv+sJENWaJ5v4w4Iy8XLSl7yqvW3uLaMzGlgGdON
         t+JNN+BZ67NaU1e1wZtV0PRasbhHGeiVwc6YT7lDsTK6hmKNo2CxvurnW3F3VAd6rh3B
         Mo1g==
X-Gm-Message-State: AJIora9QahiZW8o+s9b+Bev1Y29u6e/wanHpKOebycmDII5xUcscY3FK
        0EagqW5w3dIyZeRspBP+1tk8Bg==
X-Google-Smtp-Source: AGRyM1slGiViNrdzjVzcJOZuNc8QQfUtUDCVS+hnpTK9qGAD4qXmlvfW7+GU2rKzC3z/BPQ12WJFmQ==
X-Received: by 2002:a63:140e:0:b0:408:a923:1a81 with SMTP id u14-20020a63140e000000b00408a9231a81mr10419194pgl.358.1655498873182;
        Fri, 17 Jun 2022 13:47:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:52e2:7dc8:1e20:f870])
        by smtp.gmail.com with ESMTPSA id z12-20020aa79f8c000000b0052089e1b88esm4098325pfr.192.2022.06.17.13.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:47:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 1/3] drm/msm/dp: Reorganize code to avoid forward declaration
Date:   Fri, 17 Jun 2022 13:47:48 -0700
Message-Id: <20220617204750.2347797-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220617204750.2347797-1-swboyd@chromium.org>
References: <20220617204750.2347797-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move these functions around to avoid having to forward declare
dp_ctrl_on_stream_phy_test_report(). Also remove
dp_ctrl_reinitialize_mainlink() forward declaration because we're doing
that sort of task.

Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 104 +++++++++++++++----------------
 1 file changed, 50 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 703249384e7c..bd445e683cfc 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1238,8 +1238,6 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
 	return -ETIMEDOUT;
 }
 
-static int dp_ctrl_reinitialize_mainlink(struct dp_ctrl_private *ctrl);
-
 static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
 			int *training_step)
 {
@@ -1534,38 +1532,6 @@ static int dp_ctrl_link_maintenance(struct dp_ctrl_private *ctrl)
 	return ret;
 }
 
-static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl);
-
-static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
-{
-	int ret = 0;
-
-	if (!ctrl->link->phy_params.phy_test_pattern_sel) {
-		drm_dbg_dp(ctrl->drm_dev,
-			"no test pattern selected by sink\n");
-		return ret;
-	}
-
-	/*
-	 * The global reset will need DP link related clocks to be
-	 * running. Add the global reset just before disabling the
-	 * link clocks and core clocks.
-	 */
-	ret = dp_ctrl_off(&ctrl->dp_ctrl);
-	if (ret) {
-		DRM_ERROR("failed to disable DP controller\n");
-		return ret;
-	}
-
-	ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
-	if (!ret)
-		ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
-	else
-		DRM_ERROR("failed to enable DP link controller\n");
-
-	return ret;
-}
-
 static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
 {
 	bool success = false;
@@ -1618,6 +1584,56 @@ static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
 	return success;
 }
 
+static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
+{
+	int ret;
+	struct dp_ctrl_private *ctrl;
+
+	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
+
+	ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
+
+	ret = dp_ctrl_enable_stream_clocks(ctrl);
+	if (ret) {
+		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
+		return ret;
+	}
+
+	dp_ctrl_send_phy_test_pattern(ctrl);
+
+	return 0;
+}
+
+static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
+{
+	int ret = 0;
+
+	if (!ctrl->link->phy_params.phy_test_pattern_sel) {
+		drm_dbg_dp(ctrl->drm_dev,
+			"no test pattern selected by sink\n");
+		return ret;
+	}
+
+	/*
+	 * The global reset will need DP link related clocks to be
+	 * running. Add the global reset just before disabling the
+	 * link clocks and core clocks.
+	 */
+	ret = dp_ctrl_off(&ctrl->dp_ctrl);
+	if (ret) {
+		DRM_ERROR("failed to disable DP controller\n");
+		return ret;
+	}
+
+	ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
+	if (!ret)
+		ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
+	else
+		DRM_ERROR("failed to enable DP link controller\n");
+
+	return ret;
+}
+
 void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl)
 {
 	struct dp_ctrl_private *ctrl;
@@ -1815,26 +1831,6 @@ static int dp_ctrl_link_retrain(struct dp_ctrl_private *ctrl)
 	return dp_ctrl_setup_main_link(ctrl, &training_step);
 }
 
-static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
-{
-	int ret;
-	struct dp_ctrl_private *ctrl;
-
-	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
-
-	ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
-
-	ret = dp_ctrl_enable_stream_clocks(ctrl);
-	if (ret) {
-		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
-		return ret;
-	}
-
-	dp_ctrl_send_phy_test_pattern(ctrl);
-
-	return 0;
-}
-
 int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
 {
 	int ret = 0;
-- 
https://chromeos.dev

