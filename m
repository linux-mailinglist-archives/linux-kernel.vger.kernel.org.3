Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927764D6329
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349348AbiCKOMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349180AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A061B3A46;
        Fri, 11 Mar 2022 06:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0348AB82C1D;
        Fri, 11 Mar 2022 14:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A50C3410C;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=KRdIAukiAE1iXMgaV/B8l6PgxS1zL00K+hAyWeU9PDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AtzAtaaAIA4c8JwpMwp9aZ5TX+e5hr4ojaIQ3lO2ESbTdmVKsbQtVPF3o4nJu2brm
         aCNhe7EYPj/ZJDNaptqP1YY5BbQ8ta82O/2jNa1LtajFkE28j3rqJiKsAAQEFk0mwW
         HsGMS+LZzsofBKpd6k7MxdVMs3Yzi5Aabzbc0MGwvKVDABz7lhnq8o2ScbPXw0Ru//
         zySTb3AK2GDxje6+5ZQe8aGn6/5rUGvHvYuO30e+jbzIj3wrkjdOSwbcqJCeTHk6d2
         e4nphns25ybX15CEKBDHRPVXALlQFfbEExJeegm5dr4DwtVHvFZLp5tLt4uxwHzg33
         Oy5KrTLgNQsmA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxX-000lI1-Pc; Fri, 11 Mar 2022 15:09:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 26/38] media: platform: hva: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:39 +0100
Message-Id: <62c52f06b5dc6eb6402cb3db2da8f02ee1bc179d.1647006877.git.mchehab@kernel.org>
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
hva-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 28 +-------------------------
 drivers/media/platform/sti/hva/Kconfig | 26 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 27 deletions(-)
 create mode 100644 drivers/media/platform/sti/hva/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 95f66255b635..7e2b120a2057 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -68,6 +68,7 @@ source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
+source "drivers/media/platform/sti/hva/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -196,33 +197,6 @@ config VIDEO_STI_BDISP
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

