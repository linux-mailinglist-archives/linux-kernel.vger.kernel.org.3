Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369874AE385
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386662AbiBHWW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386713AbiBHVIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:44 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6512C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso177060wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A3tTnMr0uLBBq314Z85FYSlmwFIYVNy3yQwXAflpqNU=;
        b=TFb2QU3rtSHoVZdJiHVZvumnVkhInsk+wCMJg8P7UFjC0BxdSuwwm1lmgr39cTAQp0
         ngMKu/F9v33MtAhNOOOaKSPVmb78N+5R1zMkbeg4XzZGw4nJ7Nwz4v8lcTDFwb8agLrw
         cdqX2t7ho1/lyYNo/mt86IWdCJimXrZ9E3cxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A3tTnMr0uLBBq314Z85FYSlmwFIYVNy3yQwXAflpqNU=;
        b=ppf1s+1YHvia8QbswHUHFjrhRzTlD3BI7OWFY9oD/rA0pDHLC0TNH7Vy4vNdK85UUl
         3jTWb/jk8kdkz2Ps+XkS53oRjgXjy1VNjT2+lSIsrEu3yzB9NkmJg48dRhMgFxKZd3fi
         UaqQHf9d0+g30DPFhihlXKOVJWG3sshbrQ0MTb1pgI/lnYF8D40JhW3K5IIoLacZ3Wmf
         LuMFBaPIedepwSXEm20AQSBsujpfzzJF6DvD7CCZNNRklugLuCnVTO5kYvDzFCsms4fg
         qIkB5yzMcjTNVgvcAg0kkhVBnH28RYmDDqsJm6LgZXWFZL4bLNa4nvv2BM/s2n8wxro7
         0iMA==
X-Gm-Message-State: AOAM53222RibULugJ362680ccJ67N6aAS5dXWtOjpsfacxTgT8T6qsqf
        FFz6+TQDCBxj1IctRu/dg5b1FA==
X-Google-Smtp-Source: ABdhPJy/MmzhXYLKsb7mnJJh9l95U3zWtlVma5KcWAwg0BTYSsMlJdIwPyk/OUMiHsCuauRvtiTE7Q==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr2625406wmq.186.1644354522253;
        Tue, 08 Feb 2022 13:08:42 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:40 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2 06/19] fbcon: Use delayed work for cursor
Date:   Tue,  8 Feb 2022 22:08:11 +0100
Message-Id: <20220208210824.2238981-7-daniel.vetter@ffwll.ch>
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

Allows us to delete a bunch of hand-rolled stuff. Also to simplify the
code we initialize the cursor_work completely when we allocate the
fbcon_ops structure, instead of trying to cope with console
re-initialization.

The motiviation here is that fbcon code stops using the fb_info.queue,
which helps with locking issues around cleanup and all that in a later
patch.

Also note that this allows us to ditch the hand-rolled work cleanup in
fbcon_exit - we already call fbcon_del_cursor_timer, which takes care
of everything. Plus this was racy anyway.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/video/fbdev/core/fbcon.c | 85 +++++++++++++-------------------
 drivers/video/fbdev/core/fbcon.h |  4 +-
 2 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 83f0223f5333..a368ed602e2e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -350,8 +350,8 @@ static int get_color(struct vc_data *vc, struct fb_info *info,
 
 static void fb_flashcursor(struct work_struct *work)
 {
-	struct fb_info *info = container_of(work, struct fb_info, queue);
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_ops *ops = container_of(work, struct fbcon_ops, cursor_work.work);
+	struct fb_info *info;
 	struct vc_data *vc = NULL;
 	int c;
 	int mode;
@@ -364,7 +364,10 @@ static void fb_flashcursor(struct work_struct *work)
 	if (ret == 0)
 		return;
 
-	if (ops && ops->currcon != -1)
+	/* protected by console_lock */
+	info = ops->info;
+
+	if (ops->currcon != -1)
 		vc = vc_cons[ops->currcon].d;
 
 	if (!vc || !con_is_visible(vc) ||
@@ -380,42 +383,25 @@ static void fb_flashcursor(struct work_struct *work)
 	ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 	console_unlock();
-}
 
-static void cursor_timer_handler(struct timer_list *t)
-{
-	struct fbcon_ops *ops = from_timer(ops, t, cursor_timer);
-	struct fb_info *info = ops->info;
-
-	queue_work(system_power_efficient_wq, &info->queue);
-	mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
+	queue_delayed_work(system_power_efficient_wq, &ops->cursor_work,
+			   ops->cur_blink_jiffies);
 }
 
-static void fbcon_add_cursor_timer(struct fb_info *info)
+static void fbcon_add_cursor_work(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if ((!info->queue.func || info->queue.func == fb_flashcursor) &&
-	    !(ops->flags & FBCON_FLAGS_CURSOR_TIMER) &&
-	    !fbcon_cursor_noblink) {
-		if (!info->queue.func)
-			INIT_WORK(&info->queue, fb_flashcursor);
-
-		timer_setup(&ops->cursor_timer, cursor_timer_handler, 0);
-		mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
-		ops->flags |= FBCON_FLAGS_CURSOR_TIMER;
-	}
+	if (!fbcon_cursor_noblink)
+		queue_delayed_work(system_power_efficient_wq, &ops->cursor_work,
+				   ops->cur_blink_jiffies);
 }
 
-static void fbcon_del_cursor_timer(struct fb_info *info)
+static void fbcon_del_cursor_work(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (info->queue.func == fb_flashcursor &&
-	    ops->flags & FBCON_FLAGS_CURSOR_TIMER) {
-		del_timer_sync(&ops->cursor_timer);
-		ops->flags &= ~FBCON_FLAGS_CURSOR_TIMER;
-	}
+	cancel_delayed_work_sync(&ops->cursor_work);
 }
 
 #ifndef MODULE
@@ -714,6 +700,8 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
 		if (!ops)
 			err = -ENOMEM;
+
+		INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
 	}
 
 	if (!err) {
@@ -751,7 +739,7 @@ static int con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 	}
 
 	if (!err) {
-		fbcon_del_cursor_timer(oldinfo);
+		fbcon_del_cursor_work(oldinfo);
 		kfree(ops->cursor_state.mask);
 		kfree(ops->cursor_data);
 		kfree(ops->cursor_src);
@@ -867,7 +855,7 @@ static int set_con2fb_map(int unit, int newidx, int user)
 				 logo_shown != FBCON_LOGO_DONTSHOW);
 
 		if (!found)
-			fbcon_add_cursor_timer(info);
+			fbcon_add_cursor_work(info);
 		con2fb_map_boot[unit] = newidx;
 		con2fb_init_display(vc, info, unit, show_logo);
 	}
@@ -964,6 +952,8 @@ static const char *fbcon_startup(void)
 		return NULL;
 	}
 
+	INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
+
 	ops->currcon = -1;
 	ops->graphics = 1;
 	ops->cur_rotate = -1;
@@ -1006,7 +996,7 @@ static const char *fbcon_startup(void)
 		 info->var.yres,
 		 info->var.bits_per_pixel);
 
-	fbcon_add_cursor_timer(info);
+	fbcon_add_cursor_work(info);
 	return display_desc;
 }
 
@@ -1194,7 +1184,7 @@ static void fbcon_deinit(struct vc_data *vc)
 		goto finished;
 
 	if (con_is_visible(vc))
-		fbcon_del_cursor_timer(info);
+		fbcon_del_cursor_work(info);
 
 	ops->flags &= ~FBCON_FLAGS_INIT;
 finished:
@@ -1320,9 +1310,9 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 		return;
 
 	if (vc->vc_cursor_type & CUR_SW)
-		fbcon_del_cursor_timer(info);
+		fbcon_del_cursor_work(info);
 	else
-		fbcon_add_cursor_timer(info);
+		fbcon_add_cursor_work(info);
 
 	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
 
@@ -2132,14 +2122,14 @@ static int fbcon_switch(struct vc_data *vc)
 		}
 
 		if (old_info != info)
-			fbcon_del_cursor_timer(old_info);
+			fbcon_del_cursor_work(old_info);
 	}
 
 	if (fbcon_is_inactive(vc, info) ||
 	    ops->blank_state != FB_BLANK_UNBLANK)
-		fbcon_del_cursor_timer(info);
+		fbcon_del_cursor_work(info);
 	else
-		fbcon_add_cursor_timer(info);
+		fbcon_add_cursor_work(info);
 
 	set_blitting_type(vc, info);
 	ops->cursor_reset = 1;
@@ -2247,9 +2237,9 @@ static int fbcon_blank(struct vc_data *vc, int blank, int mode_switch)
 
 	if (mode_switch || fbcon_is_inactive(vc, info) ||
 	    ops->blank_state != FB_BLANK_UNBLANK)
-		fbcon_del_cursor_timer(info);
+		fbcon_del_cursor_work(info);
 	else
-		fbcon_add_cursor_timer(info);
+		fbcon_add_cursor_work(info);
 
 	return 0;
 }
@@ -3181,7 +3171,7 @@ static ssize_t show_cursor_blink(struct device *device,
 	if (!ops)
 		goto err;
 
-	blink = (ops->flags & FBCON_FLAGS_CURSOR_TIMER) ? 1 : 0;
+	blink = delayed_work_pending(&ops->cursor_work);
 err:
 	console_unlock();
 	return snprintf(buf, PAGE_SIZE, "%d\n", blink);
@@ -3210,10 +3200,10 @@ static ssize_t store_cursor_blink(struct device *device,
 
 	if (blink) {
 		fbcon_cursor_noblink = 0;
-		fbcon_add_cursor_timer(info);
+		fbcon_add_cursor_work(info);
 	} else {
 		fbcon_cursor_noblink = 1;
-		fbcon_del_cursor_timer(info);
+		fbcon_del_cursor_work(info);
 	}
 
 err:
@@ -3314,15 +3304,9 @@ static void fbcon_exit(void)
 #endif
 
 	for_each_registered_fb(i) {
-		int pending = 0;
-
 		mapped = 0;
 		info = registered_fb[i];
 
-		if (info->queue.func)
-			pending = cancel_work_sync(&info->queue);
-		pr_debug("fbcon: %s pending work\n", (pending ? "canceled" : "no"));
-
 		for (j = first_fb_vc; j <= last_fb_vc; j++) {
 			if (con2fb_map[j] == i) {
 				mapped = 1;
@@ -3338,15 +3322,12 @@ static void fbcon_exit(void)
 			if (info->fbcon_par) {
 				struct fbcon_ops *ops = info->fbcon_par;
 
-				fbcon_del_cursor_timer(info);
+				fbcon_del_cursor_work(info);
 				kfree(ops->cursor_src);
 				kfree(ops->cursor_state.mask);
 				kfree(info->fbcon_par);
 				info->fbcon_par = NULL;
 			}
-
-			if (info->queue.func == fb_flashcursor)
-				info->queue.func = NULL;
 		}
 	}
 }
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 969d41ecede5..6708ca0048aa 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -14,11 +14,11 @@
 #include <linux/types.h>
 #include <linux/vt_buffer.h>
 #include <linux/vt_kern.h>
+#include <linux/workqueue.h>
 
 #include <asm/io.h>
 
 #define FBCON_FLAGS_INIT         1
-#define FBCON_FLAGS_CURSOR_TIMER 2
 
    /*
     *    This is the interface between the low-level console driver and the
@@ -68,7 +68,7 @@ struct fbcon_ops {
 	int  (*update_start)(struct fb_info *info);
 	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc);
 	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
-	struct timer_list cursor_timer; /* Cursor timer */
+	struct delayed_work cursor_work; /* Cursor timer */
 	struct fb_cursor cursor_state;
 	struct fbcon_display *p;
 	struct fb_info *info;
-- 
2.34.1

