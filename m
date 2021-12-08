Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A5C46DA2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhLHRot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:44:49 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:31260 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhLHRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638985276; x=1670521276;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=QCauYEDRAx67oBsH3VYRAkYIrBaiGQvGdb741ZuxSa0=;
  b=uuJ9DsFqyR60GYJMDJ3rIf190+SUYQdhWAkBELr3eYRQy3Osghns7z/Y
   wPgs+eEiI9xIh0jlJjs5Oxgxg979i9ZnPTjy6XYqWmpCFFd8Ku2YhhYAI
   gw2Mgk2mpwj3Oy9Eup+18d9fuhZCpXopwcZXYDkoT0tAcyRVXHfhRlJqN
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Dec 2021 09:41:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 09:41:12 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 8 Dec 2021 09:41:11 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 8 Dec 2021 09:41:11 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] drm/msm/dp: dp_link_parse_sink_count() return immediately if aux read failed
Date:   Wed, 8 Dec 2021 09:41:02 -0800
Message-ID: <1638985262-2072-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checking aux read/write status at both dp_link_parse_sink_count()
and dp_link_parse_sink_status_filed() to avoid long timeout delay if
dp aux read/write failed at timeout due to cable unplugged.

Changes in V4:
-- split this patch as stand alone patch

Changes in v5:
-- rebase on msm-next branch

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 12 +++++++++---
 drivers/gpu/drm/msm/dp/dp_link.c    | 19 ++++++++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 3d61459..0766752 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -692,9 +692,15 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
 		return 0;
 	}
 
-	ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
-	if (ret == -ECONNRESET) { /* cable unplugged */
-		dp->core_initialized = false;
+	/*
+	 * dp core (ahb/aux clks) must be initialized before
+	 * irq_hpd be handled
+	 */
+	if (dp->core_initialized) {
+		ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
+		if (ret == -ECONNRESET) { /* cable unplugged */
+			dp->core_initialized = false;
+		}
 	}
 	DRM_DEBUG_DP("hpd_state=%d\n", state);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index a5bdfc5..d4d31e5 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -737,18 +737,25 @@ static int dp_link_parse_sink_count(struct dp_link *dp_link)
 	return 0;
 }
 
-static void dp_link_parse_sink_status_field(struct dp_link_private *link)
+static int dp_link_parse_sink_status_field(struct dp_link_private *link)
 {
 	int len = 0;
 
 	link->prev_sink_count = link->dp_link.sink_count;
-	dp_link_parse_sink_count(&link->dp_link);
+	len = dp_link_parse_sink_count(&link->dp_link);
+	if (len < 0) {
+		DRM_ERROR("DP parse sink count failed\n");
+		return len;
+	}
 
 	len = drm_dp_dpcd_read_link_status(link->aux,
 		link->link_status);
-	if (len < DP_LINK_STATUS_SIZE)
+	if (len < DP_LINK_STATUS_SIZE) {
 		DRM_ERROR("DP link status read failed\n");
-	dp_link_parse_request(link);
+		return len;
+	}
+
+	return dp_link_parse_request(link);
 }
 
 /**
@@ -1023,7 +1030,9 @@ int dp_link_process_request(struct dp_link *dp_link)
 
 	dp_link_reset_data(link);
 
-	dp_link_parse_sink_status_field(link);
+	ret = dp_link_parse_sink_status_field(link);
+	if (ret)
+		return ret;
 
 	if (link->request.test_requested == DP_TEST_LINK_EDID_READ) {
 		dp_link->sink_request |= DP_TEST_LINK_EDID_READ;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

