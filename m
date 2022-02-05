Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0134AABC1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381908AbiBES5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:57:49 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:40687 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381450AbiBESzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:55 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C5EF9240012;
        Sat,  5 Feb 2022 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EdcRxpJAbZcmTkOGjKP8A1FFYnpAyrcNRPpVMCBYHH4=;
        b=Pfs4BdiTqhmSUfJ4ToAOTxipkafxWmQUTN20G6HERyZqhaL0psEng5qSxJHeqkYwXl2Kno
        hUmhfNAqxSTM9Mwvpy7AhawqRt4NzsNqtPJ6kkUabGjxLdRtPVEw4bwrFB6x6gIBT9DYlb
        3tjecIGYmjjqV74R+/WqJluU1enUu9u8MCMEgUpEUyeIS2n6wzYnzCsgnYd74cSKHhx7K9
        NppIabJ61OR935aI6tWp5HY+J4bUwOKS8Pi9xSHfiRTTlXkzsbd2pEk0CDUMaeKIzhlK7A
        4lYebD7RXjdOJZuSeueh29kexkxFyRwAD6dS1Eed16UO1viGxI+iofP7bMST9w==
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
Subject: [PATCH v2 43/66] media: sun6i-csi: Tidy capture configure code
Date:   Sat,  5 Feb 2022 19:54:06 +0100
Message-Id: <20220205185429.2278860-44-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some misc code cleanups and preparation for upcoming changes.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 105 ++++++++----------
 1 file changed, 46 insertions(+), 59 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 12c02408d18e..726416d98c46 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -353,133 +353,120 @@ static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_device *csi_dev,
 static void
 sun6i_csi_capture_configure_interface(struct sun6i_csi_device *csi_dev)
 {
+	struct device *dev = csi_dev->dev;
+	struct regmap *regmap = csi_dev->regmap;
 	struct v4l2_fwnode_endpoint *endpoint =
 		&csi_dev->bridge.source->endpoint;
+	unsigned char bus_width = endpoint->bus.parallel.bus_width;
+	unsigned int flags = endpoint->bus.parallel.flags;
 	u32 pixelformat, field;
-	unsigned char bus_width;
-	u32 flags;
-	u32 cfg = 0;
-	bool input_interlaced = false;
+	u32 value = SUN6I_CSI_IF_CFG_IF_CSI;
 
 	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
 
 	if (field == V4L2_FIELD_INTERLACED ||
 	    field == V4L2_FIELD_INTERLACED_TB ||
 	    field == V4L2_FIELD_INTERLACED_BT)
-		input_interlaced = true;
-
-	bus_width = endpoint->bus.parallel.bus_width;
-
-	if (input_interlaced)
-		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED |
-		       SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(1) |
-		       SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC;
+		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED |
+			 SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(1) |
+			 SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC;
 	else
-		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
+		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
 
 	switch (endpoint->bus_type) {
 	case V4L2_MBUS_PARALLEL:
-		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
-
-		flags = endpoint->bus.parallel.flags;
-
 		if (bus_width == 16)
-			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED;
+			value |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED;
 		else
-			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW;
+			value |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW;
 
 		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
-			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
+			value |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
 		else
-			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
+			value |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
 
 		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
-			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE;
+			value |= SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE;
 		else
-			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE;
+			value |= SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE;
 
 		if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
-			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE;
+			value |= SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE;
 		else
-			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE;
+			value |= SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE;
 
 		if (flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
-			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
+			value |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
 		else
-			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
+			value |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
 		break;
 	case V4L2_MBUS_BT656:
-		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
-
-		flags = endpoint->bus.parallel.flags;
-
 		if (bus_width == 16)
-			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT1120;
+			value |= SUN6I_CSI_IF_CFG_IF_CSI_BT1120;
 		else
-			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT656;
+			value |= SUN6I_CSI_IF_CFG_IF_CSI_BT656;
 
 		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
-			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
+			value |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
 		else
-			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
+			value |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
 
 		if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
-			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
+			value |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
 		else
-			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
+			value |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
 		break;
 	default:
-		dev_warn(csi_dev->dev, "Unsupported bus type: %d\n",
-			 endpoint->bus_type);
+		dev_warn(dev, "unsupported bus type: %d\n", endpoint->bus_type);
 		break;
 	}
 
 	switch (bus_width) {
 	case 8:
-		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_8;
+	/* 16-bit YUV formats use a doubled width in 8-bit mode. */
+	case 16:
+		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_8;
 		break;
 	case 10:
-		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_10;
+		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_10;
 		break;
 	case 12:
-		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_12;
-		break;
-	case 16: /* No need to configure DATA_WIDTH for 16bit */
+		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_12;
 		break;
 	default:
-		dev_warn(csi_dev->dev, "Unsupported bus width: %u\n", bus_width);
+		dev_warn(dev, "unsupported bus width: %u\n", bus_width);
 		break;
 	}
 
-	regmap_write(csi_dev->regmap, SUN6I_CSI_IF_CFG_REG, cfg);
+	regmap_write(regmap, SUN6I_CSI_IF_CFG_REG, value);
 }
 
 static void sun6i_csi_capture_configure_format(struct sun6i_csi_device *csi_dev)
 {
+	struct regmap *regmap = csi_dev->regmap;
 	u32 mbus_code, pixelformat, field;
-	u32 cfg = 0;
-	u32 val;
+	u8 input_format, input_yuv_seq, output_format;
+	u32 value = 0;
 
 	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
 	sun6i_csi_bridge_format(csi_dev, &mbus_code, NULL);
 
-	val = get_csi_input_format(csi_dev, mbus_code, pixelformat);
-	cfg |= SUN6I_CSI_CH_CFG_INPUT_FMT(val);
-
-	val = get_csi_output_format(csi_dev, pixelformat, field);
-	cfg |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(val);
+	input_format = get_csi_input_format(csi_dev, mbus_code, pixelformat);
+	input_yuv_seq = get_csi_input_seq(csi_dev, mbus_code, pixelformat);
+	output_format = get_csi_output_format(csi_dev, pixelformat, field);
 
-	val = get_csi_input_seq(csi_dev, mbus_code, pixelformat);
-	cfg |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(val);
+	value |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(output_format);
+	value |= SUN6I_CSI_CH_CFG_INPUT_FMT(input_format);
+	value |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(input_yuv_seq);
 
 	if (field == V4L2_FIELD_TOP)
-		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0;
+		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0;
 	else if (field == V4L2_FIELD_BOTTOM)
-		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1;
+		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1;
 	else
-		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER;
+		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER;
 
-	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_CFG_REG, cfg);
+	regmap_write(regmap, SUN6I_CSI_CH_CFG_REG, value);
 }
 
 static void sun6i_csi_capture_configure_window(struct sun6i_csi_device *csi_dev)
-- 
2.34.1

