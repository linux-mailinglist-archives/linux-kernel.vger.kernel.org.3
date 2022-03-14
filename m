Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DAF4D8A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiCNQha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbiCNQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB3913D6F;
        Mon, 14 Mar 2022 09:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 673BAB80E98;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8427AC36B0A;
        Mon, 14 Mar 2022 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275707;
        bh=iDIYMYLBu8UYTkgIRAQpH16UCpol6Z3qjg5eliDPbcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaU5Ik8R007evwOF9oyRMuv99psF9OcW6VWD+ncVv1AzSfhUd/AEoaCBTY2U6FeN5
         sHPVOm7jYkhdUK8ggDULiFG4eh1FM1x/8y9A1wXv0clnPjjNJbv+994rNe5lHxu6Y6
         inIWjD2gLfsE2Cj66Df7/WQ1+w+i6GY1fSTZ87QGxcoE/Dya3ECQ4YRBSbjgn5lKSG
         rkJdsMxNF2SVMB2oSO4V05lXhkR9OVI03alcl0oki2XVDbe6EzWXdjB2mtUqEc6Xbx
         iiDgnKS/Vyzh7KAtOvyPTrYC2WTJ/9+FqmIb7c2OL0eGJqozrSfixtp93DnsEUPQsZ
         JpIoW5GDmSwnQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnez-001wxP-8C; Mon, 14 Mar 2022 17:35:05 +0100
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
Subject: [PATCH v2 20/67] media: platform: omap3isp: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:15 +0100
Message-Id: <f0717e1c41ef53f2f43d72ddccdb97dd681922c4.1647274406.git.mchehab@kernel.org>
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
omap3isp-specific config stuff on a separate Kconfig file.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig          | 22 +---------------------
 drivers/media/platform/omap3isp/Kconfig | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 21 deletions(-)
 create mode 100644 drivers/media/platform/omap3isp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 39bf4c57e044..1dac7a5b53eb 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -52,6 +52,7 @@ source "drivers/media/platform/mtk-jpeg/Kconfig"
 source "drivers/media/platform/mtk-mdp/Kconfig"
 source "drivers/media/platform/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mtk-vpu/Kconfig"
+source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -68,27 +69,6 @@ config VIDEO_MUX
 	help
 	  This driver provides support for N:1 video bus multiplexers.
 
-config VIDEO_OMAP3
-	tristate "OMAP 3 Camera support"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2 && I2C
-	depends on (ARCH_OMAP3 && OMAP_IOMMU) || COMPILE_TEST
-	depends on COMMON_CLK && OF
-	select ARM_DMA_USE_IOMMU if OMAP_IOMMU
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEOBUF2_DMA_CONTIG
-	select MFD_SYSCON
-	select V4L2_FWNODE
-	help
-	  Driver for an OMAP 3 camera controller.
-
-config VIDEO_OMAP3_DEBUG
-	bool "OMAP 3 Camera debug messages"
-	depends on VIDEO_OMAP3
-	help
-	  Enable debug messages on OMAP 3 camera controller driver.
-
 source "drivers/media/platform/intel/Kconfig"
 
 config VIDEO_QCOM_CAMSS
diff --git a/drivers/media/platform/omap3isp/Kconfig b/drivers/media/platform/omap3isp/Kconfig
new file mode 100644
index 000000000000..85f0cf063153
--- /dev/null
+++ b/drivers/media/platform/omap3isp/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_OMAP3
+	tristate "OMAP 3 Camera support"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2 && I2C
+	depends on (ARCH_OMAP3 && OMAP_IOMMU) || COMPILE_TEST
+	depends on COMMON_CLK && OF
+	select ARM_DMA_USE_IOMMU if OMAP_IOMMU
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select MFD_SYSCON
+	select V4L2_FWNODE
+	help
+	  Driver for an OMAP 3 camera controller.
+
+config VIDEO_OMAP3_DEBUG
+	bool "OMAP 3 Camera debug messages"
+	depends on VIDEO_OMAP3
+	help
+	  Enable debug messages on OMAP 3 camera controller driver.
-- 
2.35.1

