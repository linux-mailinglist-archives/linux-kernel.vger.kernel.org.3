Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FFA559F84
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiFXRP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiFXRP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:15:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE51463634;
        Fri, 24 Jun 2022 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656090927; x=1687626927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1no4VHAGF1U1GUsWuXmPq+Xyz6dJE8ewgEUyCmjoW4U=;
  b=nsAW5nQI2PuSTbIWbsNm/DqHnS8AM9NdNZJG+Cbm1mh6ipPe4KMHwK39
   F5a4fYrAw/H1ZDrCuFMmYkELGkU2e8QeTxX4LtPuahv3Sg4K/mYmc5fsa
   U3ckMRCiVGZMP4m1HmIO7zklZ4Rp2b1sxhSQNkPg5+X19zqLznwQKBAr3
   o=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 Jun 2022 10:15:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 10:15:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 10:15:25 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 10:15:24 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] drm/msm/dp: move struc of msm_display_info to msm_drv.h
Date:   Fri, 24 Jun 2022 10:15:10 -0700
Message-ID: <1656090912-18074-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

With current implementation, communication between interface driver and
upper mdss encoder layer are implemented through function calls. This
increase code complexity. Since struct msm_display_info contains msm
generic display information, it can be expended to contains more useful
information, such as widebus and dcs, in future to serve as communication
channel purpose between interface driver and upper mdss encoder layer so
that existing function calls can be eliminated.
This patch more struct msm_display_info to msm_drv.h to be visible by
whole msm scope.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h | 20 --------------------
 drivers/gpu/drm/msm/msm_drv.h               | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
index 781d41c..6b604c5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
@@ -19,26 +19,6 @@
 #define IDLE_TIMEOUT	(66 - 16/2)
 
 /**
- * struct msm_display_info - defines display properties
- * @intf_type:          DRM_MODE_ENCODER_ type
- * @capabilities:       Bitmask of display flags
- * @num_of_h_tiles:     Number of horizontal tiles in case of split interface
- * @h_tile_instance:    Controller instance used per tile. Number of elements is
- *                      based on num_of_h_tiles
- * @is_te_using_watchdog_timer:  Boolean to indicate watchdog TE is
- *				 used instead of panel TE in cmd mode panels
- * @dsc:		DSC configuration data for DSC-enabled displays
- */
-struct msm_display_info {
-	int intf_type;
-	uint32_t capabilities;
-	uint32_t num_of_h_tiles;
-	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
-	bool is_te_using_watchdog_timer;
-	struct msm_display_dsc_config *dsc;
-};
-
-/**
  * dpu_encoder_assign_crtc - Link the encoder to the crtc it's assigned to
  * @encoder:	encoder pointer
  * @crtc:	crtc pointer
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index fdbaad5..f9c263b 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -106,11 +106,30 @@ struct msm_drm_thread {
 	struct kthread_worker *worker;
 };
 
+<<<<<<< HEAD
 /* DSC config */
 struct msm_display_dsc_config {
 	struct drm_dsc_config *drm;
 };
 
+/**
+ * struct msm_display_info - defines display properties
+ * @intf_type:          DRM_MODE_ENCODER_ type
+ * @capabilities:       Bitmask of display flags
+ * @num_of_h_tiles:     Number of horizontal tiles in case of split interface
+ * @h_tile_instance:    Controller instance used per tile. Number of elements is
+ *                      based on num_of_h_tiles
+ * @is_te_using_watchdog_timer:  Boolean to indicate watchdog TE is
+ *				 used instead of panel TE in cmd mode panels
+ */
+struct msm_display_info {
+	int intf_type;
+	uint32_t capabilities;
+	uint32_t num_of_h_tiles;
+	uint32_t h_tile_instance[MAX_H_TILES_PER_DISPLAY];
+	bool is_te_using_watchdog_timer;
+};
+
 struct msm_drm_private {
 
 	struct drm_device *dev;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

