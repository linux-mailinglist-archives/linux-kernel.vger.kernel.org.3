Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F08F4D7381
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiCMHYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiCMHXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E63A19456B;
        Sat, 12 Mar 2022 23:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8CC660F5D;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB0BC36AF3;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=SEoSfG+lYuluvtMmAMBlE8SRRVhoii+jMefS41qBnAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvUJTRSOsZh+aN7uBJkRB9giniBGsMKhtpI/VfQ9BvJmDkuVjmtK4v/gKTxBRIyw6
         GGubcCxfk5cPMi3ApO5aG+jm4av9lai9at6Bt1+Y0pu16kkcOkZl7remXtzqp7Qhjo
         Hv9hlYiTZXt0yZ8avkeaclkJTFhcFMSg5jw9UQRcZei6EZO71+hpRTQ1aq5w9eL/d2
         R4Mjth/3e9NugeB8lc2JGbyqZ+nKXV5gvpUCH+VI7mCfLXYO7EfK6mhrJ06pAS1v3r
         zRSimTOLeI1qbHg8+21Ue/HL/j02LrwxA7wFQueE2wT8nbL8nA6EpLQM4td8N+rbf8
         5KXMWEBvCjWnQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY4-0012xA-55; Sun, 13 Mar 2022 08:21:52 +0100
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
Subject: [PATCH v3 26/39] media: platform: hva: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:35 +0100
Message-Id: <7bbe921bcbb748ee3973f56c4624c04b90317fed.1647155572.git.mchehab@kernel.org>
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
hva-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

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
index 000000000000..a092a9b146f1
--- /dev/null
+++ b/drivers/media/platform/sti/hva/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
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

