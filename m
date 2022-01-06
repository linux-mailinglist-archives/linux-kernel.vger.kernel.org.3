Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0D48698A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiAFSPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbiAFSPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:15:04 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635EC061245;
        Thu,  6 Jan 2022 10:15:04 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id g22so3300691pgn.1;
        Thu, 06 Jan 2022 10:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPOLEXfdQzQQdTmG9MNU+kg5OfcKlLIQc8Wvo+ywGFg=;
        b=dVcl5oZbRlN9CXKs1WzqWZjjyIYlqPwIv+8Zd+7ZjQI1W4gX5Di+KBMAbW8NZQmGSr
         FcWDIFkpSCXS7SiUQns/ZBTJpBDL3RV54+4chi0JqwuCrhjkxJO7Mnj+4PYTGZjnUeMI
         7yqr1J+jKmdvnhzptaLLBB0UtrnrxcljEnzeWhdLuZOj3vrpMP7jUgst12+MTml7bX6f
         p9IdkPDqDQI5VuWjvHXsanYE7tTaeT33NXEcpNfMn6h7zaqmdKXCzrJJWuEeM2LUftTC
         gkPD1lUl05d89MYW9rQFeDHbNn9fmhrlbHMOIEagXzbsuealBPdSZF5G/mX48uUFLjlt
         mVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZPOLEXfdQzQQdTmG9MNU+kg5OfcKlLIQc8Wvo+ywGFg=;
        b=2LCSES3WJ5ciNhGk/AzYYAZMBMPF9UDUEq7sHHA7d+7RFWIscN6L3f7tnN7L7CDMZF
         o8IQotDvpnCzrjxMtroc5Z2rJ6CkRkjYNJFSuofOCF3Lp+1vpJETBN0KqD78Y8dfNwyp
         RYx0fHHf6vykRq6FpeXp51D4GyCRM7+KB7Z35klwjLu8WUQNAOmbr7Utp1Q5Pv5VtMmZ
         iYLIZ0K8tNsLNYmQhFWYqnd8TDF8tPD7AkncpsO1QJ2oaHb4WaFQ4DwX6MRAMIb2qNZP
         qSMHQewT5Q9NgT1lXdYHxg19S0ePD0azWiCBynZ4zfxf3kpmUwCqOmosXCeRHMseCCua
         gBxw==
X-Gm-Message-State: AOAM533O2z5HSNbMG5/xesYqXh+1vavOOjU92vcLuMVENWKeojkQ5oU9
        K1qwGFBnYLvSzaa8i+rOif4BwBPp5f8=
X-Google-Smtp-Source: ABdhPJwGGsFV6PbXXGJkrzuiRrJR4ChU60O5/We5mhbGApzUnSXKi9JYqmb2ZJvzGlaYBbeJdU9EbQ==
X-Received: by 2002:a05:6a00:d6f:b0:4bc:df41:d0d4 with SMTP id n47-20020a056a000d6f00b004bcdf41d0d4mr8880838pfv.74.1641492904144;
        Thu, 06 Jan 2022 10:15:04 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id g7sm3118015pfu.2.2022.01.06.10.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:15:03 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list),
        Vladimir Lypak <vladimir.lypak@gmail.com>
Subject: [PATCH 0/2] drm/msm/gpu: System suspend fixes
Date:   Thu,  6 Jan 2022 10:14:45 -0800
Message-Id: <20220106181449.696988-1-robdclark@gmail.com>
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

 drivers/gpu/drm/msm/adreno/adreno_device.c |  9 +++++++++
 drivers/gpu/drm/msm/msm_gpu.c              |  3 +++
 drivers/gpu/drm/msm/msm_gpu.h              |  3 +++
 drivers/gpu/drm/msm/msm_gpu_devfreq.c      | 21 +++++++++++++++++++--
 4 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.33.1

