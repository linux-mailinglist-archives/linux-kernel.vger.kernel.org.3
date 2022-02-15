Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A514B7562
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiBOQxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:53:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241897AbiBOQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:52:46 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B19E565
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:52:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7534:e0be:5adf:2691])
        by michel.telenet-ops.be with bizsmtp
        id vUsV2600618GbK106UsVDJ; Tue, 15 Feb 2022 17:52:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nK140-000tUm-Kf; Tue, 15 Feb 2022 17:52:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nK140-00BURd-0H; Tue, 15 Feb 2022 17:52:28 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/8] drm/fourcc: Add drm_format_info_bpp() helper
Date:   Tue, 15 Feb 2022 17:52:21 +0100
Message-Id: <20220215165226.2738568-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215165226.2738568-1-geert@linux-m68k.org>
References: <20220215165226.2738568-1-geert@linux-m68k.org>
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

Add a helper to retrieve the actual number of bits per pixel for a
plane, taking into account the number of characters and pixels per
block for tiled formats.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/gpu/drm/drm_fourcc.c | 19 +++++++++++++++++++
 include/drm/drm_fourcc.h     |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 60ce63d728b8e308..5c77ce10f53e3a64 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -388,6 +388,25 @@ unsigned int drm_format_info_block_height(const struct drm_format_info *info,
 }
 EXPORT_SYMBOL(drm_format_info_block_height);
 
+/**
+ * drm_format_info_bpp - number of bits per pixel
+ * @info: pixel format info
+ * @plane: plane index
+ *
+ * Returns:
+ * The actual number of bits per pixel, depending on the plane index.
+ */
+unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane)
+{
+	if (!info || plane < 0 || plane >= info->num_planes)
+		return 0;
+
+	return info->char_per_block[plane] * 8 /
+	       (drm_format_info_block_width(info, plane) *
+		drm_format_info_block_height(info, plane));
+}
+EXPORT_SYMBOL(drm_format_info_bpp);
+
 /**
  * drm_format_info_min_pitch - computes the minimum required pitch in bytes
  * @info: pixel format info
diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
index 22aa64d07c7905e2..3800a7ad7f0cda7a 100644
--- a/include/drm/drm_fourcc.h
+++ b/include/drm/drm_fourcc.h
@@ -313,6 +313,7 @@ unsigned int drm_format_info_block_width(const struct drm_format_info *info,
 					 int plane);
 unsigned int drm_format_info_block_height(const struct drm_format_info *info,
 					  int plane);
+unsigned int drm_format_info_bpp(const struct drm_format_info *info, int plane);
 uint64_t drm_format_info_min_pitch(const struct drm_format_info *info,
 				   int plane, unsigned int buffer_width);
 
-- 
2.25.1

