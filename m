Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4324D4AABEC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381757AbiBES7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381409AbiBES4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:56:53 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0EAC03FED0;
        Sat,  5 Feb 2022 10:56:04 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9830724001B;
        Sat,  5 Feb 2022 18:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etLtVx+NvjIpMcjeeF7ghhjop4Bf25hBbVp6k42V6CA=;
        b=lXshYQg2ileb516TLVOqgC6dkGfWUETTE6X35nydfGSvokEA7IZXewO+vDSUs2IQ+5TnTW
        pGGUHb2herTsl89KrmSivcbdyQFcn3zwbeHR5qT0Sob4cZLWF4mArMYfhH8628q7GmT0EI
        5826itNqlxUCY18/ty9W8a30MtW1lGrSK3l4Yo3lpvrJRZiYfUQ2k7zHSc+1MM5yBOPgUS
        ilbga8ongB01oOPx+9+czpOq4+znSdhv4NsgVUPOWc8xrsLRvKdCVN5IZ6WuMpedHqcT2W
        bjrby0mm24LO+K7xUHR76rU1uLAjpcSdOjUeLrw+MdVJqu+C34X1+we82+SJlg==
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
Subject: [PATCH v2 49/66] media: sun6i-csi: Get bridge subdev directly in capture stream ops
Date:   Sat,  5 Feb 2022 19:54:12 +0100
Message-Id: <20220205185429.2278860-50-paul.kocialkowski@bootlin.com>
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

The remote subdev connected to the capture video device is always
our bridge, so get the bridge subdev directly instead of using a
dedicated helper (which is removed by this commit).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 30 ++-----------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index be1a4fe8fe5f..2f9bf75e4e39 100644
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
2.34.1

