Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD6B52074A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiEIWEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiEIWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:04:12 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA62A8056;
        Mon,  9 May 2022 15:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652133617; x=1683669617;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qXJoH9z1xHlw23nsN/8/A2gdlf4FUhU7ZzRmRTFr6lg=;
  b=wd3Vakz0dLzO2pIx2uFUZ2y1JEIUH9W4y/2epl8FVnqAgI5iv/J5Ng8x
   a1CuphkO3zAqORne3OyvS6Twsv1f9GwaSgO8+Tu+OAtQ0r/eckgHKkzzj
   6kARFttsUGeU9pRzLVHkgXEvKf2sRfM+cTMyAf8wXsIt3fKhjFzsy1a3V
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 15:00:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:00:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 15:00:16 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 15:00:15 -0700
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
Subject: [PATCH v2] drm/msm/dp: Always clear mask bits to disable interrupts at dp_ctrl_reset_irq_ctrl()
Date:   Mon, 9 May 2022 15:00:08 -0700
Message-ID: <1652133608-29247-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dp_catalog_ctrl_reset() will software reset DP controller. But it will
not reset programmable registers to default value. DP driver still have
to clear mask bits to interrupt status registers to disable interrupts
after software reset of controller. This patch removes the enable flag
condition checking to always clear mask bits of interrupt status
registers to disable interrupts if enable flag is false.

This patch also will fix the potential problem happen at system suspend where
dp_ctrl_reset_irq_ctrl() was called to try to disable HPD related irqs but
the irq is still unmasked unexpectedly and can come in while system are
suspending. This leads to bus hangs if the irq is handled after we power down
the DP hardware because we run the irq handler and access a device register
assuming that no irq could ever come in if we powered down the device. We
don't know when the irq will be handled though, so it's possible the irq is
pending from before we disable the irq in the hardware.

Changes in v2:
-- add more details commit text

Fixes: ba0a422be723 ("drm/msm/dp: do not initialize phy until plugin interrupt received")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index ebd38d7..09475a5 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1391,8 +1391,13 @@ void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable)
 
 	dp_catalog_ctrl_reset(ctrl->catalog);
 
-	if (enable)
-		dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
+	/*
+	* all dp controller programmable registers will not
+	* be reset to default value after DP_SW_RESET
+	* therefore interrupt mask bits have to be updated
+	* to enable/disable interrupts
+	*/
+	dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
 }
 
 void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

