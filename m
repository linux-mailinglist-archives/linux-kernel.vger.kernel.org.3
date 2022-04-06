Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157D74F6D79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiDFVy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiDFVwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:52:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A213E3F;
        Wed,  6 Apr 2022 14:46:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so4224151pjm.0;
        Wed, 06 Apr 2022 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CkfyiKrfymnOnK0EWh7i1INSgOHYBA/tWH69CgASpO0=;
        b=SWGT0CpR2h+e8t/dq9fbCqwGiZLLkh7/LSkWSszvAoyz0gM2C2Mn4NR0XNtKO3jIHO
         6MI6LH6EKtxhfhBx3V9nRKR2EKKptHiUN5tkesiycFAGO1N5BlAgoNLb/cEOvbhFG4nB
         QqZpr39h5HdBjq6KeKrcyBrFN3T6woSB/O2M3EjW4KIbcwjxnMe+QgQPuU9T53el1cpr
         T8m+53Zdl5eI67t+dtfwmYexj6zIN1okpyIan7MUost9AMd5/te5wkHHkV4xB1EKZnc5
         swZFiki4Ogxqnipn5wfa3VvG1jvboEMltJuAObAiAirDVyBmCe6bpblQfVICSp4Oja1n
         SVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CkfyiKrfymnOnK0EWh7i1INSgOHYBA/tWH69CgASpO0=;
        b=0+WXrh1koy2OCpyLM/UZx9Qq4kwKr7L/dgRyDurJAkULtdEBkPjb863ch0edEVm9ge
         0FDfwQ+MAb+nAGpvQwGjGTXIhDZsWcS7+iWR559qGw2EeSAk8wxMl67TUKhAARHjcT2/
         YYGkvIQgDXGvdfDMLgRpfQE1r+5EK9Tm8oPuYjqIIjH/wbrw1Pncfkqax5EOSe+V43Ch
         on5EYl/YnVQ4gcfZS/kA0w1iK3bPWFvPs+lprOEefLOYLZwR5+Oo171uNR/LURATwnjw
         /RQUiQSdEbmRKj6dvd1H5X/pLEwfh3hKXi+18gsEa5NaOpX1Dfmvw0TFzsDoOY1FHeBD
         +l0w==
X-Gm-Message-State: AOAM531RUNAsIhzUoyepe1gvtTsY4h5HEmsMp0QT8eW5KCtr3xWTMTKG
        ACI8Y5OUlmtOADZqxfOwpKE=
X-Google-Smtp-Source: ABdhPJxwUPsOIMPEeUMSDmd1Dismd7EZeSiKJZLKwwpOnWoiIlPLX8vmG2SjQh+6tbo+/dcs4XrTCg==
X-Received: by 2002:a17:903:2452:b0:157:69d:744f with SMTP id l18-20020a170903245200b00157069d744fmr54104pls.47.1649281581862;
        Wed, 06 Apr 2022 14:46:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id rm5-20020a17090b3ec500b001c7559762e9sm6536425pjb.20.2022.04.06.14.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:46:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list),
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Wang Qing <wangqing@vivo.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 00/10] drm/msm: Userspace allocated GPU addresses
Date:   Wed,  6 Apr 2022 14:46:16 -0700
Message-Id: <20220406214636.1156978-1-robdclark@gmail.com>
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
 drivers/gpu/drm/msm/msm_gem.h           |  47 +++++++-
 drivers/gpu/drm/msm/msm_gem_submit.c    |  17 ++-
 drivers/gpu/drm/msm/msm_gem_vma.c       |  59 ++++++---
 drivers/gpu/drm/msm/msm_gpu.c           |   8 +-
 drivers/gpu/drm/msm/msm_gpu.h           |   2 +-
 drivers/gpu/drm/msm/msm_ringbuffer.c    |  12 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h    |   1 -
 include/uapi/drm/msm_drm.h              |   3 +
 18 files changed, 262 insertions(+), 131 deletions(-)

-- 
2.35.1

