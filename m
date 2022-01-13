Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5E948DBD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiAMQcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiAMQcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:32:14 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F3C061574;
        Thu, 13 Jan 2022 08:32:14 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n11so8644696plf.4;
        Thu, 13 Jan 2022 08:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+3q5GmFbYNyEJgrrlP1Ic3dY/1SWaaTPA9VEhYfsQJU=;
        b=d2Xxijoqk1QxRW3U9287LjfQMlQt+Zec3Aq3Nchqnw2EWG+HksVI/vEUzpHE/dfibA
         UZER/wPc+2d3Xj+o6c6iamOXGQAZIs+YtR4EBaekNegFq4Mko78lNZzwRda2/s5YeeaZ
         7xHycysmT01PaDS+tM43VLDWaUUO/epZW9nen5LXHCIWPFrxAqkvBXaIthJ4gxDv7lh5
         Kgn5MmaGRKqqwLvokqAskJ/lyShZLolLBISSnVHJKWZ6Hza0HU3Ne4CoFzucpfdqijK1
         y0/Ob77r/LjPOdqB9gun5GShbWxLXj3Nixw5KVs2XXGDfkfyUi1FB9KChHfeiCP0KX+h
         2tgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+3q5GmFbYNyEJgrrlP1Ic3dY/1SWaaTPA9VEhYfsQJU=;
        b=zPQfEiCC6/2z7WFpmSYjAfDJnSmVf8OK5R0Qx9UZ8a2mdFEDVwhDV30Imegx/lNyrv
         c7dQCOe/c4wvonHmdHic9OZgYV3sAenyK9JIVIAwJFBB0sJScArMtcSffSwSVWGSRTF9
         /A3mIFb/K42XwxC+6puFCkj3ZtgQc/HG7WEBLdShYA2SjHNe+IAtV8yQezgk9x9u94ho
         luipv0+Vb56k8TQSkrMF0CLg9Kne+LDs9eJrqHZy/QzsxnRbO+djiLuoS5Lj8yXS+Sl/
         tJfrp/G2o+PFMcEMPmWdoAyRMEonbZV1BMHg337fpqaJb2QLJ089a3KRnWROw/aCg5s5
         uiDw==
X-Gm-Message-State: AOAM530ZaZveTM9OBeRGyPZSZxH9exIvKZSwvc62uxnhZiMortlnLDGA
        ZugvpXEyOJIRKfpF/RUANZc=
X-Google-Smtp-Source: ABdhPJyJl32B4r9KsE63UDv2Xaa30wFKuy2pT+8hjSFdNf9DEJ1Gz6eszjXC7Cb2AJywPnufEKWtBA==
X-Received: by 2002:a17:90a:458d:: with SMTP id v13mr14966962pjg.202.1642091533656;
        Thu, 13 Jan 2022 08:32:13 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id j18sm2661612pgi.78.2022.01.13.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:32:12 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Danylo Piliaiev <dpiliaiev@igalia.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: Add missing suspend_count increment
Date:   Thu, 13 Jan 2022 08:32:13 -0800
Message-Id: <20220113163215.215367-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Reported-by: Danylo Piliaiev <dpiliaiev@igalia.com>
Fixes: 3ab1c5cc3939 ("drm/msm: Add param for userspace to query suspend count")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 51b83776951b..17cfad6424db 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1560,6 +1560,8 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 		for (i = 0; i < gpu->nr_rings; i++)
 			a6xx_gpu->shadow[i] = 0;
 
+	gpu->suspend_count++;
+
 	return 0;
 }
 
-- 
2.34.1

