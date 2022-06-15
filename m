Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38A354CC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbiFOPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiFOPA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:00:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747D137BD5;
        Wed, 15 Jun 2022 08:00:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z14so6730434pjb.4;
        Wed, 15 Jun 2022 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fftyusq14pygoE98VFvLknKqjgDHop8Kgx2bJEg9loM=;
        b=Dd3Vk1PDo0eKWLfXky6AqmbKiDsQNoKnePr1CSH3382YVX+2aZufcgim47ivxwg5DE
         kDiDg+sLDTkhcTEfkvirUrkkwoJ+ppkuaGzEBuat0jMexCMf+Jx+iDGyqqRz7gu1/JVl
         TartlMlP+t2GHtOzP4IMWy7ny70JiJ+z+iUe4YZ9GSyjIqLVo3UEWUfZe83dMJ4AmYyX
         k5TVD4eemocFf9bWC+ljn8+B8cjvobhfXBee9TTDIZSCXc6jikLOjKbu6Q4R4gH53UtV
         fet3ZKzxp7koEjzXrQqmm1lGxJLAGUvF24OY6Ov89HA1mF/zLkYITI7e5H8yq1BOqU4a
         OQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fftyusq14pygoE98VFvLknKqjgDHop8Kgx2bJEg9loM=;
        b=AS73zZCNmyq7J++7X6IcMfUkXetKaYFFyqcL2SeGR13CrIDv69hZ+EpcOdeEh6iaiR
         zdnGC+w7ty3JlMq5WLOidsPxgAjxd9U4J6BdfK2jjR1ZRllFT8z08YMo2W0ajuV2u7Nh
         V69lM0NwfX77K7XoD0GR2P+JZMwbezV27+ldvBn/KwveVZM4w0G4D2IQ7OjMjfIZysWH
         nPKI9ssCxfF0EdNluctFw8l34EWgyZW/kYj3+G618IzQJfG2yFE9+s6G1H8uXKcP5yXW
         fo0m8FzOnILL0DBykHsu2/1ZVJVSbfWCg7h7uZXAjqCnqbYx80vRbGhgK2eNsGJPgdWc
         avzQ==
X-Gm-Message-State: AJIora+Wac/sadfSImVEswk9G/ex5uFy0cIBHoJX92HfFxh2Nd94rKq8
        9k5fvspGroml8U2MumxzUJY=
X-Google-Smtp-Source: AGRyM1t6iYGPtiNKJylInJeuhNBnTKe4fKmcXmlacbZLF5hj1JNSIvXkPggEUHpPxBOzLLO8qeRYTA==
X-Received: by 2002:a17:90a:b284:b0:1e3:826b:d11d with SMTP id c4-20020a17090ab28400b001e3826bd11dmr10881434pjr.79.1655305257874;
        Wed, 15 Jun 2022 08:00:57 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709027e8600b0015e8e7db067sm9485101pla.4.2022.06.15.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:00:56 -0700 (PDT)
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
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm: Drop update_fences()
Date:   Wed, 15 Jun 2022 08:01:06 -0700
Message-Id: <20220615150107.2969593-1-robdclark@gmail.com>
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

I noticed while looking at some traces, that we could miss calls to
msm_update_fence(), as the irq could have raced with retire_submits()
which could have already popped the last submit on a ring out of the
queue of in-flight submits.  But walking the list of submits in the
irq handler isn't really needed, as dma_fence_is_signaled() will dtrt.
So lets just drop it entirely.

Reported-by: Steev Klimaszewski <steev@kali.org>
Fixes: 95d1deb02a9c ("drm/msm/gem: Add fenced vma unpin")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index e59a757578df..b61078f0cd0f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -176,24 +176,6 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
 	return ret;
 }
 
-static void update_fences(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
-		uint32_t fence)
-{
-	struct msm_gem_submit *submit;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ring->submit_lock, flags);
-	list_for_each_entry(submit, &ring->submits, node) {
-		if (fence_after(submit->seqno, fence))
-			break;
-
-		msm_update_fence(submit->ring->fctx,
-			submit->hw_fence->seqno);
-		dma_fence_signal(submit->hw_fence);
-	}
-	spin_unlock_irqrestore(&ring->submit_lock, flags);
-}
-
 #ifdef CONFIG_DEV_COREDUMP
 static ssize_t msm_gpu_devcoredump_read(char *buffer, loff_t offset,
 		size_t count, void *data, size_t datalen)
@@ -450,7 +432,7 @@ static void recover_worker(struct kthread_work *work)
 		if (ring == cur_ring)
 			fence++;
 
-		update_fences(gpu, ring, fence);
+		msm_update_fence(ring->fctx, fence);
 	}
 
 	if (msm_gpu_active(gpu)) {
@@ -753,7 +735,7 @@ void msm_gpu_retire(struct msm_gpu *gpu)
 	int i;
 
 	for (i = 0; i < gpu->nr_rings; i++)
-		update_fences(gpu, gpu->rb[i], gpu->rb[i]->memptrs->fence);
+		msm_update_fence(gpu->rb[i]->fctx, gpu->rb[i]->memptrs->fence);
 
 	kthread_queue_work(gpu->worker, &gpu->retire_work);
 	update_sw_cntrs(gpu);
-- 
2.36.1

