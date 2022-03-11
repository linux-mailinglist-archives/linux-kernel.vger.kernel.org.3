Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47AB4D6330
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349328AbiCKOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349220AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE11B3A4C;
        Fri, 11 Mar 2022 06:09:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C5FEB82C23;
        Fri, 11 Mar 2022 14:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D1EC340F8;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007778;
        bh=i8yLtNELIHiC5qCHcCfZMs+FPuwp7CcyArAjNx78NBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/wvCNVIBPKjM1O/f51eVoBqtf2mwQYlcvEib/JhSJpu22yrVVIkTU4g3UQTXa5aP
         Ndy2EboE3qnvKFSNrxV+Zeb5ui6n0zTRp/CFjbQCby1FecOx0kybaPzFxSefKlmlMY
         C8vAU5mBJxwOsywHWDDyBeUUDYQZf68x9hM0f71rlR6Tvr0wrIPwgaLfWQXFXPh4M+
         rHuJoYLJMVn0F62caowOVFK6wlFeJY8jyxKvdzGhw/fKx3+qjf3VnEJakIVt6+hwwm
         /I3ai73xd/bDnXDiGZ3aQeMqNY0OfJ6S8YDqxhurO64vdelAagvWqs0ozh0F+I4ANF
         0/BT53hr+ivyQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxY-000lIb-AP; Fri, 11 Mar 2022 15:09:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 35/38] media: platform: s5p-mfc: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:48 +0100
Message-Id: <9d8647b1c33d4cc5131f9578e8e02d58546e4cde.1647006877.git.mchehab@kernel.org>
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
s5p-mfc-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 9 +--------
 drivers/media/platform/s5p-mfc/Kconfig | 9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)
 create mode 100644 drivers/media/platform/s5p-mfc/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 2f52f3f975cd..447fe5681307 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -123,14 +123,7 @@ config VIDEO_SAMSUNG_S5P_JPEG
 	  This is a v4l2 driver for Samsung S5P, EXYNOS3250
 	  and EXYNOS4 JPEG codec
 
-config VIDEO_SAMSUNG_S5P_MFC
-	tristate "Samsung S5P MFC Video Codec"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	help
-	    MFC 5.1 and 6.x driver for V4L2
+source "drivers/media/platform/s5p-mfc/Kconfig"
 
 source "drivers/media/platform/sti/bdisp/Kconfig"
 
diff --git a/drivers/media/platform/s5p-mfc/Kconfig b/drivers/media/platform/s5p-mfc/Kconfig
new file mode 100644
index 000000000000..34b52b0de304
--- /dev/null
+++ b/drivers/media/platform/s5p-mfc/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_SAMSUNG_S5P_MFC
+	tristate "Samsung S5P MFC Video Codec"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	help
+	    MFC 5.1 and 6.x driver for V4L2
-- 
2.35.1

