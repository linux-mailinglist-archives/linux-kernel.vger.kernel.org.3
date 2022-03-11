Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6994D632A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349326AbiCKOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349214AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671491B30BA;
        Fri, 11 Mar 2022 06:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43FA2B82C20;
        Fri, 11 Mar 2022 14:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746CEC3411D;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007778;
        bh=uF410uTTIIoLi4ctpRlz53OQDOaMP/Hjobd3JBwfHvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rADu7JvshrxX7lrh9+lCSzZ6kIsKGy+v++ClPr6P4bF4FTgUQPEDgsezfZKC+QqzS
         A73k3TpWxKzzEJ2FIbdyJpJyMV/0Np0M32XbALyFpEHjHRbda52iFfIgrC5QMsVjDu
         01tyNLNcCgA+fPDxm8dgRIkKTKPK44hVoh41V2Ard0Fthx7Px3pMAmi5sg7ROMEKBA
         NPjUTHhmF/og/MjWTJ9vkWqhNpiHlRPaTd39qKYGhprfM1IOpIWGJbZYwAs7PiqWHp
         Ql2egw4oWo5/M4W9cqjMV4JbZR113odRQhZAeAYi61R0IsXN6TdFrxFuSA+Xtc9S4G
         EtGOtdeyAEjhg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxY-000lIT-6r; Fri, 11 Mar 2022 15:09:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 33/38] media: platform: delta: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:46 +0100
Message-Id: <bf91fcbb6f2ae8c05c1dfb8ce9d51acc2aba667d.1647006877.git.mchehab@kernel.org>
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
delta-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig           | 36 +-----------------------
 drivers/media/platform/sti/delta/Kconfig | 36 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 35 deletions(-)
 create mode 100644 drivers/media/platform/sti/delta/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 620c7f1d5033..c5eb97199e2e 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -142,41 +142,7 @@ config VIDEO_STI_BDISP
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

