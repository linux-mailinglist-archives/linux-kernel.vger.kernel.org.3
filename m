Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70B84CC671
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiCCTtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiCCTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:49:04 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C2D1A2701;
        Thu,  3 Mar 2022 11:48:14 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 195so5572948pgc.6;
        Thu, 03 Mar 2022 11:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nq2rmInutTT50JNuTi3WdH4IenPn5amupYm/+5YS6nM=;
        b=hNYgCPz2O9db5uTiclBrG7nypU306/HnWpqPmcvXxDrb3Qq/m+b/xwi33NQzhl10SB
         2WX61/0O+nw4OEZCNRBiOTvGpCbS5Rileh/+eXGMJm17WjFu4Ba43jHRUtKdmPlJGS/O
         Oj5/Kmr2TtBkh4rFfhazVO2R39j87lvoK3Fz/ZCcXCbQn7YCSpnir5mSohildu8tijVB
         TcbKGpbm36L4N8UtR2WpnsQ53TuXrqDDiFt5LCo8DhIe4wylWjZawHAWY+XHLy3Uaslp
         oOTPkoMcWmA4SW9VI+/x8b4darMCCKgD7i8QP3iVHUvm4CdL+hnSkuMOoXCxmLN+rVTZ
         uLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nq2rmInutTT50JNuTi3WdH4IenPn5amupYm/+5YS6nM=;
        b=7SzodGuqpRtQML+I0qbH8HecTdrbF5EmSpKh3FLroGPzoECwYAUOBUcn2FRU8zpeUu
         oQFYPsW8yJwopVBlGiJ2LkaHHzgVEiT5iJdg4kg2qzMZwyDwFRFiMY6lXzqutKgcPfIK
         7EljNO5vzDxfZpeqSYZfa4F5umar6+9kFJ7/czJiGS8I+LaZziUICSwjx5olquQ1bY47
         hx2EeBki5Y3J54QunP3YKUo2yjDi4vlFsxdzRxCzLC9jlx7KAp6qb4a7jNG0QAbAaVYD
         Cb3EL4Tkb3VYZxfvICRCR2MKRl+kyeKNz1Ni1bV+lJu679G/lE6Pq+yhjEw7I/nMLAFT
         yKBg==
X-Gm-Message-State: AOAM532rVgx0tWvGn63Q5nDGbPhE6MWAA+jk94F/SOtMG5lXhTufFXlf
        v2UxTTiPr36noQl66LBip5k=
X-Google-Smtp-Source: ABdhPJyDMcOlF9eIIMTPVlfRlQIe07UC4nsuOmCpBbDN4ntch1XnJYQS3Kf6ITfUHnzvOtc1lFCfZw==
X-Received: by 2002:a63:b551:0:b0:378:c0a1:49d6 with SMTP id u17-20020a63b551000000b00378c0a149d6mr16343172pgo.296.1646336893725;
        Thu, 03 Mar 2022 11:48:13 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id nk5-20020a17090b194500b001bf01e6e558sm2889647pjb.29.2022.03.03.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 11:48:12 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-kernel@vger.kernel.org (open list),
        Stephen Boyd <swboyd@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/4] drm/msm: Clear perf counters across context switch
Date:   Thu,  3 Mar 2022 11:46:44 -0800
Message-Id: <20220303194758.710358-1-robdclark@gmail.com>
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
  drm/msm: Add SYSPROF param
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
 drivers/gpu/drm/msm/msm_gpu.h                 |  29 +
 drivers/gpu/drm/msm/msm_submitqueue.c         |  34 +
 include/uapi/drm/msm_drm.h                    |  28 +-
 34 files changed, 1051 insertions(+), 1130 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/dsi/dsi_phy_5nm.xml.h

-- 
2.35.1

