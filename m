Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA074CCB01
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiCDA6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 19:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiCDA6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:58:36 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616F45E14C;
        Thu,  3 Mar 2022 16:57:48 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q11so6325041pln.11;
        Thu, 03 Mar 2022 16:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4tlmCcwAixPksfOsjMXDq+jBjJUcS5OahrZLoaQMVA=;
        b=aIgK3V3Sn4DCfSrd6Vsq6VLfkuLIib+PrqFutN0KagVCNrWsFkzx9vBOMTPSOzvD9z
         kjhQIAMQG43ILtQDw/6gq2za9hRBxkrR5BeYlHVSJbG/dYgSRokglOMg7WkyuM3yBywk
         Fx6WOda2IxdRLKscmhM9wjtH0C16G2rwUcQq9y8wMuNEx9fNYc2zvI1IDNx9iZDqzdFC
         MKmJZx7OiNBtSktf4Z+Kn+bs2nJOnx33cKB0GMxtKhXwRBQ3cBQY/QonI3eDPK7y9hJz
         3PTg0R7kOOfwHE30ceFZpN55zv8wgR0+ZS8dWHsIeXtK2rMYavy2/AhgcS5fiw+WcNvI
         EBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4tlmCcwAixPksfOsjMXDq+jBjJUcS5OahrZLoaQMVA=;
        b=UQqxek11um3C+nZbT3r2g1Ksa1o7ZtZ3a90ImwMXuTkVmtBk1VDGZn4T+c4DJZ9FqR
         Qo0j3tEhc8bnwei99VLX5q69nu6Z/JnqkAPY4FGSXy6+rceaTEmlMK62LH4JfVwwQ9YV
         ioUVVqvm5Hd/IH6i5OAgvditRF3KTx+rESbX7gs2+Uerkkw53h0i276YKOpeZVvMoF1Q
         NRsmCoRG/UirtbjM9tCR395Xr/6vx2g14WxqG5rLt6wnGI1OibySeZwKTxx12C61PlKp
         jdzih90Pa/Ymnb1sOksLhwIVkWDQcYpSnjT1JNt+6w9bRcro396Qnax6RjWdk2lyAkUr
         5lYQ==
X-Gm-Message-State: AOAM530PtAfRnGTYpHpiDWr8eeEgQfv3zcotS0DWhEoz3542WXwLJi66
        3Xf8nGvKEHuMDV9IKr0alfFs4PFn0fM=
X-Google-Smtp-Source: ABdhPJzwVE1XKUhdVUGEANSFBPXuSZQXuj10njpmVxfknb74qZ0yevEQy/5bhs19DMZt5AdhE8JMpg==
X-Received: by 2002:a17:90a:7d10:b0:1be:ef04:43ce with SMTP id g16-20020a17090a7d1000b001beef0443cemr8012360pjl.225.1646355467918;
        Thu, 03 Mar 2022 16:57:47 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id c30-20020a63725e000000b0037c8bf5b630sm704252pgn.12.2022.03.03.16.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:57:46 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-kernel@vger.kernel.org (open list),
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/4] drm/msm: Clear perf counters across context switch
Date:   Thu,  3 Mar 2022 16:52:13 -0800
Message-Id: <20220304005317.776110-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Some clever folks figured out a way to use performance counters as a
side-channel[1].  But, other than the special case of using the perf
counters for system profiling, we can reset the counters across context
switches to protect against this.

This series introduces a SYSPROF param which a sufficiently privilaged
userspace (like Mesa's pps-producer, which already must run as root) to
opt-out, and makes the default behavior to reset counters on context
switches.

[1] https://dl.acm.org/doi/pdf/10.1145/3503222.3507757

Rob Clark (4):
  drm/msm: Update generated headers
  drm/msm: Add SET_PARAM ioctl
  drm/msm: Add SYSPROF param (v2)
  drm/msm/a6xx: Zap counters across context switch

 drivers/gpu/drm/msm/adreno/a2xx.xml.h         |  26 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c         |   1 +
 drivers/gpu/drm/msm/adreno/a3xx.xml.h         |  30 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c         |   1 +
 drivers/gpu/drm/msm/adreno/a4xx.xml.h         | 112 ++-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c         |   1 +
 drivers/gpu/drm/msm/adreno/a5xx.xml.h         |  63 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   1 +
 drivers/gpu/drm/msm/adreno/a6xx.xml.h         | 674 +++++++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h     |  26 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  30 +
 .../gpu/drm/msm/adreno/adreno_common.xml.h    |  31 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  14 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |   2 +
 drivers/gpu/drm/msm/adreno/adreno_pm4.xml.h   |  46 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4.xml.h      |  37 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h      |  37 +-
 drivers/gpu/drm/msm/disp/mdp_common.xml.h     |  37 +-
 drivers/gpu/drm/msm/dsi/dsi.xml.h             |  37 +-
 drivers/gpu/drm/msm/dsi/dsi_phy_10nm.xml.h    |  37 +-
 drivers/gpu/drm/msm/dsi/dsi_phy_14nm.xml.h    |  37 +-
 drivers/gpu/drm/msm/dsi/dsi_phy_20nm.xml.h    |  37 +-
 drivers/gpu/drm/msm/dsi/dsi_phy_28nm.xml.h    |  37 +-
 .../gpu/drm/msm/dsi/dsi_phy_28nm_8960.xml.h   |  37 +-
 drivers/gpu/drm/msm/dsi/dsi_phy_5nm.xml.h     | 480 -------------
 drivers/gpu/drm/msm/dsi/dsi_phy_7nm.xml.h     |  43 +-
 drivers/gpu/drm/msm/dsi/mmss_cc.xml.h         |  37 +-
 drivers/gpu/drm/msm/dsi/sfpb.xml.h            |  37 +-
 drivers/gpu/drm/msm/hdmi/hdmi.xml.h           |  37 +-
 drivers/gpu/drm/msm/hdmi/qfprom.xml.h         |  37 +-
 drivers/gpu/drm/msm/msm_drv.c                 |  28 +
 drivers/gpu/drm/msm/msm_gpu.c                 |   2 +
 drivers/gpu/drm/msm/msm_gpu.h                 |  29 +
 drivers/gpu/drm/msm/msm_submitqueue.c         |  39 +
 include/uapi/drm/msm_drm.h                    |  28 +-
 35 files changed, 1058 insertions(+), 1130 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/dsi/dsi_phy_5nm.xml.h

-- 
2.35.1

