Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4C4D738F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiCMHZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiCMHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCB1945D5;
        Sat, 12 Mar 2022 23:21:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65F25B80C72;
        Sun, 13 Mar 2022 07:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DACEC34117;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=eLEI4oeSsCl+uzKtV6SpZ5U9puxVwwlSCrl24xkkey8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqeKD2zNOfttzVC1I62BqdZ6VAptdBHyPO0jQX+rg29iWjfLgTGafYu5lvovP3O23
         lsd1o/5BBvCFhGsKK2loUdc/ELmJVZ/NKPXbtDF2FCBhQiYXw04t38l6swNOlj3x/0
         lYi4oNIRxFOgMV3GaoS46ywh6XwxDP+AHb3Bknz017AUEqiqJ4coBjwQxK5GfAw3PK
         ZBHmO76Di0gEXnOoTCUtdgknkHthnE14N540RyrdgoEwezT5DU9wD9wpc6ffuHsBqg
         2udzpjDiTO/bqpfbSAqJIas7MNShpxkeh5P7PPFhfk51Khr6C1NQELWc6zy1sWHBgj
         B+Ks+5R43qKdg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY3-0012wm-Sj; Sun, 13 Mar 2022 08:21:51 +0100
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
Subject: [PATCH v3 20/39] media: platform: omap3isp: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:29 +0100
Message-Id: <53bbab3062d7735c7ef9a4e6897ec69cd0c6ac8c.1647155572.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647155572.git.mchehab@kernel.org>
References: <cover.1647155572.git.mchehab@kernel.org>
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
omap3isp-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig          | 22 +---------------------
 drivers/media/platform/omap3isp/Kconfig | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 21 deletions(-)
 create mode 100644 drivers/media/platform/omap3isp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 39bf4c57e044..1dac7a5b53eb 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -52,6 +52,7 @@ source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mtk-vpu/Kconfig"
+source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -68,27 +69,6 @@ config VIDEO_MUX
 	help
 	  This driver provides support for N:1 video bus multiplexers.
 
-config VIDEO_OMAP3
-	tristate "OMAP 3 Camera support"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2 && I2C
-	depends on (ARCH_OMAP3 && OMAP_IOMMU) || COMPILE_TEST
-	depends on COMMON_CLK && OF
-	select ARM_DMA_USE_IOMMU if OMAP_IOMMU
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEOBUF2_DMA_CONTIG
-	select MFD_SYSCON
-	select V4L2_FWNODE
-	help
-	  Driver for an OMAP 3 camera controller.
-
-config VIDEO_OMAP3_DEBUG
-	bool "OMAP 3 Camera debug messages"
-	depends on VIDEO_OMAP3
-	help
-	  Enable debug messages on OMAP 3 camera controller driver.
-
 source "drivers/media/platform/intel/Kconfig"
 
 config VIDEO_QCOM_CAMSS
diff --git a/drivers/media/platform/omap3isp/Kconfig b/drivers/media/platform/omap3isp/Kconfig
new file mode 100644
index 000000000000..85f0cf063153
--- /dev/null
+++ b/drivers/media/platform/omap3isp/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_OMAP3
+	tristate "OMAP 3 Camera support"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2 && I2C
+	depends on (ARCH_OMAP3 && OMAP_IOMMU) || COMPILE_TEST
+	depends on COMMON_CLK && OF
+	select ARM_DMA_USE_IOMMU if OMAP_IOMMU
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select MFD_SYSCON
+	select V4L2_FWNODE
+	help
+	  Driver for an OMAP 3 camera controller.
+
+config VIDEO_OMAP3_DEBUG
+	bool "OMAP 3 Camera debug messages"
+	depends on VIDEO_OMAP3
+	help
+	  Enable debug messages on OMAP 3 camera controller driver.
-- 
2.35.1

