Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF2C4D89FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbiCNQiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbiCNQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5491413E23;
        Mon, 14 Mar 2022 09:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5267B80EA1;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AD0C36AE3;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275708;
        bh=3y1d2Bp0XVWk9QrVZ+2XibWOWyr3FKKdoLpqtosBJLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HySPZtn6N8FzY0wyDiz1qe+MdZ7PQiKgglSnjinbf3Qe2lLvGF5+QjzrkZuPrtx1H
         hGM/ue6+PF5V7zN+FSpos+Qi3Vc6/z57puy7FfnIgUi/PMSttzbbnJI2eMX9P5Ka2N
         NzYUqahpnp/NNPqnG2DIBF5mLQgPsBZGu2fDDkXUonyPKnyhNsrCWiwEIkHXeLdQ0B
         osbyI8Hi4VkpumVox3XPQfh6f8ZqQ0DghOYyYKvSJQJ7OZ9pMVRmAZ/PoYxJqFU2nx
         4j50g9s2N3hHWx4pssAIG2CF+7GIEVQfxUb8T4FizLobshD0TfsQ6xDK+xZTDQUzbx
         xwYz7qFcNbg9Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf0-001wyK-0t; Mon, 14 Mar 2022 17:35:06 +0100
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
Subject: [PATCH v2 34/67] media: platform: bdisp: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:29 +0100
Message-Id: <b43975b752a766feb2417cbc310d395602efb89d.1647274406.git.mchehab@kernel.org>
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
bdisp-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig           | 10 +---------
 drivers/media/platform/sti/bdisp/Kconfig | 10 ++++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)
 create mode 100644 drivers/media/platform/sti/bdisp/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index ba4c10896537..2069eee801af 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -122,15 +122,7 @@ config VIDEO_SAMSUNG_S5P_MFC
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

