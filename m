Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD31C4D630F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349222AbiCKOLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345071AbiCKOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:10:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A7D1AD959;
        Fri, 11 Mar 2022 06:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DA8AB82C11;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A1EC340F6;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=FL9FKo4Uznvd0fAyl/aiH2dqH8qRgA1i5+PVSuu//wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bEWadyJ52T3M3FClMlWfU/bjSpqWcU6ZNpJ+6bKWdr8p4QdTcD3eCkYw+0eV6gDdR
         gVbNixe3UsYulv3cFShoPkWu9VFhNFVatr/u056+QlzGmvTArH7cSZH3EYnu0dQ519
         5Z2FFf66k1KcIvWwFLfn4wfpiFZTJCjjgR6cUbOXdDav7BIuMm1D2pnywMM5T7ggCy
         jX3hMNpyi2jjNGwvsJ1okjjSC+y0JLKNmStsDRV8ZH3wY5zJ5dCTQq4K2gUiETnWqa
         /bgEMfk5BUbFw8KS84X7YhvHDP3RDzvEFgeDKqk4oIgnDiFgLSpaXA6O7zHW+mfCDg
         y8GuzLq1W8p5A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxX-000lHF-28; Fri, 11 Mar 2022 15:09:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 14/38] media: platform: exynos-gsc: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:27 +0100
Message-Id: <68f4028c20cec15964c4fa99cc7d1b96bb7e5aa7.1647006877.git.mchehab@kernel.org>
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
exynos-gsc-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig            | 11 +----------
 drivers/media/platform/exynos-gsc/Kconfig | 10 ++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)
 create mode 100644 drivers/media/platform/exynos-gsc/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index f6bc8457a1c2..103f3771fd29 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -53,6 +53,7 @@ source "drivers/media/platform/cadence/Kconfig"
 source "drivers/media/platform/coda/Kconfig"
 source "drivers/media/platform/davinci/Kconfig"
 
+source "drivers/media/platform/exynos-gsc/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -328,16 +329,6 @@ config VIDEO_SAMSUNG_S5P_MFC
 	help
 	    MFC 5.1 and 6.x driver for V4L2
 
-config VIDEO_SAMSUNG_EXYNOS_GSC
-	tristate "Samsung Exynos G-Scaler driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_EXYNOS || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This is a v4l2 driver for Samsung EXYNOS5 SoC G-Scaler.
-
 config VIDEO_STI_BDISP
 	tristate "STMicroelectronics BDISP 2D blitter driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/exynos-gsc/Kconfig b/drivers/media/platform/exynos-gsc/Kconfig
new file mode 100644
index 000000000000..f9bdffe915b4
--- /dev/null
+++ b/drivers/media/platform/exynos-gsc/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_SAMSUNG_EXYNOS_GSC
+	tristate "Samsung Exynos G-Scaler driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a v4l2 driver for Samsung EXYNOS5 SoC G-Scaler.
-- 
2.35.1

