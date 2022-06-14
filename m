Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E654AB08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355192AbiFNHuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353536AbiFNHuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:50:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96B23ED38;
        Tue, 14 Jun 2022 00:50:03 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4a7b:8d3a:acaa:ec46])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1584466016D3;
        Tue, 14 Jun 2022 08:50:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655193002;
        bh=SzxOOtr+7skGYpIQjWGLYLdEvChiAFV4FuuYZNx0NRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BaFUl8phf9ysJG/Lcm78xwePaGR0nbcFRP21s3uubPLh0zQGsjx8ovGJmu7gHFyfT
         +gag4goHwTpotDmvAuI4vxD65V2sdwgNPCq1GLaT3V5vNfHlMeqh21QqT3QHQ9OID9
         GY6JSfXIqJW60qfL8KDqv7adSVIM4ly2dZ+giOhuhzm6jEkDgHbU76hEUVcI+Bm1RT
         k3UyFcfRGexxSnvXvs/Wbwy1qq3MK8QESk/1rf5NbfX6O+betALGZ5l5P1clNCqIm+
         oZ1S6dRId8uqXNw50g6iEf5ITnrl9LSff1UVAKwL8PsZF5Lon9k9gEWpjgOHB69Lip
         3PjEgJdE2/KpQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 10/17] media: uapi: Move parsed HEVC pixel format out of staging
Date:   Tue, 14 Jun 2022 09:49:40 +0200
Message-Id: <20220614074947.160316-11-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614074947.160316-1-benjamin.gaignard@collabora.com>
References: <20220614074947.160316-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move HEVC pixel format since we are ready to stabilize the uAPI

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 5 -----
 include/media/hevc-ctrls.h                                  | 3 ---
 include/uapi/linux/videodev2.h                              | 1 +
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
index 967fc803ef94..c352d91a73d8 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
@@ -215,11 +215,6 @@ Compressed Formats
 	See the :ref:`associated Codec Control IDs <v4l2-mpeg-hevc>`.
 	Buffers associated with this pixel format must contain the appropriate
 	number of macroblocks to decode a full corresponding frame.
-
-	.. note::
-
-	   This format is not yet part of the public kernel API and it
-	   is expected to change.
     * .. _V4L2-PIX-FMT-FWHT:
 
       - ``V4L2_PIX_FMT_FWHT``
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 140151609c96..a3c829ef531a 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -13,9 +13,6 @@
 
 #include <linux/videodev2.h>
 
-/* The pixel format isn't stable at the moment and will likely be renamed. */
-#define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
-
 #define V4L2_CID_STATELESS_HEVC_SPS		(V4L2_CID_CODEC_BASE + 1008)
 #define V4L2_CID_STATELESS_HEVC_PPS		(V4L2_CID_CODEC_BASE + 1009)
 #define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS	(V4L2_CID_CODEC_BASE + 1010)
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 9018aa984db3..37f9f23a67fe 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -712,6 +712,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_FWHT     v4l2_fourcc('F', 'W', 'H', 'T') /* Fast Walsh Hadamard Transform (vicodec) */
 #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
+#define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
2.32.0

