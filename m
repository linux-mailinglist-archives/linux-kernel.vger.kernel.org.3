Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA77B48F39D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiAOA7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:59:00 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:14861 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiAOA67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642208339; x=1673744339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=z+JIuWKxJODjguXs3yWrhfZnFZJClraM9Lc/R80g5pc=;
  b=E/GW2wN08FFf3VZNVXmILhUchNJj/hRHwxw7D9hP0vxsbkbkE+RWjPri
   vVPgpJ3FupgHirIeNzHEQoZa3PujN3ZsHnQJajjzATNxYJvHTKxs5+26t
   gd5FSYnYTh5gj5/iwBaK78OqIhzhUwHNL05EkL26WI5Li5ius6cByihWG
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 14 Jan 2022 16:58:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:58:58 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 14 Jan 2022 16:58:51 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 14 Jan 2022 16:58:51 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <aravindh@codeaurora.org>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v17 4/4] drm/msm/dp: stop link training after link training 2 failed
Date:   Fri, 14 Jan 2022 16:58:35 -0800
Message-ID: <1642208315-9136-5-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642208315-9136-1-git-send-email-quic_khsieh@quicinc.com>
References: <1642208315-9136-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Changes in v10:
--  group into one series

Changes in v11:
-- drop drm/msm/dp: dp_link_parse_sink_count() return immediately if aux read

Fixes: 2e0adc765d88 ("drm/msm/dp: do not end dp link training until video is ready")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index f98df93..245e1b9 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1755,6 +1755,9 @@ int dp_ctrl_on_link(struct dp_ctrl *dp_ctrl)
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

