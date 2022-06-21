Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E01553036
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348671AbiFUKxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349002AbiFUKxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:53:47 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C8F25EA4;
        Tue, 21 Jun 2022 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655808827; x=1687344827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mb5DQUx++WBYqHBb28dKoW1PAZ+4l8zH8PF2XnRF4bc=;
  b=IwGQReI6tvZN6q7SY0h/bJL3oqEvZEqhguy5uApJnoMxUq6B71wPtDVt
   0uQPcF4ZqF4l8/JC1AfS7W+MpZZpKtytzL+pDsbmxmQT7BjZteO5G/y0a
   VmF2BBdXP9tqYJYdjKUW6KVs8jK/OvISl9VXrAQwMnm48QRI2qvxyEVDH
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Jun 2022 03:53:47 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Jun 2022 03:53:45 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 Jun 2022 16:23:27 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 32B123CF4; Tue, 21 Jun 2022 16:23:26 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     y@qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_sbillaka@quicinc.com
Subject: [v3 0/5] Add PSR support for eDP
Date:   Tue, 21 Jun 2022 16:23:15 +0530
Message-Id: <1655808800-3996-1-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <y>
References: <y>
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

Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Vinod Polimera (5):
  drm/msm/dp: Add basic PSR support for eDP
  drm/bridge: use atomic enable/disable callbacks for panel bridge
    functions
  drm/bridge: add psr support during panel bridge enable & disable
    sequence
  drm/msm/disp/dpu1: use atomic enable/disable callbacks for encoder
    functions
  drm/msm/disp/dpu1: add PSR support for eDP interface in dpu driver

 drivers/gpu/drm/bridge/panel.c              | 110 ++++++++++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  36 +++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  30 ++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     |   2 +-
 drivers/gpu/drm/msm/dp/dp_catalog.c         |  81 ++++++++++++++
 drivers/gpu/drm/msm/dp/dp_catalog.h         |   4 +
 drivers/gpu/drm/msm/dp/dp_ctrl.c            |  76 ++++++++++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.h            |   3 +
 drivers/gpu/drm/msm/dp/dp_display.c         |  14 +++
 drivers/gpu/drm/msm/dp/dp_display.h         |   2 +
 drivers/gpu/drm/msm/dp/dp_drm.c             | 166 +++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_link.c            |  36 ++++++
 drivers/gpu/drm/msm/dp/dp_panel.c           |  22 ++++
 drivers/gpu/drm/msm/dp/dp_panel.h           |   6 +
 drivers/gpu/drm/msm/dp/dp_reg.h             |  27 +++++
 15 files changed, 591 insertions(+), 24 deletions(-)

-- 
2.7.4

