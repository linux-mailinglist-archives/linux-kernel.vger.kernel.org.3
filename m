Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4B54AABD4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381961AbiBES6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:58:12 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:41349 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381539AbiBES4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:14 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 35EE4240020;
        Sat,  5 Feb 2022 18:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r7vkirzgla1o4VdWEyY7qc3mJDeawM6hQPmFQlwv7HE=;
        b=jI3xbAZGghrP+ZL330+omfHnhKuELkaMUHdbyt7gUXmhlbZTPJkbSq+9H1m1yb/I1c2FCZ
        r1EAw+FysCHBy8OkqrapX6KlNO9kRGvb7C+5r04TjW6gObLl899cpArENcJhNwXAAvNVcp
        wyJbRqJRr7oWFMen250ndy4oaBEEDhfzRQvF1Uk7XaO8FoF996Irb5hPRp5jTJIfmhhCfg
        2BpVyx+ZlPAMAouZHotkpItDTrfIl/kRFSKPT2DISLfRKxXe9G2yvph0bYRAw86E4c7tgW
        o0WQGLukHP9T1KEKH/kT6qCzjVyV6PrPPJ2M+Wbn7OkHl2yt8nwUFLhPmycPGg==
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
Subject: [PATCH v2 54/66] media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
Date:   Sat,  5 Feb 2022 19:54:17 +0100
Message-Id: <20220205185429.2278860-55-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce MIPI CSI-2 support to the bridge with a new port, source
and hardware configuration helper.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  1 +
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 35 +++++++++++++++++--
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  1 +
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index d7082e951b06..3c08b2712215 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -21,6 +21,7 @@
 
 enum sun6i_csi_port {
 	SUN6I_CSI_PORT_PARALLEL		= 0,
+	SUN6I_CSI_PORT_MIPI_CSI2	= 1,
 };
 
 struct sun6i_csi_buffer {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index f5303842d169..b631220dd682 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -226,7 +226,7 @@ static void sun6i_csi_bridge_disable(struct sun6i_csi_device *csi_dev)
 }
 
 static void
-sun6i_csi_bridge_configure_interface(struct sun6i_csi_device *csi_dev)
+sun6i_csi_bridge_configure_parallel(struct sun6i_csi_device *csi_dev)
 {
 	struct device *dev = csi_dev->dev;
 	struct regmap *regmap = csi_dev->regmap;
@@ -316,6 +316,25 @@ sun6i_csi_bridge_configure_interface(struct sun6i_csi_device *csi_dev)
 	regmap_write(regmap, SUN6I_CSI_IF_CFG_REG, value);
 }
 
+static void
+sun6i_csi_bridge_configure_mipi_csi2(struct sun6i_csi_device *csi_dev)
+{
+	struct regmap *regmap = csi_dev->regmap;
+	u32 value = SUN6I_CSI_IF_CFG_IF_MIPI;
+	u32 field;
+
+	sun6i_csi_bridge_format(csi_dev, NULL, &field);
+
+	if (field == V4L2_FIELD_INTERLACED ||
+	    field == V4L2_FIELD_INTERLACED_TB ||
+	    field == V4L2_FIELD_INTERLACED_BT)
+		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED;
+	else
+		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
+
+	regmap_write(regmap, SUN6I_CSI_IF_CFG_REG, value);
+}
+
 static void sun6i_csi_bridge_configure_format(struct sun6i_csi_device *csi_dev)
 {
 	struct regmap *regmap = csi_dev->regmap;
@@ -369,7 +388,11 @@ static void sun6i_csi_bridge_configure_format(struct sun6i_csi_device *csi_dev)
 
 static void sun6i_csi_bridge_configure(struct sun6i_csi_device *csi_dev)
 {
-	sun6i_csi_bridge_configure_interface(csi_dev);
+	if (csi_dev->bridge.source == &csi_dev->bridge.source_parallel)
+		sun6i_csi_bridge_configure_parallel(csi_dev);
+	else if (csi_dev->bridge.source == &csi_dev->bridge.source_mipi_csi2)
+		sun6i_csi_bridge_configure_mipi_csi2(csi_dev);
+
 	sun6i_csi_bridge_configure_format(csi_dev);
 }
 
@@ -552,6 +575,8 @@ static int sun6i_csi_bridge_link_validate(struct media_link *link)
 
 	if (source_subdev == bridge->source_parallel.subdev)
 		bridge->source = &bridge->source_parallel;
+	else if (source_subdev == bridge->source_mipi_csi2.subdev)
+		bridge->source = &bridge->source_mipi_csi2;
 	else
 		return -EINVAL;
 
@@ -638,6 +663,10 @@ sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
 			source = &bridge->source_parallel;
 			enabled = true;
 			break;
+		case SUN6I_CSI_PORT_MIPI_CSI2:
+			source = &bridge->source_mipi_csi2;
+			enabled = !bridge->source_parallel.expected;
+			break;
 		default:
 			break;
 		}
@@ -784,6 +813,8 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
 	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_parallel,
 				      SUN6I_CSI_PORT_PARALLEL,
 				      parallel_mbus_types);
+	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_mipi_csi2,
+				      SUN6I_CSI_PORT_MIPI_CSI2, NULL);
 
 	ret = v4l2_async_nf_register(v4l2_dev, notifier);
 	if (ret) {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
index 079227c02482..e59c40611872 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
@@ -40,6 +40,7 @@ struct sun6i_csi_bridge {
 	struct v4l2_mbus_framefmt	mbus_format;
 
 	struct sun6i_csi_bridge_source	source_parallel;
+	struct sun6i_csi_bridge_source	source_mipi_csi2;
 	struct sun6i_csi_bridge_source	*source;
 };
 
-- 
2.34.1

