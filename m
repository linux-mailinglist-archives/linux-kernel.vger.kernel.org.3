Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC8754FEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383300AbiFQUsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381762AbiFQUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:47:56 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE2D104
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:47:55 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y6so5074756pfr.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkHcSooWDiFQAWanDp+t9iIhWojlq4TIuHk5USWu968=;
        b=EiW2jSIpWnSRYzvxKxkG6vi0w3xy/58QL63gbehgu6Xz2yKJ5Sf2Bfr8wBlOiAOaha
         VILTTueJVdvB68GFjLMbnvdjEe72h5g76xKMIkWXi1UtUr6Uxd0BlGdUaLInDbpIhzQI
         dl7bEPbJsPf6GuAIlyO0Neb7bK8WXwcCwwpIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkHcSooWDiFQAWanDp+t9iIhWojlq4TIuHk5USWu968=;
        b=Xpmz1+kcdSxWEtmsVIpw6qepZ8erAJm4RUag/uOW0Plt0OCaNMviyKNT2nCWnEzf9i
         yY0Cmk/8pGBpghzjRAgiMoaDyZCykjFeZJYsUxa6FuQ5R/7mYUnUwV/ExWzeeG6jXGHl
         +Z0hm8Yz0mqUboLQWzkwL36QxlBAkjJtYvLwyjQA4QhJ4KhmNYS8FvmZ0W0VOkPzFJt8
         DuncZuTRTHlfTOz+slX/uA5JD/TWQYtXJEbQPlI7z72Vx5KlyR4CbThZrsVf13+zDBwp
         HJ+fRqZfzSp0z0tMfLWdPvz9pb2beltpogYqNWcvNVGh7eytljMGJIvNCc1/vYPJZJ8L
         sYCQ==
X-Gm-Message-State: AJIora9fm7rjE8nh7eDlajx3z1JJtYXkAX9W1NhHBFQnvK1Z483nl0L3
        HNWiUNVXx3QsoNs088HCZlWcsg==
X-Google-Smtp-Source: AGRyM1tviS+33tpMgDPQRa+qfam6sWYHX1/xJo9ZNWkAIGRMfkx8jNSbEbSqFZIiC7tLsFzZ8nSlnQ==
X-Received: by 2002:a05:6a02:201:b0:3fc:6071:a272 with SMTP id bh1-20020a056a02020100b003fc6071a272mr10732274pgb.518.1655498875212;
        Fri, 17 Jun 2022 13:47:55 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:52e2:7dc8:1e20:f870])
        by smtp.gmail.com with ESMTPSA id z12-20020aa79f8c000000b0052089e1b88esm4098325pfr.192.2022.06.17.13.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:47:54 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: [PATCH 3/3] drm/msm/dp: Get rid of dp_ctrl_on_stream_phy_test_report()
Date:   Fri, 17 Jun 2022 13:47:50 -0700
Message-Id: <20220617204750.2347797-4-swboyd@chromium.org>
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

This API isn't really more than a couple lines now that we don't store
the pixel_rate to the struct member. Inline it into the caller.

Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 40 ++++++++++++--------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index e114521af2e9..d04fddb29fdf 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1582,34 +1582,15 @@ static bool dp_ctrl_send_phy_test_pattern(struct dp_ctrl_private *ctrl)
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
-	ret = dp_ctrl_enable_stream_clocks(ctrl, pixel_rate);
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
@@ -1624,12 +1605,21 @@ static int dp_ctrl_process_phy_test_request(struct dp_ctrl_private *ctrl)
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
+	ret = dp_ctrl_enable_stream_clocks(ctrl, pixel_rate);
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

