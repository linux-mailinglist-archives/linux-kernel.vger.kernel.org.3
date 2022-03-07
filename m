Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE43F4D0903
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245485AbiCGUza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbiCGUzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:55:05 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF8340FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:53:35 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6100:2d37:4115:c358])
        by albert.telenet-ops.be with bizsmtp
        id 3YtW2700F1Yj8bA06YtWdo; Mon, 07 Mar 2022 21:53:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLY-0036Qd-Sw; Mon, 07 Mar 2022 21:52:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLX-0034hG-ST; Mon, 07 Mar 2022 21:52:47 +0100
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
Subject: [PATCH v2 01/10] drm/fourcc: Add drm_format_info_bpp() helper
Date:   Mon,  7 Mar 2022 21:52:36 +0100
Message-Id: <eab1fe866c0ffd4ac097e66ff48725dd39893105.1646683502.git.geert@linux-m68k.org>
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

Add a helper to retrieve the actual number of bits per pixel for a
plane, taking into account the number of characters and pixels per
block for tiled formats.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Move up.
---
 drivers/gpu/drm/drm_fourcc.c | 19 +++++++++++++++++++
 include/drm/drm_fourcc.h     |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 07741b678798b0f1..cf48ea0b2cb70ba8 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -370,6 +370,25 @@ unsigned int drm_format_info_block_height(const struct drm_format_info *info,
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

