Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD874D62F1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349153AbiCKOJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349067AbiCKOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:09:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19FE673C8;
        Fri, 11 Mar 2022 06:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E82A61EB2;
        Fri, 11 Mar 2022 14:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B49C340FB;
        Fri, 11 Mar 2022 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007676;
        bh=5cJF4zGe71Z13BaIcRWU12MMzz6/FmuS/leyIbj+2FQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TH930+LRxNLshQQnDyCGecrSO56f9nkTFukRDg1yfnk0YNnjKhrDDe1/+kUm+LQ4I
         cd/o07a4S4dBpghHy8qTmQG8kLPrA7I1WfDJdTBmjCRI09WluF9MXGQSzCN5E8n7IH
         bdFAz1bBhLq8bIGphiS8UpIPh+A7iAX2Pme3uGJNVYAYs4ULVqLOrCFiY9eneK43Qq
         R3ropPvgfM1ZTS9QG7O4zKH/o2kR/0FzjnLHoeEmqpm2sYwxEN0qNswFoilwEHqgvB
         nDZMAB4Rt0LQXoiui8znA8cKSyrivUAVvyAG+utG0LewfGfuRWkxuX9AwaE5Xz3LAW
         /Ifa7wMnaKDwg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfvu-000lBA-3m; Fri, 11 Mar 2022 15:07:54 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Herman <herman.yim88@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
        Ming Qian <ming.qian@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 10/38] media: platform: place Renesas drivers on a separate dir
Date:   Fri, 11 Mar 2022 15:07:23 +0100
Message-Id: <b7e9058b5caac542eb06b5ae313d72218ff848e3.1647006877.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647006877.git.mchehab@kernel.org>
References: <cover.1647006877.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In order to cleanup the main platform media directory, move Renesas
driver to its own directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 MAINTAINERS                                   |  16 +--
 drivers/media/platform/Kconfig                | 113 +----------------
 drivers/media/platform/Makefile               |   9 +-
 drivers/media/platform/renesas/Kconfig        | 119 ++++++++++++++++++
 drivers/media/platform/renesas/Makefile       |  14 +++
 .../media/platform/{ => renesas}/rcar-fcp.c   |   0
 .../media/platform/{ => renesas}/rcar-isp.c   |   0
 .../platform/{ => renesas}/rcar-vin/Kconfig   |   0
 .../platform/{ => renesas}/rcar-vin/Makefile  |   0
 .../{ => renesas}/rcar-vin/rcar-core.c        |   0
 .../{ => renesas}/rcar-vin/rcar-csi2.c        |   0
 .../{ => renesas}/rcar-vin/rcar-dma.c         |   0
 .../{ => renesas}/rcar-vin/rcar-v4l2.c        |   0
 .../{ => renesas}/rcar-vin/rcar-vin.h         |   0
 .../media/platform/{ => renesas}/rcar_drif.c  |   0
 .../media/platform/{ => renesas}/rcar_fdp1.c  |   0
 .../media/platform/{ => renesas}/rcar_jpu.c   |   0
 .../platform/{ => renesas}/renesas-ceu.c      |   0
 drivers/media/platform/{ => renesas}/sh_vou.c |   0
 19 files changed, 144 insertions(+), 127 deletions(-)
 create mode 100644 drivers/media/platform/renesas/Kconfig
 create mode 100644 drivers/media/platform/renesas/Makefile
 rename drivers/media/platform/{ => renesas}/rcar-fcp.c (100%)
 rename drivers/media/platform/{ => renesas}/rcar-isp.c (100%)
 rename drivers/media/platform/{ => renesas}/rcar-vin/Kconfig (100%)
 rename drivers/media/platform/{ => renesas}/rcar-vin/Makefile (100%)
 rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-core.c (100%)
 rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-csi2.c (100%)
 rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-dma.c (100%)
 rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-v4l2.c (100%)
 rename drivers/media/platform/{ => renesas}/rcar-vin/rcar-vin.h (100%)
 rename drivers/media/platform/{ => renesas}/rcar_drif.c (100%)
 rename drivers/media/platform/{ => renesas}/rcar_fdp1.c (100%)
 rename drivers/media/platform/{ => renesas}/rcar_jpu.c (100%)
 rename drivers/media/platform/{ => renesas}/renesas-ceu.c (100%)
 rename drivers/media/platform/{ => renesas}/sh_vou.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 780ef2ef3362..5a5cc49e27a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10322,7 +10322,7 @@ M:	Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
 L:	linux-media@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
-F:	drivers/media/platform/rcar_jpu.c
+F:	drivers/media/platform/renesas/rcar_jpu.c
 
 JSM Neo PCI based serial card
 L:	linux-serial@vger.kernel.org
@@ -11973,7 +11973,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/renesas,ceu.yaml
-F:	drivers/media/platform/renesas-ceu.c
+F:	drivers/media/platform/renesas/renesas-ceu.c
 F:	include/media/drv-intf/renesas-ceu.h
 
 MEDIA DRIVERS FOR RENESAS - DRIF
@@ -11983,7 +11983,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/renesas,drif.yaml
-F:	drivers/media/platform/rcar_drif.c
+F:	drivers/media/platform/renesas/rcar_drif.c
 
 MEDIA DRIVERS FOR RENESAS - FCP
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
@@ -11992,7 +11992,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/renesas,fcp.yaml
-F:	drivers/media/platform/rcar-fcp.c
+F:	drivers/media/platform/renesas/rcar-fcp.c
 F:	include/media/rcar-fcp.h
 
 MEDIA DRIVERS FOR RENESAS - FDP1
@@ -12002,7 +12002,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/renesas,fdp1.yaml
-F:	drivers/media/platform/rcar_fdp1.c
+F:	drivers/media/platform/renesas/rcar_fdp1.c
 
 MEDIA DRIVERS FOR RENESAS - VIN
 M:	Niklas Söderlund <niklas.soderlund@ragnatech.se>
@@ -12013,8 +12013,8 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/renesas,csi2.yaml
 F:	Documentation/devicetree/bindings/media/renesas,isp.yaml
 F:	Documentation/devicetree/bindings/media/renesas,vin.yaml
-F:	drivers/media/platform/rcar-isp.c
-F:	drivers/media/platform/rcar-vin/
+F:	drivers/media/platform/renesas/rcar-isp.c
+F:	drivers/media/platform/renesas/rcar-vin/
 
 MEDIA DRIVERS FOR RENESAS - VSP1
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
@@ -17536,7 +17536,7 @@ F:	include/media/i2c/rj54n1cb0c.h
 SH_VOU V4L2 OUTPUT DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-F:	drivers/media/platform/sh_vou.c
+F:	drivers/media/platform/renesas/sh_vou.c
 F:	include/media/drv-intf/sh_vou.h
 
 SI2157 MEDIA DRIVER
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index d6751282087a..87ef4fb68bdf 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -38,6 +38,8 @@ config V4L_MEM2MEM_DRIVERS
 
 source "drivers/media/platform/nxp/Kconfig"
 
+source "drivers/media/platform/renesas/Kconfig"
+
 # V4L platform drivers
 
 source "drivers/media/platform/marvell-ccic/Kconfig"
@@ -52,15 +54,6 @@ source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
 
-config VIDEO_SH_VOU
-	tristate "SuperH VOU video output driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && I2C
-	depends on ARCH_SHMOBILE || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	help
-	  Support for the Video Output Unit (VOU) on SuperH SoCs.
-
 config VIDEO_MUX
 	tristate "Video Multiplexer"
 	depends on V4L_PLATFORM_DRIVERS
@@ -137,16 +130,6 @@ config VIDEO_STM32_DCMI
 	  To compile this driver as a module, choose M here: the module
 	  will be called stm32-dcmi.
 
-config VIDEO_RENESAS_CEU
-	tristate "Renesas Capture Engine Unit (CEU) driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_SHMOBILE || ARCH_R7S72100 || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_FWNODE
-	help
-	  This is a v4l2 driver for the Renesas CEU Interface
-
 config VIDEO_ROCKCHIP_ISP1
 	tristate "Rockchip Image Signal Processing v1 Unit driver"
 	depends on V4L_PLATFORM_DRIVERS
@@ -169,7 +152,6 @@ config VIDEO_ROCKCHIP_ISP1
 source "drivers/media/platform/exynos4-is/Kconfig"
 source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
-source "drivers/media/platform/rcar-vin/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/sunxi/Kconfig"
 source "drivers/media/platform/imx/Kconfig"
@@ -200,22 +182,6 @@ config VIDEO_TI_CAL_MC
 	  default. Note that this behavior can be overridden via
 	  module parameter 'mc_api'.
 
-config VIDEO_RCAR_ISP
-	tristate "R-Car Image Signal Processor (ISP)"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2 && OF
-	depends on ARCH_RENESAS || COMPILE_TEST
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select RESET_CONTROLLER
-	select V4L2_FWNODE
-	help
-	  Support for Renesas R-Car Image Signal Processor (ISP).
-	  Enable this to support the Renesas R-Car Image Signal
-	  Processor (ISP).
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called rcar-isp.
 
 # Mem2mem drivers
 
@@ -488,64 +454,6 @@ config VIDEO_STM32_DMA2D
 	  The STM32 DMA2D is a memory-to-memory engine for pixel conversion
 	  and specialized DMA dedicated to image manipulation.
 
-config VIDEO_RENESAS_FDP1
-	tristate "Renesas Fine Display Processor"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This is a V4L2 driver for the Renesas Fine Display Processor
-	  providing colour space conversion, and de-interlacing features.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called rcar_fdp1.
-
-config VIDEO_RENESAS_JPU
-	tristate "Renesas JPEG Processing Unit"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_RENESAS || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This is a V4L2 driver for the Renesas JPEG Processing Unit.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called rcar_jpu.
-
-config VIDEO_RENESAS_FCP
-	tristate "Renesas Frame Compression Processor"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on OF
-	help
-	  This is a driver for the Renesas Frame Compression Processor (FCP).
-	  The FCP is a companion module of video processing modules in the
-	  Renesas R-Car Gen3 and RZ/G2 SoCs. It handles memory access for
-	  the codec, VSP and FDP modules.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called rcar-fcp.
-
-config VIDEO_RENESAS_VSP1
-	tristate "Renesas VSP1 Video Processing Engine"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_V4L2
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEOBUF2_DMA_CONTIG
-	select VIDEOBUF2_VMALLOC
-	help
-	  This is a V4L2 driver for the Renesas VSP1 video processing engine.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called vsp1.
-
 config VIDEO_ROCKCHIP_RGA
 	tristate "Rockchip Raster 2d Graphic Acceleration Unit"
 	depends on V4L_MEM2MEM_DRIVERS
@@ -676,21 +584,4 @@ config VIDEO_TI_CSC
 # DVB platform drivers
 source "drivers/media/platform/sti/c8sectpfe/Kconfig"
 
-# SDR platform drivers
-config VIDEO_RCAR_DRIF
-	tristate "Renesas Digital Radio Interface (DRIF)"
-	depends on SDR_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2
-	depends on ARCH_RENESAS || COMPILE_TEST
-	select VIDEOBUF2_VMALLOC
-	select V4L2_ASYNC
-	help
-	  Say Y if you want to enable R-Car Gen3 DRIF support. DRIF is Digital
-	  Radio Interface that interfaces with an RF front end chip. It is a
-	  receiver of digital data which uses DMA to transfer received data to
-	  a configured location for an application to use.
-
-	  To compile this driver as a module, choose M here; the module
-	  will be called rcar_drif.
-
 endif #MEDIA_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 6783b374dc80..1a6c41e6e261 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -28,7 +28,7 @@ obj-y += omap/
 obj-y += omap3isp/
 obj-y += qcom/camss/
 obj-y += qcom/venus/
-obj-y += rcar-vin/
+obj-y += renesas/
 obj-y += rockchip/rga/
 obj-y += rockchip/rkisp1/
 obj-y += s3c-camif/
@@ -50,10 +50,3 @@ obj-y += xilinx/
 # Please place here only ancillary drivers that aren't SoC-specific
 obj-$(CONFIG_VIDEO_MEM2MEM_DEINTERLACE)	+= m2m-deinterlace.o
 obj-$(CONFIG_VIDEO_MUX)			+= video-mux.o
-obj-$(CONFIG_VIDEO_RCAR_DRIF)		+= rcar_drif.o
-obj-$(CONFIG_VIDEO_RCAR_ISP)		+= rcar-isp.o
-obj-$(CONFIG_VIDEO_RENESAS_CEU)		+= renesas-ceu.o
-obj-$(CONFIG_VIDEO_RENESAS_FCP)		+= rcar-fcp.o
-obj-$(CONFIG_VIDEO_RENESAS_FDP1)	+= rcar_fdp1.o
-obj-$(CONFIG_VIDEO_RENESAS_JPU)		+= rcar_jpu.o
-obj-$(CONFIG_VIDEO_SH_VOU)		+= sh_vou.o
diff --git a/drivers/media/platform/renesas/Kconfig b/drivers/media/platform/renesas/Kconfig
new file mode 100644
index 000000000000..e1329a60d3fa
--- /dev/null
+++ b/drivers/media/platform/renesas/Kconfig
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# V4L drivers
+
+config VIDEO_RENESAS_CEU
+	tristate "Renesas Capture Engine Unit (CEU) driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_SHMOBILE || ARCH_R7S72100 || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	  This is a v4l2 driver for the Renesas CEU Interface
+
+config VIDEO_RCAR_ISP
+	tristate "R-Car Image Signal Processor (ISP)"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2 && OF
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select RESET_CONTROLLER
+	select V4L2_FWNODE
+	help
+	  Support for Renesas R-Car Image Signal Processor (ISP).
+	  Enable this to support the Renesas R-Car Image Signal
+	  Processor (ISP).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rcar-isp.
+
+config VIDEO_SH_VOU
+	tristate "SuperH VOU video output driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_DEV && I2C
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	help
+	  Support for the Video Output Unit (VOU) on SuperH SoCs.
+
+source "drivers/media/platform/renesas/rcar-vin/Kconfig"
+
+# Mem2mem drivers
+
+config VIDEO_RENESAS_FDP1
+	tristate "Renesas Fine Display Processor"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a V4L2 driver for the Renesas Fine Display Processor
+	  providing colour space conversion, and de-interlacing features.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called rcar_fdp1.
+
+config VIDEO_RENESAS_JPU
+	tristate "Renesas JPEG Processing Unit"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a V4L2 driver for the Renesas JPEG Processing Unit.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called rcar_jpu.
+
+config VIDEO_RENESAS_FCP
+	tristate "Renesas Frame Compression Processor"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on OF
+	help
+	  This is a driver for the Renesas Frame Compression Processor (FCP).
+	  The FCP is a companion module of video processing modules in the
+	  Renesas R-Car Gen3 and RZ/G2 SoCs. It handles memory access for
+	  the codec, VSP and FDP modules.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called rcar-fcp.
+
+config VIDEO_RENESAS_VSP1
+	tristate "Renesas VSP1 Video Processing Engine"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_V4L2
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on (!ARM64 && !VIDEO_RENESAS_FCP) || VIDEO_RENESAS_FCP
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	help
+	  This is a V4L2 driver for the Renesas VSP1 video processing engine.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called vsp1.
+
+# SDR drivers
+
+config VIDEO_RCAR_DRIF
+	tristate "Renesas Digital Radio Interface (DRIF)"
+	depends on SDR_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select VIDEOBUF2_VMALLOC
+	select V4L2_ASYNC
+	help
+	  Say Y if you want to enable R-Car Gen3 DRIF support. DRIF is Digital
+	  Radio Interface that interfaces with an RF front end chip. It is a
+	  receiver of digital data which uses DMA to transfer received data to
+	  a configured location for an application to use.
+
+	  To compile this driver as a module, choose M here; the module
+	  will be called rcar_drif.
diff --git a/drivers/media/platform/renesas/Makefile b/drivers/media/platform/renesas/Makefile
new file mode 100644
index 000000000000..fd2e0c5a8953
--- /dev/null
+++ b/drivers/media/platform/renesas/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Renesas capture/playback device drivers.
+#
+
+obj-y += rcar-vin/
+
+obj-$(CONFIG_VIDEO_RCAR_DRIF)		+= rcar_drif.o
+obj-$(CONFIG_VIDEO_RCAR_ISP)		+= rcar-isp.o
+obj-$(CONFIG_VIDEO_RENESAS_CEU)		+= renesas-ceu.o
+obj-$(CONFIG_VIDEO_RENESAS_FCP)		+= rcar-fcp.o
+obj-$(CONFIG_VIDEO_RENESAS_FDP1)	+= rcar_fdp1.o
+obj-$(CONFIG_VIDEO_RENESAS_JPU)		+= rcar_jpu.o
+obj-$(CONFIG_VIDEO_SH_VOU)		+= sh_vou.o
diff --git a/drivers/media/platform/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
similarity index 100%
rename from drivers/media/platform/rcar-fcp.c
rename to drivers/media/platform/renesas/rcar-fcp.c
diff --git a/drivers/media/platform/rcar-isp.c b/drivers/media/platform/renesas/rcar-isp.c
similarity index 100%
rename from drivers/media/platform/rcar-isp.c
rename to drivers/media/platform/renesas/rcar-isp.c
diff --git a/drivers/media/platform/rcar-vin/Kconfig b/drivers/media/platform/renesas/rcar-vin/Kconfig
similarity index 100%
rename from drivers/media/platform/rcar-vin/Kconfig
rename to drivers/media/platform/renesas/rcar-vin/Kconfig
diff --git a/drivers/media/platform/rcar-vin/Makefile b/drivers/media/platform/renesas/rcar-vin/Makefile
similarity index 100%
rename from drivers/media/platform/rcar-vin/Makefile
rename to drivers/media/platform/renesas/rcar-vin/Makefile
diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/renesas/rcar-vin/rcar-core.c
similarity index 100%
rename from drivers/media/platform/rcar-vin/rcar-core.c
rename to drivers/media/platform/renesas/rcar-vin/rcar-core.c
diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
similarity index 100%
rename from drivers/media/platform/rcar-vin/rcar-csi2.c
rename to drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
similarity index 100%
rename from drivers/media/platform/rcar-vin/rcar-dma.c
rename to drivers/media/platform/renesas/rcar-vin/rcar-dma.c
diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
similarity index 100%
rename from drivers/media/platform/rcar-vin/rcar-v4l2.c
rename to drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
diff --git a/drivers/media/platform/rcar-vin/rcar-vin.h b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
similarity index 100%
rename from drivers/media/platform/rcar-vin/rcar-vin.h
rename to drivers/media/platform/renesas/rcar-vin/rcar-vin.h
diff --git a/drivers/media/platform/rcar_drif.c b/drivers/media/platform/renesas/rcar_drif.c
similarity index 100%
rename from drivers/media/platform/rcar_drif.c
rename to drivers/media/platform/renesas/rcar_drif.c
diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/renesas/rcar_fdp1.c
similarity index 100%
rename from drivers/media/platform/rcar_fdp1.c
rename to drivers/media/platform/renesas/rcar_fdp1.c
diff --git a/drivers/media/platform/rcar_jpu.c b/drivers/media/platform/renesas/rcar_jpu.c
similarity index 100%
rename from drivers/media/platform/rcar_jpu.c
rename to drivers/media/platform/renesas/rcar_jpu.c
diff --git a/drivers/media/platform/renesas-ceu.c b/drivers/media/platform/renesas/renesas-ceu.c
similarity index 100%
rename from drivers/media/platform/renesas-ceu.c
rename to drivers/media/platform/renesas/renesas-ceu.c
diff --git a/drivers/media/platform/sh_vou.c b/drivers/media/platform/renesas/sh_vou.c
similarity index 100%
rename from drivers/media/platform/sh_vou.c
rename to drivers/media/platform/renesas/sh_vou.c
-- 
2.35.1

