Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E424D7CF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiCNICL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiCNH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3DE4133A;
        Mon, 14 Mar 2022 00:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7C9AB80D4E;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C78C3411E;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=N70UEj+Gv/zoVLq5oMy0Vtm3y4d2BgX4yy7v9Brft60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cR3hZcZp80e6WqaarkF/n2ScBBYimVs5alVhR2EH/b8vcSayV4SluoMurLEfauDWd
         eif8hedWBIcx5CbI4P+A19rCTa3MsGdAObF9LVxOftPa+a3+zqrc7CR3wgO8WfmbQl
         N/j/0JK8yrVX7NNUYeVl+bDgq+YQQ3wOg77UzjemKXlxjNXGbqGUngqWfL8nw/gAY5
         li12Jdg1n5J+g4R9PXMScOFpxZxe3ljgIIA8GqF1qSQ/zQ4BmHcOQyRXh8NV/wshIx
         oLtDDrUSt7t5KB32xSY3z7gHaDW803mEyo+P61J5XqF4RTb5KOJptIIf9pai2WVREY
         w+2ZgCRlD11vw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYd-001kVr-Co; Mon, 14 Mar 2022 08:55:59 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 26/64] media: platform: hva: move config to its own file
Date:   Mon, 14 Mar 2022 08:55:18 +0100
Message-Id: <72896146f418efb8f6b29ba4c8f884b5008e71ab.1647242579.git.mchehab@kernel.org>
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
hva-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 28 +-------------------------
 drivers/media/platform/sti/hva/Kconfig | 26 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 27 deletions(-)
 create mode 100644 drivers/media/platform/sti/hva/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0b88c36e8a83..9408096a365e 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -61,6 +61,7 @@ source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
+source "drivers/media/platform/sti/hva/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -186,33 +187,6 @@ config VIDEO_STI_BDISP
 	help
 	  This v4l2 mem2mem driver is a 2D blitter for STMicroelectronics SoC.
 
-config VIDEO_STI_HVA
-	tristate "STMicroelectronics HVA multi-format video encoder V4L2 driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_STI || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This V4L2 driver enables HVA (Hardware Video Accelerator) multi-format
-	  video encoder of STMicroelectronics SoC, allowing hardware encoding of
-	  raw uncompressed formats in various compressed video bitstreams format.
-
-	  To compile this driver as a module, choose M here:
-	  the module will be called st-hva.
-
-config VIDEO_STI_HVA_DEBUGFS
-	bool "Export STMicroelectronics HVA internals in debugfs"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_STI_HVA
-	depends on DEBUG_FS
-	help
-	  Select this to see information about the internal state and the last
-	  operation of STMicroelectronics HVA multi-format video encoder in
-	  debugfs.
-
-	  Choose N unless you know you need this.
-
 config VIDEO_STI_DELTA
 	tristate "STMicroelectronics DELTA multi-format video decoder V4L2 driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/sti/hva/Kconfig b/drivers/media/platform/sti/hva/Kconfig
new file mode 100644
index 000000000000..5651667bcc54
--- /dev/null
+++ b/drivers/media/platform/sti/hva/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_STI_HVA
+	tristate "STMicroelectronics HVA multi-format video encoder V4L2 driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_STI || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This V4L2 driver enables HVA (Hardware Video Accelerator) multi-format
+	  video encoder of STMicroelectronics SoC, allowing hardware encoding of
+	  raw uncompressed formats in various compressed video bitstreams format.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called st-hva.
+
+config VIDEO_STI_HVA_DEBUGFS
+	bool "Export STMicroelectronics HVA internals in debugfs"
+	depends on VIDEO_STI_HVA
+	depends on DEBUG_FS
+	help
+	  Select this to see information about the internal state and the last
+	  operation of STMicroelectronics HVA multi-format video encoder in
+	  debugfs.
+
+	  Choose N unless you know you need this.
-- 
2.35.1

