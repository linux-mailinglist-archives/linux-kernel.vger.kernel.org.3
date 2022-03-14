Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D223E4D89DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243676AbiCNQiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243126AbiCNQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2295C13DF3;
        Mon, 14 Mar 2022 09:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901BC61414;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1391C36B1C;
        Mon, 14 Mar 2022 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275707;
        bh=HBH1DclUQBbMV92/Z7EzE7rotCUoC5aTPr/ADW851Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkLGAJFobZTP2F+6TOappqPOssnq5wOBalo39xZ86GWO55UMn4mmFBkdYzPG9Hhyt
         YAzWyROIXx0CNpvP4P8V2JTeNmKvplLcRq0NyLHfjWBUf26tHizNFxMsWKhPy5hAhH
         VAu5KhILjhED+xLIUHpJC+oz+WVYiW1Mh93CxqJVv/djcU9mhiwLpF4e+Lv7D43uZr
         OR8P1rwjLP76DaVnSFvLIGaKL3aoBD2tYz7NFDUm2yt46FF9dduYCew/ggFhvVZqgB
         HE5Cemf/Kbo+/Jn5QThqH1PKgNcKwv8+CODLI9FnVMpeZ2llVakcJY6vEo8YCG/6rR
         /ZCFb3KMBwsJg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnez-001wxn-IV; Mon, 14 Mar 2022 17:35:05 +0100
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
Subject: [PATCH v2 26/67] media: platform: hva: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:21 +0100
Message-Id: <d62e8531e4c3dd4bbe7223ebb2766157a3b1ee61.1647274406.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647274406.git.mchehab@kernel.org>
References: <cover.1647274406.git.mchehab@kernel.org>
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
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

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

