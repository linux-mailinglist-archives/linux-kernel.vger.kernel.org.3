Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D394D638F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349416AbiCKOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245379AbiCKOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:36:58 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4901C8D96;
        Fri, 11 Mar 2022 06:35:54 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ED40E240015;
        Fri, 11 Mar 2022 14:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vD0F7ErVbg0idhLXtMNeE7PtA2hj3UWkov1fDa4SQJs=;
        b=pIJ8Xdq04Pr8kyby8OHM+/X8VdIwjEFxjiHH8ozicaEMWZ3MaNidatNyh15vRxkRM7SK2V
        gbmQzRMhb4mG2YWLeePp7qkV6ZAG8O/rEFHyFQxxkv9GxNlaGZoco/9pOCAc6yjKSAcjlJ
        XN2vDPV5sAbUbuiqAEqXe4gM3RX1W3YkXXrjzpD7ZzDOvcAH/ryHjWLBkww/lbTbGKoyLw
        hUOq3GbmtIHCGfkLpHTwn9EJgDG+XUx8tlvyUh3z1QnuCgUl0obN3nhuoKQWe1djpNxVel
        pIltTcZeWA/W8cMk1+/HMgFEuvIcdWIpqn+xzZbeL8uxDGd43xaMHohtX/0AiA==
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
Subject: [PATCH v3 01/46] media: sun6i-csi: Define and use driver name and (reworked) description
Date:   Fri, 11 Mar 2022 15:34:47 +0100
Message-Id: <20220311143532.265091-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
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
2.35.1

