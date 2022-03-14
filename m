Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896CC4D7C80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbiCNH55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbiCNH5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B454132E;
        Mon, 14 Mar 2022 00:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48BC1CE10A8;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A552C340FF;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=VhAg2DfM0V2K14kbMfszpRD01j0X/tOtJyqq+0ZzfTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MqPzFTvwI/J5A6ZK3SyklVYGaEAfi2arw0IlQFllhPJpDkjqbm+2bJMFAatGk3hWw
         x3hPhGxuwayNnhWv7xb+m4Ma2eH8WLi7LK/mVLvzvDmMQJuFxIrd3NPnzc77vDhS8F
         uE7zLL2ecMD6NhWkDYVSsH+wLZJONUdbh0iSsb2qHi5oxaqKo1on1En2MghLAp0hY1
         kpmHfNJtA0aOxV/t6UZvlxCAUPQckYAvl0smIm8x6GBtQWHpTmjHzrdEndA/ANRjTT
         A6vdZObFTEkTYqNsryB1mAgIaNiksYK1cKBYuzNNQ6A6Ix9tqBEQz75g28JRO2tvG0
         pf4Nlk9e2EsMg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYc-001kUt-Qo; Mon, 14 Mar 2022 08:55:58 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Ming Qian <ming.qian@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 11/64] media: platform: allegro-dvt: move config to its own file
Date:   Mon, 14 Mar 2022 08:55:03 +0100
Message-Id: <0d5e1aaa9afee08c4d04259f5498912149306a8f.1647242579.git.mchehab@kernel.org>
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
allegro-dvt-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig             | 17 +----------------
 drivers/media/platform/allegro-dvt/Kconfig | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)
 create mode 100644 drivers/media/platform/allegro-dvt/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index b6650caecf45..25e5ae27210d 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -29,6 +29,7 @@ config V4L_MEM2MEM_DRIVERS
 	  to capture and output drivers, which use memory buffers for just
 	  one of those.
 
+source "drivers/media/platform/allegro-dvt/Kconfig"
 source "drivers/media/platform/nxp/Kconfig"
 
 source "drivers/media/platform/renesas/Kconfig"
@@ -176,22 +177,6 @@ config VIDEO_TI_CAL_MC
 
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

