Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD324D7359
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiCMHXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiCMHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2F1194555;
        Sat, 12 Mar 2022 23:21:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49CC160F53;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6A5C34115;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=2VP/D+842etQuFMo6fMzz45pTfZVm/2IyG71qbDWSJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M76jZPgwzXhef8pwkclkACbP/Wvyu1kAAzbVFua/NjZnrFrO8wd5cTokH8nJcJxPH
         ve2E1/Ab+ibCY5qTXGXFcV7G+god1fMCyWRbQZQDG2UE6TfT5vmxXMU4reFCaT/Gdn
         E7JItrx40w/l7cLJVCKO3halHFBbNdIJiCGlRzA+4Y+JO1QvW6cD9MseUpu3n5mDM2
         nYcX9LrZS6gNdpBVTH7A7ZC8tDH693hMbsPpkP38+NrKHA1DDh7eIv54gpIzr0gO0p
         cB6TKViqIezGaY5u6IdexMDiTC3KrTtQGNyiZyVoXhoXL4kSbbhSfK6T0OJsCZ1SeN
         W6CxBFsTkEC9g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY3-0012wa-O2; Sun, 13 Mar 2022 08:21:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 17/39] media: platform: mtk-mdp: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:26 +0100
Message-Id: <33f2b85ee1f2d431334d1cbb666e9ca27c47a3b3.1647155572.git.mchehab@kernel.org>
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
mtk-mdp-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 18 +-----------------
 drivers/media/platform/mtk-mdp/Kconfig | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 17 deletions(-)
 create mode 100644 drivers/media/platform/mtk-mdp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index f517aa951460..3b3d7af47ca1 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -49,6 +49,7 @@ source "drivers/media/platform/davinci/Kconfig"
 source "drivers/media/platform/exynos-gsc/Kconfig"
 source "drivers/media/platform/meson/ge2d/Kconfig"
 source "drivers/media/platform/mtk-jpeg/Kconfig"
+source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -196,23 +197,6 @@ config VIDEO_MEDIATEK_VPU
 	    To compile this driver as a module, choose M here: the
 	    module will be called mtk-vpu.
 
-config VIDEO_MEDIATEK_MDP
-	tristate "Mediatek MDP driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on MTK_IOMMU || COMPILE_TEST
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on MTK_SMI || (COMPILE_TEST && MTK_SMI=n)
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	select VIDEO_MEDIATEK_VPU
-	help
-	    It is a v4l2 driver and present in Mediatek MT8173 SoCs.
-	    The driver supports for scaling and color space conversion.
-
-	    To compile this driver as a module, choose M here: the
-	    module will be called mtk-mdp.
-
 config VIDEO_MEDIATEK_VCODEC
 	tristate "Mediatek Video Codec driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/mtk-mdp/Kconfig b/drivers/media/platform/mtk-mdp/Kconfig
new file mode 100644
index 000000000000..0cc743165a1a
--- /dev/null
+++ b/drivers/media/platform/mtk-mdp/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_MEDIATEK_MDP
+	tristate "Mediatek MDP driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on MTK_IOMMU || COMPILE_TEST
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on MTK_SMI || (COMPILE_TEST && MTK_SMI=n)
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	select VIDEO_MEDIATEK_VPU
+	help
+	    It is a v4l2 driver and present in Mediatek MT8173 SoCs.
+	    The driver supports for scaling and color space conversion.
+
+	    To compile this driver as a module, choose M here: the
+	    module will be called mtk-mdp.
-- 
2.35.1

