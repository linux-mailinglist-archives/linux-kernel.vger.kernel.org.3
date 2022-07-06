Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B25691C6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiGFS3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiGFS3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:29:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0CADD;
        Wed,  6 Jul 2022 11:29:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so12079794wmp.3;
        Wed, 06 Jul 2022 11:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bRAz+V8z3pbOVqJIvMC22fUwjtIMw6EhAN0Gm4k1FY=;
        b=miWWCHqgX9+cNJIAA+hGwGKjjHXe/e2nn6A2ApevKTQP6jpyPOAKTDSlC04B1S3kuR
         js93xv19t9mp12q+k788vFTDsTQR8OSaA8DdvXG3O/wdYyV8NbYaIHDvkD/NPPBdA9eQ
         P7tFKMaW7yQoHMRDI5+QDw2wrLDk9j3+A1VwP7HClPJlq0l6lbffuBaeI3H6c/KE79V1
         lURYEjsLFa+WHjJAOmc68m1jMhgngavWp3baL8e4FtkxkzTYFvwa1pL+k8C5y2ia7E5r
         XKGgeLNp1LaLzaN9v9rBAyPkxuhBmkyNL1GwtqlB/3P7cQRMjWvFWNU5cVuMjsEndAkQ
         ZQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bRAz+V8z3pbOVqJIvMC22fUwjtIMw6EhAN0Gm4k1FY=;
        b=yLS4p/w213pGuTAWlbdu3GM6zMGA+NBObE9E6cG7bBULH6Wf4oGh5RAq3RRfQEfQf0
         t2Hr+3D662qj/P7D9VD+tIyL4hJ7i/N3PpYkfWJdRHMT+TZff0nYf1JgtjVLV5sFQoj7
         zRlfKHaqK4uoNw9hsFL8hAg92VdGRNI2N05T4pr25sCHr88f/4mpkeTKmi4JCS664rgU
         /RvkZ0p6rVh5WAJ+Rklq6TX/t8JGPkgTRgvIa60XGzFgcrU4/y0d4Tbf9XsaaYkYD/b8
         qERpFpO9A2HD1MVeZwijN4AXBKap5snj36RXjIMl9RwYXha+YgCj3z/TCzQwwwoIty/2
         uDug==
X-Gm-Message-State: AJIora/AJcaY63Xx7y5TjEQjzhQCgs7AzsZCUs5GJ7l430TBmjB1yGOv
        SWdCoAbqB1dZZHKgJGs9S1s=
X-Google-Smtp-Source: AGRyM1vCgYRYlyrNQ8s7hMV5pQYcLqocChJlpFqO05hUHknwmryQnbY68ISabmphPDEBZeHQFkzGrQ==
X-Received: by 2002:a05:600c:a07:b0:39e:da6e:fc49 with SMTP id z7-20020a05600c0a0700b0039eda6efc49mr42986943wmp.143.1657132152988;
        Wed, 06 Jul 2022 11:29:12 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm5142406wru.28.2022.07.06.11.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:29:12 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v3 1/7] media: Add P010 tiled format
Date:   Wed,  6 Jul 2022 20:28:55 +0200
Message-Id: <20220706182901.78949-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220706182901.78949-1-jernej.skrabec@gmail.com>
References: <20220706182901.78949-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Add P010 tiled format

Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
[rebased, updated pixel format name and added description]
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst            | 18 +++++++++++++++---
 drivers/media/v4l2-core/v4l2-common.c          |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c           |  1 +
 include/uapi/linux/videodev2.h                 |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index a900ff66911a..faba259a2b92 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -116,6 +116,13 @@ All components are stored with the same number of bits per component.
       - Cb, Cr
       - Yes
       - Linear
+    * - V4L2_PIX_FMT_P010_4L4
+      - 'T010'
+      - 10
+      - 4:2:0
+      - Cb, Cr
+      - Yes
+      - 4x4 tiles
     * - V4L2_PIX_FMT_NV16
       - 'NV16'
       - 8
@@ -528,11 +535,12 @@ number of lines as the luma plane.
       - Cr\ :sub:`33`
 
 .. _V4L2_PIX_FMT_P010:
+.. _V4L2-PIX-FMT-P010-4L4:
 
-P010
-----
+P010 and tiled P010
+-------------------
 
-Like NV12 with 10 bits per component, expanded to 16 bits.
+P010 is like NV12 with 10 bits per component, expanded to 16 bits.
 Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian order.
 
 .. flat-table:: Sample 4x4 P010 Image
@@ -570,6 +578,10 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
       - Cb\ :sub:`11`
       - Cr\ :sub:`11`
 
+``V4L2_PIX_FMT_P010_4L4`` stores pixels in 4x4 tiles, and stores tiles linearly
+in memory. The line stride must be aligned to multiple of 8 and image height to
+a multiple of 4. The layouts of the luma and chroma planes are identical.
+
 .. raw:: latex
 
     \endgroup
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 1e38ad8906a2..e0fbe6ba4b6c 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -278,6 +278,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 
 		/* Tiled YUV formats */
 		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
+		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 
 		/* YUV planar formats, non contiguous variant */
 		{ .format = V4L2_PIX_FMT_YUV420M, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 3, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index e2526701294e..7aa3af389b51 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1310,6 +1310,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
+	case V4L2_PIX_FMT_P010_4L4:	descr = "10-bit Y/CbCr 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M:	descr = "Y/CbCr 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_NV21M:	descr = "Y/CrCb 4:2:0 (N-C)"; break;
 	case V4L2_PIX_FMT_NV16M:	descr = "Y/CbCr 4:2:2 (N-C)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 5311ac4fde35..32bedeb04152 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -630,6 +630,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_NV12_4L4 v4l2_fourcc('V', 'T', '1', '2')   /* 12  Y/CbCr 4:2:0  4x4 tiles */
 #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 16x16 tiles */
 #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12  Y/CbCr 4:2:0 32x32 tiles */
+#define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/CbCr 4:2:0 10-bit 4x4 macroblocks */
 
 /* Tiled YUV formats, non contiguous planes */
 #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/CbCr 4:2:0 64x32 tiles */
-- 
2.37.0

