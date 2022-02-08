Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8844ADDA0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382272AbiBHPu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382131AbiBHPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:50:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06E6C06157B;
        Tue,  8 Feb 2022 07:50:40 -0800 (PST)
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:b99c:2ebe:5dcf:6513])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B13DA67;
        Tue,  8 Feb 2022 16:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644335435;
        bh=Q51HASflv5trjKC3v8KUbHn1jl34YRRs62TMwWpat+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWmqZm63XzNE1rUrqYXR0CTQIaTyR9aSK4ABPe79ZzeBUJYa9Uy62wFHVCjfZOGZ8
         CPOqO4k9SoOkmCpajFa1FIXEAtwlleqMf7/6/6Jff9zD7jwCdoRmw1K2EtV5xA5lkc
         ARN2nC5fnHTuZw4dAs1H4NfN681ASjjFf1AafAk4=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com
Subject: [PATCH v5 02/11] media: v4l: Add V4L2-PIX-FMT-Y14P format
Date:   Tue,  8 Feb 2022 16:50:18 +0100
Message-Id: <20220208155027.891055-3-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index d37ce6027095..c64485b03d27 100644
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
index 12862e0803bf..c321cbd9de54 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1267,6 +1267,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
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

