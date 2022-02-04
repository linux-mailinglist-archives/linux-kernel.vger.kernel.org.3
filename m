Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B604D4A9F48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377646AbiBDShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:37:00 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:27819 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377641AbiBDSgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643999812; x=1675535812;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=mk7BEok8/VhlRqkWI4IQkDfecA7DKdES0Z/Ryz5SbOc=;
  b=GWsQR+32KZe4//y+aU23Jk+vxkvaEi0M8ouszzo0FFfEUSYsv3YoiA+F
   5N9sQc8fOB8R9qVbShi6DoN1TjC03+VyGk2WOtL8rYk5Z7F1QK7TCprlb
   XNPZ1+SgHDBvUuj0oI/19u1yM6sbz8l8gifSXVPisZv/7+KTzDz/pqdDX
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Feb 2022 10:36:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 10:36:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 4 Feb 2022 10:36:51 -0800
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 4 Feb 2022 10:36:50 -0800
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <vkoul@kernel.org>,
        <daniel@ffwll.ch>, <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3]  enable widebus feature base on chip hardware revision
Date:   Fri, 4 Feb 2022 10:36:38 -0800
Message-ID: <1643999801-20359-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

split into 3 patches
1) widebus timing engine programming
2) dsc timing engine
3) enable widebus feature base on chip hardware revision


Kuogee Hsieh (3):
  drm/msm/dp:  revise timing engine programming to support widebus
    feature
  drm/msm/dp: revise timing engine programming to support compression
    (DSC)
  drm/msm/dp: enable widebus feature for display port

 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  14 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |   2 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  14 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        | 107 +++++++++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |   5 +
 drivers/gpu/drm/msm/dp/dp_catalog.c                |  36 ++++++-
 drivers/gpu/drm/msm/dp/dp_catalog.h                |   3 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  13 ++-
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |  30 ++++++
 drivers/gpu/drm/msm/dp/dp_display.h                |   2 +
 drivers/gpu/drm/msm/dp/dp_panel.c                  |   4 +-
 drivers/gpu/drm/msm/dp/dp_panel.h                  |   2 +-
 drivers/gpu/drm/msm/msm_drv.h                      |   6 ++
 14 files changed, 197 insertions(+), 42 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

