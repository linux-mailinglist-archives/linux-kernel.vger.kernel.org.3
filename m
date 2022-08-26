Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A455A2EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbiHZSe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiHZSdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:47 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B7BE58AD;
        Fri, 26 Aug 2022 11:33:30 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B18E8FF805;
        Fri, 26 Aug 2022 18:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9ljWOVZHVDEfoFJhkZCA4/lsNiLT2tORD7bNvqynbg=;
        b=JJDeTt9prUA2zr6nFHxc+uNeRdoCALUHQSs/mRfTIFbEdsPVcE4kC9QJoUEj+tceY90yxl
        YHLWs4d6bd9Rv2JFTJDhRbORE6xmUaLj+6mNWFqQUnga6ApVskfVJ7HiTVTtXMD2O6uH8v
        zjwkB2LBgc0rmiRGVnH3qY/Is1QmUfFohe9YQb7gukxGCASNv5Jp4XlicyFJFTkOE8VOP4
        ih9iLxY4/uMrrpzAp4YbesLZ5bKVEJCGK0mbnHuNOiIsKCiT2HanLAqs4AE8YsF2hZQwB9
        nxCrlD+L1yjj6DUt0Ch9MKb6uqssH2aLJSuvVcKjoIRZsqYStIYqTkj63KA5KA==
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
Subject: [PATCH v6 19/43] media: sun6i-csi: Rework register definitions, invert misleading fields
Date:   Fri, 26 Aug 2022 20:32:16 +0200
Message-Id: <20220826183240.604834-20-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
References: <20220826183240.604834-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleans up the register definitions a bit, adds a prefix, remove masks.
Registers are now fully defined, some additional fields were added when
needed. New format definitions are added for future use.

Some fields are wrongly defined (inverted) in Allwinner literature
(e.g. field vs frame prefixes), which is quite misleading. They are
now corrected to reflect their actual behavior.

This should only be a cosmetic commit. No functional change intended.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 182 ++++++-----
 .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  | 296 ++++++++++--------
 2 files changed, 266 insertions(+), 212 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index cc277733d7ec..79d4b00d1fcd 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -155,7 +155,8 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 	int ret;
 
 	if (!enable) {
-		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
+		regmap_update_bits(regmap, SUN6I_CSI_EN_REG,
+				   SUN6I_CSI_EN_CSI_EN, 0);
 		pm_runtime_put(dev);
 
 		return 0;
@@ -165,7 +166,8 @@ int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 	if (ret < 0)
 		return ret;
 
-	regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, CSI_EN_CSI_EN);
+	regmap_update_bits(regmap, SUN6I_CSI_EN_REG, SUN6I_CSI_EN_CSI_EN,
+			   SUN6I_CSI_EN_CSI_EN);
 
 	return 0;
 }
@@ -334,7 +336,7 @@ static void sun6i_csi_setup_bus(struct sun6i_csi_device *csi_dev)
 	struct sun6i_csi_config *config = &csi_dev->config;
 	unsigned char bus_width;
 	u32 flags;
-	u32 cfg;
+	u32 cfg = 0;
 	bool input_interlaced = false;
 
 	if (config->field == V4L2_FIELD_INTERLACED
@@ -344,52 +346,63 @@ static void sun6i_csi_setup_bus(struct sun6i_csi_device *csi_dev)
 
 	bus_width = endpoint->bus.parallel.bus_width;
 
-	regmap_read(csi_dev->regmap, CSI_IF_CFG_REG, &cfg);
-
-	cfg &= ~(CSI_IF_CFG_CSI_IF_MASK | CSI_IF_CFG_MIPI_IF_MASK |
-		 CSI_IF_CFG_IF_DATA_WIDTH_MASK |
-		 CSI_IF_CFG_CLK_POL_MASK | CSI_IF_CFG_VREF_POL_MASK |
-		 CSI_IF_CFG_HREF_POL_MASK | CSI_IF_CFG_FIELD_MASK |
-		 CSI_IF_CFG_SRC_TYPE_MASK);
-
 	if (input_interlaced)
-		cfg |= CSI_IF_CFG_SRC_TYPE_INTERLACED;
+		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED |
+		       SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(1) |
+		       SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC;
 	else
-		cfg |= CSI_IF_CFG_SRC_TYPE_PROGRESSED;
+		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
 
 	switch (endpoint->bus_type) {
 	case V4L2_MBUS_PARALLEL:
-		cfg |= CSI_IF_CFG_MIPI_IF_CSI;
+		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
 
 		flags = endpoint->bus.parallel.flags;
 
-		cfg |= (bus_width == 16) ? CSI_IF_CFG_CSI_IF_YUV422_16BIT :
-					   CSI_IF_CFG_CSI_IF_YUV422_INTLV;
+		if (bus_width == 16)
+			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW;
 
 		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
-			cfg |= CSI_IF_CFG_FIELD_POSITIVE;
+			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
 
 		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
-			cfg |= CSI_IF_CFG_VREF_POL_POSITIVE;
+			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE;
+
 		if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
-			cfg |= CSI_IF_CFG_HREF_POL_POSITIVE;
+			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE;
 
 		if (flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
-			cfg |= CSI_IF_CFG_CLK_POL_FALLING_EDGE;
+			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
 		break;
 	case V4L2_MBUS_BT656:
-		cfg |= CSI_IF_CFG_MIPI_IF_CSI;
+		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
 
 		flags = endpoint->bus.parallel.flags;
 
-		cfg |= (bus_width == 16) ? CSI_IF_CFG_CSI_IF_BT1120 :
-					   CSI_IF_CFG_CSI_IF_BT656;
+		if (bus_width == 16)
+			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT1120;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT656;
 
 		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
-			cfg |= CSI_IF_CFG_FIELD_POSITIVE;
+			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
 
 		if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
-			cfg |= CSI_IF_CFG_CLK_POL_FALLING_EDGE;
+			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
+		else
+			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
 		break;
 	default:
 		dev_warn(csi_dev->dev, "Unsupported bus type: %d\n",
@@ -399,13 +412,13 @@ static void sun6i_csi_setup_bus(struct sun6i_csi_device *csi_dev)
 
 	switch (bus_width) {
 	case 8:
-		cfg |= CSI_IF_CFG_IF_DATA_WIDTH_8BIT;
+		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_8;
 		break;
 	case 10:
-		cfg |= CSI_IF_CFG_IF_DATA_WIDTH_10BIT;
+		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_10;
 		break;
 	case 12:
-		cfg |= CSI_IF_CFG_IF_DATA_WIDTH_12BIT;
+		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_12;
 		break;
 	case 16: /* No need to configure DATA_WIDTH for 16bit */
 		break;
@@ -414,42 +427,35 @@ static void sun6i_csi_setup_bus(struct sun6i_csi_device *csi_dev)
 		break;
 	}
 
-	regmap_write(csi_dev->regmap, CSI_IF_CFG_REG, cfg);
+	regmap_write(csi_dev->regmap, SUN6I_CSI_IF_CFG_REG, cfg);
 }
 
 static void sun6i_csi_set_format(struct sun6i_csi_device *csi_dev)
 {
 	struct sun6i_csi_config *config = &csi_dev->config;
-	u32 cfg;
+	u32 cfg = 0;
 	u32 val;
 
-	regmap_read(csi_dev->regmap, CSI_CH_CFG_REG, &cfg);
-
-	cfg &= ~(CSI_CH_CFG_INPUT_FMT_MASK |
-		 CSI_CH_CFG_OUTPUT_FMT_MASK | CSI_CH_CFG_VFLIP_EN |
-		 CSI_CH_CFG_HFLIP_EN | CSI_CH_CFG_FIELD_SEL_MASK |
-		 CSI_CH_CFG_INPUT_SEQ_MASK);
-
 	val = get_csi_input_format(csi_dev, config->code,
 				   config->pixelformat);
-	cfg |= CSI_CH_CFG_INPUT_FMT(val);
+	cfg |= SUN6I_CSI_CH_CFG_INPUT_FMT(val);
 
 	val = get_csi_output_format(csi_dev, config->pixelformat,
 				    config->field);
-	cfg |= CSI_CH_CFG_OUTPUT_FMT(val);
+	cfg |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(val);
 
 	val = get_csi_input_seq(csi_dev, config->code,
 				config->pixelformat);
-	cfg |= CSI_CH_CFG_INPUT_SEQ(val);
+	cfg |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(val);
 
 	if (config->field == V4L2_FIELD_TOP)
-		cfg |= CSI_CH_CFG_FIELD_SEL_FIELD0;
+		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0;
 	else if (config->field == V4L2_FIELD_BOTTOM)
-		cfg |= CSI_CH_CFG_FIELD_SEL_FIELD1;
+		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1;
 	else
-		cfg |= CSI_CH_CFG_FIELD_SEL_BOTH;
+		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER;
 
-	regmap_write(csi_dev->regmap, CSI_CH_CFG_REG, cfg);
+	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_CFG_REG, cfg);
 }
 
 static void sun6i_csi_set_window(struct sun6i_csi_device *csi_dev)
@@ -475,12 +481,12 @@ static void sun6i_csi_set_window(struct sun6i_csi_device *csi_dev)
 		break;
 	}
 
-	regmap_write(csi_dev->regmap, CSI_CH_HSIZE_REG,
-		     CSI_CH_HSIZE_HOR_LEN(hor_len) |
-		     CSI_CH_HSIZE_HOR_START(0));
-	regmap_write(csi_dev->regmap, CSI_CH_VSIZE_REG,
-		     CSI_CH_VSIZE_VER_LEN(height) |
-		     CSI_CH_VSIZE_VER_START(0));
+	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_HSIZE_REG,
+		     SUN6I_CSI_CH_HSIZE_LEN(hor_len) |
+		     SUN6I_CSI_CH_HSIZE_START(0));
+	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_VSIZE_REG,
+		     SUN6I_CSI_CH_VSIZE_LEN(height) |
+		     SUN6I_CSI_CH_VSIZE_START(0));
 
 	planar_offset[0] = 0;
 	switch (config->pixelformat) {
@@ -521,9 +527,9 @@ static void sun6i_csi_set_window(struct sun6i_csi_device *csi_dev)
 		break;
 	}
 
-	regmap_write(csi_dev->regmap, CSI_CH_BUF_LEN_REG,
-		     CSI_CH_BUF_LEN_BUF_LEN_C(bytesperline_c) |
-		     CSI_CH_BUF_LEN_BUF_LEN_Y(bytesperline_y));
+	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_BUF_LEN_REG,
+		     SUN6I_CSI_CH_BUF_LEN_CHROMA_LINE(bytesperline_c) |
+		     SUN6I_CSI_CH_BUF_LEN_LUMA_LINE(bytesperline_y));
 }
 
 int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
@@ -544,14 +550,16 @@ int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
 void sun6i_csi_update_buf_addr(struct sun6i_csi_device *csi_dev,
 			       dma_addr_t addr)
 {
-	regmap_write(csi_dev->regmap, CSI_CH_F0_BUFA_REG,
-		     (addr + csi_dev->planar_offset[0]) >> 2);
+	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_FIFO0_ADDR_REG,
+		     SUN6I_CSI_ADDR_VALUE(addr + csi_dev->planar_offset[0]));
 	if (csi_dev->planar_offset[1] != -1)
-		regmap_write(csi_dev->regmap, CSI_CH_F1_BUFA_REG,
-			     (addr + csi_dev->planar_offset[1]) >> 2);
+		regmap_write(csi_dev->regmap, SUN6I_CSI_CH_FIFO1_ADDR_REG,
+			     SUN6I_CSI_ADDR_VALUE(addr +
+						  csi_dev->planar_offset[1]));
 	if (csi_dev->planar_offset[2] != -1)
-		regmap_write(csi_dev->regmap, CSI_CH_F2_BUFA_REG,
-			     (addr + csi_dev->planar_offset[2]) >> 2);
+		regmap_write(csi_dev->regmap, SUN6I_CSI_CH_FIFO2_ADDR_REG,
+			     SUN6I_CSI_ADDR_VALUE(addr +
+						  csi_dev->planar_offset[2]));
 }
 
 void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
@@ -559,23 +567,25 @@ void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
 	struct regmap *regmap = csi_dev->regmap;
 
 	if (!enable) {
-		regmap_update_bits(regmap, CSI_CAP_REG, CSI_CAP_CH0_VCAP_ON, 0);
-		regmap_write(regmap, CSI_CH_INT_EN_REG, 0);
+		regmap_update_bits(regmap, SUN6I_CSI_CAP_REG,
+				   SUN6I_CSI_CAP_VCAP_ON, 0);
+		regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG, 0);
 		return;
 	}
 
-	regmap_write(regmap, CSI_CH_INT_STA_REG, 0xFF);
-	regmap_write(regmap, CSI_CH_INT_EN_REG,
-		     CSI_CH_INT_EN_VS_INT_EN |
-		     CSI_CH_INT_EN_HB_OF_INT_EN |
-		     CSI_CH_INT_EN_FIFO2_OF_INT_EN |
-		     CSI_CH_INT_EN_FIFO1_OF_INT_EN |
-		     CSI_CH_INT_EN_FIFO0_OF_INT_EN |
-		     CSI_CH_INT_EN_FD_INT_EN |
-		     CSI_CH_INT_EN_CD_INT_EN);
-
-	regmap_update_bits(regmap, CSI_CAP_REG, CSI_CAP_CH0_VCAP_ON,
-			   CSI_CAP_CH0_VCAP_ON);
+	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG,
+		     SUN6I_CSI_CH_INT_STA_CLEAR);
+	regmap_write(regmap, SUN6I_CSI_CH_INT_EN_REG,
+		     SUN6I_CSI_CH_INT_EN_VS |
+		     SUN6I_CSI_CH_INT_EN_HB_OF |
+		     SUN6I_CSI_CH_INT_EN_FIFO2_OF |
+		     SUN6I_CSI_CH_INT_EN_FIFO1_OF |
+		     SUN6I_CSI_CH_INT_EN_FIFO0_OF |
+		     SUN6I_CSI_CH_INT_EN_FD |
+		     SUN6I_CSI_CH_INT_EN_CD);
+
+	regmap_update_bits(regmap, SUN6I_CSI_CAP_REG, SUN6I_CSI_CAP_VCAP_ON,
+			   SUN6I_CSI_CAP_VCAP_ON);
 }
 
 /* Media */
@@ -646,29 +656,31 @@ static irqreturn_t sun6i_csi_interrupt(int irq, void *private)
 	struct regmap *regmap = csi_dev->regmap;
 	u32 status;
 
-	regmap_read(regmap, CSI_CH_INT_STA_REG, &status);
+	regmap_read(regmap, SUN6I_CSI_CH_INT_STA_REG, &status);
 
 	if (!(status & 0xFF))
 		return IRQ_NONE;
 
-	if ((status & CSI_CH_INT_STA_FIFO0_OF_PD) ||
-	    (status & CSI_CH_INT_STA_FIFO1_OF_PD) ||
-	    (status & CSI_CH_INT_STA_FIFO2_OF_PD) ||
-	    (status & CSI_CH_INT_STA_HB_OF_PD)) {
-		regmap_write(regmap, CSI_CH_INT_STA_REG, status);
-		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
-		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN,
-				   CSI_EN_CSI_EN);
+	if ((status & SUN6I_CSI_CH_INT_STA_FIFO0_OF) ||
+	    (status & SUN6I_CSI_CH_INT_STA_FIFO1_OF) ||
+	    (status & SUN6I_CSI_CH_INT_STA_FIFO2_OF) ||
+	    (status & SUN6I_CSI_CH_INT_STA_HB_OF)) {
+		regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG, status);
+
+		regmap_update_bits(regmap, SUN6I_CSI_EN_REG,
+				   SUN6I_CSI_EN_CSI_EN, 0);
+		regmap_update_bits(regmap, SUN6I_CSI_EN_REG,
+				   SUN6I_CSI_EN_CSI_EN, SUN6I_CSI_EN_CSI_EN);
 		return IRQ_HANDLED;
 	}
 
-	if (status & CSI_CH_INT_STA_FD_PD)
+	if (status & SUN6I_CSI_CH_INT_STA_FD)
 		sun6i_csi_capture_frame_done(csi_dev);
 
-	if (status & CSI_CH_INT_STA_VS_PD)
+	if (status & SUN6I_CSI_CH_INT_STA_VS)
 		sun6i_csi_capture_sync(csi_dev);
 
-	regmap_write(regmap, CSI_CH_INT_STA_REG, status);
+	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG, status);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
index 703fa14bb313..9b0326d6ba3c 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
@@ -10,133 +10,175 @@
 
 #include <linux/kernel.h>
 
-#define CSI_EN_REG			0x0
-#define CSI_EN_VER_EN				BIT(30)
-#define CSI_EN_CSI_EN				BIT(0)
-
-#define CSI_IF_CFG_REG			0x4
-#define CSI_IF_CFG_SRC_TYPE_MASK		BIT(21)
-#define CSI_IF_CFG_SRC_TYPE_PROGRESSED		((0 << 21) & CSI_IF_CFG_SRC_TYPE_MASK)
-#define CSI_IF_CFG_SRC_TYPE_INTERLACED		((1 << 21) & CSI_IF_CFG_SRC_TYPE_MASK)
-#define CSI_IF_CFG_FPS_DS_EN			BIT(20)
-#define CSI_IF_CFG_FIELD_MASK			BIT(19)
-#define CSI_IF_CFG_FIELD_NEGATIVE		((0 << 19) & CSI_IF_CFG_FIELD_MASK)
-#define CSI_IF_CFG_FIELD_POSITIVE		((1 << 19) & CSI_IF_CFG_FIELD_MASK)
-#define CSI_IF_CFG_VREF_POL_MASK		BIT(18)
-#define CSI_IF_CFG_VREF_POL_NEGATIVE		((0 << 18) & CSI_IF_CFG_VREF_POL_MASK)
-#define CSI_IF_CFG_VREF_POL_POSITIVE		((1 << 18) & CSI_IF_CFG_VREF_POL_MASK)
-#define CSI_IF_CFG_HREF_POL_MASK		BIT(17)
-#define CSI_IF_CFG_HREF_POL_NEGATIVE		((0 << 17) & CSI_IF_CFG_HREF_POL_MASK)
-#define CSI_IF_CFG_HREF_POL_POSITIVE		((1 << 17) & CSI_IF_CFG_HREF_POL_MASK)
-#define CSI_IF_CFG_CLK_POL_MASK			BIT(16)
-#define CSI_IF_CFG_CLK_POL_RISING_EDGE		((0 << 16) & CSI_IF_CFG_CLK_POL_MASK)
-#define CSI_IF_CFG_CLK_POL_FALLING_EDGE		((1 << 16) & CSI_IF_CFG_CLK_POL_MASK)
-#define CSI_IF_CFG_IF_DATA_WIDTH_MASK		GENMASK(10, 8)
-#define CSI_IF_CFG_IF_DATA_WIDTH_8BIT		((0 << 8) & CSI_IF_CFG_IF_DATA_WIDTH_MASK)
-#define CSI_IF_CFG_IF_DATA_WIDTH_10BIT		((1 << 8) & CSI_IF_CFG_IF_DATA_WIDTH_MASK)
-#define CSI_IF_CFG_IF_DATA_WIDTH_12BIT		((2 << 8) & CSI_IF_CFG_IF_DATA_WIDTH_MASK)
-#define CSI_IF_CFG_MIPI_IF_MASK			BIT(7)
-#define CSI_IF_CFG_MIPI_IF_CSI			(0 << 7)
-#define CSI_IF_CFG_MIPI_IF_MIPI			BIT(7)
-#define CSI_IF_CFG_CSI_IF_MASK			GENMASK(4, 0)
-#define CSI_IF_CFG_CSI_IF_YUV422_INTLV		((0 << 0) & CSI_IF_CFG_CSI_IF_MASK)
-#define CSI_IF_CFG_CSI_IF_YUV422_16BIT		((1 << 0) & CSI_IF_CFG_CSI_IF_MASK)
-#define CSI_IF_CFG_CSI_IF_BT656			((4 << 0) & CSI_IF_CFG_CSI_IF_MASK)
-#define CSI_IF_CFG_CSI_IF_BT1120		((5 << 0) & CSI_IF_CFG_CSI_IF_MASK)
-
-#define CSI_CAP_REG			0x8
-#define CSI_CAP_CH0_CAP_MASK_MASK		GENMASK(5, 2)
-#define CSI_CAP_CH0_CAP_MASK(count)		(((count) << 2) & CSI_CAP_CH0_CAP_MASK_MASK)
-#define CSI_CAP_CH0_VCAP_ON			BIT(1)
-#define CSI_CAP_CH0_SCAP_ON			BIT(0)
-
-#define CSI_SYNC_CNT_REG		0xc
-#define CSI_FIFO_THRS_REG		0x10
-#define CSI_BT656_HEAD_CFG_REG		0x14
-#define CSI_PTN_LEN_REG			0x30
-#define CSI_PTN_ADDR_REG		0x34
-#define CSI_VER_REG			0x3c
-
-#define CSI_CH_CFG_REG			0x44
-#define CSI_CH_CFG_INPUT_FMT_MASK		GENMASK(23, 20)
-#define CSI_CH_CFG_INPUT_FMT(fmt)		(((fmt) << 20) & CSI_CH_CFG_INPUT_FMT_MASK)
-#define CSI_CH_CFG_OUTPUT_FMT_MASK		GENMASK(19, 16)
-#define CSI_CH_CFG_OUTPUT_FMT(fmt)		(((fmt) << 16) & CSI_CH_CFG_OUTPUT_FMT_MASK)
-#define CSI_CH_CFG_VFLIP_EN			BIT(13)
-#define CSI_CH_CFG_HFLIP_EN			BIT(12)
-#define CSI_CH_CFG_FIELD_SEL_MASK		GENMASK(11, 10)
-#define CSI_CH_CFG_FIELD_SEL_FIELD0		((0 << 10) & CSI_CH_CFG_FIELD_SEL_MASK)
-#define CSI_CH_CFG_FIELD_SEL_FIELD1		((1 << 10) & CSI_CH_CFG_FIELD_SEL_MASK)
-#define CSI_CH_CFG_FIELD_SEL_BOTH		((2 << 10) & CSI_CH_CFG_FIELD_SEL_MASK)
-#define CSI_CH_CFG_INPUT_SEQ_MASK		GENMASK(9, 8)
-#define CSI_CH_CFG_INPUT_SEQ(seq)		(((seq) << 8) & CSI_CH_CFG_INPUT_SEQ_MASK)
-
-#define CSI_CH_SCALE_REG		0x4c
-#define CSI_CH_SCALE_QUART_EN			BIT(0)
-
-#define CSI_CH_F0_BUFA_REG		0x50
-
-#define CSI_CH_F1_BUFA_REG		0x58
-
-#define CSI_CH_F2_BUFA_REG		0x60
-
-#define CSI_CH_STA_REG			0x6c
-#define CSI_CH_STA_FIELD_STA_MASK		BIT(2)
-#define CSI_CH_STA_FIELD_STA_FIELD0		((0 << 2) & CSI_CH_STA_FIELD_STA_MASK)
-#define CSI_CH_STA_FIELD_STA_FIELD1		((1 << 2) & CSI_CH_STA_FIELD_STA_MASK)
-#define CSI_CH_STA_VCAP_STA			BIT(1)
-#define CSI_CH_STA_SCAP_STA			BIT(0)
-
-#define CSI_CH_INT_EN_REG		0x70
-#define CSI_CH_INT_EN_VS_INT_EN			BIT(7)
-#define CSI_CH_INT_EN_HB_OF_INT_EN		BIT(6)
-#define CSI_CH_INT_EN_MUL_ERR_INT_EN		BIT(5)
-#define CSI_CH_INT_EN_FIFO2_OF_INT_EN		BIT(4)
-#define CSI_CH_INT_EN_FIFO1_OF_INT_EN		BIT(3)
-#define CSI_CH_INT_EN_FIFO0_OF_INT_EN		BIT(2)
-#define CSI_CH_INT_EN_FD_INT_EN			BIT(1)
-#define CSI_CH_INT_EN_CD_INT_EN			BIT(0)
-
-#define CSI_CH_INT_STA_REG		0x74
-#define CSI_CH_INT_STA_VS_PD			BIT(7)
-#define CSI_CH_INT_STA_HB_OF_PD			BIT(6)
-#define CSI_CH_INT_STA_MUL_ERR_PD		BIT(5)
-#define CSI_CH_INT_STA_FIFO2_OF_PD		BIT(4)
-#define CSI_CH_INT_STA_FIFO1_OF_PD		BIT(3)
-#define CSI_CH_INT_STA_FIFO0_OF_PD		BIT(2)
-#define CSI_CH_INT_STA_FD_PD			BIT(1)
-#define CSI_CH_INT_STA_CD_PD			BIT(0)
-
-#define CSI_CH_FLD1_VSIZE_REG		0x78
-
-#define CSI_CH_HSIZE_REG		0x80
-#define CSI_CH_HSIZE_HOR_LEN_MASK		GENMASK(28, 16)
-#define CSI_CH_HSIZE_HOR_LEN(len)		(((len) << 16) & CSI_CH_HSIZE_HOR_LEN_MASK)
-#define CSI_CH_HSIZE_HOR_START_MASK		GENMASK(12, 0)
-#define CSI_CH_HSIZE_HOR_START(start)		(((start) << 0) & CSI_CH_HSIZE_HOR_START_MASK)
-
-#define CSI_CH_VSIZE_REG		0x84
-#define CSI_CH_VSIZE_VER_LEN_MASK		GENMASK(28, 16)
-#define CSI_CH_VSIZE_VER_LEN(len)		(((len) << 16) & CSI_CH_VSIZE_VER_LEN_MASK)
-#define CSI_CH_VSIZE_VER_START_MASK		GENMASK(12, 0)
-#define CSI_CH_VSIZE_VER_START(start)		(((start) << 0) & CSI_CH_VSIZE_VER_START_MASK)
-
-#define CSI_CH_BUF_LEN_REG		0x88
-#define CSI_CH_BUF_LEN_BUF_LEN_C_MASK		GENMASK(29, 16)
-#define CSI_CH_BUF_LEN_BUF_LEN_C(len)		(((len) << 16) & CSI_CH_BUF_LEN_BUF_LEN_C_MASK)
-#define CSI_CH_BUF_LEN_BUF_LEN_Y_MASK		GENMASK(13, 0)
-#define CSI_CH_BUF_LEN_BUF_LEN_Y(len)		(((len) << 0) & CSI_CH_BUF_LEN_BUF_LEN_Y_MASK)
-
-#define CSI_CH_FLIP_SIZE_REG		0x8c
-#define CSI_CH_FLIP_SIZE_VER_LEN_MASK		GENMASK(28, 16)
-#define CSI_CH_FLIP_SIZE_VER_LEN(len)		(((len) << 16) & CSI_CH_FLIP_SIZE_VER_LEN_MASK)
-#define CSI_CH_FLIP_SIZE_VALID_LEN_MASK		GENMASK(12, 0)
-#define CSI_CH_FLIP_SIZE_VALID_LEN(len)		(((len) << 0) & CSI_CH_FLIP_SIZE_VALID_LEN_MASK)
-
-#define CSI_CH_FRM_CLK_CNT_REG		0x90
-#define CSI_CH_ACC_ITNL_CLK_CNT_REG	0x94
-#define CSI_CH_FIFO_STAT_REG		0x98
-#define CSI_CH_PCLK_STAT_REG		0x9c
+#define SUN6I_CSI_ADDR_VALUE(a)			((a) >> 2)
+
+#define SUN6I_CSI_EN_REG			0x0
+#define SUN6I_CSI_EN_VER_EN			BIT(30)
+#define SUN6I_CSI_EN_PTN_CYCLE(v)		(((v) << 16) & GENMASK(23, 16))
+#define SUN6I_CSI_EN_SRAM_PWDN			BIT(8)
+#define SUN6I_CSI_EN_PTN_START			BIT(4)
+#define SUN6I_CSI_EN_CLK_CNT_SPL_VSYNC		BIT(3)
+#define SUN6I_CSI_EN_CLK_CNT_EN			BIT(2)
+#define SUN6I_CSI_EN_PTN_GEN_EN			BIT(1)
+#define SUN6I_CSI_EN_CSI_EN			BIT(0)
+
+/* Note that Allwinner manuals and code invert positive/negative definitions. */
+
+#define SUN6I_CSI_IF_CFG_REG			0x4
+#define SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(v)	(((v) << 24) & GENMASK(27, 24))
+#define SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE	(0 << 21)
+#define SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED	(1 << 21)
+#define SUN6I_CSI_IF_CFG_FPS_DS			BIT(20)
+#define SUN6I_CSI_IF_CFG_FIELD_POSITIVE		(0 << 19)
+#define SUN6I_CSI_IF_CFG_FIELD_NEGATIVE		(1 << 19)
+#define SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE	(0 << 18)
+#define SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE	(1 << 18)
+#define SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE	(0 << 17)
+#define SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE	(1 << 17)
+#define SUN6I_CSI_IF_CFG_CLK_POL_FALLING	(0 << 16)
+#define SUN6I_CSI_IF_CFG_CLK_POL_RISING		(1 << 16)
+#define SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC	(0 << 14)
+#define SUN6I_CSI_IF_CFG_FIELD_DT_FIELD		(1 << 14)
+#define SUN6I_CSI_IF_CFG_FIELD_DT_VSYNC		(2 << 14)
+#define SUN6I_CSI_IF_CFG_DATA_WIDTH_8		(0 << 8)
+#define SUN6I_CSI_IF_CFG_DATA_WIDTH_10		(1 << 8)
+#define SUN6I_CSI_IF_CFG_DATA_WIDTH_12		(2 << 8)
+#define SUN6I_CSI_IF_CFG_DATA_WIDTH_8_PLUS_2	(3 << 8)
+#define SUN6I_CSI_IF_CFG_DATA_WIDTH_2_TIMES_8	(4 << 8)
+#define SUN6I_CSI_IF_CFG_IF_CSI			(0 << 7)
+#define SUN6I_CSI_IF_CFG_IF_MIPI		(1 << 7)
+#define SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW		(0 << 0)
+#define SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED	(1 << 0)
+#define SUN6I_CSI_IF_CFG_IF_CSI_BT656		(4 << 0)
+#define SUN6I_CSI_IF_CFG_IF_CSI_BT1120		(5 << 0)
+
+#define SUN6I_CSI_CAP_REG			0x8
+#define SUN6I_CSI_CAP_MASK(v)			(((v) << 2) & GENMASK(5, 2))
+#define SUN6I_CSI_CAP_VCAP_ON			BIT(1)
+#define SUN6I_CSI_CAP_SCAP_ON			BIT(0)
+
+#define SUN6I_CSI_SYNC_CNT_REG			0xc
+#define SUN6I_CSI_FIFO_THRS_REG			0x10
+#define SUN6I_CSI_BT656_HEAD_CFG_REG		0x14
+
+#define SUN6I_CSI_PTN_LEN_REG			0x30
+#define SUN6I_CSI_PTN_ADDR_REG			0x34
+#define SUN6I_CSI_VER_REG			0x3c
+
+#define SUN6I_CSI_CH_CFG_REG			0x44
+#define SUN6I_CSI_CH_CFG_PAD_VAL(v)		(((v) << 24) & GENMASK(31, 24))
+#define SUN6I_CSI_CH_CFG_INPUT_FMT(v)		(((v) << 20) & GENMASK(23, 20))
+#define SUN6I_CSI_CH_CFG_OUTPUT_FMT(v)		(((v) << 16) & GENMASK(19, 16))
+#define SUN6I_CSI_CH_CFG_VFLIP_EN		BIT(13)
+#define SUN6I_CSI_CH_CFG_HFLIP_EN		BIT(12)
+#define SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0	(0 << 10)
+#define SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1	(1 << 10)
+#define SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER	(2 << 10)
+#define SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(v)	(((v) << 8) & GENMASK(9, 8))
+
+#define SUN6I_CSI_INPUT_FMT_RAW			0
+#define SUN6I_CSI_INPUT_FMT_YUV422		3
+#define SUN6I_CSI_INPUT_FMT_YUV420		4
+
+/* Note that Allwinner manuals and code invert frame/field definitions. */
+
+/* RAW */
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_8	0
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_10	1
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_RAW_12	2
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_RGB565	4
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_RGB888	5
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_PRGB888	6
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_8	8
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_10	9
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_RAW_12	10
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_RGB565	12
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_RGB888	13
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_PRGB888	14
+
+/* YUV */
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_YUV422P	0
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_YUV420P	1
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_YUV420P	2
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_YUV422P	3
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_YUV422SP	4
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_YUV420SP	5
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_YUV420SP	6
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_YUV422SP	7
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_YUV422MB	8
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_YUV420MB	9
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_YUV420MB	10
+#define SUN6I_CSI_OUTPUT_FMT_FIELD_YUV422MB	11
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_YUV422SP_10	12
+#define SUN6I_CSI_OUTPUT_FMT_FRAME_YUV420SP_10	13
+
+/* YUV Planar */
+#define SUN6I_CSI_INPUT_YUV_SEQ_YUYV		0
+#define SUN6I_CSI_INPUT_YUV_SEQ_YVYU		1
+#define SUN6I_CSI_INPUT_YUV_SEQ_UYVY		2
+#define SUN6I_CSI_INPUT_YUV_SEQ_VYUY		3
+
+/* YUV Semi-planar */
+#define SUN6I_CSI_INPUT_YUV_SEQ_UV		0
+#define SUN6I_CSI_INPUT_YUV_SEQ_VU		1
+
+#define SUN6I_CSI_CH_SCALE_REG			0x4c
+#define SUN6I_CSI_CH_SCALE_QUART_EN		BIT(0)
+
+#define SUN6I_CSI_CH_FIFO0_ADDR_REG		0x50
+#define SUN6I_CSI_CH_FIFO1_ADDR_REG		0x58
+#define SUN6I_CSI_CH_FIFO2_ADDR_REG		0x60
+
+#define SUN6I_CSI_CH_STA_REG			0x6c
+#define SUN6I_CSI_CH_STA_FIELD			BIT(2)
+#define SUN6I_CSI_CH_STA_VCAP			BIT(1)
+#define SUN6I_CSI_CH_STA_SCAP			BIT(0)
+
+#define SUN6I_CSI_CH_INT_EN_REG			0x70
+#define SUN6I_CSI_CH_INT_EN_VS			BIT(7)
+#define SUN6I_CSI_CH_INT_EN_HB_OF		BIT(6)
+#define SUN6I_CSI_CH_INT_EN_MUL_ERR		BIT(5)
+#define SUN6I_CSI_CH_INT_EN_FIFO2_OF		BIT(4)
+#define SUN6I_CSI_CH_INT_EN_FIFO1_OF		BIT(3)
+#define SUN6I_CSI_CH_INT_EN_FIFO0_OF		BIT(2)
+#define SUN6I_CSI_CH_INT_EN_FD			BIT(1)
+#define SUN6I_CSI_CH_INT_EN_CD			BIT(0)
+
+#define SUN6I_CSI_CH_INT_STA_REG		0x74
+#define SUN6I_CSI_CH_INT_STA_CLEAR		0xff
+#define SUN6I_CSI_CH_INT_STA_VS			BIT(7)
+#define SUN6I_CSI_CH_INT_STA_HB_OF		BIT(6)
+#define SUN6I_CSI_CH_INT_STA_MUL_ERR		BIT(5)
+#define SUN6I_CSI_CH_INT_STA_FIFO2_OF		BIT(4)
+#define SUN6I_CSI_CH_INT_STA_FIFO1_OF		BIT(3)
+#define SUN6I_CSI_CH_INT_STA_FIFO0_OF		BIT(2)
+#define SUN6I_CSI_CH_INT_STA_FD			BIT(1)
+#define SUN6I_CSI_CH_INT_STA_CD			BIT(0)
+
+#define SUN6I_CSI_CH_FLD1_VSIZE_REG		0x78
+#define SUN6I_CSI_CH_FLD1_VSIZE_VER_LEN(v)	(((v) << 16) & GENMASK(28, 16))
+#define SUN6I_CSI_CH_FLD1_VSIZE_VER_START(v)	((v) & GENMASK(12, 0))
+
+#define SUN6I_CSI_CH_HSIZE_REG			0x80
+#define SUN6I_CSI_CH_HSIZE_LEN(v)		(((v) << 16) & GENMASK(28, 16))
+#define SUN6I_CSI_CH_HSIZE_START(v)		((v) & GENMASK(12, 0))
+
+#define SUN6I_CSI_CH_VSIZE_REG			0x84
+#define SUN6I_CSI_CH_VSIZE_LEN(v)		(((v) << 16) & GENMASK(28, 16))
+#define SUN6I_CSI_CH_VSIZE_START(v)		((v) & GENMASK(12, 0))
+
+#define SUN6I_CSI_CH_BUF_LEN_REG		0x88
+#define SUN6I_CSI_CH_BUF_LEN_CHROMA_LINE(v)	(((v) << 16) & GENMASK(29, 16))
+#define SUN6I_CSI_CH_BUF_LEN_LUMA_LINE(v)	((v) & GENMASK(13, 0))
+
+#define SUN6I_CSI_CH_FLIP_SIZE_REG		0x8c
+#define SUN6I_CSI_CH_FLIP_SIZE_VER_LEN(v)	(((v) << 16) & GENMASK(28, 16))
+#define SUN6I_CSI_CH_FLIP_SIZE_VALID_LEN(v)	((v) & GENMASK(12, 0))
+
+#define SUN6I_CSI_CH_FRM_CLK_CNT_REG		0x90
+#define SUN6I_CSI_CH_ACC_ITNL_CLK_CNT_REG	0x94
+#define SUN6I_CSI_CH_FIFO_STAT_REG		0x98
+#define SUN6I_CSI_CH_PCLK_STAT_REG		0x9c
 
 /*
  * csi input data format
-- 
2.37.1

