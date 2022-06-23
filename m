Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56E8556F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 02:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358717AbiFWAZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 20:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357211AbiFWAZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 20:25:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD907653
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:25:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w24so9003923pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SygWKchO0k+y7yXsZh0lg7LZ0sosds739AKDKHLdzm8=;
        b=b3st9LQI8EUcf4vRZkN9FuY8JTgqSsuawrFH9hFAlJZTkVCtFxFALeeL3f82fotnXr
         6LDOe5qKxy8Vz+vQ0mmD1l7s+y6QJmxrb/atmlIsrpBBGx6kLWqfcw1LvOF5iyJO1MCP
         c2DKMugV/35nUO1ROV12YG7FUQWLGIYSHRSiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SygWKchO0k+y7yXsZh0lg7LZ0sosds739AKDKHLdzm8=;
        b=uKFgyjOqPW2h43WBujGmbQe0IG5tlUrmePz5fXbQcmfkRGN0KU/U4tgryj34dh4s85
         vdHWuzHWtYxlJyvLQqEcmH2SnPHG/69tvPf3tSovsmGb/8s4EWrjiqUyKNS52rqcIPVu
         9/fc8Ygs+3UKzU0KLQu+Oq7xiRql5FnqA4ZBAk+1P8J4gbFaaKoP6XTqS435/Kf/4Pv0
         OjBF7LGbdQillIv4ATJgT8CPcMijXKz8V1xE4dBAUjGvDYOuBJWGkVSdqaDs3V7uswX4
         tPMTpNFqpljIa9C3OWl34DO8A4CSJbvwbFG7Vn8pXrqwOIcLK5bqvpxM2UcdVCjW66Fj
         zuPA==
X-Gm-Message-State: AJIora/1Lj6Q8XU2UnviWGPEbVbB47lAUB//wYF8eH9Nqjgnv3bDwqT2
        VtsaR6LcxutRca1WgZR68mxyww==
X-Google-Smtp-Source: AGRyM1vljkq/ZMbBKLNrU/5jd/GiIb1Avw040L4R6xvEuHNHC8lbPLZXn68o6WxIfLbKiAsrJ+bvnw==
X-Received: by 2002:a17:902:b216:b0:16a:854:e641 with SMTP id t22-20020a170902b21600b0016a0854e641mr29379561plr.154.1655943946136;
        Wed, 22 Jun 2022 17:25:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f28c:6f86:743c:1c04])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903024100b00163fbb1eec5sm13332705plh.229.2022.06.22.17.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 17:25:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH v2 3/3] drm/msm/dp: Get rid of dp_ctrl_on_stream_phy_test_report()
Date:   Wed, 22 Jun 2022 17:25:40 -0700
Message-Id: <20220623002540.871994-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.104.g0611611a94-goog
In-Reply-To: <20220623002540.871994-1-swboyd@chromium.org>
References: <20220623002540.871994-1-swboyd@chromium.org>
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

This API isn't really more than a couple lines now that we don't store
the pixel_rate to the struct member. Inline it into the caller.

Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 44 ++++++++++++--------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index feb26d4d6e97..e475f4ca078a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1564,36 +1564,15 @@ static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
 	return success;
 }
 
-static int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
+static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
 {
 	int ret;
-	struct dp_ctrl_private *ctrl;
 	unsigned long pixel_rate;
 
-	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
-
-	pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
-	dp_ctrl_set_clock_rate(ctrl, DP_STREAM_PM, "stream_pixel", pixel_rate * 1000);
-
-	ret = dp_power_clk_enable(ctrl->power, DP_STREAM_PM, true);
-	if (ret) {
-		DRM_ERROR("Unable to start pixel clocks. ret=%d\n", ret);
-		return ret;
-	}
-
-	dp_ctrl_send_phy_test_pattern(ctrl);
-
-	return 0;
-}
-
-static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
-{
-	int ret = 0;
-
 	if (!ctrl->link->phy_params.phy_test_pattern_sel) {
 		drm_dbg_dp(ctrl->drm_dev,
 			"no test pattern selected by sink\n");
-		return ret;
+		return 0;
 	}
 
 	/*
@@ -1608,12 +1587,23 @@ static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
 	}
 
 	ret = dp_ctrl_on_link(&ctrl->dp_ctrl);
-	if (!ret)
-		ret = dp_ctrl_on_stream_phy_test_report(&ctrl->dp_ctrl);
-	else
+	if (ret) {
 		DRM_ERROR("failed to enable DP link controller\n");
+		return ret;
+	}
 
-	return ret;
+	pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
+	dp_ctrl_set_clock_rate(ctrl, DP_STREAM_PM, "stream_pixel", pixel_rate * 1000);
+
+	ret = dp_power_clk_enable(ctrl->power, DP_STREAM_PM, true);
+	if (ret) {
+		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
+		return ret;
+	}
+
+	dp_ctrl_send_phy_test_pattern(ctrl);
+
+	return 0;
 }
 
 void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl)
-- 
https://chromeos.dev

