Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C494ECE85
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351125AbiC3Utm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351109AbiC3Uti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:49:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77DD2BB2A;
        Wed, 30 Mar 2022 13:47:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gb19so21918948pjb.1;
        Wed, 30 Mar 2022 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldA9Mhj+0mZCxGshcEo9t/60BKvUL5CRDf8xGkXfdGo=;
        b=lPIT/WDBI7h0jSYCTMxfH2uW+XNKl+dSPF9A6KLgXLvPui73Swrq3Q1Q3AZg/DX0q3
         +ILslReszOaZipmEUbTHMLnsqVfTJ9yEiM8hbPd/AXsL6lLCbhjBxI5szwGsTeuz4PXN
         JGTd7r9ax2P4rnbV+gzD6ftAIBm8grCaA0+C+YWplgI/cEU+729K+Dw2xjeRsRAbs1Mj
         jEUx5VvmE6Y75RXC5s8Yl+rJMHsTz5FZLydGXMPv0N/0XWKtiEHKeM3tOd+nxuDuUrng
         6Guam7SiAaXysw5rNN8ugEYxVvLXAd/7Y4pidtUZj8kdg/fJ6Djy34tH5qFwpyI1LWBK
         y/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldA9Mhj+0mZCxGshcEo9t/60BKvUL5CRDf8xGkXfdGo=;
        b=JNzdlisfStJCbU3R+7upJ4seBx5dfP3y9PsvWYtsd0TSmHchvV7EFfjXk/SQDDqAc9
         9zvNm2w/PaKY6+UhEQ5hkBZ1+S6EX0hX2VkwqX1hjypSxr9+d6jIN1l3Wb05mp6zDjmI
         yGEbYuW3xSpZrSP9wXzlnTCNSa86YboSxru/83nub4HEz6ZzVPBPCf9y4N9KEWVkIWoD
         OQwJrmQy/kglFKQHX4U+cSMX38F3MoW2oCzjOCaVQcjnI0IPl2AM/ArxRH/X0x+EfowO
         kA5aYUVWIhsYxOMHRUeY2fC0CZwko4Ai/5WHQ8eZbNdoc9oJ3M+qel6ql3whcXOHprjD
         ZfCA==
X-Gm-Message-State: AOAM530Pke8Aa5YAJqr6fTFh9W9gClhogxQ4mGvpHDDmoPz/zN/7R5xk
        LWn+bLo46Jff3fFSKKHvIbk=
X-Google-Smtp-Source: ABdhPJysfQC0ENwfzI6jQB6u/35Gy9KhZqGh43AyIEW8pA1f1g9B+MQW/gPexaDjtmrxvOJnE1wXDA==
X-Received: by 2002:a17:902:ab59:b0:156:17a5:5de7 with SMTP id ij25-20020a170902ab5900b0015617a55de7mr1592725plb.6.1648673272187;
        Wed, 30 Mar 2022 13:47:52 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090a150200b001c9f1a7aafesm3448919pja.29.2022.03.30.13.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:47:51 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 01/10] drm/msm/gem: Move prototypes
Date:   Wed, 30 Mar 2022 13:47:46 -0700
Message-Id: <20220330204804.660819-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330204804.660819-1-robdclark@gmail.com>
References: <20220330204804.660819-1-robdclark@gmail.com>
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

These belong more cleanly in the gem header.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_drv.h | 23 -----------------------
 drivers/gpu/drm/msm/msm_gem.h | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 9f68aa685ed7..daf60d219463 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -250,29 +250,6 @@ void msm_atomic_state_free(struct drm_atomic_state *state);
 int msm_crtc_enable_vblank(struct drm_crtc *crtc);
 void msm_crtc_disable_vblank(struct drm_crtc *crtc);
 
-int msm_gem_init_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int npages,
-		u64 range_start, u64 range_end);
-void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma);
-void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma);
-int msm_gem_map_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma, int prot,
-		struct sg_table *sgt, int npages);
-void msm_gem_close_vma(struct msm_gem_address_space *aspace,
-		struct msm_gem_vma *vma);
-
-
-struct msm_gem_address_space *
-msm_gem_address_space_get(struct msm_gem_address_space *aspace);
-
-void msm_gem_address_space_put(struct msm_gem_address_space *aspace);
-
-struct msm_gem_address_space *
-msm_gem_address_space_create(struct msm_mmu *mmu, const char *name,
-		u64 va_start, u64 size);
-
 int msm_register_mmu(struct drm_device *dev, struct msm_mmu *mmu);
 void msm_unregister_mmu(struct drm_device *dev, struct msm_mmu *mmu);
 
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 58e11c282928..947ff7d9b471 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -40,6 +40,15 @@ struct msm_gem_address_space {
 	int faults;
 };
 
+struct msm_gem_address_space *
+msm_gem_address_space_get(struct msm_gem_address_space *aspace);
+
+void msm_gem_address_space_put(struct msm_gem_address_space *aspace);
+
+struct msm_gem_address_space *
+msm_gem_address_space_create(struct msm_mmu *mmu, const char *name,
+		u64 va_start, u64 size);
+
 struct msm_gem_vma {
 	struct drm_mm_node node;
 	uint64_t iova;
@@ -49,6 +58,19 @@ struct msm_gem_vma {
 	int inuse;
 };
 
+int msm_gem_init_vma(struct msm_gem_address_space *aspace,
+		struct msm_gem_vma *vma, int npages,
+		u64 range_start, u64 range_end);
+void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
+		struct msm_gem_vma *vma);
+void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
+		struct msm_gem_vma *vma);
+int msm_gem_map_vma(struct msm_gem_address_space *aspace,
+		struct msm_gem_vma *vma, int prot,
+		struct sg_table *sgt, int npages);
+void msm_gem_close_vma(struct msm_gem_address_space *aspace,
+		struct msm_gem_vma *vma);
+
 struct msm_gem_object {
 	struct drm_gem_object base;
 
-- 
2.35.1

