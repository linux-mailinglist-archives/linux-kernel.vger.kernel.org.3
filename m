Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E7472E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238233AbhLMNxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:53:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:23904 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhLMNxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403581; x=1670939581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8q+Wras26brxM0VbhR3bV7u/0zZKlKAAorzxCJq7c0=;
  b=UqNgc1rnpoRLaaGHpqQFIJn70ayjokFp08vaNUudQVOQUkwWq8OmONYb
   U9cbBnLn8+cuYHHWTH/0P0hDcqCwK/PuIaJJs6hL0R9X/PpNX3DwfbWq3
   e/NSjsf5QIO5kL/lhppU8RrCFkOC0MYMkmwPjgUTCIdKjKvSQTt47GsuS
   qTBy887UWf/91ZbDj5NTRvPdRwgbFzvHdQJf8E3/do0jqLq4WUXHtzbeh
   ML0jR8iWx3GZK0j0DAh9bqZ69qMeyyya0i/+o+EW7+dyMGdQKkg2XDMRI
   eFBbWT11ijPHkDKrPQl1N8584lPv3nlg8ESDEfF0Vxt+mDdDq7npxbMdN
   A==;
IronPort-SDR: fstzPoPPRs7cFYuN2U12wVtbk8seJUW2OsRmWgzhilaJ4j8gSPrUUzZbIr01DBEckhlQdze/47
 3ehtb5UmHdlchEp1omYJEP3Nxonr4CI1zCOUoXeJvwRT6fGSTiNOs3pSMDUHbeb1lUzKDab0b3
 7dOvix66+4bpYBwuGAW9g9lwOXw1HKDFlbJh3q7kLp6dnAt2ixkLt2qCzEfL6tZyFMLOIcEeHT
 fUoe8dVlErU/z6B2bzRbar8wIh8TwLPrRH722E4U9CBYI894ZSNJX1Tm30QKvAMN3MvquMJ+uO
 0RG1jce60xNQg3rLscQHMoWK
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="155269943"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:53:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:53:00 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:52:31 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 11/23] media: atmel: atmel-isc-base: fix bytesperline value for planar formats
Date:   Mon, 13 Dec 2021 15:49:28 +0200
Message-ID: <20211213134940.324266-12-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bytesperline field of the pixfmt should be only for the first plane
in case of planar formats like YUV420 or YUV422.
The bytesperline is used by the driver to compute the framesize.
We have to report a different bpp (bytes per pixel) to v4l2 in bytesperline
than the actual bpp.
For example for YUV420, the real bpp is 12, but the first plane has only
8 bpp. Thus we report a bytesperline 8*width instead of 12*width.
However, for real framezise we have to compute 12*width*height.
Hence added a new variable to hold this information and to correctly
compute the frame size.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 19 +++++++++++++++++--
 drivers/media/platform/atmel/atmel-isc.h      |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 2cb8446ff90c..d0542b97a391 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -654,6 +654,7 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED8;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 8;
+		isc->try_config.bpp_v4l2 = 8;
 		break;
 	case V4L2_PIX_FMT_SBGGR10:
 	case V4L2_PIX_FMT_SGBRG10:
@@ -663,6 +664,7 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
 		break;
 	case V4L2_PIX_FMT_SBGGR12:
 	case V4L2_PIX_FMT_SGBRG12:
@@ -672,24 +674,28 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
 		break;
 	case V4L2_PIX_FMT_RGB565:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_RGB565;
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
 		break;
 	case V4L2_PIX_FMT_ARGB444:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_ARGB444;
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
 		break;
 	case V4L2_PIX_FMT_ARGB555:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_ARGB555;
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
 		break;
 	case V4L2_PIX_FMT_ABGR32:
 	case V4L2_PIX_FMT_XBGR32:
@@ -697,42 +703,49 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 32;
+		isc->try_config.bpp_v4l2 = 32;
 		break;
 	case V4L2_PIX_FMT_YUV420:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YYCC;
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_YC420P;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PLANAR;
 		isc->try_config.bpp = 12;
+		isc->try_config.bpp_v4l2 = 8; /* only first plane */
 		break;
 	case V4L2_PIX_FMT_YUV422P:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YYCC;
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_YC422P;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PLANAR;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 8; /* only first plane */
 		break;
 	case V4L2_PIX_FMT_YUYV:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YCYC | ISC_RLP_CFG_YMODE_YUYV;
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
 		break;
 	case V4L2_PIX_FMT_UYVY:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YCYC | ISC_RLP_CFG_YMODE_UYVY;
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
 		break;
 	case V4L2_PIX_FMT_VYUY:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_YCYC | ISC_RLP_CFG_YMODE_VYUY;
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED32;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
 		break;
 	case V4L2_PIX_FMT_GREY:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DATY8;
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED8;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 8;
+		isc->try_config.bpp_v4l2 = 8;
 		break;
 	case V4L2_PIX_FMT_Y16:
 		isc->try_config.rlp_cfg_mode = ISC_RLP_CFG_MODE_DATY10 | ISC_RLP_CFG_LSH;
@@ -742,6 +755,7 @@ static int isc_try_configure_rlp_dma(struct isc_device *isc, bool direct_dump)
 		isc->try_config.dcfg_imode = ISC_DCFG_IMODE_PACKED16;
 		isc->try_config.dctrl_dview = ISC_DCTRL_DVIEW_PACKED;
 		isc->try_config.bpp = 16;
+		isc->try_config.bpp_v4l2 = 16;
 		break;
 	default:
 		return -EINVAL;
@@ -990,8 +1004,9 @@ static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
 		pixfmt->height = isc->max_height;
 
 	pixfmt->field = V4L2_FIELD_NONE;
-	pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp) >> 3;
-	pixfmt->sizeimage = pixfmt->bytesperline * pixfmt->height;
+	pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp_v4l2) >> 3;
+	pixfmt->sizeimage = ((pixfmt->width * isc->try_config.bpp) >> 3) *
+			     pixfmt->height;
 
 	if (code)
 		*code = mbus_code;
diff --git a/drivers/media/platform/atmel/atmel-isc.h b/drivers/media/platform/atmel/atmel-isc.h
index 32448ccfc636..07fa6dbf8460 100644
--- a/drivers/media/platform/atmel/atmel-isc.h
+++ b/drivers/media/platform/atmel/atmel-isc.h
@@ -102,6 +102,9 @@ struct isc_format {
 			configuration.
  * @fourcc:		Fourcc code for this format.
  * @bpp:		Bytes per pixel in the current format.
+ * @bpp_v4l2:		Bytes per pixel in the current format, for v4l2.
+			This differs from 'bpp' in the sense that in planar
+			formats, it refers only to the first plane.
  * @rlp_cfg_mode:	Configuration of the RLP (rounding, limiting packaging)
  * @dcfg_imode:		Configuration of the input of the DMA module
  * @dctrl_dview:	Configuration of the output of the DMA module
@@ -112,6 +115,7 @@ struct fmt_config {
 
 	u32			fourcc;
 	u8			bpp;
+	u8			bpp_v4l2;
 
 	u32			rlp_cfg_mode;
 	u32			dcfg_imode;
-- 
2.25.1

