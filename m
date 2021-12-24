Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8EE47EA48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 02:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350790AbhLXB3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 20:29:21 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:24106 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350782AbhLXB3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 20:29:17 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BO1M74U007689;
        Fri, 24 Dec 2021 09:22:07 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 24 Dec
 2021 09:27:37 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <hverkuil-cisco@xs4all.nl>, <sakari.ailus@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <eajames@linux.ibm.com>,
        <mchehab@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-media@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/4] media: v4l: Add definition for the Aspeed JPEG format
Date:   Fri, 24 Dec 2021 09:27:35 +0800
Message-ID: <20211224012738.1551-2-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224012738.1551-1-jammy_huang@aspeedtech.com>
References: <20211224012738.1551-1-jammy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BO1M74U007689
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces support for the Aspeed JPEG format, where the new frame
can refer to previous frame to reduce the amount of compressed data. The
concept is similar to I/P frame of video compression. It will compare the
new frame with previous one to decide which macroblock's data is
changed, and only the changed macroblocks will be compressed.

This Aspeed JPEG format is used by the video engine on Aspeed platforms,
which is generally adapted for remote KVM.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
v8:
  - Add decoder information for aspeed-jpeg
v7:
  - Add more information for aspeed-jpeg
v6:
  - Update description for new format, aspeed-jpeg, in Documentation.
v5:
  - no update
v4:
  - new
---
 .../media/uapi/v4l/pixfmt-reserved.rst          | 17 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c            |  1 +
 include/uapi/linux/videodev2.h                  |  1 +
 3 files changed, 19 insertions(+)

diff --git a/Documentation/media/uapi/v4l/pixfmt-reserved.rst b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
index b2cd155e691b..1d0dc8d86ed7 100644
--- a/Documentation/media/uapi/v4l/pixfmt-reserved.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
@@ -264,6 +264,23 @@ please make a proposal on the linux-media mailing list.
 	of tiles, resulting in 32-aligned resolutions for the luminance plane
 	and 16-aligned resolutions for the chrominance plane (with 2x2
 	subsampling).
+    * .. _V4L2-PIX-FMT-AJPG:
+
+      - ``V4L2_PIX_FMT_AJPG``
+      - 'AJPG'
+      - ASPEED JPEG format used by the aspeed-video driver on Aspeed platforms,
+        which is generally adapted for remote KVM.
+        On each frame compression, I will compare the new frame with previous
+        one to decide which macroblock's data is changed, and only the changed
+        macroblocks will be compressed.
+
+        The implementation is based on AST2600 A3 datasheet, revision 0.9, which
+        is not publicly available. Or you can reference Video stream data format
+        – ASPEED mode compression of SDK_User_Guide which available on
+        AspeedTech-BMC/openbmc/releases.
+
+        Decoder's implementation can be found here,
+        `https://github.com/AspeedTech-BMC/aspeed_codec/ <https://github.com/AspeedTech-BMC/aspeed_codec/>`__
 
 .. tabularcolumns:: |p{6.6cm}|p{2.2cm}|p{8.7cm}|
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 24db33f803c0..00dde01d2f97 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1378,6 +1378,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
 		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
 		case V4L2_PIX_FMT_SUNXI_TILED_NV12: descr = "Sunxi Tiled NV12 Format"; break;
+		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3210b3c82a4a..994eb6155ea9 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -726,6 +726,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
 #define V4L2_PIX_FMT_SUNXI_TILED_NV12 v4l2_fourcc('S', 'T', '1', '2') /* Sunxi Tiled NV12 Format */
 #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
+#define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspeed JPEG */
 
 /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.25.1

