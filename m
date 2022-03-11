Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9563F4D632C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349337AbiCKOMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349184AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C075A1B3A48;
        Fri, 11 Mar 2022 06:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49BA6B82C21;
        Fri, 11 Mar 2022 14:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493D0C34117;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007778;
        bh=5mcMZJzpCXRPfLtNYLChmPFU09VgUyTWD+GKebgciQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JTe1Yqc7a5SkKiTfzmfAKSLu5o4BrlI2nhO0PjXWYN7oMjjQ9uyw/mVxw+eUCkWSI
         W1LjOQOCn6vJ7cAS9nmAFCP+eurZbekedNKE2hFz6TDiTi2kuUqrFjlGC+eCGdO5Us
         KLD/QWLuK+PZ89hZ77y5YSxIXr9+wShVqQji8cxLUyy/rXaRsIUZWT8AR1d/u01aNK
         feLQH0JC8O8WFoL+KLxv8xxP6nxVNOtnRekTN+7IrhJJGnwTdlgNRVpyxvl7A1K+83
         F2T9hPpo//xcPZ437Uf5xaxZzY+br+s3JA2m60epsYQbU9e7e65wPDoiRAK3o3OhpG
         WH4WeRABpUoLw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxY-000lIH-1R; Fri, 11 Mar 2022 15:09:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 30/38] media: platform: vde: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:43 +0100
Message-Id: <ffd86389feee80c36309aab89c30990e4fd80f4b.1647006877.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647006877.git.mchehab@kernel.org>
References: <cover.1647006877.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to better organize the platform/Kconfig, place
vde-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig           | 19 +------------------
 drivers/media/platform/tegra/vde/Kconfig | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)
 create mode 100644 drivers/media/platform/tegra/vde/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 8d0fa9670eaa..9b8a5f4eaafc 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -72,6 +72,7 @@ source "drivers/media/platform/sti/hva/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
+source "drivers/media/platform/tegra/vde/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -242,24 +243,6 @@ config VIDEO_TI_VPE_DEBUG
 	help
 	  Enable debug messages on VPE driver.
 
-config VIDEO_TEGRA_VDE
-	tristate "NVIDIA Tegra Video Decoder Engine driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on ARCH_TEGRA || COMPILE_TEST
-	depends on VIDEO_DEV && VIDEO_V4L2
-	select DMA_SHARED_BUFFER
-	select IOMMU_IOVA
-	select MEDIA_CONTROLLER
-	select MEDIA_CONTROLLER_REQUEST_API
-	select SRAM
-	select VIDEOBUF2_DMA_CONTIG
-	select VIDEOBUF2_DMA_SG
-	select V4L2_H264
-	select V4L2_MEM2MEM_DEV
-	help
-	   Support for the NVIDIA Tegra video decoder unit.
-	   To compile this driver as a module choose m here.
-
 # TI VIDEO PORT Helper Modules
 # These will be selected by VPE and VIP
 config VIDEO_TI_VPDMA
diff --git a/drivers/media/platform/tegra/vde/Kconfig b/drivers/media/platform/tegra/vde/Kconfig
new file mode 100644
index 000000000000..584b78d8d66c
--- /dev/null
+++ b/drivers/media/platform/tegra/vde/Kconfig
@@ -0,0 +1,17 @@
+config VIDEO_TEGRA_VDE
+	tristate "NVIDIA Tegra Video Decoder Engine driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on VIDEO_DEV && VIDEO_V4L2
+	select DMA_SHARED_BUFFER
+	select IOMMU_IOVA
+	select MEDIA_CONTROLLER
+	select MEDIA_CONTROLLER_REQUEST_API
+	select SRAM
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_DMA_SG
+	select V4L2_H264
+	select V4L2_MEM2MEM_DEV
+	help
+	   Support for the NVIDIA Tegra video decoder unit.
+	   To compile this driver as a module choose m here.
-- 
2.35.1

