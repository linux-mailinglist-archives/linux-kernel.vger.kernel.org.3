Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328704A8AEE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353518AbiBCRwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:52:47 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59002 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353191AbiBCRup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:45 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:5173:4d3f:4ddc:2012])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 900911447;
        Thu,  3 Feb 2022 18:50:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643910627;
        bh=wgv85acUrshpXd7kh0STF4RCGXeDk6NtpmEK6eEeSyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfvXOHfRe67ExkkCa7Mi8eVOUefcmVamQg9emxP/F0gipcxtB25ke7RTfQHely22h
         8x3tXB7xbVbUDe0OI4Lu9YSKF0+7w6Exji3DSpp15VD1f57AZoCWirzjxuo0u/XQiQ
         KjbWj72REes4Vh1NG6xYmO0OEM0WFKU+mv1uJUtQ=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [RFC PATCH v4 07/12] media: imx219: Rename mbus codes array
Date:   Thu,  3 Feb 2022 18:50:04 +0100
Message-Id: <20220203175009.558868-8-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx219 is using the name codes[] for the mbus format which is not
easy to read and know what it means. Change it to imx219_mbus_formats.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 drivers/media/i2c/imx219.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index e10af3f74b38..74dba5e61201 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -429,7 +429,7 @@ static const char * const imx219_supply_name[] = {
  * - v flip
  * - h&v flips
  */
-static const u32 codes[] = {
+static const u32 imx219_mbus_formats[] = {
 	MEDIA_BUS_FMT_SRGGB10_1X10,
 	MEDIA_BUS_FMT_SGRBG10_1X10,
 	MEDIA_BUS_FMT_SGBRG10_1X10,
@@ -655,17 +655,17 @@ static u32 imx219_get_format_code(struct imx219 *imx219, u32 code)
 
 	lockdep_assert_held(&imx219->mutex);
 
-	for (i = 0; i < ARRAY_SIZE(codes); i++)
-		if (codes[i] == code)
+	for (i = 0; i < ARRAY_SIZE(imx219_mbus_formats); i++)
+		if (imx219_mbus_formats[i] == code)
 			break;
 
-	if (i >= ARRAY_SIZE(codes))
+	if (i >= ARRAY_SIZE(imx219_mbus_formats))
 		i = 0;
 
 	i = (i & ~3) | (imx219->vflip->val ? 2 : 0) |
 	    (imx219->hflip->val ? 1 : 0);
 
-	return codes[i];
+	return imx219_mbus_formats[i];
 }
 
 static void imx219_set_default_format(struct imx219 *imx219)
@@ -808,11 +808,11 @@ static int imx219_enum_mbus_code(struct v4l2_subdev *sd,
 {
 	struct imx219 *imx219 = to_imx219(sd);
 
-	if (code->index >= (ARRAY_SIZE(codes) / 4))
+	if (code->index >= (ARRAY_SIZE(imx219_mbus_formats) / 4))
 		return -EINVAL;
 
 	mutex_lock(&imx219->mutex);
-	code->code = imx219_get_format_code(imx219, codes[code->index * 4]);
+	code->code = imx219_get_format_code(imx219, imx219_mbus_formats[code->index * 4]);
 	mutex_unlock(&imx219->mutex);
 
 	return 0;
@@ -908,14 +908,14 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
 
 	mutex_lock(&imx219->mutex);
 
-	for (i = 0; i < ARRAY_SIZE(codes); i++)
-		if (codes[i] == fmt->format.code)
+	for (i = 0; i < ARRAY_SIZE(imx219_mbus_formats); i++)
+		if (imx219_mbus_formats[i] == fmt->format.code)
 			break;
-	if (i >= ARRAY_SIZE(codes))
+	if (i >= ARRAY_SIZE(imx219_mbus_formats))
 		i = 0;
 
 	/* Bayer order varies with flips */
-	fmt->format.code = imx219_get_format_code(imx219, codes[i]);
+	fmt->format.code = imx219_get_format_code(imx219, imx219_mbus_formats[i]);
 
 	mode = v4l2_find_nearest_size(supported_modes,
 				      ARRAY_SIZE(supported_modes),
-- 
2.32.0

