Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B575343E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbiEYTJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344152AbiEYTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:07:20 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A62311476;
        Wed, 25 May 2022 12:07:00 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B184C1C0010;
        Wed, 25 May 2022 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SemjHgwYJIzY6ISbtDoRkFIj91dGcCB7+/YHQ/1LTGs=;
        b=hYGHd1xtoo67DxUXvuh/ifTWqWlylBrHpNRlsBC809/6k7iKvSwg3kICXmQnS0HVfcbqfh
        kxn2WTvjCqZakv4R7XBpTIaoL6McxhhI9xOWIDiBrflz9LyZITZcenO5YPGObHTSaZkn2H
        ozOUgIWR9qIdjQNU6Y6G7EVy/n48qy+HoZPjE7gMHRoanz/3Mop3Ed9aS/tQjCSUWNQMLV
        McnStW4ytvM1iBlmFGYhq/YM9DnGWxIidT7dh/4xwtHEIUdPT6UT5UiPuTd3iQV0VK736g
        5XCzH0CyJyG3YqVQHUg5fyuKZ4BfvFHGNsDgbTjiSLmW0EKTm2CYScfZ9rAgmw==
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
Subject: [PATCH v5 27/44] media: sun6i-csi: Remove custom format helper and rework configure
Date:   Wed, 25 May 2022 21:06:00 +0200
Message-Id: <20220525190617.696344-28-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
References: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
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

Remove the custom sun6i_csi_get_bpp helper in favor of common v4l2
infrastructure and rework the related window configuration code.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      | 49 -------------
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 70 +++++++++----------
 2 files changed, 35 insertions(+), 84 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index c52a8d94f7de..fdb36c1311ba 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -58,53 +58,4 @@ struct sun6i_csi_variant {
 bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 				   u32 pixformat, u32 mbus_code);
 
-/* get bpp form v4l2 pixformat */
-static inline int sun6i_csi_get_bpp(unsigned int pixformat)
-{
-	switch (pixformat) {
-	case V4L2_PIX_FMT_SBGGR8:
-	case V4L2_PIX_FMT_SGBRG8:
-	case V4L2_PIX_FMT_SGRBG8:
-	case V4L2_PIX_FMT_SRGGB8:
-	case V4L2_PIX_FMT_JPEG:
-		return 8;
-	case V4L2_PIX_FMT_SBGGR10:
-	case V4L2_PIX_FMT_SGBRG10:
-	case V4L2_PIX_FMT_SGRBG10:
-	case V4L2_PIX_FMT_SRGGB10:
-		return 10;
-	case V4L2_PIX_FMT_SBGGR12:
-	case V4L2_PIX_FMT_SGBRG12:
-	case V4L2_PIX_FMT_SGRBG12:
-	case V4L2_PIX_FMT_SRGGB12:
-	case V4L2_PIX_FMT_NV12_16L16:
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_YVU420:
-		return 12;
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-	case V4L2_PIX_FMT_YUV422P:
-	case V4L2_PIX_FMT_RGB565:
-	case V4L2_PIX_FMT_RGB565X:
-		return 16;
-	case V4L2_PIX_FMT_RGB24:
-	case V4L2_PIX_FMT_BGR24:
-		return 24;
-	case V4L2_PIX_FMT_RGB32:
-	case V4L2_PIX_FMT_BGR32:
-		return 32;
-	default:
-		WARN(1, "Unsupported pixformat: 0x%x\n", pixformat);
-		break;
-	}
-
-	return 0;
-}
-
 #endif /* __SUN6I_CSI_H__ */
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 5c99981be7f0..c8d350c1dea8 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -483,68 +483,68 @@ static void sun6i_csi_capture_configure_format(struct sun6i_csi_device *csi_dev)
 
 static void sun6i_csi_capture_configure_window(struct sun6i_csi_device *csi_dev)
 {
+	struct regmap *regmap = csi_dev->regmap;
+	const struct v4l2_format_info *info;
+	u32 hsize_len, vsize_len;
+	u32 luma_line, chroma_line = 0;
 	u32 pixelformat, field;
 	u32 width, height;
-	u32 bytesperline_y;
-	u32 bytesperline_c;
-	u32 hor_len;
 
 	sun6i_csi_capture_dimensions(csi_dev, &width, &height);
 	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
 
-	hor_len = width;
+	hsize_len = width;
+	vsize_len = height;
 
 	switch (pixelformat) {
 	case V4L2_PIX_FMT_YUYV:
 	case V4L2_PIX_FMT_YVYU:
 	case V4L2_PIX_FMT_UYVY:
 	case V4L2_PIX_FMT_VYUY:
-		dev_dbg(csi_dev->dev,
-			"Horizontal length should be 2 times of width for packed YUV formats!\n");
-		hor_len = width * 2;
+		/*
+		 * Horizontal length should be 2 times of width for packed
+		 * YUV formats.
+		 */
+		hsize_len *= 2;
 		break;
 	default:
 		break;
 	}
 
-	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_HSIZE_REG,
-		     SUN6I_CSI_CH_HSIZE_LEN(hor_len) |
+	regmap_write(regmap, SUN6I_CSI_CH_HSIZE_REG,
+		     SUN6I_CSI_CH_HSIZE_LEN(hsize_len) |
 		     SUN6I_CSI_CH_HSIZE_START(0));
-	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_VSIZE_REG,
-		     SUN6I_CSI_CH_VSIZE_LEN(height) |
+
+	regmap_write(regmap, SUN6I_CSI_CH_VSIZE_REG,
+		     SUN6I_CSI_CH_VSIZE_LEN(vsize_len) |
 		     SUN6I_CSI_CH_VSIZE_START(0));
 
 	switch (pixelformat) {
-	case V4L2_PIX_FMT_NV12_16L16:
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		bytesperline_y = width;
-		bytesperline_c = width;
+	case V4L2_PIX_FMT_RGB565X:
+		luma_line = width * 2;
 		break;
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_YVU420:
-		bytesperline_y = width;
-		bytesperline_c = width / 2;
+	case V4L2_PIX_FMT_NV12_16L16:
+		luma_line = width;
+		chroma_line = width;
 		break;
-	case V4L2_PIX_FMT_YUV422P:
-		bytesperline_y = width;
-		bytesperline_c = width / 2;
+	case V4L2_PIX_FMT_JPEG:
+		luma_line = width;
 		break;
-	default: /* raw */
-		dev_dbg(csi_dev->dev,
-			"Calculating pixelformat(0x%x)'s bytesperline as a packed format\n",
-			pixelformat);
-		bytesperline_y = (sun6i_csi_get_bpp(pixelformat) *
-				  width) / 8;
-		bytesperline_c = 0;
+	default:
+		info = v4l2_format_info(pixelformat);
+		if (WARN_ON(!info))
+			return;
+
+		luma_line = width * info->bpp[0];
+
+		if (info->comp_planes > 1)
+			chroma_line = width * info->bpp[1] / info->hdiv;
 		break;
 	}
 
-	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_BUF_LEN_REG,
-		     SUN6I_CSI_CH_BUF_LEN_CHROMA_LINE(bytesperline_c) |
-		     SUN6I_CSI_CH_BUF_LEN_LUMA_LINE(bytesperline_y));
+	regmap_write(regmap, SUN6I_CSI_CH_BUF_LEN_REG,
+		     SUN6I_CSI_CH_BUF_LEN_CHROMA_LINE(chroma_line) |
+		     SUN6I_CSI_CH_BUF_LEN_LUMA_LINE(luma_line));
 }
 
 static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)
-- 
2.36.1

