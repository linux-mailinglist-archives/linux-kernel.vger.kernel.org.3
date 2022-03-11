Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A7C4D6337
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349286AbiCKOLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349203AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457D71B1253;
        Fri, 11 Mar 2022 06:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35C1E61EE2;
        Fri, 11 Mar 2022 14:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C355C3411A;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007778;
        bh=8fPtgWEWhfdsdxzQxw0ENPfLd8su7s6eT5U7kXM3BDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgdwBTX05EkbDFu3nabVGEhVRJtuH856hi/VjLEW4qXRG2p47CN+tf/PdfKVBXwPe
         mu9fm3oWriffZB69x9BCasvVDGL3NVpF7vXtzg5lctXwsYkhf1RLZ8Y4fwLPSGH6UF
         IykWTtesYfpN8335xVs4lcwcTsnuIlrfDb1b6T+N57FdP1Hgnw/vvAE5hYglKk38NO
         5gWfoiojUpGAL2NH8XB4E6ckV7C/jX7ho3KSpTYBuhgtnTXfJABVCuN+XAmLPo6mHB
         fyjkTc1LEEm6hSPpoAnxuarGTnqZgMcLxdz3mmwkr46E5gOTU+XBkAMGw3Mlh7IaU1
         4kUy6muvS3Dog==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxY-000lIP-5N; Fri, 11 Mar 2022 15:09:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 32/38] media: platform: rkisp1: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:45 +0100
Message-Id: <b8db11641790052f3bb6b49fb4c9eec20ed79a8d.1647006877.git.mchehab@kernel.org>
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
rkisp1-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig                | 20 +------------------
 .../media/platform/rockchip/rkisp1/Kconfig    | 19 ++++++++++++++++++
 2 files changed, 20 insertions(+), 19 deletions(-)
 create mode 100644 drivers/media/platform/rockchip/rkisp1/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index a7db6cee6b07..620c7f1d5033 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -65,6 +65,7 @@ source "drivers/media/platform/qcom/camss/Kconfig"
 source "drivers/media/platform/qcom/venus/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
+source "drivers/media/platform/rockchip/rkisp1/Kconfig"
 source "drivers/media/platform/rockchip/rga/Kconfig"
 source "drivers/media/platform/s3c-camif/Kconfig"
 source "drivers/media/platform/s5p-g2d/Kconfig"
@@ -89,25 +90,6 @@ config VIDEO_MUX
 
 source "drivers/media/platform/intel/Kconfig"
 
-config VIDEO_ROCKCHIP_ISP1
-	tristate "Rockchip Image Signal Processing v1 Unit driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2 && OF
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEOBUF2_DMA_CONTIG
-	select VIDEOBUF2_VMALLOC
-	select V4L2_FWNODE
-	select GENERIC_PHY_MIPI_DPHY
-	default n
-	help
-	  Enable this to support the Image Signal Processing (ISP) module
-	  present in RK3399 SoCs.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called rockchip-isp1.
-
 source "drivers/media/platform/exynos4-is/Kconfig"
 source "drivers/media/platform/am437x/Kconfig"
 source "drivers/media/platform/xilinx/Kconfig"
diff --git a/drivers/media/platform/rockchip/rkisp1/Kconfig b/drivers/media/platform/rockchip/rkisp1/Kconfig
new file mode 100644
index 000000000000..c2e464317929
--- /dev/null
+++ b/drivers/media/platform/rockchip/rkisp1/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_ROCKCHIP_ISP1
+	tristate "Rockchip Image Signal Processing v1 Unit driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2 && OF
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	select V4L2_FWNODE
+	select GENERIC_PHY_MIPI_DPHY
+	default n
+	help
+	  Enable this to support the Image Signal Processing (ISP) module
+	  present in RK3399 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called rockchip-isp1.
-- 
2.35.1

