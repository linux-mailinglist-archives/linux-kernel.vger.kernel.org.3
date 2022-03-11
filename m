Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E479A4D6327
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349282AbiCKOLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349212AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494141B1DE2;
        Fri, 11 Mar 2022 06:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4136F61EF6;
        Fri, 11 Mar 2022 14:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B71C3410B;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=REm5O1zXHga0orubWuW1aw6Gn3vXk7hV226JWIwlseA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nu+qg21VzhhS1boSVHPzHG7m9ixYKjkVLJwDEn3THGqTlotE//mW4GyBvAaSzcp7p
         Fl11KrYCEGkgTCY4idN/foAchz3oetusoeku7wpOM7qA0TY/HAnrH9IQq/vz+23W6Q
         h8Lo4aGLLOl7lcDa+FrQDZYp46YJBHngszHn33MRMHOF6vmamwWzKpI77K21/h2uHZ
         noJU7n0utR6D4RtFYyalxDX9sJJu4uR3WYkREvigmeBceXDKG4N1z4mN4vgX/JP909
         /gQJ4F2G8NdHimt6GJnPzpvFA4kon6i1RiHx9Vm2+m8Abh0yLLK4bRfuJiDxSyya3h
         7QqIAVnE5Mk7A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxX-000lHt-MI; Fri, 11 Mar 2022 15:09:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 24/38] media: platform: s3c-camif: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:37 +0100
Message-Id: <cc0e8e8efa95426ac56fbe6c1c909f74be9a17db.1647006877.git.mchehab@kernel.org>
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
s3c-camif-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig           | 16 +---------------
 drivers/media/platform/s3c-camif/Kconfig | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 15 deletions(-)
 create mode 100644 drivers/media/platform/s3c-camif/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 2d2942e5187c..633fbc408b8c 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -66,6 +66,7 @@ source "drivers/media/platform/qcom/venus/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
+source "drivers/media/platform/s3c-camif/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -81,21 +82,6 @@ config VIDEO_MUX
 
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

