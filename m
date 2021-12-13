Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668C9472E05
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbhLMNwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:52:21 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:23851 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhLMNwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403540; x=1670939540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QFcZqhwV54wl82Sk8IHg25ljnl0Hvg//Cvz5aknbgrg=;
  b=b2G8P1WmSNBHLJrBixGfm2zMKtfS+hlh7UFMa8luI0E1FA5dXhPyGl1M
   bFDHu60n/Z1gJUWkQb0ypavwPaPYsg7MAhfnCSxLSHn8bSbx6qN+oIr8O
   rTFyGQL8Y0UHNSHuTeE9Nk/ByfNqoFXvxS0A2tG0LU9geK8VdqkyBKBOk
   WA1OHIO/RxzjX1zKGodatUkwpA07M3XD6Kg6/qeb5nNcSReYT1n54MrBD
   OvOHgPmh/O+RJaju5BXnUi8OAjmrTPWuMe6bQ0EKGHehsjzvjWOEvsIPw
   pongaANAC6A+NB471uBi8m4UBqWsI17X6Tsn/7awr/oPWW4LIgnZILnW/
   A==;
IronPort-SDR: K8zkbK7wl0bJt7lWbCrSvB0r4aFrddgOq/8/l3OXVvYVwXAz5NoBE4Qx16+HpX2xenNOg2tN6o
 kSHQtMUAPTtSlFp7mNCqmmnnJFU9/qdd4krhJY65yQwgvrLMxXDAZUQPcEWvVBA89UH9qSvVox
 4UwZ327HxO2zYaoNLTJaYFWkITHVnG7uXxNaxU/S27Aq9U0lOWzQciKYA8TrB/G0RcuSQ+OVtd
 mAd2GSEwxrpkC1WEresMCyGmAOaXVJeMZ4EcgdHtEfMa3nDxxkSdSS0RZ99sXbrq/fOWuU86Lg
 RcaqCqmdIAJddW9z64uptgsC
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="155269892"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:52:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:52:19 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:52:10 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 09/23] media: atmel: atmel-isc-base: report frame sizes as full supported range
Date:   Mon, 13 Dec 2021 15:49:26 +0200
Message-ID: <20211213134940.324266-10-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISC supports a full broad range of frame sizes.
Until now, the subdevice was queried for possible frame sizes and these
were reported to the user space.
However, the ISC should not care about which frame sizes the subdev supports,
as long as this frame size is supported.
Thus, report a continuous range from smallest frame size up to the max
resolution.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 22 +++++++++----------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 3389671fbfb9..bf638d201b29 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1076,14 +1076,12 @@ static int isc_enum_framesizes(struct file *file, void *fh,
 			       struct v4l2_frmsizeenum *fsize)
 {
 	struct isc_device *isc = video_drvdata(file);
-	struct v4l2_subdev_frame_size_enum fse = {
-		.code = isc->config.sd_format->mbus_code,
-		.index = fsize->index,
-		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
-	};
 	int ret = -EINVAL;
 	int i;
 
+	if (fsize->index)
+		return -EINVAL;
+
 	for (i = 0; i < isc->num_user_formats; i++)
 		if (isc->user_formats[i]->fourcc == fsize->pixel_format)
 			ret = 0;
@@ -1095,14 +1093,14 @@ static int isc_enum_framesizes(struct file *file, void *fh,
 	if (ret)
 		return ret;
 
-	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, enum_frame_size,
-			       NULL, &fse);
-	if (ret)
-		return ret;
+	fsize->type = V4L2_FRMSIZE_TYPE_CONTINUOUS;
 
-	fsize->type = V4L2_FRMSIZE_TYPE_DISCRETE;
-	fsize->discrete.width = fse.max_width;
-	fsize->discrete.height = fse.max_height;
+	fsize->stepwise.min_width = 16;
+	fsize->stepwise.max_width = isc->max_width;
+	fsize->stepwise.min_height = 16;
+	fsize->stepwise.max_height = isc->max_height;
+	fsize->stepwise.step_width = 1;
+	fsize->stepwise.step_height = 1;
 
 	return 0;
 }
-- 
2.25.1

