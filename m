Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F34586F36
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiHAREs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiHAREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:04:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6904539B8B;
        Mon,  1 Aug 2022 10:04:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id z187so1269514pfb.12;
        Mon, 01 Aug 2022 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mcGjaEjlp9E6N37UMib26cBF56AyQFK+2CInJ6FUTCo=;
        b=kyyjaNp7woKcXT7K+n3fQlDF5rurTZ1cFbBnUazT8LphCUB8Uunsdp08fL8++XY2um
         qb1LS7PccKyWz0vzjzjNpvlrRmU8E0YxTMjoBsqnK93APqh93yZiOi1E31OHdKCN2E5S
         2Bha/UZLOERNo8HHII25RrcN8NLrxzdPTQARsRVBoJCYd45cndns0/Iv/28i+nNkJjc0
         JpbO3XGDCiRSWLri0EY8pCKOQrtrOdxG0f9Mk0TciXDMpON3bZ6TEAdvHjlZ9l3Dfbsw
         D09IZeer2fLxvoLbGWAZZ0i30jGrtTQnx5m2C3Xhila4KMIUpX2NxB2ppfssLU6hWKhZ
         DxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mcGjaEjlp9E6N37UMib26cBF56AyQFK+2CInJ6FUTCo=;
        b=a+ubxdJZM8puuhRXDn6j9oznJZmjpcZbJNZ2RQa4X1PfZdAJFwl0/ofQcour8aktn8
         P6P02yjziU/20mbToYsuUKIDu/4PbR2yPMjXude5i+17YjfMfxfJjJGsW3wU4WNv7xyM
         4Rc0blJFVIrxWrcbt/4H5UmYn2BBgVaLv34n8EkvkfLgL7GUc1/GJjlJlZW8KR0RGC9I
         OWM2oAk4OwTDlbOTlLyv6mP8Ov98Qr6WTSegs9fgBDIy5AX900rAldiJaMrRtiOm3HZH
         NYZR7CR1uK+CsFD85UyIkJYQZA5wPjDz7c+LSfdeaqvsORVp7HGQmiC8CssTyeBKX7uJ
         nDGA==
X-Gm-Message-State: ACgBeo2ncRWR9QH0JvfJP7AGmVLqQDa96XC11CDDs2gK/T07aaq1KUVz
        R+X+kkU47W8xO7mKsX6SBCDynXPSjhs=
X-Google-Smtp-Source: AA6agR7dVYfLrOR+qbczsM1EP90s8etc+W7B7ocadHOyqNO+TOxE1IUloB81XTDszRpVmSoiTlEyiA==
X-Received: by 2002:a05:6a00:996:b0:52d:170f:c7ca with SMTP id u22-20020a056a00099600b0052d170fc7camr11462141pfg.86.1659373476856;
        Mon, 01 Aug 2022 10:04:36 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a9f8800b001f2ef2f9c6fsm9041018pjp.56.2022.08.01.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:04:35 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] drm/msm/prime: Add mmap_info support
Date:   Mon,  1 Aug 2022 10:04:57 -0700
Message-Id: <20220801170459.1593706-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220801170459.1593706-1-robdclark@gmail.com>
References: <20220801170459.1593706-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c       |  1 +
 drivers/gpu/drm/msm/msm_drv.h       |  1 +
 drivers/gpu/drm/msm/msm_gem_prime.c | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 1ca4a92ba96e..4979aa8187ec 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1044,6 +1044,7 @@ static const struct drm_driver msm_driver = {
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_import_sg_table = msm_gem_prime_import_sg_table,
 	.gem_prime_mmap     = msm_gem_prime_mmap,
+	.gem_prime_mmap_info= msm_gem_prime_mmap_info,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init       = msm_debugfs_init,
 #endif
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 7330d7b5de8e..b4ace34ec889 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -271,6 +271,7 @@ void msm_gem_shrinker_init(struct drm_device *dev);
 void msm_gem_shrinker_cleanup(struct drm_device *dev);
 
 int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
+int msm_gem_prime_mmap_info(struct drm_gem_object *obj);
 struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj);
 int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map);
 void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index c1d91863df05..2bacab7a1921 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/dma-buf.h>
+#include <uapi/linux/dma-buf.h>
 
 #include <drm/drm_prime.h>
 
@@ -26,6 +27,16 @@ int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 	return drm_gem_prime_mmap(obj, vma);
 }
 
+int msm_gem_prime_mmap_info(struct drm_gem_object *obj)
+{
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+
+	if (msm_obj->flags & MSM_BO_WC)
+		return DMA_BUF_VM_PROT_WC;
+
+	return DMA_BUF_VM_PROT_CACHED;
+}
+
 struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-- 
2.36.1

