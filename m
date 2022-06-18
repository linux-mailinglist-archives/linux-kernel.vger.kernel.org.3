Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6855060B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 18:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiFRQLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 12:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbiFRQLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 12:11:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E01A15717;
        Sat, 18 Jun 2022 09:11:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id r1so6233018plo.10;
        Sat, 18 Jun 2022 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=101twesbPuze1J2X5qjELU4Po4+yCThzT6Am7N5Pye8=;
        b=Nz/mSiNmtorVh9k+ROHp/waVo3dX9+KbqBDiCsTJlM17uOzyAItBYDPHngSpv2DtnN
         Pubj2Jb3HZgktpWgYKl+lgrd0ZcBza9f+qvi6LkqtNAaxYLRbnV0OsN23IARMt3nLKku
         j59HB2AIC+sw3fYMssFU+LtuZdIhuGljhvOh7Kcd67d4NbM4ZtOsQnohn+7zVHIC7s6g
         FCirQkMAjiEcetIzTO38OuqU3FDZpJD/EA6xFtBGP2rpU44R1DbYFL/8ZNaqicz/lZ8N
         xsjM2lrqNVuIhVnUgQDvrSJsZa2fxwfkEHTqFpJyPAV3AD8hRnBn0jPY8O6W8lOu06y/
         wRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=101twesbPuze1J2X5qjELU4Po4+yCThzT6Am7N5Pye8=;
        b=fK2qhCQ5687XJbdXROcQfNiQbh8wsDJfGKrdT9eBZVo/LRuvEAf0+JkwH4uDiABVnU
         YD/l9U9wcbbBfZ0MgHPmfTM1jYEadPOmM/gLIUD7z0BMSzUOqVgPozJTtmejl9QoxwLv
         htiTvddOYTuYFGyQPiwxbKL9sJhP5eYNZKD/pUtllVlY5vY2fjjam/tuGmAULPgUS+fB
         EQEkZje5vVg5IPDLwQmz+B4gY502oBh+RNjaP+EVsMD1NTHTeteFWGf7gC1DaQpIMexx
         sbgUg6JVxCigT6t/sqYgrjcHKIZTJYTsyRK08EWdvBwSsmRgO2dJv7r0l0VO/kAspCIV
         JKeQ==
X-Gm-Message-State: AJIora/wRnNqvg0GB9JP7a/awkts2qAsglzBghG8Ye1ZvQ5gWTlsvSBx
        H7pHFuPGX/tVzxmxNbpWqug=
X-Google-Smtp-Source: AGRyM1sSvnoyQNvRjK2a8Qm0nOcDlP48BDcSiSUglqXkGLCfqP6NEX/Epf0W2Qs4KFG+L6n7ZN1HoQ==
X-Received: by 2002:a17:902:da8d:b0:165:7c1b:6803 with SMTP id j13-20020a170902da8d00b001657c1b6803mr15249813plx.157.1655568676007;
        Sat, 18 Jun 2022 09:11:16 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f70200b001622c377c3esm5542437plo.117.2022.06.18.09.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 09:11:14 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] drm/msm: Don't overwrite hw fence in hw_init
Date:   Sat, 18 Jun 2022 09:11:19 -0700
Message-Id: <20220618161120.3451993-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618161120.3451993-1-robdclark@gmail.com>
References: <20220618161120.3451993-1-robdclark@gmail.com>
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

Prior to the last commit, this could result in setting the GPU
written fence value back to an older value, if we had missed
updating completed_fence prior to suspend.  This was mostly
harmless as the GPU would eventually overwrite it again with
the correct value.  But we should just not do this.  Instead
just leave a sanity check that the fence looks plausible (in
case the GPU scribbled on memory).

Reported-by: Steev Klimaszewski <steev@kali.org>
Fixes: 95d1deb02a9c ("drm/msm/gem: Add fenced vma unpin")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++++---
 drivers/gpu/drm/msm/msm_gpu.c           |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f944b69e2a25..efe9840e28fa 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -498,10 +498,15 @@ int adreno_hw_init(struct msm_gpu *gpu)
 
 		ring->cur = ring->start;
 		ring->next = ring->start;
-
-		/* reset completed fence seqno: */
-		ring->memptrs->fence = ring->fctx->completed_fence;
 		ring->memptrs->rptr = 0;
+
+		/* Detect and clean up an impossible fence, ie. if GPU managed
+		 * to scribble something invalid, we don't want that to confuse
+		 * us into mistakingly believing that submits have completed.
+		 */
+		if (fence_before(ring->fctx->last_fence, ring->memptrs->fence)) {
+			ring->memptrs->fence = ring->fctx->last_fence;
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index cedc88cf8083..c8cd9bfa3eeb 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -418,7 +418,7 @@ static void recover_worker(struct kthread_work *work)
 		 * one more to clear the faulting submit
 		 */
 		if (ring == cur_ring)
-			fence++;
+			ring->memptrs->fence = ++fence;
 
 		msm_update_fence(ring->fctx, fence);
 	}
-- 
2.36.1

