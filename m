Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99D4AABCB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381511AbiBES6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:58:08 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:44285 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381235AbiBES4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:06 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7377124001E;
        Sat,  5 Feb 2022 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wG1fmlP34XAPrPThD4i3zE7mCsQrCv28oX5bebOEtSw=;
        b=Q0e8P5GYgMPOfRmuuPapXyhQh6gmbFLe5q1IZrHXofbk0lUuDfAg0OG0+Wp5RNRmMng0Ot
        a2/sJcEAHB/+ezl1KRSaUQEwzcrYV5oiGAYCXwowOttY4ORcj7xUYRDlXxbHcUObRc1cVd
        I++G4XBaD2Iu3uGiUhdzxP354Zx83Cx9xRxIHCn5gQdfQ+R68uKmdCulck4ArfGtX0S+Il
        mHN/9gceoGAE+DbypZ4noYljsRp1lAf/dhkYX9WBcDjIn6cK9V5FxCojRbJcO0aJ1W6uUB
        uUZhSLNMeAPExU2jPU1LsSTHYQXRaxcnBKMdpytQCWJHcKKWE4Ux9vjhigJwSQ==
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
Subject: [PATCH v2 50/66] media: sun6i-csi: Move hardware control to the bridge
Date:   Sat,  5 Feb 2022 19:54:13 +0100
Message-Id: <20220205185429.2278860-51-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support the isp workflow, we need to be able to configure
the hardware from the bridge when the capture device is not used.

As a result, move all hardware configuration calls from capture to
the bridge. Only the window configuration part (which is specific
to using capture) remains there.

This effectively opens the way for hooking the bridge to the
isp in the future.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 229 ++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 249 +-----------------
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   3 +
 3 files changed, 239 insertions(+), 242 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index bb6260f28c45..f5303842d169 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -174,11 +174,211 @@ sun6i_csi_bridge_format_find(u32 mbus_code)
 	return NULL;
 }
 
+/* Bridge */
+
+static void sun6i_csi_bridge_irq_enable(struct sun6i_csi_device *csi_dev)
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
+static void sun6i_csi_bridge_irq_disable(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+
+	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG, 0);
+}
+
+static void sun6i_csi_bridge_irq_clear(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+
+	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG, 0);
+	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG,
+		     SUN6I_CSI_CH_INT_STA_CLEAR);
+}
+
+static void sun6i_csi_bridge_enable(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+
+	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN,
+			   SUN6I_CSI_EN_CSI_EN);
+
+	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON,
+			   SUN6I_CSI_CAP_VCAP_ON);
+}
+
+static void sun6i_csi_bridge_disable(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+
+	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON, 0);
+	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN, 0);
+}
+
+static void
+sun6i_csi_bridge_configure_interface(struct sun6i_csi_device *csi_dev)
+{
+	struct device *dev = csi_dev->dev;
+	struct regmap *regmap = csi_dev->regmap;
+	struct v4l2_fwnode_endpoint *endpoint =
+		&csi_dev->bridge.source->endpoint;
+	unsigned char bus_width = endpoint->bus.parallel.bus_width;
+	unsigned int flags = endpoint->bus.parallel.flags;
+	u32 field;
+	u32 value = SUN6I_CSI_IF_CFG_IF_CSI;
+
+	sun6i_csi_bridge_format(csi_dev, NULL, &field);
+
+	if (field == V4L2_FIELD_INTERLACED ||
+	    field == V4L2_FIELD_INTERLACED_TB ||
+	    field == V4L2_FIELD_INTERLACED_BT)
+		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED |
+			 SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(1) |
+			 SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC;
+	else
+		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
+
+	switch (endpoint->bus_type) {
+	case V4L2_MBUS_PARALLEL:
+		if (bus_width == 16)
+			value |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED;
+		else
+			value |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW;
+
+		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
+			value |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
+		else
+			value |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
+
+		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
+			value |= SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE;
+		else
+			value |= SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE;
+
+		if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
+			value |= SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE;
+		else
+			value |= SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE;
+
+		if (flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
+			value |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
+		else
+			value |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
+		break;
+	case V4L2_MBUS_BT656:
+		if (bus_width == 16)
+			value |= SUN6I_CSI_IF_CFG_IF_CSI_BT1120;
+		else
+			value |= SUN6I_CSI_IF_CFG_IF_CSI_BT656;
+
+		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
+			value |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
+		else
+			value |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
+
+		if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
+			value |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
+		else
+			value |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
+		break;
+	default:
+		dev_warn(dev, "unsupported bus type: %d\n", endpoint->bus_type);
+		break;
+	}
+
+	switch (bus_width) {
+	case 8:
+	/* 16-bit YUV formats use a doubled width in 8-bit mode. */
+	case 16:
+		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_8;
+		break;
+	case 10:
+		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_10;
+		break;
+	case 12:
+		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_12;
+		break;
+	default:
+		dev_warn(dev, "unsupported bus width: %u\n", bus_width);
+		break;
+	}
+
+	regmap_write(regmap, SUN6I_CSI_IF_CFG_REG, value);
+}
+
+static void sun6i_csi_bridge_configure_format(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+	const struct sun6i_csi_bridge_format *bridge_format;
+	const struct sun6i_csi_capture_format *capture_format;
+	u32 mbus_code, field, pixelformat;
+	u8 input_format, input_yuv_seq, output_format;
+	u32 value = 0;
+
+	sun6i_csi_bridge_format(csi_dev, &mbus_code, &field);
+
+	bridge_format = sun6i_csi_bridge_format_find(mbus_code);
+	if (WARN_ON(!bridge_format))
+		return;
+
+	input_format = bridge_format->input_format;
+	input_yuv_seq = bridge_format->input_yuv_seq;
+
+	sun6i_csi_capture_format(csi_dev, &pixelformat, NULL);
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
+
+	value |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(output_format);
+	value |= SUN6I_CSI_CH_CFG_INPUT_FMT(input_format);
+	value |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(input_yuv_seq);
+
+	if (field == V4L2_FIELD_TOP)
+		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0;
+	else if (field == V4L2_FIELD_BOTTOM)
+		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1;
+	else
+		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER;
+
+	regmap_write(regmap, SUN6I_CSI_CH_CFG_REG, value);
+}
+
+static void sun6i_csi_bridge_configure(struct sun6i_csi_device *csi_dev)
+{
+	sun6i_csi_bridge_configure_interface(csi_dev);
+	sun6i_csi_bridge_configure_format(csi_dev);
+}
+
 /* V4L2 Subdev */
 
 static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 {
 	struct sun6i_csi_device *csi_dev = v4l2_get_subdevdata(subdev);
+	struct device *dev = csi_dev->dev;
 	struct v4l2_subdev *source_subdev;
 	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
 	int ret = 0;
@@ -195,6 +395,30 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 		goto disable;
 	}
 
+	/* PM */
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	/* Clear */
+
+	sun6i_csi_bridge_irq_clear(csi_dev);
+
+	/* Configure */
+
+	sun6i_csi_bridge_configure(csi_dev);
+	sun6i_csi_capture_configure(csi_dev);
+
+	/* State Update */
+
+	sun6i_csi_capture_state_update(csi_dev);
+
+	/* Enable */
+
+	sun6i_csi_bridge_irq_enable(csi_dev);
+	sun6i_csi_bridge_enable(csi_dev);
+
 	ret = v4l2_subdev_call(source_subdev, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD)
 		goto disable;
@@ -202,8 +426,13 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 	return 0;
 
 disable:
+	sun6i_csi_bridge_irq_disable(csi_dev);
+	sun6i_csi_bridge_disable(csi_dev);
+
 	csi_dev->bridge.source = NULL;
 
+	pm_runtime_put(dev);
+
 	return ret;
 }
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 2f9bf75e4e39..4315e197d53f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/of.h>
-#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <media/v4l2-device.h>
@@ -330,55 +329,6 @@ static bool sun6i_csi_capture_format_match(u32 pixelformat, u32 mbus_code)
 
 /* Capture */
 
-static void sun6i_csi_capture_irq_enable(struct sun6i_csi_device *csi_dev)
-{
-	struct regmap *regmap = csi_dev->regmap;
-
-	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG,
-		     SUN6I_CSI_CH_INT_EN_VS |
-		     SUN6I_CSI_CH_INT_EN_HB_OF |
-		     SUN6I_CSI_CH_INT_EN_FIFO2_OF |
-		     SUN6I_CSI_CH_INT_EN_FIFO1_OF |
-		     SUN6I_CSI_CH_INT_EN_FIFO0_OF |
-		     SUN6I_CSI_CH_INT_EN_FD |
-		     SUN6I_CSI_CH_INT_EN_CD);
-}
-
-static void sun6i_csi_capture_irq_disable(struct sun6i_csi_device *csi_dev)
-{
-	struct regmap *regmap = csi_dev->regmap;
-
-	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG, 0);
-}
-
-static void sun6i_csi_capture_irq_clear(struct sun6i_csi_device *csi_dev)
-{
-	struct regmap *regmap = csi_dev->regmap;
-
-	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG, 0);
-	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG,
-		     SUN6I_CSI_CH_INT_STA_CLEAR);
-}
-
-static void sun6i_csi_capture_enable(struct sun6i_csi_device *csi_dev)
-{
-	struct regmap *regmap = csi_dev->regmap;
-
-	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN,
-			   SUN6I_CSI_EN_CSI_EN);
-
-	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON,
-			   SUN6I_CSI_CAP_VCAP_ON);
-}
-
-static void sun6i_csi_capture_disable(struct sun6i_csi_device *csi_dev)
-{
-	struct regmap *regmap = csi_dev->regmap;
-
-	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON, 0);
-	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN, 0);
-}
-
 static void
 sun6i_csi_capture_buffer_configure(struct sun6i_csi_device *csi_dev,
 				   struct sun6i_csi_buffer *csi_buffer)
@@ -420,148 +370,7 @@ sun6i_csi_capture_buffer_configure(struct sun6i_csi_device *csi_dev,
 	}
 }
 
-static void
-sun6i_csi_capture_configure_interface(struct sun6i_csi_device *csi_dev)
-{
-	struct device *dev = csi_dev->dev;
-	struct regmap *regmap = csi_dev->regmap;
-	struct v4l2_fwnode_endpoint *endpoint =
-		&csi_dev->bridge.source->endpoint;
-	unsigned char bus_width = endpoint->bus.parallel.bus_width;
-	unsigned int flags = endpoint->bus.parallel.flags;
-	u32 pixelformat, field;
-	u32 value = SUN6I_CSI_IF_CFG_IF_CSI;
-
-	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
-
-	if (field == V4L2_FIELD_INTERLACED ||
-	    field == V4L2_FIELD_INTERLACED_TB ||
-	    field == V4L2_FIELD_INTERLACED_BT)
-		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED |
-			 SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(1) |
-			 SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC;
-	else
-		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
-
-	switch (endpoint->bus_type) {
-	case V4L2_MBUS_PARALLEL:
-		if (bus_width == 16)
-			value |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED;
-		else
-			value |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW;
-
-		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
-			value |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
-		else
-			value |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
-
-		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
-			value |= SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE;
-		else
-			value |= SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE;
-
-		if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
-			value |= SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE;
-		else
-			value |= SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE;
-
-		if (flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
-			value |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
-		else
-			value |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
-		break;
-	case V4L2_MBUS_BT656:
-		if (bus_width == 16)
-			value |= SUN6I_CSI_IF_CFG_IF_CSI_BT1120;
-		else
-			value |= SUN6I_CSI_IF_CFG_IF_CSI_BT656;
-
-		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
-			value |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
-		else
-			value |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
-
-		if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
-			value |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
-		else
-			value |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
-		break;
-	default:
-		dev_warn(dev, "unsupported bus type: %d\n", endpoint->bus_type);
-		break;
-	}
-
-	switch (bus_width) {
-	case 8:
-	/* 16-bit YUV formats use a doubled width in 8-bit mode. */
-	case 16:
-		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_8;
-		break;
-	case 10:
-		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_10;
-		break;
-	case 12:
-		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_12;
-		break;
-	default:
-		dev_warn(dev, "unsupported bus width: %u\n", bus_width);
-		break;
-	}
-
-	regmap_write(regmap, SUN6I_CSI_IF_CFG_REG, value);
-}
-
-static void sun6i_csi_capture_configure_format(struct sun6i_csi_device *csi_dev)
-{
-	struct regmap *regmap = csi_dev->regmap;
-	const struct sun6i_csi_bridge_format *bridge_format;
-	const struct sun6i_csi_capture_format *capture_format;
-	u32 mbus_code, pixelformat, field;
-	u8 input_format, input_yuv_seq, output_format;
-	u32 value = 0;
-
-	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
-	sun6i_csi_bridge_format(csi_dev, &mbus_code, NULL);
-
-	bridge_format = sun6i_csi_bridge_format_find(mbus_code);
-	if (WARN_ON(!bridge_format))
-		return;
-
-	input_format = bridge_format->input_format;
-	input_yuv_seq = bridge_format->input_yuv_seq;
-
-	capture_format = sun6i_csi_capture_format_find(pixelformat);
-	if (WARN_ON(!capture_format))
-		return;
-
-	if (capture_format->input_format_raw)
-		input_format = SUN6I_CSI_INPUT_FMT_RAW;
-
-	if (capture_format->input_yuv_seq_invert)
-		input_yuv_seq = bridge_format->input_yuv_seq_invert;
-
-	if (field == V4L2_FIELD_INTERLACED ||
-	    field == V4L2_FIELD_INTERLACED_TB ||
-	    field == V4L2_FIELD_INTERLACED_BT)
-		output_format = capture_format->output_format_field;
-	else
-		output_format = capture_format->output_format_frame;
-
-	value |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(output_format);
-	value |= SUN6I_CSI_CH_CFG_INPUT_FMT(input_format);
-	value |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(input_yuv_seq);
-
-	if (field == V4L2_FIELD_TOP)
-		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0;
-	else if (field == V4L2_FIELD_BOTTOM)
-		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1;
-	else
-		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER;
-
-	regmap_write(regmap, SUN6I_CSI_CH_CFG_REG, value);
-}
-
-static void sun6i_csi_capture_configure_window(struct sun6i_csi_device *csi_dev)
+void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)
 {
 	struct regmap *regmap = csi_dev->regmap;
 	const struct sun6i_csi_capture_format *format;
@@ -624,13 +433,6 @@ static void sun6i_csi_capture_configure_window(struct sun6i_csi_device *csi_dev)
 		     SUN6I_CSI_CH_BUF_LEN_LUMA_LINE(luma_line));
 }
 
-static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)
-{
-	sun6i_csi_capture_configure_interface(csi_dev);
-	sun6i_csi_capture_configure_format(csi_dev);
-	sun6i_csi_capture_configure_window(csi_dev);
-}
-
 /* State */
 
 static void sun6i_csi_capture_state_cleanup(struct sun6i_csi_device *csi_dev,
@@ -670,7 +472,7 @@ static void sun6i_csi_capture_state_cleanup(struct sun6i_csi_device *csi_dev,
 	spin_unlock_irqrestore(&state->lock, flags);
 }
 
-static void sun6i_csi_capture_state_update(struct sun6i_csi_device *csi_dev)
+void sun6i_csi_capture_state_update(struct sun6i_csi_device *csi_dev)
 {
 	struct sun6i_csi_capture_state *state = &csi_dev->capture.state;
 	struct sun6i_csi_buffer *csi_buffer;
@@ -803,11 +605,9 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 					     unsigned int count)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	struct sun6i_csi_capture_state *state = &capture->state;
-	struct video_device *video_dev = &capture->video_dev;
+	struct sun6i_csi_capture_state *state = &csi_dev->capture.state;
+	struct video_device *video_dev = &csi_dev->capture.video_dev;
 	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
-	struct device *dev = csi_dev->dev;
 	int ret;
 
 	state->sequence = 0;
@@ -816,41 +616,12 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	if (ret < 0)
 		goto error_state;
 
-	/* PM */
-
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
-		goto error_media_pipeline;
-
-	/* Clear */
-
-	sun6i_csi_capture_irq_clear(csi_dev);
-
-	/* Configure */
-
-	sun6i_csi_capture_configure(csi_dev);
-
-	/* State Update */
-
-	sun6i_csi_capture_state_update(csi_dev);
-
-	/* Enable */
-
-	sun6i_csi_capture_irq_enable(csi_dev);
-	sun6i_csi_capture_enable(csi_dev);
-
 	ret = v4l2_subdev_call(subdev, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD)
-		goto error_stream;
+		goto error_media_pipeline;
 
 	return 0;
 
-error_stream:
-	sun6i_csi_capture_disable(csi_dev);
-	sun6i_csi_capture_irq_disable(csi_dev);
-
-	pm_runtime_put(dev);
-
 error_media_pipeline:
 	media_pipeline_stop(&video_dev->entity);
 
@@ -863,18 +634,12 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	struct video_device *video_dev = &csi_dev->capture.video_dev;
 	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
-	struct device *dev = csi_dev->dev;
 
 	v4l2_subdev_call(subdev, video, s_stream, 0);
 
-	sun6i_csi_capture_disable(csi_dev);
-	sun6i_csi_capture_irq_disable(csi_dev);
-
-	pm_runtime_put(dev);
-
-	media_pipeline_stop(&capture->video_dev.entity);
+	media_pipeline_stop(&video_dev->entity);
 
 	sun6i_csi_capture_state_cleanup(csi_dev, true);
 }
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 2605b16f091c..a61db3bc72e5 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -63,6 +63,9 @@ void sun6i_csi_capture_format(struct sun6i_csi_device *csi_dev,
 const
 struct sun6i_csi_capture_format *sun6i_csi_capture_format_find(u32 pixelformat);
 
+void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev);
+void sun6i_csi_capture_state_update(struct sun6i_csi_device *csi_dev);
+
 void sun6i_csi_capture_sync(struct sun6i_csi_device *csi_dev);
 void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev);
 
-- 
2.34.1

