Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E12502D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351745AbiDOPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355431AbiDOPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:32:36 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC53FD76CF;
        Fri, 15 Apr 2022 08:28:59 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 06396E0003;
        Fri, 15 Apr 2022 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650036538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyGxn+0aEzq9CJ/mlVX2JBlDUu/U3bTY05TBYj6B3uM=;
        b=M8JHhFErqrhHuJ5CPQL9RvGw16OBgOrgiytU7eZBrD2/JqoVSf+5j74bcFrvTwQiZORSGf
        X8tfglt0EAPo9xXXotE9KkbpMBawthVXUJIIJkzM/b/oNfXuajLvIyM/bSYc1tZ2Ew3U9P
        VQgpVCLtzzyuBISBjQDwfZIs9J2DOMZDMLQCp19WHCpSYtgCwUsS+7S991iQKLD+6XiiWp
        9Jv/CN9pKiqQVV7XetMNC2dpC8NWFe4DFzUSNS6K3a5M0EOamJ0vn2QM7fG7Z+yuXcVbxp
        rOBvErd0aO0MlTEC+7EToWmI6NYIzTDb01qbG0balEXrhrYmS9ndiFvFuuMFNw==
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
Subject: [PATCH v4 33/45] media: sun6i-csi: Introduce format match structure, list and helper
Date:   Fri, 15 Apr 2022 17:27:59 +0200
Message-Id: <20220415152811.636419-34-paul.kocialkowski@bootlin.com>
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

Introduce a list of mbus/pixel format combinations that need an exact
match between the two sides. This is the case when using raw input
configuration. The list will be used to replace the
sun6i_csi_is_format_supported combinatory helper.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 117 ++++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |   5 +
 2 files changed, 122 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 9ecfb3f35983..f4e12aca43e6 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -227,6 +227,123 @@ struct sun6i_csi_capture_format *sun6i_csi_capture_format_find(u32 pixelformat)
 	return NULL;
 }
 
+/* RAW formats need an exact match between pixel and mbus formats. */
+static const
+struct sun6i_csi_capture_format_match sun6i_csi_capture_format_matches[] = {
+	/* YUV420 */
+	{
+		.pixelformat	= V4L2_PIX_FMT_YUYV,
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_2X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_YUYV,
+		.mbus_code	= MEDIA_BUS_FMT_YUYV8_1X16,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_YVYU,
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_2X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_YVYU,
+		.mbus_code	= MEDIA_BUS_FMT_YVYU8_1X16,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_UYVY,
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_2X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_UYVY,
+		.mbus_code	= MEDIA_BUS_FMT_UYVY8_1X16,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_VYUY,
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_2X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_VYUY,
+		.mbus_code	= MEDIA_BUS_FMT_VYUY8_1X16,
+	},
+	/* RGB */
+	{
+		.pixelformat	= V4L2_PIX_FMT_RGB565,
+		.mbus_code	= MEDIA_BUS_FMT_RGB565_2X8_LE,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_RGB565X,
+		.mbus_code	= MEDIA_BUS_FMT_RGB565_2X8_BE,
+	},
+	/* Bayer */
+	{
+		.pixelformat	= V4L2_PIX_FMT_SBGGR8,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR8_1X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGBRG8,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG8_1X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGRBG8,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG8_1X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SRGGB8,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB8_1X8,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SBGGR10,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGBRG10,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG10_1X10,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGRBG10,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG10_1X10,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SRGGB10,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB10_1X10,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SBGGR12,
+		.mbus_code	= MEDIA_BUS_FMT_SBGGR12_1X12,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGBRG12,
+		.mbus_code	= MEDIA_BUS_FMT_SGBRG12_1X12,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SGRBG12,
+		.mbus_code	= MEDIA_BUS_FMT_SGRBG12_1X12,
+	},
+	{
+		.pixelformat	= V4L2_PIX_FMT_SRGGB12,
+		.mbus_code	= MEDIA_BUS_FMT_SRGGB12_1X12,
+	},
+	/* Compressed */
+	{
+		.pixelformat	= V4L2_PIX_FMT_JPEG,
+		.mbus_code	= MEDIA_BUS_FMT_JPEG_1X8,
+	},
+};
+
+static bool sun6i_csi_capture_format_match(u32 pixelformat, u32 mbus_code)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun6i_csi_capture_format_matches); i++) {
+		const struct sun6i_csi_capture_format_match *match =
+			&sun6i_csi_capture_format_matches[i];
+
+		if (match->pixelformat == pixelformat &&
+		    match->mbus_code == mbus_code)
+			return true;
+	}
+
+	return false;
+}
+
 /* Capture */
 
 static void sun6i_csi_capture_irq_enable(struct sun6i_csi_device *csi_dev)
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 4b1ff19edc2f..2605b16f091c 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -27,6 +27,11 @@ struct sun6i_csi_capture_format {
 	u32	hsize_len_factor;
 };
 
+struct sun6i_csi_capture_format_match {
+	u32	pixelformat;
+	u32	mbus_code;
+};
+
 #undef current
 struct sun6i_csi_capture_state {
 	struct list_head		queue;
-- 
2.35.2

