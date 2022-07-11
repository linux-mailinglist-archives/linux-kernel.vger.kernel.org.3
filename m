Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C5570739
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGKPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGKPh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:37:58 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404BD76941
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:37:57 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id trdu2700T4C55Sk01rdvwV; Mon, 11 Jul 2022 17:37:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvTu-0036qj-JG; Mon, 11 Jul 2022 17:37:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvTt-006sLV-Ib; Mon, 11 Jul 2022 17:37:53 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] video: fbdev: sa1100fb: Remove unused sa1100fb_setup()
Date:   Mon, 11 Jul 2022 17:37:52 +0200
Message-Id: <9c53722c7e17ed8be4fc5d83dcd97192fb7d7d3e.1657553763.git.geert@linux-m68k.org>
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

sa1100fb_setup() has been unused since the beginning of Linux git
history.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/sa1100fb.c | 41 ----------------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index e31cf63b0a62d485..017c8efe826703f4 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1224,47 +1224,6 @@ int __init sa1100fb_init(void)
 	return platform_driver_register(&sa1100fb_driver);
 }
 
-int __init sa1100fb_setup(char *options)
-{
-#if 0
-	char *this_opt;
-
-	if (!options || !*options)
-		return 0;
-
-	while ((this_opt = strsep(&options, ",")) != NULL) {
-
-		if (!strncmp(this_opt, "bpp:", 4))
-			current_par.max_bpp =
-			    simple_strtoul(this_opt + 4, NULL, 0);
-
-		if (!strncmp(this_opt, "lccr0:", 6))
-			lcd_shadow.lccr0 =
-			    simple_strtoul(this_opt + 6, NULL, 0);
-		if (!strncmp(this_opt, "lccr1:", 6)) {
-			lcd_shadow.lccr1 =
-			    simple_strtoul(this_opt + 6, NULL, 0);
-			current_par.max_xres =
-			    (lcd_shadow.lccr1 & 0x3ff) + 16;
-		}
-		if (!strncmp(this_opt, "lccr2:", 6)) {
-			lcd_shadow.lccr2 =
-			    simple_strtoul(this_opt + 6, NULL, 0);
-			current_par.max_yres =
-			    (lcd_shadow.
-			     lccr0 & LCCR0_SDS) ? ((lcd_shadow.
-						    lccr2 & 0x3ff) +
-						   1) *
-			    2 : ((lcd_shadow.lccr2 & 0x3ff) + 1);
-		}
-		if (!strncmp(this_opt, "lccr3:", 6))
-			lcd_shadow.lccr3 =
-			    simple_strtoul(this_opt + 6, NULL, 0);
-	}
-#endif
-	return 0;
-}
-
 module_init(sa1100fb_init);
 MODULE_DESCRIPTION("StrongARM-1100/1110 framebuffer driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

