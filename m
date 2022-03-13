Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828224D738D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiCMHZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiCMHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7C51945E0;
        Sat, 12 Mar 2022 23:21:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5C9DB80C83;
        Sun, 13 Mar 2022 07:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5070DC36AEA;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=YSKByXXCIKvIIi/1WY3ewhC/gmLtShCM9oRTe4wXDqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Up59hgssGojXQ2Wx7LTihBOK1qdmPt61OzpOZkPMEiAj2kVnOlNppUTG3VC7wgFDa
         eGl9oMa9LBhE4J0JD2l4P+Oguly52dFCmb6xOCrPtuVoaVHK1FT1Dr1wzzHumCbwzg
         UjPX1+vri5HZ5fFdYDf1YN/Tt21X9LBWAHVU/ncKZVJQQ6CYjAy9j9CuogH+33c4wX
         j4WFMQ8ynrx9eQqGXRvqdAIr8PhUl9dmtIv3NhBuo+ie69pu9eIwxscRR1q3plnxz7
         Tr+yEtN2kmNw6GyfDY/liIPIrA/CxyI0+2m+yn3n163Nt3ZObyGyMhHt61OJ8/6KkS
         lajSzniDHGVNA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY4-0012x6-3f; Sun, 13 Mar 2022 08:21:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 25/39] media: platform: s5p-g2d: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:34 +0100
Message-Id: <05d2a925432c16ace279739f903ab9d4ecf8bb5f.1647155572.git.mchehab@kernel.org>
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
s5p-g2d-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 11 +----------
 drivers/media/platform/s5p-g2d/Kconfig | 11 +++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)
 create mode 100644 drivers/media/platform/s5p-g2d/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 9fe01afd4145..0b88c36e8a83 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -60,6 +60,7 @@ source "drivers/media/platform/qcom/venus/Kconfig"
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
+source "drivers/media/platform/s5p-g2d/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -154,16 +155,6 @@ config VIDEO_MEM2MEM_DEINTERLACE
 	help
 	    Generic deinterlacing V4L2 driver.
 
-config VIDEO_SAMSUNG_S5P_G2D
-	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This is a v4l2 driver for Samsung S5P and EXYNOS4 G2D
-	  2d graphics accelerator.
 
 config VIDEO_SAMSUNG_S5P_JPEG
 	tristate "Samsung S5P/Exynos3250/Exynos4 JPEG codec driver"
diff --git a/drivers/media/platform/s5p-g2d/Kconfig b/drivers/media/platform/s5p-g2d/Kconfig
new file mode 100644
index 000000000000..9bc9d90a666a
--- /dev/null
+++ b/drivers/media/platform/s5p-g2d/Kconfig
@@ -0,0 +1,11 @@
+config VIDEO_SAMSUNG_S5P_G2D
+	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a v4l2 driver for Samsung S5P and EXYNOS4 G2D
+	  2d graphics accelerator.
+
-- 
2.35.1

