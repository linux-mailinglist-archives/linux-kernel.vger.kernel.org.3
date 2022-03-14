Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08AA4D89D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244160AbiCNQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbiCNQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F057717E1D;
        Mon, 14 Mar 2022 09:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECB6061457;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5EBC36B1A;
        Mon, 14 Mar 2022 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275707;
        bh=vmos0iyNbaBKZtzqzREGWwgvll3yIiNPkPm2h5IziVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCHmFZf7PzyJ2dg3XhS4PbL7KEFjAcNO1Wd2edI1+OKpplCQreySBxUKpbyLd8CNB
         RQV7ENFUSzaR5SpclnPKFIisDzME4tPih16gLBnswOvVk0i7+L7XdgTtPAc1RyFuaq
         GnXc478ZGBqwdkOLRc9q+2EuP9PvSFvsieAuO2Y7y1Pl9M8j8BE5XV0gvyXdIqFxu/
         cevCaXl8/dkYxULB9KJNc2SOpwzKiFD4i7supta1fK8FewuKJoHU92VyH7CtJdlBF/
         XpuAQ/EkdbcpQ/iKA3+lX6B9dwDoaOanI743y7j/P14nLnRO+Jrp2YPr8KIuP0lrWw
         A7y6JCrtsz44Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnez-001wxj-Gp; Mon, 14 Mar 2022 17:35:05 +0100
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
Subject: [PATCH v2 25/67] media: platform: s5p-g2d: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:20 +0100
Message-Id: <a8564f46d85686015fca90bcc6ad53d16ff9d27a.1647274406.git.mchehab@kernel.org>
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
s5p-g2d-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

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

