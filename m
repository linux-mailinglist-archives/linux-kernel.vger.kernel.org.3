Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F074AABA1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381763AbiBES5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:57:02 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:42931 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381327AbiBESzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:32 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8AFCA24000D;
        Sat,  5 Feb 2022 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SNwbf5QlL6t/rXl3WBfynCKlJIABovC7MSi6MTabc8s=;
        b=mywFtUMgNaUOTwoAfns3csuiwAGjI4e+7Qg9LzjwtItnxTmmbpqSUob2pX0GNJUB000OwF
        OHs3tkvQrolL/FpPDeAfxNJ9/BELD5WiGlAv3kTZJBiyRq7ueuzwTFOAmIEXmSB/6pym30
        tFA5yZI43t/aMObAaPSuDhsNTXPgovYAXV4f6d0/1zWyinKm3vPeCJj4l7LnKZyGOkLSzn
        26g3TEmNszvBGo7+Ai7Iaho3SVWKUFKJdOKtPu2k9FRAA71LD7u21oUyCrTKgtDUnyAv5Z
        P5a86zEz9uFXYsWG+TaJReMDTzCQFFTcfPvHgna6xiFWk24c/ExRBsrvJaAWSQ==
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
Subject: [PATCH v2 28/66] media: sun6i-csi: Introduce and use video helper functions
Date:   Sat,  5 Feb 2022 19:53:51 +0100
Message-Id: <20220205185429.2278860-29-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce some helpers for buffer and general video configuration.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../platform/sunxi/sun6i-csi/sun6i_video.c    | 46 +++++++++++--------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 178dddb0eaf1..6f5470a6859d 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -92,6 +92,29 @@ static bool sun6i_video_format_check(u32 format)
 	return false;
 }
 
+/* Video */
+
+static void sun6i_video_buffer_configure(struct sun6i_csi_device *csi_dev,
+					 struct sun6i_csi_buffer *csi_buffer)
+{
+	csi_buffer->queued_to_csi = true;
+	sun6i_csi_update_buf_addr(csi_dev, csi_buffer->dma_addr);
+}
+
+static void sun6i_video_configure(struct sun6i_csi_device *csi_dev)
+{
+	struct sun6i_video *video = &csi_dev->video;
+	struct sun6i_csi_config config = { 0 };
+
+	config.pixelformat = video->format.fmt.pix.pixelformat;
+	config.code = video->mbus_code;
+	config.field = video->format.fmt.pix.field;
+	config.width = video->format.fmt.pix.width;
+	config.height = video->format.fmt.pix.height;
+
+	sun6i_csi_update_config(csi_dev, &config);
+}
+
 /* Queue */
 
 static int sun6i_video_queue_setup(struct vb2_queue *queue,
@@ -160,7 +183,6 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 	struct video_device *video_dev = &video->video_dev;
 	struct sun6i_csi_buffer *buf;
 	struct sun6i_csi_buffer *next_buf;
-	struct sun6i_csi_config config;
 	struct v4l2_subdev *subdev;
 	unsigned long flags;
 	int ret;
@@ -182,22 +204,13 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 		goto error_media_pipeline;
 	}
 
-	config.pixelformat = video->format.fmt.pix.pixelformat;
-	config.code = video->mbus_code;
-	config.field = video->format.fmt.pix.field;
-	config.width = video->format.fmt.pix.width;
-	config.height = video->format.fmt.pix.height;
-
-	ret = sun6i_csi_update_config(csi_dev, &config);
-	if (ret < 0)
-		goto error_media_pipeline;
+	sun6i_video_configure(csi_dev);
 
 	spin_lock_irqsave(&video->dma_queue_lock, flags);
 
 	buf = list_first_entry(&video->dma_queue,
 			       struct sun6i_csi_buffer, list);
-	buf->queued_to_csi = true;
-	sun6i_csi_update_buf_addr(csi_dev, buf->dma_addr);
+	sun6i_video_buffer_configure(csi_dev, buf);
 
 	sun6i_csi_set_stream(csi_dev, true);
 
@@ -219,8 +232,7 @@ static int sun6i_video_start_streaming(struct vb2_queue *queue,
 	 * would also drop frame when lacking of queued buffer.
 	 */
 	next_buf = list_next_entry(buf, list);
-	next_buf->queued_to_csi = true;
-	sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
+	sun6i_video_buffer_configure(csi_dev, next_buf);
 
 	spin_unlock_irqrestore(&video->dma_queue_lock, flags);
 
@@ -294,8 +306,7 @@ void sun6i_video_frame_done(struct sun6i_csi_device *csi_dev)
 	 * for next ISR call.
 	 */
 	if (!next_buf->queued_to_csi) {
-		next_buf->queued_to_csi = true;
-		sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
+		sun6i_video_buffer_configure(csi_dev, next_buf);
 		dev_dbg(csi_dev->dev, "Frame dropped!\n");
 		goto complete;
 	}
@@ -309,8 +320,7 @@ void sun6i_video_frame_done(struct sun6i_csi_device *csi_dev)
 	/* Prepare buffer for next frame but one.  */
 	if (!list_is_last(&next_buf->list, &video->dma_queue)) {
 		next_buf = list_next_entry(next_buf, list);
-		next_buf->queued_to_csi = true;
-		sun6i_csi_update_buf_addr(csi_dev, next_buf->dma_addr);
+		sun6i_video_buffer_configure(csi_dev, next_buf);
 	} else {
 		dev_dbg(csi_dev->dev, "Next frame will be dropped!\n");
 	}
-- 
2.34.1

