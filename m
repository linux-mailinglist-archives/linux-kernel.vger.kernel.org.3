Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30804FC705
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350257AbiDKWAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350248AbiDKWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:00:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A261411C02;
        Mon, 11 Apr 2022 14:58:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso676042pjf.5;
        Mon, 11 Apr 2022 14:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TY916nBD4Ut+Nhr5Owf/4x969nS99vGSEISx8LykC4=;
        b=kyNzCdHMJPcd4hJH7AQc8Gpz/MclC6AHAJiehCgiLNxFCGInpWCNyvJKKgbo0VhBnx
         0FGig+BWvOL8Qc0awyjk4qxqrN5estwjOH52K5TK03SHa6GLF0HqKqtLu3GDr46JCnJj
         uqX6TSwOEAihCeAa/botKWD1Wxur5GMb1eo45AFIhE4TMblBF36IDamY2jkxhm0gotrd
         CND4IY0T8bMa/Jp7WUhtRfynXUb+uXRlPG3kQRtkFtG2gnSF5GgT60+IvryXDfllqu52
         MieIK71wc9e2qxO/VOtYVn18jpuh8ACsALXEqtLoQpk9aVzTrdb0UJN5sS7iDIX3SwGH
         sY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TY916nBD4Ut+Nhr5Owf/4x969nS99vGSEISx8LykC4=;
        b=SKiL0ypBB2J0n/yzwKIj38OHR6/3+FvQz13PCjgJ4EurglXInEXLnaBCiXETOuGbL/
         ww+v9UjXmwsr7FpqDsE268QUXgr6gKQCgyLzoFiFEP/822O63EBZERN6AM8BLWKZ6o6s
         hggFcqSta5zzfTrBnSkPx8F+Nm/Np+Q0yr/qHX/5JvwMEJLp32o1p7TUO3cSXl+K+BiO
         Ko6ve/dWVskcVoqkkFDYv8ayRql/jxY4O6wLrhgBb7y0xaJvWqfEmyP+xDO36NXHGuOu
         lowEDKT8UDGdYYCKnbmwtpPzkjFDOcWkGbpcq68J4HuSpYR6uRfwZQnYd4wp/gwXg3sT
         pF/Q==
X-Gm-Message-State: AOAM5331fxkAN9aBNn54OK240MXUbA8J/liZEXwmRHZegfASTRKhFK87
        UUKGstF/+T2BDgc4QhT0rrc=
X-Google-Smtp-Source: ABdhPJxrOIZtbvK9nXOtwQ0+1ehpWH4ePlZ075+QwJVaP0bMMgI3AWmB3e2Dpu8t6E4F7cqQK1Q3+Q==
X-Received: by 2002:a17:90b:4b01:b0:1cb:a81a:dc4c with SMTP id lx1-20020a17090b4b0100b001cba81adc4cmr1350348pjb.193.1649714292224;
        Mon, 11 Apr 2022 14:58:12 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id kx3-20020a17090b228300b001cb7ed57660sm419261pjb.52.2022.04.11.14.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:58:11 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 01/10] drm/msm/gem: Move prototypes
Date:   Mon, 11 Apr 2022 14:58:30 -0700
Message-Id: <20220411215849.297838-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411215849.297838-1-robdclark@gmail.com>
References: <20220411215849.297838-1-robdclark@gmail.com>
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
index d661debb50f1..000fe649a0ab 100644
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

