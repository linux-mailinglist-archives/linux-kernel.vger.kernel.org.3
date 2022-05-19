Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB03452CC58
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiESHCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiESHCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:02:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A391BC5B;
        Thu, 19 May 2022 00:02:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 642441F45629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652943719;
        bh=GLtuI+hry+/4iLJMOGwBy+jWAR47CJf0GMenGxeiSwM=;
        h=From:To:Cc:Subject:Date:From;
        b=OED4ZCMv8q+ogwauV/f2/EreJYk+XcBUc0GGjdlHa6ui7oRbLAEMNbqflkmWG/2R3
         unXL1lASx/ZFWTt7LfjBAUn8FETA6OW9WlFujnR1MlKHPxdRZkjr1n7luwg3duTMS3
         MyZ1uAsEnMEOpMNekhQv3tiGcsiX6u7k3ZFE7UbrZ2pf/J90Ph3qZBcX/7FOrI9Fa5
         auCnHdtB0lD6udebJWgInTFQMBrl1NBoigLgYdFXBhc24HNRp5ebz/F7oCmNB7FGaQ
         aLQ4q96NETWK6/cVXNiWdgyZfMEuC+dbCt0tPO7jH4qI37hzTkkUI7vaIKy4Pom+5L
         jykFXF2jkEyWw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, heiko@sntech.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     kernel@pengutronix.de, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v5] media: Add P010 video format
Date:   Thu, 19 May 2022 09:01:48 +0200
Message-Id: <20220519070148.63315-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P010 is a YUV format with 10-bits per pixel with interleaved UV.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
version 5:
- Fix commit message
- Fix fourcc comment

version 4:
- Fix 10-bits per components wording.

version 3:
- remove LE suffix
- rebased on media_tree_master branch

 .../media/v4l/pixfmt-yuv-planar.rst           | 54 +++++++++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  1 +
 include/uapi/linux/videodev2.h                |  1 +
 4 files changed, 57 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 8dff5906639b..a900ff66911a 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -109,6 +109,13 @@ All components are stored with the same number of bits per component.
       - Cb, Cr
       - No
       - 16x16 tiles
+    * - V4L2_PIX_FMT_P010
+      - 'P010'
+      - 10
+      - 4:2:0
+      - Cb, Cr
+      - Yes
+      - Linear
     * - V4L2_PIX_FMT_NV16
       - 'NV16'
       - 8
@@ -171,6 +178,7 @@ horizontally.
 .. _V4L2-PIX-FMT-NV21:
 .. _V4L2-PIX-FMT-NV12M:
 .. _V4L2-PIX-FMT-NV21M:
+.. _V4L2-PIX-FMT-P010:
 
 NV12, NV21, NV12M and NV21M
 ---------------------------
@@ -519,6 +527,52 @@ number of lines as the luma plane.
       - Cb\ :sub:`33`
       - Cr\ :sub:`33`
 
+.. _V4L2_PIX_FMT_P010:
+
+P010
+----
+
+Like NV12 with 10 bits per component, expanded to 16 bits.
+Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian order.
+
+.. flat-table:: Sample 4x4 P010 Image
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - start + 0:
+      - Y'\ :sub:`00`
+      - Y'\ :sub:`01`
+      - Y'\ :sub:`02`
+      - Y'\ :sub:`03`
+    * - start + 8:
+      - Y'\ :sub:`10`
+      - Y'\ :sub:`11`
+      - Y'\ :sub:`12`
+      - Y'\ :sub:`13`
+    * - start + 16:
+      - Y'\ :sub:`20`
+      - Y'\ :sub:`21`
+      - Y'\ :sub:`22`
+      - Y'\ :sub:`23`
+    * - start + 24:
+      - Y'\ :sub:`30`
+      - Y'\ :sub:`31`
+      - Y'\ :sub:`32`
+      - Y'\ :sub:`33`
+    * - start + 32:
+      - Cb\ :sub:`00`
+      - Cr\ :sub:`00`
+      - Cb\ :sub:`01`
+      - Cr\ :sub:`01`
+    * - start + 40:
+      - Cb\ :sub:`10`
+      - Cr\ :sub:`10`
+      - Cb\ :sub:`11`
+      - Cr\ :sub:`11`
+
+.. raw:: latex
+
+    \endgroup
 
 Fully Planar YUV Formats
 ========================
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index df34b2a283bc..1e38ad8906a2 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -266,6 +266,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_NV61,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_NV42,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
+		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
 
 		{ .format = V4L2_PIX_FMT_YUV410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
 		{ .format = V4L2_PIX_FMT_YVU410,  .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 4, .vdiv = 4 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index e2636539c9db..536aaeb4df82 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1305,6 +1305,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
 	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
 	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
+	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CrCb 4:2:0"; break;
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 6d465dc443b7..57da13b6105c 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -601,6 +601,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
 #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
 #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/CrCb 4:4:4  */
+#define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/CbCr 4:2:0 10-bit per pixel */
 
 /* two non contiguous planes - one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12M   v4l2_fourcc('N', 'M', '1', '2') /* 12  Y/CbCr 4:2:0  */
-- 
2.32.0

