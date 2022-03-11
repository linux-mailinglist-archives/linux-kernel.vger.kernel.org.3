Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A074D62FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349205AbiCKOLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244270AbiCKOKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:10:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C181B7184;
        Fri, 11 Mar 2022 06:09:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCD3261EE1;
        Fri, 11 Mar 2022 14:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB893C34106;
        Fri, 11 Mar 2022 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647007777;
        bh=rrOQ7H2gWk4rlgP70wQEzAq3AULA+FWsCAZlMq2tXyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j3j3FSZiL93aSR+tuYUJmkXcFUVNJ9nqNLwvG1d7nyXI7uaAtCWEc8WrYPlHc8NTB
         IJprNDbfwTcxVLVqSu/QpYI6+6zM6CHnuOD8zmcApNqE1+uyd4z4vBx2OGZ0b301Ez
         FH/WCxaFC4FVo6Dzi4EepufN1JFxSsJC1m3sm0LL4edzJ/77X7+TTGvLhtCmAorPDI
         ycM+7pVswYA68byxFfg7VQod5u4YhG4fTvgiEsONMDXO4XTWNSD0df9ruc7aD9KeO+
         FLIo/K0hU23cBlJrfxzVCyaaTiKUnSEjDstfo3QuTSABa/bKrtk/wwi6RvU2W2TS1y
         wDFiYX9lcCOhQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nSfxX-000lHh-GA; Fri, 11 Mar 2022 15:09:35 +0100
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
        Robert Foss <robert.foss@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 21/38] media: platform: camss: move config to its own file
Date:   Fri, 11 Mar 2022 15:07:34 +0100
Message-Id: <8602f414ccdbf2ed803b013cdb7b9a97739d4921.1647006877.git.mchehab@kernel.org>
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
camss-specific config stuff on a separate Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.1647006877.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig            | 11 +----------
 drivers/media/platform/qcom/camss/Kconfig |  9 +++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)
 create mode 100644 drivers/media/platform/qcom/camss/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index f65eefa15dda..19ca01d2f841 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -61,6 +61,7 @@ source "drivers/media/platform/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mtk-vpu/Kconfig"
 source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
+source "drivers/media/platform/qcom/camss/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
 
@@ -78,16 +79,6 @@ config VIDEO_MUX
 
 source "drivers/media/platform/intel/Kconfig"
 
-config VIDEO_QCOM_CAMSS
-	tristate "Qualcomm V4L2 Camera Subsystem driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_V4L2
-	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
-	select MEDIA_CONTROLLER
-	select VIDEO_V4L2_SUBDEV_API
-	select VIDEOBUF2_DMA_SG
-	select V4L2_FWNODE
-
 config VIDEO_S3C_CAMIF
 	tristate "Samsung S3C24XX/S3C64XX SoC Camera Interface driver"
 	depends on V4L_PLATFORM_DRIVERS
diff --git a/drivers/media/platform/qcom/camss/Kconfig b/drivers/media/platform/qcom/camss/Kconfig
new file mode 100644
index 000000000000..56be91578706
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/Kconfig
@@ -0,0 +1,9 @@
+config VIDEO_QCOM_CAMSS
+	tristate "Qualcomm V4L2 Camera Subsystem driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on VIDEO_V4L2
+	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
+	select MEDIA_CONTROLLER
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_SG
+	select V4L2_FWNODE
-- 
2.35.1

