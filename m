Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B659B53F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiHUPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiHUPyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:54:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E71BC18;
        Sun, 21 Aug 2022 08:54:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v23so2654655plo.9;
        Sun, 21 Aug 2022 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bkh2RmwQz43pDpH6k4U/hhGBE1MuNMuBG/1+04H09nA=;
        b=ZNuEb7fEQxkPm2NNO2ZrPhQhxg0BwQRwImIdnuP6Yf88nqeoybObA5gVPi/QaxeDl2
         lMXau9nQFQN/XhXyesFCEWMsBo63C+eAi4u/rVGieZyYN6kjxqcl9iQynZQedN1tPBzG
         p9r5Xen6HBfl0pr9MDJ/T9bZd8jQhITDM3DCPkOKstNtSgKgnUcU4OkutHqMZLY9IB4M
         LxnMaAipIehqbD/frL8KKAdKDq5WHiWncxGG+XnFkP+QSY9P5FNr50Ldcf15qF/GFEz1
         7qHy/tzRU9+cVvIjIXToTf2d0996+QJIJ8MknJHzydRBfWG/RTxdTViurjUjKHHfqlPh
         NvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bkh2RmwQz43pDpH6k4U/hhGBE1MuNMuBG/1+04H09nA=;
        b=iOOxiap0gygtD/aF+i88KCPp4IPkQ/rp+/Y50qzeusTMhaKyvD1eltifOK14W5Djsn
         HnZVOoIbzu5PC/NiYmu6MLI2aTy6M0B09V4Xr31frjc0cMsXbTlgC3YzGAOeljEFs1nY
         ADX3PkZXWBDG6RjFqNh6njHbzk2XJdk17YD6RwHWeXrDRrJwumAzh7rkECuIeJKQEgAV
         djEqtbr9iMHM4ITqorNYiq71teFUAA85XlVazXxBeT445ABJo7Y9ZOYvkJfHrlZHCH5I
         u0Sf6tkpq8fnTRWCjCs4P9HwX+9NlVjH/Xmf3B5voUl/A2uovjzbB474fB0BZBvHkIrr
         N+jg==
X-Gm-Message-State: ACgBeo3JKihDabMQYQUHM7suhLHIq9nVGFSie2JctDmSDmPKF/XITCDV
        Gk32Bf5lcyZQftM7OJUdnJn6nKFaNUQ=
X-Google-Smtp-Source: AA6agR5Zh5My6hY3phecIGV+h3IPFUyS+zATf/VZj14J1TTIDjXcv0iGZrjT1Z8iftL+CvaKJJHV8Q==
X-Received: by 2002:a17:903:28c:b0:172:e5f7:f58c with SMTP id j12-20020a170903028c00b00172e5f7f58cmr2283522plr.37.1661097248488;
        Sun, 21 Aug 2022 08:54:08 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b0016bea74d11esm2910408pls.267.2022.08.21.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 08:54:07 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: De-open-code some CP_EVENT_WRITE
Date:   Sun, 21 Aug 2022 08:54:35 -0700
Message-Id: <20220821155441.1092134-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 2 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 0ab0e1dd8bbb..2c8b9899625b 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -68,7 +68,7 @@ static void a3xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	/* BIT(31) of CACHE_FLUSH_TS triggers CACHE_FLUSH_TS IRQ from GPU */
 	OUT_PKT3(ring, CP_EVENT_WRITE, 3);
-	OUT_RING(ring, CACHE_FLUSH_TS | BIT(31));
+	OUT_RING(ring, CACHE_FLUSH_TS | CP_EVENT_WRITE_0_IRQ);
 	OUT_RING(ring, rbmemptr(ring, fence));
 	OUT_RING(ring, submit->seqno);
 
diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index 0c6b2a6d0b4c..7cb8d9849c07 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -62,7 +62,7 @@ static void a4xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	/* BIT(31) of CACHE_FLUSH_TS triggers CACHE_FLUSH_TS IRQ from GPU */
 	OUT_PKT3(ring, CP_EVENT_WRITE, 3);
-	OUT_RING(ring, CACHE_FLUSH_TS | BIT(31));
+	OUT_RING(ring, CACHE_FLUSH_TS | CP_EVENT_WRITE_0_IRQ);
 	OUT_RING(ring, rbmemptr(ring, fence));
 	OUT_RING(ring, submit->seqno);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4d501100b9e4..c8ad8aeca777 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -146,7 +146,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	 */
 
 	OUT_PKT7(ring, CP_EVENT_WRITE, 1);
-	OUT_RING(ring, 0x31);
+	OUT_RING(ring, CACHE_INVALIDATE);
 
 	if (!sysprof) {
 		/*
-- 
2.37.2

