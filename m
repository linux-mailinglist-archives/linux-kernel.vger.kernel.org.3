Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC074E89FD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 22:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiC0U2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 16:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiC0U2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 16:28:31 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0FD33E3C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:26:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id bp39so10799002qtb.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8UVxZLedNpHTbRo7IKHmaBenq+x1GF8T/vpr9/COFw=;
        b=5Xj7QIclTvrgSeXF+IP/WwaPT8yZo0PxRfFAqiZqBjcDNtnjxD0mek5rMxQ0apA6Ul
         bafTXYVSqEDNG8kf1iYuAnOUjXb5qi2oCFDcQE/5uYNK3bZkTgoe0DBepeCXES+YaFHy
         uUSODGqLQGtJQtv5VugwkPgpPVJ7vryhokzOW0Afh5lkxrKh1Fk1xd1uMpw2hyQsccHV
         eJjs0ODSNWhsUCnemc7fZSNqvkCppoEijTCKRkwvwUGlle+EBscLvzxCwIDwQdd1VU4r
         LrHixLpHdso5hm3MW7ETrDT5zUdsZDTsY3q8DSKWsqAUZsobp3QQEeZ78PpeI3s2YU5G
         2c9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8UVxZLedNpHTbRo7IKHmaBenq+x1GF8T/vpr9/COFw=;
        b=pB5N9E8xh/DO++F1eYCc+XxLcRaH2kIR7RMr8mLndJHYSHdRl47uTTT9AgRBITWRAB
         JC2X+AViCg6q/CnaHCwYhemjh6r83vPbw5gHRS2OwesSTFG+O6ygcOy2guQ2Vem199AQ
         M2m7NaFxImAnPSQtGGHeBn5HmSQa7021sAP8Cx4zAjX1/c/YA7On6NqY3xlTX8+YJJje
         FcATSWCN/+PRdIEYFHjoGW4I9cc0m2DAxT5byB5PT2WGiS5lLQZTXMQkeEcc4ILisAth
         bMutO2bkMPyS/2txnkTa1Ja7XfZcBGanI9mG5k2WAv7Me+eNH4mUl0C4VNKOFRuBmXV2
         BYRQ==
X-Gm-Message-State: AOAM532ZQAwym4xzXosjn5nTqP5HBD/IW1QEn9D4yDNeOGMnWidfE7w5
        UZVx8xvyNsXNnbs7GBwt4CQR3A==
X-Google-Smtp-Source: ABdhPJwjikefcEW6EE3MzZqkcTWwsp93SdKPjKGmaMKv4cGZBM3L1ZE4fkjaC0trhlqVgv+ImjZTsQ==
X-Received: by 2002:ac8:5e10:0:b0:2e1:cdc7:a73 with SMTP id h16-20020ac85e10000000b002e1cdc70a73mr19139444qtx.72.1648412811092;
        Sun, 27 Mar 2022 13:26:51 -0700 (PDT)
Received: from localhost.localdomain (modemcable134.222-177-173.mc.videotron.ca. [173.177.222.134])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a108900b0067b13036bd5sm6720386qkk.52.2022.03.27.13.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 13:26:50 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Emma Anholt <emma@anholt.net>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/4] drm/msm/adreno: add support for a730
Date:   Sun, 27 Mar 2022 16:25:53 -0400
Message-Id: <20220327202643.4053-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on a6xx_gpu.c, stripped down and updated for a7xx based on the
downstream driver. Implements the minimum to be able to submit commands to
the GPU and use it for userspace driver development. Notably this doesn't
implement support for the GMU (this means that the clock driver needs to
support the GPU core clock and turning on the GX rail, which is normally
offloaded to the GMU).

Register updates: https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/15602

Jonathan Marek (4):
  drm/msm/adreno: move a6xx CP_PROTECT macros to common code
  drm/msm/adreno: use a single register offset for
    gpu_read64/gpu_write64
  drm/msm/adreno: update headers
  drm/msm/adreno: add support for a730

 drivers/gpu/drm/msm/Makefile                |   1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c       |   3 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c       |  27 +-
 drivers/gpu/drm/msm/adreno/a5xx_preempt.c   |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  25 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h       |  17 -
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |   3 +-
 drivers/gpu/drm/msm/adreno/a7xx.xml.h       | 666 +++++++++++++++++
 drivers/gpu/drm/msm/adreno/a7xx_gpu.c       | 777 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a7xx_gpu.h       |  26 +
 drivers/gpu/drm/msm/adreno/adreno_device.c  |  12 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.h     |   9 +-
 drivers/gpu/drm/msm/adreno/adreno_pm4.xml.h |  45 +-
 drivers/gpu/drm/msm/msm_gpu.h               |  12 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h        |   1 +
 15 files changed, 1550 insertions(+), 78 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a7xx.xml.h
 create mode 100644 drivers/gpu/drm/msm/adreno/a7xx_gpu.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a7xx_gpu.h

-- 
2.26.1

