Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51024D7349
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiCMHXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbiCMHXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CC4194568;
        Sat, 12 Mar 2022 23:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8729460F5A;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FF0C36AE2;
        Sun, 13 Mar 2022 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156113;
        bh=F6iuoRTdka1gG43l8BQLK0fM99hoWzKdS6ESy3rRuXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/JyW93P5Jt9QYOET4sTxI/bedbYUKi/LFiGN40eyQVt0otBSjSmc8po0mRbboc+U
         qeotorhBXlRY+4FhIzE4b5sgiY3KXkSg+B+9PArF9nwO26mynipyX7EP36+Gfj4zeR
         G76yt088V69Jfv8+3GzifuWeX0DdsihqbS4zVH6VjI6cCFiMmIiN8QQYUWM2XMX0Ci
         wf97ppYrhKFBX/DzJ1SN4z/JxiOfg5YXurckIf/6u725yEezfOsFPuVXxcvVDUzaGn
         peKH1gGGGVdOB3RDitjeumCcsTFhF2rkU9QkYF30mIbmVvrQQIS1lUwXv19EqqE87k
         2nUFJWS5c2z2g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY3-0012wK-IZ; Sun, 13 Mar 2022 08:21:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v3 13/39] media: platform: coda: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:22 +0100
Message-Id: <d7b2c744c1324d6f9775f1b78674b0a76c44c2b0.1647155572.git.mchehab@kernel.org>
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
coda-specific config stuff on a separate Kconfig file.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig      | 18 +-----------------
 drivers/media/platform/coda/Kconfig | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 17 deletions(-)
 create mode 100644 drivers/media/platform/coda/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 060d6264dea4..0bf9dd5da845 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -43,6 +43,7 @@ source "drivers/media/platform/via/Kconfig"
 source "drivers/media/platform/amphion/Kconfig"
 source "drivers/media/platform/cadence/Kconfig"
 
+source "drivers/media/platform/coda/Kconfig"
 source "drivers/media/platform/davinci/Kconfig"
 
 source "drivers/media/platform/omap/Kconfig"
@@ -178,23 +179,6 @@ config VIDEO_TI_CAL_MC
 
 # Mem2mem drivers
 
-config VIDEO_CODA
-	tristate "Chips&Media Coda multi-standard codec IP"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2 && OF && (ARCH_MXC || COMPILE_TEST)
-	select SRAM
-	select VIDEOBUF2_DMA_CONTIG
-	select VIDEOBUF2_VMALLOC
-	select V4L2_JPEG_HELPER
-	select V4L2_MEM2MEM_DEV
-	select GENERIC_ALLOCATOR
-	help
-	   Coda is a range of video codec IPs that supports
-	   H.264, MPEG-4, and other video formats.
-
-config VIDEO_IMX_VDOA
-	def_tristate VIDEO_CODA if SOC_IMX6Q || COMPILE_TEST
-
 config VIDEO_MEDIATEK_JPEG
 	tristate "Mediatek JPEG Codec driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/coda/Kconfig b/drivers/media/platform/coda/Kconfig
new file mode 100644
index 000000000000..ae495fd7b25a
--- /dev/null
+++ b/drivers/media/platform/coda/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_CODA
+	tristate "Chips&Media Coda multi-standard codec IP"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2 && OF && (ARCH_MXC || COMPILE_TEST)
+	select SRAM
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	select V4L2_JPEG_HELPER
+	select V4L2_MEM2MEM_DEV
+	select GENERIC_ALLOCATOR
+	help
+	   Coda is a range of video codec IPs that supports
+	   H.264, MPEG-4, and other video formats.
+
+config VIDEO_IMX_VDOA
+	def_tristate VIDEO_CODA if SOC_IMX6Q || COMPILE_TEST
-- 
2.35.1

