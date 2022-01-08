Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB4548853A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiAHSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiAHSJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:09:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18586C06173F;
        Sat,  8 Jan 2022 10:09:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so16630047pjj.2;
        Sat, 08 Jan 2022 10:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DocxFXdAJY37L6DlG3De/ynEIKw/NoYzpHSiyKpP1us=;
        b=SMD7T/2epjcnWjFmIgvtvEsWI+xc6iu760NJAZauiT9yO3Km0BZNCCYoEGzUhcsDpO
         BPCoXIfQfsj8C0ErQYCA/XO234JEZGfxPmaCkCEmuowKjGWrqTkRBkeM6cIHI9UftZ4+
         HEyoInJwCzCcYg3bCp7eC74248eN9ypLtYlsiPODduK+wOHRzZfjLigti/DTz573JGwl
         tkZnnI71N6PK2pA1sbZrgciShS5WuC8D08CqnJ3ZGANEp3vcMzxbKaOAtYh8zNcliHVF
         6ckPftLKasIRtQOMPDtHJlRTK1Leqy3oZ/5I0yANMiEqNLh2EYiwvKXUJHzqlIR+NIDJ
         9YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DocxFXdAJY37L6DlG3De/ynEIKw/NoYzpHSiyKpP1us=;
        b=x28bvBn8+Go8rusPqioOKJC4HbSLyKme3KVhbzfrUs5fPGU5SCmvouKPd+AsIExAC1
         44DiwTlv2vnMkFmS9EZ4gn5zZVn0JnDx6pI3UB+SJ6TTxdyaaGSkI5gtiaOv5WOgA1HT
         prI6Fe1HyR/ysFoT2m5usMN0+7kJu7mAksPYVjC5GBf72KJmoj/T16x8o5JXBYBR8q5o
         4eUwBjyiBbOue+NtSbIR6tJjoZm3r200xYisVdqRxqG9vV1ohUC29eJSBcdEgmDjQx35
         oEnmGazViRXaVHHKoLMj/v9C15iCSPaf+bXexq9B9sFTx5/qNsdgk4QjFfRKLOoJdeiu
         h3sA==
X-Gm-Message-State: AOAM530ntz3e9xS5Z0y0UpQQ2p5MFRGqGqatDKWdQEuZryWF6sLuXr19
        DVuNIsGv3tmfGlOlera50HM=
X-Google-Smtp-Source: ABdhPJyJLFZ2l0VKMwTPAPRHyqaK0kNwqFAAoswZCfQgHtGirzg5qrPr0kRZgHcms1ohydXGRRGLYA==
X-Received: by 2002:a63:9204:: with SMTP id o4mr39996960pgd.596.1641665363603;
        Sat, 08 Jan 2022 10:09:23 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id t191sm2049854pgd.3.2022.01.08.10.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 10:09:22 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list),
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: [PATCH v3 0/2] drm/msm/gpu: System suspend fixes
Date:   Sat,  8 Jan 2022 10:09:09 -0800
Message-Id: <20220108180913.814448-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Because system suspend uses pm_runtime_force_suspend() we can't rely
runpm refcnt's to protect us if the GPU is active, etc.  Fortunately
*usually* the GPU is idle when system suspend is triggered.  But that
isn't quite good enough.

The first patch attempts to block for a modest amount of time until GPU
is idle (and failing that, returns -EBUSY).  We could have taken a
slightly easier approach and just returned -EBUSY if GPU is not idle,
but that would cause system suspend to fail.  And no one likes pulling
a hot laptop out of their backpack.

The second patch avoids getting devfreq callbacks after suspend, since
pm_runtime_force_suspend() breaks the pm_runtime_get_if_in_use() tricks
used to deal with devfreq callbacks while suspended.

Rob Clark (2):
  drm/msm/gpu: Wait for idle before suspending
  drm/msm/gpu: Cancel idle/boost work on suspend

 drivers/gpu/drm/msm/adreno/adreno_device.c | 18 ++++++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.c              |  3 +++
 drivers/gpu/drm/msm/msm_gpu.h              |  3 +++
 drivers/gpu/drm/msm/msm_gpu_devfreq.c      | 21 +++++++++++++++++++--
 4 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.33.1

