Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8815A2EEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344876AbiHZSfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbiHZSdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:55 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7536FE39A1;
        Fri, 26 Aug 2022 11:33:33 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E8DB2FF80A;
        Fri, 26 Aug 2022 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Cr7l0mF+DluC7EOQcaEWbfb86GAw2BVuDr2Ce2BDA0=;
        b=lUzNBsdVA3hzrxuvitHxXtXqOEJi3VNmEOHqtosenCBOYO6lmKqDvsN+I26dCUOhxJi3UQ
        bZN4xz1nNOE0Ok52KxdRE0cPlFtXQgX5hX+wg49gnyMQAt7BflXoij4SgPBQn3aBUAaJmV
        bU+3mUneEfa1efkmJraeHfrNRK470gE2vHHaUbvNIvcQt09drhf3AoWSeBrILTLJzRh9oo
        iCDIwINDGxjM/0wRs9l6mwMK3n4HTlXn8dsa5P3rOjj3WPpqEoAQr00byigrf7+81/W+iZ
        W5HWDrx5yDMpwbnkJR2HDZAkmC8i26JKuhiJoNKIBcgU899CXzYbcAQIbDLXNg==
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
Subject: [PATCH v6 22/43] media: sun6i-csi: Split stream sequences and irq code in capture
Date:   Fri, 26 Aug 2022 20:32:19 +0200
Message-Id: <20220826183240.604834-23-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create minimal helpers that split the enable/disable flow, which will
make it easier to move control over to the bridge later on.

Generally speaking the goal is to move register configuration to
the capture code and later split it with the bridge code.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 26 ---------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  7 ---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 58 ++++++++++++++++++-
 3 files changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 5e03069bd4c3..d5318e2b04df 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -535,32 +535,6 @@ int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
 	return 0;
 }
 
-void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
-{
-	struct regmap *regmap = csi_dev->regmap;
-
-	if (!enable) {
-		regmap_update_bits(regmap, SUN6I_CSI_CAP_REG,
-				   SUN6I_CSI_CAP_VCAP_ON, 0);
-		regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG, 0);
-		return;
-	}
-
-	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG,
-		     SUN6I_CSI_CH_INT_STA_CLEAR);
-	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG,
-		     SUN6I_CSI_CH_INT_EN_VS |
-		     SUN6I_CSI_CH_INT_EN_HB_OF |
-		     SUN6I_CSI_CH_INT_EN_FIFO2_OF |
-		     SUN6I_CSI_CH_INT_EN_FIFO1_OF |
-		     SUN6I_CSI_CH_INT_EN_FIFO0_OF |
-		     SUN6I_CSI_CH_INT_EN_FD |
-		     SUN6I_CSI_CH_INT_EN_CD);
-
-	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON,
-			   SUN6I_CSI_CAP_VCAP_ON);
-}
-
 /* Media */
 
 static const struct media_device_ops sun6i_csi_media_ops = {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index ff7bb7c0de01..a522aedb5ee6 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -90,13 +90,6 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable);
 int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
 			    struct sun6i_csi_config *config);
 
-/**
- * sun6i_csi_set_stream() - start/stop csi streaming
- * @csi:	pointer to the csi
- * @enable:	start/stop
- */
-void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable);
-
 /* get bpp form v4l2 pixformat */
 static inline int sun6i_csi_get_bpp(unsigned int pixformat)
 {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 0d844e3798e4..4c49d9206898 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -107,6 +107,51 @@ static bool sun6i_csi_capture_format_check(u32 format)
 
 /* Capture */
 
+static void sun6i_csi_capture_irq_enable(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+
+	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG,
+		     SUN6I_CSI_CH_INT_EN_VS |
+		     SUN6I_CSI_CH_INT_EN_HB_OF |
+		     SUN6I_CSI_CH_INT_EN_FIFO2_OF |
+		     SUN6I_CSI_CH_INT_EN_FIFO1_OF |
+		     SUN6I_CSI_CH_INT_EN_FIFO0_OF |
+		     SUN6I_CSI_CH_INT_EN_FD |
+		     SUN6I_CSI_CH_INT_EN_CD);
+}
+
+static void sun6i_csi_capture_irq_disable(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+
+	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG, 0);
+}
+
+static void sun6i_csi_capture_irq_clear(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+
+	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG, 0);
+	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG,
+		     SUN6I_CSI_CH_INT_STA_CLEAR);
+}
+
+static void sun6i_csi_capture_enable(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+
+	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON,
+			   SUN6I_CSI_CAP_VCAP_ON);
+}
+
+static void sun6i_csi_capture_disable(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+
+	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON, 0);
+}
+
 static void
 sun6i_csi_capture_buffer_configure(struct sun6i_csi_device *csi_dev,
 				   struct sun6i_csi_buffer *csi_buffer)
@@ -357,6 +402,10 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 		goto error_media_pipeline;
 	}
 
+	/* Clear */
+
+	sun6i_csi_capture_irq_clear(csi_dev);
+
 	/* Configure */
 
 	sun6i_csi_capture_configure(csi_dev);
@@ -367,7 +416,8 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 
 	/* Enable */
 
-	sun6i_csi_set_stream(csi_dev, true);
+	sun6i_csi_capture_irq_enable(csi_dev);
+	sun6i_csi_capture_enable(csi_dev);
 
 	ret = v4l2_subdev_call(subdev, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD)
@@ -376,7 +426,8 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	return 0;
 
 error_stream:
-	sun6i_csi_set_stream(csi_dev, false);
+	sun6i_csi_capture_disable(csi_dev);
+	sun6i_csi_capture_irq_disable(csi_dev);
 
 error_media_pipeline:
 	media_pipeline_stop(&video_dev->entity);
@@ -397,7 +448,8 @@ static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 	if (subdev)
 		v4l2_subdev_call(subdev, video, s_stream, 0);
 
-	sun6i_csi_set_stream(csi_dev, false);
+	sun6i_csi_capture_disable(csi_dev);
+	sun6i_csi_capture_irq_disable(csi_dev);
 
 	media_pipeline_stop(&capture->video_dev.entity);
 
-- 
2.37.1

