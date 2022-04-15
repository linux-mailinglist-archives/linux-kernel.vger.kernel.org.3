Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE3F502CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355000AbiDOPa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348962AbiDOPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:30:51 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D490D3AE6;
        Fri, 15 Apr 2022 08:28:21 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 50290E0009;
        Fri, 15 Apr 2022 15:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CEm5+pGRNel/0Old7UzJMKf1s19Es9J+Jjzr7jKNOZ0=;
        b=X2CQrLsOEU929UKZI3UjKfC+rGr76kJN1MWbcUik/HnoE3rzeJljFY6o96WZHpshvPTuek
        zZh61Sh5Q6xCG12k59ZCc6Gyl1B7yDYIwL4Qqx5kR5htr7ZuGw7YB7Rp4AfA9rEei9VOhM
        sUJ2+NIiZbeZ5FkXuqTUGfq76H3+7OaIsJe0zzU0sAxbJtolKlPloTIaQ7MiWU+Ilij+20
        jctsp3eW3BS7L1H+8nPQWY78gNtF2sxYV5fbU3URP+bYqRsWOE3I6HXHA9kg0g+lvNAC+t
        MBC+bYfGOMNA30+ED+SkXvX5oUbbmYEbiRGVaujNMoIEgrhDmPGKKXVk318Vlw==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 01/45] media: sun6i-csi: Define and use driver name and (reworked) description
Date:   Fri, 15 Apr 2022 17:27:27 +0200
Message-Id: <20220415152811.636419-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add proper defines for driver name and description instead of
MODULE_NAME and hardcoding (cosmetics).

Also rework the description while at it to mention the hardware
generation that the driver supports and remove the video capture
mentions since it applies to the whole media device.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 14 ++++++--------
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h |  3 +++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index fc96921b0583..43dcd8117d3f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -27,8 +27,6 @@
 #include "sun6i_csi.h"
 #include "sun6i_csi_reg.h"
 
-#define MODULE_NAME	"sun6i-csi"
-
 struct sun6i_csi_dev {
 	struct sun6i_csi		csi;
 	struct device			*dev;
@@ -730,7 +728,7 @@ static int sun6i_csi_v4l2_init(struct sun6i_csi *csi)
 	int ret;
 
 	csi->media_dev.dev = csi->dev;
-	strscpy(csi->media_dev.model, "Allwinner Video Capture Device",
+	strscpy(csi->media_dev.model, SUN6I_CSI_DESCRIPTION,
 		sizeof(csi->media_dev.model));
 	csi->media_dev.hw_revision = 0;
 	snprintf(csi->media_dev.bus_info, sizeof(csi->media_dev.bus_info),
@@ -755,7 +753,7 @@ static int sun6i_csi_v4l2_init(struct sun6i_csi *csi)
 		goto free_ctrl;
 	}
 
-	ret = sun6i_video_init(&csi->video, csi, "sun6i-csi");
+	ret = sun6i_video_init(&csi->video, csi, SUN6I_CSI_NAME);
 	if (ret)
 		goto unreg_v4l2;
 
@@ -870,8 +868,8 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 	if (irq < 0)
 		return -ENXIO;
 
-	ret = devm_request_irq(&pdev->dev, irq, sun6i_csi_isr, 0, MODULE_NAME,
-			       sdev);
+	ret = devm_request_irq(&pdev->dev, irq, sun6i_csi_isr, 0,
+			       SUN6I_CSI_NAME, sdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request csi IRQ\n");
 		return ret;
@@ -924,12 +922,12 @@ static struct platform_driver sun6i_csi_platform_driver = {
 	.probe = sun6i_csi_probe,
 	.remove = sun6i_csi_remove,
 	.driver = {
-		.name = MODULE_NAME,
+		.name = SUN6I_CSI_NAME,
 		.of_match_table = of_match_ptr(sun6i_csi_of_match),
 	},
 };
 module_platform_driver(sun6i_csi_platform_driver);
 
-MODULE_DESCRIPTION("Allwinner V3s Camera Sensor Interface driver");
+MODULE_DESCRIPTION("Allwinner A31 Camera Sensor Interface driver");
 MODULE_AUTHOR("Yong Deng <yong.deng@magewell.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 3a38d107ae3f..e04f3c3fa27b 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -14,6 +14,9 @@
 
 #include "sun6i_video.h"
 
+#define SUN6I_CSI_NAME		"sun6i-csi"
+#define SUN6I_CSI_DESCRIPTION	"Allwinner A31 CSI Device"
+
 struct sun6i_csi;
 
 /**
-- 
2.35.2

