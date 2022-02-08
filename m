Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5F4AE4B1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386953AbiBHWfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386725AbiBHVIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537EEC0612BA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so153819wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0jcZhW240q/V+F937iAT51+jAJ4wMTWthnKOU1oFwYY=;
        b=RvN9RXsH98HQ7R4ASK94Wa721S7v3e9uYupFyjpxCVnHmyUZk9Z0e0fiSif0AsX195
         hJ8mBsbov8YE3ijlPln772kRVM7ChshKzGAhsKXYeIBbkNk0RX0OB2TONi3m39pCKQhc
         m8pJ7WEZ//h8h6RloxQYTj4Gg7Q9rT68dL5eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0jcZhW240q/V+F937iAT51+jAJ4wMTWthnKOU1oFwYY=;
        b=kpdZzWoiYvXlK/f4PcA02jOhSw9jfG/H9DNclC1xXZOVlorZtpsP9qE6hYTNGmWLMG
         NMS7Aghe6V6QN57LlPvmTRtSvnvXJMXdh/2XYVg/sPZO4nrFJUNdyd8GkjuXmYc0zhNw
         7xfxCs2bgTs8NQ3ym9VrZ8SJXDWaA1F4dmEyZZMUr1T0XY4gDYDIgk6fr5LX9HxQ2+Fj
         7wvFabzMYEMRyp4uPx4eWIbupir98V5wQV1t6fSRAFwVxBeHbbnYhUVyU2VFRkQjwhxL
         vySpvvIo7iwLt69cka9Ic9jAHwBdib8QaKrm7KQQ9Qn11OfSz516uDG8AdeSlssTofdR
         hhNQ==
X-Gm-Message-State: AOAM532J2W+TDkF8+tH8UvFenDLpZfc0fUmLGrFCMazMAqBTT94zDLFQ
        23fJUu+ofKZCqWfltDDJhUNwOw==
X-Google-Smtp-Source: ABdhPJwMORQTpYifpLCGD22BDyRns4eEbj+NoYV/5vmbXl7M9Sj9oFb03bz6IHoMsQGBTHnNyzmopg==
X-Received: by 2002:a05:600c:3848:: with SMTP id s8mr2565869wmr.151.1644354527869;
        Tue, 08 Feb 2022 13:08:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:47 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 10/19] fbcon: Ditch error handling for con2fb_release_oldinfo
Date:   Tue,  8 Feb 2022 22:08:15 +0100
Message-Id: <20220208210824.2238981-11-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't ever fail anymore.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/fbdev/core/fbcon.c | 37 +++++++++++---------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3e1a3e7bf527..a60891005d44 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -739,9 +739,8 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 	return err;
 }
 
-static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
-				  struct fb_info *newinfo, int unit,
-				  int oldidx, int found)
+static void con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
+				   struct fb_info *newinfo)
 {
 	struct fbcon_ops *ops = oldinfo->fbcon_par;
 	int ret;
@@ -770,8 +769,6 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 				"detected unhandled fb_set_par error, "
 				"error code %d\n", ret);
 	}
-
-	return 0;
 }
 
 static void con2fb_init_display(struct vc_data *vc, struct fb_info *info,
@@ -825,7 +822,7 @@ static int set_con2fb_map(int unit, int newidx, int user)
 	int oldidx = con2fb_map[unit];
 	struct fb_info *info = registered_fb[newidx];
 	struct fb_info *oldinfo = NULL;
-	int found, err = 0;
+	int found, err = 0, show_logo;
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -854,18 +851,15 @@ static int set_con2fb_map(int unit, int newidx, int user)
 	 * fbcon should release it.
 	 */
 	if (!err && oldinfo && !search_fb_in_map(oldidx))
-		err = con2fb_release_oldinfo(vc, oldinfo, info, unit, oldidx,
-					     found);
+		con2fb_release_oldinfo(vc, oldinfo, info);
 
-	if (!err) {
-		int show_logo = (fg_console == 0 && !user &&
-				 logo_shown != FBCON_LOGO_DONTSHOW);
+	show_logo = (fg_console == 0 && !user &&
+			 logo_shown != FBCON_LOGO_DONTSHOW);
 
-		if (!found)
-			fbcon_add_cursor_work(info);
-		con2fb_map_boot[unit] = newidx;
-		con2fb_init_display(vc, info, unit, show_logo);
-	}
+	if (!found)
+		fbcon_add_cursor_work(info);
+	con2fb_map_boot[unit] = newidx;
+	con2fb_init_display(vc, info, unit, show_logo);
 
 	if (!search_fb_in_map(info_idx))
 		info_idx = newidx;
@@ -2769,7 +2763,7 @@ static inline void fbcon_unbind(void) {}
 /* called with console_lock held */
 void fbcon_fb_unbind(struct fb_info *info)
 {
-	int i, new_idx = -1, ret = 0;
+	int i, new_idx = -1;
 	int idx = info->node;
 
 	WARN_CONSOLE_UNLOCKED();
@@ -2803,13 +2797,8 @@ void fbcon_fb_unbind(struct fb_info *info)
 			if (con2fb_map[i] == idx) {
 				con2fb_map[i] = -1;
 				if (!search_fb_in_map(idx)) {
-					ret = con2fb_release_oldinfo(vc_cons[i].d,
-								     info, NULL, i,
-								     idx, 0);
-					if (ret) {
-						con2fb_map[i] = idx;
-						return;
-					}
+					con2fb_release_oldinfo(vc_cons[i].d,
+							       info, NULL);
 				}
 			}
 		}
-- 
2.34.1

