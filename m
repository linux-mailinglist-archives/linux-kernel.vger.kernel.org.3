Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E095502D06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349942AbiDOPeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355457AbiDOPci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:32:38 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8838D76E4;
        Fri, 15 Apr 2022 08:29:01 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 701ADE0015;
        Fri, 15 Apr 2022 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7FHQnruHQ5VGh4qmCb+H78ZzzkOR9N2YEfIjwO+nmPc=;
        b=MGQmF4VSsmCJZKZ1hJg9Jy94mxypz3jtztZ6cZ3DgX+VfFY2HYlSFWMh+vf0nEsaIfZhYs
        RGCXDrpdwI04QqWMeNPEcc8cP1Ph6sNeeg2tJfrJSy9+CXRXUR0r1qLgFf7EXZCGLDM6Ij
        6OALpaf693LCwwlXkdTyQWpeheauX8D7pUmaVI1ae05hA1Z91u8lT6QomVy+ur5P8A0gXJ
        8fXBoNQ6lzrOHLCQZrtuUG9kACy43P87raeXcQXZhAl7aHduC3GCeGZglGOMKEzc6bkcDx
        WTTGnFrCxiF3BuD9BVfPy04Nqn5mha31biy+nT1mRwIZIIxF4DkV9DLghwdqAA==
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
Subject: [PATCH v4 35/45] media: sun6i-csi: Get bridge subdev directly in capture stream ops
Date:   Fri, 15 Apr 2022 17:28:01 +0200
Message-Id: <20220415152811.636419-36-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remote subdev connected to the capture video device is always
our bridge, so get the bridge subdev directly instead of using a
dedicated helper (which is removed by this commit).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 30 ++-----------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index b3452ed825ad..b92f8aa55a92 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -42,22 +42,6 @@ void sun6i_csi_capture_format(struct sun6i_csi_device *csi_dev,
 		*field = csi_dev->capture.format.fmt.pix.field;
 }
 
-static struct v4l2_subdev *
-sun6i_csi_capture_remote_subdev(struct sun6i_csi_capture *capture, u32 *pad)
-{
-	struct media_pad *remote;
-
-	remote = media_entity_remote_pad(&capture->pad);
-
-	if (!remote || !is_media_entity_v4l2_subdev(remote->entity))
-		return NULL;
-
-	if (pad)
-		*pad = remote->index;
-
-	return media_entity_to_v4l2_subdev(remote->entity);
-}
-
 /* Format */
 
 static const struct sun6i_csi_capture_format sun6i_csi_capture_formats[] = {
@@ -822,8 +806,8 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
 	struct sun6i_csi_capture_state *state = &capture->state;
 	struct video_device *video_dev = &capture->video_dev;
+	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
 	struct device *dev = csi_dev->dev;
-	struct v4l2_subdev *subdev;
 	int ret;
 
 	state->sequence = 0;
@@ -832,12 +816,6 @@ static int sun6i_csi_capture_start_streaming(struct vb2_queue *queue,
 	if (ret < 0)
 		goto error_state;
 
-	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
-	if (!subdev) {
-		ret = -EINVAL;
-		goto error_media_pipeline;
-	}
-
 	/* PM */
 
 	ret = pm_runtime_resume_and_get(dev);
@@ -886,12 +864,10 @@ static void sun6i_csi_capture_stop_streaming(struct vb2_queue *queue)
 {
 	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
 	struct sun6i_csi_capture *capture = &csi_dev->capture;
+	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
 	struct device *dev = csi_dev->dev;
-	struct v4l2_subdev *subdev;
 
-	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
-	if (subdev)
-		v4l2_subdev_call(subdev, video, s_stream, 0);
+	v4l2_subdev_call(subdev, video, s_stream, 0);
 
 	sun6i_csi_capture_disable(csi_dev);
 	sun6i_csi_capture_irq_disable(csi_dev);
-- 
2.35.2

