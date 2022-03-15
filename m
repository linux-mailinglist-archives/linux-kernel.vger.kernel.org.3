Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37124D943C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbiCOF6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiCOF54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:57:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601D39839;
        Mon, 14 Mar 2022 22:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 650236122E;
        Tue, 15 Mar 2022 05:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434B6C340E8;
        Tue, 15 Mar 2022 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647323801;
        bh=l1m59ElkdHw6mcbFcu6Xbob8fE2FfA8JUePBFSXOvo8=;
        h=From:To:Cc:Subject:Date:From;
        b=unu/9M8vJ7LRM5J0XWhpoa6DuvuDbVlyejcz6UdHNojKpJmUav3x0T2CoLRXWZ7ic
         58N6SwKRBrU6WFD/HIbTJ1Wdt01kMllKQjMkvHvTbDzeFhq5B92zdbHqnxib6Yjpsu
         JkhI/SGPK4VB1dL8nU1ciHzB8iPPAbuR1FFn8SbJ5Zs1emNSJEWrLIfW5YQy4luQC/
         MbB/tyruGnXr6AnoLSlHp9dv/VkdKO0xicaDyXsJ0e+fBjyY69BnzJnh4aAUpBGG1P
         xUljU0cpa0TrV8EhUntCjwwAwtBYuuZkb4E+6QWf8MOzXK5migDSjgywuLbtTXpFzx
         8kpSIXc3l4D+A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nU0Ag-002Bou-Lg; Tue, 15 Mar 2022 06:56:38 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jimmy Su <jimmy.su@intel.com>,
        Martina Krasteva <martinax.krasteva@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Shawn Tu <shawnx.tu@intel.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH] media: i2c: Kconfig: move camera drivers to the top
Date:   Tue, 15 Mar 2022 06:56:36 +0100
Message-Id: <f2d22b8cdf095b6b907eafa1b92c8c3a046b61be.1647323789.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
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

The camera drivers are the ones that suffer additions/changes
on those days. Place them on the top of the I2C drivers.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/i2c/Kconfig | 1688 ++++++++++++++++++-------------------
 1 file changed, 844 insertions(+), 844 deletions(-)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 14fe94f3c772..fae2baabb773 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -21,6 +21,850 @@ config VIDEO_IR_I2C
 
 	  In doubt, say Y.
 
+#
+# V4L2 I2C drivers that are related with Camera support
+#
+
+menu "Camera sensor devices"
+	visible if MEDIA_CAMERA_SUPPORT
+
+config VIDEO_APTINA_PLL
+	tristate
+
+config VIDEO_CCS_PLL
+	tristate
+
+config VIDEO_HI556
+	tristate "Hynix Hi-556 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Hynix
+	  Hi-556 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hi556.
+
+config VIDEO_HI846
+	tristate "Hynix Hi-846 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Hynix
+	  Hi-846 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hi846.
+
+config VIDEO_HI847
+        tristate "Hynix Hi-847 sensor support"
+        depends on I2C && VIDEO_DEV
+        select MEDIA_CONTROLLER
+        select VIDEO_V4L2_SUBDEV_API
+        select V4L2_FWNODE
+        help
+          This is a Video4Linux2 sensor driver for the Hynix
+          Hi-847 camera.
+
+          To compile this driver as a module, choose M here: the
+          module will be called hi847.
+
+config VIDEO_IMX208
+	tristate "Sony IMX208 sensor support"
+	depends on I2C && VIDEO_DEV && VIDEO_V4L2_SUBDEV_API
+	depends on MEDIA_CAMERA_SUPPORT
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX208 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx208.
+
+config VIDEO_IMX214
+	tristate "Sony IMX214 sensor support"
+	depends on GPIOLIB && I2C && VIDEO_DEV
+	select V4L2_FWNODE
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select REGMAP_I2C
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX214 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx214.
+
+config VIDEO_IMX219
+	tristate "Sony IMX219 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX219 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx219.
+
+config VIDEO_IMX258
+	tristate "Sony IMX258 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX258 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx258.
+
+config VIDEO_IMX274
+	tristate "Sony IMX274 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select REGMAP_I2C
+	help
+	  This is a V4L2 sensor driver for the Sony IMX274
+	  CMOS image sensor.
+
+config VIDEO_IMX290
+	tristate "Sony IMX290 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select REGMAP_I2C
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX290 camera sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx290.
+
+config VIDEO_IMX319
+	tristate "Sony IMX319 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX319 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx319.
+
+config VIDEO_IMX334
+	tristate "Sony IMX334 sensor support"
+	depends on OF_GPIO
+	depends on I2C && VIDEO_DEV
+	select VIDEO_V4L2_SUBDEV_API
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX334 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx334.
+
+config VIDEO_IMX335
+	tristate "Sony IMX335 sensor support"
+	depends on OF_GPIO
+	depends on I2C && VIDEO_DEV
+	select VIDEO_V4L2_SUBDEV_API
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX335 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx335.
+
+config VIDEO_IMX355
+	tristate "Sony IMX355 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX355 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx355.
+
+config VIDEO_IMX412
+	tristate "Sony IMX412 sensor support"
+	depends on OF_GPIO
+	depends on I2C && VIDEO_DEV
+	select VIDEO_V4L2_SUBDEV_API
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Sony
+	  IMX412 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called imx412.
+
+config VIDEO_MAX9271_LIB
+	tristate
+
+config VIDEO_MT9M001
+	tristate "mt9m001 support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This driver supports MT9M001 cameras from Micron, monochrome
+	  and colour models.
+
+config VIDEO_MT9M032
+	tristate "MT9M032 camera sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEO_APTINA_PLL
+	help
+	  This driver supports MT9M032 camera sensors from Aptina, monochrome
+	  models only.
+
+config VIDEO_MT9M111
+	tristate "mt9m111, mt9m112 and mt9m131 support"
+	depends on I2C && VIDEO_DEV
+	select V4L2_FWNODE
+	help
+	  This driver supports MT9M111, MT9M112 and MT9M131 cameras from
+	  Micron/Aptina
+
+config VIDEO_MT9P031
+	tristate "Aptina MT9P031 support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEO_APTINA_PLL
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Aptina
+	  (Micron) mt9p031 5 Mpixel camera.
+
+config VIDEO_MT9T001
+	tristate "Aptina MT9T001 support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a Video4Linux2 sensor driver for the Aptina
+	  (Micron) mt0t001 3 Mpixel camera.
+
+config VIDEO_MT9T112
+	tristate "Aptina MT9T111/MT9T112 support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the Aptina
+	  (Micron) MT9T111 and MT9T112 3 Mpixel camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mt9t112.
+
+config VIDEO_MT9V011
+	tristate "Micron mt9v011 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the Micron
+	  mt0v011 1.3 Mpixel camera.  It currently only works with the
+	  em28xx driver.
+
+config VIDEO_MT9V032
+	tristate "Micron MT9V032 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select REGMAP_I2C
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Micron
+	  MT9V032 752x480 CMOS sensor.
+
+config VIDEO_MT9V111
+	tristate "Aptina MT9V111 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the Aptina/Micron
+	  MT9V111 sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mt9v111.
+
+config VIDEO_NOON010PC30
+	tristate "Siliconfile NOON010PC30 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This driver supports NOON010PC30 CIF camera from Siliconfile
+
+config VIDEO_OG01A1B
+	tristate "OmniVision OG01A1B sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OG01A1B camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called og01a1b.
+
+config VIDEO_OV02A10
+	tristate "OmniVision OV02A10 sensor support"
+	depends on VIDEO_DEV && I2C
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV02A10 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov02a10.
+
+config VIDEO_OV08D10
+        tristate "OmniVision OV08D10 sensor support"
+        depends on I2C && VIDEO_DEV
+        select MEDIA_CONTROLLER
+        select VIDEO_V4L2_SUBDEV_API
+        select V4L2_FWNODE
+        help
+          This is a Video4Linux2 sensor driver for the OmniVision
+          OV08D10 camera sensor.
+
+          To compile this driver as a module, choose M here: the
+          module will be called ov08d10.
+
+config VIDEO_OV13858
+	tristate "OmniVision OV13858 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV13858 camera.
+
+config VIDEO_OV13B10
+	tristate "OmniVision OV13B10 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV13B10 camera.
+
+config VIDEO_OV2640
+	tristate "OmniVision OV2640 sensor support"
+	depends on VIDEO_DEV && I2C
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV2640 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov2640.
+
+config VIDEO_OV2659
+	tristate "OmniVision OV2659 sensor support"
+	depends on VIDEO_DEV && I2C && GPIOLIB
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV2659 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov2659.
+
+config VIDEO_OV2680
+	tristate "OmniVision OV2680 sensor support"
+	depends on VIDEO_DEV && I2C
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV2680 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov2680.
+
+config VIDEO_OV2685
+	tristate "OmniVision OV2685 sensor support"
+	depends on VIDEO_DEV && I2C
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV2685 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov2685.
+
+config VIDEO_OV2740
+	tristate "OmniVision OV2740 sensor support"
+	depends on VIDEO_DEV && I2C
+	depends on ACPI || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	select REGMAP_I2C
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV2740 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov2740.
+
+config VIDEO_OV5640
+	tristate "OmniVision OV5640 sensor support"
+	depends on OF
+	depends on GPIOLIB && VIDEO_DEV && I2C
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the Omnivision
+	  OV5640 camera sensor with a MIPI CSI-2 interface.
+
+config VIDEO_OV5645
+	tristate "OmniVision OV5645 sensor support"
+	depends on OF
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV5645 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov5645.
+
+config VIDEO_OV5647
+	tristate "OmniVision OV5647 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV5647 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov5647.
+
+config VIDEO_OV5648
+	tristate "OmniVision OV5648 sensor support"
+	depends on I2C && PM && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV5648 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov5648.
+
+config VIDEO_OV5670
+	tristate "OmniVision OV5670 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV5670 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov5670.
+
+config VIDEO_OV5675
+	tristate "OmniVision OV5675 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV5675 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov5675.
+
+config VIDEO_OV5693
+	tristate "OmniVision OV5693 sensor support"
+	depends on I2C && VIDEO_DEV
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV5693 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov5693.
+
+config VIDEO_OV5695
+	tristate "OmniVision OV5695 sensor support"
+	depends on I2C && VIDEO_DEV
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV5695 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov5695.
+
+config VIDEO_OV6650
+	tristate "OmniVision OV6650 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV6650 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov6650.
+
+config VIDEO_OV7251
+	tristate "OmniVision OV7251 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV7251 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov7251.
+
+config VIDEO_OV7640
+	tristate "OmniVision OV7640 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV7640 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov7640.
+
+config VIDEO_OV7670
+	tristate "OmniVision OV7670 sensor support"
+	depends on I2C && VIDEO_DEV
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV7670 VGA camera.  It currently only works with the M88ALP01
+	  controller.
+
+config VIDEO_OV772X
+	tristate "OmniVision OV772x sensor support"
+	depends on I2C && VIDEO_DEV
+	select REGMAP_SCCB
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV772x camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov772x.
+
+config VIDEO_OV7740
+	tristate "OmniVision OV7740 sensor support"
+	depends on I2C && VIDEO_DEV
+	select REGMAP_SCCB
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV7740 VGA camera sensor.
+
+config VIDEO_OV8856
+	tristate "OmniVision OV8856 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV8856 camera sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov8856.
+
+config VIDEO_OV8865
+	tristate "OmniVision OV8865 sensor support"
+	depends on I2C && PM && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for OmniVision
+	  OV8865 camera sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov8865.
+
+config VIDEO_OV9282
+	tristate "OmniVision OV9282 sensor support"
+	depends on OF_GPIO
+	depends on I2C && VIDEO_DEV
+	select VIDEO_V4L2_SUBDEV_API
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV9282 camera sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ov9282.
+
+config VIDEO_OV9640
+	tristate "OmniVision OV9640 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV9640 camera sensor.
+
+config VIDEO_OV9650
+	tristate "OmniVision OV9650/OV9652 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select REGMAP_SCCB
+	help
+	  This is a V4L2 sensor driver for the Omnivision
+	  OV9650 and OV9652 camera sensors.
+
+config VIDEO_OV9734
+	tristate "OmniVision OV9734 sensor support"
+	depends on VIDEO_DEV && I2C
+	depends on ACPI || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a Video4Linux2 sensor driver for the OmniVision
+	  OV9734 camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module's name is ov9734.
+
+config VIDEO_RDACM20
+	tristate "IMI RDACM20 camera support"
+	depends on I2C
+	select V4L2_FWNODE
+	select VIDEO_V4L2_SUBDEV_API
+	select MEDIA_CONTROLLER
+	select VIDEO_MAX9271_LIB
+	help
+	  This driver supports the IMI RDACM20 GMSL camera, used in
+	  ADAS systems.
+
+	  This camera should be used in conjunction with a GMSL
+	  deserialiser such as the MAX9286.
+
+config VIDEO_RDACM21
+	tristate "IMI RDACM21 camera support"
+	depends on I2C
+	select V4L2_FWNODE
+	select VIDEO_V4L2_SUBDEV_API
+	select MEDIA_CONTROLLER
+	select VIDEO_MAX9271_LIB
+	help
+	  This driver supports the IMI RDACM21 GMSL camera, used in
+	  ADAS systems.
+
+	  This camera should be used in conjunction with a GMSL
+	  deserialiser such as the MAX9286.
+
+config VIDEO_RJ54N1
+	tristate "Sharp RJ54N1CB0C sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This is a V4L2 sensor driver for Sharp RJ54N1CB0C CMOS image
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rj54n1.
+
+config VIDEO_S5C73M3
+	tristate "Samsung S5C73M3 sensor support"
+	depends on I2C && SPI && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a V4L2 sensor driver for Samsung S5C73M3
+	  8 Mpixel camera.
+
+config VIDEO_S5K4ECGX
+	tristate "Samsung S5K4ECGX sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select CRC32
+	help
+	  This is a V4L2 sensor driver for Samsung S5K4ECGX 5M
+	  camera sensor with an embedded SoC image signal processor.
+
+config VIDEO_S5K5BAF
+	tristate "Samsung S5K5BAF sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a V4L2 sensor driver for Samsung S5K5BAF 2M
+	  camera sensor with an embedded SoC image signal processor.
+
+config VIDEO_S5K6A3
+	tristate "Samsung S5K6A3 sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a V4L2 sensor driver for Samsung S5K6A3 raw
+	  camera sensor.
+
+config VIDEO_S5K6AA
+	tristate "Samsung S5K6AAFX sensor support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	help
+	  This is a V4L2 sensor driver for Samsung S5K6AA(FX) 1.3M
+	  camera sensor with an embedded SoC image signal processor.
+
+config VIDEO_SR030PC30
+	tristate "Siliconfile SR030PC30 sensor support"
+	depends on I2C && VIDEO_DEV
+	help
+	  This driver supports SR030PC30 VGA camera from Siliconfile
+
+config VIDEO_VS6624
+	tristate "ST VS6624 sensor support"
+	depends on VIDEO_DEV && I2C
+	help
+	  This is a Video4Linux2 sensor driver for the ST VS6624
+	  camera.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vs6624.
+
+source "drivers/media/i2c/ccs/Kconfig"
+source "drivers/media/i2c/et8ek8/Kconfig"
+source "drivers/media/i2c/m5mols/Kconfig"
+
+endmenu
+
+menu "Lens drivers"
+	visible if MEDIA_CAMERA_SUPPORT
+
+config VIDEO_AD5820
+	tristate "AD5820 lens voice coil support"
+	depends on GPIOLIB && I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select V4L2_ASYNC
+	help
+	  This is a driver for the AD5820 camera lens voice coil.
+	  It is used for example in Nokia N900 (RX-51).
+
+config VIDEO_AK7375
+	tristate "AK7375 lens voice coil support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_ASYNC
+	help
+	  This is a driver for the AK7375 camera lens voice coil.
+	  AK7375 is a 12 bit DAC with 120mA output current sink
+	  capability. This is designed for linear control of
+	  voice coil motors, controlled via I2C serial interface.
+
+config VIDEO_DW9714
+	tristate "DW9714 lens voice coil support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_ASYNC
+	help
+	  This is a driver for the DW9714 camera lens voice coil.
+	  DW9714 is a 10 bit DAC with 120mA output current sink
+	  capability. This is designed for linear control of
+	  voice coil motors, controlled via I2C serial interface.
+
+config VIDEO_DW9768
+	tristate "DW9768 lens voice coil support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_FWNODE
+	help
+	  This is a driver for the DW9768 camera lens voice coil.
+	  DW9768 is a 10 bit DAC with 100mA output current sink
+	  capability. This is designed for linear control of
+	  voice coil motors, controlled via I2C serial interface.
+
+config VIDEO_DW9807_VCM
+	tristate "DW9807 lens voice coil support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select V4L2_ASYNC
+	help
+	  This is a driver for the DW9807 camera lens voice coil.
+	  DW9807 is a 10 bit DAC with 100mA output current sink
+	  capability. This is designed for linear control of
+	  voice coil motors, controlled via I2C serial interface.
+
+endmenu
+
+menu "Flash devices"
+	visible if MEDIA_CAMERA_SUPPORT
+
+config VIDEO_ADP1653
+	tristate "ADP1653 flash support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select V4L2_ASYNC
+	help
+	  This is a driver for the ADP1653 flash controller. It is used for
+	  example in Nokia N900.
+
+config VIDEO_LM3560
+	tristate "LM3560 dual flash driver support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select REGMAP_I2C
+	select V4L2_ASYNC
+	help
+	  This is a driver for the lm3560 dual flash controllers. It controls
+	  flash, torch LEDs.
+
+config VIDEO_LM3646
+	tristate "LM3646 dual flash driver support"
+	depends on I2C && VIDEO_DEV
+	select MEDIA_CONTROLLER
+	select REGMAP_I2C
+	select V4L2_ASYNC
+	help
+	  This is a driver for the lm3646 dual flash controllers. It controls
+	  flash, torch LEDs.
+
+endmenu
+
 #
 # V4L2 I2C drivers that aren't related with Camera support
 #
@@ -734,848 +1578,4 @@ config VIDEO_THS7303
 
 endmenu
 
-#
-# V4L2 I2C drivers that are related with Camera support
-#
-
-menu "Camera sensor devices"
-	visible if MEDIA_CAMERA_SUPPORT
-
-config VIDEO_APTINA_PLL
-	tristate
-
-config VIDEO_CCS_PLL
-	tristate
-
-config VIDEO_HI556
-	tristate "Hynix Hi-556 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Hynix
-	  Hi-556 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called hi556.
-
-config VIDEO_HI846
-	tristate "Hynix Hi-846 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Hynix
-	  Hi-846 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called hi846.
-
-config VIDEO_HI847
-        tristate "Hynix Hi-847 sensor support"
-        depends on I2C && VIDEO_DEV
-        select MEDIA_CONTROLLER
-        select VIDEO_V4L2_SUBDEV_API
-        select V4L2_FWNODE
-        help
-          This is a Video4Linux2 sensor driver for the Hynix
-          Hi-847 camera.
-
-          To compile this driver as a module, choose M here: the
-          module will be called hi847.
-
-config VIDEO_IMX208
-	tristate "Sony IMX208 sensor support"
-	depends on I2C && VIDEO_DEV && VIDEO_V4L2_SUBDEV_API
-	depends on MEDIA_CAMERA_SUPPORT
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX208 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx208.
-
-config VIDEO_IMX214
-	tristate "Sony IMX214 sensor support"
-	depends on GPIOLIB && I2C && VIDEO_DEV
-	select V4L2_FWNODE
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select REGMAP_I2C
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX214 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx214.
-
-config VIDEO_IMX219
-	tristate "Sony IMX219 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX219 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx219.
-
-config VIDEO_IMX258
-	tristate "Sony IMX258 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX258 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx258.
-
-config VIDEO_IMX274
-	tristate "Sony IMX274 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select REGMAP_I2C
-	help
-	  This is a V4L2 sensor driver for the Sony IMX274
-	  CMOS image sensor.
-
-config VIDEO_IMX290
-	tristate "Sony IMX290 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select REGMAP_I2C
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX290 camera sensor.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx290.
-
-config VIDEO_IMX319
-	tristate "Sony IMX319 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX319 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx319.
-
-config VIDEO_IMX334
-	tristate "Sony IMX334 sensor support"
-	depends on OF_GPIO
-	depends on I2C && VIDEO_DEV
-	select VIDEO_V4L2_SUBDEV_API
-	select MEDIA_CONTROLLER
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX334 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx334.
-
-config VIDEO_IMX335
-	tristate "Sony IMX335 sensor support"
-	depends on OF_GPIO
-	depends on I2C && VIDEO_DEV
-	select VIDEO_V4L2_SUBDEV_API
-	select MEDIA_CONTROLLER
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX335 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx335.
-
-config VIDEO_IMX355
-	tristate "Sony IMX355 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX355 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx355.
-
-config VIDEO_IMX412
-	tristate "Sony IMX412 sensor support"
-	depends on OF_GPIO
-	depends on I2C && VIDEO_DEV
-	select VIDEO_V4L2_SUBDEV_API
-	select MEDIA_CONTROLLER
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Sony
-	  IMX412 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called imx412.
-
-config VIDEO_MAX9271_LIB
-	tristate
-
-config VIDEO_MT9M001
-	tristate "mt9m001 support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This driver supports MT9M001 cameras from Micron, monochrome
-	  and colour models.
-
-config VIDEO_MT9M032
-	tristate "MT9M032 camera sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEO_APTINA_PLL
-	help
-	  This driver supports MT9M032 camera sensors from Aptina, monochrome
-	  models only.
-
-config VIDEO_MT9M111
-	tristate "mt9m111, mt9m112 and mt9m131 support"
-	depends on I2C && VIDEO_DEV
-	select V4L2_FWNODE
-	help
-	  This driver supports MT9M111, MT9M112 and MT9M131 cameras from
-	  Micron/Aptina
-
-config VIDEO_MT9P031
-	tristate "Aptina MT9P031 support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEO_APTINA_PLL
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Aptina
-	  (Micron) mt9p031 5 Mpixel camera.
-
-config VIDEO_MT9T001
-	tristate "Aptina MT9T001 support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This is a Video4Linux2 sensor driver for the Aptina
-	  (Micron) mt0t001 3 Mpixel camera.
-
-config VIDEO_MT9T112
-	tristate "Aptina MT9T111/MT9T112 support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the Aptina
-	  (Micron) MT9T111 and MT9T112 3 Mpixel camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called mt9t112.
-
-config VIDEO_MT9V011
-	tristate "Micron mt9v011 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the Micron
-	  mt0v011 1.3 Mpixel camera.  It currently only works with the
-	  em28xx driver.
-
-config VIDEO_MT9V032
-	tristate "Micron MT9V032 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select REGMAP_I2C
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Micron
-	  MT9V032 752x480 CMOS sensor.
-
-config VIDEO_MT9V111
-	tristate "Aptina MT9V111 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the Aptina/Micron
-	  MT9V111 sensor.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called mt9v111.
-
-config VIDEO_NOON010PC30
-	tristate "Siliconfile NOON010PC30 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This driver supports NOON010PC30 CIF camera from Siliconfile
-
-config VIDEO_OG01A1B
-	tristate "OmniVision OG01A1B sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OG01A1B camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called og01a1b.
-
-config VIDEO_OV02A10
-	tristate "OmniVision OV02A10 sensor support"
-	depends on VIDEO_DEV && I2C
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV02A10 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov02a10.
-
-config VIDEO_OV08D10
-        tristate "OmniVision OV08D10 sensor support"
-        depends on I2C && VIDEO_DEV
-        select MEDIA_CONTROLLER
-        select VIDEO_V4L2_SUBDEV_API
-        select V4L2_FWNODE
-        help
-          This is a Video4Linux2 sensor driver for the OmniVision
-          OV08D10 camera sensor.
-
-          To compile this driver as a module, choose M here: the
-          module will be called ov08d10.
-
-config VIDEO_OV13858
-	tristate "OmniVision OV13858 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV13858 camera.
-
-config VIDEO_OV13B10
-	tristate "OmniVision OV13B10 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV13B10 camera.
-
-config VIDEO_OV2640
-	tristate "OmniVision OV2640 sensor support"
-	depends on VIDEO_DEV && I2C
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV2640 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov2640.
-
-config VIDEO_OV2659
-	tristate "OmniVision OV2659 sensor support"
-	depends on VIDEO_DEV && I2C && GPIOLIB
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV2659 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov2659.
-
-config VIDEO_OV2680
-	tristate "OmniVision OV2680 sensor support"
-	depends on VIDEO_DEV && I2C
-	select MEDIA_CONTROLLER
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV2680 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov2680.
-
-config VIDEO_OV2685
-	tristate "OmniVision OV2685 sensor support"
-	depends on VIDEO_DEV && I2C
-	select MEDIA_CONTROLLER
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV2685 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov2685.
-
-config VIDEO_OV2740
-	tristate "OmniVision OV2740 sensor support"
-	depends on VIDEO_DEV && I2C
-	depends on ACPI || COMPILE_TEST
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	select REGMAP_I2C
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV2740 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov2740.
-
-config VIDEO_OV5640
-	tristate "OmniVision OV5640 sensor support"
-	depends on OF
-	depends on GPIOLIB && VIDEO_DEV && I2C
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the Omnivision
-	  OV5640 camera sensor with a MIPI CSI-2 interface.
-
-config VIDEO_OV5645
-	tristate "OmniVision OV5645 sensor support"
-	depends on OF
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV5645 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov5645.
-
-config VIDEO_OV5647
-	tristate "OmniVision OV5647 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV5647 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov5647.
-
-config VIDEO_OV5648
-	tristate "OmniVision OV5648 sensor support"
-	depends on I2C && PM && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV5648 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov5648.
-
-config VIDEO_OV5670
-	tristate "OmniVision OV5670 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV5670 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov5670.
-
-config VIDEO_OV5675
-	tristate "OmniVision OV5675 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV5675 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov5675.
-
-config VIDEO_OV5693
-	tristate "OmniVision OV5693 sensor support"
-	depends on I2C && VIDEO_DEV
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV5693 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov5693.
-
-config VIDEO_OV5695
-	tristate "OmniVision OV5695 sensor support"
-	depends on I2C && VIDEO_DEV
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV5695 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov5695.
-
-config VIDEO_OV6650
-	tristate "OmniVision OV6650 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV6650 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov6650.
-
-config VIDEO_OV7251
-	tristate "OmniVision OV7251 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV7251 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov7251.
-
-config VIDEO_OV7640
-	tristate "OmniVision OV7640 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV7640 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov7640.
-
-config VIDEO_OV7670
-	tristate "OmniVision OV7670 sensor support"
-	depends on I2C && VIDEO_DEV
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV7670 VGA camera.  It currently only works with the M88ALP01
-	  controller.
-
-config VIDEO_OV772X
-	tristate "OmniVision OV772x sensor support"
-	depends on I2C && VIDEO_DEV
-	select REGMAP_SCCB
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV772x camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov772x.
-
-config VIDEO_OV7740
-	tristate "OmniVision OV7740 sensor support"
-	depends on I2C && VIDEO_DEV
-	select REGMAP_SCCB
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV7740 VGA camera sensor.
-
-config VIDEO_OV8856
-	tristate "OmniVision OV8856 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV8856 camera sensor.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov8856.
-
-config VIDEO_OV8865
-	tristate "OmniVision OV8865 sensor support"
-	depends on I2C && PM && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for OmniVision
-	  OV8865 camera sensor.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov8865.
-
-config VIDEO_OV9282
-	tristate "OmniVision OV9282 sensor support"
-	depends on OF_GPIO
-	depends on I2C && VIDEO_DEV
-	select VIDEO_V4L2_SUBDEV_API
-	select MEDIA_CONTROLLER
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV9282 camera sensor.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ov9282.
-
-config VIDEO_OV9640
-	tristate "OmniVision OV9640 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV9640 camera sensor.
-
-config VIDEO_OV9650
-	tristate "OmniVision OV9650/OV9652 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select REGMAP_SCCB
-	help
-	  This is a V4L2 sensor driver for the Omnivision
-	  OV9650 and OV9652 camera sensors.
-
-config VIDEO_OV9734
-	tristate "OmniVision OV9734 sensor support"
-	depends on VIDEO_DEV && I2C
-	depends on ACPI || COMPILE_TEST
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a Video4Linux2 sensor driver for the OmniVision
-	  OV9734 camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module's name is ov9734.
-
-config VIDEO_RDACM20
-	tristate "IMI RDACM20 camera support"
-	depends on I2C
-	select V4L2_FWNODE
-	select VIDEO_V4L2_SUBDEV_API
-	select MEDIA_CONTROLLER
-	select VIDEO_MAX9271_LIB
-	help
-	  This driver supports the IMI RDACM20 GMSL camera, used in
-	  ADAS systems.
-
-	  This camera should be used in conjunction with a GMSL
-	  deserialiser such as the MAX9286.
-
-config VIDEO_RDACM21
-	tristate "IMI RDACM21 camera support"
-	depends on I2C
-	select V4L2_FWNODE
-	select VIDEO_V4L2_SUBDEV_API
-	select MEDIA_CONTROLLER
-	select VIDEO_MAX9271_LIB
-	help
-	  This driver supports the IMI RDACM21 GMSL camera, used in
-	  ADAS systems.
-
-	  This camera should be used in conjunction with a GMSL
-	  deserialiser such as the MAX9286.
-
-config VIDEO_RJ54N1
-	tristate "Sharp RJ54N1CB0C sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This is a V4L2 sensor driver for Sharp RJ54N1CB0C CMOS image
-	  sensor.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called rj54n1.
-
-config VIDEO_S5C73M3
-	tristate "Samsung S5C73M3 sensor support"
-	depends on I2C && SPI && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a V4L2 sensor driver for Samsung S5C73M3
-	  8 Mpixel camera.
-
-config VIDEO_S5K4ECGX
-	tristate "Samsung S5K4ECGX sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select CRC32
-	help
-	  This is a V4L2 sensor driver for Samsung S5K4ECGX 5M
-	  camera sensor with an embedded SoC image signal processor.
-
-config VIDEO_S5K5BAF
-	tristate "Samsung S5K5BAF sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a V4L2 sensor driver for Samsung S5K5BAF 2M
-	  camera sensor with an embedded SoC image signal processor.
-
-config VIDEO_S5K6A3
-	tristate "Samsung S5K6A3 sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This is a V4L2 sensor driver for Samsung S5K6A3 raw
-	  camera sensor.
-
-config VIDEO_S5K6AA
-	tristate "Samsung S5K6AAFX sensor support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	help
-	  This is a V4L2 sensor driver for Samsung S5K6AA(FX) 1.3M
-	  camera sensor with an embedded SoC image signal processor.
-
-config VIDEO_SR030PC30
-	tristate "Siliconfile SR030PC30 sensor support"
-	depends on I2C && VIDEO_DEV
-	help
-	  This driver supports SR030PC30 VGA camera from Siliconfile
-
-config VIDEO_VS6624
-	tristate "ST VS6624 sensor support"
-	depends on VIDEO_DEV && I2C
-	help
-	  This is a Video4Linux2 sensor driver for the ST VS6624
-	  camera.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called vs6624.
-
-source "drivers/media/i2c/ccs/Kconfig"
-source "drivers/media/i2c/et8ek8/Kconfig"
-source "drivers/media/i2c/m5mols/Kconfig"
-
-endmenu
-
-menu "Lens drivers"
-	visible if MEDIA_CAMERA_SUPPORT
-
-config VIDEO_AD5820
-	tristate "AD5820 lens voice coil support"
-	depends on GPIOLIB && I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select V4L2_ASYNC
-	help
-	  This is a driver for the AD5820 camera lens voice coil.
-	  It is used for example in Nokia N900 (RX-51).
-
-config VIDEO_AK7375
-	tristate "AK7375 lens voice coil support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_ASYNC
-	help
-	  This is a driver for the AK7375 camera lens voice coil.
-	  AK7375 is a 12 bit DAC with 120mA output current sink
-	  capability. This is designed for linear control of
-	  voice coil motors, controlled via I2C serial interface.
-
-config VIDEO_DW9714
-	tristate "DW9714 lens voice coil support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_ASYNC
-	help
-	  This is a driver for the DW9714 camera lens voice coil.
-	  DW9714 is a 10 bit DAC with 120mA output current sink
-	  capability. This is designed for linear control of
-	  voice coil motors, controlled via I2C serial interface.
-
-config VIDEO_DW9768
-	tristate "DW9768 lens voice coil support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_FWNODE
-	help
-	  This is a driver for the DW9768 camera lens voice coil.
-	  DW9768 is a 10 bit DAC with 100mA output current sink
-	  capability. This is designed for linear control of
-	  voice coil motors, controlled via I2C serial interface.
-
-config VIDEO_DW9807_VCM
-	tristate "DW9807 lens voice coil support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select V4L2_ASYNC
-	help
-	  This is a driver for the DW9807 camera lens voice coil.
-	  DW9807 is a 10 bit DAC with 100mA output current sink
-	  capability. This is designed for linear control of
-	  voice coil motors, controlled via I2C serial interface.
-
-endmenu
-
-menu "Flash devices"
-	visible if MEDIA_CAMERA_SUPPORT
-
-config VIDEO_ADP1653
-	tristate "ADP1653 flash support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select V4L2_ASYNC
-	help
-	  This is a driver for the ADP1653 flash controller. It is used for
-	  example in Nokia N900.
-
-config VIDEO_LM3560
-	tristate "LM3560 dual flash driver support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select REGMAP_I2C
-	select V4L2_ASYNC
-	help
-	  This is a driver for the lm3560 dual flash controllers. It controls
-	  flash, torch LEDs.
-
-config VIDEO_LM3646
-	tristate "LM3646 dual flash driver support"
-	depends on I2C && VIDEO_DEV
-	select MEDIA_CONTROLLER
-	select REGMAP_I2C
-	select V4L2_ASYNC
-	help
-	  This is a driver for the lm3646 dual flash controllers. It controls
-	  flash, torch LEDs.
-
-endmenu
-
 endif # VIDEO_DEV
-- 
2.35.1

