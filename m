Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE235674FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiGERB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiGERBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:01:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFB71C13C;
        Tue,  5 Jul 2022 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657040479; x=1688576479;
  h=from:to:cc:subject:date:message-id;
  bh=3ZKq8tFCZlHxZ5e3ej+t0Hk1cFuHvgdrOMWcfXQ0AmM=;
  b=RYBvNCTsLf0U5WWxL3qYaghOYhux7Xm8vEpLMNKkYCBZ2OGMuz+bdKZz
   V4ih2hWNLO8410HH7mhhQD2+0SdBGbTJbtdfEiuXY6OojBhOF2FsIbw3J
   +QbWIPGXqAzz3HS05Q4V+UnWFfFh3Kqe6vksPjPRrTn11bvxrZax9vCUg
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 05 Jul 2022 10:01:19 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 05 Jul 2022 10:01:17 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 05 Jul 2022 22:30:54 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 47F223CBE; Tue,  5 Jul 2022 22:30:53 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_khsieh@quicinc.com, quic_vproddut@quicinc.com,
        bjorn.andersson@linaro.org, quic_aravindh@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com
Subject: [PATCH v4 0/7] Add PSR support for eDP 
Date:   Tue,  5 Jul 2022 22:30:38 +0530
Message-Id: <1657040445-13067-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
  - Use dp bridge to set psr entry/exit instead of dpu_enocder.
  - Don't modify whitespaces.
  - Set self refresh aware from atomic_check.
  - Set self refresh aware only if psr is supported.
  - Provide a stub for msm_dp_display_set_psr.
  - Move dp functions to bridge code.

Changes in v3:
  - Change callback names to reflect atomic interfaces.
  - Move bridge callback change to separate patch as suggested by Dmitry.
  - Remove psr function declaration from msm_drv.h.
  - Set self_refresh_aware flag only if psr is supported.
  - Modify the variable names to simpler form.
  - Define bit fields for PSR settings.
  - Add comments explaining the steps to enter/exit psr.
  - Change DRM_INFO to drm_dbg_db. 

Changes in v4:
  - Move the get crtc functions to drm_atomic.
  - Add atomic functions for DP bridge too.
  - Add ternary operator to choose eDP or DP ops.
  - return true/false instead of 1/0.
  - mode_valid missing in the eDP bridge ops.
  - Move the functions to get crtc into drm_atomic.c.
  - Fix compilation issues.
  - Remove dpu_assign_crtc and get crtc from drm_enc instead of dpu_enc.
  - Check for crtc state enable while reserving resources.

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Vinod Polimera (7):
  drm/msm/disp/dpu1: clear dpu_assign_crtc and get crtc from drm_enc
    instead of dpu_enc
  drm: add helper functions to retrieve old and new crtc
  drm/msm/dp: Add basic PSR support for eDP
  drm/bridge: use atomic enable/disable callbacks for panel bridge
  drm/bridge: Add psr support for panel bridge callbacks
  drm/msm/disp/dpu1: use atomic enable/disable callbacks for encoder
    functions
  drm/msm/disp/dpu1: add PSR support for eDP interface in dpu driver

 drivers/gpu/drm/bridge/panel.c              |  68 ++++++++--
 drivers/gpu/drm/drm_atomic.c                |  60 +++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  17 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  47 ++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |   8 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |   2 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c         |  81 ++++++++++++
 drivers/gpu/drm/msm/dp/dp_catalog.h         |   4 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c            |  76 +++++++++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.h            |   3 +
 drivers/gpu/drm/msm/dp/dp_display.c         |  31 +++--
 drivers/gpu/drm/msm/dp/dp_display.h         |   2 +
 drivers/gpu/drm/msm/dp/dp_drm.c             | 186 ++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_drm.h             |   9 +-
 drivers/gpu/drm/msm/dp/dp_link.c            |  36 ++++++
 drivers/gpu/drm/msm/dp/dp_panel.c           |  22 ++++
 drivers/gpu/drm/msm/dp/dp_panel.h           |   6 +
 drivers/gpu/drm/msm/dp/dp_reg.h             |  27 ++++
 include/drm/drm_atomic.h                    |   7 ++
 19 files changed, 625 insertions(+), 67 deletions(-)

-- 
2.7.4

