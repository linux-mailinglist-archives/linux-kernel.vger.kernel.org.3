Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA1C54CD5E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiFOPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiFOPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:48:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4B032E9E5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:48:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89EF4153B;
        Wed, 15 Jun 2022 08:48:49 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.7.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB7D33F7F5;
        Wed, 15 Jun 2022 08:48:47 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sandy Huang <hjc@rock-chips.com>
Cc:     Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] drm/rockchip: Detach from ARM DMA domain in attach_device
Date:   Wed, 15 Jun 2022 16:48:30 +0100
Message-Id: <20220615154830.555422-1-steven.price@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1ea2a07a532b ("iommu: Add DMA ownership management
interfaces") the Rockchip display driver on the Firefly RK3288 fails to
initialise properly. This is because ARM DMA domain is still attached.

Let's follow the lead of exynos and tegra and add code to explicitly
remove the ARM domain before attaching a new one.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
See also the thread[1] where I reported the regression.

[1] https://lore.kernel.org/linux-kernel/da9cca0a-ec5b-2e73-9de0-a930f7d947b2%40arm.com
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 67d38f53d3e5..13ed33e74457 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -23,6 +23,14 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
+#if defined(CONFIG_ARM_DMA_USE_IOMMU)
+#include <asm/dma-iommu.h>
+#else
+#define arm_iommu_detach_device(...)	({ })
+#define arm_iommu_release_mapping(...)	({ })
+#define to_dma_iommu_mapping(dev) NULL
+#endif
+
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_fb.h"
 #include "rockchip_drm_gem.h"
@@ -49,6 +57,15 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 	if (!private->domain)
 		return 0;
 
+	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
+		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+
+		if (mapping) {
+			arm_iommu_detach_device(dev);
+			arm_iommu_release_mapping(mapping);
+		}
+	}
+
 	ret = iommu_attach_device(private->domain, dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Failed to attach iommu device\n");
-- 
2.25.1

