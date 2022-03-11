Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFDB4D6306
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349196AbiCKOLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiCKOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:10:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CFF1B1DD0;
        Fri, 11 Mar 2022 06:09:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6BC761ED5;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B74C340EE;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=YrrnYq7xL8JFq0xja3ewNHJ+8MIXWdxCPWeemCfhNyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3NACKJwHgLhSOPkNeLuy9wIZy5Rr76+49Ont7CRKg8gpURKOTPP+ixDgyK26mGwF
         RzBVhSi7fCj1szv98Fx8Sv9nei+KUe8kfcBZIfMkOV+MLvagCFRgNreBNnGa0EWOd6
         65rWU5ReD+b+ry30A3kXtvk3vf+F31QDKpeVYNCcxr3WsTNvYm8qnoV1DS5lkByq/y
         bSXASE8V1b8nss6H3mc57a6FW8cd8W3s54sSGgTtVET8g5n1A8zpmcVJS+TNc3h+xb
         WOsuyR9W4jKWe7t9zGzzXLiGGwahplZrgz/I0XeVurArOY3FaErCs/2NTwKDvYjDg4
         OA0D7x5ikbUkA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxW-000lH4-Tq; Fri, 11 Mar 2022 15:09:34 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Ming Qian <ming.qian@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 11/38] media: platform: allegro-dvt: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:24 +0100
Message-Id: <96c538dfdef76361537c27993df2ed4e497d807c.1647006877.git.mchehab@kernel.org>
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
allegro-dvt-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig             | 17 +----------------
 drivers/media/platform/allegro-dvt/Kconfig | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)
 create mode 100644 drivers/media/platform/allegro-dvt/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 87ef4fb68bdf..e795a0862841 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -36,6 +36,7 @@ config V4L_MEM2MEM_DRIVERS
 	  to capture and output drivers, which use memory buffers for just
 	  one of those.
 
+source "drivers/media/platform/allegro-dvt/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
 
 source "drivers/media/platform/renesas/Kconfig"
@@ -185,22 +186,6 @@ config VIDEO_TI_CAL_MC
 
 # Mem2mem drivers
 
-config VIDEO_ALLEGRO_DVT
-	tristate "Allegro DVT Video IP Core"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2
-	depends on ARCH_ZYNQMP || COMPILE_TEST
-	select V4L2_MEM2MEM_DEV
-	select VIDEOBUF2_DMA_CONTIG
-	select REGMAP_MMIO
-	help
-	  Support for the encoder video IP core by Allegro DVT. This core is
-	  found for example on the Xilinx ZynqMP SoC in the EV family and is
-	  called VCU in the reference manual.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called allegro.
-
 config VIDEO_CODA
 	tristate "Chips&Media Coda multi-standard codec IP"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/allegro-dvt/Kconfig b/drivers/media/platform/allegro-dvt/Kconfig
new file mode 100644
index 000000000000..dd528e9d0958
--- /dev/null
+++ b/drivers/media/platform/allegro-dvt/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config VIDEO_ALLEGRO_DVT
+	tristate "Allegro DVT Video IP Core"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	select V4L2_MEM2MEM_DEV
+	select VIDEOBUF2_DMA_CONTIG
+	select REGMAP_MMIO
+	help
+	  Support for the encoder video IP core by Allegro DVT. This core is
+	  found for example on the Xilinx ZynqMP SoC in the EV family and is
+	  called VCU in the reference manual.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called allegro.
-- 
2.35.1

