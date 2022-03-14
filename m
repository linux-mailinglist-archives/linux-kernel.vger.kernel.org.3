Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9D4D7CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiCNICE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiCNH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D37E4133D;
        Mon, 14 Mar 2022 00:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED820B80D50;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAEAC36AE9;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=GnE8f84XYDrMP2zLhIQhx16WAZQLX/XeXHJvY3cO3vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOf62xOIC/sw0a0bFUaGgH+uyhGsGDYaaiE29qTxH6FtTc+L9KVLN0XuzbOIzuawj
         54LgcPWfRTLkZyLxs9hscx5mSV0fr/hN/ut3le8fQQaFzzfEjR9R1RR4mFXOgHrVjh
         FKEgB1GYHpdn9kK04WLRTeNeUbHKyUOcZxnjWogiXT/6YVzH1abpo0PmGV6wQDWl1N
         1Pe9KS5bO8BNzSBhN8Z6tJGJJ4Cqs8DPq0VQrXggnM+F5xS/kD5Ut8N16E6nhHGulO
         AFdySk+n5h9c3mdcgxMkJlaSAbYDCLsA8pjtOM2R+7vpYkAhBe4GatPJRoVDrN7s3Z
         y4jXdreS9ADlw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYd-001kVn-Ba; Mon, 14 Mar 2022 08:55:59 +0100
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
Subject: [PATCH 25/64] media: platform: s5p-g2d: move config to its own file
Date:   Mon, 14 Mar 2022 08:55:17 +0100
Message-Id: <0e154ddbe90870c0a0a5f62f18fa6109023cb260.1647242579.git.mchehab@kernel.org>
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
s5p-g2d-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

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

