Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84A94D89F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbiCNQhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243096AbiCNQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0194E13DEF;
        Mon, 14 Mar 2022 09:35:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C0C6140C;
        Mon, 14 Mar 2022 16:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A4CC36B0B;
        Mon, 14 Mar 2022 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647275707;
        bh=R+Uy0UkoKmgU5mpBmnzvblMXdB4VR6H26eLVWh/zVyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cf1k4P1gQlflBQEt5tn8J8GGq5o3ehT7odsJ1UVyTfIPariGF9ORXsPxEbYX51JRZ
         /AbXHI5FT1ZPfen6kynSgJkWxuPVZaeqv7XaYwMYLZRq/rROeBeirOv5Gpf0cdQfar
         50/ayxIBh5/r6GlKDFQeQTFbnrY6KnRY/ty74NLSM2pGqs01qzVOkQMS6Fr5jnTnon
         vYQG9dIe4h194fYidwl1GD8OQqRlU3fUEscrS/YCmILY0FOgBHQSVkEr6rzQeenzhj
         rlb5ID0QxuzDmP/vVk9WoVJkvgJxmfOS1H+brwrAMWCNJH98jr4KngT4rri9pzE+qx
         EMp+E1sw7CK3g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nTnez-001wxT-9t; Mon, 14 Mar 2022 17:35:05 +0100
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
        Robert Foss <robert.foss@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 21/67] media: platform: camss: move config to its own file
Date:   Mon, 14 Mar 2022 17:34:16 +0100
Message-Id: <9b1ca66a0cf602753b6a031f578832a462792aca.1647274406.git.mchehab@kernel.org>
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
camss-specific config stuff on a separate Kconfig file.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/

 drivers/media/platform/Kconfig            | 11 +----------
 drivers/media/platform/qcom/camss/Kconfig |  9 +++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)
 create mode 100644 drivers/media/platform/qcom/camss/Kconfig

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 1dac7a5b53eb..b5a1cb0d62c2 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -54,6 +54,7 @@ source "drivers/media/platform/mtk-vcodec/Kconfig"
 source "drivers/media/platform/mtk-vpu/Kconfig"
 source "drivers/media/platform/omap3isp/Kconfig"
 source "drivers/media/platform/omap/Kconfig"
+source "drivers/media/platform/qcom/camss/Kconfig"
 
 source "drivers/media/platform/aspeed/Kconfig"
 
@@ -71,16 +72,6 @@ config VIDEO_MUX
 
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

