Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0E4D63DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349834AbiCKOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349461AbiCKOhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:24 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC081C8DAF;
        Fri, 11 Mar 2022 06:36:12 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1A9C8240012;
        Fri, 11 Mar 2022 14:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBf7ZsZre9TfQfmI5vha9jSv0sHiauMmdrFBfvzd4+s=;
        b=YR6C2NDnd33gjEd8qXogpUA5v3YWiSUW6z/e2LlHs7ZbSsAEWsl8CabJrlIcMgzrpLROjQ
        jp4eNPxf6/g6gd43xh2IOU7s5/nmgJUVyfHFUBoFnrLatLUQ8jlYdqPxsUuVNXbBXvVTDc
        3jG9hkBaZYSp22WGzojEm59GNiG99CGXZMhOTGs3WhP1MdjQLtUU/QefFaE5Ldkx57Nvhh
        xe8RpoeYzYgVVNrmCji6OxyzTiAy7smKXzOYu/2qx1IuEU/dJwWS9QSFxujl2lOuUG7/NR
        7id9bXSTM7Itvild7wrTtfsd9YMY2WnQwreD4M9ZNsg29e3FTcxGFxg91JflUQ==
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
Subject: [PATCH v3 14/46] media: sun6i-csi: Introduce and use video helper functions
Date:   Fri, 11 Mar 2022 15:35:00 +0100
Message-Id: <20220311143532.265091-15-paul.kocialkowski@bootlin.com>
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
2.35.1

