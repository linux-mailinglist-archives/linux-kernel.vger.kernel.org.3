Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2868F5240A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349052AbiEKXQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiEKXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:15:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D315707
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:15:57 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x52so3215820pfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/bRSCWxN3crWK458fxz1SEwoQZz1X0AHwhiaJnWOQg=;
        b=KVvo0HsMb0gWdW8ms9ukhOL6ZAQxTudwfprKB5eUOOA+BinL+gfiSIxfaBnRXJOEiQ
         wsjUqTqHizdwMwtddcF+UYDChiULqeGuICA6d/SUXH11T8Qo+LkrC/kp/zkg4QyVqiPZ
         gqEwBe0ptEgOxlgZcAnSsAaak/mHjo34JaYdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R/bRSCWxN3crWK458fxz1SEwoQZz1X0AHwhiaJnWOQg=;
        b=6nvCv24X0+CqYNyIGwghs5WAN4U/YKAH5PM93J3Blasemi8Xcg3G9bqzpHYxVJugtl
         i+eWoq002Fr+olwWKeOXq/HgIWAtIHAfHS46ARLBsh7P2Fn1Fns3RQkoo0zEVhnAPoRk
         Xb8OPIWhQDmJ7eF9etzr40gAS5uT6dzvrNGWJ5Z09J1RBYSoTnAE08plHG9vx5fj5MWw
         51r+VaBDzcyIrFF1SucJmwmtuk91OMzy7GzKck66C1WJOSiX71i17KuTwwCorhYYdyBU
         s+cMzw5Bb3LYx89Ki6/BGHMZ5OqnUPIm26Sz/l44i5xeyDH/jkIGNwTJlyVJUq+ZhJrh
         8ioQ==
X-Gm-Message-State: AOAM532hUnP/2YZwy0FihJK8iQdoRcd+0zIsZVZPxuzYrh2ZvD9j0PlY
        GyCvqOFNuThrJTdifBJw74RCmA==
X-Google-Smtp-Source: ABdhPJzC5NTog37EDIqcukSTKK1ryjMlJrzN5VuhbJd6toYfu2679dFJdIBToo+zFeHGy4CReIKYbg==
X-Received: by 2002:a63:3e44:0:b0:3c3:dabd:eb03 with SMTP id l65-20020a633e44000000b003c3dabdeb03mr22323606pga.15.1652310957139;
        Wed, 11 May 2022 16:15:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:504e:720d:de58:4f66])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b0015e8d4eb22asm2416295plx.116.2022.05.11.16.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 16:15:56 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "drm/msm/dsi: move DSI host powerup to modeset time"
Date:   Wed, 11 May 2022 16:15:51 -0700
Message-Id: <20220511161539.v2.1.Ia196e35ad985059e77b038a41662faae9e26f411@changeid>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7d8e9a90509f1bd1d193a0c93cb8d1dbad9049fb.

The patch causes sc7180 Chromebooks that use the parade-ps8640 bridge
chip to fail to turn the display back on after it turns off.

Let's revert to get these devices back to a working state. It seems
like the DSI powerup problem is somewhat common and probably we should
land something more general like Dave Stevenson's series [1] that
would give more flexibility.

[1] https://lore.kernel.org/r/cover.1646406653.git.dave.stevenson@raspberrypi.com

Fixes: 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset time")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Remove the mud from my face.

 drivers/gpu/drm/msm/dsi/dsi_manager.c | 43 ++++++++-------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 50b987658b1f..8d51711a3417 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -315,12 +315,13 @@ dsi_mgr_connector_best_encoder(struct drm_connector *connector)
 	return msm_dsi_get_encoder(msm_dsi);
 }
 
-static void dsi_mgr_bridge_power_on(struct drm_bridge *bridge)
+static void dsi_mgr_bridge_pre_enable(struct drm_bridge *bridge)
 {
 	int id = dsi_mgr_bridge_get_id(bridge);
 	struct msm_dsi *msm_dsi = dsi_mgr_get_dsi(id);
 	struct msm_dsi *msm_dsi1 = dsi_mgr_get_dsi(DSI_1);
 	struct mipi_dsi_host *host = msm_dsi->host;
+	struct drm_panel *panel = msm_dsi->panel;
 	struct msm_dsi_phy_shared_timings phy_shared_timings[DSI_MAX];
 	bool is_bonded_dsi = IS_BONDED_DSI();
 	int ret;
@@ -361,34 +362,6 @@ static void dsi_mgr_bridge_power_on(struct drm_bridge *bridge)
 	if (is_bonded_dsi && msm_dsi1)
 		msm_dsi_host_enable_irq(msm_dsi1->host);
 
-	return;
-
-host1_on_fail:
-	msm_dsi_host_power_off(host);
-host_on_fail:
-	dsi_mgr_phy_disable(id);
-phy_en_fail:
-	return;
-}
-
-static void dsi_mgr_bridge_pre_enable(struct drm_bridge *bridge)
-{
-	int id = dsi_mgr_bridge_get_id(bridge);
-	struct msm_dsi *msm_dsi = dsi_mgr_get_dsi(id);
-	struct msm_dsi *msm_dsi1 = dsi_mgr_get_dsi(DSI_1);
-	struct mipi_dsi_host *host = msm_dsi->host;
-	struct drm_panel *panel = msm_dsi->panel;
-	bool is_bonded_dsi = IS_BONDED_DSI();
-	int ret;
-
-	DBG("id=%d", id);
-	if (!msm_dsi_device_connected(msm_dsi))
-		return;
-
-	/* Do nothing with the host if it is slave-DSI in case of bonded DSI */
-	if (is_bonded_dsi && !IS_MASTER_DSI_LINK(id))
-		return;
-
 	/* Always call panel functions once, because even for dual panels,
 	 * there is only one drm_panel instance.
 	 */
@@ -423,7 +396,17 @@ static void dsi_mgr_bridge_pre_enable(struct drm_bridge *bridge)
 	if (panel)
 		drm_panel_unprepare(panel);
 panel_prep_fail:
+	msm_dsi_host_disable_irq(host);
+	if (is_bonded_dsi && msm_dsi1)
+		msm_dsi_host_disable_irq(msm_dsi1->host);
 
+	if (is_bonded_dsi && msm_dsi1)
+		msm_dsi_host_power_off(msm_dsi1->host);
+host1_on_fail:
+	msm_dsi_host_power_off(host);
+host_on_fail:
+	dsi_mgr_phy_disable(id);
+phy_en_fail:
 	return;
 }
 
@@ -569,8 +552,6 @@ static void dsi_mgr_bridge_mode_set(struct drm_bridge *bridge,
 	msm_dsi_host_set_display_mode(host, adjusted_mode);
 	if (is_bonded_dsi && other_dsi)
 		msm_dsi_host_set_display_mode(other_dsi->host, adjusted_mode);
-
-	dsi_mgr_bridge_power_on(bridge);
 }
 
 static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
-- 
2.36.0.550.gb090851708-goog

