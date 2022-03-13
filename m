Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E24D735B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiCMHXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiCMHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7977194554;
        Sat, 12 Mar 2022 23:21:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C25B60F49;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CB7C3410B;
        Sun, 13 Mar 2022 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156113;
        bh=BkVktkSo/WUley35vVDnUt9kp1LCPwF0mlg6q9pl3Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qsahfzf48LlnFLrJ/GVxF9m2lrV23MTdNHQuhgbyfJMn1RUei4Wpxx4NtsHSAkiCn
         Rq8u9RzaTmEZHAxy8EQQ37F9sV3Oa7rzRUrLwqLEebKfnp2t3V2UlsWuV20sTHb5Se
         tZGi+EwSKMuniqbwF6AIi8qeErvVtaKlGWgLqeshT8SlmX9g2/++e1oRcWgJqQK4P/
         5LTFlBFILihhmkAH6lZtaIIyKssGc9tA3V++dGdYIa/ZN0uZqtH8YLQQYSo9QseB9h
         hvijazKvnejNKIeVTlhpqC1tqfFPC6O+fzzK1uJ/L7h4AfGhkzS5T++FvXMNfjmMu2
         HF0fTQvXwpI1g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY3-0012wO-Jq; Sun, 13 Mar 2022 08:21:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 14/39] media: platform: exynos-gsc: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:23 +0100
Message-Id: <e9c2c1dfc5084c73241bca58378079f440a46c24.1647155572.git.mchehab@kernel.org>
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
exynos-gsc-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig            | 11 +----------
 drivers/media/platform/exynos-gsc/Kconfig | 10 ++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)
 create mode 100644 drivers/media/platform/exynos-gsc/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0bf9dd5da845..57ca2426a83b 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -46,6 +46,7 @@ source "drivers/media/platform/cadence/Kconfig"
 source "drivers/media/platform/coda/Kconfig"
 source "drivers/media/platform/davinci/Kconfig"
 
+source "drivers/media/platform/exynos-gsc/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
@@ -317,16 +318,6 @@ config VIDEO_SAMSUNG_S5P_MFC
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

