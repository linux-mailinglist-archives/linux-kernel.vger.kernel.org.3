Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084874D62DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349134AbiCKOJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349068AbiCKOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:09:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9476D3BD;
        Fri, 11 Mar 2022 06:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFEABB82B71;
        Fri, 11 Mar 2022 14:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F204C340F8;
        Fri, 11 Mar 2022 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007676;
        bh=ijVdHEBxArG3lrQiqNXi4alWQYYb5ZQ+ysOokB22F7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4Ocra2gi4fX1X0JLh2c1QAdh8/Lj5tZIVUWRYbjD59pUSYs7MkYPFfHKRKkVbcxD
         U64mTpyQf/+UqdjNpAtCT9JJq+J+zYRwbok+lR3FPiha6exY2c47IW2GSX4lliwbit
         g+JL6+PsZlt2sp5pSfqpgi5SDOC0YHxQm/ehWl8xl//r3pff1fd06i4c/oiVF4s83H
         qYYHwS2SliAmDYBm7skGbuWFgRci8n9nfa223Zl9C7UtVzq+U2lMqmIbtCFEIK2DAY
         PsUWPhCREHcYEOnpPIeKSubh+KrdP4NNAQU/MiIW+lLGklv58JoZH5ZqTXUtbxHO6F
         3d+tR+tK7o4/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfvt-000lAy-U1; Fri, 11 Mar 2022 15:07:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 07/38] media: platform: place NXP drivers on a separate dir
Date:   Fri, 11 Mar 2022 15:07:20 +0100
Message-Id: <723fbc3e03d8817916a085e218befd6400d299a3.1647006877.git.mchehab@kernel.org>
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

In order to cleanup the main platform media directory, move NXP
driver to its own directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 MAINTAINERS                                   |  2 +-
 drivers/media/platform/Kconfig                | 37 +----------------
 drivers/media/platform/Makefile               |  4 +-
 drivers/media/platform/nxp/Kconfig            | 40 +++++++++++++++++++
 drivers/media/platform/nxp/Makefile           |  5 +++
 drivers/media/platform/{ => nxp}/fsl-viu.c    |  0
 drivers/media/platform/{ => nxp}/imx-pxp.c    |  0
 drivers/media/platform/{ => nxp}/imx-pxp.h    |  0
 .../media/platform/{ => nxp}/mx2_emmaprp.c    |  0
 9 files changed, 49 insertions(+), 39 deletions(-)
 create mode 100644 drivers/media/platform/nxp/Kconfig
 create mode 100644 drivers/media/platform/nxp/Makefile
 rename drivers/media/platform/{ => nxp}/fsl-viu.c (100%)
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
index ad95a25ae2fc..f5ef28d3e53c 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -36,6 +36,8 @@ config V4L_MEM2MEM_DRIVERS
 	  to capture and output drivers, which use memory buffers for just
 	  one of those.
 
+source "drivers/media/platform/nxp/Kconfig"
+
 # V4L platform drivers
 
 source "drivers/media/platform/marvell-ccic/Kconfig"
@@ -68,19 +70,6 @@ config VIDEO_SH_VOU
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
@@ -281,16 +270,6 @@ config VIDEO_CODA
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
 source "drivers/media/platform/imx-jpeg/Kconfig"
 
 config VIDEO_MEDIATEK_JPEG
@@ -431,18 +410,6 @@ config VIDEO_SAMSUNG_S5P_MFC
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
index 1a52a1a784b5..e9f982eb034b 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -22,6 +22,7 @@ obj-y += mtk-jpeg/
 obj-y += mtk-mdp/
 obj-y += mtk-vcodec/
 obj-y += mtk-vpu/
+obj-y += nxp/
 obj-y += omap/
 obj-y += omap3isp/
 obj-y += qcom/camss/
@@ -45,10 +46,8 @@ obj-y += vsp1/
 obj-y += xilinx/
 
 # Please place here only ancillary drivers that aren't SoC-specific
-obj-$(CONFIG_VIDEO_IMX_PXP)		+= imx-pxp.o
 obj-$(CONFIG_VIDEO_MEM2MEM_DEINTERLACE)	+= m2m-deinterlace.o
 obj-$(CONFIG_VIDEO_MUX)			+= video-mux.o
-obj-$(CONFIG_VIDEO_MX2_EMMAPRP)		+= mx2_emmaprp.o
 obj-$(CONFIG_VIDEO_PXA27x)		+= pxa_camera.o
 obj-$(CONFIG_VIDEO_RCAR_DRIF)		+= rcar_drif.o
 obj-$(CONFIG_VIDEO_RCAR_ISP)		+= rcar-isp.o
@@ -58,4 +57,3 @@ obj-$(CONFIG_VIDEO_RENESAS_FDP1)	+= rcar_fdp1.o
 obj-$(CONFIG_VIDEO_RENESAS_JPU)		+= rcar_jpu.o
 obj-$(CONFIG_VIDEO_SH_VOU)		+= sh_vou.o
 obj-$(CONFIG_VIDEO_VIA_CAMERA)		+= via-camera.o
-obj-$(CONFIG_VIDEO_VIU)			+= fsl-viu.o
diff --git a/drivers/media/platform/nxp/Kconfig b/drivers/media/platform/nxp/Kconfig
new file mode 100644
index 000000000000..92724121ff91
--- /dev/null
+++ b/drivers/media/platform/nxp/Kconfig
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# V4L drivers
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
diff --git a/drivers/media/platform/nxp/Makefile b/drivers/media/platform/nxp/Makefile
new file mode 100644
index 000000000000..147bd7ad4ef4
--- /dev/null
+++ b/drivers/media/platform/nxp/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_VIDEO_IMX_PXP)		+= imx-pxp.o
+obj-$(CONFIG_VIDEO_VIU)			+= fsl-viu.o
+obj-$(CONFIG_VIDEO_MX2_EMMAPRP)		+= mx2_emmaprp.o
diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/nxp/fsl-viu.c
similarity index 100%
rename from drivers/media/platform/fsl-viu.c
rename to drivers/media/platform/nxp/fsl-viu.c
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

