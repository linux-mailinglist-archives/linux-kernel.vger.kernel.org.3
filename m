Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8CB49E877
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244340AbiA0RKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiA0RKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:10:41 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D9EC061714;
        Thu, 27 Jan 2022 09:10:41 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id e28so3210379pfj.5;
        Thu, 27 Jan 2022 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CDYV/P4O/r3dgztPFLJV9lZu9zFEjn3L3fRfL7MbBg=;
        b=Hk2vLuMBhTwAlb4KfBdcApLjWnZDozauE3TjJ4sb/iJXaqrO1FrsL4c3Ws4Qg/zHQa
         mhdSVaD+Ic9IGShFa+PSVgTzSHCFmYgn+1hEO/JunIX/mqEWJ9Ao2zlTJIiia4kgw8AP
         +2Os0rxdyQcQay1394o5TuMIfMnf+CFkhpyudSbLhk6Wn72mz+cGXyE9fkzSqUMi9j3Z
         p9GTZQFq3QSoI0tJEUjB7AMybt2cxsEbFExufpG2VwoLRJoSuJR4bOzZ7eBquYvhfqTn
         LSF2GpnxOyxXe2vqrrwi4uBA6bHJwmFWhFYQs9ak2ljg/SblZiV2ssf7F62H9TiYTwLt
         zD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CDYV/P4O/r3dgztPFLJV9lZu9zFEjn3L3fRfL7MbBg=;
        b=cF8+L/C5tVVnpamTKW0dSJsxw+YqfgQ4TIN/HjUzn3B2KyRf2LKd02lUhSCXgRaIfj
         8CwQ6qYDmBvfnrw/iM8ZCoyKlSmM9M6GFHKkYp1IeShWFPFOq05XHLoLKkFPRMLJpit/
         WQn3MCe1LJCCJdlXUbDaKpQDFG0eCpwKdLp5lSDc3kOXEyeCPZmxhoSTyZQiugPYcqic
         W9tqJ5Do8BNq2qVAEyFJuUQFI23xBLxXnGQ5Yi/YO0a0QkNdzY0ER9KSI6zVVZh+1bZl
         GPpPcI8aqdWu9GvgzvK6PatRB6JLOTZj/hMur53bhkXdrwiBujFYm9u8nbAFtfCkD+3p
         vZww==
X-Gm-Message-State: AOAM533LJWVunH+qBypZXZF6RuTYfYS9vp6BzKuIV3BdHi7yK6WQ34Nc
        N9oH3jdhHK4YpCIys2AuOfc=
X-Google-Smtp-Source: ABdhPJzn1vEhu3bWNINfrUH4IlHRDhOyZTM5Rr6/CueuFg55HYzFq/5BYJocgMN50qBBIF+3eEgakw==
X-Received: by 2002:a05:6a00:15d0:: with SMTP id o16mr3722269pfu.19.1643303440786;
        Thu, 27 Jan 2022 09:10:40 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id 84sm5779217pgd.66.2022.01.27.09.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:10:39 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list),
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/2] drm/msm: Add tracking for faults associated with an address space
Date:   Thu, 27 Jan 2022 09:10:37 -0800
Message-Id: <20220127171045.541341-1-robdclark@gmail.com>
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

This new param gives userspace a way to ignore faults triggered by other
processes.

Applies on top of https://patchwork.freedesktop.org/series/98907/

Rob Clark (2):
  drm/msm/gpu: Add ctx to get_param()
  drm/msm/gpu: Add param to get address space faults

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 6 +++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 3 ++-
 drivers/gpu/drm/msm/msm_drv.c           | 4 +++-
 drivers/gpu/drm/msm/msm_gem.h           | 3 +++
 drivers/gpu/drm/msm/msm_gpu.c           | 1 +
 drivers/gpu/drm/msm/msm_gpu.h           | 3 ++-
 drivers/gpu/drm/msm/msm_rd.c            | 6 ++++--
 include/uapi/drm/msm_drm.h              | 3 ++-
 8 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.34.1

