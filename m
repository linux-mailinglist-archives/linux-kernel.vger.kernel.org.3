Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B094D62F3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349186AbiCKOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349082AbiCKOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:09:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90CB99689;
        Fri, 11 Mar 2022 06:08:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C8EFB82C19;
        Fri, 11 Mar 2022 14:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD08C340F6;
        Fri, 11 Mar 2022 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007676;
        bh=bwPUfixnMMMLYKoF0FKok+c6RIHDE6nwFXAt3rddH7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DU+MyyrFD4ayVjVmbSiJkRlemrIuLZA10qztcyZyi14ghl88ZrtjVWanakIbPunIT
         jlT3BPICECYwNhp63EJ37qoxPspfpuCegTz0T8B1t/Scj6ESgmx5VeO/2XT8eUg1St
         8ijRHdV4qtsLwIV24tF/5tc8Sh2FicFq12d/sZTWQtXZX80z0YPHnT7zagxk3GG+/n
         6dx3624yOlMCrXguDAsfwrmmnU0FSCl7Na8C5SM2ktBeFqz8laB8b4znhN/EYGZW3p
         BX7Trmmly3HvnNwbrwhheG+bT6EOyEEJzajoOwrBlXg6uxWVWPGW2ZDhd6xWMed4yp
         fN3T/Nft84j4Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfvt-000lAr-PL; Fri, 11 Mar 2022 15:07:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Yong Deng <yong.deng@magewell.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 05/38] media: platform: move platform menu dependencies to drivers
Date:   Fri, 11 Mar 2022 15:07:18 +0100
Message-Id: <93e1ed4c56850384185d684d2f035995e646f431.1647006877.git.mchehab@kernel.org>
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

Right now, platform dependencies are organized by the type of
the platform driver. Yet, things tend to become very messy with
time. The better seems to organize the drivers per manufacturer,
as other Kernel subsystems are doing.

As a preparation for such purpose, get rid of menuconfigs,
moving the per-menu dependencies to be at the driver-specifig
config entires.

This shoud give flexibility to reorganize the platform drivers
per manufacturer and re-sort them.

This patch removes all "if..endif" options from the platform
Kconfig, converting them into depends on.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                | 127 ++++++++++++------
 drivers/media/platform/am437x/Kconfig         |   1 +
 drivers/media/platform/atmel/Kconfig          |   4 +
 drivers/media/platform/cadence/Kconfig        |   1 +
 drivers/media/platform/davinci/Kconfig        |   6 +
 drivers/media/platform/exynos4-is/Kconfig     |   1 +
 drivers/media/platform/imx-jpeg/Kconfig       |   1 +
 drivers/media/platform/imx/Kconfig            |   1 +
 drivers/media/platform/marvell-ccic/Kconfig   |   2 +
 drivers/media/platform/omap/Kconfig           |   1 +
 drivers/media/platform/rcar-vin/Kconfig       |   2 +
 drivers/media/platform/sti/c8sectpfe/Kconfig  |   1 +
 .../media/platform/sunxi/sun4i-csi/Kconfig    |   1 +
 .../media/platform/sunxi/sun6i-csi/Kconfig    |   1 +
 drivers/media/platform/xilinx/Kconfig         |   1 +
 15 files changed, 107 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 4843fabb8bb2..1cb73f09d0b5 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -3,17 +3,46 @@
 # Platform drivers
 #	Most drivers here are currently for webcam support
 
-menuconfig V4L_PLATFORM_DRIVERS
+menuconfig MEDIA_PLATFORM_DRIVERS
+	bool "Media platform devices"
+	help
+	  Say Y here to enable support for platform-specific media drivers.
+
+if MEDIA_PLATFORM_DRIVERS
+
+config V4L_PLATFORM_DRIVERS
 	bool "V4L platform devices"
 	help
 	  Say Y here to enable support for platform-specific V4L drivers.
 
-if V4L_PLATFORM_DRIVERS
+config SDR_PLATFORM_DRIVERS
+	bool "SDR platform devices"
+	depends on MEDIA_SDR_SUPPORT
+	help
+	  Say Y here to enable support for platform-specific SDR Drivers.
+
+config DVB_PLATFORM_DRIVERS
+	bool "DVB platform devices"
+	depends on MEDIA_DIGITAL_TV_SUPPORT
+	help
+	  Say Y here to enable support for platform-specific Digital TV drivers.
+
+config V4L_MEM2MEM_DRIVERS
+	bool "Memory-to-memory multimedia devices"
+	depends on VIDEO_V4L2
+	help
+	  Say Y here to enable selecting drivers for V4L devices that
+	  use system memory for both source and destination buffers, as opposed
+	  to capture and output drivers, which use memory buffers for just
+	  one of those.
+
+# V4L platform drivers
 
 source "drivers/media/platform/marvell-ccic/Kconfig"
 
 config VIDEO_VIA_CAMERA
 	tristate "VIAFB camera controller support"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on FB_VIA && VIDEO_V4L2
 	select VIDEOBUF2_DMA_SG
 	select VIDEO_OV7670
@@ -22,9 +51,6 @@ config VIDEO_VIA_CAMERA
 	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
 	   with ov7670 sensors.
 
-#
-# Platform multimedia device configuration
-#
 source "drivers/media/platform/cadence/Kconfig"
 
 source "drivers/media/platform/davinci/Kconfig"
@@ -33,6 +59,7 @@ source "drivers/media/platform/omap/Kconfig"
 
 config VIDEO_ASPEED
 	tristate "Aspeed AST2400 and AST2500 Video Engine driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	select VIDEOBUF2_DMA_CONTIG
 	help
@@ -42,6 +69,7 @@ config VIDEO_ASPEED
 
 config VIDEO_SH_VOU
 	tristate "SuperH VOU video output driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV && I2C
 	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -50,6 +78,7 @@ config VIDEO_SH_VOU
 
 config VIDEO_VIU
 	tristate "Freescale VIU Video Driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && (PPC_MPC512x || COMPILE_TEST) && I2C
 	select VIDEOBUF_DMA_CONTIG
 	default y
@@ -62,6 +91,7 @@ config VIDEO_VIU
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
+	depends on V4L_PLATFORM_DRIVERS
 	select MULTIPLEXER
 	depends on VIDEO_V4L2 && OF
 	select MEDIA_CONTROLLER
@@ -73,6 +103,7 @@ config VIDEO_MUX
 
 config VIDEO_OMAP3
 	tristate "OMAP 3 Camera support"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && I2C
 	depends on (ARCH_OMAP3 && OMAP_IOMMU) || COMPILE_TEST
 	depends on COMMON_CLK && OF
@@ -87,12 +118,14 @@ config VIDEO_OMAP3
 
 config VIDEO_OMAP3_DEBUG
 	bool "OMAP 3 Camera debug messages"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_OMAP3
 	help
 	  Enable debug messages on OMAP 3 camera controller driver.
 
 config VIDEO_PXA27x
 	tristate "PXA27x Quick Capture Interface driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on PXA27x || COMPILE_TEST
 	select VIDEOBUF2_DMA_SG
@@ -103,6 +136,7 @@ config VIDEO_PXA27x
 
 config VIDEO_QCOM_CAMSS
 	tristate "Qualcomm V4L2 Camera Subsystem driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
 	select MEDIA_CONTROLLER
@@ -112,6 +146,7 @@ config VIDEO_QCOM_CAMSS
 
 config VIDEO_S3C_CAMIF
 	tristate "Samsung S3C24XX/S3C64XX SoC Camera Interface driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && I2C && PM
 	depends on ARCH_S3C64XX || PLAT_S3C24XX || COMPILE_TEST
 	select MEDIA_CONTROLLER
@@ -126,6 +161,7 @@ config VIDEO_S3C_CAMIF
 
 config VIDEO_STM32_DCMI
 	tristate "STM32 Digital Camera Memory Interface (DCMI) support"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && OF
 	depends on ARCH_STM32 || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -140,6 +176,7 @@ config VIDEO_STM32_DCMI
 
 config VIDEO_RENESAS_CEU
 	tristate "Renesas Capture Engine Unit (CEU) driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_SHMOBILE || ARCH_R7S72100 || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -149,6 +186,7 @@ config VIDEO_RENESAS_CEU
 
 config VIDEO_ROCKCHIP_ISP1
 	tristate "Rockchip Image Signal Processing v1 Unit driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && OF
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select MEDIA_CONTROLLER
@@ -175,6 +213,7 @@ source "drivers/media/platform/imx/Kconfig"
 
 config VIDEO_TI_CAL
 	tristate "TI CAL (Camera Adaptation Layer) driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
@@ -187,10 +226,9 @@ config VIDEO_TI_CAL
 	  In TI Technical Reference Manual this module is referred as
 	  Camera Interface Subsystem (CAMSS).
 
-if VIDEO_TI_CAL
-
 config VIDEO_TI_CAL_MC
 	bool "Media Controller centric mode by default"
+	depends on VIDEO_TI_CAL
 	default n
 	help
 	  Enables Media Controller centric mode by default.
@@ -199,10 +237,9 @@ config VIDEO_TI_CAL_MC
 	  default. Note that this behavior can be overridden via
 	  module parameter 'mc_api'.
 
-endif # VIDEO_TI_CAL
-
 config VIDEO_RCAR_ISP
 	tristate "R-Car Image Signal Processor (ISP)"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && OF
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select MEDIA_CONTROLLER
@@ -217,21 +254,11 @@ config VIDEO_RCAR_ISP
 	  To compile this driver as a module, choose M here: the
 	  module will be called rcar-isp.
 
-endif # V4L_PLATFORM_DRIVERS
-
-menuconfig V4L_MEM2MEM_DRIVERS
-	bool "Memory-to-memory multimedia devices"
-	depends on VIDEO_V4L2
-	help
-	  Say Y here to enable selecting drivers for V4L devices that
-	  use system memory for both source and destination buffers, as opposed
-	  to capture and output drivers, which use memory buffers for just
-	  one of those.
-
-if V4L_MEM2MEM_DRIVERS
+# Mem2mem drivers
 
 config VIDEO_ALLEGRO_DVT
 	tristate "Allegro DVT Video IP Core"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	select V4L2_MEM2MEM_DEV
@@ -247,6 +274,7 @@ config VIDEO_ALLEGRO_DVT
 
 config VIDEO_CODA
 	tristate "Chips&Media Coda multi-standard codec IP"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2 && OF && (ARCH_MXC || COMPILE_TEST)
 	select SRAM
 	select VIDEOBUF2_DMA_CONTIG
@@ -263,6 +291,7 @@ config VIDEO_IMX_VDOA
 
 config VIDEO_IMX_PXP
 	tristate "i.MX Pixel Pipeline (PXP)"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2 && (ARCH_MXC || COMPILE_TEST)
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
@@ -274,6 +303,7 @@ source "drivers/media/platform/imx-jpeg/Kconfig"
 
 config VIDEO_MEDIATEK_JPEG
 	tristate "Mediatek JPEG Codec driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on MTK_IOMMU_V1 || MTK_IOMMU || COMPILE_TEST
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_MEDIATEK || COMPILE_TEST
@@ -289,6 +319,7 @@ config VIDEO_MEDIATEK_JPEG
 
 config VIDEO_MEDIATEK_VPU
 	tristate "Mediatek Video Processor Unit"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	help
@@ -302,6 +333,7 @@ config VIDEO_MEDIATEK_VPU
 
 config VIDEO_MEDIATEK_MDP
 	tristate "Mediatek MDP driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on MTK_IOMMU || COMPILE_TEST
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_MEDIATEK || COMPILE_TEST
@@ -318,6 +350,7 @@ config VIDEO_MEDIATEK_MDP
 
 config VIDEO_MEDIATEK_VCODEC
 	tristate "Mediatek Video Codec driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on MTK_IOMMU || COMPILE_TEST
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_MEDIATEK || COMPILE_TEST
@@ -353,6 +386,7 @@ config VIDEO_MEDIATEK_VCODEC_SCP
 
 config VIDEO_MEM2MEM_DEINTERLACE
 	tristate "Deinterlace support"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on HAS_DMA
 	select VIDEOBUF2_DMA_CONTIG
@@ -362,6 +396,7 @@ config VIDEO_MEM2MEM_DEINTERLACE
 
 config VIDEO_MESON_GE2D
 	tristate "Amlogic 2D Graphic Acceleration Unit"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_MESON || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -375,6 +410,7 @@ config VIDEO_MESON_GE2D
 
 config VIDEO_SAMSUNG_S5P_G2D
 	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -385,6 +421,7 @@ config VIDEO_SAMSUNG_S5P_G2D
 
 config VIDEO_SAMSUNG_S5P_JPEG
 	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -395,6 +432,7 @@ config VIDEO_SAMSUNG_S5P_JPEG
 
 config VIDEO_SAMSUNG_S5P_MFC
 	tristate "Samsung S5P MFC Video Codec"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -403,6 +441,7 @@ config VIDEO_SAMSUNG_S5P_MFC
 
 config VIDEO_MX2_EMMAPRP
 	tristate "MX2 eMMa-PrP support"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on SOC_IMX27 || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -414,6 +453,7 @@ config VIDEO_MX2_EMMAPRP
 
 config VIDEO_SAMSUNG_EXYNOS_GSC
 	tristate "Samsung Exynos G-Scaler driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -423,6 +463,7 @@ config VIDEO_SAMSUNG_EXYNOS_GSC
 
 config VIDEO_STI_BDISP
 	tristate "STMicroelectronics BDISP 2D blitter driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_STI || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -432,6 +473,7 @@ config VIDEO_STI_BDISP
 
 config VIDEO_STI_HVA
 	tristate "STMicroelectronics HVA multi-format video encoder V4L2 driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_STI || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -446,6 +488,7 @@ config VIDEO_STI_HVA
 
 config VIDEO_STI_HVA_DEBUGFS
 	bool "Export STMicroelectronics HVA internals in debugfs"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_STI_HVA
 	depends on DEBUG_FS
 	help
@@ -457,6 +500,7 @@ config VIDEO_STI_HVA_DEBUGFS
 
 config VIDEO_STI_DELTA
 	tristate "STMicroelectronics DELTA multi-format video decoder V4L2 driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_STI || COMPILE_TEST
 	help
@@ -471,11 +515,10 @@ config VIDEO_STI_DELTA
 		Please notice that the driver will only be built if
 		at least one of the DELTA decoder below is selected.
 
-if VIDEO_STI_DELTA
-
 config VIDEO_STI_DELTA_MJPEG
 	bool "STMicroelectronics DELTA MJPEG support"
 	default y
+	depends on VIDEO_STI_DELTA
 	help
 		Enables DELTA MJPEG hardware support.
 
@@ -491,10 +534,9 @@ config VIDEO_STI_DELTA_DRIVER
 	select V4L2_MEM2MEM_DEV
 	select RPMSG
 
-endif # VIDEO_STI_DELTA
-
 config VIDEO_STM32_DMA2D
 	tristate "STM32 Chrom-Art Accelerator (DMA2D)"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_STM32 || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -507,6 +549,7 @@ config VIDEO_STM32_DMA2D
 
 config VIDEO_RENESAS_FDP1
 	tristate "Renesas Fine Display Processor"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
@@ -521,6 +564,7 @@ config VIDEO_RENESAS_FDP1
 
 config VIDEO_RENESAS_JPU
 	tristate "Renesas JPEG Processing Unit"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -533,6 +577,7 @@ config VIDEO_RENESAS_JPU
 
 config VIDEO_RENESAS_FCP
 	tristate "Renesas Frame Compression Processor"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on OF
 	help
@@ -546,6 +591,7 @@ config VIDEO_RENESAS_FCP
 
 config VIDEO_RENESAS_VSP1
 	tristate "Renesas VSP1 Video Processing Engine"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
@@ -561,6 +607,7 @@ config VIDEO_RENESAS_VSP1
 
 config VIDEO_ROCKCHIP_RGA
 	tristate "Rockchip Raster 2d Graphic Acceleration Unit"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	select VIDEOBUF2_DMA_SG
@@ -575,6 +622,7 @@ config VIDEO_ROCKCHIP_RGA
 
 config VIDEO_TI_VPE
 	tristate "TI VPE (Video Processing Engine) driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on SOC_DRA7XX || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -588,12 +636,14 @@ config VIDEO_TI_VPE
 
 config VIDEO_TI_VPE_DEBUG
 	bool "VPE debug messages"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_TI_VPE
 	help
 	  Enable debug messages on VPE driver.
 
 config VIDEO_QCOM_VENUS
 	tristate "Qualcomm Venus V4L2 encoder/decoder driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2 && QCOM_SMEM
 	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
 	select QCOM_MDT_LOADER if ARCH_QCOM
@@ -608,6 +658,7 @@ config VIDEO_QCOM_VENUS
 
 config VIDEO_SUN8I_DEINTERLACE
 	tristate "Allwinner Deinterlace driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on COMMON_CLK && OF
@@ -621,6 +672,7 @@ config VIDEO_SUN8I_DEINTERLACE
 
 config VIDEO_SUN8I_ROTATE
 	tristate "Allwinner DE2 rotation driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV && VIDEO_V4L2
 	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on COMMON_CLK && OF
@@ -633,6 +685,7 @@ config VIDEO_SUN8I_ROTATE
 
 config VIDEO_TEGRA_VDE
 	tristate "NVIDIA Tegra Video Decoder Engine driver"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on VIDEO_DEV && VIDEO_V4L2
 	select DMA_SHARED_BUFFER
@@ -650,6 +703,7 @@ config VIDEO_TEGRA_VDE
 
 config VIDEO_AMPHION_VPU
 	tristate "Amphion VPU (Video Processing Unit) Codec IP"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on MEDIA_SUPPORT
 	depends on VIDEO_DEV
@@ -667,8 +721,6 @@ config VIDEO_AMPHION_VPU
 	  various NXP SoCs.
 	  To compile this driver as a module choose m here.
 
-endif # V4L_MEM2MEM_DRIVERS
-
 # TI VIDEO PORT Helper Modules
 # These will be selected by VPE and VIP
 config VIDEO_TI_VPDMA
@@ -680,26 +732,13 @@ config VIDEO_TI_SC
 config VIDEO_TI_CSC
 	tristate
 
-menuconfig DVB_PLATFORM_DRIVERS
-	bool "DVB platform devices"
-	depends on MEDIA_DIGITAL_TV_SUPPORT
-	help
-	  Say Y here to enable support for platform-specific Digital TV drivers.
-
-if DVB_PLATFORM_DRIVERS
+# DVB platform drivers
 source "drivers/media/platform/sti/c8sectpfe/Kconfig"
-endif #DVB_PLATFORM_DRIVERS
-
-menuconfig SDR_PLATFORM_DRIVERS
-	bool "SDR platform devices"
-	depends on MEDIA_SDR_SUPPORT
-	help
-	  Say Y here to enable support for platform-specific SDR Drivers.
-
-if SDR_PLATFORM_DRIVERS
 
+# SDR platform drivers
 config VIDEO_RCAR_DRIF
 	tristate "Renesas Digital Radio Interface (DRIF)"
+	depends on SDR_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select VIDEOBUF2_VMALLOC
@@ -713,4 +752,4 @@ config VIDEO_RCAR_DRIF
 	  To compile this driver as a module, choose M here; the module
 	  will be called rcar_drif.
 
-endif # SDR_PLATFORM_DRIVERS
+endif #MEDIA_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/am437x/Kconfig b/drivers/media/platform/am437x/Kconfig
index 9ef898f512de..619cefca7590 100644
--- a/drivers/media/platform/am437x/Kconfig
+++ b/drivers/media/platform/am437x/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_AM437X_VPFE
 	tristate "TI AM437x VPFE video capture driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on SOC_AM43XX || COMPILE_TEST
 	select MEDIA_CONTROLLER
diff --git a/drivers/media/platform/atmel/Kconfig b/drivers/media/platform/atmel/Kconfig
index f83bee373d82..5122290729ae 100644
--- a/drivers/media/platform/atmel/Kconfig
+++ b/drivers/media/platform/atmel/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_ATMEL_ISC
 	tristate "ATMEL Image Sensor Controller (ISC) support"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && COMMON_CLK
 	depends on ARCH_AT91 || COMPILE_TEST
 	select MEDIA_CONTROLLER
@@ -15,6 +16,7 @@ config VIDEO_ATMEL_ISC
 
 config VIDEO_ATMEL_XISC
 	tristate "ATMEL eXtended Image Sensor Controller (XISC) support"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && COMMON_CLK && VIDEO_V4L2_SUBDEV_API
 	depends on ARCH_AT91 || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -33,6 +35,7 @@ config VIDEO_ATMEL_ISC_BASE
 
 config VIDEO_ATMEL_ISI
 	tristate "ATMEL Image Sensor Interface (ISI) support"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && OF
 	depends on ARCH_AT91 || COMPILE_TEST
 	select VIDEOBUF2_DMA_CONTIG
@@ -43,6 +46,7 @@ config VIDEO_ATMEL_ISI
 
 config VIDEO_MICROCHIP_CSI2DC
 	tristate "Microchip CSI2 Demux Controller"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && COMMON_CLK && OF
 	depends on ARCH_AT91 || COMPILE_TEST
 	select MEDIA_CONTROLLER
diff --git a/drivers/media/platform/cadence/Kconfig b/drivers/media/platform/cadence/Kconfig
index 80cf601323ce..79a7e9fb2575 100644
--- a/drivers/media/platform/cadence/Kconfig
+++ b/drivers/media/platform/cadence/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_CADENCE
 	bool "Cadence Video Devices"
+	depends on V4L_PLATFORM_DRIVERS
 	help
 	  If you have a media device designed by Cadence, say Y.
 
diff --git a/drivers/media/platform/davinci/Kconfig b/drivers/media/platform/davinci/Kconfig
index 9d2a9eeb3499..7e5f92b0082a 100644
--- a/drivers/media/platform/davinci/Kconfig
+++ b/drivers/media/platform/davinci/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_DAVINCI_VPIF_DISPLAY
 	tristate "TI DaVinci VPIF V4L2-Display driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on I2C
@@ -17,6 +18,7 @@ config VIDEO_DAVINCI_VPIF_DISPLAY
 
 config VIDEO_DAVINCI_VPIF_CAPTURE
 	tristate "TI DaVinci VPIF video capture driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on I2C
@@ -32,6 +34,7 @@ config VIDEO_DAVINCI_VPIF_CAPTURE
 
 config VIDEO_DM6446_CCDC
 	tristate "TI DM6446 CCDC video capture driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on I2C
@@ -48,6 +51,7 @@ config VIDEO_DM6446_CCDC
 
 config VIDEO_DM355_CCDC
 	tristate "TI DM355 CCDC video capture driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on I2C
@@ -64,6 +68,7 @@ config VIDEO_DM355_CCDC
 
 config VIDEO_DM365_ISIF
 	tristate "TI DM365 ISIF video capture driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on I2C
@@ -78,6 +83,7 @@ config VIDEO_DM365_ISIF
 
 config VIDEO_DAVINCI_VPBE_DISPLAY
 	tristate "TI DaVinci VPBE V4L2-Display driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2
 	depends on ARCH_DAVINCI || COMPILE_TEST
 	depends on I2C
diff --git a/drivers/media/platform/exynos4-is/Kconfig b/drivers/media/platform/exynos4-is/Kconfig
index 136d3b2a0fbb..868bb86c7699 100644
--- a/drivers/media/platform/exynos4-is/Kconfig
+++ b/drivers/media/platform/exynos4-is/Kconfig
@@ -2,6 +2,7 @@
 
 config VIDEO_SAMSUNG_EXYNOS4_IS
 	tristate "Samsung S5P/EXYNOS4 SoC series Camera Subsystem driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && OF && COMMON_CLK
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	select MEDIA_CONTROLLER
diff --git a/drivers/media/platform/imx-jpeg/Kconfig b/drivers/media/platform/imx-jpeg/Kconfig
index 2fdd648cda80..cbf6101a8b1d 100644
--- a/drivers/media/platform/imx-jpeg/Kconfig
+++ b/drivers/media/platform/imx-jpeg/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config VIDEO_IMX8_JPEG
 	tristate "IMX8 JPEG Encoder/Decoder"
+	depends on V4L_MEM2MEM_DRIVERS
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on VIDEO_DEV && VIDEO_V4L2
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/platform/imx/Kconfig b/drivers/media/platform/imx/Kconfig
index 683863572c20..7cd0617c9b1b 100644
--- a/drivers/media/platform/imx/Kconfig
+++ b/drivers/media/platform/imx/Kconfig
@@ -2,6 +2,7 @@
 
 menuconfig VIDEO_IMX
 	bool "V4L2 capture drivers for NXP i.MX devices"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on VIDEO_DEV && VIDEO_V4L2
 	help
diff --git a/drivers/media/platform/marvell-ccic/Kconfig b/drivers/media/platform/marvell-ccic/Kconfig
index 3e3f86264762..bfe655b2cedd 100644
--- a/drivers/media/platform/marvell-ccic/Kconfig
+++ b/drivers/media/platform/marvell-ccic/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_CAFE_CCIC
 	tristate "Marvell 88ALP01 (Cafe) CMOS Camera Controller support"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on PCI && I2C && VIDEO_V4L2
 	depends on COMMON_CLK
 	select VIDEO_OV7670
@@ -14,6 +15,7 @@ config VIDEO_CAFE_CCIC
 
 config VIDEO_MMP_CAMERA
 	tristate "Marvell Armada 610 integrated camera controller support"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on I2C && VIDEO_V4L2
 	depends on ARCH_MMP || COMPILE_TEST
 	depends on COMMON_CLK
diff --git a/drivers/media/platform/omap/Kconfig b/drivers/media/platform/omap/Kconfig
index de16de46c0f4..789d5e5686c7 100644
--- a/drivers/media/platform/omap/Kconfig
+++ b/drivers/media/platform/omap/Kconfig
@@ -6,6 +6,7 @@ config VIDEO_OMAP2_VOUT_VRFB
 
 config VIDEO_OMAP2_VOUT
 	tristate "OMAP2/OMAP3 V4L2-Display driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on MMU
 	depends on FB_OMAP2 || (COMPILE_TEST && FB_OMAP2=n)
 	depends on ARCH_OMAP2 || ARCH_OMAP3 || COMPILE_TEST
diff --git a/drivers/media/platform/rcar-vin/Kconfig b/drivers/media/platform/rcar-vin/Kconfig
index 030312d862e7..34b7ea6f1246 100644
--- a/drivers/media/platform/rcar-vin/Kconfig
+++ b/drivers/media/platform/rcar-vin/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config VIDEO_RCAR_CSI2
 	tristate "R-Car MIPI CSI-2 Receiver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && OF
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select MEDIA_CONTROLLER
@@ -16,6 +17,7 @@ config VIDEO_RCAR_CSI2
 
 config VIDEO_RCAR_VIN
 	tristate "R-Car Video Input (VIN) Driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && OF
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select MEDIA_CONTROLLER
diff --git a/drivers/media/platform/sti/c8sectpfe/Kconfig b/drivers/media/platform/sti/c8sectpfe/Kconfig
index 369509e03071..702b910509c9 100644
--- a/drivers/media/platform/sti/c8sectpfe/Kconfig
+++ b/drivers/media/platform/sti/c8sectpfe/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config DVB_C8SECTPFE
 	tristate "STMicroelectronics C8SECTPFE DVB support"
+	depends on DVB_PLATFORM_DRIVERS
 	depends on PINCTRL && DVB_CORE && I2C
 	depends on ARCH_STI || ARCH_MULTIPLATFORM || COMPILE_TEST
 	select FW_LOADER
diff --git a/drivers/media/platform/sunxi/sun4i-csi/Kconfig b/drivers/media/platform/sunxi/sun4i-csi/Kconfig
index 903c6152f6e8..43ad2dd7da5d 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/Kconfig
+++ b/drivers/media/platform/sunxi/sun4i-csi/Kconfig
@@ -2,6 +2,7 @@
 
 config VIDEO_SUN4I_CSI
 	tristate "Allwinner A10 CMOS Sensor Interface Support"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select MEDIA_CONTROLLER
diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
index 586e3fb3a80d..6d9cf1963c41 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
+++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_SUN6I_CSI
 	tristate "Allwinner V3s Camera Sensor Interface driver"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
 	depends on ARCH_SUNXI || COMPILE_TEST
 	select MEDIA_CONTROLLER
diff --git a/drivers/media/platform/xilinx/Kconfig b/drivers/media/platform/xilinx/Kconfig
index 44587dccacf1..a9531d5efd50 100644
--- a/drivers/media/platform/xilinx/Kconfig
+++ b/drivers/media/platform/xilinx/Kconfig
@@ -2,6 +2,7 @@
 
 config VIDEO_XILINX
 	tristate "Xilinx Video IP (EXPERIMENTAL)"
+	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_V4L2  && OF && HAS_DMA
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
-- 
2.35.1

