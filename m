Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449294D899D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbiCNQiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbiCNQgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694F13F83;
        Mon, 14 Mar 2022 09:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A046F61423;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FDCC341C5;
        Mon, 14 Mar 2022 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275707;
        bh=nCb6VTUEtdsePK0bUTAcUuP2A2YISDJ4E2NIfYNtHCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8OVrzUdGIIzupm/LVYaTEBcCaaAMOTrkByom9KYTx0FDp5+9qo+Rbn1RDIspTfhM
         zTInEbm53K7XxFjy+k5+iGM2U445Rp64h1CSifv3nTJcpNBCNMU4g6JE7Bymfde6G5
         LjfxSnJNOkcFakfQ/KKolsIb8/RQZB7p4+3FIwnCMsqbqOSaMuL4Kxd0rwd3/JwLq+
         BRgl4opU2sTaTDpy4qEl5hpoIhArBHONnrjmeRf22tcyQr1rDQA74VjXpa4q+VJjgr
         yaUbe4kajQx42ne6YIe/NDJm9B5bAwiKEn44iP1nV0mSG3AX2edDGiyulpDRMaYNJO
         WH5phQt/C49Sg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnez-001wy3-PH; Mon, 14 Mar 2022 17:35:05 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 30/67] media: platform: vde: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:25 +0100
Message-Id: <d77d3b21c933ebbbff1874b2638559750b53d60a.1647274406.git.mchehab@kernel.org>
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
vde-specific config stuff on a separate Kconfig file.

Acked-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig           | 19 +------------------
 drivers/media/platform/tegra/vde/Kconfig | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)
 create mode 100644 drivers/media/platform/tegra/vde/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 224ebe4f5348..b0acbf3ccb69 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -65,6 +65,7 @@ source "drivers/media/platform/sti/hva/Kconfig"
 source "drivers/media/platform/stm32/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
 source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
+source "drivers/media/platform/tegra/vde/Kconfig"
 
 config VIDEO_MUX
 	tristate "Video Multiplexer"
@@ -232,24 +233,6 @@ config VIDEO_TI_VPE_DEBUG
 	help
 	  Enable debug messages on VPE driver.
 
-config VIDEO_TEGRA_VDE
-	tristate "NVIDIA Tegra Video Decoder Engine driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on ARCH_TEGRA || COMPILE_TEST
-	depends on VIDEO_DEV && VIDEO_V4L2
-	select DMA_SHARED_BUFFER
-	select IOMMU_IOVA
-	select MEDIA_CONTROLLER
-	select MEDIA_CONTROLLER_REQUEST_API
-	select SRAM
-	select VIDEOBUF2_DMA_CONTIG
-	select VIDEOBUF2_DMA_SG
-	select V4L2_H264
-	select V4L2_MEM2MEM_DEV
-	help
-	   Support for the NVIDIA Tegra video decoder unit.
-	   To compile this driver as a module choose m here.
-
 # TI VIDEO PORT Helper Modules
 # These will be selected by VPE and VIP
 config VIDEO_TI_VPDMA
diff --git a/drivers/media/platform/tegra/vde/Kconfig b/drivers/media/platform/tegra/vde/Kconfig
new file mode 100644
index 000000000000..584b78d8d66c
--- /dev/null
+++ b/drivers/media/platform/tegra/vde/Kconfig
@@ -0,0 +1,17 @@
+config VIDEO_TEGRA_VDE
+	tristate "NVIDIA Tegra Video Decoder Engine driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on VIDEO_DEV && VIDEO_V4L2
+	select DMA_SHARED_BUFFER
+	select IOMMU_IOVA
+	select MEDIA_CONTROLLER
+	select MEDIA_CONTROLLER_REQUEST_API
+	select SRAM
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_DMA_SG
+	select V4L2_H264
+	select V4L2_MEM2MEM_DEV
+	help
+	   Support for the NVIDIA Tegra video decoder unit.
+	   To compile this driver as a module choose m here.
-- 
2.35.1

