Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7545454CE95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbiFOQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiFOQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:24:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7975032EE6;
        Wed, 15 Jun 2022 09:24:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u2so11908332pfc.2;
        Wed, 15 Jun 2022 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=py6GEyuDmZJFdYOHYjHaNYQonIUxCggLBa4xNxCVPiI=;
        b=lwp84MUy8aVK38zeHShl+5sWGRLOP7YtFKjClNzK9QETCKTdvHtTQwSV7YX7IAleTZ
         hhnASLIQAYmpoY2kT26DOKUhr2JdllSmRc/ZsxynkeE0cvqwbGz0+vHcrRo8Gi7uhX12
         ysn+n/bEjOIcuJZ3cnSbZW8ySuu9jn0j+ZUEl+6E8n+sKXzkerb14hAAvpnD8r+UxN5L
         tCi6GW08Nr/0izW5Y1Q6z7d3jsfSNXxD4RHVmKG9w1y5tRsyzZZrYEe3pPw+0E0ffeZF
         /7YEtZUUD54Et7Xnv60CWfGdNQlX9zgEHStpar6E1h725mj2spJZ9ioTck4nEZsyoiLG
         yp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=py6GEyuDmZJFdYOHYjHaNYQonIUxCggLBa4xNxCVPiI=;
        b=MLLwiGzym3cMA4hUTD9LgT6elFLILgD7tFWXwNC+c9Zu8NTP1qVzEKwSu1aUmGXGDm
         vVeTltfEfFc3uHmOMPWZ/34NEO4wbt1xUBjyAh3Ruqea+Oyc7g5+gJtI0+I2ie6WEfi7
         lnRXSUk08F3bQFmi3DxOxMHXcdL2ZXvxxo67x1or5/2ASWi168DGYlzH3sN9qUVxd83K
         BdYYRuMsbyt0c/rpa/3VHe9Sq/Rl7vkliNubjsh8o3pko2j7OxEmOTtJPswnZqUH9T8l
         d81top2INdeVXtCN9vPidsyx+W3eOjwp6wdVW6/q7rJ++s6YCkdl77URJQLKqUjXUrrt
         s5ag==
X-Gm-Message-State: AJIora9+iNlPpLVfX7CmQM0MTewRiNpf2TDsiJFx5F4cq3ndJT9ycKme
        T1x8pRgfuP9nOOkBfoKsNKo=
X-Google-Smtp-Source: AGRyM1tGREJNu5awib9cAUO8GkgnbOfiIQsGUbIPOrc/TUh8iC3c1m0/3l/Ns5AH207ke8bLqFgObg==
X-Received: by 2002:a63:824a:0:b0:406:59b2:b5b4 with SMTP id w71-20020a63824a000000b0040659b2b5b4mr556905pgd.190.1655310263864;
        Wed, 15 Jun 2022 09:24:23 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id o22-20020a17090aac1600b001dff2fb7e39sm1995523pjq.24.2022.06.15.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:24:22 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix fence rollover issue
Date:   Wed, 15 Jun 2022 09:24:35 -0700
Message-Id: <20220615162435.3011793-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
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

And while we are at it, let's start the fence counter close to the
rollover point so that if issues slip in, they are more obvious.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_fence.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
index 3df255402a33..a35a6746c7cd 100644
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -28,6 +28,14 @@ msm_fence_context_alloc(struct drm_device *dev, volatile uint32_t *fenceptr,
 	fctx->fenceptr = fenceptr;
 	spin_lock_init(&fctx->spinlock);
 
+	/*
+	 * Start out close to the 32b fence rollover point, so we can
+	 * catch bugs with fence comparisons.
+	 */
+	fctx->last_fence = 0xffffff00;
+	fctx->completed_fence = fctx->last_fence;
+	*fctx->fenceptr = fctx->last_fence;
+
 	return fctx;
 }
 
@@ -46,11 +54,12 @@ bool msm_fence_completed(struct msm_fence_context *fctx, uint32_t fence)
 		(int32_t)(*fctx->fenceptr - fence) >= 0;
 }
 
-/* called from workqueue */
+/* called from irq handler */
 void msm_update_fence(struct msm_fence_context *fctx, uint32_t fence)
 {
 	spin_lock(&fctx->spinlock);
-	fctx->completed_fence = max(fence, fctx->completed_fence);
+	if (fence_after(fence, fctx->completed_fence))
+		fctx->completed_fence = fence;
 	spin_unlock(&fctx->spinlock);
 }
 
-- 
2.36.1

