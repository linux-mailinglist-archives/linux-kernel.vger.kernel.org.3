Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58B4C4B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiBYQrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243217AbiBYQqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:46:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F9722D646;
        Fri, 25 Feb 2022 08:46:19 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:947c:7c9e:f96:1bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7A4871F462DD;
        Fri, 25 Feb 2022 16:46:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645807578;
        bh=ZKLccwCI9e2jto29+P03GlKR+XxsqNInVtVq+uWxfHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LULVDE0C7aEvjvxnL1X7ZHcPQ2WANd5bc1/sqOwzfGUv2qJAo0v0JmlCX788ILKSx
         fwtEc7bBNlg/p63mAvF8DH3MnM45dxAuAddG7EVM+xt3a7J8oFA+vZs3TcQQB55V1U
         T5IWxuu8An6d4rordaElKHBuDU/gmGebx2xeaFHaSSpI+MnEqjI+fq+lsIgmcPPBl1
         04qae8WxnaDaniQ06sImJG4vqEf1VcMGqLjMuOSuM2QP7tYflcwriLqYH8pN3oEIS8
         H0yLGj7pLuA4ooPxSEpYVR2On/iWRjgf1r4Ag5xvvbr9LerWiNdBCC36+XBUCHVhef
         vysOb5oITixGA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 12/14] media: uapi: Create a dedicated header for Hantro control
Date:   Fri, 25 Feb 2022 17:45:58 +0100
Message-Id: <20220225164600.1044663-13-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
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

Hantro hardware needs a dedicated v4l2 control to perform HEVC
decoding. Move it to a dedicated header file to prepare HEVC
uAPI un-staging.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../userspace-api/media/drivers/hantro.rst    |  5 -----
 drivers/staging/media/hantro/hantro_drv.c     |  1 +
 include/media/hevc-ctrls.h                    | 13 -------------
 include/uapi/linux/hantro-media.h             | 19 +++++++++++++++++++
 include/uapi/linux/v4l2-controls.h            |  5 +++++
 5 files changed, 25 insertions(+), 18 deletions(-)
 create mode 100644 include/uapi/linux/hantro-media.h

diff --git a/Documentation/userspace-api/media/drivers/hantro.rst b/Documentation/userspace-api/media/drivers/hantro.rst
index cd9754b4e005..78dcd2a44a03 100644
--- a/Documentation/userspace-api/media/drivers/hantro.rst
+++ b/Documentation/userspace-api/media/drivers/hantro.rst
@@ -12,8 +12,3 @@ The Hantro video decoder driver implements the following driver-specific control
     to before syntax element "slice_temporal_mvp_enabled_flag".
     If IDR, the skipped bits are just "pic_output_flag"
     (separate_colour_plane_flag is not supported).
-
-.. note::
-
-        This control is not yet part of the public kernel API and
-        it is expected to change.
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 6f58c259d8fc..783a92a38c8e 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/hantro-media.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index cbf41d180fe9..f29298c8c2f8 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -443,17 +443,4 @@ struct v4l2_ctrl_hevc_scaling_matrix {
 	__u8	scaling_list_dc_coef_32x32[2];
 };
 
-/*  MPEG-class control IDs specific to the Hantro driver as defined by V4L2 */
-#define V4L2_CID_CODEC_HANTRO_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1200)
-/*
- * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
- * the number of data (in bits) to skip in the
- * slice segment header.
- * If non-IDR, the bits to be skipped go from syntax element "pic_output_flag"
- * to before syntax element "slice_temporal_mvp_enabled_flag".
- * If IDR, the skipped bits are just "pic_output_flag"
- * (separate_colour_plane_flag is not supported).
- */
-#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	(V4L2_CID_CODEC_HANTRO_BASE + 0)
-
 #endif
diff --git a/include/uapi/linux/hantro-media.h b/include/uapi/linux/hantro-media.h
new file mode 100644
index 000000000000..b4e7ab7e6452
--- /dev/null
+++ b/include/uapi/linux/hantro-media.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __UAPI_HANTRO_MEDIA_H__
+#define __UAPI_HANTRO_MEDIA_H__
+
+#include <linux/v4l2-controls.h>
+
+/*
+ * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
+ * the number of data (in bits) to skip in the
+ * slice segment header.
+ * If non-IDR, the bits to be skipped go from syntax element "pic_output_flag"
+ * to before syntax element "slice_temporal_mvp_enabled_flag".
+ * If IDR, the skipped bits are just "pic_output_flag"
+ * (separate_colour_plane_flag is not supported).
+ */
+#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	(V4L2_CID_USER_HANTRO_BASE + 0)
+
+#endif /* __UAPI_HANTRO_MEDIA_H__ */
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c8e0f84d204d..d56a1c7fb91d 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -218,6 +218,11 @@ enum v4l2_colorfx {
  * We reserve 16 controls for this driver.
  */
 #define V4L2_CID_USER_ALLEGRO_BASE		(V4L2_CID_USER_BASE + 0x1170)
+/*
+ * The base for Hantro driver controls.
+ * We reserve 128 controls for this driver.
+ */
+#define V4L2_CID_USER_HANTRO_BASE		(V4L2_CID_USER_BASE + 0x1180)
 
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
-- 
2.32.0

