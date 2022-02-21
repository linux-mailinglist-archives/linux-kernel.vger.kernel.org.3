Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77994BEB35
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbiBUTMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:12:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiBUTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:12:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F5520F64;
        Mon, 21 Feb 2022 11:12:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 5B5E41F43AD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645470736;
        bh=XM70mQYqpo0EN+97MbBv5HsRvmA2NIYUG8YtRFFXv4k=;
        h=From:To:Cc:Subject:Date:From;
        b=X7LCGF0fO9fzaH2CEgy5WVAZ/EOEJmwblAGFA2pKrkt3LYKmnu2XoJhJ+XEcsMwxg
         RMneAVMWrW9v42GScqlxPlfkPmhZyuTLO0OLpG1XutV6oxZOsnUAwMW4Uq0i5Zc+sJ
         i/e6V+XFtAxTTNVymOFtoPOY5W+ay8tzjKuQK27wQOGuFaMmDhed0AJWvcoNxRrqlr
         zZNIdW2Tfeu9P0381GmYNc4XISi+BftsVqS6jndgAZ0QMjG90JTJb9bVCCZbClXPlZ
         OS29JItcthUH2NhbLN3I6Xq9XZiEIZ3Ujfs57pzntMKtrgpyah5zhyt/hGd4CTQ9TK
         B/63bMq6fy6WA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, yunfei.dong@mediatek.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] doc: media: Document MM21 tiled format
Date:   Mon, 21 Feb 2022 14:12:01 -0500
Message-Id: <20220221191202.805745-1-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.35.1
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

MM21 has been documented through two software implementation [0] in libyuv and
[2] GStreamer. This format is similar to other tiled format, though it uses
uneven tile sizes. The luma tiles are 16x32 while the chroma tile have a
subsampled size of 16x16. This is the uncompressed cousin of V4L2_PIX_FMT_MT21C
and shares its tiling pattern and alignment.

[0] https://chromium.googlesource.com/libyuv/libyuv/+/b4ddbaf549a1bf5572bf703fd2862d1eb7380c6a
[1] https://gitlab.freedesktop.org/gstreamer/gstreamer/-/commit/c9b127dae3af4b3fe78468e697cb491902425254

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../userspace-api/media/v4l/pixfmt-reserved.rst   | 15 ++++-----------
 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst |  6 ++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 2f2133b4cd9ce..cabfa34b7db5a 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -233,19 +233,12 @@ please make a proposal on the linux-media mailing list.
 
       - ``V4L2_PIX_FMT_MT21C``
       - 'MT21'
-      - Compressed two-planar YVU420 format used by Mediatek MT8173.
-	The compression is lossless.
-	It is an opaque intermediate format and the MDP hardware must be
+      - Compressed two-planar YVU420 format used by Mediatek MT8173, MT8192,
+        MT8195 and more. The compression is lossless. This format have
+	similitude with ``V4L2_PIX_FMT_MM21`` in term of alignment and tiling.
+	It remains an opaque intermediate format and the MDP hardware must be
 	used to convert ``V4L2_PIX_FMT_MT21C`` to ``V4L2_PIX_FMT_NV12M``,
 	``V4L2_PIX_FMT_YUV420M`` or ``V4L2_PIX_FMT_YVU420``.
-    * .. _V4L2-PIX-FMT-MM21:
-
-      - ``V4L2_PIX_FMT_MM21``
-      - 'MM21'
-      - Non-compressed, tiled two-planar format used by Mediatek MT8183.
-	This is an opaque intermediate format and the MDP3 hardware can be
-	used to convert it to other formats.
-
 .. raw:: latex
 
     \normalsize
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 3a09d93d405b2..570791fbc5c8b 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -296,6 +296,12 @@ tiles linearly in memory. The line stride and image height must be
 aligned to a multiple of 32. The layouts of the luma and chroma planes are
 identical.
 
+``V4L2_PIX_FMT_MM21`` store luma pixel in 16x32 tiles, and chroma pixels
+in 16x16 tiles. The line stride must be aligned to a multiple of 16 and the
+image height must be aligned to a multiple of 32. The number of luma and chroma
+tiles are identical, even though the tile size differ. The image is formed of
+two non-contiguous planes.
+
 .. _nv12mt:
 
 .. kernel-figure:: nv12mt.svg
-- 
2.35.1

