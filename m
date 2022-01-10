Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5750F48A14A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbiAJU5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:57:07 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:32338 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343701AbiAJU43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641848189; x=1673384189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=rPI9+4W9MEMrQmP0+FkgmDWaxmtT4g093MVJF1yVLtc=;
  b=d8oDk+2AI/L1hcjmq0LCGEBQZ5fQPhB2lBQqirC/uawGnsTJYJNL5N0p
   NEiXXW3Fp9arH1JdyPHx2gkQxuDH6FdI3vilm47qFTfZj8EUZc4Y/k1fY
   wV47GMy9a/15Xy+uqkIpBXN2zSjptX+hRaDZ9bwBBTENwBMUkyLv+Qn4k
   g=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jan 2022 12:56:29 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:56:28 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 12:56:28 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 12:56:27 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/5] drm/msm/dp: dp_link_parse_sink_count() return immediately if aux read failed
Date:   Mon, 10 Jan 2022 12:55:40 -0800
Message-ID: <1641848144-25147-2-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641848144-25147-1-git-send-email-quic_khsieh@quicinc.com>
References: <1641848144-25147-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checking aux read/write status at both dp_link_parse_sink_count()
and dp_link_parse_sink_status_filed() to avoid long timeout delay if
dp aux read/write failed at timeout due to cable unplugged. Also make
sure dp controller had been initialized before start dpcd read and write.

Changes in V4:
-- split this patch as stand alone patch

Changes in v5:
-- rebase on msm-next branch

Changes in v6:
-- add more details commit text

Changes in v10:
--  group into one series

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

