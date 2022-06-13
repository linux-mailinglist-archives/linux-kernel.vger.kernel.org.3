Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133BF54A0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbiFMVLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351929AbiFMVKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:10:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEB416586;
        Mon, 13 Jun 2022 13:49:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so9903761pjl.4;
        Mon, 13 Jun 2022 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WbBxL9rxB+15RDo2ejuHuLx5dieu0bPV+8/sqzH35Y=;
        b=DFL3pOHOBZ6uaJ9yEQKJPsB4zFwGx8lcLv8a8av/oYj7ZXVHpF9p4sbHQSM+SiPgzS
         G8v5eO+mAEDU3qPqPtbDxwqMOgfXWgxVYZos6oI0uSl/K1IL6woCWmkehq9oS3XK4l7c
         Uu+e25rcd3/Psv0Hx7k+uDQqHCQxeODGaPKqPeURWic69bRlu7thtwyczqT2D19SxSR7
         GnxyQlGZrDiTQq4x25qyT/ovdPwjwkHlMJ+45YNBt8/4I2ATZvIgVWdMQLJt/JdszGV4
         pRgA4XxU+dIMgKHpuiTMx2hCERNDNuVjp+s4IaereW/IY1CT/WT6dTHpkBGbium/OBgq
         G/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WbBxL9rxB+15RDo2ejuHuLx5dieu0bPV+8/sqzH35Y=;
        b=1NSS1QdODMtq3DT1fNl3MoOphc+uuIRcrNsb3gR5NuZyij0ACFU3WMqokFLAD9MNJm
         DjbNOTUvDyndNXnkMjy8S4aqIeGU8dSDkaFafU3jxpuXz2pJ259+C96Fx6yACSXoz6if
         +2AKo+dTDcPHJWHvmlni7Eqn/9qCz2MbOH+hDfYPrfmnRhvRI6AyJIr71H2WKT3H10Hu
         NuiDa6nHfJl+tUv7CTlghS0LraaSWeITRZaoJOvtBMi7CwbhdXIp+WATy3JtX6AEgyFD
         IsP4SJjXS5t0/ZDDysu19/NKkzmyOkLtTzf9TtswJSippA90ZkPjvom14vewmBPi3SYj
         Mfgw==
X-Gm-Message-State: AJIora/YW0hLJCUA5CGRNklw/ZJsEydj3rFi3RIcGoQ1j1yALApMrf2u
        bMX2GSH7qWrrCA81QNej01E=
X-Google-Smtp-Source: AGRyM1uOTI6k/sL4XJU84/uEt3GMbUUcl5XCnXux4Nhuu8n+ayh648e2MJrOjk4qEy4XjYgEi16mpA==
X-Received: by 2002:a17:90a:1588:b0:1e0:a45c:5c1 with SMTP id m8-20020a17090a158800b001e0a45c05c1mr596780pja.65.1655153341625;
        Mon, 13 Jun 2022 13:49:01 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902900b00b00168b113f222sm5539202plp.173.2022.06.13.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:49:00 -0700 (PDT)
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
Subject: [PATCH] drm/msm: Make msm_gem_free_object() static
Date:   Mon, 13 Jun 2022 13:49:10 -0700
Message-Id: <20220613204910.2651747-1-robdclark@gmail.com>
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

Misc small cleanup I noticed.  Not called from another object file since
3c9edd9c85f5 ("drm/msm: Introduce GEM object funcs")

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 2 +-
 drivers/gpu/drm/msm/msm_gem.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 35845e273d81..3ef7ada59392 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1004,7 +1004,7 @@ void msm_gem_describe_objects(struct list_head *list, struct seq_file *m)
 #endif
 
 /* don't call directly!  Use drm_gem_object_put() */
-void msm_gem_free_object(struct drm_gem_object *obj)
+static void msm_gem_free_object(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	struct drm_device *dev = obj->dev;
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 6b7d5bb3b575..d608339c1643 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -175,7 +175,6 @@ void msm_gem_active_get(struct drm_gem_object *obj, struct msm_gpu *gpu);
 void msm_gem_active_put(struct drm_gem_object *obj);
 int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout);
 int msm_gem_cpu_fini(struct drm_gem_object *obj);
-void msm_gem_free_object(struct drm_gem_object *obj);
 int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 		uint32_t size, uint32_t flags, uint32_t *handle, char *name);
 struct drm_gem_object *msm_gem_new(struct drm_device *dev,
-- 
2.36.1

