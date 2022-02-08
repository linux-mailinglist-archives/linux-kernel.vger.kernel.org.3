Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFD74AE4CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387832AbiBHWby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386699AbiBHVIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654EAC0612BE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so153508wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5WrS/1rmXvD/BYbGf8gVLMNVbqD+GkBVWeKUPnYEUE=;
        b=W8SZ9ZT9lnqf674qYwX61QIIXfYPpz5TT8FNFquYqMWF60Zr1NxVSo67LFUIumhY/b
         g4X3DWnYQ4E9O0TT9I27jrKoBmg4rpZuW34qAkgkfckRl0rxiOId6Jms4FaL+TttstLl
         RZw/gE3MZ7mAZ0AStwQU91DCKbDEAy83Zt1DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5WrS/1rmXvD/BYbGf8gVLMNVbqD+GkBVWeKUPnYEUE=;
        b=UtQBa8h1at7l9jWbsrqc7CYjlEb0DQyvpSRB5heVOK04Ja0ni+6DnwCAMGMOs/ZnSd
         i3Ez20sNwvdMDP0vqadOMXCplEmMogRUHOdcJU0rXzLFY1WAaq7r4wzCpuIBMW/ysGNG
         0AfopRfhJp3LnwtcwoH71wz3dI/HzOEQrn1HySUz2Xaraxs8h06NN6M+M17k55aj+s7w
         6FFzQDQq+MwAV3NYScLY07iy1UxHNf1Evup7CF+b8g94mmfWj+DSARUhVzNUuhkDHkKA
         KJ19izyUWdKot4nbBRjDkle4KCCWTCOYRYLzF1mjAs90Kx/K9jH6j9dx4xHvHlyOQmi+
         tkNw==
X-Gm-Message-State: AOAM531y9zTJnxxPM+RIuCQ5k6t2BkfjSvduLmGZLqJKe/BI/138vdun
        EEMlrNJgTXPXxfAwolxy/ks1sg==
X-Google-Smtp-Source: ABdhPJymquC64RJAFkzllw/eFz8WLOUKu7ZMOr++7kAYlKbVxvjPxIJXICIuvaEML/N2TifrI9Fp2w==
X-Received: by 2002:a05:600c:4f85:: with SMTP id n5mr2579212wmq.64.1644354513896;
        Tue, 08 Feb 2022 13:08:33 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:32 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Du Cheng <ducheng2@gmail.com>, Claudio Suarez <cssk@net-c.es>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 03/19] fbcon: Introduce wrapper for console->fb_info lookup
Date:   Tue,  8 Feb 2022 22:08:08 +0100
Message-Id: <20220208210824.2238981-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Half of it is protected by console_lock, but the other half is a lot
more awkward: Registration/deregistration of fbdev are serialized, but
we don't really clear out anything in con2fb_map and so there's
potential for use-after free mixups.

First step is to encapsulate the lookup.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c | 76 ++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index e925bb608e25..b75e638cb83d 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -110,6 +110,18 @@ static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 static signed char con2fb_map[MAX_NR_CONSOLES];
 static signed char con2fb_map_boot[MAX_NR_CONSOLES];
 
+static struct fb_info *fbcon_info_from_console(int console)
+{
+	WARN_CONSOLE_UNLOCKED();
+
+	/*
+	 * Note that only con2fb_map is protected by the console lock,
+	 * registered_fb is protected by a separate mutex. This lookup can
+	 * therefore race.
+	 */
+	return registered_fb[con2fb_map[console]];
+}
+
 static int logo_lines;
 /* logo_shown is an index to vc_cons when >= 0; otherwise follows FBCON_LOGO
    enums.  */
@@ -199,7 +211,7 @@ static void fbcon_rotate(struct fb_info *info, u32 rotate)
 	if (!ops || ops->currcon == -1)
 		return;
 
-	fb_info = registered_fb[con2fb_map[ops->currcon]];
+	fb_info = fbcon_info_from_console(ops->currcon);
 
 	if (info == fb_info) {
 		struct fbcon_display *p = &fb_display[ops->currcon];
@@ -226,7 +238,7 @@ static void fbcon_rotate_all(struct fb_info *info, u32 rotate)
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		vc = vc_cons[i].d;
 		if (!vc || vc->vc_mode != KD_TEXT ||
-		    registered_fb[con2fb_map[i]] != info)
+		    fbcon_info_from_console(i) != info)
 			continue;
 
 		p = &fb_display[vc->vc_num];
@@ -356,7 +368,7 @@ static void fb_flashcursor(struct work_struct *work)
 		vc = vc_cons[ops->currcon].d;
 
 	if (!vc || !con_is_visible(vc) ||
- 	    registered_fb[con2fb_map[vc->vc_num]] != info ||
+	    fbcon_info_from_console(vc->vc_num) != info ||
 	    vc->vc_deccm != 1) {
 		console_unlock();
 		return;
@@ -791,7 +803,7 @@ static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
 	if (show_logo) {
 		struct vc_data *fg_vc = vc_cons[fg_console].d;
 		struct fb_info *fg_info =
-			registered_fb[con2fb_map[fg_console]];
+			fbcon_info_from_console(fg_console);
 
 		fbcon_prepare_logo(fg_vc, fg_info, fg_vc->vc_cols,
 				   fg_vc->vc_rows, fg_vc->vc_cols,
@@ -1014,7 +1026,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 	if (con2fb_map[vc->vc_num] == -1)
 		con2fb_map[vc->vc_num] = info_idx;
 
-	info = registered_fb[con2fb_map[vc->vc_num]];
+	info = fbcon_info_from_console(vc->vc_num);
 
 	if (logo_shown < 0 && console_loglevel <= CONSOLE_LOGLEVEL_QUIET)
 		logo_shown = FBCON_LOGO_DONTSHOW;
@@ -1231,7 +1243,7 @@ static void fbcon_deinit(struct vc_data *vc)
 static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 			int width)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	struct fbcon_display *p = &fb_display[vc->vc_num];
@@ -1269,7 +1281,7 @@ static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
@@ -1289,7 +1301,7 @@ static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 
 static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	if (!fbcon_is_inactive(vc, info))
@@ -1298,7 +1310,7 @@ static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
 
 static void fbcon_cursor(struct vc_data *vc, int mode)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
  	int c = scr_readw((u16 *) vc->vc_pos);
 
@@ -1392,7 +1404,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 
 static __inline__ void ywrap_up(struct vc_data *vc, int count)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 
@@ -1411,7 +1423,7 @@ static __inline__ void ywrap_up(struct vc_data *vc, int count)
 
 static __inline__ void ywrap_down(struct vc_data *vc, int count)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 
@@ -1430,7 +1442,7 @@ static __inline__ void ywrap_down(struct vc_data *vc, int count)
 
 static __inline__ void ypan_up(struct vc_data *vc, int count)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
@@ -1454,7 +1466,7 @@ static __inline__ void ypan_up(struct vc_data *vc, int count)
 
 static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 
@@ -1478,7 +1490,7 @@ static __inline__ void ypan_up_redraw(struct vc_data *vc, int t, int count)
 
 static __inline__ void ypan_down(struct vc_data *vc, int count)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
@@ -1502,7 +1514,7 @@ static __inline__ void ypan_down(struct vc_data *vc, int count)
 
 static __inline__ void ypan_down_redraw(struct vc_data *vc, int t, int count)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 
@@ -1666,7 +1678,7 @@ static void fbcon_redraw(struct vc_data *vc, struct fbcon_display *p,
 static void fbcon_bmove_rec(struct vc_data *vc, struct fbcon_display *p, int sy, int sx,
 			    int dy, int dx, int height, int width, u_int y_break)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 	u_int b;
 
@@ -1708,7 +1720,7 @@ static void fbcon_bmove_rec(struct vc_data *vc, struct fbcon_display *p, int sy,
 static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 			int height, int width)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 
 	if (fbcon_is_inactive(vc, info))
@@ -1731,7 +1743,7 @@ static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		enum con_scroll dir, unsigned int count)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
 
@@ -1996,7 +2008,7 @@ static void updatescrollmode(struct fbcon_display *p,
 static int fbcon_resize(struct vc_data *vc, unsigned int width, 
 			unsigned int height, unsigned int user)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fb_var_screeninfo var = info->var;
@@ -2065,7 +2077,7 @@ static int fbcon_switch(struct vc_data *vc)
 	struct fb_var_screeninfo var;
 	int i, ret, prev_console;
 
-	info = registered_fb[con2fb_map[vc->vc_num]];
+	info = fbcon_info_from_console(vc->vc_num);
 	ops = info->fbcon_par;
 
 	if (logo_shown >= 0) {
@@ -2079,7 +2091,7 @@ static int fbcon_switch(struct vc_data *vc)
 
 	prev_console = ops->currcon;
 	if (prev_console != -1)
-		old_info = registered_fb[con2fb_map[prev_console]];
+		old_info = fbcon_info_from_console(prev_console);
 	/*
 	 * FIXME: If we have multiple fbdev's loaded, we need to
 	 * update all info->currcon.  Perhaps, we can place this
@@ -2202,7 +2214,7 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 
 static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	if (mode_switch) {
@@ -2244,7 +2256,7 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 
 static int fbcon_debug_enter(struct vc_data *vc)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	ops->save_graphics = ops->graphics;
@@ -2257,7 +2269,7 @@ static int fbcon_debug_enter(struct vc_data *vc)
 
 static int fbcon_debug_leave(struct vc_data *vc)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	ops->graphics = ops->save_graphics;
@@ -2393,7 +2405,7 @@ static void set_vc_hi_font(struct vc_data *vc, bool set)
 static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 			     const u8 * data, int userfont)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize;
@@ -2447,7 +2459,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 			  unsigned int flags)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
@@ -2511,7 +2523,7 @@ static int fbcon_set_font(struct vc_data *vc, struct console_font *font,
 
 static int fbcon_set_def_font(struct vc_data *vc, struct console_font *font, char *name)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	const struct font_desc *f;
 
 	if (!name)
@@ -2535,7 +2547,7 @@ static struct fb_cmap palette_cmap = {
 
 static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 {
-	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
+	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	int i, j, k, depth;
 	u8 val;
 
@@ -2651,7 +2663,7 @@ static void fbcon_modechanged(struct fb_info *info)
 		return;
 	vc = vc_cons[ops->currcon].d;
 	if (vc->vc_mode != KD_TEXT ||
-	    registered_fb[con2fb_map[ops->currcon]] != info)
+	    fbcon_info_from_console(ops->currcon) != info)
 		return;
 
 	p = &fb_display[vc->vc_num];
@@ -2691,7 +2703,7 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		vc = vc_cons[i].d;
 		if (!vc || vc->vc_mode != KD_TEXT ||
-		    registered_fb[con2fb_map[i]] != info)
+		    fbcon_info_from_console(i) != info)
 			continue;
 
 		if (con_is_visible(vc)) {
@@ -2954,7 +2966,7 @@ void fbcon_fb_blanked(struct fb_info *info, int blank)
 
 	vc = vc_cons[ops->currcon].d;
 	if (vc->vc_mode != KD_TEXT ||
-			registered_fb[con2fb_map[ops->currcon]] != info)
+			fbcon_info_from_console(ops->currcon) != info)
 		return;
 
 	if (con_is_visible(vc)) {
@@ -2974,7 +2986,7 @@ void fbcon_new_modelist(struct fb_info *info)
 	const struct fb_videomode *mode;
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
-		if (registered_fb[con2fb_map[i]] != info)
+		if (fbcon_info_from_console(i) != info)
 			continue;
 		if (!fb_display[i].mode)
 			continue;
-- 
2.34.1

