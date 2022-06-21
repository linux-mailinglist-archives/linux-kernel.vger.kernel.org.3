Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FBB552923
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiFUBw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 21:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFUBwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:52:25 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803F41D0ED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 18:52:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655776341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K1+H2v0Dcy5bcSfjbkDccu2ORW87weu+sEwK39E3Vlk=;
        b=ivrUZstejSf/I9HRVWtAIeQvqmdrX3LWfbTyH4Lqykkaa5zxKwQr7kDwuMAR2J542l6Omx
        ZhHxTdF2b/sUqPDyZPHGU3bVgX9rowrRntCKpKDaLiexGXnbB1hJb+oWB4ppiS6unYdg2W
        fYuntfhTPtar7BMhHUHvawpE2Anw+oE=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Make drm_buddy a part of drm module
Date:   Tue, 21 Jun 2022 09:51:50 +0800
Message-Id: <20220621015151.11129-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_buddy is just a software allocator, so don't need to create
a module for this small part.
If drm_buddy is included in drm module, then only need to insmod drm.ko

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/gpu/drm/Kconfig     |  2 +-
 drivers/gpu/drm/Makefile    |  1 +
 drivers/gpu/drm/drm_buddy.c |  7 ++-----
 drivers/gpu/drm/drm_drv.c   | 10 ++++++++++
 include/drm/drm_buddy.h     |  3 +++
 5 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 22e7fa48d693..6c18b34f25d3 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -180,7 +180,7 @@ config DRM_TTM
 	  uses it.
 
 config DRM_BUDDY
-	tristate
+	bool
 	depends on DRM
 	help
 	  A page based buddy allocator
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 13ef240b3d2b..75737ccb5fc0 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -29,6 +29,7 @@ drm-$(CONFIG_PCI) += drm_pci.o
 drm-$(CONFIG_DEBUG_FS) += drm_debugfs.o drm_debugfs_crc.o
 drm-$(CONFIG_DRM_LOAD_EDID_FIRMWARE) += drm_edid_load.o
 drm-$(CONFIG_DRM_PRIVACY_SCREEN) += drm_privacy_screen.o drm_privacy_screen_x86.o
+drm-$(CONFIG_DRM_BUDDY) += drm_buddy.o
 obj-$(CONFIG_DRM)	+= drm.o
 
 obj-$(CONFIG_DRM_NOMODESET) += drm_nomodeset.o
diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index 11bb59399471..9262811b39ac 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -767,12 +767,12 @@ void drm_buddy_print(struct drm_buddy *mm, struct drm_printer *p)
 }
 EXPORT_SYMBOL(drm_buddy_print);
 
-static void drm_buddy_module_exit(void)
+void drm_buddy_slb_blk_put(void)
 {
 	kmem_cache_destroy(slab_blocks);
 }
 
-static int __init drm_buddy_module_init(void)
+int __init drm_buddy_slb_blk_get(void)
 {
 	slab_blocks = KMEM_CACHE(drm_buddy_block, 0);
 	if (!slab_blocks)
@@ -781,8 +781,5 @@ static int __init drm_buddy_module_init(void)
 	return 0;
 }
 
-module_init(drm_buddy_module_init);
-module_exit(drm_buddy_module_exit);
-
 MODULE_DESCRIPTION("DRM Buddy Allocator");
 MODULE_LICENSE("Dual MIT/GPL");
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..2b5d6a8b5572 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -44,6 +44,7 @@
 #include <drm/drm_mode_object.h>
 #include <drm/drm_print.h>
 #include <drm/drm_privacy_screen_machine.h>
+#include <drm/drm_buddy.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
@@ -1034,6 +1035,9 @@ static const struct file_operations drm_stub_fops = {
 static void drm_core_exit(void)
 {
 	drm_privacy_screen_lookup_exit();
+#if IS_ENABLED(CONFIG_DRM_BUDDY)
+	drm_buddy_slb_blk_put();
+#endif
 	unregister_chrdev(DRM_MAJOR, "drm");
 	debugfs_remove(drm_debugfs_root);
 	drm_sysfs_destroy();
@@ -1061,6 +1065,12 @@ static int __init drm_core_init(void)
 	if (ret < 0)
 		goto error;
 
+#if IS_ENABLED(CONFIG_DRM_BUDDY)
+	ret = drm_buddy_slb_blk_get();
+	if (!ret)
+		goto error;
+#endif
+
 	drm_privacy_screen_lookup_init();
 
 	drm_core_init_complete = true;
diff --git a/include/drm/drm_buddy.h b/include/drm/drm_buddy.h
index 572077ff8ae7..6f648175243c 100644
--- a/include/drm/drm_buddy.h
+++ b/include/drm/drm_buddy.h
@@ -156,4 +156,7 @@ void drm_buddy_block_print(struct drm_buddy *mm,
 			   struct drm_buddy_block *block,
 			   struct drm_printer *p);
 
+int __init drm_buddy_slb_blk_get(void);
+void drm_buddy_slb_blk_put(void);
+
 #endif
-- 
2.25.1

