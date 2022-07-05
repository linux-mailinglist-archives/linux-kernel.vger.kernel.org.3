Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2ED567511
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiGERBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiGERBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:01:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113BF13D22;
        Tue,  5 Jul 2022 10:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657040485; x=1688576485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DdSWLWV6h1FcenkEhqE7q80VF+1KzLQ27NhPU+jHsRo=;
  b=G/ntLgG8jJIdIctuwPeYmRNdMhPo7oPxpzcIAcmSxjZ4KEs1KodwlgHH
   +koJzcgIUReMgvgin7pxmdHWR6WxL1R0QpsHRbivYNZGj5CauDFbHHJOr
   kGse3LUp7Db6JBd9if8pL573ZqPAMW9FvTrSEaWoc1W2qIx9kvlxMm+6P
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 05 Jul 2022 10:01:25 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Jul 2022 10:01:23 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 05 Jul 2022 22:31:01 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id A997F3CBE; Tue,  5 Jul 2022 22:31:00 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_khsieh@quicinc.com, quic_vproddut@quicinc.com,
        bjorn.andersson@linaro.org, quic_aravindh@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Subject: [PATCH v4 4/7] drm/bridge: use atomic enable/disable callbacks for panel bridge
Date:   Tue,  5 Jul 2022 22:30:42 +0530
Message-Id: <1657040445-13067-5-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657040445-13067-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1657040445-13067-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use atomic variants for panel bridge callback functions such that
certain states like self-refresh can be accessed as part of
enable/disable sequence.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/bridge/panel.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 0ee563e..eeb9546 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -108,28 +108,32 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
 		drm_connector_cleanup(connector);
 }
 
-static void panel_bridge_pre_enable(struct drm_bridge *bridge)
+static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+				struct drm_bridge_state *old_bridge_state)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
 
 	drm_panel_prepare(panel_bridge->panel);
 }
 
-static void panel_bridge_enable(struct drm_bridge *bridge)
+static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
+				struct drm_bridge_state *old_bridge_state)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
 
 	drm_panel_enable(panel_bridge->panel);
 }
 
-static void panel_bridge_disable(struct drm_bridge *bridge)
+static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
+				struct drm_bridge_state *old_bridge_state)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
 
 	drm_panel_disable(panel_bridge->panel);
 }
 
-static void panel_bridge_post_disable(struct drm_bridge *bridge)
+static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
+				struct drm_bridge_state *old_bridge_state)
 {
 	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
 
@@ -158,10 +162,10 @@ static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
 	.attach = panel_bridge_attach,
 	.detach = panel_bridge_detach,
-	.pre_enable = panel_bridge_pre_enable,
-	.enable = panel_bridge_enable,
-	.disable = panel_bridge_disable,
-	.post_disable = panel_bridge_post_disable,
+	.atomic_pre_enable = panel_bridge_atomic_pre_enable,
+	.atomic_enable = panel_bridge_atomic_enable,
+	.atomic_disable = panel_bridge_atomic_disable,
+	.atomic_post_disable = panel_bridge_atomic_post_disable,
 	.get_modes = panel_bridge_get_modes,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-- 
2.7.4

