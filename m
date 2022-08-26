Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB37B5A2ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbiHZSgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344578AbiHZSeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:34:31 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB20EE68D0;
        Fri, 26 Aug 2022 11:33:43 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A246EFF803;
        Fri, 26 Aug 2022 18:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15uC+Ts5kucvenzoJDT+0IrfCFZWwp1tNALcgtZsrD8=;
        b=AV00MkQDwx/gdLMVxI14Ivf0MOGmrJ02zY5X4lap8cnXFqfKJSfn7B9Kz3fHPVzLHGgsa/
        Hg/nrej1BTSKKDPnkWeVZPJMg6Ur19fPziANUrbDqhbtpfleKNkOhghH7iy/rflfqVi0qz
        AFCCFkmziUOXldxfQOJhsJtN47x43yCi2T3QPCazDCR241nY9d9MU5Nsdk9pSPURXaj5m3
        pGLOp3n/Ee93Qh2o8idYsmujdYwaz+i7Ly0ZLpMiSk/SUfb39YBNPwjDv6ovV2mSK82FYG
        Z6NyriqYimhqDspwUwMQdYnqWxaiOQADxvv1kN/uMLAz18cOHEkDpuB6OmxHKQ==
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
Subject: [PATCH v6 32/43] media: sun6i-csi: Configure registers from format tables
Date:   Fri, 26 Aug 2022 20:32:29 +0200
Message-Id: <20220826183240.604834-33-paul.kocialkowski@bootlin.com>
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

Switch over to using the static format table descriptions to configure
registers. Rework the hardware configuration helpers to leverage
information from the format structures and benefit from their logic.
Remove the previous dedicated helpers.

The intention is to make the interaction between the different formats
and the hardware side more visible and clear.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 210 +++---------------
 .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  |  55 -----
 2 files changed, 36 insertions(+), 229 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 628add17bf57..b2e76ce53907 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -319,163 +319,6 @@ sun6i_csi_capture_buffer_configure(struct sun6i_csi_device *csi_dev,
 	}
 }
 
-static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device *csi_dev,
-					       u32 mbus_code, u32 pixformat)
-{
-	/* non-YUV */
-	if ((mbus_code & 0xF000) != 0x2000)
-		return CSI_INPUT_FORMAT_RAW;
-
-	switch (pixformat) {
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-		return CSI_INPUT_FORMAT_RAW;
-	default:
-		break;
-	}
-
-	/* not support YUV420 input format yet */
-	dev_dbg(csi_dev->dev, "Select YUV422 as default input format of CSI.\n");
-	return CSI_INPUT_FORMAT_YUV422;
-}
-
-static enum csi_output_fmt
-get_csi_output_format(struct sun6i_csi_device *csi_dev, u32 pixformat,
-		      u32 field)
-{
-	bool buf_interlaced = false;
-
-	if (field == V4L2_FIELD_INTERLACED
-	    || field == V4L2_FIELD_INTERLACED_TB
-	    || field == V4L2_FIELD_INTERLACED_BT)
-		buf_interlaced = true;
-
-	switch (pixformat) {
-	case V4L2_PIX_FMT_SBGGR8:
-	case V4L2_PIX_FMT_SGBRG8:
-	case V4L2_PIX_FMT_SGRBG8:
-	case V4L2_PIX_FMT_SRGGB8:
-		return buf_interlaced ? CSI_FRAME_RAW_8 : CSI_FIELD_RAW_8;
-	case V4L2_PIX_FMT_SBGGR10:
-	case V4L2_PIX_FMT_SGBRG10:
-	case V4L2_PIX_FMT_SGRBG10:
-	case V4L2_PIX_FMT_SRGGB10:
-		return buf_interlaced ? CSI_FRAME_RAW_10 : CSI_FIELD_RAW_10;
-	case V4L2_PIX_FMT_SBGGR12:
-	case V4L2_PIX_FMT_SGBRG12:
-	case V4L2_PIX_FMT_SGRBG12:
-	case V4L2_PIX_FMT_SRGGB12:
-		return buf_interlaced ? CSI_FRAME_RAW_12 : CSI_FIELD_RAW_12;
-
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-		return buf_interlaced ? CSI_FRAME_RAW_8 : CSI_FIELD_RAW_8;
-
-	case V4L2_PIX_FMT_NV12_16L16:
-		return buf_interlaced ? CSI_FRAME_MB_YUV420 :
-					CSI_FIELD_MB_YUV420;
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-		return buf_interlaced ? CSI_FRAME_UV_CB_YUV420 :
-					CSI_FIELD_UV_CB_YUV420;
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_YVU420:
-		return buf_interlaced ? CSI_FRAME_PLANAR_YUV420 :
-					CSI_FIELD_PLANAR_YUV420;
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		return buf_interlaced ? CSI_FRAME_UV_CB_YUV422 :
-					CSI_FIELD_UV_CB_YUV422;
-	case V4L2_PIX_FMT_YUV422P:
-		return buf_interlaced ? CSI_FRAME_PLANAR_YUV422 :
-					CSI_FIELD_PLANAR_YUV422;
-
-	case V4L2_PIX_FMT_RGB565:
-	case V4L2_PIX_FMT_RGB565X:
-		return buf_interlaced ? CSI_FRAME_RGB565 : CSI_FIELD_RGB565;
-
-	case V4L2_PIX_FMT_JPEG:
-		return buf_interlaced ? CSI_FRAME_RAW_8 : CSI_FIELD_RAW_8;
-
-	default:
-		dev_warn(csi_dev->dev, "Unsupported pixformat: 0x%x\n", pixformat);
-		break;
-	}
-
-	return CSI_FIELD_RAW_8;
-}
-
-static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_device *csi_dev,
-					    u32 mbus_code, u32 pixformat)
-{
-	/* Input sequence does not apply to non-YUV formats */
-	if ((mbus_code & 0xF000) != 0x2000)
-		return 0;
-
-	switch (pixformat) {
-	case V4L2_PIX_FMT_NV12_16L16:
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_YUV422P:
-		switch (mbus_code) {
-		case MEDIA_BUS_FMT_UYVY8_2X8:
-		case MEDIA_BUS_FMT_UYVY8_1X16:
-			return CSI_INPUT_SEQ_UYVY;
-		case MEDIA_BUS_FMT_VYUY8_2X8:
-		case MEDIA_BUS_FMT_VYUY8_1X16:
-			return CSI_INPUT_SEQ_VYUY;
-		case MEDIA_BUS_FMT_YUYV8_2X8:
-		case MEDIA_BUS_FMT_YUYV8_1X16:
-			return CSI_INPUT_SEQ_YUYV;
-		case MEDIA_BUS_FMT_YVYU8_1X16:
-		case MEDIA_BUS_FMT_YVYU8_2X8:
-			return CSI_INPUT_SEQ_YVYU;
-		default:
-			dev_warn(csi_dev->dev, "Unsupported mbus code: 0x%x\n",
-				 mbus_code);
-			break;
-		}
-		break;
-	case V4L2_PIX_FMT_NV21:
-	case V4L2_PIX_FMT_NV61:
-	case V4L2_PIX_FMT_YVU420:
-		switch (mbus_code) {
-		case MEDIA_BUS_FMT_UYVY8_2X8:
-		case MEDIA_BUS_FMT_UYVY8_1X16:
-			return CSI_INPUT_SEQ_VYUY;
-		case MEDIA_BUS_FMT_VYUY8_2X8:
-		case MEDIA_BUS_FMT_VYUY8_1X16:
-			return CSI_INPUT_SEQ_UYVY;
-		case MEDIA_BUS_FMT_YUYV8_2X8:
-		case MEDIA_BUS_FMT_YUYV8_1X16:
-			return CSI_INPUT_SEQ_YVYU;
-		case MEDIA_BUS_FMT_YVYU8_1X16:
-		case MEDIA_BUS_FMT_YVYU8_2X8:
-			return CSI_INPUT_SEQ_YUYV;
-		default:
-			dev_warn(csi_dev->dev, "Unsupported mbus code: 0x%x\n",
-				 mbus_code);
-			break;
-		}
-		break;
-
-	case V4L2_PIX_FMT_YUYV:
-		return CSI_INPUT_SEQ_YUYV;
-
-	default:
-		dev_warn(csi_dev->dev, "Unsupported pixformat: 0x%x, defaulting to YUYV\n",
-			 pixformat);
-		break;
-	}
-
-	return CSI_INPUT_SEQ_YUYV;
-}
-
 static void
 sun6i_csi_capture_configure_interface(struct sun6i_csi_device *csi_dev)
 {
@@ -570,6 +413,8 @@ sun6i_csi_capture_configure_interface(struct sun6i_csi_device *csi_dev)
 static void sun6i_csi_capture_configure_format(struct sun6i_csi_device *csi_dev)
 {
 	struct regmap *regmap = csi_dev->regmap;
+	const struct sun6i_csi_bridge_format *bridge_format;
+	const struct sun6i_csi_capture_format *capture_format;
 	u32 mbus_code, pixelformat, field;
 	u8 input_format, input_yuv_seq, output_format;
 	u32 value = 0;
@@ -577,9 +422,29 @@ static void sun6i_csi_capture_configure_format(struct sun6i_csi_device *csi_dev)
 	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
 	sun6i_csi_bridge_format(csi_dev, &mbus_code, NULL);
 
-	input_format = get_csi_input_format(csi_dev, mbus_code, pixelformat);
-	input_yuv_seq = get_csi_input_seq(csi_dev, mbus_code, pixelformat);
-	output_format = get_csi_output_format(csi_dev, pixelformat, field);
+	bridge_format = sun6i_csi_bridge_format_find(mbus_code);
+	if (WARN_ON(!bridge_format))
+		return;
+
+	input_format = bridge_format->input_format;
+	input_yuv_seq = bridge_format->input_yuv_seq;
+
+	capture_format = sun6i_csi_capture_format_find(pixelformat);
+	if (WARN_ON(!capture_format))
+		return;
+
+	if (capture_format->input_format_raw)
+		input_format = SUN6I_CSI_INPUT_FMT_RAW;
+
+	if (capture_format->input_yuv_seq_invert)
+		input_yuv_seq = bridge_format->input_yuv_seq_invert;
+
+	if (field == V4L2_FIELD_INTERLACED ||
+	    field == V4L2_FIELD_INTERLACED_TB ||
+	    field == V4L2_FIELD_INTERLACED_BT)
+		output_format = capture_format->output_format_field;
+	else
+		output_format = capture_format->output_format_frame;
 
 	value |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(output_format);
 	value |= SUN6I_CSI_CH_CFG_INPUT_FMT(input_format);
@@ -598,6 +463,7 @@ static void sun6i_csi_capture_configure_format(struct sun6i_csi_device *csi_dev)
 static void sun6i_csi_capture_configure_window(struct sun6i_csi_device *csi_dev)
 {
 	struct regmap *regmap = csi_dev->regmap;
+	const struct sun6i_csi_capture_format *format;
 	const struct v4l2_format_info *info;
 	u32 hsize_len, vsize_len;
 	u32 luma_line, chroma_line = 0;
@@ -607,23 +473,19 @@ static void sun6i_csi_capture_configure_window(struct sun6i_csi_device *csi_dev)
 	sun6i_csi_capture_dimensions(csi_dev, &width, &height);
 	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
 
+	format = sun6i_csi_capture_format_find(pixelformat);
+	if (WARN_ON(!format))
+		return;
+
 	hsize_len = width;
 	vsize_len = height;
 
-	switch (pixelformat) {
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-		/*
-		 * Horizontal length should be 2 times of width for packed
-		 * YUV formats.
-		 */
-		hsize_len *= 2;
-		break;
-	default:
-		break;
-	}
+	/*
+	 * When using 8-bit raw input/output (for packed YUV), we need to adapt
+	 * the width to account for the difference in bpp when it's not 8-bit.
+	 */
+	if (format->hsize_len_factor)
+		hsize_len *= format->hsize_len_factor;
 
 	regmap_write(regmap, SUN6I_CSI_CH_HSIZE_REG,
 		     SUN6I_CSI_CH_HSIZE_LEN(hsize_len) |
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
index 9b0326d6ba3c..1e4a07f26d1d 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
@@ -180,59 +180,4 @@
 #define SUN6I_CSI_CH_FIFO_STAT_REG		0x98
 #define SUN6I_CSI_CH_PCLK_STAT_REG		0x9c
 
-/*
- * csi input data format
- */
-enum csi_input_fmt {
-	CSI_INPUT_FORMAT_RAW		= 0,
-	CSI_INPUT_FORMAT_YUV422		= 3,
-	CSI_INPUT_FORMAT_YUV420		= 4,
-};
-
-/*
- * csi output data format
- */
-enum csi_output_fmt {
-	/* only when input format is RAW */
-	CSI_FIELD_RAW_8			= 0,
-	CSI_FIELD_RAW_10		= 1,
-	CSI_FIELD_RAW_12		= 2,
-	CSI_FIELD_RGB565		= 4,
-	CSI_FIELD_RGB888		= 5,
-	CSI_FIELD_PRGB888		= 6,
-	CSI_FRAME_RAW_8			= 8,
-	CSI_FRAME_RAW_10		= 9,
-	CSI_FRAME_RAW_12		= 10,
-	CSI_FRAME_RGB565		= 12,
-	CSI_FRAME_RGB888		= 13,
-	CSI_FRAME_PRGB888		= 14,
-
-	/* only when input format is YUV422 */
-	CSI_FIELD_PLANAR_YUV422		= 0,
-	CSI_FIELD_PLANAR_YUV420		= 1,
-	CSI_FRAME_PLANAR_YUV420		= 2,
-	CSI_FRAME_PLANAR_YUV422		= 3,
-	CSI_FIELD_UV_CB_YUV422		= 4,
-	CSI_FIELD_UV_CB_YUV420		= 5,
-	CSI_FRAME_UV_CB_YUV420		= 6,
-	CSI_FRAME_UV_CB_YUV422		= 7,
-	CSI_FIELD_MB_YUV422		= 8,
-	CSI_FIELD_MB_YUV420		= 9,
-	CSI_FRAME_MB_YUV420		= 10,
-	CSI_FRAME_MB_YUV422		= 11,
-	CSI_FIELD_UV_CB_YUV422_10	= 12,
-	CSI_FIELD_UV_CB_YUV420_10	= 13,
-};
-
-/*
- * csi YUV input data sequence
- */
-enum csi_input_seq {
-	/* only when input format is YUV422 */
-	CSI_INPUT_SEQ_YUYV = 0,
-	CSI_INPUT_SEQ_YVYU,
-	CSI_INPUT_SEQ_UYVY,
-	CSI_INPUT_SEQ_VYUY,
-};
-
 #endif /* __SUN6I_CSI_REG_H__ */
-- 
2.37.1

