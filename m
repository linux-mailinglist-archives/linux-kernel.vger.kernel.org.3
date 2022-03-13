Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0447C4D7389
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbiCMHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiCMHXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6027319456C;
        Sat, 12 Mar 2022 23:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1D1060F62;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133F6C34118;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=UNkjZC/qtBH4vLA3o5EPqFuToyxjw8bWymaANWe0Gsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PnQ60rMFa6cS8VTbb/Ey/IRWfwX1W/IvtdIkYyoVwEaCrersZS7ZKyLMDqnhXZG/3
         5PVdJwyxllFWbp20hq+syS9CuiVBpzPCRnZj+w+pwVc3zigYXjMiqcxh/w3uIPzy1o
         R6QIfa0ijkotPeJ8b8Zmjw0M4eXCqekUsahUJSGDSNxdN2ZUeRbszAcfXHwxMFRLDA
         cME4Z18ZrZ1jSne0kQEbYWeU/tSDalt7DZ0c/LLyKnKPPyvBHiDOGCtOH871Kurtps
         wluacjMO4S8gVWXR5P2Kxe6m64y4oT0hjX55DL8eHnv0SjNleou+H+vW9WzmMrPijL
         mZXM7peIMLPFw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY3-0012wi-RC; Sun, 13 Mar 2022 08:21:51 +0100
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
        Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v3 19/39] media: platform: mtk-vpu: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:28 +0100
Message-Id: <8cc26630206e292f2349e6210f124f9520fb84ab.1647155572.git.mchehab@kernel.org>
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
mtk-vpu-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 15 +--------------
 drivers/media/platform/mtk-vpu/Kconfig | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)
 create mode 100644 drivers/media/platform/mtk-vpu/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index ab7c85613625..39bf4c57e044 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -51,6 +51,7 @@ source "drivers/media/platform/meson/ge2d/Kconfig"
 source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/mtk-vcodec/Kconfig"
+source "drivers/media/platform/mtk-vpu/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -184,20 +185,6 @@ config VIDEO_TI_CAL_MC
 
 # Mem2mem drivers
 
-config VIDEO_MEDIATEK_VPU
-	tristate "Mediatek Video Processor Unit"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	help
-	    This driver provides downloading VPU firmware and
-	    communicating with VPU. This driver for hw video
-	    codec embedded in Mediatek's MT8173 SOCs. It is able
-	    to handle video decoding/encoding in a range of formats.
-
-	    To compile this driver as a module, choose M here: the
-	    module will be called mtk-vpu.
-
 config VIDEO_MEM2MEM_DEINTERLACE
 	tristate "Deinterlace support"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/mtk-vpu/Kconfig b/drivers/media/platform/mtk-vpu/Kconfig
new file mode 100644
index 000000000000..df679ea79ed0
--- /dev/null
+++ b/drivers/media/platform/mtk-vpu/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config VIDEO_MEDIATEK_VPU
+	tristate "Mediatek Video Processor Unit"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	    This driver provides downloading VPU firmware and
+	    communicating with VPU. This driver for hw video
+	    codec embedded in Mediatek's MT8173 SOCs. It is able
+	    to handle video decoding/encoding in a range of formats.
+
+	    To compile this driver as a module, choose M here: the
+	    module will be called mtk-vpu.
-- 
2.35.1

