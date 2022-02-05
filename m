Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9204AABB5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381854AbiBES5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:57:38 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39013 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbiBESzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:49 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BC4B5240010;
        Sat,  5 Feb 2022 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h75JqJgq6QG+QOajI+uXIxRh4Nj5dGBymygUtKmDRes=;
        b=JZzyEEQE91vY0aTTIZs5rZcxQDqtAH20J36gTZWsh2QwLca6y5yIY8WGY/o9R1gKx9gzO/
        MsfPl91BGIxchRs9ARg8MjkM7QTHsN6yy8gwpP8pLg5mzJageBnvNaZYmagsyqj+K3gm7+
        vOsSablNoBhsHHjBUmv9arVDe5toKXH+UNFMNr0SNgCnt7PpmI09Cqpz37loFoCVSvzBjZ
        jlK/DRN52VocOG74Oqw911gR2se7P4FtqzRnS+FwXlRPLcAovQQDm7zHontyyQM9xLWgpJ
        e8xxFAkxcc23j6b3O77MbmTREs+xwtuplWTPUHXXVqf6VAr6qKibg1cq24OoeA==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 40/66] media: sun6i-csi: Remove custom format helper and rework configure
Date:   Sat,  5 Feb 2022 19:54:03 +0100
Message-Id: <20220205185429.2278860-41-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the custom sun6i_csi_get_bpp helper in favor of common v4l2
infrastructure and rework the related window configuration code.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      | 49 -------------
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 70 +++++++++----------
 2 files changed, 35 insertions(+), 84 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index c37bbab93cd5..c687213924d4 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -57,55 +57,6 @@ struct sun6i_csi_device {
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
 int sun6i_csi_v4l2_complete(struct sun6i_csi_device *csi_dev);
 
 #endif /* __SUN6I_CSI_H__ */
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 9c8b33c7e59c..f977b89dcea2 100644
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
2.34.1

