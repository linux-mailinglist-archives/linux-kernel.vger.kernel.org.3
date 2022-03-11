Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA7F4D6334
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiCKOMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349216AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A91B3A47;
        Fri, 11 Mar 2022 06:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 497A5B82C16;
        Fri, 11 Mar 2022 14:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0AEC34100;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=f6rVcnC4NQzIhGu0zc2CZYVuVZxuemnCqfneah5wGCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAHgHdUE4MR2wobRq8B5mp9TSRW+4vNhxY6xwptFcuOFkRehjjecSMPJK4v3ON11n
         9uiHAvqB+uvlFZJoXAaLVq/ujksbijaGKfKqj+13zYKyYoqSOklGkfRGSuja4sOvSw
         isyE1FSBOPIL0mclpUMQ/rPnkiQLDDBLFwU2Qks/AHIasZFMUEdx+C1qlOIyxQP001
         mMbSaoE/imG8Dk0eVNsHnpXqq567+YFe91zirCCfkStc5Sa6w3Xt9hSL7PyUQ1NBps
         sUubhTVV0VHDCG4wtR3fytJMAoBvG3TmVKjvkuQOxLJ4GklW77UV/w9Z5q5K6bCYhL
         iJVZ2SNLMfO9g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxX-000lHZ-CZ; Fri, 11 Mar 2022 15:09:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 19/38] media: platform: mtk-vpu: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:32 +0100
Message-Id: <6064dc98df604cbc70a6d58df471a74e78c03338.1647006877.git.mchehab@kernel.org>
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
mtk-vpu-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 15 +--------------
 drivers/media/platform/mtk-vpu/Kconfig | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)
 create mode 100644 drivers/media/platform/mtk-vpu/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 4553e7fc193c..1c6358d6fa89 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -58,6 +58,7 @@ source "drivers/media/platform/meson/ge2d/Kconfig"
 source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/mtk-vcodec/Kconfig"
+source "drivers/media/platform/mtk-vpu/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -195,20 +196,6 @@ config VIDEO_TI_CAL_MC
 
 source "drivers/media/platform/imx-jpeg/Kconfig"
 
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

