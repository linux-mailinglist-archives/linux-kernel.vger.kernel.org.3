Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B559B5FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiHUSTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiHUSTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:19:09 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85940205F3;
        Sun, 21 Aug 2022 11:19:08 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r22so7585086pgm.5;
        Sun, 21 Aug 2022 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rJPJHp4WUC+k2ZugmXMrEl/gry6ReB2YgyAezAf1/ks=;
        b=igd3L5C0F/igLnISA3+VP7PELE0Tt3GXUb3snhvjwtOdEzx9eRDgu/de4iZ4v8ZByJ
         9p8GsGJC4YZ5AIL7Baq8coyhYhSJlmsz8t61OWkgsoxBiRA8UjJdLUtJv4e6Wd82LuYq
         YPnSx1vQV1elOuCFKu6lsmXcy3XvF8MvBudyOhK2cf/4X3p7aBLcbyFVpmtyxOsyUNfv
         jsL1sPaOcZ9p3pub/xX3MxRTnbjyQzn6Q+NgQbFeH5HB4NBRdr2kp9DMEtkJiBh0HnBm
         CJYGRjFHNaxi6TooTGYKT8+O5Ime+KG9p/MJMa/Gzco2Vc2UKU4rcnUTtcNJsndoT2K3
         XALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rJPJHp4WUC+k2ZugmXMrEl/gry6ReB2YgyAezAf1/ks=;
        b=0BaHyIg9t6ypmF/78fvxgM6vegHs1AZk9ebEAmqGZANUluv8zp21x1s1cwStEpe2AH
         i8mH+6wsU6topHt8/zMuLZvbZmeGNYidSJ5UIKiSACoSdHIJUS1zP0dwP+SY5mOjFsqj
         dftIh/2/OgwJxe8VkNGOnI0XGmUJOJS8MQl9SGqoFDRMesOUYABQrrX3BIw3c45RB+w6
         cMDvpVEfVtBzbiY1fl8qbMAthP/Mhz+7L1c7GR53yrf+8oUwzNozu9zy2wuXTdYLzcT7
         Pfs5iW4nBFWU2Vzwmnw1cxVz61gYg+3BotY3kj4ln7fLzUfEb8+/WtU2iDMHulozanRW
         cNIg==
X-Gm-Message-State: ACgBeo3WoJD7potKdXGLUZxkW7wAe+dcgIvIQhs9z3bV0sGtoZBRu3C/
        fBdXVUJJNa2lDh5mh2pxGMs=
X-Google-Smtp-Source: AA6agR7grPVWv0p0d5feTVXYX0q0iIO3i4jluQbDa7BvmI7ly44pt5otEGUi/E8EyZ4IvklYGtFK9A==
X-Received: by 2002:a05:6a00:27a0:b0:52f:8947:4cc5 with SMTP id bd32-20020a056a0027a000b0052f89474cc5mr17505693pfb.16.1661105947769;
        Sun, 21 Aug 2022 11:19:07 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id nt22-20020a17090b249600b001f55dda84b3sm6602422pjb.22.2022.08.21.11.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:19:06 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] drm/msm: Skip tlbinv on unmap from non-current pgtables
Date:   Sun, 21 Aug 2022 11:19:06 -0700
Message-Id: <20220821181917.1188021-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220821181917.1188021-1-robdclark@gmail.com>
References: <20220821181917.1188021-1-robdclark@gmail.com>
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

We can rely on the tlbinv done by CP_SMMU_TABLE_UPDATE in this case.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  6 ++++++
 drivers/gpu/drm/msm/msm_iommu.c       | 29 +++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index c8ad8aeca777..1ba0ed629549 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1180,6 +1180,12 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Always come up on rb 0 */
 	a6xx_gpu->cur_ring = gpu->rb[0];
 
+	/*
+	 * Note, we cannot assume anything about the state of the SMMU when
+	 * coming back from power collapse, so force a CP_SMMU_TABLE_UPDATE
+	 * on the first submit.  Also, msm_iommu_pagetable_unmap() relies on
+	 * this behavior.
+	 */
 	gpu->cur_ctx_seqno = 0;
 
 	/* Enable the SQE_to start the CP engine */
diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 94c8c09980d1..218074a58081 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -45,8 +45,37 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
 		size -= 4096;
 	}
 
+	/*
+	 * A CP_SMMU_TABLE_UPDATE is always sent for the first
+	 * submit after resume, and that does a TLB invalidate.
+	 * So we can skip that if the device is not currently
+	 * powered.
+	 */
+	if (!pm_runtime_get_if_in_use(pagetable->parent->dev))
+		goto out;
+
+	/*
+	 * If we are not the current pgtables, we can rely on the
+	 * TLB invalidate done by CP_SMMU_TABLE_UPDATE.
+	 *
+	 * We'll always be racing with the GPU updating ttbr0,
+	 * but there are only two cases:
+	 *
+	 *  + either we are not the the current pgtables and there
+	 *    will be a tlbinv done by the GPU before we are again
+	 *
+	 *  + or we are.. there might have already been a tblinv
+	 *    if we raced with the GPU, but we have to assume the
+	 *    worse and do the tlbinv
+	 */
+	if (adreno_smmu->get_ttbr0(adreno_smmu->cookie) != pagetable->ttbr)
+		goto out_put;
+
 	adreno_smmu->tlb_inv_by_id(adreno_smmu->cookie, pagetable->asid);
 
+out_put:
+	pm_runtime_put(pagetable->parent->dev);
+out:
 	return (unmapped == size) ? 0 : -EINVAL;
 }
 
-- 
2.37.2

