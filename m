Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7F058FAA5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiHKKXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiHKKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:23:26 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495FE255BA
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:23:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id 855AE40D403E;
        Thu, 11 Aug 2022 10:23:19 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] drm/fb-helper: add virtual screen size check to drm_fb_helper_check_var()
Date:   Thu, 11 Aug 2022 13:23:04 +0300
Message-Id: <20220811102304.70769-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add virtual screen size check to drm_fb_helper_check_var() in
order to validate userspace input.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 6c11df58fd1a ("fbmem: Check virtual screen sizes in fb_set_var()")
---
 drivers/gpu/drm/drm_fb_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 2d4cee6a10ff..d21fe89358af 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1355,6 +1355,16 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 	    (drm_format_info_block_height(fb->format, 0) > 1))
 		return -EINVAL;
 
+	/* verify that virtual resolution >= physical resolution */
+	if (var->xres_virtual < var->xres ||
+	    var->yres_virtual < var->yres) {
+		drm_dbg_kms(dev, "requested virtual screen size that is "
+				"below the physical size(%ux%u vs. %ux%u)\n",
+			var->xres_virtual, var->yres_virtual,
+			var->xres, var->yres);
+		return -EINVAL;
+	}
+
 	/*
 	 * Changes struct fb_var_screeninfo are currently not pushed back
 	 * to KMS, hence fail if different settings are requested.
-- 
2.25.1

