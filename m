Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C34D0904
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbiCGUzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245484AbiCGUzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:55:04 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512EE340EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:53:35 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6100:2d37:4115:c358])
        by albert.telenet-ops.be with bizsmtp
        id 3YtW2700D1Yj8bA06YtWdp; Mon, 07 Mar 2022 21:53:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLZ-0036Qh-1N; Mon, 07 Mar 2022 21:52:49 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLX-0034hh-Vg; Mon, 07 Mar 2022 21:52:47 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 05/10] drm/fourcc: Add DRM_FORMAT_C[124]
Date:   Mon,  7 Mar 2022 21:52:40 +0100
Message-Id: <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646683502.git.geert@linux-m68k.org>
References: <cover.1646683502.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce fourcc codes for color-indexed frame buffer formats with two,
four, and sixteen colors, and provide a mapping from bit per pixel and
depth to fourcc codes.

As the number of bits per pixel is less than eight, these rely on proper
block handling for the calculation of bits per pixel and pitch.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Improve pixel descriptions,
  - Require depth to match bpp in drm_mode_legacy_fb_format(),
  - Set .is_color_indexed flag.
---
 drivers/gpu/drm/drm_fourcc.c  | 21 +++++++++++++++++++++
 include/uapi/drm/drm_fourcc.h |  5 ++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 6c76bd821d17e7c7..29f4fe199c4ddcf0 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -43,6 +43,21 @@ uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth)
 	uint32_t fmt = DRM_FORMAT_INVALID;
 
 	switch (bpp) {
+	case 1:
+		if (depth == 1)
+			fmt = DRM_FORMAT_C1;
+		break;
+
+	case 2:
+		if (depth == 2)
+			fmt = DRM_FORMAT_C2;
+		break;
+
+	case 4:
+		if (depth == 4)
+			fmt = DRM_FORMAT_C4;
+		break;
+
 	case 8:
 		if (depth == 8)
 			fmt = DRM_FORMAT_C8;
@@ -132,6 +147,12 @@ EXPORT_SYMBOL(drm_driver_legacy_fb_format);
 const struct drm_format_info *__drm_format_info(u32 format)
 {
 	static const struct drm_format_info formats[] = {
+		{ .format = DRM_FORMAT_C1,		.depth = 1,  .num_planes = 1,
+		  .char_per_block = { 1, }, .block_w = { 8, }, .block_h = { 1, }, .hsub = 1, .vsub = 1, .is_color_indexed = true },
+		{ .format = DRM_FORMAT_C2,		.depth = 2,  .num_planes = 1,
+		  .char_per_block = { 1, }, .block_w = { 4, }, .block_h = { 1, }, .hsub = 1, .vsub = 1, .is_color_indexed = true },
+		{ .format = DRM_FORMAT_C4,		.depth = 4,  .num_planes = 1,
+		  .char_per_block = { 1, }, .block_w = { 2, }, .block_h = { 1, }, .hsub = 1, .vsub = 1, .is_color_indexed = true },
 		{ .format = DRM_FORMAT_C8,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1, .is_color_indexed = true },
 		{ .format = DRM_FORMAT_R8,		.depth = 8,  .num_planes = 1, .cpp = { 1, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_R10,		.depth = 10, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index fc0c1454d2757d5d..457ed39cc48f08e1 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -99,7 +99,10 @@ extern "C" {
 #define DRM_FORMAT_INVALID	0
 
 /* color index */
-#define DRM_FORMAT_C8		fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
+#define DRM_FORMAT_C1		fourcc_code('C', '1', ' ', ' ') /* [7:0] C0:C1:C2:C3:C4:C5:C6:C7 1:1:1:1:1:1:1:1 eight pixels/byte */
+#define DRM_FORMAT_C2		fourcc_code('C', '2', ' ', ' ') /* [7:0] C0:C1:C2:C3 2:2:2:2 four pixels/byte */
+#define DRM_FORMAT_C4		fourcc_code('C', '4', ' ', ' ') /* [7:0] C0:C1 4:4 two pixels/byte */
+#define DRM_FORMAT_C8		fourcc_code('C', '8', ' ', ' ') /* [7:0] C 8 one pixel/byte */
 
 /* 8 bpp Red */
 #define DRM_FORMAT_R8		fourcc_code('R', '8', ' ', ' ') /* [7:0] R */
-- 
2.25.1

