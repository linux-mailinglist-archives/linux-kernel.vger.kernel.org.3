Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B763F4AABC0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381894AbiBES5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:57:45 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:52145 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381289AbiBESzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:53 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 17171240017;
        Sat,  5 Feb 2022 18:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0uQL8zzt9MM63qHmYlfeh8zoQTXQD02jc2R4hrTl6Y=;
        b=jAZ26Kn/ixI32OqgVBT9teyluW05Qy7s7RR6w7ZK7Hpk/egFpRKXzSIiiT/EwgU4FKs2zq
        RkN8Lc3BMrvM7no/qVnExsHZAJArWicHm7r47opZl/6TEZbl2/sbbj6X7nZb7k+BWW32AV
        smJE4Aw5CIQqL3fsIuIVF/Wdr1s1RDgkFJn8Kp2jsNElcMwTeFmcEqq44G5ypN3wJuD9/y
        NN+AxRqOozcjj6Si/BBaHb+oCheG6rAk1LVtSkTHI69ZNHGbimj8F0hkI33q7QRV3G0Vqx
        QUVdbvC0LA7asQRbHYYvLCEDezDEuQxrPV8FibodR+ShYaM9jlHVCePdaAywCQ==
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
Subject: [PATCH v2 42/66] media: sun6i-csi: Get mbus code from bridge instead of storing it
Date:   Sat,  5 Feb 2022 19:54:05 +0100
Message-Id: <20220205185429.2278860-43-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another instance of removing a duplicated variable and using common
helpers instead.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c        | 18 +++++-------------
 .../sunxi/sun6i-csi/sun6i_csi_capture.h        |  1 -
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index f977b89dcea2..12c02408d18e 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -17,6 +17,7 @@
 #include <media/videobuf2-v4l2.h>
 
 #include "sun6i_csi.h"
+#include "sun6i_csi_bridge.h"
 #include "sun6i_csi_capture.h"
 #include "sun6i_csi_reg.h"
 
@@ -455,20 +456,20 @@ sun6i_csi_capture_configure_interface(struct sun6i_csi_device *csi_dev)
 
 static void sun6i_csi_capture_configure_format(struct sun6i_csi_device *csi_dev)
 {
-	struct sun6i_csi_capture *capture = &csi_dev->capture;
-	u32 pixelformat, field;
+	u32 mbus_code, pixelformat, field;
 	u32 cfg = 0;
 	u32 val;
 
 	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
+	sun6i_csi_bridge_format(csi_dev, &mbus_code, NULL);
 
-	val = get_csi_input_format(csi_dev, capture->mbus_code, pixelformat);
+	val = get_csi_input_format(csi_dev, mbus_code, pixelformat);
 	cfg |= SUN6I_CSI_CH_CFG_INPUT_FMT(val);
 
 	val = get_csi_output_format(csi_dev, pixelformat, field);
 	cfg |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(val);
 
-	val = get_csi_input_seq(csi_dev, capture->mbus_code, pixelformat);
+	val = get_csi_input_seq(csi_dev, mbus_code, pixelformat);
 	cfg |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(val);
 
 	if (field == V4L2_FIELD_TOP)
@@ -739,11 +740,6 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	if (ret < 0)
 		goto error_state;
 
-	if (capture->mbus_code == 0) {
-		ret = -EINVAL;
-		goto error_media_pipeline;
-	}
-
 	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
 	if (!subdev) {
 		ret = -EINVAL;
@@ -1067,8 +1063,6 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
 	struct v4l2_subdev_format source_fmt;
 	int ret;
 
-	capture->mbus_code = 0;
-
 	if (!media_entity_remote_pad(link->sink->entity->pads)) {
 		dev_info(csi_dev->dev, "capture node %s pad not connected\n",
 			 vdev->name);
@@ -1100,8 +1094,6 @@ static int sun6i_csi_capture_link_validate(struct media_link *link)
 		return -EPIPE;
 	}
 
-	capture->mbus_code = source_fmt.format.code;
-
 	return 0;
 }
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 02bdf45f7ca5..3b9759e1563d 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -39,7 +39,6 @@ struct sun6i_csi_capture {
 	struct media_pad		pad;
 
 	struct v4l2_format		format;
-	u32				mbus_code;
 };
 
 void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
-- 
2.34.1

