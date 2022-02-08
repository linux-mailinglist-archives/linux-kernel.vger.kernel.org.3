Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6384AE463
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352377AbiBHWaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386731AbiBHVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:52 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA982C0612BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i14so536844wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vhsaJLRuFd4cLY+OipxjxgQ9+hkB2eOCoIWIkwzsX4=;
        b=hSTzBYbk+EsRstvMat5gULyq5OnxonnqMQZDYW4OJ03WdVZriqwshzqAMnR7z6Mxs/
         W6MTAgwmuJNCwpePfGNu5wjMP+TCcIEb/7e82sC/9tyzHPsI/T9dN7TU5AUq23/yggHX
         dBWuat8BzdR3DTzRrJ0Hynpwp08gs8C0OyboY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vhsaJLRuFd4cLY+OipxjxgQ9+hkB2eOCoIWIkwzsX4=;
        b=OYg4059kv9HWSXl2b0YONUpqx/XLE+og13GH9Ze56zf7c/sMY0CFwPGF1uvH6oSVzb
         vg469kDOoozp7TzDgLszSf7PoBLVRwK+P5GT4Ux/JX47AjYRsqjdX+xTlB5MaFvFf/9J
         zETNtvoMJfMxE4A5fJzVGA7RJFvKDVLGhRJANl1tBKAKy3Xu3uLqEvgBPcsqJEmJdRjf
         f+BSd7D7wSoY8xEUjMQeSSR3gO0n55EbUpZSH53mgErauuRR38o4dNJNXm7XodLZPNtb
         he1GRjh4tCcmtEQf5qj2fr9I7ZpfdQ6TiwqK8N9ZWHxwtHuy1pqDYl0cV/4HIW1lz91K
         x1gw==
X-Gm-Message-State: AOAM530lIdjwsAFM436seckKAWrMCRFQ+tG/1ostWHldDqdgZ3RQctPN
        oaHO7RH+IqBy1KcYehRCU3SLmA==
X-Google-Smtp-Source: ABdhPJx34FaRILEJCtAru2c7l4UL1l3tfbLxaWVDlH2pbi+Y5VD+HSoJSIbcO7Y6315RPOWA+MZjag==
X-Received: by 2002:a5d:5246:: with SMTP id k6mr4924929wrc.89.1644354530369;
        Tue, 08 Feb 2022 13:08:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:49 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Claudio Suarez <cssk@net-c.es>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Du Cheng <ducheng2@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: [PATCH v2 12/19] fbcon: use lock_fb_info in fbcon_open/release
Date:   Tue,  8 Feb 2022 22:08:17 +0100
Message-Id: <20220208210824.2238981-13-daniel.vetter@ffwll.ch>
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

Now we get to the real motiviation, because fbmem.c insists that
that's the right lock for these.

Ofc fbcon.c has a lot more places where it probably should call
lock_fb_info(). But looking at fbmem.c at least most of these seem to
be protected by console_lock() too, which is probably what papers over
any issues.

Note that this means we're shuffling around a bit the locking sections
for some of the console takeover and unbind paths, but not all:
- console binding/unbinding from the console layer never with
lock_fb_info
- unbind (as opposed to unlink) never bother with lock_fb_info

Also the real serialization against set_par and set_pan are still
doing by wrapping the entire ioctl code in console_lock(). So this
shuffling shouldn't be worse than what we had from a "can you trigger
races?" pov, but it's at least clearer.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Du Cheng <ducheng2@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
---
 drivers/video/fbdev/core/fbcon.c | 5 +++++
 drivers/video/fbdev/core/fbmem.c | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index f0213a0e3870..cc960bf49991 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -684,8 +684,10 @@ static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
 
 static void fbcon_release(struct fb_info *info)
 {
+	lock_fb_info(info);
 	if (info->fbops->fb_release)
 		info->fbops->fb_release(info, 0);
+	unlock_fb_info(info);
 
 	module_put(info->fbops->owner);
 }
@@ -697,11 +699,14 @@ static int fbcon_open(struct fb_info *info)
 	if (!try_module_get(info->fbops->owner))
 		return -ENODEV;
 
+	lock_fb_info(info);
 	if (info->fbops->fb_open &&
 	    info->fbops->fb_open(info, 0)) {
+		unlock_fb_info(info);
 		module_put(info->fbops->owner);
 		return -ENODEV;
 	}
+	unlock_fb_info(info);
 
 	ops = kzalloc(sizeof(struct fbcon_ops), GFP_KERNEL);
 	if (!ops) {
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index ad9aac06427a..37656883e7bd 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1674,9 +1674,7 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 		console_lock();
 	else
 		atomic_inc(&ignore_console_lock_warning);
-	lock_fb_info(fb_info);
 	ret = fbcon_fb_registered(fb_info);
-	unlock_fb_info(fb_info);
 
 	if (!lockless_register_fb)
 		console_unlock();
@@ -1693,9 +1691,7 @@ static void unbind_console(struct fb_info *fb_info)
 		return;
 
 	console_lock();
-	lock_fb_info(fb_info);
 	fbcon_fb_unbind(fb_info);
-	unlock_fb_info(fb_info);
 	console_unlock();
 }
 
-- 
2.34.1

