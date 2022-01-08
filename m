Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD45748850B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiAHRnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbiAHRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:42:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C83C06173F;
        Sat,  8 Jan 2022 09:42:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m13so8895065pji.3;
        Sat, 08 Jan 2022 09:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DocxFXdAJY37L6DlG3De/ynEIKw/NoYzpHSiyKpP1us=;
        b=VN6igdtm1jasxSDZCJasInfzcPtKDYiG6dlzn5QRWC/PguzY5sQynBrkCKFzwSjmso
         2Q2C2A3qW0OF6ECecyH4pegwc67rE/l7J+snomunwR9oMcrioYQ7gi6wc9lZfAMdx44l
         n2PR1idWzWgyqzTUcYcA57Y1RLI/QP358QYV6/Wd6wTyl06Uk8vX3f9TjNixiZP5SeG5
         FwDt1Ch0l3SsPhMSsLc0eEKJIXoNJtAEdIwsAfONoX3XXAU5mbJDl+RoI4mbynM8Pn6U
         xrmM1QOpTXkIL5Vu6Q1tCN/AdbCzWPR0OAfHS3eBN5lY/7BewrrUbQs5gQgMmm4H5wV9
         ZgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DocxFXdAJY37L6DlG3De/ynEIKw/NoYzpHSiyKpP1us=;
        b=yrTCMTw/HPdDz0Jv8/8UK9a29IsPXjLdQVbVweFFv/7cHpcjYYdX6nof3DyKzD0+KT
         NE2Odsg+D2YMGwETDacSDlD/GIq8GBkIYWj5FtDXRtYqiASaahCkri/P9HfaUq/oEtqx
         16K65YQHUZLOCZf7watTTJXyvhdFoKZb5UHxLVG5FiF8QkP9YsccMuUn7vYnqGBD5G7W
         CLhjfVVaTPOx+txFIdXxUdZ4Q7cEtbDaSSSFVTOx4W9FlZIJZOEl5ngH7fXiu/BUey0f
         3PiobRujNg98NW+qpa2gxlT5eVQRSZJlC2vL7l9UyiYLKOpfP6uBuiFsVJWfY8QeHK5I
         JTxA==
X-Gm-Message-State: AOAM532c8tmuYBsM2kn03/7PjOtFMxrt2/xqQG49mBheHUwTxW5ZPAPL
        qrglJoLc49KZ41/rKByAgpY=
X-Google-Smtp-Source: ABdhPJyQFElIB145usE9UleO1jJm1lgiEQlewGVf1MSY3TTEKCQ6becE6JZA8OJrSbAyNt4hxbUGAQ==
X-Received: by 2002:a17:90a:e018:: with SMTP id u24mr2263766pjy.95.1641663774489;
        Sat, 08 Jan 2022 09:42:54 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id z13sm2032839pgi.75.2022.01.08.09.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:42:53 -0800 (PST)
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
Subject: [PATCH v2 0/2] drm/msm/gpu: System suspend fixes
Date:   Sat,  8 Jan 2022 09:42:45 -0800
Message-Id: <20220108174249.811872-1-robdclark@gmail.com>
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

