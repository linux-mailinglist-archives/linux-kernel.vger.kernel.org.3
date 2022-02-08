Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7464AE4C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388361AbiBHWcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386726AbiBHVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452BC0612BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s10so591417wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a7btPFkxjvf2mfzDClUDZxd+ZY9UWGCKfTqWfIAGZE4=;
        b=hC3hy+RQU0IwCFFhPrwVyJ7y2LIZTcjUzkEUlkvoHv0+/idoFt5rzVLYgDfL/hgQIi
         i2eeoFzpPEkt5fIvytjXjxYMYBVzGR7jyva3sSvlFHwg+sOFZrStM/ihrh+FHInpCE0T
         P8beATlmu3Ae4wYaareiwO9PDCh36eixaQNpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a7btPFkxjvf2mfzDClUDZxd+ZY9UWGCKfTqWfIAGZE4=;
        b=VbrNtW7tn2AOf3/tbnOhRKT+2f9spv1mOibtKiZDGt6GtpKGpQoGeeo9nKfQvKFIQH
         CHw8+ag2zVGumtWWhkrmNTC31CmSFw5k6oBcOW0AVL/D93oVj1jCVPg5jgW0+TfmEbdT
         J/LLi93bQPRZWkS3n+W5ds6VigxidfhZh1MPMG/K4HcoSwfT7VUYM2lrbHISfsoNZk8i
         5ktUkR1dhVfrNcx8/kQ7D8On3WCbUCAUsU0eU5I3seZxG8dkLBjRTabGSc8nngagV0eI
         Y6sJikAFq5loe5iv+RI0Dr+lRSObGirWLdz8WGLMuxz5x9OEu4kBeKWEcccZjqTmp+Gt
         cG8g==
X-Gm-Message-State: AOAM530hcJ3FMIe39XKishw8dOYjZxYnmnEWXKFinVGShRlLI8TGR+p2
        Q555cHRrXMuCrDAnfegsg7atlQ==
X-Google-Smtp-Source: ABdhPJxeKo6oxb1DStpx7vg2vbnJEG3khQpC5Pgmw0k9BwE0aQ7ghCQbgGVL5nA7XrrUJ87c2ZVJ6w==
X-Received: by 2002:a5d:4528:: with SMTP id j8mr5046963wra.544.1644354528995;
        Tue, 08 Feb 2022 13:08:48 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:48 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Claudio Suarez <cssk@net-c.es>, Du Cheng <ducheng2@gmail.com>
Subject: [PATCH v2 11/19] fbcon: move more common code into fb_open()
Date:   Tue,  8 Feb 2022 22:08:16 +0100
Message-Id: <20220208210824.2238981-12-daniel.vetter@ffwll.ch>
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

No idea why con2fb_acquire_newinfo() initializes much less than
fbcon_startup(), but so be it. From a quick look most of the
un-initialized stuff should be fairly harmless, but who knows.

Note that the error handling for the con2fb_acquire_newinfo() failure
case was very strange: Callers updated con2fb_map to the new value
before calling this function, but upon error con2fb_acquire_newinfo
reset it to the old value. Since I removed the call to fbcon_release
anyway that strange error path was sticking out like a sore thumb,
hence I removed it. Which also allows us to remove the oldidx
parameter from that function.

v2: Explain what's going on with oldidx and error paths (Sam)

v3: Drop unused variable (0day)

Acked-by: Sam Ravnborg <sam@ravnborg.org> (v2)
Cc: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Du Cheng <ducheng2@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 75 +++++++++++++-------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index a60891005d44..f0213a0e3870 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -682,8 +682,18 @@ static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
 
 #endif /* CONFIG_MISC_TILEBLITTING */
 
+static void fbcon_release(struct fb_info *info)
+{
+	if (info->fbops->fb_release)
+		info->fbops->fb_release(info, 0);
+
+	module_put(info->fbops->owner);
+}
+
 static int fbcon_open(struct fb_info *info)
 {
+	struct fbcon_ops *ops;
+
 	if (!try_module_get(info->fbops->owner))
 		return -ENODEV;
 
@@ -693,48 +703,31 @@ static int fbcon_open(struct fb_info *info)
 		return -ENODEV;
 	}
 
-	return 0;
-}
+	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
+	if (!ops) {
+		fbcon_release(info);
+		return -ENOMEM;
+	}
 
-static void fbcon_release(struct fb_info *info)
-{
-	if (info->fbops->fb_release)
-		info->fbops->fb_release(info, 0);
+	INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
+	ops->info = info;
+	info->fbcon_par = ops;
+	ops->cur_blink_jiffies = HZ / 5;
 
-	module_put(info->fbops->owner);
+	return 0;
 }
 
 static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
-				  int unit, int oldidx)
+				  int unit)
 {
-	struct fbcon_ops *ops = NULL;
 	int err;
 
 	err = fbcon_open(info);
 	if (err)
 		return err;
 
-	if (!err) {
-		ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
-		if (!ops)
-			err = -ENOMEM;
-
-		INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
-	}
-
-	if (!err) {
-		ops->cur_blink_jiffies = HZ / 5;
-		ops->info = info;
-		info->fbcon_par = ops;
-
-		if (vc)
-			set_blitting_type(vc, info);
-	}
-
-	if (err) {
-		con2fb_map[unit] = oldidx;
-		fbcon_release(info);
-	}
+	if (vc)
+		set_blitting_type(vc, info);
 
 	return err;
 }
@@ -842,9 +835,11 @@ static int set_con2fb_map(int unit, int newidx, int user)
 
 	found = search_fb_in_map(newidx);
 
-	con2fb_map[unit] = newidx;
-	if (!err && !found)
-		err = con2fb_acquire_newinfo(vc, info, unit, oldidx);
+	if (!err && !found) {
+		err = con2fb_acquire_newinfo(vc, info, unit);
+		if (!err)
+			con2fb_map[unit] = newidx;
+	}
 
 	/*
 	 * If old fb is not mapped to any of the consoles,
@@ -941,20 +936,10 @@ static const char *fbcon_startup(void)
 	if (fbcon_open(info))
 		return NULL;
 
-	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
-	if (!ops) {
-		fbcon_release(info);
-		return NULL;
-	}
-
-	INIT_DELAYED_WORK(&ops->cursor_work, fb_flashcursor);
-
+	ops = info->fbcon_par;
 	ops->currcon = -1;
 	ops->graphics = 1;
 	ops->cur_rotate = -1;
-	ops->cur_blink_jiffies = HZ / 5;
-	ops->info = info;
-	info->fbcon_par = ops;
 
 	p->con_rotate = initial_rotation;
 	if (p->con_rotate == -1)
@@ -1024,7 +1009,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 		return;
 
 	if (!info->fbcon_par)
-		con2fb_acquire_newinfo(vc, info, vc->vc_num, -1);
+		con2fb_acquire_newinfo(vc, info, vc->vc_num);
 
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
-- 
2.34.1

