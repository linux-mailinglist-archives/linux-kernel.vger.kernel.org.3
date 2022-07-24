Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73A657F518
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiGXMhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0121FD15
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658666267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G0f3MDsyJEdQb5fcMCp5m0x+k6cu5Bh/NA8aL6IfSBI=;
        b=HS7n3Ltyhs5Fo28ioDSe60g9kj4xtMNdxh8ErBVMsEJoHGXR5o/QjJCDrtQFFiYvPHhHDI
        pHf9JzjY43q57hT9NPsbnmZnNtbcq8R79DZqMfDFsqHpZJjtLghSya9IOu4u4wNrBrAtBD
        UeqvyZbibwBAtS6tvA7BWw1p6W86La8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-Km_CnkspP3yMb0Ta_uRRdg-1; Sun, 24 Jul 2022 08:37:46 -0400
X-MC-Unique: Km_CnkspP3yMb0Ta_uRRdg-1
Received: by mail-wm1-f72.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so4802386wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0f3MDsyJEdQb5fcMCp5m0x+k6cu5Bh/NA8aL6IfSBI=;
        b=DEKs1+GtkVriDd6OjHnSG4UW4P985OwquLoMG2mGM+xDSfHSQOdKUgxdQfOdrG3Hgu
         2HBb7iLoFR+y+GO0HTSiBEMTMw90qCqvivi9yPcqUO8w2aUPFKfDK0wsXZkviwgb6XLm
         CyyrvercSctn2MkguFofii5yNwy6Dt1B6ZntHhyvtw7bLHx/DdPKqgt71SS2QQBmV/K8
         xmJXkguehQWaq6vHzLjjO2ECWbtQZo+dRBWqYPV/9/cijNWqazTx+qdKCR0AeloDQVPA
         2aOaFyJnKkWcDMwcjmC2b790SGyPl6htITuPBL+EJnhwHDaSx+lC6qIW/jBXoB1lEaYq
         h/Ow==
X-Gm-Message-State: AJIora/aV+OmCmDI/WfuZ+7ZHyT3DpvLtHAkM5L/j9lyrRtWIUUklgAw
        c6u2VQsO9cIhCBaJO8muXsrBSN6hgx98ZBK72oQb1zRP0Jym4k0MmtdZrdLS9i+aFtDaWF0mB5N
        jFMOvKrrgvpktPB01tX646BN34sI5HX/yVkPbJqj4TL5wj3PPWLEpq+FcmaUJBRc4c2LJO8wIdO
        o=
X-Received: by 2002:a05:6000:2c8:b0:21d:b356:5f21 with SMTP id o8-20020a05600002c800b0021db3565f21mr5325418wry.515.1658666265112;
        Sun, 24 Jul 2022 05:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ug4YTsIGIBNBnXCQXnAEtS3vid0LdX10qcNDlCxc235fu3aeC6pJksAYEP5BAkqCWq0SUwHQ==
X-Received: by 2002:a05:6000:2c8:b0:21d:b356:5f21 with SMTP id o8-20020a05600002c800b0021db3565f21mr5325389wry.515.1658666264736;
        Sun, 24 Jul 2022 05:37:44 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b0021e4829d359sm9368925wrx.39.2022.07.24.05.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 05:37:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: Prevent modeset helpers to access an uninitialized drm_mode_config
Date:   Sun, 24 Jul 2022 14:37:41 +0200
Message-Id: <20220724123741.1268536-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM drivers initialize the mode configuration with drmm_mode_config_init()
and that function (among other things) initializes mutexes that are later
used by modeset helpers.

But the helpers should only attempt to grab those locks if the mode config
was properly initialized. Otherwise it can lead to kernel oops. An example
is when a DRM driver using the component framework does not initialize the
drm_mode_config, because its .bind callback was not being executed due one
of its expected sub-devices' driver failing to probe.

Some drivers check the struct drm_driver.registered field as an indication
on whether their .shutdown callback should call helpers to tearn down the
mode configuration or not, but most drivers just assume that it is always
safe to call helpers such as drm_atomic_helper_shutdown() during shutdown.

Let make the DRM core more robust and prevent this to happen, by marking a
struct drm_mode_config as initialized during drmm_mode_config_init(). that
way helpers can check for it and not attempt to grab uninitialized mutexes.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_mode_config.c  | 4 ++++
 drivers/gpu/drm/drm_modeset_lock.c | 6 ++++++
 include/drm/drm_mode_config.h      | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 59b34f07cfce..db649f97120b 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -456,6 +456,8 @@ int drmm_mode_config_init(struct drm_device *dev)
 		dma_resv_fini(&resv);
 	}
 
+	dev->mode_config.initialized = true;
+
 	return drmm_add_action_or_reset(dev, drm_mode_config_init_release,
 					NULL);
 }
@@ -549,6 +551,8 @@ void drm_mode_config_cleanup(struct drm_device *dev)
 	idr_destroy(&dev->mode_config.tile_idr);
 	idr_destroy(&dev->mode_config.object_idr);
 	drm_modeset_lock_fini(&dev->mode_config.connection_mutex);
+
+	dev->mode_config.initialized = false;
 }
 EXPORT_SYMBOL(drm_mode_config_cleanup);
 
diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 918065982db4..d6a81cb88123 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -444,6 +444,9 @@ EXPORT_SYMBOL(drm_modeset_unlock);
  *
  * See also: DRM_MODESET_LOCK_ALL_BEGIN() and DRM_MODESET_LOCK_ALL_END()
  *
+ * This function must only be called after drmm_mode_config_init(), since it
+ * takes locks that are initialized as part of the initial mode configuration.
+ *
  * Returns: 0 on success or a negative error-code on failure.
  */
 int drm_modeset_lock_all_ctx(struct drm_device *dev,
@@ -454,6 +457,9 @@ int drm_modeset_lock_all_ctx(struct drm_device *dev,
 	struct drm_plane *plane;
 	int ret;
 
+	if (WARN_ON(!dev->mode_config.initialized))
+		return -EINVAL;
+
 	ret = drm_modeset_lock(&dev->mode_config.connection_mutex, ctx);
 	if (ret)
 		return ret;
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 6b5e01295348..d2e1a6d7dcc2 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -954,6 +954,14 @@ struct drm_mode_config {
 	struct drm_atomic_state *suspend_state;
 
 	const struct drm_mode_config_helper_funcs *helper_private;
+
+	/**
+	 * @initialized:
+	 *
+	 * Internally used by modeset helpers such as drm_modeset_lock_all_ctx()
+	 * to determine if the mode configuration has been properly initialized.
+	 */
+	bool initialized;
 };
 
 int __must_check drmm_mode_config_init(struct drm_device *dev);
-- 
2.37.1

