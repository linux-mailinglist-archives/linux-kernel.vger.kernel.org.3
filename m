Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BA517E61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiECHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiECHT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:19:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9649B2CE16
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651562155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtraDmUmHWZ5CXW/vDLQ7b/w9+ZLre3XUlilpcMRu6A=;
        b=EBv3D7UADwpV1AfFLuNfAq0AnMiP7eNI+tb0oVvllYDMksQnxaVtde+CNMjq32ltrOzoH4
        oNvaerSiy4HrPUnnR6a1Xy2OuXztbvYs+uWEkCsEaRnLGspGAeGTb1Kjca5YJ8TI0KK9CI
        R4RxNtukbIk+QFprbLhyzc+ufppUYm8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-uVj1CgzAMwSP6g-Pjn9wFg-1; Tue, 03 May 2022 03:15:54 -0400
X-MC-Unique: uVj1CgzAMwSP6g-Pjn9wFg-1
Received: by mail-wm1-f70.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so3396348wmr.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtraDmUmHWZ5CXW/vDLQ7b/w9+ZLre3XUlilpcMRu6A=;
        b=idtTb0led5ezQGQsHHxAifDbOevxsWcab1EVLrtjGWeeLmlm9YpwPRBySOpmAJ4x2L
         WfYn+HKDe25qi+GbUawlkum+8DKhIA4CZgFY8QnwwqJPUweVu3ums8I33rbwO1sY8Iqr
         31RjI8d+47lUXLrvH5HXR51pz7ehRO6b0BNe/6VVTYER++k9oAe3FKHX0MXD5vpwHfrf
         c/SedNGEGYOqjkn5Q2DxAXArwsWWQxEB4PibEud8Djhmb9PerCGYo7HVkKsEFrwm9c82
         8CodZAPYkurnwzgfsXqVWBUge4YB5fjPJrdPybc/8+KzJs1CYfRVvKwb++s2gUv/YfZg
         YuNA==
X-Gm-Message-State: AOAM532G0KH46w+P8uFpdNT95uVpkziStvNCaqFN/Ekrh3Dt2qd5y2xP
        1ygdsK3pHqWk0tUeF82trrIvFDEMZh+8O7EWew+w8mDmOgUYhh4/7VL1EQKdf7Mn9yrS9owcSRx
        nlPNkug7/5zPaaUsCRGxbhnSgUsvicEPRKf6ZzLwcH16NuU31URPay6mbQihuvwQlW+MDSP29Td
        s=
X-Received: by 2002:a5d:4686:0:b0:20a:e8dc:fd99 with SMTP id u6-20020a5d4686000000b0020ae8dcfd99mr11567484wrq.478.1651562152756;
        Tue, 03 May 2022 00:15:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBl7s6u9LXk5to6fBUq9k2QYLkjxFcT7wJp9/+4B6ASdL9DSXyR9W5uBHHsWeUQTXcm1BFXQ==
X-Received: by 2002:a5d:4686:0:b0:20a:e8dc:fd99 with SMTP id u6-20020a5d4686000000b0020ae8dcfd99mr11567442wrq.478.1651562152071;
        Tue, 03 May 2022 00:15:52 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c339400b003942a244f33sm1035387wmp.12.2022.05.03.00.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 00:15:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 2/3] drm/fb-helper: Rename preferred_bpp drm_fbdev_generic_setup() parameter
Date:   Tue,  3 May 2022 09:15:39 +0200
Message-Id: <20220503071540.471667-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503071540.471667-1-javierm@redhat.com>
References: <20220503071540.471667-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default the bits per pixel for the emulated framebuffer device is set
to dev->mode_config.preferred_depth, but some devices need another value.

Since this second parameter is only used by a few drivers, and to allow
drivers to use it for passing other configurations when registering the
fbdev, rename @preferred_bpp to @options and make it a multi-field param.

The DRM_FB_OPTION() and DRM_FB_GET_OPTION() macros are provided to drivers
for computing options bitfield values and getting the values respectively

For now, only the DRM_FB_BPP option exists but other options can be added.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Changes in v3:
- Drop the preferred_bpp local variable (Laurent Pinchart).
- Add a const qualifier to options parameter (Laurent Pinchart).

Changes in v2:
- Rename DRM_FB_SET_OPTION() to DRM_FB_OPTION() and make more clear in
  the kernel-doc what this macro does (Laurent Pinchart).
- Fix some kernel-doc issues I didn't notice in v1.
- Add Reviewed-by tags from Thomas and Laurent.

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  6 +++--
 drivers/gpu/drm/arm/hdlcd_drv.c               |  2 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  2 +-
 drivers/gpu/drm/ast/ast_drv.c                 |  2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |  2 +-
 drivers/gpu/drm/drm_drv.c                     |  2 +-
 drivers/gpu/drm/drm_fb_helper.c               | 26 ++++++++++++-------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  2 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c           |  2 +-
 drivers/gpu/drm/imx/imx-drm-core.c            |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  2 +-
 drivers/gpu/drm/mcde/mcde_drv.c               |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +-
 drivers/gpu/drm/meson/meson_drv.c             |  2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |  2 +-
 drivers/gpu/drm/pl111/pl111_drv.c             |  2 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |  2 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  2 +-
 drivers/gpu/drm/sti/sti_drv.c                 |  2 +-
 drivers/gpu/drm/stm/drv.c                     |  2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  2 +-
 drivers/gpu/drm/tidss/tidss_drv.c             |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |  2 +-
 drivers/gpu/drm/tiny/arcpgu.c                 |  2 +-
 drivers/gpu/drm/tiny/bochs.c                  |  2 +-
 drivers/gpu/drm/tve200/tve200_drv.c           |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c          |  2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                 |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c          |  2 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |  2 +-
 include/drm/drm_fb_helper.h                   | 14 +++++++++-
 33 files changed, 64 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b03663f42cc9..0c54470975e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2118,9 +2118,11 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	    !list_empty(&adev_to_drm(adev)->mode_config.connector_list)) {
 		/* select 8 bpp console on low vram cards */
 		if (adev->gmc.real_vram_size <= (32*1024*1024))
-			drm_fbdev_generic_setup(adev_to_drm(adev), 8);
+			drm_fbdev_generic_setup(adev_to_drm(adev),
+						DRM_FB_OPTION(DRM_FB_BPP, 8));
 		else
-			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
+			drm_fbdev_generic_setup(adev_to_drm(adev),
+						DRM_FB_OPTION(DRM_FB_BPP, 32));
 	}
 
 	ret = amdgpu_debugfs_init(adev);
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index e89ae0ec60eb..b69b1e5be379 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -321,7 +321,7 @@ static int hdlcd_drm_bind(struct device *dev)
 	if (ret)
 		goto err_register;
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index d5aef21426cf..25685b579a05 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -863,7 +863,7 @@ static int malidp_bind(struct device *dev)
 	if (ret)
 		goto register_fail;
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 7780b72de9e8..dcccc2e93aea 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -343,7 +343,7 @@ static int aspeed_gfx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unload;
 
-	drm_fbdev_generic_setup(&priv->drm, 32);
+	drm_fbdev_generic_setup(&priv->drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 	return 0;
 
 err_unload:
diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 7465c4f0156a..115be73e9b02 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -126,7 +126,7 @@ static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
-	drm_fbdev_generic_setup(dev, 32);
+	drm_fbdev_generic_setup(dev, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 651e3c109360..d2ced1a03df9 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -760,7 +760,7 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unload;
 
-	drm_fbdev_generic_setup(ddev, 24);
+	drm_fbdev_generic_setup(ddev, DRM_FB_OPTION(DRM_FB_BPP, 24));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..9fbc2287c876 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -324,7 +324,7 @@ void drm_minor_release(struct drm_minor *minor)
  *		if (ret)
  *			return ret;
  *
- *		drm_fbdev_generic_setup(drm, 32);
+ *		drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
  *
  *		return 0;
  *	}
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d265a73313c9..52042ba1e4cf 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2501,8 +2501,17 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
 /**
  * drm_fbdev_generic_setup() - Setup generic fbdev emulation
  * @dev: DRM device
- * @preferred_bpp: Preferred bits per pixel for the device.
- *                 @dev->mode_config.preferred_depth is used if this is zero.
+ * @options: options for the registered framebuffer.
+ *
+ * The @options parameter is a multi-field parameter that can contain
+ * different options for the emulated framebuffer device registered.
+ *
+ * The options field values can be set using DRM_FB_OPTION() to compute
+ * the value according to the option bitfield and can be obtained using
+ * DRM_FB_GET_OPTION(). The options fields are the following:
+ *
+ * * DRM_FB_BPP: bits per pixel for the device. If the field is not set,
+ *   @dev->mode_config.preferred_depth is used instead.
  *
  * This function sets up generic fbdev emulation for drivers that supports
  * dumb buffers with a virtual address and that can be mmap'ed.
@@ -2525,8 +2534,7 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
  *
  * The fbdev is destroyed by drm_dev_unregister().
  */
-void drm_fbdev_generic_setup(struct drm_device *dev,
-			     unsigned int preferred_bpp)
+void drm_fbdev_generic_setup(struct drm_device *dev, const unsigned int options)
 {
 	struct drm_fb_helper *fb_helper;
 	int ret;
@@ -2555,11 +2563,11 @@ void drm_fbdev_generic_setup(struct drm_device *dev,
 	 * mess, resulting in some drivers picking wrong fbdev defaults and
 	 * others wrong preferred_depth defaults.
 	 */
-	if (!preferred_bpp)
-		preferred_bpp = dev->mode_config.preferred_depth;
-	if (!preferred_bpp)
-		preferred_bpp = 32;
-	fb_helper->preferred_bpp = preferred_bpp;
+	fb_helper->preferred_bpp = DRM_FB_GET_OPTION(DRM_FB_BPP, options);
+	if (!fb_helper->preferred_bpp)
+		fb_helper->preferred_bpp = dev->mode_config.preferred_depth;
+	if (!fb_helper->preferred_bpp)
+		fb_helper->preferred_bpp = 32;
 
 	ret = drm_fbdev_client_hotplug(&fb_helper->client);
 	if (ret)
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 7a503bf08d0f..293390f0d99c 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -334,7 +334,7 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto put;
 
-	drm_fbdev_generic_setup(drm, legacyfb_depth);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, legacyfb_depth));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 2af51df6dca7..eb6f3e5d4c95 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -237,7 +237,7 @@ static int kirin_drm_bind(struct device *dev)
 	if (ret)
 		goto err_kms_cleanup;
 
-	drm_fbdev_generic_setup(drm_dev, 32);
+	drm_fbdev_generic_setup(drm_dev, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
index 9b84df34a6a1..f84b54793d96 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
@@ -148,7 +148,7 @@ struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss)
 	if (ret)
 		goto cleanup_crtc;
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return kms;
 
diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index a57812ec36b1..5fd8cf003a4c 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -251,7 +251,7 @@ static int imx_drm_bind(struct device *dev)
 	if (ret)
 		goto err_poll_fini;
 
-	drm_fbdev_generic_setup(drm, legacyfb_depth);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, legacyfb_depth));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 8eb0ad501a7b..2e7815294e32 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1388,7 +1388,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 		goto err_clk_notifier_unregister;
 	}
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index e601baa87e55..e2ca0162061f 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -238,7 +238,7 @@ static int mcde_drm_bind(struct device *dev)
 	if (ret < 0)
 		goto unbind;
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 247c6ff277ef..fef2cc840baf 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -393,7 +393,7 @@ static int mtk_drm_bind(struct device *dev)
 	if (ret < 0)
 		goto err_deinit;
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 1b70938cfd2c..87fcee9143a9 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -350,7 +350,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (ret)
 		goto uninstall_irq;
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 9d71c55a31c0..6b251916a6c9 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -357,7 +357,7 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unload;
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 520301b405f1..11b5aea3a166 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -308,7 +308,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	if (ret < 0)
 		goto dev_put;
 
-	drm_fbdev_generic_setup(drm, priv->variant->fb_bpp);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, priv->variant->fb_bpp));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 1cb6f0c224bb..883beebe6317 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -122,7 +122,7 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto modeset_cleanup;
 
-	drm_fbdev_generic_setup(&qdev->ddev, 32);
+	drm_fbdev_generic_setup(&qdev->ddev, DRM_FB_OPTION(DRM_FB_BPP, 32));
 	return 0;
 
 modeset_cleanup:
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index 957ea97541d5..6faadab6577b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -681,7 +681,7 @@ static int rcar_du_probe(struct platform_device *pdev)
 
 	DRM_INFO("Device %s probed\n", dev_name(&pdev->dev));
 
-	drm_fbdev_generic_setup(&rcdu->ddev, 32);
+	drm_fbdev_generic_setup(&rcdu->ddev, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index d858209cf8de..b97ab614d25a 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -200,7 +200,7 @@ static int sti_bind(struct device *dev)
 
 	drm_mode_config_reset(ddev);
 
-	drm_fbdev_generic_setup(ddev, 32);
+	drm_fbdev_generic_setup(ddev, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 0da7cce2a1a2..a04a54d0cc9a 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -203,7 +203,7 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_put;
 
-	drm_fbdev_generic_setup(ddev, 16);
+	drm_fbdev_generic_setup(ddev, DRM_FB_OPTION(DRM_FB_BPP, 16));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 275f7e4a03ae..f593a8d127fa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -112,7 +112,7 @@ static int sun4i_drv_bind(struct device *dev)
 	if (ret)
 		goto finish_poll;
 
-	drm_fbdev_generic_setup(drm, 32);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 04cfff89ee51..58f0d69b2979 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -180,7 +180,7 @@ static int tidss_probe(struct platform_device *pdev)
 		goto err_irq_uninstall;
 	}
 
-	drm_fbdev_generic_setup(ddev, 32);
+	drm_fbdev_generic_setup(ddev, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	dev_dbg(dev, "%s done\n", __func__);
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index eee3c447fbac..5216365ccab5 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -384,7 +384,7 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
 		goto init_failed;
 	priv->is_registered = true;
 
-	drm_fbdev_generic_setup(ddev, bpp);
+	drm_fbdev_generic_setup(ddev, DRM_FB_OPTION(DRM_FB_BPP, bpp));
 	return 0;
 
 init_failed:
diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index f0fa3b15c341..df989d5ff5a0 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -392,7 +392,7 @@ static int arcpgu_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unload;
 
-	drm_fbdev_generic_setup(&arcpgu->drm, 16);
+	drm_fbdev_generic_setup(&arcpgu->drm, DRM_FB_OPTION(DRM_FB_BPP, 16));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index ed971c8bb446..c99608f20bcc 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -663,7 +663,7 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 	if (ret)
 		goto err_free_dev;
 
-	drm_fbdev_generic_setup(dev, 32);
+	drm_fbdev_generic_setup(dev, DRM_FB_OPTION(DRM_FB_BPP, 32));
 	return ret;
 
 err_free_dev:
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 6d9d2921abf4..5fc940d09043 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -226,7 +226,7 @@ static int tve200_probe(struct platform_device *pdev)
 	 * Passing in 16 here will make the RGB565 mode the default
 	 * Passing in 32 will use XRGB8888 mode
 	 */
-	drm_fbdev_generic_setup(drm, 16);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 16));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
index f4f2bd79a7cb..2212be1bf03e 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -79,7 +79,7 @@ static int vbox_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto err_irq_fini;
 
-	drm_fbdev_generic_setup(&vbox->ddev, 32);
+	drm_fbdev_generic_setup(&vbox->ddev, DRM_FB_OPTION(DRM_FB_BPP, 32));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 162bc18e7497..ddfdf9907344 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -291,7 +291,7 @@ static int vc4_drm_bind(struct device *dev)
 	if (ret < 0)
 		goto unbind_all;
 
-	drm_fbdev_generic_setup(drm, 16);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 16));
 
 	return 0;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 5f25a8d15464..d62aa084392b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -128,7 +128,7 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 	if (ret)
 		goto err_deinit;
 
-	drm_fbdev_generic_setup(vdev->priv, 32);
+	drm_fbdev_generic_setup(vdev->priv, DRM_FB_OPTION(DRM_FB_BPP, 32));
 	return 0;
 
 err_deinit:
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 824b510e337b..be1f0f6b460b 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -135,7 +135,7 @@ static int zynqmp_dpsub_drm_init(struct zynqmp_dpsub *dpsub)
 		goto err_poll_fini;
 
 	/* Initialize fbdev generic emulation. */
-	drm_fbdev_generic_setup(drm, 24);
+	drm_fbdev_generic_setup(drm, DRM_FB_OPTION(DRM_FB_BPP, 24));
 
 	return 0;
 
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 3af4624368d8..5fc41cf0c987 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -35,6 +35,7 @@ struct drm_fb_helper;
 #include <drm/drm_client.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
+#include <linux/bitfield.h>
 #include <linux/kgdb.h>
 
 enum mode_set_atomic {
@@ -42,6 +43,17 @@ enum mode_set_atomic {
 	ENTER_ATOMIC_MODE_SET,
 };
 
+#define DRM_FB_BPP_MASK GENMASK(7, 0)
+
+/* Using the GNU statement expression extension */
+#define DRM_FB_OPTION(option, value)				\
+	({							\
+		WARN_ON(!FIELD_FIT(option##_MASK, value));	\
+		FIELD_PREP(option##_MASK, value);		\
+	})
+
+#define DRM_FB_GET_OPTION(option, word) FIELD_GET(option##_MASK, word)
+
 /**
  * struct drm_fb_helper_surface_size - describes fbdev size and scanout surface size
  * @fb_width: fbdev width
@@ -269,7 +281,7 @@ void drm_fb_helper_lastclose(struct drm_device *dev);
 void drm_fb_helper_output_poll_changed(struct drm_device *dev);
 
 void drm_fbdev_generic_setup(struct drm_device *dev,
-			     unsigned int preferred_bpp);
+			     const unsigned int options);
 #else
 static inline void drm_fb_helper_prepare(struct drm_device *dev,
 					struct drm_fb_helper *helper,
-- 
2.35.1

