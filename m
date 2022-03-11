Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE74D6332
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbiCKOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349209AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4955C1B1DF9;
        Fri, 11 Mar 2022 06:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E5BC61EF5;
        Fri, 11 Mar 2022 14:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAD7C340F5;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007778;
        bh=4hXJdb9SBAyyK1gdbuIjH0eJrEW4WSwJh/oufT4g3d0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsGmokHVb5cC+mUmxiVZmggcb47Vc0jBJr2PTOQ+jy5kVRiOSNNnzZn9WAqJPp2GA
         lPSiJ6OnlYS2DSn4CXUkUB4C5HyCdH6O8hYq+VKTPU4wJxnKCYOf1TT82f8h0sVkvB
         Gx8DKzHIb31+TwrLBxJST6pLcR71/0CE+voOS41oX0zFY9rCzRzfPnR8NmvIOeUHCn
         PTc5w0hOxj+JrLZqYaB9L0KHiEBWpdFZXBOKSWgNj4rCqSUbwf8zYuup8OPnJ66NSn
         CAxn8fLSF1mfoGqcdjT1f0JEfj+sbfU22b+JLqpe9aDtV7AEQDx4Ic5zDN2v4K299W
         fKyKKb1pnA9lg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxY-000lIX-8P; Fri, 11 Mar 2022 15:09:36 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 34/38] media: platform: bdisp: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:47 +0100
Message-Id: <c2807f9010719946e54110cac2196e1cc4c91eb0.1647006877.git.mchehab@kernel.org>
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
bdisp-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig           | 10 +---------
 drivers/media/platform/sti/bdisp/Kconfig | 10 ++++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)
 create mode 100644 drivers/media/platform/sti/bdisp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index c5eb97199e2e..2f52f3f975cd 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -132,15 +132,7 @@ config VIDEO_SAMSUNG_S5P_MFC
 	help
 	    MFC 5.1 and 6.x driver for V4L2
 
-config VIDEO_STI_BDISP
-	tristate "STMicroelectronics BDISP 2D blitter driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_STI || COMPILE_TEST
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This v4l2 mem2mem driver is a 2D blitter for STMicroelectronics SoC.
+source "drivers/media/platform/sti/bdisp/Kconfig"
 
 source "drivers/media/platform/sti/delta/Kconfig"
 
diff --git a/drivers/media/platform/sti/bdisp/Kconfig b/drivers/media/platform/sti/bdisp/Kconfig
new file mode 100644
index 000000000000..e583fb924f52
--- /dev/null
+++ b/drivers/media/platform/sti/bdisp/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_STI_BDISP
+	tristate "STMicroelectronics BDISP 2D blitter driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_STI || COMPILE_TEST
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This v4l2 mem2mem driver is a 2D blitter for STMicroelectronics SoC.
-- 
2.35.1

