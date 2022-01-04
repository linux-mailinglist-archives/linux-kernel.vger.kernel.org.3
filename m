Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAD484B63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 00:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiADXxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 18:53:07 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:18998 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiADXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641340386; x=1672876386;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=fLCcdxocKH85HQ3jCk4LCX/EcUSahJ0COmlko2j8PsA=;
  b=xg7QKbHKRMU2MORlfYWN59MqT+IzZ/wufOWYgLrjVyYWinZ/LsbwMsZY
   qtf4hzraLf36zxwW+Ls4BMp6kBzmtXHsUE73AxDxScQomtfndrpzwUvJI
   nDTk6m31Am1t/01+S9CdYUxONmXQM1w6wux9cai78of67pWNQxEoJGTsa
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 04 Jan 2022 15:53:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 15:52:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 15:52:15 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 15:52:14 -0800
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
Subject: [PATCH] drm/msm/dp: stop link training after link training 2 failed
Date:   Tue, 4 Jan 2022 15:52:07 -0800
Message-ID: <1641340327-2261-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each DP link training contains link training 1 followed by link
training 2.  There is maximum of 5 retries of DP link training
before declared link training failed. It is required to stop link
training at end of link training 2 if it is failed so that next
link training 1 can start freshly. This patch fixes link compliance
test  case 4.3.1.13 (Source Device Link Training EQ Fallback Test).

Fixes: 2e0adc765d88 ("drm/msm/dp: do not end dp link training until video is ready")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 39558a2..3e4b3d9 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1745,6 +1745,9 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
 				/* end with failure */
 				break; /* lane == 1 already */
 			}
+
+			/* stop link training before start re training  */
+			dp_ctrl_clear_training_pattern(ctrl);
 		}
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

