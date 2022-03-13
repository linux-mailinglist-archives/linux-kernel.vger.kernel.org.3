Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9E24D7384
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 08:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiCMHZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 03:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiCMHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 03:23:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDEC1945D4;
        Sat, 12 Mar 2022 23:21:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F304CB80BFA;
        Sun, 13 Mar 2022 07:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFEAC341D7;
        Sun, 13 Mar 2022 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647156114;
        bh=+YGcmMZwK1ZBRVHE+lynl+rMtW0LIl0vNNkDOwX/BAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBvMFv1lYNqEPjfyhjcQJCNKfDfpVZ1X+NgVIDz4uTL0brEdGRqaACKiSDrps0wSe
         YwVdW2WEA0uTLHjSsqYPcOBZ6MsrAXd7+eJlRGx3z3KIXF+ajAO+aaE1ajkfPv4yUU
         sOWG2GByWZy1weUwvCZIeCKS79KnHE36bw1JpKEeAISqf7Qeu6FgbHWiBaCKfgTbL6
         3Sm/Ez/VeHR5WPLc6shyXxT86xcBePZAWNPhFIFV+SjrolstDcyns1LLcGH/GVhHIK
         PGswfXdHsM29jalre/MH8RZ23RCPbQFUUoqziIhYk+AJgDSHx0PYSFtO2YAJztyuAp
         XaN3KtaWuPSWg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTIY4-0012xg-FE; Sun, 13 Mar 2022 08:21:52 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v3 34/39] media: platform: bdisp: move config to its own file
Date:   Sun, 13 Mar 2022 08:21:43 +0100
Message-Id: <57addcb1816e4178fccab122908aa5f43351af9e.1647155572.git.mchehab@kernel.org>
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
bdisp-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/39] at: https://lore.kernel.org/all/cover.1647155572.git.mchehab@kernel.org/

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

