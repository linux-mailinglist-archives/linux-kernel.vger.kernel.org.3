Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE33D5707A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiGKPvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiGKPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:50:43 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5301377A40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:50:40 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id trqd2700Z4C55Sk01rqdeL; Mon, 11 Jul 2022 17:50:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgD-0036wx-8w; Mon, 11 Jul 2022 17:50:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgC-006sh9-RW; Mon, 11 Jul 2022 17:50:36 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 01/10] video: fbdev: atari: Simplify atafb_pan_display()
Date:   Mon, 11 Jul 2022 17:50:25 +0200
Message-Id: <7b7c1c25309f40d780e25b258f726e6ebcc79ca4.1657554353.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657554353.git.geert@linux-m68k.org>
References: <cover.1657554353.git.geert@linux-m68k.org>
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

The fb_pan_display() function in the core already takes care of
validating the panning parameters before calling the driver's
.fb_pan_display() callback, and of updating the panning state
afterwards, so there is no need to repeat that in the driver.

Remove the duplicate code.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index 102c727cedc0f005..c0683d2a4efaf1e8 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2407,35 +2407,10 @@ static void atafb_set_disp(struct fb_info *info)
 static int
 atafb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	int xoffset = var->xoffset;
-	int yoffset = var->yoffset;
-	int err;
-
-	if (var->vmode & FB_VMODE_YWRAP) {
-		if (yoffset < 0 || yoffset >= info->var.yres_virtual || xoffset)
-			return -EINVAL;
-	} else {
-		if (xoffset + info->var.xres > info->var.xres_virtual ||
-		    yoffset + info->var.yres > info->var.yres_virtual)
-			return -EINVAL;
-	}
-
-	if (fbhw->pan_display) {
-		err = fbhw->pan_display(var, info);
-		if (err)
-			return err;
-	} else
+	if (!fbhw->pan_display)
 		return -EINVAL;
 
-	info->var.xoffset = xoffset;
-	info->var.yoffset = yoffset;
-
-	if (var->vmode & FB_VMODE_YWRAP)
-		info->var.vmode |= FB_VMODE_YWRAP;
-	else
-		info->var.vmode &= ~FB_VMODE_YWRAP;
-
-	return 0;
+	return fbhw->pan_display(var, info);
 }
 
 /*
-- 
2.25.1

