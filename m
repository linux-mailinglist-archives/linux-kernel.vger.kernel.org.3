Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BB04A5117
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380331AbiAaVIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380237AbiAaVG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:06:59 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E66C061753
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:51 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso230560wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLCFktF5bXfVELdSs1sFnaEEXohencjsFb8X+BTPOv4=;
        b=IHzC2SevZm5+o9SbqNmhgWdJDul0iEkmYGyVGe/SmayW6tHVYAPf+A5/26FIZeTE+D
         0VOw3ADfS5vBpiQTuUGs2n8y+G19uSujvFy7DZ7THok1dM7BC3LIlrb046oFUnkEtglA
         ktiGzuVyyG84pbn82uIEzbyH2elqAexWphQIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLCFktF5bXfVELdSs1sFnaEEXohencjsFb8X+BTPOv4=;
        b=GTG5CwIM5MJnN2j1i4BrxSUA0xGlNOWQGoxNM4L8GIYdDIofWXQx6pA3FBISbyegze
         D3xi50Czm2pbjIV8apYvU3XdjjqJjTUT0LCG6H4ZVTHwWTG6SP+u1LjRsfIkuaYQu7X2
         EdifWZ3k1FVYbxeydSwSpaouVs8xxHNUtZ5O43n3UVdzXPVwP1AXHA6pQETfJXGvHbY0
         0dy4OZfI6wnCmTrSX6JOjqBMUgKGO7P9ZaR2ibcB7SZ5b2geb7uUy7jYXX5wdCDnKHP0
         9G7U4cMfLYYaKUKGdWGB3GfKc5S3KCuwi2ckxQ52eyUod/4QZLVblr9NqgF7FZ7+lxY1
         ERvQ==
X-Gm-Message-State: AOAM532NjHyxXeTGQnqx9GKMY3PRz2L/r0ntUJqndV8lAOGK2AEOkowh
        C+PFFazKlcLGo5ysRpvirEP3zw==
X-Google-Smtp-Source: ABdhPJwL5EQol13tK1r2sH3cLNG0kbIqqGvoNKhVRDedFDmv74vH5tVE+s2M6mlbGpn9cwEZu83+7w==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr28651132wmq.44.1643663210600;
        Mon, 31 Jan 2022 13:06:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:50 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Du Cheng <ducheng2@gmail.com>, Claudio Suarez <cssk@net-c.es>
Subject: [PATCH 17/21] fbcon: Move more code into fbcon_release
Date:   Mon, 31 Jan 2022 22:05:48 +0100
Message-Id: <20220131210552.482606-18-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

con2fb_release_oldinfo() has a bunch more kfree() calls than
fbcon_exit(), but since kfree() on NULL is harmless doing that in both
places should be ok. This is also a bit more symmetric now again with
fbcon_open also allocating the fbcon_ops structure.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Claudio Suarez <cssk@net-c.es>
---
 drivers/video/fbdev/core/fbcon.c | 33 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index e5e8aaf6f60d..5c14e24d14a1 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -688,6 +688,18 @@ static void fbcon_release(struct fb_info *info)
 	unlock_fb_info(info);
 
 	module_put(info->fbops->owner);
+
+	if (info->fbcon_par) {
+		struct fbcon_ops *ops = info->fbcon_par;
+
+		fbcon_del_cursor_work(info);
+		kfree(ops->cursor_state.mask);
+		kfree(ops->cursor_data);
+		kfree(ops->cursor_src);
+		kfree(ops->fontbuffer);
+		kfree(info->fbcon_par);
+		info->fbcon_par = NULL;
+	}
 }
 
 static int fbcon_open(struct fb_info *info)
@@ -741,18 +753,10 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 static void con2fb_release_oldinfo(struct vc_data *vc, struct fb_info *oldinfo,
 				   struct fb_info *newinfo)
 {
-	struct fbcon_ops *ops = oldinfo->fbcon_par;
 	int ret;
 
 	fbcon_release(oldinfo);
 
-	fbcon_del_cursor_work(oldinfo);
-	kfree(ops->cursor_state.mask);
-	kfree(ops->cursor_data);
-	kfree(ops->cursor_src);
-	kfree(ops->fontbuffer);
-	kfree(oldinfo->fbcon_par);
-	oldinfo->fbcon_par = NULL;
 	/*
 	  If oldinfo and newinfo are driving the same hardware,
 	  the fb_release() method of oldinfo may attempt to
@@ -3335,19 +3339,8 @@ static void fbcon_exit(void)
 			}
 		}
 
-		if (mapped) {
-			if (info->fbcon_par) {
-				struct fbcon_ops *ops = info->fbcon_par;
-
-				fbcon_del_cursor_work(info);
-				kfree(ops->cursor_src);
-				kfree(ops->cursor_state.mask);
-				kfree(info->fbcon_par);
-				info->fbcon_par = NULL;
-			}
-
+		if (mapped)
 			fbcon_release(info);
-		}
 	}
 }
 
-- 
2.33.0

