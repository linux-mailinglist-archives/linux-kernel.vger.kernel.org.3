Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88B0581929
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbiGZRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiGZRvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:51:20 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0786C32D96;
        Tue, 26 Jul 2022 10:50:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bf13so13735661pgb.11;
        Tue, 26 Jul 2022 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tv9XZJtMf2UZGPK9r5daZO8lAjNs4ugv43Of9czCQIM=;
        b=n6N05FO3A/857gPBbDiuof2GwBfUn9kG0puB7kE8lFbQKIRgt5AHPZzAAaOh3dGaw+
         I0qC2WcECj1kdPZjXnWb2ynEpT0VEDMaY6F4290Haflq9ssHlBMTUon11dWEoP73dzhf
         QATtcmH9W6axNlapK/asy95XPOrDO5j6fV3PCqKz1+u+uvnOrCaQ36QvvRXKMZYLcL43
         fxhdUO4uzY6xfRvqsDmJ3lxyZnCuMuY4gEPFRh+lNZfpo6IBoOhjVOlWDypeT/R1l8cv
         jpP2SBPbKIuFLlqXbE7uv92AFhfT34u/Sku5aJTW7yANKYxCyAwXSjbjTzttH8HfRATU
         7XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tv9XZJtMf2UZGPK9r5daZO8lAjNs4ugv43Of9czCQIM=;
        b=ssA/VGIpvllEGPV7qMEIR8IofMX4tp/nv48XeEgrl/BTWfH/gVcfiFbXk8obo98bRp
         vdEjirfoL6owVY401eo9PvLemHVgZFbcmVmDpSxkzGNd4OOMPc/iI886F0MyR36gHJUV
         KF31XOQu3dQslqni1uUEeiTOU2PZrz9nfg8tuIOgRmeDB4C/2d8yIViQcxJj5UGy7z+T
         mnrA6qhvB6ajjR/ctvBl4JSNvAPQh+HpW6G2NQgaAuUrZKL3zWnuOKm2i8SuRCi6mwIS
         4teSm5f79nSPjyfDqFIxa9W5EDRvUKtjbo10YnRSAjsqoR13X5Zx1Y8Nr6TpYM9Qxzly
         n0nw==
X-Gm-Message-State: AJIora80onsBO0VghDSFLS0j7V3ylsrsfqYCsfadsa3nNQ1KnAacRrup
        FxC/iv9uG/P2QNNdOKPnZRE=
X-Google-Smtp-Source: AGRyM1t4eqbPaP3I7M4Q4a8CREAJGaFkgWHmK7O/ZXpR+tC19xQ9DUEs+FBui8DB+uQCfvsd4JVx/A==
X-Received: by 2002:a05:6a00:1590:b0:52a:eb00:71dc with SMTP id u16-20020a056a00159000b0052aeb0071dcmr18652289pfk.64.1658857856554;
        Tue, 26 Jul 2022 10:50:56 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id 202-20020a6302d3000000b003db7de758besm10637529pgc.5.2022.07.26.10.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:50:55 -0700 (PDT)
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
Subject: [PATCH v3 15/15] drm/msm/gem: Convert to lockdep assert
Date:   Tue, 26 Jul 2022 10:50:39 -0700
Message-Id: <20220726175043.1027731-16-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220726175043.1027731-1-robdclark@gmail.com>
References: <20220726175043.1027731-1-robdclark@gmail.com>
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

