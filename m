Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7865356C3F8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiGHUzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiGHUzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:55:02 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4087365;
        Fri,  8 Jul 2022 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657313666; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3za2o5fHO/UXzjf7ToxHWFd4R5/d/tS3sCIOjVRiIs=;
        b=f7Em+wIFnv/2Fe1Le76SpeJs8bLFGZImpRs9Wlj2V+ZDlt9XCiJ8Ig7ZetPBosfsSgkB3V
        /F2JDWBQTh4si7xiqYi7mqi10TEolb2yaFugb78x6AJrBpCw1y7ojFzIuaPlyX73J76nAD
        xXCLauNeU9NfqD8bVjmR3uPMBG0CT1E=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/6] drm/ingenic: Make IPU driver its own module
Date:   Fri,  8 Jul 2022 21:54:05 +0100
Message-Id: <20220708205406.96473-6-paul@crapouillou.net>
In-Reply-To: <20220708205406.96473-1-paul@crapouillou.net>
References: <20220708205406.96473-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of building the IPU driver code into the ingenic-drm driver,
create a ingenic-ipu driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/Kconfig           |  2 +-
 drivers/gpu/drm/ingenic/Makefile          |  2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 33 +++++------------------
 drivers/gpu/drm/ingenic/ingenic-drm.h     |  3 ---
 drivers/gpu/drm/ingenic/ingenic-ipu.c     |  6 ++++-
 5 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/Kconfig b/drivers/gpu/drm/ingenic/Kconfig
index 090830bcbde7..daa1aa81b46b 100644
--- a/drivers/gpu/drm/ingenic/Kconfig
+++ b/drivers/gpu/drm/ingenic/Kconfig
@@ -18,7 +18,7 @@ config DRM_INGENIC
 if DRM_INGENIC
 
 config DRM_INGENIC_IPU
-	bool "IPU support for Ingenic SoCs"
+	tristate "IPU support for Ingenic SoCs"
 	help
 	  Choose this option to enable support for the IPU found in Ingenic SoCs.
 
diff --git a/drivers/gpu/drm/ingenic/Makefile b/drivers/gpu/drm/ingenic/Makefile
index f10cc1c5a5f2..e650d4ec895b 100644
--- a/drivers/gpu/drm/ingenic/Makefile
+++ b/drivers/gpu/drm/ingenic/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_DRM_INGENIC) += ingenic-drm.o
 ingenic-drm-y = ingenic-drm-drv.o
-ingenic-drm-$(CONFIG_DRM_INGENIC_IPU) += ingenic-ipu.o
+obj-$(CONFIG_DRM_INGENIC_IPU) += ingenic-ipu.o
 obj-$(CONFIG_DRM_INGENIC_DW_HDMI) += ingenic-dw-hdmi.o
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 78d0b035e2d7..98ff038d95d6 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -550,6 +550,7 @@ void ingenic_drm_plane_disable(struct device *dev, struct drm_plane *plane)
 		regmap_clear_bits(priv->map, JZ_REG_LCD_OSDC, en_bit);
 	}
 }
+EXPORT_SYMBOL_GPL(ingenic_drm_plane_disable);
 
 static void ingenic_drm_plane_atomic_disable(struct drm_plane *plane,
 					     struct drm_atomic_state *state)
@@ -633,6 +634,7 @@ void ingenic_drm_plane_config(struct device *dev,
 			     state->crtc_h << JZ_LCD_SIZE01_HEIGHT_LSB);
 	}
 }
+EXPORT_SYMBOL_GPL(ingenic_drm_plane_config);
 
 bool ingenic_drm_map_noncoherent(const struct device *dev)
 {
@@ -640,6 +642,7 @@ bool ingenic_drm_map_noncoherent(const struct device *dev)
 
 	return priv->soc_info->map_noncoherent;
 }
+EXPORT_SYMBOL_GPL(ingenic_drm_map_noncoherent);
 
 static void ingenic_drm_update_palette(struct ingenic_drm *priv,
 				       const struct drm_color_lut *lut)
@@ -1438,6 +1441,9 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	struct device_node *np;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	if (!IS_ENABLED(CONFIG_DRM_INGENIC_IPU))
 		return ingenic_drm_bind(dev, false);
 
@@ -1615,32 +1621,7 @@ static struct platform_driver ingenic_drm_driver = {
 	.probe = ingenic_drm_probe,
 	.remove = ingenic_drm_remove,
 };
-
-static int ingenic_drm_init(void)
-{
-	int err;
-
-	if (drm_firmware_drivers_only())
-		return -ENODEV;
-
-	if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU)) {
-		err = platform_driver_register(ingenic_ipu_driver_ptr);
-		if (err)
-			return err;
-	}
-
-	return platform_driver_register(&ingenic_drm_driver);
-}
-module_init(ingenic_drm_init);
-
-static void ingenic_drm_exit(void)
-{
-	platform_driver_unregister(&ingenic_drm_driver);
-
-	if (IS_ENABLED(CONFIG_DRM_INGENIC_IPU))
-		platform_driver_unregister(ingenic_ipu_driver_ptr);
-}
-module_exit(ingenic_drm_exit);
+module_platform_driver(ingenic_drm_driver);
 
 MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
 MODULE_DESCRIPTION("DRM driver for the Ingenic SoCs\n");
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.h b/drivers/gpu/drm/ingenic/ingenic-drm.h
index e5bd007ea93d..9b89929b81bc 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.h
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.h
@@ -220,13 +220,10 @@
 struct device;
 struct drm_plane;
 struct drm_plane_state;
-struct platform_driver;
 
 void ingenic_drm_plane_config(struct device *dev,
 			      struct drm_plane *plane, u32 fourcc);
 void ingenic_drm_plane_disable(struct device *dev, struct drm_plane *plane);
 bool ingenic_drm_map_noncoherent(const struct device *dev);
 
-extern struct platform_driver *ingenic_ipu_driver_ptr;
-
 #endif /* DRIVERS_GPU_DRM_INGENIC_INGENIC_DRM_H */
diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index d13f58ad4769..fb62c27819ea 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/time.h>
 
@@ -995,5 +996,8 @@ static struct platform_driver ingenic_ipu_driver = {
 	.probe = ingenic_ipu_probe,
 	.remove = ingenic_ipu_remove,
 };
+module_platform_driver(ingenic_ipu_driver);
 
-struct platform_driver *ingenic_ipu_driver_ptr = &ingenic_ipu_driver;
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_DESCRIPTION("DRM driver for the IPU of Ingenic SoCs\n");
+MODULE_LICENSE("GPL");
-- 
2.35.1

