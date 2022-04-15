Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA9502D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344926AbiDOPec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355255AbiDOPdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:33:07 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921BD7921;
        Fri, 15 Apr 2022 08:29:07 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 62181E000B;
        Fri, 15 Apr 2022 15:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lmbm3uu6Ak9ybLK1C+cGzGH40257deustHb6NnF5VoM=;
        b=Gs0wFkW9nstaRhLKrH0BZCZ7AvoJhheTqX63akGh1+Uy/OIxnW0ES1OCDVZvCeOIBnIc0p
        xakPfADhA4rp27x1sObZiUrAgjem+E1HTash1TmDWlwfR9OgA36GfHR8sThJFrF8oLDAsv
        W2Ro6ARel58rIrK7r1rMZ41taqILSd2dmHcx51MjlnZQK6pAt904P+JysVf7CxHvyk/7yh
        UqAB92Un1kwka4qGjjfjElfP/9hXXDOiI3p14WQpzQLDcF2Qu2rbb9dekgaJHxim/Khb1k
        LBAbAMlCNuIKeb0XC90h4duF965lGwZuiQyvr8JCCe8GkXcvTDupCOflUQiIfw==
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
Subject: [PATCH v4 39/45] media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
Date:   Fri, 15 Apr 2022 17:28:05 +0200
Message-Id: <20220415152811.636419-40-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
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

Introduce MIPI CSI-2 support to the bridge with a new port, source
and hardware configuration helper.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  1 +
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 46 +++++++++++++++++--
 .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  1 +
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index 1aeaef84abba..6aa83dd11684 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -21,6 +21,7 @@
 
 enum sun6i_csi_port {
 	SUN6I_CSI_PORT_PARALLEL		= 0,
+	SUN6I_CSI_PORT_MIPI_CSI2	= 1,
 };
 
 struct sun6i_csi_buffer {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index ec3e04353106..27289d904d5c 100644
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
@@ -367,9 +386,16 @@ static void sun6i_csi_bridge_configure_format(struct sun6i_csi_device *csi_dev)
 	regmap_write(regmap, SUN6I_CSI_CH_CFG_REG, value);
 }
 
-static void sun6i_csi_bridge_configure(struct sun6i_csi_device *csi_dev)
+static void sun6i_csi_bridge_configure(struct sun6i_csi_device *csi_dev,
+				       struct sun6i_csi_bridge_source *source)
 {
-	sun6i_csi_bridge_configure_interface(csi_dev);
+	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
+
+	if (source == &bridge->source_parallel)
+		sun6i_csi_bridge_configure_parallel(csi_dev);
+	else
+		sun6i_csi_bridge_configure_mipi_csi2(csi_dev);
+
 	sun6i_csi_bridge_configure_format(csi_dev);
 }
 
@@ -381,6 +407,7 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
 	struct media_entity *bridge_entity = &bridge->subdev.entity;
 	struct device *dev = csi_dev->dev;
+	struct sun6i_csi_bridge_source *source;
 	struct v4l2_subdev *source_subdev;
 	struct media_link *link;
 	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
@@ -398,6 +425,11 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 
 	source_subdev = media_entity_to_v4l2_subdev(link->source->entity);
 
+	if (source_subdev == bridge->source_parallel.subdev)
+		source = &bridge->source_parallel;
+	else
+		source = &bridge->source_mipi_csi2;
+
 	if (!on) {
 		v4l2_subdev_call(source_subdev, video, s_stream, 0);
 		goto disable;
@@ -415,7 +447,7 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 
 	/* Configure */
 
-	sun6i_csi_bridge_configure(csi_dev);
+	sun6i_csi_bridge_configure(csi_dev, source);
 	sun6i_csi_capture_configure(csi_dev);
 
 	/* State Update */
@@ -607,6 +639,7 @@ sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
 	struct sun6i_csi_bridge_async_subdev *bridge_async_subdev =
 		container_of(async_subdev, struct sun6i_csi_bridge_async_subdev,
 			     async_subdev);
+	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
 	struct sun6i_csi_bridge_source *source = bridge_async_subdev->source;
 	bool enabled;
 
@@ -614,6 +647,9 @@ sun6i_csi_bridge_notifier_bound(struct v4l2_async_notifier *notifier,
 	case SUN6I_CSI_PORT_PARALLEL:
 		enabled = true;
 		break;
+	case SUN6I_CSI_PORT_MIPI_CSI2:
+		enabled = !bridge->source_parallel.expected;
+		break;
 	default:
 		break;
 	}
@@ -760,6 +796,8 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device *csi_dev)
 	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_parallel,
 				      SUN6I_CSI_PORT_PARALLEL,
 				      parallel_mbus_types);
+	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_mipi_csi2,
+				      SUN6I_CSI_PORT_MIPI_CSI2, NULL);
 
 	ret = v4l2_async_nf_register(v4l2_dev, notifier);
 	if (ret) {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
index cb3b27af4607..ee592a14b9c5 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
@@ -46,6 +46,7 @@ struct sun6i_csi_bridge {
 	struct mutex			lock; /* Mbus format lock. */
 
 	struct sun6i_csi_bridge_source	source_parallel;
+	struct sun6i_csi_bridge_source	source_mipi_csi2;
 };
 
 /* Helpers */
-- 
2.35.2

