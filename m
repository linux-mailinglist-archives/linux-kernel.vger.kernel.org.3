Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350F54D7CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiCNIA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbiCNH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:50 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087614161B;
        Mon, 14 Mar 2022 00:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15831CE10BA;
        Mon, 14 Mar 2022 07:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12825C34101;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=Dk4qqeKZEyRVnvBhM69IPdSRAU4TzxaUegvICcNvNHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=au9V19f5CZObn9/JNtEts1aQulAknUkMahLtDRce7fekd/eNcoW3NJ/Qx68zjo665
         s+7L0+QLt4DMHqA294hKt/Hx/vrdZUX+kislsFM28SOfC0AtP09I5gg/12ZPwBKKJv
         /32NhRPuC7QRBVZ11EaPJOKMW+3tZY7NqPfddb5C0sRRwm82/L/MKUa5PgAsgfOZel
         mI0yG8wMd5wUFDJnAt7YbBxY/yWWOtEC6VBnWaxKE7HybwUQDB1z+wJ1hXi1H7/s5G
         8o0fB8i9HtwHW6Bvj899vQP/XRFhMeErloB414rzEkX0xyFUGmZ8UZAmU61mbM4OFc
         YB5Zx2m72x3VQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYc-001kUp-Ou; Mon, 14 Mar 2022 08:55:58 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Herman <herman.yim88@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>,
        Ming Qian <ming.qian@nxp.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 10/64] media: platform: place Renesas drivers on a separate dir
Date:   Mon, 14 Mar 2022 08:55:02 +0100
Message-Id: <1d83f5b7a19947e0b996c0c03fe3f0580d0143a1.1647242579.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647242578.git.mchehab@kernel.org>
References: <cover.1647242578.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In order to cleanup the main platform media directory, move Renesas
driver to its own directory.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 MAINTAINERS                                   |  18 +--
 drivers/media/platform/Kconfig                | 113 +----------------
 drivers/media/platform/Makefile               |  10 +-
 drivers/media/platform/renesas/Kconfig        | 119 ++++++++++++++++++
 drivers/media/platform/renesas/Makefile       |  15 +++
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
 .../platform/{ => renesas}/vsp1/Makefile      |   0
 .../media/platform/{ => renesas}/vsp1/vsp1.h  |   0
 .../platform/{ => renesas}/vsp1/vsp1_brx.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_brx.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_clu.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_clu.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_dl.c     |   0
 .../platform/{ => renesas}/vsp1/vsp1_dl.h     |   0
 .../platform/{ => renesas}/vsp1/vsp1_drm.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_drm.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_drv.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_entity.c |   0
 .../platform/{ => renesas}/vsp1/vsp1_entity.h |   0
 .../platform/{ => renesas}/vsp1/vsp1_hgo.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_hgo.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_hgt.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_hgt.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_histo.c  |   0
 .../platform/{ => renesas}/vsp1/vsp1_histo.h  |   0
 .../platform/{ => renesas}/vsp1/vsp1_hsit.c   |   0
 .../platform/{ => renesas}/vsp1/vsp1_hsit.h   |   0
 .../platform/{ => renesas}/vsp1/vsp1_lif.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_lif.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_lut.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_lut.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_pipe.c   |   0
 .../platform/{ => renesas}/vsp1/vsp1_pipe.h   |   0
 .../platform/{ => renesas}/vsp1/vsp1_regs.h   |   0
 .../platform/{ => renesas}/vsp1/vsp1_rpf.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_rwpf.c   |   0
 .../platform/{ => renesas}/vsp1/vsp1_rwpf.h   |   0
 .../platform/{ => renesas}/vsp1/vsp1_sru.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_sru.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_uds.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_uds.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_uif.c    |   0
 .../platform/{ => renesas}/vsp1/vsp1_uif.h    |   0
 .../platform/{ => renesas}/vsp1/vsp1_video.c  |   0
 .../platform/{ => renesas}/vsp1/vsp1_video.h  |   0
 .../platform/{ => renesas}/vsp1/vsp1_wpf.c    |   0
 59 files changed, 146 insertions(+), 129 deletions(-)
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
 rename drivers/media/platform/{ => renesas}/vsp1/Makefile (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_brx.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_brx.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_clu.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_clu.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_dl.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_dl.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_drm.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_drm.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_drv.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_entity.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_entity.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_hgo.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_hgo.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_hgt.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_hgt.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_histo.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_histo.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_hsit.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_hsit.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_lif.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_lif.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_lut.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_lut.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_pipe.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_pipe.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_regs.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_rpf.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_rwpf.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_rwpf.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_sru.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_sru.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_uds.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_uds.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_uif.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_uif.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_video.c (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_video.h (100%)
 rename drivers/media/platform/{ => renesas}/vsp1/vsp1_wpf.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 780ef2ef3362..848640546398 100644
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
@@ -12024,7 +12024,7 @@ L:	linux-renesas-soc@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/renesas,vsp1.yaml
-F:	drivers/media/platform/vsp1/
+F:	drivers/media/platform/renesas/vsp1/
 
 MEDIA DRIVERS FOR ST STV0910 DEMODULATOR ICs
 L:	linux-media@vger.kernel.org
@@ -17536,7 +17536,7 @@ F:	include/media/i2c/rj54n1cb0c.h
 SH_VOU V4L2 OUTPUT DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-F:	drivers/media/platform/sh_vou.c
+F:	drivers/media/platform/renesas/sh_vou.c
 F:	include/media/drv-intf/sh_vou.h
 
 SI2157 MEDIA DRIVER
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 83a496327325..b6650caecf45 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -31,6 +31,8 @@ config V4L_MEM2MEM_DRIVERS
 
 source "drivers/media/platform/nxp/Kconfig"
 
+source "drivers/media/platform/renesas/Kconfig"
+
 # V4L platform drivers
 
 source "drivers/media/platform/marvell-ccic/Kconfig"
@@ -45,15 +47,6 @@ source "drivers/media/platform/omap/Kconfig"
 
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
@@ -129,16 +122,6 @@ config VIDEO_STM32_DCMI
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
@@ -161,7 +144,6 @@ config VIDEO_ROCKCHIP_ISP1
 source "drivers/media/platform/exynos4-is/Kconfig"
 source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
-source "drivers/media/platform/rcar-vin/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/sunxi/Kconfig"
 
@@ -191,22 +173,6 @@ config VIDEO_TI_CAL_MC
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
 
@@ -477,64 +443,6 @@ config VIDEO_STM32_DMA2D
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
@@ -664,20 +572,3 @@ config VIDEO_TI_CSC
 
 # DVB platform drivers
 source "drivers/media/platform/sti/c8sectpfe/Kconfig"
-
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
diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
index 4742b18fd8d8..20b07ae3ebf1 100644
--- a/drivers/media/platform/Makefile
+++ b/drivers/media/platform/Makefile
@@ -27,7 +27,7 @@ obj-y += omap/
 obj-y += omap3isp/
 obj-y += qcom/camss/
 obj-y += qcom/venus/
-obj-y += rcar-vin/
+obj-y += renesas/
 obj-y += rockchip/rga/
 obj-y += rockchip/rkisp1/
 obj-y += s3c-camif/
@@ -43,7 +43,6 @@ obj-y += sunxi/
 obj-y += tegra/vde/
 obj-y += ti-vpe/
 obj-y += via/
-obj-y += vsp1/
 obj-y += xilinx/
 
 # Please place here only ancillary drivers that aren't SoC-specific
@@ -51,10 +50,3 @@ obj-y += xilinx/
 # (e. g. LC_ALL=C sort Makefile)
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
index 000000000000..3f35f1b5106d
--- /dev/null
+++ b/drivers/media/platform/renesas/Kconfig
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# V4L drivers
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
index 000000000000..3ec226ef5fd2
--- /dev/null
+++ b/drivers/media/platform/renesas/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the Renesas capture/playback device drivers.
+#
+
+obj-y += rcar-vin/
+obj-y += vsp1/
+
+obj-$(CONFIG_VIDEO_RCAR_DRIF) += rcar_drif.o
+obj-$(CONFIG_VIDEO_RCAR_ISP) += rcar-isp.o
+obj-$(CONFIG_VIDEO_RENESAS_CEU) += renesas-ceu.o
+obj-$(CONFIG_VIDEO_RENESAS_FCP) += rcar-fcp.o
+obj-$(CONFIG_VIDEO_RENESAS_FDP1) += rcar_fdp1.o
+obj-$(CONFIG_VIDEO_RENESAS_JPU) += rcar_jpu.o
+obj-$(CONFIG_VIDEO_SH_VOU) += sh_vou.o
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
diff --git a/drivers/media/platform/vsp1/Makefile b/drivers/media/platform/renesas/vsp1/Makefile
similarity index 100%
rename from drivers/media/platform/vsp1/Makefile
rename to drivers/media/platform/renesas/vsp1/Makefile
diff --git a/drivers/media/platform/vsp1/vsp1.h b/drivers/media/platform/renesas/vsp1/vsp1.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1.h
rename to drivers/media/platform/renesas/vsp1/vsp1.h
diff --git a/drivers/media/platform/vsp1/vsp1_brx.c b/drivers/media/platform/renesas/vsp1/vsp1_brx.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_brx.c
rename to drivers/media/platform/renesas/vsp1/vsp1_brx.c
diff --git a/drivers/media/platform/vsp1/vsp1_brx.h b/drivers/media/platform/renesas/vsp1/vsp1_brx.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_brx.h
rename to drivers/media/platform/renesas/vsp1/vsp1_brx.h
diff --git a/drivers/media/platform/vsp1/vsp1_clu.c b/drivers/media/platform/renesas/vsp1/vsp1_clu.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_clu.c
rename to drivers/media/platform/renesas/vsp1/vsp1_clu.c
diff --git a/drivers/media/platform/vsp1/vsp1_clu.h b/drivers/media/platform/renesas/vsp1/vsp1_clu.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_clu.h
rename to drivers/media/platform/renesas/vsp1/vsp1_clu.h
diff --git a/drivers/media/platform/vsp1/vsp1_dl.c b/drivers/media/platform/renesas/vsp1/vsp1_dl.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_dl.c
rename to drivers/media/platform/renesas/vsp1/vsp1_dl.c
diff --git a/drivers/media/platform/vsp1/vsp1_dl.h b/drivers/media/platform/renesas/vsp1/vsp1_dl.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_dl.h
rename to drivers/media/platform/renesas/vsp1/vsp1_dl.h
diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_drm.c
rename to drivers/media/platform/renesas/vsp1/vsp1_drm.c
diff --git a/drivers/media/platform/vsp1/vsp1_drm.h b/drivers/media/platform/renesas/vsp1/vsp1_drm.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_drm.h
rename to drivers/media/platform/renesas/vsp1/vsp1_drm.h
diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_drv.c
rename to drivers/media/platform/renesas/vsp1/vsp1_drv.c
diff --git a/drivers/media/platform/vsp1/vsp1_entity.c b/drivers/media/platform/renesas/vsp1/vsp1_entity.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_entity.c
rename to drivers/media/platform/renesas/vsp1/vsp1_entity.c
diff --git a/drivers/media/platform/vsp1/vsp1_entity.h b/drivers/media/platform/renesas/vsp1/vsp1_entity.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_entity.h
rename to drivers/media/platform/renesas/vsp1/vsp1_entity.h
diff --git a/drivers/media/platform/vsp1/vsp1_hgo.c b/drivers/media/platform/renesas/vsp1/vsp1_hgo.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_hgo.c
rename to drivers/media/platform/renesas/vsp1/vsp1_hgo.c
diff --git a/drivers/media/platform/vsp1/vsp1_hgo.h b/drivers/media/platform/renesas/vsp1/vsp1_hgo.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_hgo.h
rename to drivers/media/platform/renesas/vsp1/vsp1_hgo.h
diff --git a/drivers/media/platform/vsp1/vsp1_hgt.c b/drivers/media/platform/renesas/vsp1/vsp1_hgt.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_hgt.c
rename to drivers/media/platform/renesas/vsp1/vsp1_hgt.c
diff --git a/drivers/media/platform/vsp1/vsp1_hgt.h b/drivers/media/platform/renesas/vsp1/vsp1_hgt.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_hgt.h
rename to drivers/media/platform/renesas/vsp1/vsp1_hgt.h
diff --git a/drivers/media/platform/vsp1/vsp1_histo.c b/drivers/media/platform/renesas/vsp1/vsp1_histo.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_histo.c
rename to drivers/media/platform/renesas/vsp1/vsp1_histo.c
diff --git a/drivers/media/platform/vsp1/vsp1_histo.h b/drivers/media/platform/renesas/vsp1/vsp1_histo.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_histo.h
rename to drivers/media/platform/renesas/vsp1/vsp1_histo.h
diff --git a/drivers/media/platform/vsp1/vsp1_hsit.c b/drivers/media/platform/renesas/vsp1/vsp1_hsit.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_hsit.c
rename to drivers/media/platform/renesas/vsp1/vsp1_hsit.c
diff --git a/drivers/media/platform/vsp1/vsp1_hsit.h b/drivers/media/platform/renesas/vsp1/vsp1_hsit.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_hsit.h
rename to drivers/media/platform/renesas/vsp1/vsp1_hsit.h
diff --git a/drivers/media/platform/vsp1/vsp1_lif.c b/drivers/media/platform/renesas/vsp1/vsp1_lif.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_lif.c
rename to drivers/media/platform/renesas/vsp1/vsp1_lif.c
diff --git a/drivers/media/platform/vsp1/vsp1_lif.h b/drivers/media/platform/renesas/vsp1/vsp1_lif.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_lif.h
rename to drivers/media/platform/renesas/vsp1/vsp1_lif.h
diff --git a/drivers/media/platform/vsp1/vsp1_lut.c b/drivers/media/platform/renesas/vsp1/vsp1_lut.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_lut.c
rename to drivers/media/platform/renesas/vsp1/vsp1_lut.c
diff --git a/drivers/media/platform/vsp1/vsp1_lut.h b/drivers/media/platform/renesas/vsp1/vsp1_lut.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_lut.h
rename to drivers/media/platform/renesas/vsp1/vsp1_lut.h
diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c b/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_pipe.c
rename to drivers/media/platform/renesas/vsp1/vsp1_pipe.c
diff --git a/drivers/media/platform/vsp1/vsp1_pipe.h b/drivers/media/platform/renesas/vsp1/vsp1_pipe.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_pipe.h
rename to drivers/media/platform/renesas/vsp1/vsp1_pipe.h
diff --git a/drivers/media/platform/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_regs.h
rename to drivers/media/platform/renesas/vsp1/vsp1_regs.h
diff --git a/drivers/media/platform/vsp1/vsp1_rpf.c b/drivers/media/platform/renesas/vsp1/vsp1_rpf.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_rpf.c
rename to drivers/media/platform/renesas/vsp1/vsp1_rpf.c
diff --git a/drivers/media/platform/vsp1/vsp1_rwpf.c b/drivers/media/platform/renesas/vsp1/vsp1_rwpf.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_rwpf.c
rename to drivers/media/platform/renesas/vsp1/vsp1_rwpf.c
diff --git a/drivers/media/platform/vsp1/vsp1_rwpf.h b/drivers/media/platform/renesas/vsp1/vsp1_rwpf.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_rwpf.h
rename to drivers/media/platform/renesas/vsp1/vsp1_rwpf.h
diff --git a/drivers/media/platform/vsp1/vsp1_sru.c b/drivers/media/platform/renesas/vsp1/vsp1_sru.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_sru.c
rename to drivers/media/platform/renesas/vsp1/vsp1_sru.c
diff --git a/drivers/media/platform/vsp1/vsp1_sru.h b/drivers/media/platform/renesas/vsp1/vsp1_sru.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_sru.h
rename to drivers/media/platform/renesas/vsp1/vsp1_sru.h
diff --git a/drivers/media/platform/vsp1/vsp1_uds.c b/drivers/media/platform/renesas/vsp1/vsp1_uds.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_uds.c
rename to drivers/media/platform/renesas/vsp1/vsp1_uds.c
diff --git a/drivers/media/platform/vsp1/vsp1_uds.h b/drivers/media/platform/renesas/vsp1/vsp1_uds.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_uds.h
rename to drivers/media/platform/renesas/vsp1/vsp1_uds.h
diff --git a/drivers/media/platform/vsp1/vsp1_uif.c b/drivers/media/platform/renesas/vsp1/vsp1_uif.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_uif.c
rename to drivers/media/platform/renesas/vsp1/vsp1_uif.c
diff --git a/drivers/media/platform/vsp1/vsp1_uif.h b/drivers/media/platform/renesas/vsp1/vsp1_uif.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_uif.h
rename to drivers/media/platform/renesas/vsp1/vsp1_uif.h
diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/renesas/vsp1/vsp1_video.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_video.c
rename to drivers/media/platform/renesas/vsp1/vsp1_video.c
diff --git a/drivers/media/platform/vsp1/vsp1_video.h b/drivers/media/platform/renesas/vsp1/vsp1_video.h
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_video.h
rename to drivers/media/platform/renesas/vsp1/vsp1_video.h
diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
similarity index 100%
rename from drivers/media/platform/vsp1/vsp1_wpf.c
rename to drivers/media/platform/renesas/vsp1/vsp1_wpf.c
-- 
2.35.1

