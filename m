Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467E587232
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiHAUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiHAUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:14:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD9543E68;
        Mon,  1 Aug 2022 13:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659384842; x=1690920842;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=n6IukTgG6N+YuAzTEhN370nFPejMJyHqYPVPP8VIqXc=;
  b=Hgg2AIPZyAvDGQlYOJuRFZyTf4WdgIHrWLkmotRdr8FrhJN2YDacdK6Z
   u8CZyYgCmjNJwVARP1EZ/gViJwxFIv8ynQBXoY31oZ/bcVRd2IbtHTY4/
   6Ea/Nl3x7IaVuEUMbOaXoIv35TPGXGqIA9QU/i2gVOW4vahul3/8CtM6Q
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 01 Aug 2022 13:14:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 13:14:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 13:13:59 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 13:13:59 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <quic_aravindh@quicinc.com>, <quic_khsieh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/msm/dp: delete DP_RECOVERED_CLOCK_OUT_EN to fix tps4
Date:   Mon, 1 Aug 2022 13:13:50 -0700
Message-ID: <1659384830-9909-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data Symbols scrambled is required for tps4 at link training 2.
Therefore SCRAMBLING_DISABLE bit should not be set for tps4 to
work.
RECOVERED_CLOCK_OUT_EN is for enable simple EYE test for jitter
measurement with minimal equipment for embedded applications purpose
and is not required to be set during normal operation.
Current implementation always have RECOVERED_CLOCK_OUT_EN bit set
which cause SCRAMBLING_DISABLE bit wrongly set at tps4 which prevent
tps4 from working.
This patch delete setting RECOVERED_CLOCK_OUT_EN to fix SCRAMBLING_DISABLE
be wrongly set at tps4.

Changes in v2:
-- fix Fixes tag

Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index ab6aa13..013ca02 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1214,7 +1214,7 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
 	if (ret)
 		return ret;
 
-	dp_ctrl_train_pattern_set(ctrl, pattern | DP_RECOVERED_CLOCK_OUT_EN);
+	dp_ctrl_train_pattern_set(ctrl, pattern);
 
 	for (tries = 0; tries <= maximum_retries; tries++) {
 		drm_dp_link_train_channel_eq_delay(ctrl->aux, ctrl->panel->dpcd);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

