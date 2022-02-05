Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EBE4AAB97
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381797AbiBES5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:57:22 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:41599 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381322AbiBESzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:55:39 -0500
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C64F524000F;
        Sat,  5 Feb 2022 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644087338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//Qc7XjLYxE3yQkQCiZCEdHx9uQtYT28JsyXBc9nHFY=;
        b=K7yx2LuUd3NG3rFwQWkeBbBjXRbtMwnQhMK4T+S49OsmWavbuyf6JYPe7BBFn0N4635MLr
        mD2mOYhaPMTaejD86sdHqZhJz0r6dO3asmE5Rhq11Ilv9S2mGIJLklrOMxvSVfg3nBl1+W
        I0iNQQKq/FOLz/5R06OpLG13WjqW7+ew5H3xqgmoGwIVzzYeOoMLr0OtMlqEVeyRC0JHaZ
        D4b0mC2uMBc5XyUNHayd/n+cXlQ3Mjjwfojwsb44h3oWSUEINqoobijoRrV/f/It7GBL82
        6vWoQs2D9TENYPX+n+B44XOfYuzHL35licCcLwTOas0X+njp3WMK0ULxQP/o/g==
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
Subject: [PATCH v2 34/66] media: sun6i-csi: Add dimensions and format helpers to capture
Date:   Sat,  5 Feb 2022 19:53:57 +0100
Message-Id: <20220205185429.2278860-35-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define and export useful helpers to access dimensions and pixel format.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 19 +++++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index bcbb4ffbb517..7b8556a25c61 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -25,6 +25,25 @@
 
 /* Helpers */
 
+void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
+				  unsigned int *width, unsigned int *height)
+{
+	if (width)
+		*width = csi_dev->capture.format.fmt.pix.width;
+	if (height)
+		*height = csi_dev->capture.format.fmt.pix.height;
+}
+
+void sun6i_csi_capture_format(struct sun6i_csi_device *csi_dev,
+			      u32 *pixelformat, u32 *field)
+{
+	if (pixelformat)
+		*pixelformat = csi_dev->capture.format.fmt.pix.pixelformat;
+
+	if (field)
+		*field = csi_dev->capture.format.fmt.pix.field;
+}
+
 static struct v4l2_subdev *
 sun6i_csi_capture_remote_subdev(struct sun6i_csi_capture *capture, u32 *pad)
 {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
index 7fa66a2af5ec..935f35b7049a 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
@@ -37,6 +37,11 @@ struct sun6i_csi_capture {
 	u32				mbus_code;
 };
 
+void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
+				  unsigned int *width, unsigned int *height);
+void sun6i_csi_capture_format(struct sun6i_csi_device *csi_dev,
+			      u32 *pixelformat, u32 *field);
+
 void sun6i_csi_capture_sync(struct sun6i_csi_device *csi_dev);
 void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev);
 
-- 
2.34.1

