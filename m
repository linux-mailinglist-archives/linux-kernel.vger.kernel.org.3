Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7691B54FED8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382864AbiFQUsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377905AbiFQUrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:47:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BFE2BC1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:47:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id s37so5078202pfg.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMNoixv5Y3qsAebD0G5IYmMWYO2NVrDKFpWelKo7ZYA=;
        b=DwAKj5hU7XxEk73p7uOwKh762e+QzETDqC3hbDVnRwxMQBTNbMPnGkmQmqIVFRBM6Z
         2uL2Ym278pMDCX5cvIMB9388irWNnAoFG5Aur+lP8NVPwUS1C8RlH3hUT2mAEfw8h2h1
         RlHIwiEYwL2gQ8OoqXgoGmiFgA5eHjBDKezQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMNoixv5Y3qsAebD0G5IYmMWYO2NVrDKFpWelKo7ZYA=;
        b=Qm9Iv0q/JoHVH3oBWBanJ3r/us0pZ+XPDEUJKE7UumUgE5JDW7DGQi/iUJpJxn0KKW
         5nRVdRCNYwbeAlLHu/vdUWPPJTtJ3nHtr/HP4WagayfHSzGr2pi5RRUBIkSdU5y8pK7Z
         M7MR+ZkTTzrx8WtK/rCUo6qsITtUocHDgiS92joHxhZpAEaCWEYnBFZaUAN+r25qO55/
         wBl5QaWBhcehNKJmw4QblDBZwkcm7EFUt/XVTO/VLvdOlDb9ROeKq0P+4ycO8GEi+jlu
         SKIQWsKU4q6cJzcTPTAPx22Ykqc9wgYNgYPbX8EjIl1ismuXFDEW/WUHrbnj3dQh0s2n
         U3+g==
X-Gm-Message-State: AJIora9xT19KQbr6g9/OwHo6BmGrurBq6KJIp6mnVONM+aJn6RPAAxMr
        Za6TS3Hi9cE/V5lsh+nvewp/ZA==
X-Google-Smtp-Source: AGRyM1u+s+YlgWsAAWnGZ5F3EpyUl3ftH+1yKIqhCN/cckxSBSkKmkSwxL2gzegku6DKprMS5XgWkQ==
X-Received: by 2002:a05:6a00:2311:b0:4e1:52bf:e466 with SMTP id h17-20020a056a00231100b004e152bfe466mr12007494pfh.77.1655498874110;
        Fri, 17 Jun 2022 13:47:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:52e2:7dc8:1e20:f870])
        by smtp.gmail.com with ESMTPSA id z12-20020aa79f8c000000b0052089e1b88esm4098325pfr.192.2022.06.17.13.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:47:53 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 2/3] drm/msm/dp: Remove pixel_rate from struct dp_ctrl
Date:   Fri, 17 Jun 2022 13:47:49 -0700
Message-Id: <20220617204750.2347797-3-swboyd@chromium.org>
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

This struct member is stored to in the function that calls the function
which uses it. That's possible with a function argument instead of
storing to a struct member. Pass the pixel_rate as an argument instead
to simplify the code. Note that dp_ctrl_link_maintenance() was storing
the pixel_rate but never using it so we just remove the assignment from
there.

Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 57 ++++++++++++++++----------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h |  1 -
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index bd445e683cfc..e114521af2e9 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1336,7 +1336,7 @@ static void dp_ctrl_set_clock_rate(struct dp_ctrl_private *ctrl,
 				name, rate);
 }
 
-static int dp_ctrl_enable_mainlink_clocks(struct dp_ctrl_private *ctrl)
+static int dp_ctrl_enable_mainlink_clocks(struct dp_ctrl_private *ctrl, unsigned long pixel_rate)
 {
 	int ret = 0;
 	struct dp_io *dp_io = &ctrl->parser->io;
@@ -1357,25 +1357,25 @@ static int dp_ctrl_enable_mainlink_clocks(struct dp_ctrl_private *ctrl)
 	if (ret)
 		DRM_ERROR("Unable to start link clocks. ret=%d\n", ret);
 
-	drm_dbg_dp(ctrl->drm_dev, "link rate=%d pixel_clk=%d\n",
-		ctrl->link->link_params.rate, ctrl->dp_ctrl.pixel_rate);
+	drm_dbg_dp(ctrl->drm_dev, "link rate=%d pixel_clk=%lu\n",
+		ctrl->link->link_params.rate, pixel_rate);
 
 	return ret;
 }
 
-static int dp_ctrl_enable_stream_clocks(struct dp_ctrl_private *ctrl)
+static int dp_ctrl_enable_stream_clocks(struct dp_ctrl_private *ctrl,
+					unsigned long pixel_rate)
 {
-	int ret = 0;
+	int ret;
 
-	dp_ctrl_set_clock_rate(ctrl, DP_STREAM_PM, "stream_pixel",
-					ctrl->dp_ctrl.pixel_rate * 1000);
+	dp_ctrl_set_clock_rate(ctrl, DP_STREAM_PM, "stream_pixel", pixel_rate * 1000);
 
 	ret = dp_power_clk_enable(ctrl->power, DP_STREAM_PM, true);
 	if (ret)
 		DRM_ERROR("Unabled to start pixel clocks. ret=%d\n", ret);
 
-	drm_dbg_dp(ctrl->drm_dev, "link rate=%d pixel_clk=%d\n",
-			ctrl->link->link_params.rate, ctrl->dp_ctrl.pixel_rate);
+	drm_dbg_dp(ctrl->drm_dev, "link rate=%d pixel_clk=%lu\n",
+			ctrl->link->link_params.rate, pixel_rate);
 
 	return ret;
 }
@@ -1445,7 +1445,7 @@ static bool dp_ctrl_use_fixed_nvid(struct dp_ctrl_private *ctrl)
 	return false;
 }
 
-static int dp_ctrl_reinitialize_mainlink(struct dp_ctrl_private *ctrl)
+static int dp_ctrl_reinitialize_mainlink(struct dp_ctrl_private *ctrl, unsigned long pixel_rate)
 {
 	int ret = 0;
 	struct dp_io *dp_io = &ctrl->parser->io;
@@ -1469,7 +1469,7 @@ static int dp_ctrl_reinitialize_mainlink(struct dp_ctrl_private *ctrl)
 	/* hw recommended delay before re-enabling clocks */
 	msleep(20);
 
-	ret = dp_ctrl_enable_mainlink_clocks(ctrl);
+	ret = dp_ctrl_enable_mainlink_clocks(ctrl, pixel_rate);
 	if (ret) {
 		DRM_ERROR("Failed to enable mainlink clks. ret=%d\n", ret);
 		return ret;
@@ -1517,8 +1517,6 @@ static int dp_ctrl_link_maintenance(struct dp_ctrl_private *ctrl)
 	ctrl->link->phy_params.p_level = 0;
 	ctrl->link->phy_params.v_level = 0;
 
-	ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
-
 	ret = dp_ctrl_setup_main_link(ctrl, &training_step);
 	if (ret)
 		goto end;
@@ -1588,12 +1586,12 @@ static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
 {
 	int ret;
 	struct dp_ctrl_private *ctrl;
+	unsigned long pixel_rate;
 
 	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
 
-	ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
-
-	ret = dp_ctrl_enable_stream_clocks(ctrl);
+	pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
+	ret = dp_ctrl_enable_stream_clocks(ctrl, pixel_rate);
 	if (ret) {
 		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
 		return ret;
@@ -1709,6 +1707,7 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 	u32 const phy_cts_pixel_clk_khz = 148500;
 	u8 link_status[DP_LINK_STATUS_SIZE];
 	unsigned int training_step;
+	unsigned long pixel_rate;
 
 	if (!dp_ctrl)
 		return -EINVAL;
@@ -1723,25 +1722,25 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 		drm_dbg_dp(ctrl->drm_dev,
 				"using phy test link parameters\n");
 		if (!ctrl->panel->dp_mode.drm_mode.clock)
-			ctrl->dp_ctrl.pixel_rate = phy_cts_pixel_clk_khz;
+			pixel_rate = phy_cts_pixel_clk_khz;
 	} else {
 		ctrl->link->link_params.rate = rate;
 		ctrl->link->link_params.num_lanes =
 			ctrl->panel->link_info.num_lanes;
-		ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
+		pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
 	}
 
-	drm_dbg_dp(ctrl->drm_dev, "rate=%d, num_lanes=%d, pixel_rate=%d\n",
+	drm_dbg_dp(ctrl->drm_dev, "rate=%d, num_lanes=%d, pixel_rate=%lu\n",
 		ctrl->link->link_params.rate, ctrl->link->link_params.num_lanes,
-		ctrl->dp_ctrl.pixel_rate);
+		pixel_rate);
 
 
-	rc = dp_ctrl_enable_mainlink_clocks(ctrl);
+	rc = dp_ctrl_enable_mainlink_clocks(ctrl, pixel_rate);
 	if (rc)
 		return rc;
 
 	while (--link_train_max_retries) {
-		rc = dp_ctrl_reinitialize_mainlink(ctrl);
+		rc = dp_ctrl_reinitialize_mainlink(ctrl, pixel_rate);
 		if (rc) {
 			DRM_ERROR("Failed to reinitialize mainlink. rc=%d\n",
 					rc);
@@ -1836,6 +1835,7 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
 	int ret = 0;
 	bool mainlink_ready = false;
 	struct dp_ctrl_private *ctrl;
+	unsigned long pixel_rate;
 	unsigned long pixel_rate_orig;
 
 	if (!dp_ctrl)
@@ -1843,25 +1843,24 @@ int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
 
 	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
 
-	ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
+	pixel_rate = pixel_rate_orig = ctrl->panel->dp_mode.drm_mode.clock;
 
-	pixel_rate_orig = ctrl->dp_ctrl.pixel_rate;
 	if (dp_ctrl->wide_bus_en)
-		ctrl->dp_ctrl.pixel_rate >>= 1;
+		pixel_rate >>= 1;
 
-	drm_dbg_dp(ctrl->drm_dev, "rate=%d, num_lanes=%d, pixel_rate=%d\n",
+	drm_dbg_dp(ctrl->drm_dev, "rate=%d, num_lanes=%d, pixel_rate=%lu\n",
 		ctrl->link->link_params.rate,
-		ctrl->link->link_params.num_lanes, ctrl->dp_ctrl.pixel_rate);
+		ctrl->link->link_params.num_lanes, pixel_rate);
 
 	if (!dp_power_clk_status(ctrl->power, DP_CTRL_PM)) { /* link clk is off */
-		ret = dp_ctrl_enable_mainlink_clocks(ctrl);
+		ret = dp_ctrl_enable_mainlink_clocks(ctrl, pixel_rate);
 		if (ret) {
 			DRM_ERROR("Failed to start link clocks. ret=%d\n", ret);
 			goto end;
 		}
 	}
 
-	ret = dp_ctrl_enable_stream_clocks(ctrl);
+	ret = dp_ctrl_enable_stream_clocks(ctrl, pixel_rate);
 	if (ret) {
 		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
 		goto end;
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index b563e2e3bfe5..9f29734af81c 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -16,7 +16,6 @@
 struct dp_ctrl {
 	bool orientation;
 	atomic_t aborted;
-	u32 pixel_rate;
 	bool wide_bus_en;
 };
 
-- 
https://chromeos.dev

