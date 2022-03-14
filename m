Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4B34D8998
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbiCNQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbiCNQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C2913D7C;
        Mon, 14 Mar 2022 09:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52BC961403;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C1CC36AE2;
        Mon, 14 Mar 2022 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275707;
        bh=RDBawNucX7GVbj7v6fMyJ+XspQaSaH+FwtEpq8ue/vI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQhY7v3Fg+CSA2E8gcEKxdifGbAnuk6h6tj2g3ASLqfKUu2rGOaH6tJd0TazrzKKs
         78d4YotvdEBN4W5iiSYPkGgyHcT1Yo+N7aJLCz1ZAQ8TFKh1nhFwiWNXjc+f1c4p6q
         YMeJs3WVJs/oGJNHQlhSIy9B6gdiIrkXXnr7uH9fafebqfPHLP86a6xYgfM3eU1HnS
         4a9BaVv4maT9ibWxZRk3wtJvNI/HwcowEbgqiy+EcbjFV4uICuCZ1enMS2Ygok0jU2
         5JsCKv1HP/6RCsgfh8+b+5NeyS+DDcMTEtSbuQbt+sl/CXiLE8hw+0sjqwYudZcJ95
         hZBddHr4oDOMw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnez-001wxH-5i; Mon, 14 Mar 2022 17:35:05 +0100
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
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 18/67] media: platform: mtk-vcodec: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:13 +0100
Message-Id: <39b7b40cabbdec8b8c2d263a1d040b1bd74e8775.1647274406.git.mchehab@kernel.org>
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
mtk-vcodec-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig            | 37 +----------------------
 drivers/media/platform/mtk-vcodec/Kconfig | 36 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 36 deletions(-)
 create mode 100644 drivers/media/platform/mtk-vcodec/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 3b3d7af47ca1..ab7c85613625 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -50,6 +50,7 @@ source "drivers/media/platform/exynos-gsc/Kconfig"
 source "drivers/media/platform/meson/ge2d/Kconfig"
 source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
+source "drivers/media/platform/mtk-vcodec/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -197,42 +198,6 @@ config VIDEO_MEDIATEK_VPU
 	    To compile this driver as a module, choose M here: the
 	    module will be called mtk-vpu.
 
-config VIDEO_MEDIATEK_VCODEC
-	tristate "Mediatek Video Codec driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on MTK_IOMMU || COMPILE_TEST
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on VIDEO_MEDIATEK_VPU || MTK_SCP
-	# The two following lines ensure we have the same state ("m" or "y") as
-	# our dependencies, to avoid missing symbols during link.
-	depends on VIDEO_MEDIATEK_VPU || !VIDEO_MEDIATEK_VPU
-	depends on MTK_SCP || !MTK_SCP
-	depends on MTK_SMI || (COMPILE_TEST && MTK_SMI=n)
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	select VIDEO_MEDIATEK_VCODEC_VPU if VIDEO_MEDIATEK_VPU
-	select VIDEO_MEDIATEK_VCODEC_SCP if MTK_SCP
-	select V4L2_H264
-	select MEDIA_CONTROLLER
-	select MEDIA_CONTROLLER_REQUEST_API
-	help
-	  Mediatek video codec driver provides HW capability to
-	  encode and decode in a range of video formats on MT8173
-	  and MT8183.
-
-	  Note that support for MT8173 requires VIDEO_MEDIATEK_VPU to
-	  also be selected. Support for MT8183 depends on MTK_SCP.
-
-	  To compile this driver as modules, choose M here: the
-	  modules will be called mtk-vcodec-dec and mtk-vcodec-enc.
-
-config VIDEO_MEDIATEK_VCODEC_VPU
-	bool
-
-config VIDEO_MEDIATEK_VCODEC_SCP
-	bool
-
 config VIDEO_MEM2MEM_DEINTERLACE
 	tristate "Deinterlace support"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/mtk-vcodec/Kconfig b/drivers/media/platform/mtk-vcodec/Kconfig
new file mode 100644
index 000000000000..635801a19d55
--- /dev/null
+++ b/drivers/media/platform/mtk-vcodec/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_MEDIATEK_VCODEC_SCP
+	bool
+
+config VIDEO_MEDIATEK_VCODEC_VPU
+	bool
+
+config VIDEO_MEDIATEK_VCODEC
+	tristate "Mediatek Video Codec driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on MTK_IOMMU || COMPILE_TEST
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on VIDEO_MEDIATEK_VPU || MTK_SCP
+	# The two following lines ensure we have the same state ("m" or "y") as
+	# our dependencies, to avoid missing symbols during link.
+	depends on VIDEO_MEDIATEK_VPU || !VIDEO_MEDIATEK_VPU
+	depends on MTK_SCP || !MTK_SCP
+	depends on MTK_SMI || (COMPILE_TEST && MTK_SMI=n)
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	select VIDEO_MEDIATEK_VCODEC_VPU if VIDEO_MEDIATEK_VPU
+	select VIDEO_MEDIATEK_VCODEC_SCP if MTK_SCP
+	select V4L2_H264
+	select MEDIA_CONTROLLER
+	select MEDIA_CONTROLLER_REQUEST_API
+	help
+	  Mediatek video codec driver provides HW capability to
+	  encode and decode in a range of video formats on MT8173
+	  and MT8183.
+
+	  Note that support for MT8173 requires VIDEO_MEDIATEK_VPU to
+	  also be selected. Support for MT8183 depends on MTK_SCP.
+
+	  To compile this driver as modules, choose M here: the
+	  modules will be called mtk-vcodec-dec and mtk-vcodec-enc.
-- 
2.35.1

