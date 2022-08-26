Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC75A2EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345126AbiHZSfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344948AbiHZSd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:58 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E73E42E4;
        Fri, 26 Aug 2022 11:33:35 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0D86AFF809;
        Fri, 26 Aug 2022 18:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gz4nFjG9z0uU6+vANtFfAhiCgurnftmlzNVDlRQ1KdQ=;
        b=VIadjRg7TIC3jyGGHVGr2S7RfbYVOEqAT1bTImLo4QL6cGv1aeTVFROZorsuBZ1sz9wVNs
        KTERwZBsoymPkXMacpp3YzwdszqmZN7q0kqdwq2sXdRvO9qRcZSgp7uapH7yeRldRuqvp7
        NNxwuTZTc3lWyqlA2OALKbWO0hFF632qpWNRpoY9H+q6gfycOKCUjO2wzDexod/H9J68lc
        +1R0mZVf6ViDSQkSj162kKFsbvrnE1KDigPrNPXHn1jee9bDMCR4BGHMPvNMQvC/RJrxyx
        7VqRf3pPuj0SpOH89fYNCen3OS43oZvhJAmu7a2JeiCRUcM8ph+LxZGbzVNdQA==
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
Subject: [PATCH v6 24/43] media: sun6i-csi: Move register configuration to capture
Date:   Fri, 26 Aug 2022 20:32:21 +0200
Message-Id: <20220826183240.604834-25-paul.kocialkowski@bootlin.com>
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

Continue moving things over to capture in tidy helpers.
Also take the occasion to remove the config struct, which is
unwelcome redundancy and use the capture helpers instead.

The code is only adapted to reflect the removal of the config
structure. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 363 -----------------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  25 --
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 364 +++++++++++++++++-
 3 files changed, 356 insertions(+), 396 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 9a12077ea03a..47ea3d68a4b5 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -148,369 +148,6 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 	return false;
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
-static void sun6i_csi_setup_bus(struct sun6i_csi_device *csi_dev)
-{
-	struct v4l2_fwnode_endpoint *endpoint =
-		&csi_dev->bridge.source_parallel.endpoint;
-	struct sun6i_csi_config *config = &csi_dev->config;
-	unsigned char bus_width;
-	u32 flags;
-	u32 cfg = 0;
-	bool input_interlaced = false;
-
-	if (config->field == V4L2_FIELD_INTERLACED
-	    || config->field == V4L2_FIELD_INTERLACED_TB
-	    || config->field == V4L2_FIELD_INTERLACED_BT)
-		input_interlaced = true;
-
-	bus_width = endpoint->bus.parallel.bus_width;
-
-	if (input_interlaced)
-		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED |
-		       SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(1) |
-		       SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC;
-	else
-		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
-
-	switch (endpoint->bus_type) {
-	case V4L2_MBUS_PARALLEL:
-		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
-
-		flags = endpoint->bus.parallel.flags;
-
-		if (bus_width == 16)
-			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED;
-		else
-			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW;
-
-		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
-			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
-		else
-			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
-
-		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
-			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE;
-		else
-			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE;
-
-		if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
-			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE;
-		else
-			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE;
-
-		if (flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
-			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
-		else
-			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
-		break;
-	case V4L2_MBUS_BT656:
-		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
-
-		flags = endpoint->bus.parallel.flags;
-
-		if (bus_width == 16)
-			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT1120;
-		else
-			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT656;
-
-		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
-			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
-		else
-			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
-
-		if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
-			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
-		else
-			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
-		break;
-	default:
-		dev_warn(csi_dev->dev, "Unsupported bus type: %d\n",
-			 endpoint->bus_type);
-		break;
-	}
-
-	switch (bus_width) {
-	case 8:
-		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_8;
-		break;
-	case 10:
-		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_10;
-		break;
-	case 12:
-		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_12;
-		break;
-	case 16: /* No need to configure DATA_WIDTH for 16bit */
-		break;
-	default:
-		dev_warn(csi_dev->dev, "Unsupported bus width: %u\n", bus_width);
-		break;
-	}
-
-	regmap_write(csi_dev->regmap, SUN6I_CSI_IF_CFG_REG, cfg);
-}
-
-static void sun6i_csi_set_format(struct sun6i_csi_device *csi_dev)
-{
-	struct sun6i_csi_config *config = &csi_dev->config;
-	u32 cfg = 0;
-	u32 val;
-
-	val = get_csi_input_format(csi_dev, config->code,
-				   config->pixelformat);
-	cfg |= SUN6I_CSI_CH_CFG_INPUT_FMT(val);
-
-	val = get_csi_output_format(csi_dev, config->pixelformat,
-				    config->field);
-	cfg |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(val);
-
-	val = get_csi_input_seq(csi_dev, config->code,
-				config->pixelformat);
-	cfg |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(val);
-
-	if (config->field == V4L2_FIELD_TOP)
-		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0;
-	else if (config->field == V4L2_FIELD_BOTTOM)
-		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1;
-	else
-		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER;
-
-	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_CFG_REG, cfg);
-}
-
-static void sun6i_csi_set_window(struct sun6i_csi_device *csi_dev)
-{
-	struct sun6i_csi_config *config = &csi_dev->config;
-	u32 bytesperline_y;
-	u32 bytesperline_c;
-	u32 width = config->width;
-	u32 height = config->height;
-	u32 hor_len = width;
-
-	switch (config->pixelformat) {
-	case V4L2_PIX_FMT_YUYV:
-	case V4L2_PIX_FMT_YVYU:
-	case V4L2_PIX_FMT_UYVY:
-	case V4L2_PIX_FMT_VYUY:
-		dev_dbg(csi_dev->dev,
-			"Horizontal length should be 2 times of width for packed YUV formats!\n");
-		hor_len = width * 2;
-		break;
-	default:
-		break;
-	}
-
-	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_HSIZE_REG,
-		     SUN6I_CSI_CH_HSIZE_LEN(hor_len) |
-		     SUN6I_CSI_CH_HSIZE_START(0));
-	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_VSIZE_REG,
-		     SUN6I_CSI_CH_VSIZE_LEN(height) |
-		     SUN6I_CSI_CH_VSIZE_START(0));
-
-	switch (config->pixelformat) {
-	case V4L2_PIX_FMT_NV12_16L16:
-	case V4L2_PIX_FMT_NV12:
-	case V4L2_PIX_FMT_NV21:
-	case V4L2_PIX_FMT_NV16:
-	case V4L2_PIX_FMT_NV61:
-		bytesperline_y = width;
-		bytesperline_c = width;
-		break;
-	case V4L2_PIX_FMT_YUV420:
-	case V4L2_PIX_FMT_YVU420:
-		bytesperline_y = width;
-		bytesperline_c = width / 2;
-		break;
-	case V4L2_PIX_FMT_YUV422P:
-		bytesperline_y = width;
-		bytesperline_c = width / 2;
-		break;
-	default: /* raw */
-		dev_dbg(csi_dev->dev,
-			"Calculating pixelformat(0x%x)'s bytesperline as a packed format\n",
-			config->pixelformat);
-		bytesperline_y = (sun6i_csi_get_bpp(config->pixelformat) *
-				  config->width) / 8;
-		bytesperline_c = 0;
-		break;
-	}
-
-	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_BUF_LEN_REG,
-		     SUN6I_CSI_CH_BUF_LEN_CHROMA_LINE(bytesperline_c) |
-		     SUN6I_CSI_CH_BUF_LEN_LUMA_LINE(bytesperline_y));
-}
-
-int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
-			    struct sun6i_csi_config *config)
-{
-	if (!config)
-		return -EINVAL;
-
-	memcpy(&csi_dev->config, config, sizeof(csi_dev->config));
-
-	sun6i_csi_setup_bus(csi_dev);
-	sun6i_csi_set_format(csi_dev);
-	sun6i_csi_set_window(csi_dev);
-
-	return 0;
-}
-
 /* Media */
 
 static const struct media_device_ops sun6i_csi_media_ops = {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 1e3bac1829dc..c52a8d94f7de 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -27,22 +27,6 @@ struct sun6i_csi_buffer {
 	struct list_head		list;
 };
 
-/**
- * struct sun6i_csi_config - configs for sun6i csi
- * @pixelformat: v4l2 pixel format (V4L2_PIX_FMT_*)
- * @code:	media bus format code (MEDIA_BUS_FMT_*)
- * @field:	used interlacing type (enum v4l2_field)
- * @width:	frame width
- * @height:	frame height
- */
-struct sun6i_csi_config {
-	u32		pixelformat;
-	u32		code;
-	u32		field;
-	u32		width;
-	u32		height;
-};
-
 struct sun6i_csi_v4l2 {
 	struct v4l2_device		v4l2_dev;
 	struct media_device		media_dev;
@@ -51,7 +35,6 @@ struct sun6i_csi_v4l2 {
 struct sun6i_csi_device {
 	struct device			*dev;
 
-	struct sun6i_csi_config		config;
 	struct sun6i_csi_v4l2		v4l2;
 	struct sun6i_csi_bridge		bridge;
 	struct sun6i_csi_capture	capture;
@@ -75,14 +58,6 @@ struct sun6i_csi_variant {
 bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 				   u32 pixformat, u32 mbus_code);
 
-/**
- * sun6i_csi_update_config() - update the csi register settings
- * @csi:	pointer to the csi
- * @config:	see struct sun6i_csi_config
- */
-int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
-			    struct sun6i_csi_config *config);
-
 /* get bpp form v4l2 pixformat */
 static inline int sun6i_csi_get_bpp(unsigned int pixformat)
 {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 0b66f3ab1285..04bcd9621455 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -198,18 +198,366 @@ sun6i_csi_capture_buffer_configure(struct sun6i_csi_device *csi_dev,
 	}
 }
 
-static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)
+static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device *csi_dev,
+					       u32 mbus_code, u32 pixformat)
+{
+	/* non-YUV */
+	if ((mbus_code & 0xF000) != 0x2000)
+		return CSI_INPUT_FORMAT_RAW;
+
+	switch (pixformat) {
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_YVYU:
+	case V4L2_PIX_FMT_UYVY:
+	case V4L2_PIX_FMT_VYUY:
+		return CSI_INPUT_FORMAT_RAW;
+	default:
+		break;
+	}
+
+	/* not support YUV420 input format yet */
+	dev_dbg(csi_dev->dev, "Select YUV422 as default input format of CSI.\n");
+	return CSI_INPUT_FORMAT_YUV422;
+}
+
+static enum csi_output_fmt
+get_csi_output_format(struct sun6i_csi_device *csi_dev, u32 pixformat,
+		      u32 field)
+{
+	bool buf_interlaced = false;
+
+	if (field == V4L2_FIELD_INTERLACED
+	    || field == V4L2_FIELD_INTERLACED_TB
+	    || field == V4L2_FIELD_INTERLACED_BT)
+		buf_interlaced = true;
+
+	switch (pixformat) {
+	case V4L2_PIX_FMT_SBGGR8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SRGGB8:
+		return buf_interlaced ? CSI_FRAME_RAW_8 : CSI_FIELD_RAW_8;
+	case V4L2_PIX_FMT_SBGGR10:
+	case V4L2_PIX_FMT_SGBRG10:
+	case V4L2_PIX_FMT_SGRBG10:
+	case V4L2_PIX_FMT_SRGGB10:
+		return buf_interlaced ? CSI_FRAME_RAW_10 : CSI_FIELD_RAW_10;
+	case V4L2_PIX_FMT_SBGGR12:
+	case V4L2_PIX_FMT_SGBRG12:
+	case V4L2_PIX_FMT_SGRBG12:
+	case V4L2_PIX_FMT_SRGGB12:
+		return buf_interlaced ? CSI_FRAME_RAW_12 : CSI_FIELD_RAW_12;
+
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_YVYU:
+	case V4L2_PIX_FMT_UYVY:
+	case V4L2_PIX_FMT_VYUY:
+		return buf_interlaced ? CSI_FRAME_RAW_8 : CSI_FIELD_RAW_8;
+
+	case V4L2_PIX_FMT_NV12_16L16:
+		return buf_interlaced ? CSI_FRAME_MB_YUV420 :
+					CSI_FIELD_MB_YUV420;
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+		return buf_interlaced ? CSI_FRAME_UV_CB_YUV420 :
+					CSI_FIELD_UV_CB_YUV420;
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YVU420:
+		return buf_interlaced ? CSI_FRAME_PLANAR_YUV420 :
+					CSI_FIELD_PLANAR_YUV420;
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		return buf_interlaced ? CSI_FRAME_UV_CB_YUV422 :
+					CSI_FIELD_UV_CB_YUV422;
+	case V4L2_PIX_FMT_YUV422P:
+		return buf_interlaced ? CSI_FRAME_PLANAR_YUV422 :
+					CSI_FIELD_PLANAR_YUV422;
+
+	case V4L2_PIX_FMT_RGB565:
+	case V4L2_PIX_FMT_RGB565X:
+		return buf_interlaced ? CSI_FRAME_RGB565 : CSI_FIELD_RGB565;
+
+	case V4L2_PIX_FMT_JPEG:
+		return buf_interlaced ? CSI_FRAME_RAW_8 : CSI_FIELD_RAW_8;
+
+	default:
+		dev_warn(csi_dev->dev, "Unsupported pixformat: 0x%x\n", pixformat);
+		break;
+	}
+
+	return CSI_FIELD_RAW_8;
+}
+
+static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_device *csi_dev,
+					    u32 mbus_code, u32 pixformat)
+{
+	/* Input sequence does not apply to non-YUV formats */
+	if ((mbus_code & 0xF000) != 0x2000)
+		return 0;
+
+	switch (pixformat) {
+	case V4L2_PIX_FMT_NV12_16L16:
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YUV422P:
+		switch (mbus_code) {
+		case MEDIA_BUS_FMT_UYVY8_2X8:
+		case MEDIA_BUS_FMT_UYVY8_1X16:
+			return CSI_INPUT_SEQ_UYVY;
+		case MEDIA_BUS_FMT_VYUY8_2X8:
+		case MEDIA_BUS_FMT_VYUY8_1X16:
+			return CSI_INPUT_SEQ_VYUY;
+		case MEDIA_BUS_FMT_YUYV8_2X8:
+		case MEDIA_BUS_FMT_YUYV8_1X16:
+			return CSI_INPUT_SEQ_YUYV;
+		case MEDIA_BUS_FMT_YVYU8_1X16:
+		case MEDIA_BUS_FMT_YVYU8_2X8:
+			return CSI_INPUT_SEQ_YVYU;
+		default:
+			dev_warn(csi_dev->dev, "Unsupported mbus code: 0x%x\n",
+				 mbus_code);
+			break;
+		}
+		break;
+	case V4L2_PIX_FMT_NV21:
+	case V4L2_PIX_FMT_NV61:
+	case V4L2_PIX_FMT_YVU420:
+		switch (mbus_code) {
+		case MEDIA_BUS_FMT_UYVY8_2X8:
+		case MEDIA_BUS_FMT_UYVY8_1X16:
+			return CSI_INPUT_SEQ_VYUY;
+		case MEDIA_BUS_FMT_VYUY8_2X8:
+		case MEDIA_BUS_FMT_VYUY8_1X16:
+			return CSI_INPUT_SEQ_UYVY;
+		case MEDIA_BUS_FMT_YUYV8_2X8:
+		case MEDIA_BUS_FMT_YUYV8_1X16:
+			return CSI_INPUT_SEQ_YVYU;
+		case MEDIA_BUS_FMT_YVYU8_1X16:
+		case MEDIA_BUS_FMT_YVYU8_2X8:
+			return CSI_INPUT_SEQ_YUYV;
+		default:
+			dev_warn(csi_dev->dev, "Unsupported mbus code: 0x%x\n",
+				 mbus_code);
+			break;
+		}
+		break;
+
+	case V4L2_PIX_FMT_YUYV:
+		return CSI_INPUT_SEQ_YUYV;
+
+	default:
+		dev_warn(csi_dev->dev, "Unsupported pixformat: 0x%x, defaulting to YUYV\n",
+			 pixformat);
+		break;
+	}
+
+	return CSI_INPUT_SEQ_YUYV;
+}
+
+static void
+sun6i_csi_capture_configure_interface(struct sun6i_csi_device *csi_dev)
+{
+	struct v4l2_fwnode_endpoint *endpoint =
+		&csi_dev->bridge.source_parallel.endpoint;
+	u32 pixelformat, field;
+	unsigned char bus_width;
+	u32 flags;
+	u32 cfg = 0;
+	bool input_interlaced = false;
+
+	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
+
+	if (field == V4L2_FIELD_INTERLACED ||
+	    field == V4L2_FIELD_INTERLACED_TB ||
+	    field == V4L2_FIELD_INTERLACED_BT)
+		input_interlaced = true;
+
+	bus_width = endpoint->bus.parallel.bus_width;
+
+	if (input_interlaced)
+		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED |
+		       SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(1) |
+		       SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC;
+	else
+		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
+
+	switch (endpoint->bus_type) {
+	case V4L2_MBUS_PARALLEL:
+		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
+
+		flags = endpoint->bus.parallel.flags;
+
+		if (bus_width == 16)
+			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW;
+
+		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
+			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
+
+		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
+			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE;
+
+		if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
+			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE;
+
+		if (flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
+			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
+		break;
+	case V4L2_MBUS_BT656:
+		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
+
+		flags = endpoint->bus.parallel.flags;
+
+		if (bus_width == 16)
+			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT1120;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT656;
+
+		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
+			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
+
+		if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
+			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
+		break;
+	default:
+		dev_warn(csi_dev->dev, "Unsupported bus type: %d\n",
+			 endpoint->bus_type);
+		break;
+	}
+
+	switch (bus_width) {
+	case 8:
+		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_8;
+		break;
+	case 10:
+		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_10;
+		break;
+	case 12:
+		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_12;
+		break;
+	case 16: /* No need to configure DATA_WIDTH for 16bit */
+		break;
+	default:
+		dev_warn(csi_dev->dev, "Unsupported bus width: %u\n", bus_width);
+		break;
+	}
+
+	regmap_write(csi_dev->regmap, SUN6I_CSI_IF_CFG_REG, cfg);
+}
+
+static void sun6i_csi_capture_configure_format(struct sun6i_csi_device *csi_dev)
 {
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	struct sun6i_csi_config config = { 0 };
+	u32 pixelformat, field;
+	u32 cfg = 0;
+	u32 val;
+
+	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
+
+	val = get_csi_input_format(csi_dev, capture->mbus_code, pixelformat);
+	cfg |= SUN6I_CSI_CH_CFG_INPUT_FMT(val);
+
+	val = get_csi_output_format(csi_dev, pixelformat, field);
+	cfg |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(val);
 
-	config.pixelformat = capture->format.fmt.pix.pixelformat;
-	config.code = capture->mbus_code;
-	config.field = capture->format.fmt.pix.field;
-	config.width = capture->format.fmt.pix.width;
-	config.height = capture->format.fmt.pix.height;
+	val = get_csi_input_seq(csi_dev, capture->mbus_code, pixelformat);
+	cfg |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(val);
 
-	sun6i_csi_update_config(csi_dev, &config);
+	if (field == V4L2_FIELD_TOP)
+		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0;
+	else if (field == V4L2_FIELD_BOTTOM)
+		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1;
+	else
+		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER;
+
+	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_CFG_REG, cfg);
+}
+
+static void sun6i_csi_capture_configure_window(struct sun6i_csi_device *csi_dev)
+{
+	u32 pixelformat, field;
+	u32 width, height;
+	u32 bytesperline_y;
+	u32 bytesperline_c;
+	u32 hor_len;
+
+	sun6i_csi_capture_dimensions(csi_dev, &width, &height);
+	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
+
+	hor_len = width;
+
+	switch (pixelformat) {
+	case V4L2_PIX_FMT_YUYV:
+	case V4L2_PIX_FMT_YVYU:
+	case V4L2_PIX_FMT_UYVY:
+	case V4L2_PIX_FMT_VYUY:
+		dev_dbg(csi_dev->dev,
+			"Horizontal length should be 2 times of width for packed YUV formats!\n");
+		hor_len = width * 2;
+		break;
+	default:
+		break;
+	}
+
+	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_HSIZE_REG,
+		     SUN6I_CSI_CH_HSIZE_LEN(hor_len) |
+		     SUN6I_CSI_CH_HSIZE_START(0));
+	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_VSIZE_REG,
+		     SUN6I_CSI_CH_VSIZE_LEN(height) |
+		     SUN6I_CSI_CH_VSIZE_START(0));
+
+	switch (pixelformat) {
+	case V4L2_PIX_FMT_NV12_16L16:
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+	case V4L2_PIX_FMT_NV16:
+	case V4L2_PIX_FMT_NV61:
+		bytesperline_y = width;
+		bytesperline_c = width;
+		break;
+	case V4L2_PIX_FMT_YUV420:
+	case V4L2_PIX_FMT_YVU420:
+		bytesperline_y = width;
+		bytesperline_c = width / 2;
+		break;
+	case V4L2_PIX_FMT_YUV422P:
+		bytesperline_y = width;
+		bytesperline_c = width / 2;
+		break;
+	default: /* raw */
+		dev_dbg(csi_dev->dev,
+			"Calculating pixelformat(0x%x)'s bytesperline as a packed format\n",
+			pixelformat);
+		bytesperline_y = (sun6i_csi_get_bpp(pixelformat) *
+				  width) / 8;
+		bytesperline_c = 0;
+		break;
+	}
+
+	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_BUF_LEN_REG,
+		     SUN6I_CSI_CH_BUF_LEN_CHROMA_LINE(bytesperline_c) |
+		     SUN6I_CSI_CH_BUF_LEN_LUMA_LINE(bytesperline_y));
+}
+
+static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)
+{
+	sun6i_csi_capture_configure_interface(csi_dev);
+	sun6i_csi_capture_configure_format(csi_dev);
+	sun6i_csi_capture_configure_window(csi_dev);
 }
 
 /* State */
-- 
2.37.1

