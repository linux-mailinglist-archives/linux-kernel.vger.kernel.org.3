Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F389F4CC689
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiCCTuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiCCTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:50:17 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD56D1A41D4;
        Thu,  3 Mar 2022 11:49:29 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o23so5550939pgk.13;
        Thu, 03 Mar 2022 11:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmkJTY4UoVeWJUK/ZSD0iRFmOgOS8XNBDluJphWOGhI=;
        b=Va808++pxqpNi95Q7zLOC4N2eUYH6cpb2Mk/xWme4nq2VFd0yfNgou7qpo9HGAIh1j
         40lemyZ7v0VsivcdJQ6t1fZQ4t8ohTjwPYAcdzb3KK0cI8q9muDVK1lqV7GJPqypi5A6
         QfuwluGKFpllbebaPvxtX3Xb8jmO0apK5I5SKYgQL4WjGCO7rCxqbYOn6peUcVrqqbgr
         ADXw842UdMhGqvFaj1y2LA38RmiN+e0vHt5DSUcnbIa/6FVJyNfJ0V6vF85OgicVqZLp
         beYKE7I2F9DT1+X2eZ5vRr9wyoIETXvAZKM98K0vr+Yz5X0goqvpJOBCppfn5+Jb1mxI
         TaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmkJTY4UoVeWJUK/ZSD0iRFmOgOS8XNBDluJphWOGhI=;
        b=lq0b8MTfYMEW0NgsW4llhZaxd/rr5FkbfQ1LCWRyhLTXqNqUqCHDeF+aEf/sPIi6fN
         VAY6YLrT/IrFW8zaIt/s4Co+wvjVN/1cMm+7k4ymjDBt6Ea4i92N8Eto6m6ckeyE/Uko
         OvJDnlwfm0gNlwjYaEaeMTl6LB4MmfVjVt4wOJFB7q3eW+VoMmE5iHawD03wTlZJaqUW
         kYCTbMxny39wpuoEZHDvxRJYRNCOpfi1kshX2vqA0tsLbyO5eftvYdT8gLAqhLcEXDL4
         kzU6JmZZzwg3gGfInkn0g1U5zsprMQRJW2pZKf1bsBB1bTxTzsYtoYT70ejalNW7vmCS
         zBgA==
X-Gm-Message-State: AOAM531eP0tYLkuoL60sOcNaXZz1HiE28RDI2xkXirPedOj/4PWkzDfW
        w7bB9OjVCCCb7v0yiVg9GyY=
X-Google-Smtp-Source: ABdhPJzzhu782jKEl9lNoZKQq0BWCXwyE1OsMvvHOFPI8fezzk2jK0tRGvsvCFtEMQq0CZ3xPMNfwg==
X-Received: by 2002:a05:6a00:23c6:b0:4cf:1e1e:ff4f with SMTP id g6-20020a056a0023c600b004cf1e1eff4fmr39340020pfc.80.1646336969077;
        Thu, 03 Mar 2022 11:49:29 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id y74-20020a62644d000000b004f129e94f40sm3295024pfb.131.2022.03.03.11.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 11:49:28 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] drm/msm/a6xx: Zap counters across context switch
Date:   Thu,  3 Mar 2022 11:46:48 -0800
Message-Id: <20220303194758.710358-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303194758.710358-1-robdclark@gmail.com>
References: <20220303194758.710358-1-robdclark@gmail.com>
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

Any app controlled perfcntr collection (GL_AMD_performance_monitor, etc)
does not require counters to maintain state across context switches.  So
clear them if systemwide profiling is not active.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 237c2e7a7baa..98b3282a117b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -101,6 +101,7 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		struct msm_ringbuffer *ring, struct msm_file_private *ctx)
 {
+	bool sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 0;
 	phys_addr_t ttbr;
 	u32 asid;
 	u64 memptr = rbmemptr(ring, ttbr0);
@@ -111,6 +112,15 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	if (msm_iommu_pagetable_params(ctx->aspace->mmu, &ttbr, &asid))
 		return;
 
+	if (!sysprof) {
+		/* Turn off protected mode to write to special registers */
+		OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
+		OUT_RING(ring, 0);
+
+		OUT_PKT4(ring, REG_A6XX_RBBM_PERFCTR_SRAM_INIT_CMD, 1);
+		OUT_RING(ring, 1);
+	}
+
 	/* Execute the table update */
 	OUT_PKT7(ring, CP_SMMU_TABLE_UPDATE, 4);
 	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_0_TTBR0_LO(lower_32_bits(ttbr)));
@@ -137,6 +147,25 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 
 	OUT_PKT7(ring, CP_EVENT_WRITE, 1);
 	OUT_RING(ring, 0x31);
+
+	if (!sysprof) {
+		/*
+		 * Wait for SRAM clear after the pgtable update, so the
+		 * two can happen in parallel:
+		 */
+		OUT_PKT7(ring, CP_WAIT_REG_MEM, 6);
+		OUT_RING(ring, CP_WAIT_REG_MEM_0_FUNCTION(WRITE_EQ));
+		OUT_RING(ring, CP_WAIT_REG_MEM_1_POLL_ADDR_LO(
+				REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS));
+		OUT_RING(ring, CP_WAIT_REG_MEM_2_POLL_ADDR_HI(0));
+		OUT_RING(ring, CP_WAIT_REG_MEM_3_REF(0x1));
+		OUT_RING(ring, CP_WAIT_REG_MEM_4_MASK(0x1));
+		OUT_RING(ring, CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0));
+
+		/* Re-enable protected mode: */
+		OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
+		OUT_RING(ring, 1);
+	}
 }
 
 static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
-- 
2.35.1

