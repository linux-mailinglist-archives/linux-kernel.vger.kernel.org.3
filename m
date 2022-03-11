Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A24D6331
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349375AbiCKOMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349207AbiCKOLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498911B2ACB;
        Fri, 11 Mar 2022 06:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 106A161EE6;
        Fri, 11 Mar 2022 14:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51E3C34103;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=eJpjYLyGOhPUclYMvF5Ed2UbE5NGJ6LNLtVfGzEd9rc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsQzggx7u2Q95RpKhUdIPGQVp1KhtTBF60L8ncvd+NOD/C9piBb43QKalDMelRzgm
         miLEXxxB0sTMMk04LE16l2NSgjD5V937kS3jFk6Gy5P725JJ5EaPfx0t/rjFVUF3LU
         2C0yhzU8K+NqEaE4TyazOJLAB0R6OBG6mdOj8iWrFANbQbDwVMTveWABfRz66vMuse
         Akvk4wnMtMG/SEOZNmf5pskk/gwKGz3OXX+9s7uGasfUrT4dgcYPULXW8bWRBz0xvc
         97tpa7q3BeXZOMFwmzT7Hfx9J6M79IeD9XMJG10gRCXMSEgNf6PAoFxXU24PpiRazr
         O/yoCR8T+9f/g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxX-000lHl-I9; Fri, 11 Mar 2022 15:09:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 22/38] media: platform: venus: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:35 +0100
Message-Id: <42c51372fa3b5f76d88174ae8aebc6b8d6af0331.1647006877.git.mchehab@kernel.org>
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
venus-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig            | 16 +---------------
 drivers/media/platform/qcom/venus/Kconfig | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 19ca01d2f841..a423b16a466a 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -62,6 +62,7 @@ source "drivers/media/platform/mtk-vpu/Kconfig"
 source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 source "drivers/media/platform/qcom/camss/Kconfig"
+source "drivers/media/platform/qcom/venus/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
 
@@ -329,21 +330,6 @@ config VIDEO_TI_VPE_DEBUG
 	help
 	  Enable debug messages on VPE driver.
 
-config VIDEO_QCOM_VENUS
-	tristate "Qualcomm Venus V4L2 encoder/decoder driver"
-	depends on V4L_MEM2MEM_DRIVERS
-	depends on VIDEO_DEV && VIDEO_V4L2 && QCOM_SMEM
-	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
-	select QCOM_MDT_LOADER if ARCH_QCOM
-	select QCOM_SCM
-	select VIDEOBUF2_DMA_CONTIG
-	select V4L2_MEM2MEM_DEV
-	help
-	  This is a V4L2 driver for Qualcomm Venus video accelerator
-	  hardware. It accelerates encoding and decoding operations
-	  on various Qualcomm SoCs.
-	  To compile this driver as a module choose m here.
-
 config VIDEO_SUN8I_DEINTERLACE
 	tristate "Allwinner Deinterlace driver"
 	depends on V4L_MEM2MEM_DRIVERS
diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
new file mode 100644
index 000000000000..de0fe3f7be5f
--- /dev/null
+++ b/drivers/media/platform/qcom/venus/Kconfig
@@ -0,0 +1,14 @@
+config VIDEO_QCOM_VENUS
+	tristate "Qualcomm Venus V4L2 encoder/decoder driver"
+	depends on V4L_MEM2MEM_DRIVERS
+	depends on VIDEO_DEV && VIDEO_V4L2 && QCOM_SMEM
+	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
+	select QCOM_MDT_LOADER if ARCH_QCOM
+	select QCOM_SCM
+	select VIDEOBUF2_DMA_CONTIG
+	select V4L2_MEM2MEM_DEV
+	help
+	  This is a V4L2 driver for Qualcomm Venus video accelerator
+	  hardware. It accelerates encoding and decoding operations
+	  on various Qualcomm SoCs.
+	  To compile this driver as a module choose m here.
-- 
2.35.1

