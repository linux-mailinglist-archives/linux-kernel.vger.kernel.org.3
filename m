Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B923554CC11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbiFOPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiFOPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:01:07 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCADC3818A;
        Wed, 15 Jun 2022 08:01:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y196so11686541pfb.6;
        Wed, 15 Jun 2022 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oZ4C/2pH/xtflOzIMAJ169l+TNeby43rC2FOPbSEEZs=;
        b=nojPL5UaGkmux0gCu7JOJqxhwy1lqtFptyfnXTMFceVdPL2Rxobub2I3oVJ78AtmFb
         +bxryzTBDxDkecuOV+d5DIJNeSXPxGjnCIy8peSr6Zzju4bWjrlmC14dbkg0RJgzM49Y
         cKr976plCRJjpRBAYYPnhi+X03BBEYPdI+xzPzHMfZyMrWq4HR0XRTo/TLXX6SHVJwy7
         Lk82MdXUTdp52hzlrVgeQZKZuyRad/oYjLydlLYnj+yuxvqDYv7TqHFdjPjnniOcrsc0
         arz2nwYUYoEsieX7Drp5TKN5rrm9iEPvY6dpl+51IfD6oiEyNc/28QbRwGH4H783PdDX
         qeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZ4C/2pH/xtflOzIMAJ169l+TNeby43rC2FOPbSEEZs=;
        b=wAF4uweRh09+YXtkU5nTWRH3GCEMCdLdwALKtBwnmgenkrrzkas5C7bhahQW0Diz2Y
         F8EHNY43OXy+b5joUV9C/vMMduoAKShTEx1poCR34w1Fr8RD2IxiHNX1UAWWMgm/8s8v
         0bnhY9PNGpBRSKazr068xbocp7R2haKwXfKq3osozxzm9kXpI76iDivpSIzhrtSLG7fc
         0tuohhvBJ3MiKE5HupIs6cC+CXCdpnIgFBkrldMGtfhJ21iSlgcbf13biinpNGnzlYym
         jZb+CQqOkJEKI5p/fWPaAk4pmINlheri8YO5XNtK2T+SFi5zv2NAb9Vn0dZdFbRiGW2P
         GjQQ==
X-Gm-Message-State: AJIora9YfX/Kax5CBskW3qnfWfOVc77ym7OhXvHGjlUzGqV4MF5DwSZO
        O+1C79o4O3+SGcB5e4ItZjM=
X-Google-Smtp-Source: AGRyM1uVmXm2LijmpDnabCBZB64cAjzssYoJ5LFqFHbcXkw1POVaPkDuu3znkGzi5uOvf/VCeg9V5Q==
X-Received: by 2002:a63:ec14:0:b0:401:9e3e:7d23 with SMTP id j20-20020a63ec14000000b004019e3e7d23mr190083pgh.235.1655305266249;
        Wed, 15 Jun 2022 08:01:06 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id d4-20020a62f804000000b0050dc76281d9sm10341671pfh.179.2022.06.15.08.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:01:02 -0700 (PDT)
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
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm: Don't overwrite hw fence in hw_init
Date:   Wed, 15 Jun 2022 08:01:07 -0700
Message-Id: <20220615150107.2969593-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615150107.2969593-1-robdclark@gmail.com>
References: <20220615150107.2969593-1-robdclark@gmail.com>
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
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++++---
 drivers/gpu/drm/msm/msm_gpu.c           |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index e1aef4875e2f..dd044d557c7c 100644
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
index b61078f0cd0f..8c00f9187c03 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -430,7 +430,7 @@ static void recover_worker(struct kthread_work *work)
 		 * one more to clear the faulting submit
 		 */
 		if (ring == cur_ring)
-			fence++;
+			ring->memptrs->fence = ++fence;
 
 		msm_update_fence(ring->fctx, fence);
 	}
-- 
2.36.1

