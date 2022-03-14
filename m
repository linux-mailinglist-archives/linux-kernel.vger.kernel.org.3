Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E704D89B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243518AbiCNQhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243119AbiCNQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011C413DC6;
        Mon, 14 Mar 2022 09:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9BB9B80EA0;
        Mon, 14 Mar 2022 16:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1ECC36AEF;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275708;
        bh=Rt4baVZ0AS4OUlHbuvYNFr2qU8hmii5bc0wWCMYW4cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uhZRdk5haKFwrl6L5cL+pcPN87drJlJNEQKnGTyjOua9n9iw5IA/FdkfEFTROPT5t
         wyW/xZNDFhK2ePAFiB7hb/vAWNM7TblGBd2jKvRum+qPBp4jZPbjaxMLmeyJFUBswo
         TrZXQbhSwn9XLMKbnUU6fyTXfOijjvLd6SQWXAfqW1AP8aBTDqtXzLa+dQwxwmNL2+
         FoTmk7TDlDFVHLb75xopAKwMUrOjV9cthXqP/10Um3WQZVRoSdsTiR+z5lvG6G62zU
         GoJqZ2pbomLIpB7qkqZ+7uZA2ymPzV/ffybCJJJcUnvG2J7TkT+1KGkzG1S8YbQGYS
         ohnCA6kt+bnow==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnf0-001wyO-2l; Mon, 14 Mar 2022 17:35:06 +0100
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
Subject: [PATCH v2 35/67] media: platform: s5p-mfc: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:30 +0100
Message-Id: <7bd52c3b542fff0bb704a8d001cf08aa4af7d16f.1647274406.git.mchehab@kernel.org>
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
s5p-mfc-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig         | 9 +--------
 drivers/media/platform/s5p-mfc/Kconfig | 9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)
 create mode 100644 drivers/media/platform/s5p-mfc/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 2069eee801af..fd6b18ac0c7c 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -113,14 +113,7 @@ config VIDEO_SAMSUNG_S5P_JPEG
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

