Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75FE570731
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiGKPf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKPf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:35:56 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5553E776
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:35:55 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id trbs2700b4C55Sk01rbsZy; Mon, 11 Jul 2022 17:35:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvRw-0036pt-Ek; Mon, 11 Jul 2022 17:35:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvRv-006sIs-K9; Mon, 11 Jul 2022 17:35:51 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] video: fbdev: amiga: Simplify amifb_pan_display()
Date:   Mon, 11 Jul 2022 17:35:48 +0200
Message-Id: <b803f10a2b3b85386b25a2e25b98fb4e59413ea9.1657553681.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fb_pan_display() function in the core already takes care of
validating most panning parameters before calling the driver's
.fb_pan_display() callback, and of updating the panning state
afterwards, so there is no need to repeat that in the driver.

Remove the duplicate code.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/amifb.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/amifb.c b/drivers/video/fbdev/amifb.c
index 6e07a97bbd31a1dd..d88265dbebf4cb19 100644
--- a/drivers/video/fbdev/amifb.c
+++ b/drivers/video/fbdev/amifb.c
@@ -2540,27 +2540,16 @@ static int amifb_blank(int blank, struct fb_info *info)
 static int amifb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
-	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset < 0 ||
-			var->yoffset >= info->var.yres_virtual || var->xoffset)
-				return -EINVAL;
-	} else {
+	if (!(var->vmode & FB_VMODE_YWRAP)) {
 		/*
 		 * TODO: There will be problems when xpan!=1, so some columns
 		 * on the right side will never be seen
 		 */
 		if (var->xoffset + info->var.xres >
-		    upx(16 << maxfmode, info->var.xres_virtual) ||
-		    var->yoffset + info->var.yres > info->var.yres_virtual)
+		    upx(16 << maxfmode, info->var.xres_virtual))
 			return -EINVAL;
 	}
 	ami_pan_var(var, info);
-	info->var.xoffset = var->xoffset;
-	info->var.yoffset = var->yoffset;
-	if (var->vmode & FB_VMODE_YWRAP)
-		info->var.vmode |= FB_VMODE_YWRAP;
-	else
-		info->var.vmode &= ~FB_VMODE_YWRAP;
 	return 0;
 }
 
-- 
2.25.1

