Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C134D63D2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349794AbiCKOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349585AbiCKOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:42 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C2C1C9477;
        Fri, 11 Mar 2022 06:36:34 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5AD9B24001A;
        Fri, 11 Mar 2022 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhIUG9Wb8r7xhMYMWkvu01J+yj35PnUIfRFm0qkzrGk=;
        b=XU8Opjovr7Am4L2agxh/qXtsB+DDuGgE30d8Ah8lz7ApGYQpGzV9+JpyDDutnMZPBwKsj5
        Awt/IR38qZQLi60WMqjCOb3gMaY+DU9WkVSLoixyAsCPvnT93EjySGt2TBgRKXZAGvAZNQ
        u4PFoVjrutggpHwxtzQjdtFW7u9Ia4FLRUgEIN7AG35hUi+0TMGk/ZEUyaRwqz2YvXVJdt
        VXHN+VB0Gz9ZCJCO2edTps5HrRx7H9IaKLxvjrOUg6oMVqlaU4QJRk7cOFHvuE8Cw4aKbC
        bu1ySGYZMJ97CXiMpxzUYzGNPtjmhG9qFWQ+BQ5oE33iPJMGx4liV71d+itkqw==
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
Subject: [PATCH v3 29/46] media: sun6i-csi: Tidy capture configure code
Date:   Fri, 11 Mar 2022 15:35:15 +0100
Message-Id: <20220311143532.265091-30-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
2.35.1

