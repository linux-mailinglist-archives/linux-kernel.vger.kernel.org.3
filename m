Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2678E5A2EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbiHZSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344761AbiHZSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:19 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD56FE3947;
        Fri, 26 Aug 2022 11:33:17 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 67AEBFF812;
        Fri, 26 Aug 2022 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kis72kdJHWDZ8DX3N+6DuNYGcZy0272LD4yoE9/KzTk=;
        b=erpoSm1wtXJgJVVwhSnBDYK54JJnQR/FzZ6dpXP6dosKJSdadfVfFKBYYdg2wq39IeAqhT
        bLM/S9bI5lvqrCPjydhdmXVuN0XllQxK+XS7xpdNe+eWzNgDVpCdc7E30PDldrGolwdo5p
        tAPY+vVgjSLNRNDpvlimSu7I4gtfJMQEJNHkcymKQDB+Gg5kKNUPw9N5ZPzbDAjO48jeRE
        D/FphHSdcKEYX1Ue8luBW3qmB46oybRVEsq7KoFIqjsM9X4uZgm/OLydnuhs/gycbgb+bB
        YlwEGWf1YYEVL2iepaemgny76uPfjeGPTEQjkRV/u8Cx9YdhRq7wL8XLIkzrxg==
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
Subject: [PATCH v6 08/43] media: sun6i-csi: Tidy up v4l2 code
Date:   Fri, 26 Aug 2022 20:32:05 +0200
Message-Id: <20220826183240.604834-9-paul.kocialkowski@bootlin.com>
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

Various cosmetic improvements to the v4l2 registration code, with
renames, lowerings, etc. The cleanup function is moved down after
setup. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 113 ++++++++++--------
 1 file changed, 66 insertions(+), 47 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 31374d45eb9f..98c9c887c543 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -27,6 +27,8 @@
 #include "sun6i_csi.h"
 #include "sun6i_csi_reg.h"
 
+/* Helpers */
+
 /* TODO add 10&12 bit YUV, RGB support */
 bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 				   u32 pixformat, u32 mbus_code)
@@ -572,9 +574,8 @@ void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
 			   CSI_CAP_CH0_VCAP_ON);
 }
 
-/* -----------------------------------------------------------------------------
- * Media Controller and V4L2
- */
+/* V4L2 */
+
 static int sun6i_csi_link_entity(struct sun6i_csi_device *csi_dev,
 				 struct media_entity *entity,
 				 struct fwnode_handle *fwnode)
@@ -666,83 +667,101 @@ static int sun6i_csi_fwnode_parse(struct device *dev,
 	}
 }
 
-static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
+static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 {
 	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
+	struct media_device *media_dev = &v4l2->media_dev;
+	struct v4l2_device *v4l2_dev = &v4l2->v4l2_dev;
+	struct v4l2_async_notifier *notifier = &v4l2->notifier;
+	struct device *dev = csi_dev->dev;
+	int ret;
 
-	media_device_unregister(&v4l2->media_dev);
-	v4l2_async_nf_unregister(&v4l2->notifier);
-	v4l2_async_nf_cleanup(&v4l2->notifier);
-	sun6i_video_cleanup(&csi_dev->video);
-	v4l2_device_unregister(&v4l2->v4l2_dev);
-	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
-	media_device_cleanup(&v4l2->media_dev);
-}
+	/* Media Device */
 
-static int sun6i_csi_v4l2_init(struct sun6i_csi_device *csi_dev)
-{
-	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
-	int ret;
+	strscpy(media_dev->model, SUN6I_CSI_DESCRIPTION,
+		sizeof(media_dev->model));
+	media_dev->hw_revision = 0;
+	media_dev->dev = dev;
 
-	v4l2->media_dev.dev = csi_dev->dev;
-	strscpy(v4l2->media_dev.model, SUN6I_CSI_DESCRIPTION,
-		sizeof(v4l2->media_dev.model));
-	v4l2->media_dev.hw_revision = 0;
+	media_device_init(media_dev);
 
-	media_device_init(&v4l2->media_dev);
-	v4l2_async_nf_init(&v4l2->notifier);
+	/* V4L2 Control Handler */
 
 	ret = v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
 	if (ret) {
-		dev_err(csi_dev->dev, "V4L2 controls handler init failed (%d)\n",
-			ret);
-		goto clean_media;
+		dev_err(dev, "failed to init v4l2 control handler: %d\n", ret);
+		goto error_media;
 	}
 
-	v4l2->v4l2_dev.mdev = &v4l2->media_dev;
-	v4l2->v4l2_dev.ctrl_handler = &v4l2->ctrl_handler;
-	ret = v4l2_device_register(csi_dev->dev, &v4l2->v4l2_dev);
+	/* V4L2 Device */
+
+	v4l2_dev->mdev = media_dev;
+	v4l2_dev->ctrl_handler = &v4l2->ctrl_handler;
+
+	ret = v4l2_device_register(dev, v4l2_dev);
 	if (ret) {
-		dev_err(csi_dev->dev, "V4L2 device registration failed (%d)\n",
-			ret);
-		goto free_ctrl;
+		dev_err(dev, "failed to register v4l2 device: %d\n", ret);
+		goto error_v4l2_ctrl;
 	}
 
+	/* Video */
+
 	ret = sun6i_video_init(&csi_dev->video, csi_dev, SUN6I_CSI_NAME);
 	if (ret)
-		goto unreg_v4l2;
+		goto error_v4l2_device;
 
-	ret = v4l2_async_nf_parse_fwnode_endpoints(csi_dev->dev,
-						   &v4l2->notifier,
+	/* V4L2 Async */
+
+	v4l2_async_nf_init(notifier);
+	notifier->ops = &sun6i_csi_async_ops;
+
+	ret = v4l2_async_nf_parse_fwnode_endpoints(dev, notifier,
 						   sizeof(struct
 							  v4l2_async_subdev),
 						   sun6i_csi_fwnode_parse);
 	if (ret)
-		goto clean_video;
-
-	v4l2->notifier.ops = &sun6i_csi_async_ops;
+		goto error_video;
 
-	ret = v4l2_async_nf_register(&v4l2->v4l2_dev, &v4l2->notifier);
+	ret = v4l2_async_nf_register(v4l2_dev, notifier);
 	if (ret) {
-		dev_err(csi_dev->dev, "notifier registration failed\n");
-		goto clean_video;
+		dev_err(dev, "failed to register v4l2 async notifier: %d\n",
+			ret);
+		goto error_v4l2_async_notifier;
 	}
 
 	return 0;
 
-clean_video:
+error_v4l2_async_notifier:
+	v4l2_async_nf_cleanup(notifier);
+
+error_video:
 	sun6i_video_cleanup(&csi_dev->video);
-unreg_v4l2:
+
+error_v4l2_device:
 	v4l2_device_unregister(&v4l2->v4l2_dev);
-free_ctrl:
+
+error_v4l2_ctrl:
 	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
-clean_media:
-	v4l2_async_nf_cleanup(&v4l2->notifier);
-	media_device_cleanup(&v4l2->media_dev);
+
+error_media:
+	media_device_cleanup(media_dev);
 
 	return ret;
 }
 
+static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
+{
+	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
+
+	media_device_unregister(&v4l2->media_dev);
+	v4l2_async_nf_unregister(&v4l2->notifier);
+	v4l2_async_nf_cleanup(&v4l2->notifier);
+	sun6i_video_cleanup(&csi_dev->video);
+	v4l2_device_unregister(&v4l2->v4l2_dev);
+	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
+	media_device_cleanup(&v4l2->media_dev);
+}
+
 /* Platform */
 
 static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
@@ -939,7 +958,7 @@ static int sun6i_csi_probe(struct platform_device *platform_dev)
 	if (ret)
 		return ret;
 
-	ret = sun6i_csi_v4l2_init(csi_dev);
+	ret = sun6i_csi_v4l2_setup(csi_dev);
 	if (ret)
 		goto error_resources;
 
-- 
2.37.1

