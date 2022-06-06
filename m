Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCFE53ED51
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiFFRzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiFFRzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:55:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E82F9AD9;
        Mon,  6 Jun 2022 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654538151; x=1686074151;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=nA3VMIc0EdXLtq38zIS6zslzeXYlwNxm4o2TKajA+5E=;
  b=aB8f/Hnkgq8hYIVzjcTOYMszJsB1KWRG9RNUjETlqJ5rrmQs5FiUJh+9
   jP6YGLM07uGvILaRQsmYpMsl2HSMWUqanH6W5TlkD8NxBDeinrYmqxscS
   01rDhYl0kLH+KwVOpvOxHR13rbwL71SlXhPpDFgzZgyITeGDRfzDiDwk0
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 06 Jun 2022 10:55:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 10:55:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 10:55:49 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 10:55:49 -0700
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
Subject: [PATCH v2] drm/msm/dp: check core_initialized before disable interrupts at dp_display_unbind()
Date:   Mon, 6 Jun 2022 10:55:39 -0700
Message-ID: <1654538139-7450-1-git-send-email-quic_khsieh@quicinc.com>
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

During msm initialize phase, dp_display_unbind() will be called to undo
initializations had been done by dp_display_bind() previously if there is
error happen at msm_drm_bind. In this case, core_initialized flag had to
be check to make sure clocks is on before update DP controller register
to disable HPD interrupts. Otherwise system will crash due to below NOC
fatal error.

QTISECLIB [01f01a7ad]CNOC2 ERROR: ERRLOG0_LOW = 0x00061007
QTISECLIB [01f01a7ad]GEM_NOC ERROR: ERRLOG0_LOW = 0x00001007
QTISECLIB [01f0371a0]CNOC2 ERROR: ERRLOG0_HIGH = 0x00000003
QTISECLIB [01f055297]GEM_NOC ERROR: ERRLOG0_HIGH = 0x00000003
QTISECLIB [01f072beb]CNOC2 ERROR: ERRLOG1_LOW = 0x00000024
QTISECLIB [01f0914b8]GEM_NOC ERROR: ERRLOG1_LOW = 0x00000042
QTISECLIB [01f0ae639]CNOC2 ERROR: ERRLOG1_HIGH = 0x00004002
QTISECLIB [01f0cc73f]GEM_NOC ERROR: ERRLOG1_HIGH = 0x00004002
QTISECLIB [01f0ea092]CNOC2 ERROR: ERRLOG2_LOW = 0x0009020c
QTISECLIB [01f10895f]GEM_NOC ERROR: ERRLOG2_LOW = 0x0ae9020c
QTISECLIB [01f125ae1]CNOC2 ERROR: ERRLOG2_HIGH = 0x00000000
QTISECLIB [01f143be7]GEM_NOC ERROR: ERRLOG2_HIGH = 0x00000000
QTISECLIB [01f16153a]CNOC2 ERROR: ERRLOG3_LOW = 0x00000000
QTISECLIB [01f17fe07]GEM_NOC ERROR: ERRLOG3_LOW = 0x00000000
QTISECLIB [01f19cf89]CNOC2 ERROR: ERRLOG3_HIGH = 0x00000000
QTISECLIB [01f1bb08e]GEM_NOC ERROR: ERRLOG3_HIGH = 0x00000000
QTISECLIB [01f1d8a31]CNOC2 ERROR: SBM1 FAULTINSTATUS0_LOW = 0x00000002
QTISECLIB [01f1f72a4]GEM_NOC ERROR: SBM0 FAULTINSTATUS0_LOW = 0x00000001
QTISECLIB [01f21a217]CNOC3 ERROR: ERRLOG0_LOW = 0x00000006
QTISECLIB [01f23dfd3]NOC error fatal

changes in v2:
-- drop the first patch (drm/msm: enable msm irq after all initializations are done successfully at msm_drm_init()) since the problem had been fixed by other patch

Fixes: a65c95ff88f2 ("drm/msm/dp: stop event kernel thread when DP unbind")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index da5c03a..2b72639 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -309,7 +309,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
 	struct msm_drm_private *priv = dev_get_drvdata(master);
 
 	/* disable all HPD interrupts */
-	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, false);
+	if (dp->core_initialized)
+		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, false);
 
 	kthread_stop(dp->ev_tsk);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

