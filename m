Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2E34D7CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbiCNH7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiCNH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:57:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D39F4133B;
        Mon, 14 Mar 2022 00:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD9C5B80D49;
        Mon, 14 Mar 2022 07:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F04C3411D;
        Mon, 14 Mar 2022 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647244561;
        bh=hLXlZDsANXrQDNOF5BHnehyTUuhg/sL1AnjnfHoobO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKbkseoZgTmkhbIJDaWcYf0/bwJI1XXMSGfndwA3bQXcYcpzWuC0nsMjDHaHK1iC6
         i0SVyJ2/OporjtuQHSTVbhlKzICmv7Y5sCZCuoyA2MaK+iwqCT7kGX2SPU+l/XrWrw
         Kz1y7icf0LDivII0qPHbz9EzR7mBOZmAy/K8XP0YgHASQTilHtNPtRqxTMoF+SwXFa
         zSE/jZbUny9/UwfPX38j4hyv62istqngymjyOtSyq2vY6MEuAgl1MQbYmTerLEAbu1
         jfP17lEEnXa9CbTHbFdmnRIjJeVxIKP7oQNMlR6Qz95MoWXqwmHaI9XbQ+KVe23k6r
         O9+zwZK0o7iFA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTfYd-001kVb-7u; Mon, 14 Mar 2022 08:55:59 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 22/64] media: platform: venus: move config to its own file
Date:   Mon, 14 Mar 2022 08:55:14 +0100
Message-Id: <54e5d62d97b01544d78619605eebe533993bb2fb.1647242579.git.mchehab@kernel.org>
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
venus-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig            | 16 +---------------
 drivers/media/platform/qcom/venus/Kconfig | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 15 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index b5a1cb0d62c2..5a8495338fd4 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -55,6 +55,7 @@ source "drivers/media/platform/mtk-vpu/Kconfig"
 source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
 source "drivers/media/platform/qcom/camss/Kconfig"
+source "drivers/media/platform/qcom/venus/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
 
@@ -319,21 +320,6 @@ config VIDEO_TI_VPE_DEBUG
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

