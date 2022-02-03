Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDB34A8AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353165AbiBCRuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:50:39 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59002 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353075AbiBCRu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:27 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:5173:4d3f:4ddc:2012])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2077FE04;
        Thu,  3 Feb 2022 18:50:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643910625;
        bh=pCOndSKzH93s/QrZRjfnrn8XUqpMgone11bPElqdn54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RO5kQ8kPwuXiVxp4p7zB/iSeYyjVRWalZgEA0AMBDpNHQluBADLqqZm4QvcIGiYm5
         0TbENvm94bMaKFnBUnmVPF/HW5KM1sgORltEXuwKuKBrLguGYy9OZc0TxEibPI1ISK
         i5VAxoFJQHKoof4Vii9ImymHk2NxaEIsk7fAaDKI=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [RFC PATCH v4 02/12] media: v4l: Add V4L2-PIX-FMT-Y14P format
Date:   Thu,  3 Feb 2022 18:49:59 +0100
Message-Id: <20220203175009.558868-3-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a packed grey-scale image format with a depth of 14 bits per
pixel. Every four consecutive samples are packed into seven bytes. Each
of the first four bytes contain the eight high order bits of the pixels,
and the three following bytes contains the six least significants bits
of each pixel, in the same order.

As the other formats only needed 5 bytes before, append two bytes in the
documentation array.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../media/v4l/pixfmt-yuv-luma.rst             | 33 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 3 files changed, 35 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
index 2d9d588eedcd..2f38b888ca19 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-luma.rst
@@ -36,6 +36,8 @@ are often referred to as greyscale formats.
       - Byte 2
       - Byte 3
       - Byte 4
+      - Byte 5
+      - Byte 6
 
     * .. _V4L2-PIX-FMT-GREY:
 
@@ -47,6 +49,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y10:
 
@@ -58,6 +62,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y10BPACK:
 
@@ -69,6 +75,8 @@ are often referred to as greyscale formats.
       - Y'\ :sub:`1`\ [3:0] Y'\ :sub:`2`\ [9:6]
       - Y'\ :sub:`2`\ [5:0] Y'\ :sub:`3`\ [9:8]
       - Y'\ :sub:`3`\ [7:0]
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y10P:
 
@@ -80,6 +88,8 @@ are often referred to as greyscale formats.
       - Y'\ :sub:`2`\ [9:2]
       - Y'\ :sub:`3`\ [9:2]
       - Y'\ :sub:`3`\ [1:0] Y'\ :sub:`2`\ [1:0] Y'\ :sub:`1`\ [1:0] Y'\ :sub:`0`\ [1:0]
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y12:
 
@@ -91,6 +101,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y12P:
 
@@ -102,6 +114,8 @@ are often referred to as greyscale formats.
       - Y'\ :sub:`1`\ [3:0] Y'\ :sub:`0`\ [3:0]
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y14:
 
@@ -113,6 +127,21 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
+
+    * .. _V4L2-PIX-FMT-Y14P:
+
+      - ``V4L2_PIX_FMT_Y14P``
+      - 'Y14P'
+
+      - Y'\ :sub:`0`\ [13:6]
+      - Y'\ :sub:`1`\ [13:6]
+      - Y'\ :sub:`2`\ [13:6]
+      - Y'\ :sub:`3`\ [13:6]
+      - Y'\ :sub:`1`\ [1:0] Y'\ :sub:`0`\ [5:0]
+      - Y'\ :sub:`2`\ [3:0] Y'\ :sub:`1`\ [5:2]
+      - Y'\ :sub:`3`\ [5:0] Y'\ :sub:`2`\ [5:4]
 
     * .. _V4L2-PIX-FMT-Y16:
 
@@ -124,6 +153,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
     * .. _V4L2-PIX-FMT-Y16-BE:
 
@@ -135,6 +166,8 @@ are often referred to as greyscale formats.
       - ...
       - ...
       - ...
+      - ...
+      - ...
 
 .. raw:: latex
 
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 64a72a6b2132..131105e8afac 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1265,6 +1265,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_Y10BPACK:	descr = "10-bit Greyscale (Packed)"; break;
 	case V4L2_PIX_FMT_Y10P:		descr = "10-bit Greyscale (MIPI Packed)"; break;
 	case V4L2_PIX_FMT_Y12P:		descr = "12-bit Greyscale (MIPI Packed)"; break;
+	case V4L2_PIX_FMT_Y14P:		descr = "14-bit Greyscale (MIPI Packed)"; break;
 	case V4L2_PIX_FMT_Y8I:		descr = "Interleaved 8-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Y12I:		descr = "Interleaved 12-bit Greyscale"; break;
 	case V4L2_PIX_FMT_Z16:		descr = "16-bit Depth"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index bef488205fea..18611289217f 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -570,6 +570,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Y10BPACK    v4l2_fourcc('Y', '1', '0', 'B') /* 10  Greyscale bit-packed */
 #define V4L2_PIX_FMT_Y10P    v4l2_fourcc('Y', '1', '0', 'P') /* 10  Greyscale, MIPI RAW10 packed */
 #define V4L2_PIX_FMT_Y12P    v4l2_fourcc('Y', '1', '2', 'P') /* 12  Greyscale, MIPI RAW12 packed */
+#define V4L2_PIX_FMT_Y14P    v4l2_fourcc('Y', '1', '4', 'P') /* 14  Greyscale, MIPI RAW14 packed */
 
 /* Palette formats */
 #define V4L2_PIX_FMT_PAL8    v4l2_fourcc('P', 'A', 'L', '8') /*  8  8-bit palette */
-- 
2.32.0

