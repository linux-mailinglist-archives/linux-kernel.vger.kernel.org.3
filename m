Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79521517A65
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiEBXIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiEBXII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:08:08 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8C2DD46;
        Mon,  2 May 2022 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651532678; x=1683068678;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ckEAP8ApiIt+mqi1MEQVL+jvWJidDY78/Cy+N1HYKmE=;
  b=aCdkhN3RakadWyfYTbLwAZRGhWid1IG0b7WMbwbGHB7mN1xX2s42yAXt
   bOivAAPapZSoHMzSoenPBy/JRKq7vHe/hw8r85fxULhj3PLowjJX1toee
   yoBhPdoX6JmAkO9sCagAI+g/ycN25QnfBSeB+EUBGK64B4j4sVK441qXv
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 May 2022 16:04:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 16:04:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 16:04:37 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 2 May 2022 16:04:36 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/msm/dp: fix event thread stuck in wait_event after kthread_stop()
Date:   Mon, 2 May 2022 16:04:28 -0700
Message-ID: <1651532668-18873-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Event thread supposed to exit from its while loop after kthread_stop().
However there may has possibility that event thread is pending in the
middle of wait_event due to condition checking never become true.
To make sure event thread exit its loop after kthread_stop(), this
patch OR kthread_should_stop() into wait_event's condition checking
so that event thread will exit its loop after kernal_stop().

Changes in v2:
--  correct spelling error at commit title

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 570d3e5d28db ("drm/msm/dp: stop event kernel thread when DP unbind")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c388323..5200a58 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1106,12 +1106,17 @@ static int hpd_event_thread(void *data)
 	while (!kthread_should_stop()) {
 		if (timeout_mode) {
 			wait_event_timeout(dp_priv->event_q,
-				(dp_priv->event_pndx == dp_priv->event_gndx),
-						EVENT_TIMEOUT);
+				((dp_priv->event_pndx == dp_priv->event_gndx) ||
+					kthread_should_stop()), EVENT_TIMEOUT);
 		} else {
 			wait_event_interruptible(dp_priv->event_q,
-				(dp_priv->event_pndx != dp_priv->event_gndx));
+				((dp_priv->event_pndx != dp_priv->event_gndx) ||
+					kthread_should_stop()));
 		}
+
+		if(kthread_should_stop())
+			break;
+
 		spin_lock_irqsave(&dp_priv->event_lock, flag);
 		todo = &dp_priv->event_list[dp_priv->event_gndx];
 		if (todo->delay) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

