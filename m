Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC025859CF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiG3JlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbiG3JlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:41:16 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D702A13DC3;
        Sat, 30 Jul 2022 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659174071; x=1690710071;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Yx6mdlgxUKcuMUJpG9RAXbgHUuz7QAS+XXKWOccu2sE=;
  b=hNWtlncU8oYvXUmhkoSDGPGQHpppEpTqHyM7v2H64v1cRk+jk2NO9iB/
   zNXtHFDQxCD6Zsd+6gNlBIZr/N6EPGT2C2N1wvJow6AS37Q3W0DmJC7Lc
   BoyGee89DFzuUbyAguBMJs34EvkyZ0he9MK3CELHNashiPqxi3AwpsKLB
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Jul 2022 02:41:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 02:41:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:41:10 -0700
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:41:03 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Wang Qing <wangqing@vivo.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/8] Improve GPU Recovery
Date:   Sat, 30 Jul 2022 15:10:43 +0530
Message-ID: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently, I debugged a few device crashes which occured during recovery
after a hangcheck timeout. It looks like there are a few things we can
do to improve our chance at a successful gpu recovery.

First one is to ensure that CX GDSC collapses which clears the internal
states in gpu's CX domain. First 5 patches tries to handle this.

Rest of the patches are to ensure that few internal blocks like CP, GMU
and GBIF are halted properly before proceeding for a snapshot followed by
recovery. Also, handle 'prepare slumber' hfi failure correctly. These
are A6x specific improvements.

This series is rebased on top of [1] which based on linus's master
branch.

[1] https://patchwork.freedesktop.org/series/106860/

Changes in v3:
- Use reset interface from gpucc driver to poll for cx gdsc collapse
  https://patchwork.freedesktop.org/series/106860/
- Use single pm refcount for all active submits

Changes in v2:
- Rebased on msm-next tip

Akhil P Oommen (8):
  drm/msm: Remove unnecessary pm_runtime_get/put
  drm/msm: Take single rpm refcount on behalf of all submits
  drm/msm: Correct pm_runtime votes in recover worker
  drm/msm: Fix cx collapse issue during recovery
  drm/msm/a6xx: Ensure CX collapse during gpu recovery
  drm/msm/adreno: Remove a WARN() during runtime_suspend
  drm/msm/a6xx: Improve gpu recovery sequence
  drm/msm/a6xx: Handle GMU prepare-slumber hfi failure

 drivers/gpu/drm/msm/adreno/a6xx.xml.h      |  4 ++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 83 +++++++++++++++++++-----------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 35 +++++++++++--
 drivers/gpu/drm/msm/adreno/adreno_device.c |  7 ---
 drivers/gpu/drm/msm/msm_gpu.c              | 21 +++++---
 drivers/gpu/drm/msm/msm_gpu.h              |  4 ++
 drivers/gpu/drm/msm/msm_ringbuffer.c       |  4 --
 7 files changed, 106 insertions(+), 52 deletions(-)

-- 
2.7.4

