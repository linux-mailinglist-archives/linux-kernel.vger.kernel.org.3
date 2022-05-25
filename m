Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA535343DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344167AbiEYTJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbiEYTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:06:59 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593011A23;
        Wed, 25 May 2022 12:06:52 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 508591C0011;
        Wed, 25 May 2022 19:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653505611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lJNCHyvGrV4lGdykQArwfZ5B/hBTOtT5/D5imDx0XT4=;
        b=P9yAN4Gpv9ojkd3cZpQLpO7VKcszZnmriC8BmafSvNcrPE7aIaoRZDX85p2WkZX+U0NDB0
        krz3txZA3abWu5gSUrqzUKXuBEbz/2fXjdWi5CsDexjD9xv1m226kfjR/46Ih4Vr7Cuhju
        jpMdGYdFgH8VDLoQIgUJU8k+GmK+ZFpT+kRcjd4W7/rKb0Z+QGCU7qeCmdR2XzKngWsEuE
        gwqGJ1U/BWPiECdyhd+czLYSysd7oG1LQmBrZ7uy+3tdGJ/77KdiFkC8q0d+9D5JeJDqSY
        3lgp/WPmUhX6LSQWGHXPPAaPC2y/rpX7Lpg+lt+NjXDuV6uGSy4i+NdRS9hDQg==
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
Subject: [PATCH v5 21/44] media: sun6i-csi: Add dimensions and format helpers to capture
Date:   Wed, 25 May 2022 21:05:54 +0200
Message-Id: <20220525190617.696344-22-paul.kocialkowski@bootlin.com>
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

Define and export useful helpers to access dimensions and pixel format.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 19 +++++++++++++++++++
 .../sunxi/sun6i-csi/sun6i_csi_capture.h       |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index cdf8b4890593..abcf913364b2 100644
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
2.36.1

