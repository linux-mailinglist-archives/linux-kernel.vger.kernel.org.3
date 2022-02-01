Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC44A6129
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbiBAQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 11:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbiBAQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 11:16:08 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56545C061714;
        Tue,  1 Feb 2022 08:16:08 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id z131so15713978pgz.12;
        Tue, 01 Feb 2022 08:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z552m5AcP5etVlHRK0+tWqqO0U3d4xBy54uwMDmgho=;
        b=ZAqR/gBucsSsJR+hfxdCZop70afx4XfLHuzI5FzWwFFvIx7fOq2pgoItRMdOUyGsLO
         jp1PfISnjETOzfDS0NCLofIAApK3cQfKbrAEDs3tUwMwdUlocO+XLtfQkFhCjOjvOllj
         pk5Ysmrk4+xHtFO04jCd0//spn1e4BDyJ08wU7XYyD+Jya1k/GfMohxn69t3Q8ZtfgP9
         PnG7nvuS0PUhniLgWQ35Gu+DYj8ntJ5aM/8C7Gl77iYNZXkDPC3Z6E1/cUqBgghMqVML
         u54dffPiF5fRKnxn1ra8GIFzmCiV7eWkzdqAIynI5HjA/5LoadVPXgxOUvppnTWPNLFR
         J/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1z552m5AcP5etVlHRK0+tWqqO0U3d4xBy54uwMDmgho=;
        b=K+XViV9SGu3V2JEjJEZQHZus0b683UyWYQ6R9O/Zc03AO8Irfnrx3dLpR+0bQ5DKpI
         G0jhiaBO8CBB+eDAruWpLwWktSMy81kYDAb3ZuTPx2SnEKwHuLgwtw0xX6hgj53Ejsq4
         NubgbLwp04rdV7GAt9SwLt9yW04Tu7hnVtMFkQuFL+BV9ExUuKrUFOPe59oOcISXPYKX
         O/F0NK1TFR22iGb+PcUaV6kWNeoHnToMreT8TAYey+1MIO5orJTKMqIIs5F0Mk9PDtZ0
         nOpO2m2Jj/qVFHNCbWcnoztdIEvnIrocXDyd+Q3vB++ykNbR+5uFUyEemnv/u/gfoGBz
         JyNw==
X-Gm-Message-State: AOAM530sD0jLJARiL+t34MgM0Qp0RghEx7hYnPWh+Y7gUvHkiR5ucOiv
        Gnr0EaFImPNiXqIMfA4bfnY2Nm7e06M=
X-Google-Smtp-Source: ABdhPJwHJOa8LNQvh6cGDOag9uq3jkCN051+pZ3ohETZm4elKnh1tepyZ8ZsPt2+XaN8I6ZI0MH9LA==
X-Received: by 2002:a05:6a00:1ac9:: with SMTP id f9mr23920358pfv.65.1643732167741;
        Tue, 01 Feb 2022 08:16:07 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id a1sm31503548pgg.18.2022.02.01.08.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 08:16:06 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Emma Anholt <emma@anholt.net>,
        Yiwei Zhang <zzyiwei@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list),
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 0/2] drm/msm: Add tracking for faults associated with an address space
Date:   Tue,  1 Feb 2022 08:16:10 -0800
Message-Id: <20220201161618.778455-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Currently, for GL_EXT_robustness userspace uses the global and per-
submitqueue fault counters to determine GUILTY_CONTEXT_RESET_EXT vs
INNOCENT_CONTEXT_RESET_EXT.  But that is a bit overly paranoid, in
that a fault in a different process's context (when it has it's own
isolated address space) should not hurt anything.

This is particularly annoying with CrOS and chrome's exit_on_context_lost quirk,
while running deqp in the android container, as the deqp-egl suite has
tests that intentionally trigger gpu hangs (for the purpose of testing
the robustness extension), which triggers chrome to restart, which
restarts the android container!

But chrome doesn't need to know about these faults, thanks to address
space isolation.

Applies on top of https://patchwork.freedesktop.org/series/98907/

Rob Clark (2):
  drm/msm/gpu: Add ctx to get_param()
  drm/msm/gpu: Track global faults per address-space

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 5 +++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 3 ++-
 drivers/gpu/drm/msm/msm_drv.c           | 3 ++-
 drivers/gpu/drm/msm/msm_gem.h           | 3 +++
 drivers/gpu/drm/msm/msm_gpu.c           | 8 +++++++-
 drivers/gpu/drm/msm/msm_gpu.h           | 8 ++++++--
 drivers/gpu/drm/msm/msm_rd.c            | 6 ++++--
 7 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.34.1

