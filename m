Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB94BA86A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244365AbiBQSgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:36:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244534AbiBQSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:36:04 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A8738A0;
        Thu, 17 Feb 2022 10:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645122946; x=1676658946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sEmE1WZUmqWjwfocPA6SyYXNPkOmoqNqw4Foo23Ps54=;
  b=kz3G2Fj2eHV18RdZ6YVWsItvTfsrkbeCuZYzKNXjXG1v4Q0sa+xCQf4R
   ZhIEWbltIX26ZIUd4O/j8oD01Kr46PRYuKW00YjtvkryulcAcZcQWj3Tk
   UZwSLdXM++K4AJmFgyKESYUCymIDxPWI1o3YMdvJtSGEt3Lssoafk7Qar
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 17 Feb 2022 10:35:45 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 10:35:45 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Feb 2022 10:35:44 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 17 Feb 2022 10:35:43 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] drm/msm/dp: enhance debug info related to dp phy
Date:   Thu, 17 Feb 2022 10:35:29 -0800
Message-ID: <1645122930-23863-3-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645122930-23863-1-git-send-email-quic_khsieh@quicinc.com>
References: <1645122930-23863-1-git-send-email-quic_khsieh@quicinc.com>
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

DP phy should be initialized and exited symmetrically to avoid
clock being stucked at either on or off error. Add debug info
to cover all DP phy to identify clock issues easily.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 245e1b9..dcd0126 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1396,6 +1396,8 @@ void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
 
 	dp_catalog_ctrl_phy_reset(ctrl->catalog);
 	phy_init(phy);
+	DRM_DEBUG_DP("phy=%p init=%d power_on=%d\n",
+			phy, phy->init_count, phy->power_count);
 }
 
 void dp_ctrl_phy_exit(struct dp_ctrl *dp_ctrl)
@@ -1410,6 +1412,8 @@ void dp_ctrl_phy_exit(struct dp_ctrl *dp_ctrl)
 
 	dp_catalog_ctrl_phy_reset(ctrl->catalog);
 	phy_exit(phy);
+	DRM_DEBUG_DP("phy=%p init=%d power_on=%d\n",
+			phy, phy->init_count, phy->power_count);
 }
 
 static bool dp_ctrl_use_fixed_nvid(struct dp_ctrl_private *ctrl)
@@ -1484,6 +1488,8 @@ static int dp_ctrl_deinitialize_mainlink(struct dp_ctrl_private *ctrl)
 	phy_exit(phy);
 	phy_init(phy);
 
+	DRM_DEBUG_DP("phy=%p init=%d power_on=%d\n",
+			phy, phy->init_count, phy->power_count);
 	return 0;
 }
 
@@ -1895,14 +1901,12 @@ int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl)
 
 	phy_power_off(phy);
 
-	DRM_DEBUG_DP("After, phy=%x init_count=%d power_on=%d\n",
-		(u32)(uintptr_t)phy, phy->init_count, phy->power_count);
-
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
 	phy_init(phy);
 
-	DRM_DEBUG_DP("DP off link/stream done\n");
+	DRM_DEBUG_DP("phy=%p init=%d power_on=%d\n",
+			phy, phy->init_count, phy->power_count);
 	return ret;
 }
 
@@ -1933,13 +1937,9 @@ int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
 		DRM_ERROR("Failed to disable link clocks. ret=%d\n", ret);
 	}
 
-	DRM_DEBUG_DP("Before, phy=%x init_count=%d power_on=%d\n",
-		(u32)(uintptr_t)phy, phy->init_count, phy->power_count);
-
 	phy_power_off(phy);
-
-	DRM_DEBUG_DP("After, phy=%x init_count=%d power_on=%d\n",
-		(u32)(uintptr_t)phy, phy->init_count, phy->power_count);
+	DRM_DEBUG_DP("phy=%p init=%d power_on=%d\n",
+			phy, phy->init_count, phy->power_count);
 
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

