Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D58B4CE641
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 18:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiCERe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 12:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiCEReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 12:34:25 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D683C15137C;
        Sat,  5 Mar 2022 09:33:35 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 132so10112620pga.5;
        Sat, 05 Mar 2022 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12jc84zVACmPZitAQSCb3aE5VlqyZHrB+UXDuxQbIOc=;
        b=OJKGYJts4lLE8sv13wBz+01+qJke1kaef4oTLqY+k4PRzNLU9gIOW/2YYRAMR5Is19
         YWW/6bQLg21aOiZ2U9RzSZS0io6k2XgufBQU7fsgymUBtvEkOVJbio6mUTZOPHjZv5mk
         yWnvftE8JsLQG1Vcu1UNu5e1PhWmQvmtCHzbc8nXGTmzj910ZIVMK1lkz5Jf0CQrlA0G
         RQ6ie8vDIYEDONm2VGnBSrDHpKWhaq+tMz87ZVoQnQK0I9vEJnM6nT2jEyfUBedFw6z9
         O1wea9/NgpRcO+0/QKorOYL5InhT1hFEWGF2Nnunn2xYpqH6xClZ9LyRpM17ALe1KNTk
         5LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=12jc84zVACmPZitAQSCb3aE5VlqyZHrB+UXDuxQbIOc=;
        b=eoBi69u1O1aUG1Muo1YtiYKL4NHVpIQyDU3ORbUsIbf/pIPzMlUystYOBUP1IYPHcH
         bf6QD8G1dJBudj8G38rS5hgfPsxaLjDtrFQyBQPCLZN6wfaabMcKt1Z5If7/5wqL4xMb
         GByiHTr/sFFYl6XfLbvyYHFoA7/32P/qjxRHnCBG6wyVTetvzH7w7WtkW+6uIU1xpCnM
         aRt9bgcmNJ7z8tkFxOF254OyZAgDpM/7ZgXITSaqISR816ZZWWsKf+J9LrJ2l/aMQtHq
         R+5HwJMrX4yPPwpFX71CzpGL2oBtDuLdmofb6RWx1bMkjkPWTiudkg78PRXwUdvl1llX
         oOVw==
X-Gm-Message-State: AOAM531mxGKK4spvRHnh2IMCTtIF7ABOiFK5WxotIkMBlcsTsulEbtJM
        2psMVP4Pm1Oh7y3bHxEu3Sg=
X-Google-Smtp-Source: ABdhPJwUZoMD1qdQmW7sKJkY/P0Jf8kaI1M3DCVgtmJsxT5spI6VebPuV35teZIfIPfgdje/kVVyDw==
X-Received: by 2002:a05:6a00:180d:b0:4f6:d697:7df9 with SMTP id y13-20020a056a00180d00b004f6d6977df9mr3302231pfa.71.1646501610505;
        Sat, 05 Mar 2022 09:33:30 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id l62-20020a633e41000000b0037fee1843dbsm2922838pga.25.2022.03.05.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 09:33:28 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: Fix missing ARRAY_SIZE() check
Date:   Sat,  5 Mar 2022 09:34:03 -0800
Message-Id: <20220305173405.914989-1-robdclark@gmail.com>
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

Fixes: f6d62d091cfd ("drm/msm/a6xx: add support for Adreno 660 GPU")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 02b47977b5c3..83c31b2ad865 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -683,19 +683,23 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	const u32 *regs = a6xx_protect;
-	unsigned i, count = ARRAY_SIZE(a6xx_protect), count_max = 32;
-
-	BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
-	BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
+	unsigned i, count, count_max;
 
 	if (adreno_is_a650(adreno_gpu)) {
 		regs = a650_protect;
 		count = ARRAY_SIZE(a650_protect);
 		count_max = 48;
+		BUILD_BUG_ON(ARRAY_SIZE(a650_protect) > 48);
 	} else if (adreno_is_a660_family(adreno_gpu)) {
 		regs = a660_protect;
 		count = ARRAY_SIZE(a660_protect);
 		count_max = 48;
+		BUILD_BUG_ON(ARRAY_SIZE(a660_protect) > 48);
+	} else {
+		regs = a6xx_protect;
+		count = ARRAY_SIZE(a6xx_protect);
+		count_max = 32;
+		BUILD_BUG_ON(ARRAY_SIZE(a6xx_protect) > 32);
 	}
 
 	/*
-- 
2.35.1

