Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDC15A2EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244153AbiHZSdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344143AbiHZSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:13 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB06E3947;
        Fri, 26 Aug 2022 11:33:10 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 50F2CFF808;
        Fri, 26 Aug 2022 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgfc/mdxuvrHP6g6pOIfo97k6bJYWiFm3PnqSdcA2vk=;
        b=mR4gJRMoeNzs4r73KNQPW5NaY0udpcPPpJ3pPBaXkdHLnPQoQlvr55FATFoWXUKzX0p/JT
        zFPuVo55iVkdX1lCx2+A2cE7FdguZZOH08saMBMe9XXX3JarO0r8zlh6MJ40YWBjpTnHEv
        lzSrBRaCE36wYlHnoYcjJzyL/UcG5sbSedmtifjb2TlHTs1Yk3R6ZNvW7PvlgybvriLpIP
        Swihbx1QNC55XpVMD5vhmbr8lnHDUNbRT+9dEKru7KpRnHcLK+YjnlVViPjbLyHyFNNq7n
        AfU9ksggj5EP31/nyXPYG/AK27O7lBbsuLgebrQEbc1MMLR+mtXrwM8WSE1SIA==
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v6 02/43] media: sun6i-csi: Refactor main driver data structures
Date:   Fri, 26 Aug 2022 20:31:59 +0200
Message-Id: <20220826183240.604834-3-paul.kocialkowski@bootlin.com>
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

Merge contents of structs sun6i_csi and sun6i_csi_dev into a main
sun6i_csi_device structure holding a sun6i_csi_v4l2 struct for things
related to v4l2, as well as the already-existing sun6i_csi_video and
sun6i_csi_config which are left unchanged.

This mostly simplifies accessing stuff by having a single main
structure accessible to every part of the code instead of a private
definition.

No functional change is intended in this commit, variables are just
moved around (cosmetics).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 346 +++++++++---------
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  34 +-
 .../platform/sunxi/sun6i-csi/sun6i_video.c    |  52 +--
 .../platform/sunxi/sun6i-csi/sun6i_video.h    |   8 +-
 4 files changed, 218 insertions(+), 222 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 5ca05f348021..0e2b4d38e81c 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -27,37 +27,20 @@
 #include "sun6i_csi.h"
 #include "sun6i_csi_reg.h"
 
-struct sun6i_csi_dev {
-	struct sun6i_csi		csi;
-	struct device			*dev;
-
-	struct regmap			*regmap;
-	struct clk			*clk_mod;
-	struct clk			*clk_ram;
-	struct reset_control		*rstc_bus;
-
-	int				planar_offset[3];
-};
-
-static inline struct sun6i_csi_dev *sun6i_csi_to_dev(struct sun6i_csi *csi)
-{
-	return container_of(csi, struct sun6i_csi_dev, csi);
-}
-
 /* TODO add 10&12 bit YUV, RGB support */
-bool sun6i_csi_is_format_supported(struct sun6i_csi *csi,
+bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
 				   u32 pixformat, u32 mbus_code)
 {
-	struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
+	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
 
 	/*
 	 * Some video receivers have the ability to be compatible with
 	 * 8bit and 16bit bus width.
 	 * Identify the media bus format from device tree.
 	 */
-	if ((sdev->csi.v4l2_ep.bus_type == V4L2_MBUS_PARALLEL
-	     || sdev->csi.v4l2_ep.bus_type == V4L2_MBUS_BT656)
-	     && sdev->csi.v4l2_ep.bus.parallel.bus_width == 16) {
+	if ((v4l2->v4l2_ep.bus_type == V4L2_MBUS_PARALLEL
+	     || v4l2->v4l2_ep.bus_type == V4L2_MBUS_BT656)
+	     && v4l2->v4l2_ep.bus.parallel.bus_width == 16) {
 		switch (pixformat) {
 		case V4L2_PIX_FMT_NV12_16L16:
 		case V4L2_PIX_FMT_NV12:
@@ -74,13 +57,14 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi *csi,
 			case MEDIA_BUS_FMT_YVYU8_1X16:
 				return true;
 			default:
-				dev_dbg(sdev->dev, "Unsupported mbus code: 0x%x\n",
+				dev_dbg(csi_dev->dev,
+					"Unsupported mbus code: 0x%x\n",
 					mbus_code);
 				break;
 			}
 			break;
 		default:
-			dev_dbg(sdev->dev, "Unsupported pixformat: 0x%x\n",
+			dev_dbg(csi_dev->dev, "Unsupported pixformat: 0x%x\n",
 				pixformat);
 			break;
 		}
@@ -137,7 +121,7 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi *csi,
 		case MEDIA_BUS_FMT_YVYU8_2X8:
 			return true;
 		default:
-			dev_dbg(sdev->dev, "Unsupported mbus code: 0x%x\n",
+			dev_dbg(csi_dev->dev, "Unsupported mbus code: 0x%x\n",
 				mbus_code);
 			break;
 		}
@@ -152,50 +136,50 @@ bool sun6i_csi_is_format_supported(struct sun6i_csi *csi,
 		return (mbus_code == MEDIA_BUS_FMT_JPEG_1X8);
 
 	default:
-		dev_dbg(sdev->dev, "Unsupported pixformat: 0x%x\n", pixformat);
+		dev_dbg(csi_dev->dev, "Unsupported pixformat: 0x%x\n",
+			pixformat);
 		break;
 	}
 
 	return false;
 }
 
-int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
+int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable)
 {
-	struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
-	struct device *dev = sdev->dev;
-	struct regmap *regmap = sdev->regmap;
+	struct device *dev = csi_dev->dev;
+	struct regmap *regmap = csi_dev->regmap;
 	int ret;
 
 	if (!enable) {
 		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
 
-		clk_disable_unprepare(sdev->clk_ram);
+		clk_disable_unprepare(csi_dev->clk_ram);
 		if (of_device_is_compatible(dev->of_node,
 					    "allwinner,sun50i-a64-csi"))
-			clk_rate_exclusive_put(sdev->clk_mod);
-		clk_disable_unprepare(sdev->clk_mod);
-		reset_control_assert(sdev->rstc_bus);
+			clk_rate_exclusive_put(csi_dev->clk_mod);
+		clk_disable_unprepare(csi_dev->clk_mod);
+		reset_control_assert(csi_dev->reset);
 		return 0;
 	}
 
-	ret = clk_prepare_enable(sdev->clk_mod);
+	ret = clk_prepare_enable(csi_dev->clk_mod);
 	if (ret) {
-		dev_err(sdev->dev, "Enable csi clk err %d\n", ret);
+		dev_err(csi_dev->dev, "Enable csi clk err %d\n", ret);
 		return ret;
 	}
 
 	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
-		clk_set_rate_exclusive(sdev->clk_mod, 300000000);
+		clk_set_rate_exclusive(csi_dev->clk_mod, 300000000);
 
-	ret = clk_prepare_enable(sdev->clk_ram);
+	ret = clk_prepare_enable(csi_dev->clk_ram);
 	if (ret) {
-		dev_err(sdev->dev, "Enable clk_dram_csi clk err %d\n", ret);
+		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err %d\n", ret);
 		goto clk_mod_disable;
 	}
 
-	ret = reset_control_deassert(sdev->rstc_bus);
+	ret = reset_control_deassert(csi_dev->reset);
 	if (ret) {
-		dev_err(sdev->dev, "reset err %d\n", ret);
+		dev_err(csi_dev->dev, "reset err %d\n", ret);
 		goto clk_ram_disable;
 	}
 
@@ -204,15 +188,15 @@ int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable)
 	return 0;
 
 clk_ram_disable:
-	clk_disable_unprepare(sdev->clk_ram);
+	clk_disable_unprepare(csi_dev->clk_ram);
 clk_mod_disable:
 	if (of_device_is_compatible(dev->of_node, "allwinner,sun50i-a64-csi"))
-		clk_rate_exclusive_put(sdev->clk_mod);
-	clk_disable_unprepare(sdev->clk_mod);
+		clk_rate_exclusive_put(csi_dev->clk_mod);
+	clk_disable_unprepare(csi_dev->clk_mod);
 	return ret;
 }
 
-static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_dev *sdev,
+static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_device *csi_dev,
 					       u32 mbus_code, u32 pixformat)
 {
 	/* non-YUV */
@@ -230,12 +214,13 @@ static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_dev *sdev,
 	}
 
 	/* not support YUV420 input format yet */
-	dev_dbg(sdev->dev, "Select YUV422 as default input format of CSI.\n");
+	dev_dbg(csi_dev->dev, "Select YUV422 as default input format of CSI.\n");
 	return CSI_INPUT_FORMAT_YUV422;
 }
 
-static enum csi_output_fmt get_csi_output_format(struct sun6i_csi_dev *sdev,
-						 u32 pixformat, u32 field)
+static enum csi_output_fmt
+get_csi_output_format(struct sun6i_csi_device *csi_dev, u32 pixformat,
+		      u32 field)
 {
 	bool buf_interlaced = false;
 
@@ -294,14 +279,14 @@ static enum csi_output_fmt get_csi_output_format(struct sun6i_csi_dev *sdev,
 		return buf_interlaced ? CSI_FRAME_RAW_8 : CSI_FIELD_RAW_8;
 
 	default:
-		dev_warn(sdev->dev, "Unsupported pixformat: 0x%x\n", pixformat);
+		dev_warn(csi_dev->dev, "Unsupported pixformat: 0x%x\n", pixformat);
 		break;
 	}
 
 	return CSI_FIELD_RAW_8;
 }
 
-static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_dev *sdev,
+static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_device *csi_dev,
 					    u32 mbus_code, u32 pixformat)
 {
 	/* Input sequence does not apply to non-YUV formats */
@@ -328,7 +313,7 @@ static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_dev *sdev,
 		case MEDIA_BUS_FMT_YVYU8_2X8:
 			return CSI_INPUT_SEQ_YVYU;
 		default:
-			dev_warn(sdev->dev, "Unsupported mbus code: 0x%x\n",
+			dev_warn(csi_dev->dev, "Unsupported mbus code: 0x%x\n",
 				 mbus_code);
 			break;
 		}
@@ -350,7 +335,7 @@ static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_dev *sdev,
 		case MEDIA_BUS_FMT_YVYU8_2X8:
 			return CSI_INPUT_SEQ_YUYV;
 		default:
-			dev_warn(sdev->dev, "Unsupported mbus code: 0x%x\n",
+			dev_warn(csi_dev->dev, "Unsupported mbus code: 0x%x\n",
 				 mbus_code);
 			break;
 		}
@@ -360,7 +345,7 @@ static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_dev *sdev,
 		return CSI_INPUT_SEQ_YUYV;
 
 	default:
-		dev_warn(sdev->dev, "Unsupported pixformat: 0x%x, defaulting to YUYV\n",
+		dev_warn(csi_dev->dev, "Unsupported pixformat: 0x%x, defaulting to YUYV\n",
 			 pixformat);
 		break;
 	}
@@ -368,23 +353,23 @@ static enum csi_input_seq get_csi_input_seq(struct sun6i_csi_dev *sdev,
 	return CSI_INPUT_SEQ_YUYV;
 }
 
-static void sun6i_csi_setup_bus(struct sun6i_csi_dev *sdev)
+static void sun6i_csi_setup_bus(struct sun6i_csi_device *csi_dev)
 {
-	struct v4l2_fwnode_endpoint *endpoint = &sdev->csi.v4l2_ep;
-	struct sun6i_csi *csi = &sdev->csi;
+	struct v4l2_fwnode_endpoint *endpoint = &csi_dev->v4l2.v4l2_ep;
+	struct sun6i_csi_config *config = &csi_dev->config;
 	unsigned char bus_width;
 	u32 flags;
 	u32 cfg;
 	bool input_interlaced = false;
 
-	if (csi->config.field == V4L2_FIELD_INTERLACED
-	    || csi->config.field == V4L2_FIELD_INTERLACED_TB
-	    || csi->config.field == V4L2_FIELD_INTERLACED_BT)
+	if (config->field == V4L2_FIELD_INTERLACED
+	    || config->field == V4L2_FIELD_INTERLACED_TB
+	    || config->field == V4L2_FIELD_INTERLACED_BT)
 		input_interlaced = true;
 
 	bus_width = endpoint->bus.parallel.bus_width;
 
-	regmap_read(sdev->regmap, CSI_IF_CFG_REG, &cfg);
+	regmap_read(csi_dev->regmap, CSI_IF_CFG_REG, &cfg);
 
 	cfg &= ~(CSI_IF_CFG_CSI_IF_MASK | CSI_IF_CFG_MIPI_IF_MASK |
 		 CSI_IF_CFG_IF_DATA_WIDTH_MASK |
@@ -432,7 +417,7 @@ static void sun6i_csi_setup_bus(struct sun6i_csi_dev *sdev)
 			cfg |= CSI_IF_CFG_CLK_POL_FALLING_EDGE;
 		break;
 	default:
-		dev_warn(sdev->dev, "Unsupported bus type: %d\n",
+		dev_warn(csi_dev->dev, "Unsupported bus type: %d\n",
 			 endpoint->bus_type);
 		break;
 	}
@@ -450,54 +435,54 @@ static void sun6i_csi_setup_bus(struct sun6i_csi_dev *sdev)
 	case 16: /* No need to configure DATA_WIDTH for 16bit */
 		break;
 	default:
-		dev_warn(sdev->dev, "Unsupported bus width: %u\n", bus_width);
+		dev_warn(csi_dev->dev, "Unsupported bus width: %u\n", bus_width);
 		break;
 	}
 
-	regmap_write(sdev->regmap, CSI_IF_CFG_REG, cfg);
+	regmap_write(csi_dev->regmap, CSI_IF_CFG_REG, cfg);
 }
 
-static void sun6i_csi_set_format(struct sun6i_csi_dev *sdev)
+static void sun6i_csi_set_format(struct sun6i_csi_device *csi_dev)
 {
-	struct sun6i_csi *csi = &sdev->csi;
+	struct sun6i_csi_config *config = &csi_dev->config;
 	u32 cfg;
 	u32 val;
 
-	regmap_read(sdev->regmap, CSI_CH_CFG_REG, &cfg);
+	regmap_read(csi_dev->regmap, CSI_CH_CFG_REG, &cfg);
 
 	cfg &= ~(CSI_CH_CFG_INPUT_FMT_MASK |
 		 CSI_CH_CFG_OUTPUT_FMT_MASK | CSI_CH_CFG_VFLIP_EN |
 		 CSI_CH_CFG_HFLIP_EN | CSI_CH_CFG_FIELD_SEL_MASK |
 		 CSI_CH_CFG_INPUT_SEQ_MASK);
 
-	val = get_csi_input_format(sdev, csi->config.code,
-				   csi->config.pixelformat);
+	val = get_csi_input_format(csi_dev, config->code,
+				   config->pixelformat);
 	cfg |= CSI_CH_CFG_INPUT_FMT(val);
 
-	val = get_csi_output_format(sdev, csi->config.pixelformat,
-				    csi->config.field);
+	val = get_csi_output_format(csi_dev, config->pixelformat,
+				    config->field);
 	cfg |= CSI_CH_CFG_OUTPUT_FMT(val);
 
-	val = get_csi_input_seq(sdev, csi->config.code,
-				csi->config.pixelformat);
+	val = get_csi_input_seq(csi_dev, config->code,
+				config->pixelformat);
 	cfg |= CSI_CH_CFG_INPUT_SEQ(val);
 
-	if (csi->config.field == V4L2_FIELD_TOP)
+	if (config->field == V4L2_FIELD_TOP)
 		cfg |= CSI_CH_CFG_FIELD_SEL_FIELD0;
-	else if (csi->config.field == V4L2_FIELD_BOTTOM)
+	else if (config->field == V4L2_FIELD_BOTTOM)
 		cfg |= CSI_CH_CFG_FIELD_SEL_FIELD1;
 	else
 		cfg |= CSI_CH_CFG_FIELD_SEL_BOTH;
 
-	regmap_write(sdev->regmap, CSI_CH_CFG_REG, cfg);
+	regmap_write(csi_dev->regmap, CSI_CH_CFG_REG, cfg);
 }
 
-static void sun6i_csi_set_window(struct sun6i_csi_dev *sdev)
+static void sun6i_csi_set_window(struct sun6i_csi_device *csi_dev)
 {
-	struct sun6i_csi_config *config = &sdev->csi.config;
+	struct sun6i_csi_config *config = &csi_dev->config;
 	u32 bytesperline_y;
 	u32 bytesperline_c;
-	int *planar_offset = sdev->planar_offset;
+	int *planar_offset = csi_dev->planar_offset;
 	u32 width = config->width;
 	u32 height = config->height;
 	u32 hor_len = width;
@@ -507,7 +492,7 @@ static void sun6i_csi_set_window(struct sun6i_csi_dev *sdev)
 	case V4L2_PIX_FMT_YVYU:
 	case V4L2_PIX_FMT_UYVY:
 	case V4L2_PIX_FMT_VYUY:
-		dev_dbg(sdev->dev,
+		dev_dbg(csi_dev->dev,
 			"Horizontal length should be 2 times of width for packed YUV formats!\n");
 		hor_len = width * 2;
 		break;
@@ -515,10 +500,10 @@ static void sun6i_csi_set_window(struct sun6i_csi_dev *sdev)
 		break;
 	}
 
-	regmap_write(sdev->regmap, CSI_CH_HSIZE_REG,
+	regmap_write(csi_dev->regmap, CSI_CH_HSIZE_REG,
 		     CSI_CH_HSIZE_HOR_LEN(hor_len) |
 		     CSI_CH_HSIZE_HOR_START(0));
-	regmap_write(sdev->regmap, CSI_CH_VSIZE_REG,
+	regmap_write(csi_dev->regmap, CSI_CH_VSIZE_REG,
 		     CSI_CH_VSIZE_VER_LEN(height) |
 		     CSI_CH_VSIZE_VER_START(0));
 
@@ -550,7 +535,7 @@ static void sun6i_csi_set_window(struct sun6i_csi_dev *sdev)
 				bytesperline_c * height;
 		break;
 	default: /* raw */
-		dev_dbg(sdev->dev,
+		dev_dbg(csi_dev->dev,
 			"Calculating pixelformat(0x%x)'s bytesperline as a packed format\n",
 			config->pixelformat);
 		bytesperline_y = (sun6i_csi_get_bpp(config->pixelformat) *
@@ -561,46 +546,42 @@ static void sun6i_csi_set_window(struct sun6i_csi_dev *sdev)
 		break;
 	}
 
-	regmap_write(sdev->regmap, CSI_CH_BUF_LEN_REG,
+	regmap_write(csi_dev->regmap, CSI_CH_BUF_LEN_REG,
 		     CSI_CH_BUF_LEN_BUF_LEN_C(bytesperline_c) |
 		     CSI_CH_BUF_LEN_BUF_LEN_Y(bytesperline_y));
 }
 
-int sun6i_csi_update_config(struct sun6i_csi *csi,
+int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
 			    struct sun6i_csi_config *config)
 {
-	struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
-
 	if (!config)
 		return -EINVAL;
 
-	memcpy(&csi->config, config, sizeof(csi->config));
+	memcpy(&csi_dev->config, config, sizeof(csi_dev->config));
 
-	sun6i_csi_setup_bus(sdev);
-	sun6i_csi_set_format(sdev);
-	sun6i_csi_set_window(sdev);
+	sun6i_csi_setup_bus(csi_dev);
+	sun6i_csi_set_format(csi_dev);
+	sun6i_csi_set_window(csi_dev);
 
 	return 0;
 }
 
-void sun6i_csi_update_buf_addr(struct sun6i_csi *csi, dma_addr_t addr)
+void sun6i_csi_update_buf_addr(struct sun6i_csi_device *csi_dev,
+			       dma_addr_t addr)
 {
-	struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
-
-	regmap_write(sdev->regmap, CSI_CH_F0_BUFA_REG,
-		     (addr + sdev->planar_offset[0]) >> 2);
-	if (sdev->planar_offset[1] != -1)
-		regmap_write(sdev->regmap, CSI_CH_F1_BUFA_REG,
-			     (addr + sdev->planar_offset[1]) >> 2);
-	if (sdev->planar_offset[2] != -1)
-		regmap_write(sdev->regmap, CSI_CH_F2_BUFA_REG,
-			     (addr + sdev->planar_offset[2]) >> 2);
+	regmap_write(csi_dev->regmap, CSI_CH_F0_BUFA_REG,
+		     (addr + csi_dev->planar_offset[0]) >> 2);
+	if (csi_dev->planar_offset[1] != -1)
+		regmap_write(csi_dev->regmap, CSI_CH_F1_BUFA_REG,
+			     (addr + csi_dev->planar_offset[1]) >> 2);
+	if (csi_dev->planar_offset[2] != -1)
+		regmap_write(csi_dev->regmap, CSI_CH_F2_BUFA_REG,
+			     (addr + csi_dev->planar_offset[2]) >> 2);
 }
 
-void sun6i_csi_set_stream(struct sun6i_csi *csi, bool enable)
+void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable)
 {
-	struct sun6i_csi_dev *sdev = sun6i_csi_to_dev(csi);
-	struct regmap *regmap = sdev->regmap;
+	struct regmap *regmap = csi_dev->regmap;
 
 	if (!enable) {
 		regmap_update_bits(regmap, CSI_CAP_REG, CSI_CAP_CH0_VCAP_ON, 0);
@@ -624,7 +605,7 @@ void sun6i_csi_set_stream(struct sun6i_csi *csi, bool enable)
 /* -----------------------------------------------------------------------------
  * Media Controller and V4L2
  */
-static int sun6i_csi_link_entity(struct sun6i_csi *csi,
+static int sun6i_csi_link_entity(struct sun6i_csi_device *csi_dev,
 				 struct media_entity *entity,
 				 struct fwnode_handle *fwnode)
 {
@@ -635,24 +616,25 @@ static int sun6i_csi_link_entity(struct sun6i_csi *csi,
 
 	ret = media_entity_get_fwnode_pad(entity, fwnode, MEDIA_PAD_FL_SOURCE);
 	if (ret < 0) {
-		dev_err(csi->dev, "%s: no source pad in external entity %s\n",
-			__func__, entity->name);
+		dev_err(csi_dev->dev,
+			"%s: no source pad in external entity %s\n", __func__,
+			entity->name);
 		return -EINVAL;
 	}
 
 	src_pad_index = ret;
 
-	sink = &csi->video.vdev.entity;
-	sink_pad = &csi->video.pad;
+	sink = &csi_dev->video.vdev.entity;
+	sink_pad = &csi_dev->video.pad;
 
-	dev_dbg(csi->dev, "creating %s:%u -> %s:%u link\n",
+	dev_dbg(csi_dev->dev, "creating %s:%u -> %s:%u link\n",
 		entity->name, src_pad_index, sink->name, sink_pad->index);
 	ret = media_create_pad_link(entity, src_pad_index, sink,
 				    sink_pad->index,
 				    MEDIA_LNK_FL_ENABLED |
 				    MEDIA_LNK_FL_IMMUTABLE);
 	if (ret < 0) {
-		dev_err(csi->dev, "failed to create %s:%u -> %s:%u link\n",
+		dev_err(csi_dev->dev, "failed to create %s:%u -> %s:%u link\n",
 			entity->name, src_pad_index,
 			sink->name, sink_pad->index);
 		return ret;
@@ -663,27 +645,29 @@ static int sun6i_csi_link_entity(struct sun6i_csi *csi,
 
 static int sun6i_subdev_notify_complete(struct v4l2_async_notifier *notifier)
 {
-	struct sun6i_csi *csi = container_of(notifier, struct sun6i_csi,
-					     notifier);
-	struct v4l2_device *v4l2_dev = &csi->v4l2_dev;
+	struct sun6i_csi_device *csi_dev =
+		container_of(notifier, struct sun6i_csi_device,
+			     v4l2.notifier);
+	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
+	struct v4l2_device *v4l2_dev = &v4l2->v4l2_dev;
 	struct v4l2_subdev *sd;
 	int ret;
 
-	dev_dbg(csi->dev, "notify complete, all subdevs registered\n");
+	dev_dbg(csi_dev->dev, "notify complete, all subdevs registered\n");
 
 	sd = list_first_entry(&v4l2_dev->subdevs, struct v4l2_subdev, list);
 	if (!sd)
 		return -EINVAL;
 
-	ret = sun6i_csi_link_entity(csi, &sd->entity, sd->fwnode);
+	ret = sun6i_csi_link_entity(csi_dev, &sd->entity, sd->fwnode);
 	if (ret < 0)
 		return ret;
 
-	ret = v4l2_device_register_subdev_nodes(&csi->v4l2_dev);
+	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
 	if (ret < 0)
 		return ret;
 
-	return media_device_register(&csi->media_dev);
+	return media_device_register(&v4l2->media_dev);
 }
 
 static const struct v4l2_async_notifier_operations sun6i_csi_async_ops = {
@@ -694,7 +678,7 @@ static int sun6i_csi_fwnode_parse(struct device *dev,
 				  struct v4l2_fwnode_endpoint *vep,
 				  struct v4l2_async_subdev *asd)
 {
-	struct sun6i_csi *csi = dev_get_drvdata(dev);
+	struct sun6i_csi_device *csi_dev = dev_get_drvdata(dev);
 
 	if (vep->base.port || vep->base.id) {
 		dev_warn(dev, "Only support a single port with one endpoint\n");
@@ -704,7 +688,7 @@ static int sun6i_csi_fwnode_parse(struct device *dev,
 	switch (vep->bus_type) {
 	case V4L2_MBUS_PARALLEL:
 	case V4L2_MBUS_BT656:
-		csi->v4l2_ep = *vep;
+		csi_dev->v4l2.v4l2_ep = *vep;
 		return 0;
 	default:
 		dev_err(dev, "Unsupported media bus type\n");
@@ -712,76 +696,79 @@ static int sun6i_csi_fwnode_parse(struct device *dev,
 	}
 }
 
-static void sun6i_csi_v4l2_cleanup(struct sun6i_csi *csi)
+static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
 {
-	media_device_unregister(&csi->media_dev);
-	v4l2_async_nf_unregister(&csi->notifier);
-	v4l2_async_nf_cleanup(&csi->notifier);
-	sun6i_video_cleanup(&csi->video);
-	v4l2_device_unregister(&csi->v4l2_dev);
-	v4l2_ctrl_handler_free(&csi->ctrl_handler);
-	media_device_cleanup(&csi->media_dev);
+	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
+
+	media_device_unregister(&v4l2->media_dev);
+	v4l2_async_nf_unregister(&v4l2->notifier);
+	v4l2_async_nf_cleanup(&v4l2->notifier);
+	sun6i_video_cleanup(&csi_dev->video);
+	v4l2_device_unregister(&v4l2->v4l2_dev);
+	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
+	media_device_cleanup(&v4l2->media_dev);
 }
 
-static int sun6i_csi_v4l2_init(struct sun6i_csi *csi)
+static int sun6i_csi_v4l2_init(struct sun6i_csi_device *csi_dev)
 {
+	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
 	int ret;
 
-	csi->media_dev.dev = csi->dev;
-	strscpy(csi->media_dev.model, SUN6I_CSI_DESCRIPTION,
-		sizeof(csi->media_dev.model));
-	csi->media_dev.hw_revision = 0;
+	v4l2->media_dev.dev = csi_dev->dev;
+	strscpy(v4l2->media_dev.model, SUN6I_CSI_DESCRIPTION,
+		sizeof(v4l2->media_dev.model));
+	v4l2->media_dev.hw_revision = 0;
 
-	media_device_init(&csi->media_dev);
-	v4l2_async_nf_init(&csi->notifier);
+	media_device_init(&v4l2->media_dev);
+	v4l2_async_nf_init(&v4l2->notifier);
 
-	ret = v4l2_ctrl_handler_init(&csi->ctrl_handler, 0);
+	ret = v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
 	if (ret) {
-		dev_err(csi->dev, "V4L2 controls handler init failed (%d)\n",
+		dev_err(csi_dev->dev, "V4L2 controls handler init failed (%d)\n",
 			ret);
 		goto clean_media;
 	}
 
-	csi->v4l2_dev.mdev = &csi->media_dev;
-	csi->v4l2_dev.ctrl_handler = &csi->ctrl_handler;
-	ret = v4l2_device_register(csi->dev, &csi->v4l2_dev);
+	v4l2->v4l2_dev.mdev = &v4l2->media_dev;
+	v4l2->v4l2_dev.ctrl_handler = &v4l2->ctrl_handler;
+	ret = v4l2_device_register(csi_dev->dev, &v4l2->v4l2_dev);
 	if (ret) {
-		dev_err(csi->dev, "V4L2 device registration failed (%d)\n",
+		dev_err(csi_dev->dev, "V4L2 device registration failed (%d)\n",
 			ret);
 		goto free_ctrl;
 	}
 
-	ret = sun6i_video_init(&csi->video, csi, SUN6I_CSI_NAME);
+	ret = sun6i_video_init(&csi_dev->video, csi_dev, SUN6I_CSI_NAME);
 	if (ret)
 		goto unreg_v4l2;
 
-	ret = v4l2_async_nf_parse_fwnode_endpoints(csi->dev,
-						   &csi->notifier,
+	ret = v4l2_async_nf_parse_fwnode_endpoints(csi_dev->dev,
+						   &v4l2->notifier,
 						   sizeof(struct
 							  v4l2_async_subdev),
 						   sun6i_csi_fwnode_parse);
 	if (ret)
 		goto clean_video;
 
-	csi->notifier.ops = &sun6i_csi_async_ops;
+	v4l2->notifier.ops = &sun6i_csi_async_ops;
 
-	ret = v4l2_async_nf_register(&csi->v4l2_dev, &csi->notifier);
+	ret = v4l2_async_nf_register(&v4l2->v4l2_dev, &v4l2->notifier);
 	if (ret) {
-		dev_err(csi->dev, "notifier registration failed\n");
+		dev_err(csi_dev->dev, "notifier registration failed\n");
 		goto clean_video;
 	}
 
 	return 0;
 
 clean_video:
-	sun6i_video_cleanup(&csi->video);
+	sun6i_video_cleanup(&csi_dev->video);
 unreg_v4l2:
-	v4l2_device_unregister(&csi->v4l2_dev);
+	v4l2_device_unregister(&v4l2->v4l2_dev);
 free_ctrl:
-	v4l2_ctrl_handler_free(&csi->ctrl_handler);
+	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
 clean_media:
-	v4l2_async_nf_cleanup(&csi->notifier);
-	media_device_cleanup(&csi->media_dev);
+	v4l2_async_nf_cleanup(&v4l2->notifier);
+	media_device_cleanup(&v4l2->media_dev);
 
 	return ret;
 }
@@ -791,8 +778,8 @@ static int sun6i_csi_v4l2_init(struct sun6i_csi *csi)
  */
 static irqreturn_t sun6i_csi_isr(int irq, void *dev_id)
 {
-	struct sun6i_csi_dev *sdev = (struct sun6i_csi_dev *)dev_id;
-	struct regmap *regmap = sdev->regmap;
+	struct sun6i_csi_device *csi_dev = (struct sun6i_csi_device *)dev_id;
+	struct regmap *regmap = csi_dev->regmap;
 	u32 status;
 
 	regmap_read(regmap, CSI_CH_INT_STA_REG, &status);
@@ -812,7 +799,7 @@ static irqreturn_t sun6i_csi_isr(int irq, void *dev_id)
 	}
 
 	if (status & CSI_CH_INT_STA_FD_PD)
-		sun6i_video_frame_done(&sdev->csi.video);
+		sun6i_video_frame_done(&csi_dev->video);
 
 	regmap_write(regmap, CSI_CH_INT_STA_REG, status);
 
@@ -826,7 +813,7 @@ static const struct regmap_config sun6i_csi_regmap_config = {
 	.max_register	= 0x9c,
 };
 
-static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
+static int sun6i_csi_resource_request(struct sun6i_csi_device *csi_dev,
 				      struct platform_device *pdev)
 {
 	void __iomem *io_base;
@@ -837,29 +824,29 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-	sdev->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus", io_base,
-						 &sun6i_csi_regmap_config);
-	if (IS_ERR(sdev->regmap)) {
+	csi_dev->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus", io_base,
+						    &sun6i_csi_regmap_config);
+	if (IS_ERR(csi_dev->regmap)) {
 		dev_err(&pdev->dev, "Failed to init register map\n");
-		return PTR_ERR(sdev->regmap);
+		return PTR_ERR(csi_dev->regmap);
 	}
 
-	sdev->clk_mod = devm_clk_get(&pdev->dev, "mod");
-	if (IS_ERR(sdev->clk_mod)) {
+	csi_dev->clk_mod = devm_clk_get(&pdev->dev, "mod");
+	if (IS_ERR(csi_dev->clk_mod)) {
 		dev_err(&pdev->dev, "Unable to acquire csi clock\n");
-		return PTR_ERR(sdev->clk_mod);
+		return PTR_ERR(csi_dev->clk_mod);
 	}
 
-	sdev->clk_ram = devm_clk_get(&pdev->dev, "ram");
-	if (IS_ERR(sdev->clk_ram)) {
+	csi_dev->clk_ram = devm_clk_get(&pdev->dev, "ram");
+	if (IS_ERR(csi_dev->clk_ram)) {
 		dev_err(&pdev->dev, "Unable to acquire dram-csi clock\n");
-		return PTR_ERR(sdev->clk_ram);
+		return PTR_ERR(csi_dev->clk_ram);
 	}
 
-	sdev->rstc_bus = devm_reset_control_get_shared(&pdev->dev, NULL);
-	if (IS_ERR(sdev->rstc_bus)) {
+	csi_dev->reset = devm_reset_control_get_shared(&pdev->dev, NULL);
+	if (IS_ERR(csi_dev->reset)) {
 		dev_err(&pdev->dev, "Cannot get reset controller\n");
-		return PTR_ERR(sdev->rstc_bus);
+		return PTR_ERR(csi_dev->reset);
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -867,7 +854,7 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 		return -ENXIO;
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_csi_isr, 0,
-			       SUN6I_CSI_NAME, sdev);
+			       SUN6I_CSI_NAME, csi_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request csi IRQ\n");
 		return ret;
@@ -878,30 +865,29 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 
 static int sun6i_csi_probe(struct platform_device *pdev)
 {
-	struct sun6i_csi_dev *sdev;
+	struct sun6i_csi_device *csi_dev;
 	int ret;
 
-	sdev = devm_kzalloc(&pdev->dev, sizeof(*sdev), GFP_KERNEL);
-	if (!sdev)
+	csi_dev = devm_kzalloc(&pdev->dev, sizeof(*csi_dev), GFP_KERNEL);
+	if (!csi_dev)
 		return -ENOMEM;
 
-	sdev->dev = &pdev->dev;
+	csi_dev->dev = &pdev->dev;
 
-	ret = sun6i_csi_resource_request(sdev, pdev);
+	ret = sun6i_csi_resource_request(csi_dev, pdev);
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, sdev);
+	platform_set_drvdata(pdev, csi_dev);
 
-	sdev->csi.dev = &pdev->dev;
-	return sun6i_csi_v4l2_init(&sdev->csi);
+	return sun6i_csi_v4l2_init(csi_dev);
 }
 
 static int sun6i_csi_remove(struct platform_device *pdev)
 {
-	struct sun6i_csi_dev *sdev = platform_get_drvdata(pdev);
+	struct sun6i_csi_device *csi_dev = platform_get_drvdata(pdev);
 
-	sun6i_csi_v4l2_cleanup(&sdev->csi);
+	sun6i_csi_v4l2_cleanup(csi_dev);
 
 	return 0;
 }
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index e04f3c3fa27b..e4e7ac6c869f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -17,8 +17,6 @@
 #define SUN6I_CSI_NAME		"sun6i-csi"
 #define SUN6I_CSI_DESCRIPTION	"Allwinner A31 CSI Device"
 
-struct sun6i_csi;
-
 /**
  * struct sun6i_csi_config - configs for sun6i csi
  * @pixelformat: v4l2 pixel format (V4L2_PIX_FMT_*)
@@ -35,20 +33,29 @@ struct sun6i_csi_config {
 	u32		height;
 };
 
-struct sun6i_csi {
-	struct device			*dev;
-	struct v4l2_ctrl_handler	ctrl_handler;
+struct sun6i_csi_v4l2 {
 	struct v4l2_device		v4l2_dev;
+	struct v4l2_ctrl_handler	ctrl_handler;
 	struct media_device		media_dev;
 
 	struct v4l2_async_notifier	notifier;
-
 	/* video port settings */
 	struct v4l2_fwnode_endpoint	v4l2_ep;
+};
 
-	struct sun6i_csi_config		config;
+struct sun6i_csi_device {
+	struct device			*dev;
 
+	struct sun6i_csi_config		config;
+	struct sun6i_csi_v4l2		v4l2;
 	struct sun6i_video		video;
+
+	struct regmap			*regmap;
+	struct clk			*clk_mod;
+	struct clk			*clk_ram;
+	struct reset_control		*reset;
+
+	int				planar_offset[3];
 };
 
 /**
@@ -57,22 +64,22 @@ struct sun6i_csi {
  * @pixformat:	v4l2 pixel format (V4L2_PIX_FMT_*)
  * @mbus_code:	media bus format code (MEDIA_BUS_FMT_*)
  */
-bool sun6i_csi_is_format_supported(struct sun6i_csi *csi, u32 pixformat,
-				   u32 mbus_code);
+bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
+				   u32 pixformat, u32 mbus_code);
 
 /**
  * sun6i_csi_set_power() - power on/off the csi
  * @csi:	pointer to the csi
  * @enable:	on/off
  */
-int sun6i_csi_set_power(struct sun6i_csi *csi, bool enable);
+int sun6i_csi_set_power(struct sun6i_csi_device *csi_dev, bool enable);
 
 /**
  * sun6i_csi_update_config() - update the csi register settings
  * @csi:	pointer to the csi
  * @config:	see struct sun6i_csi_config
  */
-int sun6i_csi_update_config(struct sun6i_csi *csi,
+int sun6i_csi_update_config(struct sun6i_csi_device *csi_dev,
 			    struct sun6i_csi_config *config);
 
 /**
@@ -80,14 +87,15 @@ int sun6i_csi_update_config(struct sun6i_csi *csi,
  * @csi:	pointer to the csi
  * @addr:	frame buffer's physical address
  */
-void sun6i_csi_update_buf_addr(struct sun6i_csi *csi, dma_addr_t addr);
+void sun6i_csi_update_buf_addr(struct sun6i_csi_device *csi_dev,
+			       dma_addr_t addr);
 
 /**
  * sun6i_csi_set_stream() - start/stop csi streaming
  * @csi:	pointer to the csi
  * @enable:	start/stop
  */
-void sun6i_csi_set_stream(struct sun6i_csi *csi, bool enable);
+void sun6i_csi_set_stream(struct sun6i_csi_device *csi_dev, bool enable);
 
 /* get bpp form v4l2 pixformat */
 static inline int sun6i_csi_get_bpp(unsigned int pixformat)
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 1d46e113d01d..fdcfb3c8ba8f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -162,7 +162,7 @@ static int sun6i_video_start_streaming(struct vb2_queue *vq, unsigned int count)
 	config.width = video->fmt.fmt.pix.width;
 	config.height = video->fmt.fmt.pix.height;
 
-	ret = sun6i_csi_update_config(video->csi, &config);
+	ret = sun6i_csi_update_config(video->csi_dev, &config);
 	if (ret < 0)
 		goto stop_media_pipeline;
 
@@ -171,9 +171,9 @@ static int sun6i_video_start_streaming(struct vb2_queue *vq, unsigned int count)
 	buf = list_first_entry(&video->dma_queue,
 			       struct sun6i_csi_buffer, list);
 	buf->queued_to_csi = true;
-	sun6i_csi_update_buf_addr(video->csi, buf->dma_addr);
+	sun6i_csi_update_buf_addr(video->csi_dev, buf->dma_addr);
 
-	sun6i_csi_set_stream(video->csi, true);
+	sun6i_csi_set_stream(video->csi_dev, true);
 
 	/*
 	 * CSI will lookup the next dma buffer for next frame before the
@@ -194,7 +194,7 @@ static int sun6i_video_start_streaming(struct vb2_queue *vq, unsigned int count)
 	 */
 	next_buf = list_next_entry(buf, list);
 	next_buf->queued_to_csi = true;
-	sun6i_csi_update_buf_addr(video->csi, next_buf->dma_addr);
+	sun6i_csi_update_buf_addr(video->csi_dev, next_buf->dma_addr);
 
 	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
 
@@ -205,7 +205,7 @@ static int sun6i_video_start_streaming(struct vb2_queue *vq, unsigned int count)
 	return 0;
 
 stop_csi_stream:
-	sun6i_csi_set_stream(video->csi, false);
+	sun6i_csi_set_stream(video->csi_dev, false);
 stop_media_pipeline:
 	media_pipeline_stop(&video->vdev.entity);
 clear_dma_queue:
@@ -229,7 +229,7 @@ static void sun6i_video_stop_streaming(struct vb2_queue *vq)
 	if (subdev)
 		v4l2_subdev_call(subdev, video, s_stream, 0);
 
-	sun6i_csi_set_stream(video->csi, false);
+	sun6i_csi_set_stream(video->csi_dev, false);
 
 	media_pipeline_stop(&video->vdev.entity);
 
@@ -266,7 +266,7 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 	buf = list_first_entry(&video->dma_queue,
 			       struct sun6i_csi_buffer, list);
 	if (list_is_last(&buf->list, &video->dma_queue)) {
-		dev_dbg(video->csi->dev, "Frame dropped!\n");
+		dev_dbg(video->csi_dev->dev, "Frame dropped!\n");
 		goto unlock;
 	}
 
@@ -278,8 +278,8 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 	 */
 	if (!next_buf->queued_to_csi) {
 		next_buf->queued_to_csi = true;
-		sun6i_csi_update_buf_addr(video->csi, next_buf->dma_addr);
-		dev_dbg(video->csi->dev, "Frame dropped!\n");
+		sun6i_csi_update_buf_addr(video->csi_dev, next_buf->dma_addr);
+		dev_dbg(video->csi_dev->dev, "Frame dropped!\n");
 		goto unlock;
 	}
 
@@ -293,9 +293,9 @@ void sun6i_video_frame_done(struct sun6i_video *video)
 	if (!list_is_last(&next_buf->list, &video->dma_queue)) {
 		next_buf = list_next_entry(next_buf, list);
 		next_buf->queued_to_csi = true;
-		sun6i_csi_update_buf_addr(video->csi, next_buf->dma_addr);
+		sun6i_csi_update_buf_addr(video->csi_dev, next_buf->dma_addr);
 	} else {
-		dev_dbg(video->csi->dev, "Next frame will be dropped!\n");
+		dev_dbg(video->csi_dev->dev, "Next frame will be dropped!\n");
 	}
 
 unlock:
@@ -321,7 +321,7 @@ static int vidioc_querycap(struct file *file, void *priv,
 	strscpy(cap->driver, "sun6i-video", sizeof(cap->driver));
 	strscpy(cap->card, video->vdev.name, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:%s",
-		 video->csi->dev->of_node->name);
+		 video->csi_dev->dev->of_node->name);
 
 	return 0;
 }
@@ -488,7 +488,7 @@ static int sun6i_video_open(struct file *file)
 	if (!v4l2_fh_is_singular_file(file))
 		goto unlock;
 
-	ret = sun6i_csi_set_power(video->csi, true);
+	ret = sun6i_csi_set_power(video->csi_dev, true);
 	if (ret < 0)
 		goto fh_release;
 
@@ -516,7 +516,7 @@ static int sun6i_video_close(struct file *file)
 	v4l2_pipeline_pm_put(&video->vdev.entity);
 
 	if (last_fh)
-		sun6i_csi_set_power(video->csi, false);
+		sun6i_csi_set_power(video->csi_dev, false);
 
 	mutex_unlock(&video->lock);
 
@@ -561,7 +561,7 @@ static int sun6i_video_link_validate(struct media_link *link)
 	video->mbus_code = 0;
 
 	if (!media_pad_remote_pad_first(link->sink->entity->pads)) {
-		dev_info(video->csi->dev,
+		dev_info(video->csi_dev->dev,
 			 "video node %s pad not connected\n", vdev->name);
 		return -ENOLINK;
 	}
@@ -570,10 +570,10 @@ static int sun6i_video_link_validate(struct media_link *link)
 	if (ret < 0)
 		return ret;
 
-	if (!sun6i_csi_is_format_supported(video->csi,
+	if (!sun6i_csi_is_format_supported(video->csi_dev,
 					   video->fmt.fmt.pix.pixelformat,
 					   source_fmt.format.code)) {
-		dev_err(video->csi->dev,
+		dev_err(video->csi_dev->dev,
 			"Unsupported pixformat: 0x%x with mbus code: 0x%x!\n",
 			video->fmt.fmt.pix.pixelformat,
 			source_fmt.format.code);
@@ -582,7 +582,7 @@ static int sun6i_video_link_validate(struct media_link *link)
 
 	if (source_fmt.format.width != video->fmt.fmt.pix.width ||
 	    source_fmt.format.height != video->fmt.fmt.pix.height) {
-		dev_err(video->csi->dev,
+		dev_err(video->csi_dev->dev,
 			"Wrong width or height %ux%u (%ux%u expected)\n",
 			video->fmt.fmt.pix.width, video->fmt.fmt.pix.height,
 			source_fmt.format.width, source_fmt.format.height);
@@ -598,15 +598,16 @@ static const struct media_entity_operations sun6i_video_media_ops = {
 	.link_validate = sun6i_video_link_validate
 };
 
-int sun6i_video_init(struct sun6i_video *video, struct sun6i_csi *csi,
-		     const char *name)
+int sun6i_video_init(struct sun6i_video *video,
+		     struct sun6i_csi_device *csi_dev, const char *name)
 {
+	struct sun6i_csi_v4l2 *v4l2 = &csi_dev->v4l2;
 	struct video_device *vdev = &video->vdev;
 	struct vb2_queue *vidq = &video->vb2_vidq;
 	struct v4l2_format fmt = { 0 };
 	int ret;
 
-	video->csi = csi;
+	video->csi_dev = csi_dev;
 
 	/* Initialize the media entity... */
 	video->pad.flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
@@ -641,11 +642,12 @@ int sun6i_video_init(struct sun6i_video *video, struct sun6i_csi *csi,
 	vidq->lock			= &video->lock;
 	/* Make sure non-dropped frame */
 	vidq->min_buffers_needed	= 3;
-	vidq->dev			= csi->dev;
+	vidq->dev			= csi_dev->dev;
 
 	ret = vb2_queue_init(vidq);
 	if (ret) {
-		v4l2_err(&csi->v4l2_dev, "vb2_queue_init failed: %d\n", ret);
+		v4l2_err(&v4l2->v4l2_dev, "vb2_queue_init failed: %d\n",
+			 ret);
 		goto clean_entity;
 	}
 
@@ -656,7 +658,7 @@ int sun6i_video_init(struct sun6i_video *video, struct sun6i_csi *csi,
 	vdev->ioctl_ops		= &sun6i_video_ioctl_ops;
 	vdev->vfl_type		= VFL_TYPE_VIDEO;
 	vdev->vfl_dir		= VFL_DIR_RX;
-	vdev->v4l2_dev		= &csi->v4l2_dev;
+	vdev->v4l2_dev		= &v4l2->v4l2_dev;
 	vdev->queue		= vidq;
 	vdev->lock		= &video->lock;
 	vdev->device_caps	= V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE;
@@ -664,7 +666,7 @@ int sun6i_video_init(struct sun6i_video *video, struct sun6i_csi *csi,
 
 	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (ret < 0) {
-		v4l2_err(&csi->v4l2_dev,
+		v4l2_err(&v4l2->v4l2_dev,
 			 "video_register_device failed: %d\n", ret);
 		goto clean_entity;
 	}
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
index b9cd919c24ac..30e37ee0d07f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
@@ -11,12 +11,12 @@
 #include <media/v4l2-dev.h>
 #include <media/videobuf2-core.h>
 
-struct sun6i_csi;
+struct sun6i_csi_device;
 
 struct sun6i_video {
+	struct sun6i_csi_device		*csi_dev;
 	struct video_device		vdev;
 	struct media_pad		pad;
-	struct sun6i_csi		*csi;
 
 	struct mutex			lock;
 
@@ -29,8 +29,8 @@ struct sun6i_video {
 	u32				mbus_code;
 };
 
-int sun6i_video_init(struct sun6i_video *video, struct sun6i_csi *csi,
-		     const char *name);
+int sun6i_video_init(struct sun6i_video *video,
+		     struct sun6i_csi_device *csi_dev, const char *name);
 void sun6i_video_cleanup(struct sun6i_video *video);
 
 void sun6i_video_frame_done(struct sun6i_video *video);
-- 
2.37.1

