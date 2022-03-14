Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46C14D7D06
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237259AbiCNICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236911AbiCNH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D68341323;
        Mon, 14 Mar 2022 00:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 110346119F;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A7CC341C5;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=XwnuOMWav2wW/mQwSdrIlV80W2cHb8kKIf2vvbnpLzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5Taxlo+xgcPzJLl100gM8UdADsNRnBhb2WuH0paD1ngi3Kb440eMM4K//WBzoMVM
         ecOKhojeQxuT/AYzVGulO8H8qPuaGd9nyXb3lmqeIgif0wR+/pVv24vDrQUhta7krQ
         d2gKB8TlzItHuC94BuyeOngpatFI0RQJUl/jYIs1YZMFY7AwLNwcJTc6LzKuZ1tLey
         y51qxYQsP2kfhXlXZDEUNaT5Xpa8oidLFlSkKT7ruMvKInW5JyQMNG6G9ubuMh6a0g
         f2IQURv8iQIMhg4E9f8SIEaL9zb8HtXSdB9HkhOB+Z3JtNUO6eXzGBSs151Jr9u+dy
         gFwkG/gyqbZPg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYd-001kVv-E1; Mon, 14 Mar 2022 08:55:59 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 27/64] media: platform: stm32: move config to its own file
Date:   Mon, 14 Mar 2022 08:55:19 +0100
Message-Id: <bd59a9480b5bc4f257957f0883db7af024ae5fc8.1647242579.git.mchehab@kernel.org>
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
stm32-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig       | 29 +-------------------------
 drivers/media/platform/stm32/Kconfig | 31 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 28 deletions(-)
 create mode 100644 drivers/media/platform/stm32/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 9408096a365e..b14a0fc78f41 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -62,6 +62,7 @@ source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
 source "drivers/media/platform/sti/hva/Kconfig"
+source "drivers/media/platform/stm32/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -77,21 +78,6 @@ config VIDEO_MUX
 
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
@@ -223,19 +209,6 @@ config VIDEO_STI_DELTA_DRIVER
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
index 000000000000..60b87e403c7c
--- /dev/null
+++ b/drivers/media/platform/stm32/Kconfig
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: GPL-2.0-only
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

