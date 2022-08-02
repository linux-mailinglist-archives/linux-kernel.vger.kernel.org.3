Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC4587F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiHBPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbiHBPwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:52:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4416932446;
        Tue,  2 Aug 2022 08:51:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so12694321pgs.3;
        Tue, 02 Aug 2022 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tv9XZJtMf2UZGPK9r5daZO8lAjNs4ugv43Of9czCQIM=;
        b=ewcgdHYUnR0pjbQr7lLrbohv0CIdWnfTaVa/OdLqKa56REj1mZVDD3loCWUUXysHJb
         r1nv6LvBlTqUGW5Yn7MekuRqEHSPnRvgfxi8RbvnxLAPMdUnKJd3gAzv7ZK0ctBMmKFK
         Cx5FfFd7GebaOk14M/0AQVBAEON772Rfp5BU7zVsirwUcKBaErJ3PfTATLVq4G/Bw+B/
         vKxsWxn33KGmbgUmEWsOn1uNznXGWHDoB+nDhkdNc08TKQ/kKKSY/K7/EoMlTGURdLwc
         r5hqBVOcuKvFTYPqyq2XRu1L0cPf/efn+WxvfX6OEEhuXH/KXeoqWzwOqXhYXUDDISLP
         8bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tv9XZJtMf2UZGPK9r5daZO8lAjNs4ugv43Of9czCQIM=;
        b=68dfkfG8SJFu1kDPS5mMp5mH00Dupkd5w9UkwsbbM9/7zL4X0BAT2d3Nqz8kfQfBSS
         TNxOV1uAhfoehp+oola1czTcPbi+odBcvUdNeCYR4GA898RF+hbWnQXGIGkUuL/CPKMh
         2NcmLWxQENsPQZh2ITNTFlpgrKRlQW1jx00e37bxDZoXogLVvo9VNv6b2vnm0bUW3CNp
         CHJh667quPOvAuMZz1fbB8tlUS5bAJLcId8NMu7h7RxNXZnkm0GP4iUE2vRzILOSjvYe
         vxlKPUMu5+ddwObdoDL825vZeG+1PiAsm4ftZYj29L7+H5ABFavOF9ewcDWWhDScFqEA
         b1ZQ==
X-Gm-Message-State: ACgBeo2E1xbxP5MDZ9O/bykAd3zlFhXHVBg0uIlLYfHgnzFieLxCWKtS
        ELd9ojVCrY+JXN/Uvemt+Cw=
X-Google-Smtp-Source: AA6agR7fjw8jn0jQNN1u5zHtoNHt/wIMLL6YxqIYFMtVGwrrRbd03oug9Bjkf/Ril+hPJDZo6qr8WQ==
X-Received: by 2002:aa7:82c2:0:b0:52d:2317:8938 with SMTP id f2-20020aa782c2000000b0052d23178938mr15195307pfn.75.1659455516225;
        Tue, 02 Aug 2022 08:51:56 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78bd4000000b0052d5e93fcb7sm5315612pfd.191.2022.08.02.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:55 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 15/15] drm/msm/gem: Convert to lockdep assert
Date:   Tue,  2 Aug 2022 08:51:48 -0700
Message-Id: <20220802155152.1727594-16-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220802155152.1727594-1-robdclark@gmail.com>
References: <20220802155152.1727594-1-robdclark@gmail.com>
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
 drivers/gpu/drm/msm/msm_gem.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 3c6add51d13b..c4844cf3a585 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -197,8 +197,8 @@ msm_gem_unlock(struct drm_gem_object *obj)
 	dma_resv_unlock(obj->resv);
 }
 
-static inline bool
-msm_gem_is_locked(struct drm_gem_object *obj)
+static inline void
+msm_gem_assert_locked(struct drm_gem_object *obj)
 {
 	/*
 	 * Destroying the object is a special case.. msm_gem_free_object()
@@ -212,13 +212,10 @@ msm_gem_is_locked(struct drm_gem_object *obj)
 	 * Unfortunately lockdep is not aware of this detail.  So when the
 	 * refcount drops to zero, we pretend it is already locked.
 	 */
-	return dma_resv_is_locked(obj->resv) || (kref_read(&obj->refcount) == 0);
-}
-
-static inline void
-msm_gem_assert_locked(struct drm_gem_object *obj)
-{
-	GEM_WARN_ON(!msm_gem_is_locked(obj));
+	lockdep_assert_once(
+		(kref_read(&obj->refcount) == 0) ||
+		(lockdep_is_held(&obj->resv->lock.base) != LOCK_STATE_NOT_HELD)
+	);
 }
 
 /* imported/exported objects are not purgeable: */
-- 
2.36.1

