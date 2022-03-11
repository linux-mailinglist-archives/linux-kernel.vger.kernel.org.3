Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3134D63E6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiCKOkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349574AbiCKOhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:39 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A801C9455;
        Fri, 11 Mar 2022 06:36:30 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 50B90240004;
        Fri, 11 Mar 2022 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iggvo2rKOQxtmuPw2qJyHa5S/fk0RafXxscwtfDj1dg=;
        b=l9t27ymgioqxk7VMuWg/PvC3tPc7/UErsoxRubSz31jmRdbEC0qRkTI0l+7Yonz1Ba8MUz
        VVKgEiwiGzKKZzK96DGmG9o/JFR2xhwQcjFYA677mnScynZ9MlRl77npkKBGQta/uouBpT
        eRNdAxPFeeMv2LSX5GV2LPAcRfZCtJT+UwVcJ7BV95fecJ2JJS2x/XtRVoydAW81Zg7UyL
        p/Rx39pi2Vwga2MUx4zewJD8Bas7j1ttgYhiiE3mPJI1JcNm/6BEorzAq3uAeFsv6pKWE2
        9sxevk6fr/NG64ZB2LF+jzsalYlpbdWdZmxV40yRJYCfuMmkD1vaaVh+Qxm0ig==
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
Subject: [PATCH v3 26/46] media: sun6i-csi: Remove custom format helper and rework configure
Date:   Fri, 11 Mar 2022 15:35:12 +0100
Message-Id: <20220311143532.265091-27-paul.kocialkowski@bootlin.com>
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

Remove the custom sun6i_csi_get_bpp helper in favor of common v4l2
infrastructure and rework the related window configuration code.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      | 49 -------------
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 70 +++++++++----------
 2 files changed, 35 insertions(+), 84 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 8a9586e02f73..21932aae3636 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -61,53 +61,4 @@ struct sun6i_csi_variant {
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
2.35.1

