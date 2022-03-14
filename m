Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F894D89FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiCNQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbiCNQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6A813CC7;
        Mon, 14 Mar 2022 09:35:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B302B80E8F;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E235C36B03;
        Mon, 14 Mar 2022 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275707;
        bh=oR/Nqcf8uV2nNNdkbYKq+1DFuBdrsIdZT4cOwhjy4dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ptmuRLEs3wsSnLiRNvUZ1PXi3FQm4MWbMq/SMJOg++sKPzZJtjXP9Yildc5p5Cm6l
         Rvn+/K5dhAo6z1+i4oYQMl9cq2UDtSQ/oy+YPibFO7/7fLu1QbKQyqLFSS1aeSfcHu
         GQvU8I4LWlGAJaAsOW8qfUiTYjkVzeDRRrtLvq8fiwg8oUyCNtzXlC0oZQZeG61AAN
         +ecOPn/1RbBOdztRLf+ZcGE353/WrM4URrKFKrWPecCGceDPPHWBIFnAXgwZr/IhEX
         +Zby3Ygp17AhancB3vWZLzlt8Xjk5l9xlL45NoZ4twLZE/Dx2bDWkpUDcG07zeJpJk
         QrGD/KOVLxz+g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnez-001wx9-3O; Mon, 14 Mar 2022 17:35:05 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 16/67] media: platform: mtk-jpeg: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:11 +0100
Message-Id: <d46abc044bbbab877446adb362d28794a67493ac.1647274406.git.mchehab@kernel.org>
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
mtk-jpeg-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig          | 17 +----------------
 drivers/media/platform/mtk-jpeg/Kconfig | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)
 create mode 100644 drivers/media/platform/mtk-jpeg/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index d3b7bef19237..f517aa951460 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -48,6 +48,7 @@ source "drivers/media/platform/davinci/Kconfig"
 
 source "drivers/media/platform/exynos-gsc/Kconfig"
 source "drivers/media/platform/meson/ge2d/Kconfig"
+source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -181,22 +182,6 @@ config VIDEO_TI_CAL_MC
 
 # Mem2mem drivers
 
-config VIDEO_MEDIATEK_JPEG
-	tristate "Mediatek JPEG Codec driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on MTK_IOMMU_V1 || MTK_IOMMU || COMPILE_TEST
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on MTK_SMI || (COMPILE_TEST && MTK_SMI=n)
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  Mediatek jpeg codec driver provides HW capability to decode
-	  JPEG format
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called mtk-jpeg
-
 config VIDEO_MEDIATEK_VPU
 	tristate "Mediatek Video Processor Unit"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/mtk-jpeg/Kconfig b/drivers/media/platform/mtk-jpeg/Kconfig
new file mode 100644
index 000000000000..72ed920b011a
--- /dev/null
+++ b/drivers/media/platform/mtk-jpeg/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_MEDIATEK_JPEG
+	tristate "Mediatek JPEG Codec driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on MTK_IOMMU_V1 || MTK_IOMMU || COMPILE_TEST
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on MTK_SMI || (COMPILE_TEST && MTK_SMI=n)
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  Mediatek jpeg codec driver provides HW capability to decode
+	  JPEG format
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mtk-jpeg
-- 
2.35.1

