Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1384CCB15
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 01:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiCDBAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbiCDA7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 19:59:40 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38E61405F3;
        Thu,  3 Mar 2022 16:58:53 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e13so6351786plh.3;
        Thu, 03 Mar 2022 16:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4j6M/QS1mgW5MTxzHwE3g8Q8Q6w+oMyq63tCyKGxiU=;
        b=DWC4DkI9wrUscASe9OTO/VybE2truTUQRwJVLU7Dr7Lk3zIGDp1ucqsHmEnuMtKhWG
         k9jIOF+x7ZeehiBWYJe+et8X/l9bv2+vk/rYAw2YokDjRLUbPm9wTMwEYhz1glnVwL8u
         eHLe41yXVJK6osaYY8sWxlvRDG+h6boLQwa0wIqmAS7sbiY4qR6XNEreJHO+FzbExMXm
         ym9UIYoS8Hj6SIy3RrXBTxF0Lpd/Oqcs2wZy5ytdjzGwrojFuSgClxMsQieXTc+hnDO6
         eHF4vUrqnwRZs8rDqTPUzE4+j9/6pf6jn6ahS5i8U78hccAvU6OnUOB+VGVQIUhG72DM
         l8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4j6M/QS1mgW5MTxzHwE3g8Q8Q6w+oMyq63tCyKGxiU=;
        b=ngCTGKhFX+fXsXhpV6p96Wh+6Hq9XdKj6HvC83HMjAcJpE9yiidYXlr6h7UyFvcgJV
         5+9N/CMOxgvL6gJoNAyujIbHH/gv8f0NAqKbsNqDGRtxA6U6uN5ms2uF1nXJ2qsucNom
         aCTaTKhC9ore5FlB8LtSZ+FoA01A6ZMwt0VO2yZYEMt/ZJLx9Uz376rNoWyYjxqFizKd
         oUKGHbhXmob/+60RYeRNdKatIQ5u3nMPXBmmSueqgkaEKX3P8FxZhZFXvJHxxr7jg45W
         6WoMgVzsDoUzeyXKlztEOClShvTj92WNnIBaRwyU7Km/0SnL70VhRGRe1DJd0YTWS+3y
         WlnA==
X-Gm-Message-State: AOAM530ihf0QhJgt5Qot9rTwjndTS66n9/t0bO0ElXdJbnp6sVafaH0+
        Cf/J1O76heduf9o7JbqKif/HWwcImso=
X-Google-Smtp-Source: ABdhPJzA5bZTW91ErXFqEOX9J0gm0y6jMQksaO9v3kaCeVmebqi6yV6gwM7M+14FmNYid9bPqdN7eQ==
X-Received: by 2002:a17:902:cec2:b0:151:b337:a699 with SMTP id d2-20020a170902cec200b00151b337a699mr3710872plg.59.1646355533288;
        Thu, 03 Mar 2022 16:58:53 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id ob13-20020a17090b390d00b001becfd7c6f3sm3246386pjb.27.2022.03.03.16.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:58:52 -0800 (PST)
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
Date:   Thu,  3 Mar 2022 16:52:17 -0800
Message-Id: <20220304005317.776110-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304005317.776110-1-robdclark@gmail.com>
References: <20220304005317.776110-1-robdclark@gmail.com>
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
index 237c2e7a7baa..02b47977b5c3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -101,6 +101,7 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		struct msm_ringbuffer *ring, struct msm_file_private *ctx)
 {
+	bool sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 1;
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

