Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86DE4D63AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349660AbiCKOhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349533AbiCKOhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:37:31 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E031C947D;
        Fri, 11 Mar 2022 06:36:21 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0BE3124000C;
        Fri, 11 Mar 2022 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647009380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MKmJo4pe35t5EXt9jJlqCaZhlnGKEm842sgyp4ZOkT0=;
        b=RFYYRITvxOczB2KRHmonjhCranHCDOSKzZBA8/36CLahhSsSZFtgaC9APsBo68fI0DFhmw
        MjU02pPnjGKeMrqph8BYReSS10yewrlkl2x47f5ufq4dii0uRmbo+xPr69jU6XHPnm6lu5
        +t7tOry3rM4gS1GwPzv7DjuykVb76f94iGqrlFPnmxgeyIsiyQ8TjNNXz9RUYpaUfUjcDV
        tj9fRyC9kkAnIk/MS6OZPhPmIrb5irB6AYJtnF9cqMZBtW/JQ3cCPnJzH+0I8c/arpBHw2
        0m1A3XUiRbwT487pD7ic6F0CFvtGV245hzYkOSXo8kV8ecXhVDkOGm85LCAhCQ==
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
Subject: [PATCH v3 20/46] media: sun6i-csi: Add dimensions and format helpers to capture
Date:   Fri, 11 Mar 2022 15:35:06 +0100
Message-Id: <20220311143532.265091-21-paul.kocialkowski@bootlin.com>
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
2.35.1

