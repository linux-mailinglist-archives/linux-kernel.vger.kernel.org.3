Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F015A2EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344611AbiHZSeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344892AbiHZSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:33:36 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D09E42FC;
        Fri, 26 Aug 2022 11:33:22 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 30DA2FF807;
        Fri, 26 Aug 2022 18:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1661538801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UkzL+XjeV73DWx5Qcx35TSQvYKL4YWx9RJU4zkku6WM=;
        b=pngrdpf65rAH9cfayXOVD1sjUKDc+JhDoZe4W807Mlg8b8e8aegovGXo0ufQnDHBKptntE
        I4aTCKXzrrv1+pyxIMjtCXX9LRJeWxoGnzfwGcxo9Sj3keEN2IJvzTSoPtdhoVF7AyDVwa
        qK2gJKJRc6dW5qC0NX2HHw2jBD/kKsBCABgyrKyGOcBNSv7Dd/rUKPBnqk1DfK6JoxfTMC
        Q6b0UYv6BeRqSOVeVGCvMPvJ/4rWE8fjirYLWoJCvfGy4GeOc3EQwPxVE7sSWSnis3bl/D
        TXXv+kvwRcfA36AvkyM5dIG0t88p5U7sLsa95E0JF6s8XOFL0wP8Dq+vkfGuig==
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
Subject: [PATCH v6 12/43] media: sun6i-csi: Remove controls handler from the driver
Date:   Fri, 26 Aug 2022 20:32:09 +0200
Message-Id: <20220826183240.604834-13-paul.kocialkowski@bootlin.com>
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

The driver does not expose controls directly and thus does not need
a controls handler for its own use.

Controls attached to subdevs used to be exposed that way, however this
can easily lead to issue when multiple subdevs attached to the same
v4l2 device expose the same controls. Subdev controls should be set
through each individual subdev node instead.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../media/platform/sunxi/sun6i-csi/sun6i_csi.c    | 15 +--------------
 .../media/platform/sunxi/sun6i-csi/sun6i_csi.h    |  2 --
 .../media/platform/sunxi/sun6i-csi/sun6i_video.c  |  4 ----
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index e3d60b647cb2..d74eaa3132d6 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -691,23 +691,14 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 		goto error_media;
 	}
 
-	/* V4L2 Control Handler */
-
-	ret = v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
-	if (ret) {
-		dev_err(dev, "failed to init v4l2 control handler: %d\n", ret);
-		goto error_media;
-	}
-
 	/* V4L2 Device */
 
 	v4l2_dev->mdev = media_dev;
-	v4l2_dev->ctrl_handler = &v4l2->ctrl_handler;
 
 	ret = v4l2_device_register(dev, v4l2_dev);
 	if (ret) {
 		dev_err(dev, "failed to register v4l2 device: %d\n", ret);
-		goto error_v4l2_ctrl;
+		goto error_media;
 	}
 
 	/* Video */
@@ -746,9 +737,6 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device *csi_dev)
 error_v4l2_device:
 	v4l2_device_unregister(&v4l2->v4l2_dev);
 
-error_v4l2_ctrl:
-	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
-
 error_media:
 	media_device_unregister(media_dev);
 	media_device_cleanup(media_dev);
@@ -765,7 +753,6 @@ static void sun6i_csi_v4l2_cleanup(struct sun6i_csi_device *csi_dev)
 	v4l2_async_nf_cleanup(&v4l2->notifier);
 	sun6i_video_cleanup(csi_dev);
 	v4l2_device_unregister(&v4l2->v4l2_dev);
-	v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
 	media_device_cleanup(&v4l2->media_dev);
 }
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
index a76b545f2aa4..1edc3e91ba6f 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
@@ -8,7 +8,6 @@
 #ifndef __SUN6I_CSI_H__
 #define __SUN6I_CSI_H__
 
-#include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-fwnode.h>
 
@@ -35,7 +34,6 @@ struct sun6i_csi_config {
 
 struct sun6i_csi_v4l2 {
 	struct v4l2_device		v4l2_dev;
-	struct v4l2_ctrl_handler	ctrl_handler;
 	struct media_device		media_dev;
 
 	struct v4l2_async_notifier	notifier;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 627bdf695b96..a2881b1d7420 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -486,10 +486,6 @@ static const struct v4l2_ioctl_ops sun6i_video_ioctl_ops = {
 	.vidioc_dqbuf			= vb2_ioctl_dqbuf,
 	.vidioc_streamon		= vb2_ioctl_streamon,
 	.vidioc_streamoff		= vb2_ioctl_streamoff,
-
-	.vidioc_log_status		= v4l2_ctrl_log_status,
-	.vidioc_subscribe_event		= v4l2_ctrl_subscribe_event,
-	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
 };
 
 /* V4L2 File */
-- 
2.37.1

