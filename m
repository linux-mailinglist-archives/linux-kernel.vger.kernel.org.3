Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CABF4D2E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiCILnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiCILmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:42:55 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F020116BCD8;
        Wed,  9 Mar 2022 03:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646826116; x=1678362116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iQV1eFvLFnbtYXiohQguMMYHg/6BrzAOmBAwDo+NsSQ=;
  b=ArFHL16yBP4M1vnEUKkpQmON/61WQzLeuKAiReh0Xnhmz4HblI6l36TC
   BRwBeFvyGtxzhES2TiWzT972JXn6Elk0ZtMKxvV9OZgG4S9yznnruFrww
   67D1VPCBM0xZWicBkL8AXqlXWY4q9QX5h4RiYD6Q75HWUKo0LWLdkfMP0
   PugZUXV3z3ICSy1pko7a64bKWpVl17FdTrgX+pSYtcrpbd8PbVhPSUHWg
   rYwmRFkATrD6wc2/ZegFIKa2oR9G7Tx5X8wucFYbMblRqb74WkcHJdl0z
   gJ132UgeKzUWopiHrWmV7uc+0gih7hSVkIsE/8a8IBeD8FQe9cgUArv6w
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22553360"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Mar 2022 12:41:53 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 09 Mar 2022 12:41:53 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 09 Mar 2022 12:41:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1646826113; x=1678362113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iQV1eFvLFnbtYXiohQguMMYHg/6BrzAOmBAwDo+NsSQ=;
  b=A/7CwhzKtDJcGQApxKWf8citvm50Yn1t5luGVtK1LnGFEsHdnPbjSDRZ
   8bln4Y+86QzKZloVo0n/rRwgmGICnIhMVzhDpVgnEwirilazQfQyhqWYL
   X8mg0WYZ+0uqpxa8EucfykF8UZH2oJ3Uo1EwmXeFsmlu8eagTx7qfHVyh
   h31pLHeZslcRuTdHuMLrNUSxyiylq+f5V6+geOsi/qtxRfnNep+BLEk9J
   UbtKfLpGJ7F4jGIwT/Ow68L7Trt3JKK9I0yggAEnpvxXdUdJ/BVtKMez/
   J7uCwM6Gfuw9xTIYJJfz/fX3ylsZ9EaZ2I3g5y5KEQcpDRK4DOUQ09m5s
   w==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643670000"; 
   d="scan'208";a="22553359"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Mar 2022 12:41:53 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 35C16280075;
        Wed,  9 Mar 2022 12:41:53 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v3 1/8] media: imx: Store the type of hardware implementation
Date:   Wed,  9 Mar 2022 12:41:37 +0100
Message-Id: <20220309114144.120643-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309114144.120643-1-alexander.stein@ew.tq-group.com>
References: <20220309114144.120643-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>

The driver covers i.MX5/6, as well as i.MX7/8 hardware.
Those implementations differ, e.g. in the sizes of buffers they accept.

Some functionality should be abstracted, and storing type achieves that.

Note: This is a temporary solution until the imx7-media-csi driver gets
decoupled from the helpers shared with the i.MX6 implementation, and
should be reverted once this happens.

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
Changes in v3:
* Added note this change shall be reverted later on
* Add R-b Laurent Pinchart

 drivers/staging/media/imx/imx-ic-prpencvf.c   | 3 ++-
 drivers/staging/media/imx/imx-media-capture.c | 5 ++++-
 drivers/staging/media/imx/imx-media-csi.c     | 3 ++-
 drivers/staging/media/imx/imx-media.h         | 8 +++++++-
 drivers/staging/media/imx/imx7-media-csi.c    | 3 ++-
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 9b81cfbcd777..671bb9a681aa 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -1266,7 +1266,8 @@ static int prp_registered(struct v4l2_subdev *sd)
 
 	priv->vdev = imx_media_capture_device_init(ic_priv->ipu_dev,
 						   &ic_priv->sd,
-						   PRPENCVF_SRC_PAD, true);
+						   PRPENCVF_SRC_PAD, true,
+						   DEVICE_TYPE_IMX56);
 	if (IS_ERR(priv->vdev))
 		return PTR_ERR(priv->vdev);
 
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 93ba09236010..65dc95a48ecc 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -34,6 +34,7 @@ struct capture_priv {
 
 	struct imx_media_video_dev vdev;	/* Video device */
 	struct media_pad vdev_pad;		/* Video device pad */
+	enum imx_media_device_type type;	/* Type of hardware implementation */
 
 	struct v4l2_subdev *src_sd;		/* Source subdev */
 	int src_sd_pad;				/* Source subdev pad */
@@ -957,7 +958,8 @@ EXPORT_SYMBOL_GPL(imx_media_capture_device_unregister);
 
 struct imx_media_video_dev *
 imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
-			      int pad, bool legacy_api)
+			      int pad, bool legacy_api,
+			      enum imx_media_device_type type)
 {
 	struct capture_priv *priv;
 	struct video_device *vfd;
@@ -972,6 +974,7 @@ imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
 	priv->src_sd_pad = pad;
 	priv->dev = dev;
 	priv->legacy_api = legacy_api;
+	priv->type = type;
 
 	mutex_init(&priv->mutex);
 	INIT_LIST_HEAD(&priv->ready_q);
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index b2b1f4dd41d7..0f8943475fa8 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1804,7 +1804,8 @@ static int csi_registered(struct v4l2_subdev *sd)
 	}
 
 	priv->vdev = imx_media_capture_device_init(priv->sd.dev, &priv->sd,
-						   CSI_SRC_PAD_IDMAC, true);
+						   CSI_SRC_PAD_IDMAC, true,
+						   DEVICE_TYPE_IMX56);
 	if (IS_ERR(priv->vdev)) {
 		ret = PTR_ERR(priv->vdev);
 		goto free_fim;
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index f263fc3adbb9..e4c22b3ccd57 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -96,6 +96,11 @@ enum imx_pixfmt_sel {
 	PIXFMT_SEL_ANY = PIXFMT_SEL_YUV | PIXFMT_SEL_RGB | PIXFMT_SEL_BAYER,
 };
 
+enum imx_media_device_type {
+	DEVICE_TYPE_IMX56,
+	DEVICE_TYPE_IMX78,
+};
+
 struct imx_media_buffer {
 	struct vb2_v4l2_buffer vbuf; /* v4l buffer must be first */
 	struct list_head  list;
@@ -282,7 +287,8 @@ int imx_media_ic_unregister(struct v4l2_subdev *sd);
 /* imx-media-capture.c */
 struct imx_media_video_dev *
 imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
-			      int pad, bool legacy_api);
+			      int pad, bool legacy_api,
+			      enum imx_media_device_type type);
 void imx_media_capture_device_remove(struct imx_media_video_dev *vdev);
 int imx_media_capture_device_register(struct imx_media_video_dev *vdev,
 				      u32 link_flags);
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 8467a1491048..cf74960dee84 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1063,7 +1063,8 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
 	}
 
 	csi->vdev = imx_media_capture_device_init(csi->sd.dev, &csi->sd,
-						  IMX7_CSI_PAD_SRC, false);
+						  IMX7_CSI_PAD_SRC, false,
+						  DEVICE_TYPE_IMX78);
 	if (IS_ERR(csi->vdev))
 		return PTR_ERR(csi->vdev);
 
-- 
2.25.1

