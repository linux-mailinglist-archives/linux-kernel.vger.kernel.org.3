Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABF95A2EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbiHZSdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbiHZSdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:18 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B1E2C57;
        Fri, 26 Aug 2022 11:33:16 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C61C0FF80B;
        Fri, 26 Aug 2022 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFzxCx+qnXCiS91fxrIWsbQ+I4MWcYrGJzjVS9Iv+IU=;
        b=HocYbVbW4X1cUPNwGs/yZ0vR5S6JwCP407xaSzQvcKWk137L16ADMdbDRTlo5G14xotZqo
        igR5ap4ueNefLlLf1l9PqZ61rsUWtBmJhklR5/tfjwO3Hx6vMmwmTo26ggpoZ8fn+XW8Kn
        gzpyivSDDYwmRsuOvI+IIz++bt3M6m1J/Ds2XiscxxaK6BnKlPXru4i5aw1nGzq3llDBuw
        kC9NF1elYx6RYf+g2cM+C82qRaGeUDC31vUPZtH0zkh2JhlsIJPMobl4O2CK1N0gzELMC6
        MIv0MhxrUHff0O2xGUoTJjEgsx+GROGcmzQ36RNzsT/pz0R752GY2L0xiAYZRA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 07/43] media: sun6i-csi: Tidy up Kconfig
Date:   Fri, 26 Aug 2022 20:32:04 +0200
Message-Id: <20220826183240.604834-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the option title and help, group related options together,
add dependency on VIDEO_DEV since the driver uses it and update the
description.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/platform/sunxi/sun6i-csi/Kconfig | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
index a472f46648af..886006f6a48a 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
+++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
@@ -1,13 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config VIDEO_SUN6I_CSI
-	tristate "Allwinner V3s Camera Sensor Interface driver"
-	depends on V4L_PLATFORM_DRIVERS
-	depends on VIDEO_DEV && COMMON_CLK && RESET_CONTROLLER && HAS_DMA && PM
+	tristate "Allwinner A31 Camera Sensor Interface (CSI) Driver"
+	depends on V4L_PLATFORM_DRIVERS && VIDEO_DEV
 	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on PM && COMMON_CLK && RESET_CONTROLLER && HAS_DMA
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_DMA_CONTIG
-	select REGMAP_MMIO
 	select V4L2_FWNODE
+	select REGMAP_MMIO
 	help
-	   Support for the Allwinner Camera Sensor Interface Controller on V3s.
+	   Support for the Allwinner A31 Camera Sensor Interface (CSI)
+	   controller, also found on other platforms such as the A83T, H3,
+	   V3/V3s or A64.
-- 
2.37.1

