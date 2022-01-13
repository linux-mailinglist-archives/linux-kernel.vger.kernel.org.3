Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970D248E144
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiAMXx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:53:58 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19874 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235897AbiAMXxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642118034; x=1673654034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8BCDV6NCnlYiGDkn8XsChXRDOfUBU+LHZ6N3FMlNIbM=;
  b=psFX4Tm/Le1pWV4pmU+IxI+3YniGY+BHoMxTz0yiMeShUFfCsIJkFPJg
   /G0spKvmYfHfA5FHY1R48RWYoKqm3bi0O7fG2f9M3sBqr3eA7RcXpW6Yh
   Um8domZREaPfNWE4neAmRLaapJe54zicXL3iMb3zUHXwqDYeciZ4emLCr
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jan 2022 15:53:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 15:53:53 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 13 Jan 2022 15:53:53 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 13 Jan 2022 15:53:52 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 2/4] drm/msm/dp:  populate connector of struct  dp_panel
Date:   Thu, 13 Jan 2022 15:53:37 -0800
Message-ID: <1642118019-18673-3-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642118019-18673-1-git-send-email-quic_khsieh@quicinc.com>
References: <1642118019-18673-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DP CTS test case 4.2.2.6 has valid edid with bad checksum on purpose
and expect DP source return correct checksum. During drm edid read,
correct edid checksum is calculated and stored at
connector::real_edid_checksum.

The problem is struct dp_panel::connector never be assigned, instead the
connector is stored in struct msm_dp::connector. When we run compliance
testing test case 4.2.2.6 dp_panel_handle_sink_request() won't have a valid
edid set in struct dp_panel::edid so we'll try to use the connectors
real_edid_checksum and hit a NULL pointer dereference error because the
connector pointer is never assigned.

Changes in V2:
-- populate panel connector at msm_dp_modeset_init() instead of at dp_panel_read_sink_caps()

Changes in V3:
-- remove unhelpful kernel crash trace commit text
-- remove renaming dp_display parameter to dp

Changes in V4:
-- add more details to commit text

Changes in v10:
--  group into one series

Changes in v11:
-- drop drm/msm/dp: dp_link_parse_sink_count() return immediately if aux read

Fixes: 7948fe12d47 ("drm/msm/dp: return correct edid checksum after corrupted edid checksum read")
Signee-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index b3c5404..52dcb56 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1483,6 +1483,7 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 			struct drm_encoder *encoder)
 {
 	struct msm_drm_private *priv;
+	struct dp_display_private *dp_priv;
 	int ret;
 
 	if (WARN_ON(!encoder) || WARN_ON(!dp_display) || WARN_ON(!dev))
@@ -1491,6 +1492,8 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 	priv = dev->dev_private;
 	dp_display->drm_dev = dev;
 
+	dp_priv = container_of(dp_display, struct dp_display_private, dp_display);
+
 	ret = dp_display_request_irq(dp_display);
 	if (ret) {
 		DRM_ERROR("request_irq failed, ret=%d\n", ret);
@@ -1508,6 +1511,8 @@ int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
 		return ret;
 	}
 
+	dp_priv->panel->connector = dp_display->connector;
+
 	priv->connectors[priv->num_connectors++] = dp_display->connector;
 
 	dp_display->bridge = msm_dp_bridge_init(dp_display, dev, encoder);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

