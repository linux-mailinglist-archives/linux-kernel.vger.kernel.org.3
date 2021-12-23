Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4119947E814
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349974AbhLWTQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:16:39 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48564 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349967AbhLWTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:16:37 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNJGX9F031716;
        Thu, 23 Dec 2021 13:16:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640286993;
        bh=FcWD7n6VkAN+74nl1acWQBFr0n0exn0pGopGVCbNxng=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vQICtSgRuIrFVlNkL3w7xgj3Oy4AX71ygMDqYvmopbtJiPlssYjo6Qb7gk8dCrBe+
         /I1IbGxOVG30TOTj+fzGs1Zw8YMioC56cA9NmoM7dKhAw9Ma/ykquQDpyFWH5qNiss
         aLQu1kyj1Q0CW/psJ0+GRnCsekbge41lxR5KLcYY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNJGXqq124430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 13:16:33 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 13:16:32 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 13:16:32 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNJGGQQ006164;
        Thu, 23 Dec 2021 13:16:29 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Benoit Parrot <bparrot@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>
Subject: [PATCH v5 03/14] media: cadence: csi2rx: Add get_fmt and set_fmt pad ops
Date:   Fri, 24 Dec 2021 00:46:04 +0530
Message-ID: <20211223191615.17803-4-p.yadav@ti.com>
X-Mailer: git-send-email 2.33.1.835.ge9e5ba39a7
In-Reply-To: <20211223191615.17803-1-p.yadav@ti.com>
References: <20211223191615.17803-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format is needed to calculate the link speed for the external DPHY
configuration. It is not right to query the format from the source
subdev. Add get_fmt and set_fmt pad operations so that the format can be
configured and correct bpp be selected.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---

Changes in v5:
- Use YUV 1X16 formats instead of 2X8.
- New in v5.

 drivers/media/platform/cadence/cdns-csi2rx.c | 137 +++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 2547903f2e8e..4a2a5a9d019b 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -54,6 +54,11 @@ enum csi2rx_pads {
 	CSI2RX_PAD_MAX,
 };
 
+struct csi2rx_fmt {
+	u32				code;
+	u8				bpp;
+};
+
 struct csi2rx_priv {
 	struct device			*dev;
 	unsigned int			count;
@@ -79,12 +84,43 @@ struct csi2rx_priv {
 	struct v4l2_subdev		subdev;
 	struct v4l2_async_notifier	notifier;
 	struct media_pad		pads[CSI2RX_PAD_MAX];
+	struct v4l2_mbus_framefmt	fmt;
 
 	/* Remote source */
 	struct v4l2_subdev		*source_subdev;
 	int				source_pad;
 };
 
+static const struct csi2rx_fmt formats[] = {
+	{
+		.code	= MEDIA_BUS_FMT_YUYV8_1X16,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_UYVY8_1X16,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_YVYU8_1X16,
+		.bpp	= 16,
+	},
+	{
+		.code	= MEDIA_BUS_FMT_VYUY8_1X16,
+		.bpp	= 16,
+	},
+};
+
+static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(formats); i++)
+		if (formats[i].code == code)
+			return &formats[i];
+
+	return NULL;
+}
+
 static inline
 struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 {
@@ -236,12 +272,109 @@ static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
 	return ret;
 }
 
+static struct v4l2_mbus_framefmt *
+csi2rx_get_pad_format(struct csi2rx_priv *csi2rx,
+		      struct v4l2_subdev_state *state,
+		      unsigned int pad, u32 which)
+{
+	switch (which) {
+	case V4L2_SUBDEV_FORMAT_TRY:
+		return v4l2_subdev_get_try_format(&csi2rx->subdev, state, pad);
+	case V4L2_SUBDEV_FORMAT_ACTIVE:
+		return &csi2rx->fmt;
+	default:
+		return NULL;
+	}
+}
+
+static int csi2rx_get_fmt(struct v4l2_subdev *subdev,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *format)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	struct v4l2_mbus_framefmt *framefmt;
+
+	mutex_lock(&csi2rx->lock);
+
+	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
+					 format->which);
+	mutex_unlock(&csi2rx->lock);
+
+	if (!framefmt)
+		return -EINVAL;
+
+	format->format = *framefmt;
+
+	return 0;
+}
+
+static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
+			  struct v4l2_subdev_state *state,
+			  struct v4l2_subdev_format *format)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	struct v4l2_mbus_framefmt *framefmt;
+	const struct csi2rx_fmt *fmt;
+
+	/* No transcoding, source and sink formats must match. */
+	if (format->pad != CSI2RX_PAD_SINK)
+		return csi2rx_get_fmt(subdev, state, format);
+
+	fmt = csi2rx_get_fmt_by_code(format->format.code);
+	if (!fmt)
+		return -EOPNOTSUPP;
+
+	format->format.field = V4L2_FIELD_NONE;
+
+	mutex_lock(&csi2rx->lock);
+	framefmt = csi2rx_get_pad_format(csi2rx, state, format->pad,
+					 format->which);
+	if (!framefmt) {
+		mutex_unlock(&csi2rx->lock);
+		return -EINVAL;
+	}
+
+	*framefmt = format->format;
+	mutex_unlock(&csi2rx->lock);
+
+	return 0;
+}
+
+static int csi2rx_init_cfg(struct v4l2_subdev *subdev,
+			   struct v4l2_subdev_state *state)
+{
+	struct v4l2_subdev_format format = {
+		.which = state ? V4L2_SUBDEV_FORMAT_TRY
+			: V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad = CSI2RX_PAD_SINK,
+		.format = {
+			.width = 640,
+			.height = 480,
+			.code = MEDIA_BUS_FMT_UYVY8_1X16,
+			.field = V4L2_FIELD_NONE,
+			.colorspace = V4L2_COLORSPACE_SRGB,
+			.ycbcr_enc = V4L2_YCBCR_ENC_601,
+			.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+			.xfer_func = V4L2_XFER_FUNC_SRGB,
+		},
+	};
+
+	return csi2rx_set_fmt(subdev, state, &format);
+}
+
+static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
+	.get_fmt	= csi2rx_get_fmt,
+	.set_fmt	= csi2rx_set_fmt,
+	.init_cfg	= csi2rx_init_cfg,
+};
+
 static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
 	.s_stream	= csi2rx_s_stream,
 };
 
 static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
 	.video		= &csi2rx_video_ops,
+	.pad		= &csi2rx_pad_ops,
 };
 
 static int csi2rx_async_bound(struct v4l2_async_notifier *notifier,
@@ -457,6 +590,10 @@ static int csi2rx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup;
 
+	ret = csi2rx_init_cfg(&csi2rx->subdev, NULL);
+	if (ret)
+		goto err_cleanup;
+
 	ret = v4l2_async_register_subdev(&csi2rx->subdev);
 	if (ret < 0)
 		goto err_cleanup;
-- 
2.33.1.835.ge9e5ba39a7

