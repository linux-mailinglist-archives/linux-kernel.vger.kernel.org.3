Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF5568940
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiGFNS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiGFNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:18:56 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC85F7B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:18:55 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id rpJr2700E4C55Sk06pJr8g; Wed, 06 Jul 2022 15:18:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o94va-002LB9-R2; Wed, 06 Jul 2022 15:18:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o94va-009esk-7c; Wed, 06 Jul 2022 15:18:50 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] drm/msm/adreno: Do not propagate void return values
Date:   Wed,  6 Jul 2022 15:18:48 +0200
Message-Id: <0083bc7e23753c19902580b902582ae499b44dbf.1657113388.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With sparse ("make C=2"), lots of

  error: return expression in void function

messages are seen.

Fix this by removing the return statements to propagate void return
values.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 4 ++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9f76f5b157598c27..ccf7b29473f0ea4e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -504,7 +504,7 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 
 static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
 {
-	return msm_writel(value, ptr + (offset << 2));
+	msm_writel(value, ptr + (offset << 2));
 }
 
 static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 84bd516f01e895b2..e034935b3986f9f2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -98,7 +98,7 @@ static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
 
 static inline void gmu_write(struct a6xx_gmu *gmu, u32 offset, u32 value)
 {
-	return msm_writel(value, gmu->mmio + (offset << 2));
+	msm_writel(value, gmu->mmio + (offset << 2));
 }
 
 static inline void
@@ -138,7 +138,7 @@ static inline u32 gmu_read_rscc(struct a6xx_gmu *gmu, u32 offset)
 
 static inline void gmu_write_rscc(struct a6xx_gmu *gmu, u32 offset, u32 value)
 {
-	return msm_writel(value, gmu->rscc + (offset << 2));
+	msm_writel(value, gmu->rscc + (offset << 2));
 }
 
 #define gmu_poll_timeout_rscc(gmu, addr, val, cond, interval, timeout) \
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 42ed9a3c490551a2..2613219a778717a2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1446,7 +1446,7 @@ static void a6xx_llc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 mask, u32 or)
 
 static void a6xx_llc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 value)
 {
-	return msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));
+	msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));
 }
 
 static void a6xx_llc_deactivate(struct a6xx_gpu *a6xx_gpu)
-- 
2.25.1

