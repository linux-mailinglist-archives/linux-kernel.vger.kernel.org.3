Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A65A4AE43C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387486AbiBHW2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386739AbiBHVIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965A5C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:54 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e3so674843wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dejATrMlEFDMStF3OMugI910D6zgAzmO5LlqrLdpoQ=;
        b=Vg1y5QTUtQPV6CG6h9MGHsJhE0k2b69Rfhh2j1S9IuenRN1GWwvmFzFJpiuPcQwm9A
         8wtN+XoACH3DLsEdXmydVgZh8yHMegVuRM8+2Yff7ryLYiM9OyCcjpUEW/7GTKAx98je
         TMkLIra5W9DrBamN01sItC1ThQl5ST5R9mGcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dejATrMlEFDMStF3OMugI910D6zgAzmO5LlqrLdpoQ=;
        b=DEG9itv2lLZkFFwdVfQHO9PmDKiSpeiknR2Q5mEY8AEZEZbHfD4W5WmUBP/tPnezHe
         tXo9ynacF+xgRw2De4go23vsOwMzDLbrh6I2ZNKMPJVitlPYbHzOqh7WovZQJ7wMEiFC
         TQBCpj5CMD3ttweix5blXLm2kzmBEqdJLG/T/Wih07i4DtjYpcDTkvYxRiHalHIIemNZ
         7FVPr749k1/RgLe55elChQBnRx4Va6w4AVxn1cU7PBp8lpffi1HYJvp63CUgC0P9HeN4
         2wSgo6SpHavSCWkJ/4oOeFdJESZQhxZSTo2f6Wgwv/UrXB+u1cVhAr9yn3ZuSoU9HsGS
         tRKQ==
X-Gm-Message-State: AOAM53258PTUfnBOsYAT/E12n5c92mCXQ8H274pxSp9UI86gEwwV0LbV
        q0y1tuubj9FTpmJZP7pPaImYDg==
X-Google-Smtp-Source: ABdhPJxnNKHzn5v9jmu/dxkGA2+iLKqES3WUl0y1h3nMtz+C+V7YDVarwK1JvdMEbxQauvwana1kng==
X-Received: by 2002:a5d:46c5:: with SMTP id g5mr4776916wrs.406.1644354533075;
        Tue, 08 Feb 2022 13:08:53 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:52 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Du Cheng <ducheng2@gmail.com>, Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Matthew Wilcox <willy@infradead.org>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: [PATCH v2 14/19] fbcon: Move console_lock for register/unlink/unregister
Date:   Tue,  8 Feb 2022 22:08:19 +0100
Message-Id: <20220208210824.2238981-15-daniel.vetter@ffwll.ch>
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

Ideally console_lock becomes an implementation detail of fbcon.c and
doesn't show up anywhere in fbmem.c. We're still pretty far from that,
but at least the register/unregister code is there now.

With this the do_fb_ioctl() handler is the only code in fbmem.c still
calling console_lock().

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
---
 drivers/video/fbdev/core/fbcon.c | 33 ++++++++++++++++++++++++++------
 drivers/video/fbdev/core/fbmem.c | 23 ++--------------------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 4f9752ee9189..abb419a091c6 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2756,10 +2756,12 @@ void fbcon_fb_unbind(struct fb_info *info)
 	int i, new_idx = -1;
 	int idx = info->node;
 
-	WARN_CONSOLE_UNLOCKED();
+	console_lock();
 
-	if (!fbcon_has_console_bind)
+	if (!fbcon_has_console_bind) {
+		console_unlock();
 		return;
+	}
 
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] != idx &&
@@ -2794,6 +2796,8 @@ void fbcon_fb_unbind(struct fb_info *info)
 		}
 		fbcon_unbind();
 	}
+
+	console_unlock();
 }
 
 /* called with console_lock held */
@@ -2801,10 +2805,12 @@ void fbcon_fb_unregistered(struct fb_info *info)
 {
 	int i, idx;
 
-	WARN_CONSOLE_UNLOCKED();
+	console_lock();
 
-	if (deferred_takeover)
+	if (deferred_takeover) {
+		console_unlock();
 		return;
+	}
 
 	idx = info->node;
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
@@ -2833,6 +2839,7 @@ void fbcon_fb_unregistered(struct fb_info *info)
 
 	if (!num_registered_fb)
 		do_unregister_con_driver(&fb_con);
+	console_unlock();
 }
 
 void fbcon_remap_all(struct fb_info *info)
@@ -2890,19 +2897,27 @@ static inline void fbcon_select_primary(struct fb_info *info)
 }
 #endif /* CONFIG_FRAMEBUFFER_DETECT_PRIMARY */
 
+static bool lockless_register_fb;
+module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, 0400);
+MODULE_PARM_DESC(lockless_register_fb,
+	"Lockless framebuffer registration for debugging [default=off]");
+
 /* called with console_lock held */
 int fbcon_fb_registered(struct fb_info *info)
 {
 	int ret = 0, i, idx;
 
-	WARN_CONSOLE_UNLOCKED();
+	if (!lockless_register_fb)
+		console_lock();
+	else
+		atomic_inc(&ignore_console_lock_warning);
 
 	idx = info->node;
 	fbcon_select_primary(info);
 
 	if (deferred_takeover) {
 		pr_info("fbcon: Deferring console take-over\n");
-		return 0;
+		goto out;
 	}
 
 	if (info_idx == -1) {
@@ -2922,6 +2937,12 @@ int fbcon_fb_registered(struct fb_info *info)
 		}
 	}
 
+out:
+	if (!lockless_register_fb)
+		console_unlock();
+	else
+		atomic_dec(&ignore_console_lock_warning);
+
 	return ret;
 }
 
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 37656883e7bd..6f6f7a763969 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1594,14 +1594,9 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 	}
 }
 
-static bool lockless_register_fb;
-module_param_named_unsafe(lockless_register_fb, lockless_register_fb, bool, 0400);
-MODULE_PARM_DESC(lockless_register_fb,
-	"Lockless framebuffer registration for debugging [default=off]");
-
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
-	int i, ret;
+	int i;
 	struct fb_videomode mode;
 
 	if (fb_check_foreignness(fb_info))
@@ -1670,17 +1665,7 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	}
 #endif
 
-	if (!lockless_register_fb)
-		console_lock();
-	else
-		atomic_inc(&ignore_console_lock_warning);
-	ret = fbcon_fb_registered(fb_info);
-
-	if (!lockless_register_fb)
-		console_unlock();
-	else
-		atomic_dec(&ignore_console_lock_warning);
-	return ret;
+	return fbcon_fb_registered(fb_info);
 }
 
 static void unbind_console(struct fb_info *fb_info)
@@ -1690,9 +1675,7 @@ static void unbind_console(struct fb_info *fb_info)
 	if (WARN_ON(i < 0 || i >= FB_MAX || registered_fb[i] != fb_info))
 		return;
 
-	console_lock();
 	fbcon_fb_unbind(fb_info);
-	console_unlock();
 }
 
 static void unlink_framebuffer(struct fb_info *fb_info)
@@ -1735,9 +1718,7 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 		fb_notifier_call_chain(FB_EVENT_FB_UNREGISTERED, &event);
 	}
 #endif
-	console_lock();
 	fbcon_fb_unregistered(fb_info);
-	console_unlock();
 
 	/* this may free fb info */
 	put_fb_info(fb_info);
-- 
2.34.1

