Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E444D7C76
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbiCNH5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiCNH5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6764241316;
        Mon, 14 Mar 2022 00:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7308B80D26;
        Mon, 14 Mar 2022 07:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B94C340F9;
        Mon, 14 Mar 2022 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=gCY6DeOD7tIAL1xAGYlvKwLzO3GNjzbI3uQICgso1GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHUFOqDZYbL0XjZnOJlVuyDBkZVMfRQWU0cmfJO7kcgdvi9nqrtS8wUHhNOYUPFHD
         MXT6hGaG5ZhNgF/GSZjALRx8UXkxWEPwWubHcrtB5jGPESVw2n3g26R2tnz64CbREw
         Gld7H3WtXk0vgzzdPaltlZyhrJnCPGX/0fLMW6ETMsT2aAk6k9LJ7JyQ/wRhU0jGz9
         2jfT2Ti0hUsl6ht/GP5GCgLwOUaaOgm47noiEBYXo3rZxD03Nbfyox7tO7idDZ3cuG
         iQFtN290y5rBuHrxVbkQ4kEdAuVjbpO0cFtCT6QsG8wM833coPth6yt/50er3m/9p5
         Omc/eAAet2xMw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYc-001kUd-Kb; Mon, 14 Mar 2022 08:55:58 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 07/64] media: platform: place NXP drivers on a separate dir
Date:   Mon, 14 Mar 2022 08:54:59 +0100
Message-Id: <92c02beaa7918253ca0d537e4454b839def2ab38.1647242579.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647242578.git.mchehab@kernel.org>
References: <cover.1647242578.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to cleanup the main platform media directory, move NXP
drivers to their own directory.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 MAINTAINERS                                   |  2 +-
 drivers/media/platform/Kconfig                | 40 +----------
 drivers/media/platform/Makefile               |  6 +-
 drivers/media/platform/imx/Kconfig            | 25 -------
 drivers/media/platform/imx/Makefile           |  1 -
 drivers/media/platform/nxp/Kconfig            | 66 +++++++++++++++++++
 drivers/media/platform/nxp/Makefile           |  8 +++
 drivers/media/platform/{ => nxp}/fsl-viu.c    |  0
 .../media/platform/{ => nxp}/imx-jpeg/Kconfig |  0
 .../platform/{ => nxp}/imx-jpeg/Makefile      |  0
 .../platform/{ => nxp}/imx-jpeg/mxc-jpeg-hw.c |  0
 .../platform/{ => nxp}/imx-jpeg/mxc-jpeg-hw.h |  0
 .../platform/{ => nxp}/imx-jpeg/mxc-jpeg.c    |  0
 .../platform/{ => nxp}/imx-jpeg/mxc-jpeg.h    |  0
 .../platform/{imx => nxp}/imx-mipi-csis.c     |  0
 drivers/media/platform/{ => nxp}/imx-pxp.c    |  0
 drivers/media/platform/{ => nxp}/imx-pxp.h    |  0
 .../media/platform/{ => nxp}/mx2_emmaprp.c    |  0
 18 files changed, 78 insertions(+), 70 deletions(-)
 delete mode 100644 drivers/media/platform/imx/Kconfig
 delete mode 100644 drivers/media/platform/imx/Makefile
 create mode 100644 drivers/media/platform/nxp/Kconfig
 create mode 100644 drivers/media/platform/nxp/Makefile
 rename drivers/media/platform/{ => nxp}/fsl-viu.c (100%)
 rename drivers/media/platform/{ => nxp}/imx-jpeg/Kconfig (100%)
 rename drivers/media/platform/{ => nxp}/imx-jpeg/Makefile (100%)
 rename drivers/media/platform/{ => nxp}/imx-jpeg/mxc-jpeg-hw.c (100%)
 rename drivers/media/platform/{ => nxp}/imx-jpeg/mxc-jpeg-hw.h (100%)
 rename drivers/media/platform/{ => nxp}/imx-jpeg/mxc-jpeg.c (100%)
 rename drivers/media/platform/{ => nxp}/imx-jpeg/mxc-jpeg.h (100%)
 rename drivers/media/platform/{imx => nxp}/imx-mipi-csis.c (100%)
 rename drivers/media/platform/{ => nxp}/imx-pxp.c (100%)
 rename drivers/media/platform/{ => nxp}/imx-pxp.h (100%)
 rename drivers/media/platform/{ => nxp}/mx2_emmaprp.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b6f48a660de..780ef2ef3362 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11841,7 +11841,7 @@ M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
-F:	drivers/media/platform/imx-pxp.[ch]
+F:	drivers/media/platform/nxp/imx-pxp.[ch]
 
 MEDIA DRIVERS FOR ASCOT2E
 M:	Sergey Kozlov <serjk@netup.ru>
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 10f453ff2717..711b6ab9370b 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -29,6 +29,8 @@ config V4L_MEM2MEM_DRIVERS
 	  to capture and output drivers, which use memory buffers for just
 	  one of those.
 
+source "drivers/media/platform/nxp/Kconfig"
+
 # V4L platform drivers
 
 source "drivers/media/platform/marvell-ccic/Kconfig"
@@ -61,19 +63,6 @@ config VIDEO_SH_VOU
 	help
 	  Support for the Video Output Unit (VOU) on SuperH SoCs.
 
-config VIDEO_VIU
-	tristate "Freescale VIU Video Driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2 && (PPC_MPC512x || COMPILE_TEST) && I2C
-	select VIDEOBUF_DMA_CONTIG
-	default y
-	help
-	  Support for Freescale VIU video driver. This device captures
-	  video data, or overlays video on DIU frame buffer.
-
-	  Say Y here if you want to enable VIU device on MPC5121e Rev2+.
-	  In doubt, say N.
-
 config VIDEO_MUX
 	tristate "Video Multiplexer"
 	depends on V4L_PLATFORM_DRIVERS
@@ -193,7 +182,6 @@ source "drivers/media/platform/xilinx/Kconfig"
 source "drivers/media/platform/rcar-vin/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/sunxi/Kconfig"
-source "drivers/media/platform/imx/Kconfig"
 
 config VIDEO_TI_CAL
 	tristate "TI CAL (Camera Adaptation Layer) driver"
@@ -273,18 +261,6 @@ config VIDEO_CODA
 config VIDEO_IMX_VDOA
 	def_tristate VIDEO_CODA if SOC_IMX6Q || COMPILE_TEST
 
-config VIDEO_IMX_PXP
-	tristate "i.MX Pixel Pipeline (PXP)"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2 && (ARCH_MXC || COMPILE_TEST)
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  The i.MX Pixel Pipeline is a memory-to-memory engine for scaling,
-	  color space conversion, and rotation.
-
-source "drivers/media/platform/imx-jpeg/Kconfig"
-
 config VIDEO_MEDIATEK_JPEG
 	tristate "Mediatek JPEG Codec driver"
 	depends on V4L_MEM2MEM_DRIVERS
@@ -423,18 +399,6 @@ config VIDEO_SAMSUNG_S5P_MFC
 	help
 	    MFC 5.1 and 6.x driver for V4L2
 
-config VIDEO_MX2_EMMAPRP
-	tristate "MX2 eMMa-PrP support"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on SOC_IMX27 || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	    MX2X chips have a PrP that can be used to process buffers from
-	    memory to memory. Operations include resizing and format
-	    conversion.
-
 config VIDEO_SAMSUNG_EXYNOS_GSC
 	tristate "Samsung Exynos G-Scaler driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 18ec3d208483..4458690c1965 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -15,14 +15,13 @@ obj-y += coda/
 obj-y += davinci/
 obj-y += exynos-gsc/
 obj-y += exynos4-is/
-obj-y += imx/
-obj-y += imx-jpeg/
 obj-y += marvell-ccic/
 obj-y += meson/ge2d/
 obj-y += mtk-jpeg/
 obj-y += mtk-mdp/
 obj-y += mtk-vcodec/
 obj-y += mtk-vpu/
+obj-y += nxp/
 obj-y += omap/
 obj-y += omap3isp/
 obj-y += qcom/camss/
@@ -48,10 +47,8 @@ obj-y += xilinx/
 # Please place here only ancillary drivers that aren't SoC-specific
 # Please keep it alphabetically sorted by Kconfig name
 # (e. g. LC_ALL=C sort Makefile)
-obj-$(CONFIG_VIDEO_IMX_PXP)		+= imx-pxp.o
 obj-$(CONFIG_VIDEO_MEM2MEM_DEINTERLACE)	+= m2m-deinterlace.o
 obj-$(CONFIG_VIDEO_MUX)			+= video-mux.o
-obj-$(CONFIG_VIDEO_MX2_EMMAPRP)		+= mx2_emmaprp.o
 obj-$(CONFIG_VIDEO_PXA27x)		+= pxa_camera.o
 obj-$(CONFIG_VIDEO_RCAR_DRIF)		+= rcar_drif.o
 obj-$(CONFIG_VIDEO_RCAR_ISP)		+= rcar-isp.o
@@ -61,4 +58,3 @@ obj-$(CONFIG_VIDEO_RENESAS_FDP1)	+= rcar_fdp1.o
 obj-$(CONFIG_VIDEO_RENESAS_JPU)		+= rcar_jpu.o
 obj-$(CONFIG_VIDEO_SH_VOU)		+= sh_vou.o
 obj-$(CONFIG_VIDEO_VIA_CAMERA)		+= via-camera.o
-obj-$(CONFIG_VIDEO_VIU)			+= fsl-viu.o
diff --git a/drivers/media/platform/imx/Kconfig b/drivers/media/platform/imx/Kconfig
deleted file mode 100644
index 7cd0617c9b1b..000000000000
--- a/drivers/media/platform/imx/Kconfig
+++ /dev/null
@@ -1,25 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-
-menuconfig VIDEO_IMX
-	bool "V4L2 capture drivers for NXP i.MX devices"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on ARCH_MXC || COMPILE_TEST
-	depends on VIDEO_DEV && VIDEO_V4L2
-	help
-	  Say yes here to enable support for capture drivers on i.MX SoCs.
-	  Support for the single SoC features are selectable in the sub-menu
-	  options.
-
-if VIDEO_IMX
-
-config VIDEO_IMX_MIPI_CSIS
-	tristate "MIPI CSI-2 CSIS receiver found on i.MX7 and i.MX8 models"
-	select MEDIA_CONTROLLER
-	select V4L2_FWNODE
-	select VIDEO_V4L2_SUBDEV_API
-	default n
-	help
-	  Video4Linux2 sub-device driver for the MIPI CSI-2 CSIS receiver
-	  v3.3/v3.6.3 found on some i.MX7 and i.MX8 SoCs.
-
-endif # VIDEO_IMX
diff --git a/drivers/media/platform/imx/Makefile b/drivers/media/platform/imx/Makefile
deleted file mode 100644
index f72bdbe8e6ef..000000000000
--- a/drivers/media/platform/imx/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_VIDEO_IMX_MIPI_CSIS) += imx-mipi-csis.o
diff --git a/drivers/media/platform/nxp/Kconfig b/drivers/media/platform/nxp/Kconfig
new file mode 100644
index 000000000000..df52d32ebe50
--- /dev/null
+++ b/drivers/media/platform/nxp/Kconfig
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# V4L drivers
+
+menuconfig VIDEO_IMX
+	bool "V4L2 capture drivers for NXP i.MX devices"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on VIDEO_DEV && VIDEO_V4L2
+	help
+	  Say yes here to enable support for capture drivers on i.MX SoCs.
+	  Support for the single SoC features are selectable in the sub-menu
+	  options.
+
+if VIDEO_IMX
+
+config VIDEO_IMX_MIPI_CSIS
+	tristate "MIPI CSI-2 CSIS receiver found on i.MX7 and i.MX8 models"
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	select VIDEO_V4L2_SUBDEV_API
+	default n
+	help
+	  Video4Linux2 sub-device driver for the MIPI CSI-2 CSIS receiver
+	  v3.3/v3.6.3 found on some i.MX7 and i.MX8 SoCs.
+
+endif # VIDEO_IMX
+
+config VIDEO_VIU
+	tristate "Freescale/NXP VIU Video Driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2 && (PPC_MPC512x || COMPILE_TEST) && I2C
+	select VIDEOBUF_DMA_CONTIG
+	default y
+	help
+	  Support for Freescale VIU video driver. This device captures
+	  video data, or overlays video on DIU frame buffer.
+
+	  Say Y here if you want to enable VIU device on MPC5121e Rev2+.
+	  In doubt, say N.
+
+# mem2mem drivers
+
+config VIDEO_IMX_PXP
+	tristate "i.MX Pixel Pipeline (PXP)"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2 && (ARCH_MXC || COMPILE_TEST)
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  The i.MX Pixel Pipeline is a memory-to-memory engine for scaling,
+	  color space conversion, and rotation.
+
+config VIDEO_MX2_EMMAPRP
+	tristate "Freescale/NXP MX2 eMMa-PrP support"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on SOC_IMX27 || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	    MX2X chips have a PrP that can be used to process buffers from
+	    memory to memory. Operations include resizing and format
+	    conversion.
+
+source "drivers/media/platform/nxp/imx-jpeg/Kconfig"
diff --git a/drivers/media/platform/nxp/Makefile b/drivers/media/platform/nxp/Makefile
new file mode 100644
index 000000000000..efc38c6578ce
--- /dev/null
+++ b/drivers/media/platform/nxp/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += imx-jpeg/
+
+obj-$(CONFIG_VIDEO_IMX_MIPI_CSIS) += imx-mipi-csis.o
+obj-$(CONFIG_VIDEO_IMX_PXP) += imx-pxp.o
+obj-$(CONFIG_VIDEO_MX2_EMMAPRP) += mx2_emmaprp.o
+obj-$(CONFIG_VIDEO_VIU) += fsl-viu.o
diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/nxp/fsl-viu.c
similarity index 100%
rename from drivers/media/platform/fsl-viu.c
rename to drivers/media/platform/nxp/fsl-viu.c
diff --git a/drivers/media/platform/imx-jpeg/Kconfig b/drivers/media/platform/nxp/imx-jpeg/Kconfig
similarity index 100%
rename from drivers/media/platform/imx-jpeg/Kconfig
rename to drivers/media/platform/nxp/imx-jpeg/Kconfig
diff --git a/drivers/media/platform/imx-jpeg/Makefile b/drivers/media/platform/nxp/imx-jpeg/Makefile
similarity index 100%
rename from drivers/media/platform/imx-jpeg/Makefile
rename to drivers/media/platform/nxp/imx-jpeg/Makefile
diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg-hw.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
similarity index 100%
rename from drivers/media/platform/imx-jpeg/mxc-jpeg-hw.c
rename to drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c
diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
similarity index 100%
rename from drivers/media/platform/imx-jpeg/mxc-jpeg-hw.h
rename to drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
similarity index 100%
rename from drivers/media/platform/imx-jpeg/mxc-jpeg.c
rename to drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
diff --git a/drivers/media/platform/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
similarity index 100%
rename from drivers/media/platform/imx-jpeg/mxc-jpeg.h
rename to drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
diff --git a/drivers/media/platform/imx/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
similarity index 100%
rename from drivers/media/platform/imx/imx-mipi-csis.c
rename to drivers/media/platform/nxp/imx-mipi-csis.c
diff --git a/drivers/media/platform/imx-pxp.c b/drivers/media/platform/nxp/imx-pxp.c
similarity index 100%
rename from drivers/media/platform/imx-pxp.c
rename to drivers/media/platform/nxp/imx-pxp.c
diff --git a/drivers/media/platform/imx-pxp.h b/drivers/media/platform/nxp/imx-pxp.h
similarity index 100%
rename from drivers/media/platform/imx-pxp.h
rename to drivers/media/platform/nxp/imx-pxp.h
diff --git a/drivers/media/platform/mx2_emmaprp.c b/drivers/media/platform/nxp/mx2_emmaprp.c
similarity index 100%
rename from drivers/media/platform/mx2_emmaprp.c
rename to drivers/media/platform/nxp/mx2_emmaprp.c
-- 
2.35.1

