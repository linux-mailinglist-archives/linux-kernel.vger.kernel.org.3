Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C474FC6F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350250AbiDKWA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiDKWAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:00:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ECF11C02;
        Mon, 11 Apr 2022 14:58:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q142so15313532pgq.9;
        Mon, 11 Apr 2022 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjX9OiCRZovNS7uWD7qtI1tuIPYpsaOZmyjT0QclAFo=;
        b=F0BkDSIuJxh7VvjREkPIPyYuDDgZFYrtitXYRDq9e3ICyFdaihszLA2XvhrMFFCLrK
         sDAfc8QQRxTGKsTaLm6UqLwG9ltH/W3wrni2xKPAaR57aOEeJpkiZj/xd5V6qowkLMz7
         9fzTAYw3bQPaOQrxIAyBMztGa67zHyd5QZ+kdX8lRhaa0t2vz7PwGsak+iu6rLvpO38B
         PN7w/N25HOnBRMuwC7ciNos+MPLB1Bxd8VMksodnlxDXIWrRluZoTvoGQHO9qAtBXoZi
         Kwwmxpxc2WhERFSdxTqrEp8uNHJ9IAnX6iEm+lWgiFG1o8/jndwNuktgmzyhv7F9guD5
         Fxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjX9OiCRZovNS7uWD7qtI1tuIPYpsaOZmyjT0QclAFo=;
        b=ve5CVqqFbEs3xQtH7Tb71JubxOuW7BE5UvMc1J1JeRmkKnrqQ3bbLuR/YM/jDdpjuD
         RoPqFbWQv+tKuuiLYDK5siT4R9vxcQ+Q0xo0pFyrIT4FP7HlA1erHp9nVauRqXCh0ut3
         4i62kgFF6IeTWsZ17qR1emo6ld16ZUami4jg1qyneo8hmnhJE/vlGHd3O8xSUpN69Cng
         GUvYdLHYfODtUSYySuFEiaFrHEPGXzfMm15NqP2r0a+sciHf7fV2N9bmO/awE2YEqqDP
         nB1jiujjWjvw1cyUnndTO1eJ2GrvcHxnyjEqbZilLtKHh1SpaimfyZzVveF/rP+n+pYm
         KdGw==
X-Gm-Message-State: AOAM533OIBbMqs7nPOvXIwyY5FUNGgNN6FN8h4LTj5qnJh1J74OnPn8Q
        HzYg9Q1rk6UmPFrs28OIUgQ=
X-Google-Smtp-Source: ABdhPJzJd1UCJJvv1QvVM06xqzDOGkc+c37rzWJj+lcOhADFhNzsU6dBpsMSxyK69YiEI2NWIzzPLQ==
X-Received: by 2002:a05:6a00:138f:b0:505:d077:33db with SMTP id t15-20020a056a00138f00b00505d07733dbmr1426061pfg.36.1649714289859;
        Mon, 11 Apr 2022 14:58:09 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id j63-20020a636e42000000b003987df110edsm641375pgc.42.2022.04.11.14.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:58:08 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list),
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Wang Qing <wangqing@vivo.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v4 00/10] drm/msm: Userspace allocated GPU addresses
Date:   Mon, 11 Apr 2022 14:58:29 -0700
Message-Id: <20220411215849.297838-1-robdclark@gmail.com>
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

The first six paches are various cleanups and simplifications.  The
next two get rid of redundant vma lookups in the submit and retire
paths.  Following that, fenced vma lets us indicate a fence value
following which the vma is no longer used, which is needed because
otherwise userspace could observe the signaled fence prior to
retire_submits() finishing.  (With userspace allocated GPU addresses
userspace is tracking when a buffer is no longer used and it's vma can
be deleted.)  And finally the last patch adds the new uabi for user-
space allocated iova.

v2: Fix inuse check in last patch, split GEM_WARN_ON() conversion to
    separate patch, and nits
v3: Fix nested fb prepares in 06/10, return -EBUSY if trying to set
    iova on buffer that already has one in 10/10
v4: Fix race condition in 09/10

Rob Clark (10):
  drm/msm/gem: Move prototypes
  drm/msm/gpu: Drop duplicate fence counter
  drm/msm/gem: Convert some missed GEM_WARN_ON()s
  drm/msm/gem: Split out inuse helper
  drm/msm/gem: Drop PAGE_SHIFT for address space mm
  drm/msm: Drop msm_gem_iova()
  drm/msm/gem: Rework vma lookup and pin
  drm/msm/gem: Split vma lookup and pin
  drm/msm/gem: Add fenced vma unpin
  drm/msm: Add a way for userspace to allocate GPU iova

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  14 ++-
 drivers/gpu/drm/msm/msm_drv.c           |  21 ++++
 drivers/gpu/drm/msm/msm_drv.h           |  23 ----
 drivers/gpu/drm/msm/msm_fb.c            |  20 +++-
 drivers/gpu/drm/msm/msm_fence.c         |   6 +-
 drivers/gpu/drm/msm/msm_fence.h         |   3 +
 drivers/gpu/drm/msm/msm_gem.c           | 151 ++++++++++++++----------
 drivers/gpu/drm/msm/msm_gem.h           |  52 +++++++-
 drivers/gpu/drm/msm/msm_gem_submit.c    |  32 ++---
 drivers/gpu/drm/msm/msm_gem_vma.c       |  61 +++++++---
 drivers/gpu/drm/msm/msm_gpu.c           |   8 +-
 drivers/gpu/drm/msm/msm_gpu.h           |   2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c    |  13 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h    |   1 -
 include/uapi/drm/msm_drm.h              |   3 +
 18 files changed, 277 insertions(+), 139 deletions(-)

-- 
2.35.1

