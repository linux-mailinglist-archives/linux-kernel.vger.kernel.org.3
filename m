Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006F44AAC0B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377143AbiBES7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381732AbiBES47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:59 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED29C03FED9;
        Sat,  5 Feb 2022 10:56:14 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E0472240016;
        Sat,  5 Feb 2022 18:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3LhFPVwGxoOrWZ1HkvtJgo9PGpxM3Ge8Kn9h1p++8mA=;
        b=HO1PQ6MNIInKM2Q/W6K76u61/wKCZbZP/R1bOoCflNKDMhtmvQyQebax+XrHBylhXzzAC1
        1YWM496Eh8aJj7bWotUqrBb/m+GGNyk4Q6V2VwQ1pER/KaLMqktu7y2SGxWC+EoBqy5uhQ
        J2Rhx6WyhoLB2qynANAu1IEhRwkoESOirHGE/FcyH+73Z5xedGSVJWZVpkKoGTbnvUIISf
        g1QnLJTxpVIGFxfDfBqowGXdV/+uhoRf9AttSg4tV3Moa0TYC3g1VwyhVq+Ja4MjdkoGCU
        tnpX+YRI9GCwkmfdFpR9M3I2gyBF9CHr00/UJrkZIZsiNCYgBy+v3Hkz9NfKPA==
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
Subject: [PATCH v2 55/66] media: sun6i-csi: Only configure capture when streaming
Date:   Sat,  5 Feb 2022 19:54:18 +0100
Message-Id: <20220205185429.2278860-56-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a streaming element to the capture state structure to know if the
capture device is used or not. Only configure things related to output
when streaming, including the output format, irq, state (dma buffer)
and window configuration registers.

After this change, it becomes possible to use the bridge without the
capture device, which will be the case in the isp media flow.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 50 ++++++++++++-------
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 11 +++-
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  1 +
 3 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
index b631220dd682..9827486dc3cb 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
@@ -338,6 +338,7 @@ sun6i_csi_bridge_configure_mipi_csi2(struct sun6i_csi_device *csi_dev)
 static void sun6i_csi_bridge_configure_format(struct sun6i_csi_device *csi_dev)
 {
 	struct regmap *regmap = csi_dev->regmap;
+	bool capture_streaming = csi_dev->capture.state.streaming;
 	const struct sun6i_csi_bridge_format *bridge_format;
 	const struct sun6i_csi_capture_format *capture_format;
 	u32 mbus_code, field, pixelformat;
@@ -353,26 +354,29 @@ static void sun6i_csi_bridge_configure_format(struct sun6i_csi_device *csi_dev)
 	input_format = bridge_format->input_format;
 	input_yuv_seq = bridge_format->input_yuv_seq;
 
-	sun6i_csi_capture_format(csi_dev, &pixelformat, NULL);
+	if (capture_streaming) {
+		sun6i_csi_capture_format(csi_dev, &pixelformat, NULL);
 
-	capture_format = sun6i_csi_capture_format_find(pixelformat);
-	if (WARN_ON(!capture_format))
-		return;
+		capture_format = sun6i_csi_capture_format_find(pixelformat);
+		if (WARN_ON(!capture_format))
+			return;
 
-	if (capture_format->input_format_raw)
-		input_format = SUN6I_CSI_INPUT_FMT_RAW;
+		if (capture_format->input_format_raw)
+			input_format = SUN6I_CSI_INPUT_FMT_RAW;
 
-	if (capture_format->input_yuv_seq_invert)
-		input_yuv_seq = bridge_format->input_yuv_seq_invert;
+		if (capture_format->input_yuv_seq_invert)
+			input_yuv_seq = bridge_format->input_yuv_seq_invert;
 
-	if (field == V4L2_FIELD_INTERLACED ||
-	    field == V4L2_FIELD_INTERLACED_TB ||
-	    field == V4L2_FIELD_INTERLACED_BT)
-		output_format = capture_format->output_format_field;
-	else
-		output_format = capture_format->output_format_frame;
+		if (field == V4L2_FIELD_INTERLACED ||
+		    field == V4L2_FIELD_INTERLACED_TB ||
+		    field == V4L2_FIELD_INTERLACED_BT)
+			output_format = capture_format->output_format_field;
+		else
+			output_format = capture_format->output_format_frame;
+
+		value |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(output_format);
+	}
 
-	value |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(output_format);
 	value |= SUN6I_CSI_CH_CFG_INPUT_FMT(input_format);
 	value |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(input_yuv_seq);
 
@@ -401,6 +405,7 @@ static void sun6i_csi_bridge_configure(struct sun6i_csi_device *csi_dev)
 static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 {
 	struct sun6i_csi_device *csi_dev = v4l2_get_subdevdata(subdev);
+	bool capture_streaming = csi_dev->capture.state.streaming;
 	struct device *dev = csi_dev->dev;
 	struct v4l2_subdev *source_subdev;
 	/* Initialize to 0 to use both in disable label (ret != 0) and off. */
@@ -431,15 +436,20 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 	/* Configure */
 
 	sun6i_csi_bridge_configure(csi_dev);
-	sun6i_csi_capture_configure(csi_dev);
+
+	if (capture_streaming)
+		sun6i_csi_capture_configure(csi_dev);
 
 	/* State Update */
 
-	sun6i_csi_capture_state_update(csi_dev);
+	if (capture_streaming)
+		sun6i_csi_capture_state_update(csi_dev);
 
 	/* Enable */
 
-	sun6i_csi_bridge_irq_enable(csi_dev);
+	if (capture_streaming)
+		sun6i_csi_bridge_irq_enable(csi_dev);
+
 	sun6i_csi_bridge_enable(csi_dev);
 
 	ret = v4l2_subdev_call(source_subdev, video, s_stream, 1);
@@ -449,7 +459,9 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev *subdev, int on)
 	return 0;
 
 disable:
-	sun6i_csi_bridge_irq_disable(csi_dev);
+	if (capture_streaming)
+		sun6i_csi_bridge_irq_disable(csi_dev);
+
 	sun6i_csi_bridge_disable(csi_dev);
 
 	csi_dev->bridge.source = NULL;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 67863642df44..f6dac15af675 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -616,13 +616,17 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	if (ret < 0)
 		goto error_state;
 
+	state->streaming = true;
+
 	ret = v4l2_subdev_call(subdev, video, s_stream, 1);
 	if (ret && ret != -ENOIOCTLCMD)
-		goto error_media_pipeline;
+		goto error_streaming;
 
 	return 0;
 
-error_media_pipeline:
+error_streaming:
+	state->streaming = false;
+
 	media_pipeline_stop(&video_dev->entity);
 
 error_state:
@@ -636,11 +640,14 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
+	struct sun6i_csi_capture_state *state = &csi_dev->capture.state;
 	struct video_device *video_dev = &csi_dev->capture.video_dev;
 	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
 
 	v4l2_subdev_call(subdev, video, s_stream, 0);
 
+	state->streaming = false;
+
 	media_pipeline_stop(&video_dev->entity);
 
 	sun6i_csi_capture_state_cleanup(csi_dev, true);
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index ceceb030aef6..29893cf96f6b 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -44,6 +44,7 @@ struct sun6i_csi_capture_state {
 	struct sun6i_csi_buffer		*complete;
 
 	unsigned int			sequence;
+	bool				streaming;
 };
 
 struct sun6i_csi_capture {
-- 
2.34.1

