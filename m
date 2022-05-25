Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F18A5343F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbiEYTKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344146AbiEYTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:07:44 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5121512774;
        Wed, 25 May 2022 12:07:11 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5B88A1C0004;
        Wed, 25 May 2022 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KF7V5wdhEBZbE0QI6TdidIoE0fuNLaf9TH4sI5llwP4=;
        b=jrG5TuryZ6Jg/QtnlMPOBWdQxETTG+ixlt1cpBR0hn2DmMs5i7Lf0jm4cwoZwgOpB6rXzx
        HMxkcMuvvydis/yLCTb02dvAFDRrb0+WLtbkvT9pFKFMfzR/R1b+ud8scTmKF9zx8D8TOz
        SRGduVOCSFQdaNFeaFIZn6IkjqfXDxfbKJQp4HlFXQs0GwjRRGH6r4NBqWTtIqHJ2EGFZ7
        +VzYequoHXLYeo+B5SdOML8L2ZDUR0PFgB3JIUnu89ONQqVdo69ze04DrR5Usa3AVQrI5p
        NdYSlcyKLp5LAITJJRm1iLDyaNUTB10bEnyEA4uJPr7Zu20LJ9GLSGP99fDegQ==
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
Subject: [PATCH v5 36/44] media: sun6i-csi: Get bridge subdev directly in capture stream ops
Date:   Wed, 25 May 2022 21:06:09 +0200
Message-Id: <20220525190617.696344-37-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
References: <20220525190617.696344-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remote subdev connected to the capture video device is always
our bridge, so get the bridge subdev directly instead of using a
dedicated helper (which is removed by this commit).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 30 ++-----------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index be52ff679831..b91b6ad44ba1 100644
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
2.36.1

