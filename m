Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8C64D7393
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiCMHZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiCMHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B31945CA;
        Sat, 12 Mar 2022 23:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C29360F80;
        Sun, 13 Mar 2022 07:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EC8C340FA;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=NuPqiaM++04yo79KJFjhJmC2/r7rL/qgIrASqOVQOBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeWkZxiMaQhAdU6WDc7XDExcshbXRmEuXpQHyQ88xygPaYujoNIQxiHWeUCPcLV4B
         /QcM64J+XCkrIlN/Ekuzla2VJwmJrND4NDRUlhPwhOTITocI4vdpkwdcwFx121yLGG
         cDtAibRu6UGVXGk+KwXOCyvl2dQFYYto7AjAShBsI2rh2r1QnE4n9jXcDD/M2vuB6s
         NT9PFJyHQLckTpB0SutfD9JYdF7dw4GAJLw32kr6tTZSygy42keV3tNHmdyHy8oeGe
         LtbZAeXSgScielkSUpPskcmqagyNCz28M4Q7nu7fockLxzVSHkKDEBKH+uaAWDrS5C
         8rG38MQRHu/qw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY4-0012xI-7q; Sun, 13 Mar 2022 08:21:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Chen-Yu Tsai <wens@csie.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v3 28/39] media: platform: sun8i-di: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:37 +0100
Message-Id: <95fe5cc182658713be7dd6c977ff6e10e3b75c9f.1647155572.git.mchehab@kernel.org>
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
sun8i-di-specific config stuff on a separate Kconfig file.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                | 15 +--------------
 drivers/media/platform/sunxi/sun8i-di/Kconfig | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)
 create mode 100644 drivers/media/platform/sunxi/sun8i-di/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index b14a0fc78f41..61f8a8fae109 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -63,6 +63,7 @@ source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
 source "drivers/media/platform/sti/hva/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
+source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -230,20 +231,6 @@ config VIDEO_TI_VPE_DEBUG
 	help
 	  Enable debug messages on VPE driver.
 
-config VIDEO_SUN8I_DEINTERLACE
-	tristate "Allwinner Deinterlace driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_SUNXI || COMPILE_TEST
-	depends on COMMON_CLK && OF
-	depends on PM
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	   Support for the Allwinner deinterlace unit with scaling
-	   capability found on some SoCs, like H3.
-	   To compile this driver as a module choose m here.
-
 config VIDEO_SUN8I_ROTATE
 	tristate "Allwinner DE2 rotation driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/sunxi/sun8i-di/Kconfig b/drivers/media/platform/sunxi/sun8i-di/Kconfig
new file mode 100644
index 000000000000..8d762e664d45
--- /dev/null
+++ b/drivers/media/platform/sunxi/sun8i-di/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_SUN8I_DEINTERLACE
+	tristate "Allwinner Deinterlace driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on COMMON_CLK && OF
+	depends on PM
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	   Support for the Allwinner deinterlace unit with scaling
+	   capability found on some SoCs, like H3.
+	   To compile this driver as a module choose m here.
-- 
2.35.1

