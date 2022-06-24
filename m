Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09652559F61
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiFXRPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiFXRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:15:29 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D92D63628;
        Fri, 24 Jun 2022 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656090929; x=1687626929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fT+ythOYCVlNcrsvXZFZiFoUH/exNdQzHOf/KDYIKOM=;
  b=AWXP7Rfhyhvd7cq2zH3Z7R5zW33w8SE1eAlzWuopWL36gFKnid2r0m8x
   INEtENViP5ieTSP1itSL57uHg3zaU4GdzVSZMYKbE+VwlqjfOF5lI8CDr
   PNTrv543quALmtWwRs5kCMjc2VAIGaFNwJBQUo8sZa1RILuryOjuQbP7V
   A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Jun 2022 10:15:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 10:15:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 10:15:28 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 24 Jun 2022 10:15:27 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/3] drm/msm/dp: place edp at head of drm bridge chain to fix screen corruption
Date:   Fri, 24 Jun 2022 10:15:12 -0700
Message-ID: <1656090912-18074-4-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
References: <1656090912-18074-1-git-send-email-quic_khsieh@quicinc.com>
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

The msm_dp_modeset_init() is used to attach DP driver to drm bridge chain.
msm_dp_modeset_init() is executed in the order of index (dp->id) of DP
descriptor table.

Currently, DP is placed at first entry (dp->id = 0) of descriptor table
and eDP is placed at secondary entry (dp->id = 1 ) of descriptor table.
This means DP will be placed at head of bridge chain and eDP will be
placed right after DP at bridge chain.

Drm screen update is happen sequentially in the order from head to tail
of bridge chain. Therefore external DP display will have screen updated
happen before primary eDP display if external DP display presented.
This is wrong screen update order and cause one frame time screen
corruption happen at primary display during external DP plugged in.

This patch place eDP at first entry (dp->id = 0) of descriptor table and
place DP at secondary entry (dp->id = 1) to have primary eDP locate at
head of bridge chain. This correct screen update order and eliminated
the one frame time screen corruption happen d at primary display.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a87a9d8..2755ff3 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -143,10 +143,10 @@ static const struct msm_dp_config sc7180_dp_cfg = {
 
 static const struct msm_dp_config sc7280_dp_cfg = {
 	.descs = (const struct msm_dp_desc[]) {
-		{ .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort,
-		.controller_id = MSM_DP_CONTROLLER_0, .wide_bus_en = true },
 		{ .io_start = 0x0aea0000, .connector_type = DRM_MODE_CONNECTOR_eDP, 
 		.controller_id = MSM_DP_CONTROLLER_1, .wide_bus_en = true },
+		{ .io_start = 0x0ae90000, .connector_type = DRM_MODE_CONNECTOR_DisplayPort,
+		.controller_id = MSM_DP_CONTROLLER_0, .wide_bus_en = true },
 	},
 	.num_descs = 2,
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

