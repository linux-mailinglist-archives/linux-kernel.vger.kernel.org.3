Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF84B5DC2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiBNWj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:39:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiBNWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:39:26 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798B2145AED;
        Mon, 14 Feb 2022 14:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644878357; x=1676414357;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=rFIILB0DndzOx4jtv0A2A1R9LDNqCW1MRDBaXDoyVLI=;
  b=kFDVSTQXBtQ+hJ18S41VLkAUmnYu+JtXXgbBKQcVfL4dPUZAs7T1m86N
   34RheRPWE91KBPhVbnwCF+HOt7xd0jHTg46Qb+4w1q/USV7rTce4rwdni
   JKsr16RIDuePXluWNY3ijzq6z6Yi2RbCVUbhNkWfE0pLGCvQS/Zo2oI5Y
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Feb 2022 14:39:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 14:39:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 14:39:16 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 14 Feb 2022 14:39:15 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2]  enable widebus feature base on chip hardware revision
Date:   Mon, 14 Feb 2022 14:39:04 -0800
Message-ID: <1644878346-28511-1-git-send-email-quic_khsieh@quicinc.com>
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

split into 2 patches
1) widebus timing engine programming
2) enable widebus feature base on chip hardware revision

Kuogee Hsieh (2):
  drm/msm/dp:  revise timing engine programming to support widebus
    feature
  drm/msm/dp: enable widebus feature for display port

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 14 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |  2 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   | 14 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 99 ++++++++++++++++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |  6 ++
 drivers/gpu/drm/msm/dp/dp_catalog.c                | 36 +++++++-
 drivers/gpu/drm/msm/dp/dp_catalog.h                |  3 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 13 ++-
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c                | 30 +++++++
 drivers/gpu/drm/msm/dp/dp_display.h                |  2 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |  4 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |  2 +-
 drivers/gpu/drm/msm/msm_drv.h                      |  6 ++
 14 files changed, 205 insertions(+), 27 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

