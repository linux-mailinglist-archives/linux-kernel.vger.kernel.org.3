Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223254D6336
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349450AbiCKOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349208AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DA81AD959;
        Fri, 11 Mar 2022 06:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58DC861EFA;
        Fri, 11 Mar 2022 14:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11959C34111;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007778;
        bh=YDr+LkSJ9LsOY8UPhtMHd6OG6zfQyitjAjU4i6/8mwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rstGkDpQYmG/gWcfzx7m3ztE18p618LViwjGLvAVyQrUhaOYOjdu6p1RneC4x5i8p
         NDnSl8BxCLxxSS+v+E5fd05wK+pYVt2ubPR92zmOdfU3jczzIEJmYZ4C68LPDG0imz
         CrhQHSJf0QXkCYlVKkaedfInLJNEHXoHPR9PZ7ey2n33sq6qOk4N0v6kX7aE3kFa6W
         XxX5UU0SL5+ofGfhXJF306xCPBkWtqaQgetS3Aaz7xZr4sxO6Q20sbcvojDsmFl0ky
         2OZ2N7X1lPyXuety6phZ0A5kAa2x31fGVusPf/Ay43+AMUgm0q/G5to/Gk2PeYw2Ap
         s3cmdK66UwNJQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxX-000lI5-R3; Fri, 11 Mar 2022 15:09:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 27/38] media: platform: stm32: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:40 +0100
Message-Id: <b51a1c723370e000ef658dc8a17b8d3d34102dee.1647006877.git.mchehab@kernel.org>
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
stm32-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig       | 29 +-------------------------
 drivers/media/platform/stm32/Kconfig | 31 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 28 deletions(-)
 create mode 100644 drivers/media/platform/stm32/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 7e2b120a2057..460ad793b89b 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -69,6 +69,7 @@ source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
 source "drivers/media/platform/sti/hva/Kconfig"
+source "drivers/media/platform/stm32/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -84,21 +85,6 @@ config VIDEO_MUX
 
 source "drivers/media/platform/intel/Kconfig"
 
-config VIDEO_STM32_DCMI
-	tristate "STM32 Digital Camera Memory Interface (DCMI) support"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2 && OF
-	depends on ARCH_STM32 || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select MEDIA_CONTROLLER
-	select V4L2_FWNODE
-	help
-	  This module makes the STM32 Digital Camera Memory Interface (DCMI)
-	  available as a v4l2 device.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called stm32-dcmi.
-
 config VIDEO_ROCKCHIP_ISP1
 	tristate "Rockchip Image Signal Processing v1 Unit driver"
 	depends on V4L_PLATFORM_DRIVERS
@@ -233,19 +219,6 @@ config VIDEO_STI_DELTA_DRIVER
 	select V4L2_MEM2MEM_DEV
 	select RPMSG
 
-config VIDEO_STM32_DMA2D
-	tristate "STM32 Chrom-Art Accelerator (DMA2D)"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_STM32 || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  Enables DMA2D hardware support on stm32.
-
-	  The STM32 DMA2D is a memory-to-memory engine for pixel conversion
-	  and specialized DMA dedicated to image manipulation.
-
 config VIDEO_TI_VPE
 	tristate "TI VPE (Video Processing Engine) driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/stm32/Kconfig b/drivers/media/platform/stm32/Kconfig
new file mode 100644
index 000000000000..f4726010ca14
--- /dev/null
+++ b/drivers/media/platform/stm32/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# V4L drivers
+config VIDEO_STM32_DCMI
+	tristate "STM32 Digital Camera Memory Interface (DCMI) support"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2 && OF
+	depends on ARCH_STM32 || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select MEDIA_CONTROLLER
+	select V4L2_FWNODE
+	help
+	  This module makes the STM32 Digital Camera Memory Interface (DCMI)
+	  available as a v4l2 device.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called stm32-dcmi.
+
+# Mem2mem drivers
+config VIDEO_STM32_DMA2D
+	tristate "STM32 Chrom-Art Accelerator (DMA2D)"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_STM32 || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  Enables DMA2D hardware support on stm32.
+
+	  The STM32 DMA2D is a memory-to-memory engine for pixel conversion
+	  and specialized DMA dedicated to image manipulation.
-- 
2.35.1

