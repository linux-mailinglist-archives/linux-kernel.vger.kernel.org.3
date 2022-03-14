Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60A4D7CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiCNH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiCNH5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A641613;
        Mon, 14 Mar 2022 00:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D36611C2;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BCEC341D6;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=6vh0NW6pE/2yG8lmami/Y4MhdJpgdS+SQOdsp7VPBLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bR6mhUN/1sdixB4g8PBmSz93GIE2zz8DNt362WNv2pGGNfHosVbyjtIVG65C7pej7
         5gZay5vLuOq5IJykWfNw9rKns2ef0HsX+m5VGbRlC52W4a+Xmz7l5V3qIOdCZ8hviG
         JXnhMjMbTDpCKHTCI4hdI8SRymT7Asn6G3Bt0BjgGR2D0WEXhefzehOgL2FTydgnDL
         79Lh+/+S827bz4dq4CII03IZe5lGGTybKz/2ZB1xFTVM4/14Ky+ejx0Jomp95zYP02
         nsX0UWeVukTse8rQLp0ihXRNU8YaPhL1dmN+ZOOG1eGtt9zdS+/t3u9gILbAmkLXlY
         NlMIC2R6uyLPw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYd-001kWB-Iq; Mon, 14 Mar 2022 08:55:59 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 31/64] media: platform: ti-vpe: move config to its own file
Date:   Mon, 14 Mar 2022 08:55:23 +0100
Message-Id: <12666f5d61d1232d17721f97d4cbe84a33bb4534.1647242579.git.mchehab@kernel.org>
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

In order to better organize the platform/Kconfig, place
ti-vpe-specific config stuff on a separate Kconfig file.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig        | 60 +-------------------------
 drivers/media/platform/ti-vpe/Kconfig | 62 +++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 59 deletions(-)
 create mode 100644 drivers/media/platform/ti-vpe/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index b0acbf3ccb69..228881ae0d22 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -66,6 +66,7 @@ source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
 source "drivers/media/platform/tegra/vde/Kconfig"
+source "drivers/media/platform/ti-vpe/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -106,33 +107,6 @@ source "drivers/media/platform/xilinx/Kconfig"
 source "drivers/media/platform/atmel/Kconfig"
 source "drivers/media/platform/sunxi/Kconfig"
 
-config VIDEO_TI_CAL
-	tristate "TI CAL (Camera Adaptation Layer) driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	depends on SOC_DRA7XX || ARCH_K3 || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_FWNODE
-	help
-	  Support for the TI CAL (Camera Adaptation Layer) block
-	  found on DRA72X SoC.
-	  In TI Technical Reference Manual this module is referred as
-	  Camera Interface Subsystem (CAMSS).
-
-config VIDEO_TI_CAL_MC
-	bool "Media Controller centric mode by default"
-	depends on VIDEO_TI_CAL
-	default n
-	help
-	  Enables Media Controller centric mode by default.
-
-	  If set, CAL driver will start in Media Controller mode by
-	  default. Note that this behavior can be overridden via
-	  module parameter 'mc_api'.
-
-
 # Mem2mem drivers
 
 config VIDEO_MEM2MEM_DEINTERLACE
@@ -212,37 +186,5 @@ config VIDEO_STI_DELTA_DRIVER
 	select V4L2_MEM2MEM_DEV
 	select RPMSG
 
-config VIDEO_TI_VPE
-	tristate "TI VPE (Video Processing Engine) driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on SOC_DRA7XX || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	select VIDEO_TI_VPDMA
-	select VIDEO_TI_SC
-	select VIDEO_TI_CSC
-	help
-	  Support for the TI VPE(Video Processing Engine) block
-	  found on DRA7XX SoC.
-
-config VIDEO_TI_VPE_DEBUG
-	bool "VPE debug messages"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_TI_VPE
-	help
-	  Enable debug messages on VPE driver.
-
-# TI VIDEO PORT Helper Modules
-# These will be selected by VPE and VIP
-config VIDEO_TI_VPDMA
-	tristate
-
-config VIDEO_TI_SC
-	tristate
-
-config VIDEO_TI_CSC
-	tristate
-
 # DVB platform drivers
 source "drivers/media/platform/sti/c8sectpfe/Kconfig"
diff --git a/drivers/media/platform/ti-vpe/Kconfig b/drivers/media/platform/ti-vpe/Kconfig
new file mode 100644
index 000000000000..a9ee0189f2f2
--- /dev/null
+++ b/drivers/media/platform/ti-vpe/Kconfig
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# TI VIDEO PORT Helper Modules
+# These will be selected by VPE and VIP
+config VIDEO_TI_VPDMA
+	tristate
+
+config VIDEO_TI_SC
+	tristate
+
+config VIDEO_TI_CSC
+	tristate
+
+# V4L drivers
+
+config VIDEO_TI_CAL
+	tristate "TI CAL (Camera Adaptation Layer) driver"
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on V4L_PLATFORM_DRIVERS
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	depends on SOC_DRA7XX || ARCH_K3 || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_FWNODE
+	help
+	  Support for the TI CAL (Camera Adaptation Layer) block
+	  found on DRA72X SoC.
+	  In TI Technical Reference Manual this module is referred as
+	  Camera Interface Subsystem (CAMSS).
+
+config VIDEO_TI_CAL_MC
+	bool "Media Controller centric mode by default"
+	depends on VIDEO_TI_CAL
+	default n
+	help
+	  Enables Media Controller centric mode by default.
+
+	  If set, CAL driver will start in Media Controller mode by
+	  default. Note that this behavior can be overridden via
+	  module parameter 'mc_api'.
+
+# Mem2mem drivers
+
+config VIDEO_TI_VPE
+	tristate "TI VPE (Video Processing Engine) driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on SOC_DRA7XX || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	select VIDEO_TI_VPDMA
+	select VIDEO_TI_SC
+	select VIDEO_TI_CSC
+	help
+	  Support for the TI VPE(Video Processing Engine) block
+	  found on DRA7XX SoC.
+
+config VIDEO_TI_VPE_DEBUG
+	bool "VPE debug messages"
+	depends on VIDEO_TI_VPE
+	help
+	  Enable debug messages on VPE driver.
-- 
2.35.1

