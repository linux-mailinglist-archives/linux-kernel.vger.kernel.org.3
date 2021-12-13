Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAD8472E01
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbhLMNwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:52:12 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:28919 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhLMNwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403530; x=1670939530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pCcil2Lhx+bCuXSs5PAUAjwV2486l6SIQeWMh7Zqkw=;
  b=JMoyqbzAjJaOZZJFuAx85ebDiEWDH+vbvLdsjVl0wczvjbWivqxpAzR/
   kJvUNc/iw+b/ZKttpdqXuFbs0iBuneTiq7/VJXfbEREEkU/E0e+BflKo/
   FKnCNkCksuNZhILp6nh+UrgbkMoTYed8/ROBv5Pr5kfWCmxRpOMMAX3fx
   u6U8hnqvqxmcTPMBO6TOIfEkNteH6uOVSpKkFt6q8JifUjAWYZ9GbMoJt
   DOWB9M0FwUJw0s2FLF0eA0DkZH8rKWwpPAkeHUs4OEY4oUxXv+UWnbEKe
   G3VNZ64Q9/W/jzBcqlyL0q9MhElLz2eqPZpPa5Ll6b4HszUXt3KEK+9ou
   Q==;
IronPort-SDR: 11wSvwnbJBu/bzGhSCoDzrngCGPkMj16H7bTOrW7YJx+/lykN+N3t8lLMUhzdP7aI2C24Bibgq
 Zl06bNE5hwTxKoiKePB+fzWMbc6ipHDhMofibdewE5m4P+5y260jFjOYX37KLHoOto+QqqWZ8g
 IWYUAvShASO2t4WgiAgVeIgVbjLt5vM3NTsWig2lGA4pu9UL32vLxD3/h6ydWJPuA/GhrHQ9PL
 ec+ntfm+PgnjNDR4GiuxKjrxxo9Oyrs7YkDhgqxYYIS3Q1hIM1qXMFFZ4ysfuMY7Mt3nGsh1xh
 ZrQ4fTU4p0E7MjEwqwKskG0A
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="147032558"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:52:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:52:09 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:51:50 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 08/23] media: atmel: atmel-isc-base: remove frameintervals VIDIOC
Date:   Mon, 13 Dec 2021 15:49:25 +0200
Message-ID: <20211213134940.324266-9-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIDIOC_ENUM_FRAMEINTERVALS is not recommended for a top video driver.
The frame rate is defined by the sensor subdevice, thus it can be queried
directly by anyone interested in the frame intervals.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 37 -------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index e6c9071c04f0..3389671fbfb9 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1107,42 +1107,6 @@ static int isc_enum_framesizes(struct file *file, void *fh,
 	return 0;
 }
 
-static int isc_enum_frameintervals(struct file *file, void *fh,
-				    struct v4l2_frmivalenum *fival)
-{
-	struct isc_device *isc = video_drvdata(file);
-	struct v4l2_subdev_frame_interval_enum fie = {
-		.code = isc->config.sd_format->mbus_code,
-		.index = fival->index,
-		.width = fival->width,
-		.height = fival->height,
-		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
-	};
-	int ret = -EINVAL;
-	unsigned int i;
-
-	for (i = 0; i < isc->num_user_formats; i++)
-		if (isc->user_formats[i]->fourcc == fival->pixel_format)
-			ret = 0;
-
-	for (i = 0; i < isc->controller_formats_size; i++)
-		if (isc->controller_formats[i].fourcc == fival->pixel_format)
-			ret = 0;
-
-	if (ret)
-		return ret;
-
-	ret = v4l2_subdev_call(isc->current_subdev->sd, pad,
-			       enum_frame_interval, NULL, &fie);
-	if (ret)
-		return ret;
-
-	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
-	fival->discrete = fie.interval;
-
-	return 0;
-}
-
 static const struct v4l2_ioctl_ops isc_ioctl_ops = {
 	.vidioc_querycap		= isc_querycap,
 	.vidioc_enum_fmt_vid_cap	= isc_enum_fmt_vid_cap,
@@ -1167,7 +1131,6 @@ static const struct v4l2_ioctl_ops isc_ioctl_ops = {
 	.vidioc_g_parm			= isc_g_parm,
 	.vidioc_s_parm			= isc_s_parm,
 	.vidioc_enum_framesizes		= isc_enum_framesizes,
-	.vidioc_enum_frameintervals	= isc_enum_frameintervals,
 
 	.vidioc_log_status		= v4l2_ctrl_log_status,
 	.vidioc_subscribe_event		= v4l2_ctrl_subscribe_event,
-- 
2.25.1

