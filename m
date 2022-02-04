Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4A4A990F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358677AbiBDMPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:15:46 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:57020 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358632AbiBDMPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976931; x=1675512931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0jzXBJ2fXI0x5vj73g1ujzvH0lAWyzFDAhA3RZ/VINw=;
  b=VSPezzx57EcOfoO3hIHruy6TNfAVVoECJMZ5j0aQbJDK50F95YkMEB4j
   xInuJea3ZMEXxf7d1YMj6JoNDGx8Q+nwOJ8E14+otYB5WBCvkf+B3hFjo
   HvsJaaYxe3GdxSYZbwLm397DKjA6sxuKxBjieH9vAFru/8D16X5g1oSYt
   ISFi/8gpk7fZ+VGLPO7S1GQKAW+oCc3dSPIfda/MUGwDzZd4Qo2WI+/Ql
   Tgob3qf4cqqoRyuQpKshkyX8P8mGJGVN1DskU+F7M8uPiev2tPyctIhy1
   M0Dzfl02sCQy59gL4dMTTllPPPMl9wGQTtb6Cwb5PKgvGgEBnmOLiIamE
   A==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903442"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 Feb 2022 13:15:30 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 04 Feb 2022 13:15:30 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 04 Feb 2022 13:15:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1643976930; x=1675512930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0jzXBJ2fXI0x5vj73g1ujzvH0lAWyzFDAhA3RZ/VINw=;
  b=R6gpuAoIf49JVzbVHQPb3QEtmtWLxhWw5u0ePtET9fj7uT5jkAC8Brxk
   ytKIjqreYVLLi1pZo4iQxcgTq/s/i4FalQBxdaxl6LKBqeKM1TQ/vwEmm
   +dOvjifaP/4z1XkhQyjYBsUZRwHsPkLBtbKUpra1C1NGkm4rVLPsYiOXI
   hu66VYjKhCexBE0Gkj0dfxa37LS7XdAxWtYUaYbo5tHFvC3+IydXz342j
   Me9V0J5akErmJy0PmNsp9oW/3xmMFUsNrR67ety7U6cETSUKb6ss1Chh1
   cZd3RGRwr6R38QSPatmhUx9GxGO+KknMYWqMTFF03MQQVQEKknLpwWQXz
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635199200"; 
   d="scan'208";a="21903426"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Feb 2022 13:15:24 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 63E87280075;
        Fri,  4 Feb 2022 13:15:24 +0100 (CET)
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
Subject: [PATCH 1/8] media: imx: Store the type of hardware implementation
Date:   Fri,  4 Feb 2022 13:15:07 +0100
Message-Id: <20220204121514.2762676-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
References: <20220204121514.2762676-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>

The driver covers i.MX5/6, as well as i.MX7/8 hardware.
Those implementations differ, e.g. in the sizes of buffers they accept.

Some functionality should be abstracted, and storing type achieves that.

Signed-off-by: Dorota Czaplejewicz <dorota.czaplejewicz@puri.sm>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in comparison to original commit from Dorota:
* Applied the suggestion from Hans at [1].

[1] https://patchwork.linuxtv.org/project/linux-media/patch/20211104113631.206899-2-dorota.czaplejewicz@puri.sm/

 drivers/staging/media/imx/imx-ic-prpencvf.c   | 3 ++-
 drivers/staging/media/imx/imx-media-capture.c | 5 ++++-
 drivers/staging/media/imx/imx-media-csi.c     | 3 ++-
 drivers/staging/media/imx/imx-media.h         | 3 ++-
 drivers/staging/media/imx/imx7-media-csi.c    | 3 ++-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/imx/imx-ic-prpencvf.c b/drivers/staging/media/imx/imx-ic-prpencvf.c
index 9b81cfbcd777..caaaac1a515a 100644
--- a/drivers/staging/media/imx/imx-ic-prpencvf.c
+++ b/drivers/staging/media/imx/imx-ic-prpencvf.c
@@ -1266,7 +1266,8 @@ static int prp_registered(struct v4l2_subdev *sd)
 
 	priv->vdev = imx_media_capture_device_init(ic_priv->ipu_dev,
 						   &ic_priv->sd,
-						   PRPENCVF_SRC_PAD, true);
+						   PRPENCVF_SRC_PAD, true,
+						   true);
 	if (IS_ERR(priv->vdev))
 		return PTR_ERR(priv->vdev);
 
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 93ba09236010..b61bf9f8ddf8 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -47,6 +47,7 @@ struct capture_priv {
 	struct v4l2_ctrl_handler ctrl_hdlr;	/* Controls inherited from subdevs */
 
 	bool legacy_api;			/* Use the legacy (pre-MC) API */
+	bool is_imx56;				/* Hardware is i.MX5/i.MX6 */
 };
 
 #define to_capture_priv(v) container_of(v, struct capture_priv, vdev)
@@ -957,7 +958,8 @@ EXPORT_SYMBOL_GPL(imx_media_capture_device_unregister);
 
 struct imx_media_video_dev *
 imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
-			      int pad, bool legacy_api)
+			      int pad, bool legacy_api,
+			      bool is_imx56)
 {
 	struct capture_priv *priv;
 	struct video_device *vfd;
@@ -972,6 +974,7 @@ imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
 	priv->src_sd_pad = pad;
 	priv->dev = dev;
 	priv->legacy_api = legacy_api;
+	priv->is_imx56 = is_imx56;
 
 	mutex_init(&priv->mutex);
 	INIT_LIST_HEAD(&priv->ready_q);
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index bd7f156f2d52..c8f6add00dbb 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -1803,7 +1803,8 @@ static int csi_registered(struct v4l2_subdev *sd)
 	}
 
 	priv->vdev = imx_media_capture_device_init(priv->sd.dev, &priv->sd,
-						   CSI_SRC_PAD_IDMAC, true);
+						   CSI_SRC_PAD_IDMAC, true,
+						   true);
 	if (IS_ERR(priv->vdev)) {
 		ret = PTR_ERR(priv->vdev);
 		goto free_fim;
diff --git a/drivers/staging/media/imx/imx-media.h b/drivers/staging/media/imx/imx-media.h
index f263fc3adbb9..73e8e6e0d8e8 100644
--- a/drivers/staging/media/imx/imx-media.h
+++ b/drivers/staging/media/imx/imx-media.h
@@ -282,7 +282,8 @@ int imx_media_ic_unregister(struct v4l2_subdev *sd);
 /* imx-media-capture.c */
 struct imx_media_video_dev *
 imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
-			      int pad, bool legacy_api);
+			      int pad, bool legacy_api,
+			      bool is_imx56);
 void imx_media_capture_device_remove(struct imx_media_video_dev *vdev);
 int imx_media_capture_device_register(struct imx_media_video_dev *vdev,
 				      u32 link_flags);
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 32311fc0e2a4..158d2a736c6d 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1039,7 +1039,8 @@ static int imx7_csi_registered(struct v4l2_subdev *sd)
 	}
 
 	csi->vdev = imx_media_capture_device_init(csi->sd.dev, &csi->sd,
-						  IMX7_CSI_PAD_SRC, false);
+						  IMX7_CSI_PAD_SRC, false,
+						  false);
 	if (IS_ERR(csi->vdev))
 		return PTR_ERR(csi->vdev);
 
-- 
2.25.1

