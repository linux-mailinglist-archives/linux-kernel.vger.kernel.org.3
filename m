Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862BA4D89DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244140AbiCNQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243177AbiCNQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D0A140E9;
        Mon, 14 Mar 2022 09:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C005C6143A;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BD2C36AF3;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275708;
        bh=7CzxiehJOBa+ZNQWPhXLdm88K+SSD8Mw7asmh6OyhKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjnecuqwXCShMq1YmDI8yNJ+/ulNHYWMzEho6yiSlaY393SMZKofWi7JNv/lsP91H
         x6HYsk5I2PyLfguraYAAdQ2Ye7QHwwv+r5znzliFtT559AUEW6oToxqQCYhjfCn/Da
         2hkYE2fKLxk5DeroDcgMEGOj3B1c7X8Wk+wAogpZ4gXgxTMjAVGvO9VJLftazOVHJH
         u2pyw3JJuTs+3kqTreMGdtN759ZIRHkyKDoBycuoYviXMGcwHtc5vqT2GtDb/qLmVn
         lcVPS6WYo0KgZlcemjpI4Hct6gaE+vkK/0xABVMjTETogLfSC1mZvy1SHhoGZWq2Ru
         T35C19pLttnmw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf0-001wyS-50; Mon, 14 Mar 2022 17:35:06 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 36/67] media: platform: s5p-jpeg: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:31 +0100
Message-Id: <e157601ebb3a83855f7a32c3907c80eff34756e2.1647274406.git.mchehab@kernel.org>
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
s5p-jpeg-specific config stuff on a separate Kconfig file.

Acked-by: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig          | 13 +------------
 drivers/media/platform/s5p-jpeg/Kconfig | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)
 create mode 100644 drivers/media/platform/s5p-jpeg/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index fd6b18ac0c7c..d5aedc6b5ca3 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -62,6 +62,7 @@ source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/rockchip/rkisp1/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
+source "drivers/media/platform/s5p-jpeg/Kconfig"
 source "drivers/media/platform/sti/hva/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
@@ -101,18 +102,6 @@ config VIDEO_MEM2MEM_DEINTERLACE
 	help
 	    Generic deinterlacing V4L2 driver.
 
-
-config VIDEO_SAMSUNG_S5P_JPEG
-	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This is a v4l2 driver for Samsung S5P, EXYNOS3250
-	  and EXYNOS4 JPEG codec
-
 source "drivers/media/platform/s5p-mfc/Kconfig"
 
 source "drivers/media/platform/sti/bdisp/Kconfig"
diff --git a/drivers/media/platform/s5p-jpeg/Kconfig b/drivers/media/platform/s5p-jpeg/Kconfig
new file mode 100644
index 000000000000..e522860d2b15
--- /dev/null
+++ b/drivers/media/platform/s5p-jpeg/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config VIDEO_SAMSUNG_S5P_JPEG
+	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a v4l2 driver for Samsung S5P, EXYNOS3250
+	  and EXYNOS4 JPEG codec
-- 
2.35.1

