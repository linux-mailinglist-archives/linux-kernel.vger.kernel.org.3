Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAD85707AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiGKPvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiGKPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:50:49 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A72F77A4A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:50:40 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id trqe270064C55Sk01rqeeU; Mon, 11 Jul 2022 17:50:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgD-0036x1-Ny; Mon, 11 Jul 2022 17:50:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgC-006shc-UU; Mon, 11 Jul 2022 17:50:36 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 05/10] video: fbdev: atari: Remove unneeded casts from void *
Date:   Mon, 11 Jul 2022 17:50:29 +0200
Message-Id: <6347fe3212d34d6b50634ee967c0a4a2127610a8.1657554353.git.geert@linux-m68k.org>
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

There is no need to cast fb_info.par to "struct atafb_par *", as the
former has type "void *".

Remove the casts, as they make it impossible to validate types.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index a36cd8f1f4200dd5..f20535ea3e549384 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -1639,7 +1639,7 @@ static irqreturn_t falcon_vbl_switcher(int irq, void *dummy)
 static int falcon_pan_display(struct fb_var_screeninfo *var,
 			      struct fb_info *info)
 {
-	struct atafb_par *par = (struct atafb_par *)info->par;
+	struct atafb_par *par = info->par;
 
 	int xoffset;
 	int bpp = info->var.bits_per_pixel;
@@ -2263,7 +2263,7 @@ static void set_screen_base(void *s_base)
 
 static int pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct atafb_par *par = (struct atafb_par *)info->par;
+	struct atafb_par *par = info->par;
 
 	if (!fbhw->set_screen_base ||
 	    (!ATARIHW_PRESENT(EXTD_SHIFTER) && var->xoffset))
@@ -2432,7 +2432,7 @@ atafb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 
 static void atafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 {
-	struct atafb_par *par = (struct atafb_par *)info->par;
+	struct atafb_par *par = info->par;
 	int x2, y2;
 	u32 width, height;
 
@@ -2475,7 +2475,7 @@ static void atafb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
 
 static void atafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
-	struct atafb_par *par = (struct atafb_par *)info->par;
+	struct atafb_par *par = info->par;
 	int x2, y2;
 	u32 dx, dy, sx, sy, width, height;
 	int rev_copy = 0;
@@ -2529,7 +2529,7 @@ static void atafb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 
 static void atafb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-	struct atafb_par *par = (struct atafb_par *)info->par;
+	struct atafb_par *par = info->par;
 	int x2, y2;
 	unsigned long *dst;
 	int dst_idx;
@@ -2672,7 +2672,7 @@ static int atafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	 * hw par just decoded */
 static int atafb_set_par(struct fb_info *info)
 {
-	struct atafb_par *par = (struct atafb_par *)info->par;
+	struct atafb_par *par = info->par;
 
 	/* Decode wanted screen parameters */
 	fbhw->decode_var(&info->var, par);
-- 
2.25.1

