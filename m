Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC84D738A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiCMHYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiCMHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FEE194578;
        Sat, 12 Mar 2022 23:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5EF260F67;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5EBC341D2;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=h3+eFKVsxgNvApH2Ao59ocpbNLRi1y8Jxm3e7zSePjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/vY7IgZx/09lDnUPp19/7u8MPdj4UzjSWZDeRe91obpwq0NM7UsTsT7riGniq1xH
         ZyV9xqCXVbWkRuMK5sizKd4NJcVlX3ABui+16AOf/O+d56jRcjxvL2RI4cjbeSL3Gg
         lyTc+r+scvbS6kyiRkZ+OBwEJ6FTuelPqEJljMiHeJlww8QAeELOu7dr0YRb2g8gQJ
         nqwPvt/gr/fuvo9x4N6ynbEL0uzjL8WVyTsT2ESnIJAJEsCUHvEiHY2loYOjccdCIU
         nOuzMTp/gePLC67tz9/zf6wm9+2D7L/OZXgTOKPMgnzsYAiJtN9WMxdteXUOdgW009
         R8z6dIOfDEtnw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY4-0012xc-E4; Sun, 13 Mar 2022 08:21:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 33/39] media: platform: delta: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:42 +0100
Message-Id: <60926eb6c8f1f6677dbe34acd84c1f0601b7f245.1647155572.git.mchehab@kernel.org>
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
delta-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig           | 36 +-----------------------
 drivers/media/platform/sti/delta/Kconfig | 36 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 35 deletions(-)
 create mode 100644 drivers/media/platform/sti/delta/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 29afef26cbe4..ba4c10896537 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -132,41 +132,7 @@ config VIDEO_STI_BDISP
 	help
 	  This v4l2 mem2mem driver is a 2D blitter for STMicroelectronics SoC.
 
-config VIDEO_STI_DELTA
-	tristate "STMicroelectronics DELTA multi-format video decoder V4L2 driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_STI || COMPILE_TEST
-	help
-		This V4L2 driver enables DELTA multi-format video decoder
-		of STMicroelectronics STiH4xx SoC series allowing hardware
-		decoding of various compressed video bitstream format in
-		raw uncompressed format.
-
-		Use this option to see the decoders available for such
-		hardware.
-
-		Please notice that the driver will only be built if
-		at least one of the DELTA decoder below is selected.
-
-config VIDEO_STI_DELTA_MJPEG
-	bool "STMicroelectronics DELTA MJPEG support"
-	default y
-	depends on VIDEO_STI_DELTA
-	help
-		Enables DELTA MJPEG hardware support.
-
-		To compile this driver as a module, choose M here:
-		the module will be called st-delta.
-
-config VIDEO_STI_DELTA_DRIVER
-	tristate
-	depends on VIDEO_STI_DELTA
-	depends on VIDEO_STI_DELTA_MJPEG
-	default VIDEO_STI_DELTA_MJPEG
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	select RPMSG
+source "drivers/media/platform/sti/delta/Kconfig"
 
 # DVB platform drivers
 source "drivers/media/platform/sti/c8sectpfe/Kconfig"
diff --git a/drivers/media/platform/sti/delta/Kconfig b/drivers/media/platform/sti/delta/Kconfig
new file mode 100644
index 000000000000..0bbc7edce208
--- /dev/null
+++ b/drivers/media/platform/sti/delta/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_STI_DELTA
+	tristate "STMicroelectronics DELTA multi-format video decoder V4L2 driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_STI || COMPILE_TEST
+	help
+		This V4L2 driver enables DELTA multi-format video decoder
+		of STMicroelectronics STiH4xx SoC series allowing hardware
+		decoding of various compressed video bitstream format in
+		raw uncompressed format.
+
+		Use this option to see the decoders available for such
+		hardware.
+
+		Please notice that the driver will only be built if
+		at least one of the DELTA decoder below is selected.
+
+config VIDEO_STI_DELTA_MJPEG
+	bool "STMicroelectronics DELTA MJPEG support"
+	default y
+	depends on VIDEO_STI_DELTA
+	help
+		Enables DELTA MJPEG hardware support.
+
+		To compile this driver as a module, choose M here:
+		the module will be called st-delta.
+
+config VIDEO_STI_DELTA_DRIVER
+	tristate
+	depends on VIDEO_STI_DELTA
+	depends on VIDEO_STI_DELTA_MJPEG
+	default VIDEO_STI_DELTA_MJPEG
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	select RPMSG
-- 
2.35.1

