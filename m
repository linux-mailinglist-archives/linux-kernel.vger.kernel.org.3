Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FB34D7CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiCNH6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236894AbiCNH5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FD241338;
        Mon, 14 Mar 2022 00:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6FCE61198;
        Mon, 14 Mar 2022 07:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B63C341C4;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=sSv0mD+ufRV8ZFuW7I2o0vKEQZ3EMPLVPgUWIaoyAno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzHk54JklHrOlCZwMtcKqQ/3UpVax0QcnzfgrUdXRBHvkOUqYQF76PKI7RzdJ0Cl6
         LjwDXFoq6WfHJxyvNd+Bn/Fi5jZ3hnXmX4+62U6omOODCc25xwP/8T69faIZaC0xNa
         HAKZx+whwtc3BzWqGAGrtIBZMaSRvDbVmIyCH+Ou5MqdU4U8ErT/3+pa4R/A0xcv0C
         AgvG/AEvubiYZ6ZlBd2TgFAicmeYoHgplLrZ4ssijoM5pEmr30zInB5/U767X49c4G
         g6+DDTztZytC+3Qjfk9Oyai4FLu483lPY5h320NYi57/f9/MNPI8dU9bPINwxJEwZZ
         ALCzcN1HL+3dA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYd-001kVj-AP; Mon, 14 Mar 2022 08:55:59 +0100
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
Subject: [PATCH 24/64] media: platform: s3c-camif: move config to its own file
Date:   Mon, 14 Mar 2022 08:55:16 +0100
Message-Id: <fbfdc78a48e7332ff01ce0b55249b6271f54722c.1647242579.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647242578.git.mchehab@kernel.org>
References: <cover.1647242578.git.mchehab@kernel.org>
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
s3c-camif-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig           | 16 +---------------
 drivers/media/platform/s3c-camif/Kconfig | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)
 create mode 100644 drivers/media/platform/s3c-camif/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 314e25dd7ca1..9fe01afd4145 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -59,6 +59,7 @@ source "drivers/media/platform/qcom/venus/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
+source "drivers/media/platform/s3c-camif/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -74,21 +75,6 @@ config VIDEO_MUX
 
 source "drivers/media/platform/intel/Kconfig"
 
-config VIDEO_S3C_CAMIF
-	tristate "Samsung S3C24XX/S3C64XX SoC Camera Interface driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2 && I2C && PM
-	depends on ARCH_S3C64XX || PLAT_S3C24XX || COMPILE_TEST
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEOBUF2_DMA_CONTIG
-	help
-	  This is a v4l2 driver for s3c24xx and s3c64xx SoC series camera
-	  host interface (CAMIF).
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called s3c-camif.
-
 config VIDEO_STM32_DCMI
 	tristate "STM32 Digital Camera Memory Interface (DCMI) support"
 	depends on V4L_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/s3c-camif/Kconfig b/drivers/media/platform/s3c-camif/Kconfig
new file mode 100644
index 000000000000..e8ef9e06dc1b
--- /dev/null
+++ b/drivers/media/platform/s3c-camif/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_S3C_CAMIF
+	tristate "Samsung S3C24XX/S3C64XX SoC Camera Interface driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2 && I2C && PM
+	depends on ARCH_S3C64XX || PLAT_S3C24XX || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	help
+	  This is a v4l2 driver for s3c24xx and s3c64xx SoC series camera
+	  host interface (CAMIF).
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called s3c-camif.
-- 
2.35.1

