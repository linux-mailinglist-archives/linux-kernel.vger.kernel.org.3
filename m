Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4B54C38EF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiBXWnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiBXWnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:43:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB51A8049;
        Thu, 24 Feb 2022 14:43:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j22so1771572wrb.13;
        Thu, 24 Feb 2022 14:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bWKLMT4aebSJWW8C7UiCQ3/EbG02GUUsHveIfrNn2xE=;
        b=hm/yI1Cy2Kc8mLeeLsOCHupF1kEHeji6XjXMjWyWbiitXdcqzotkVsqhN+bU7+hwc5
         t/Jct+cxOWL03KF/nmu3K5nzMPMgen47vrPBS0NpiuJd/X0wuYF5NXJZvIQIRiPt2m2w
         t2heHb5g/O+V72fy/UUlcjmfXgRF1p8E3GHQEcggq0h2lJaFK8l+BwBN9SYa65n/7a0w
         2C53p+XtaPhGaJgtIquK/MEhhm+6m50rt73HguwdIImHYO/TW5gJo2qec+hnLWvUZBh3
         2QRVv8+FfvYeIyvjXTU9Cn8tYpHjqa6RN24Eips/xUqhHgITJM9cj76iUEBh5xuAIJv1
         Izig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bWKLMT4aebSJWW8C7UiCQ3/EbG02GUUsHveIfrNn2xE=;
        b=EIl8b4/Qiwc16ZXPK3nO4OD6MEDU8DWImbOCGMaLelOgfabBA/fqItXAegf2RPndgD
         /8Tx2eHYg4Idqc+pnamzx4Es27qJjZ/JF00nRV9TBZsjb6BR4Vl5z9VcU9capcBVBcmC
         AWP0s7bBFrfcOOvI83RQsW0rNPlJFwLQbi5G2eRaGLc+P9NC4TYiSP32AMXLJ+M6VVrJ
         q/Sba+qdEK4sGmTbxTDWUae+El9YcYXpEPMLjKncSI/fhA8axjFbbl96z7DbAkwkeesn
         ecJ+c8vFy2uwXgUBK/Io+F6J/dEgnJJEb5BYugC0QxRP1Pt9NpC8fmBuS7ChXAbofY/E
         dHlw==
X-Gm-Message-State: AOAM531x9IYS/OHXqx8HfHENf34opeABGlihRPI33X7r8DEYwHATBVI8
        IBPdQi1vtxjt9bVevIElBiM=
X-Google-Smtp-Source: ABdhPJx+iF7F/adABVhKlAG8I0mrA22SnXPr653iA75eyj2+GDckFVmGWApaNaHjkGCuXsZThToCeQ==
X-Received: by 2002:a05:6000:2c4:b0:1ea:910c:151c with SMTP id o4-20020a05600002c400b001ea910c151cmr3801018wry.92.1645742597131;
        Thu, 24 Feb 2022 14:43:17 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b001edb61b2687sm736421wrt.63.2022.02.24.14.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:43:16 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH][next] drm/amdgpu: Fix missing assignment to variable r
Date:   Thu, 24 Feb 2022 22:43:16 +0000
Message-Id: <20220224224316.149704-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Currently the call to function amdgpu_benchmark_move should be
assigning the return value to variable r as this is checked in
the next statement, however, this assignment is missing. Fix
this by adding in the missing assignment.

Addresses clang scan warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c:168:7: warning:
variable 'r' is uninitialized when used here [-Wuninitialized]

Fixes: 9645c9c9fb15 ("drm/amdgpu: plumb error handling though amdgpu_benchmark()")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 3136a9ad2d54..bb293a5c6fd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -163,7 +163,7 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
 			 "benchmark test: %d (simple test, VRAM to VRAM)\n",
 			 test_number);
 		/* simple test, VRAM to VRAM */
-		amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
+		r = amdgpu_benchmark_move(adev, 1024*1024, AMDGPU_GEM_DOMAIN_VRAM,
 				      AMDGPU_GEM_DOMAIN_VRAM);
 		if (r)
 			goto done;
-- 
2.34.1

