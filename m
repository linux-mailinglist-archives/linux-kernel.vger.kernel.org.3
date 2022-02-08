Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3464AE416
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386693AbiBHWZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386712AbiBHVIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:08:41 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42295C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:08:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso1996710wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/n/16RZ52OxmA0UdDabSATFo04ROfy75nWG7tM3V6I=;
        b=hRasZriqWBEeJzoUOLv/QgNtugplRHjEQRKqik65NeifTKzyRf0hhvBW1KWOkIoadP
         3babK90zxgB9jGgUf/UNp4JC9Y+PrFYPgiRob7sYtSxpvX3uoVU0VosLdxIxxSp78Mvv
         nGxEaJzOsmX/d0hVbISOd5f0gVyHiJlADJFE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/n/16RZ52OxmA0UdDabSATFo04ROfy75nWG7tM3V6I=;
        b=s01LMQKXAEd4+6r0T4GkZlVlHp/QREockh9/wher2pNYIuB7NSNIgvjgZTw4PvABmf
         5Dr0DGxtOBS+BL+Y51j39jReNFphdqm0dNqrn2vBiQON4ychWIkG1VPewdb9lfgnmGHf
         TXZ9xWrlIKrk+2J01nWNTZNB9n3AEsKcJnsci8MUwXMg0TwC2k2XGDu33oQm/9Nel9w6
         u51Yp3P6Bk9ANMUrHMX1PoMDnVN4JSYdAL2Zk2WRpWxTwYHUKLjIHvdMaE6ql/UF8nIn
         PghNb8Dj7Bzfh3AU9uVZX7m7RY+Rigm1lfth5e5vipsK+VYpC9RVKiKx5qfQBcSkG1UC
         6Z7Q==
X-Gm-Message-State: AOAM5310n/EdBsZhInrdhR8xBFzbW7EckUIjMvKsDq0+MrPMVLpY1inf
        KIjYYHJtntBt2wuvkTMdx3V54w==
X-Google-Smtp-Source: ABdhPJxmKGvfzwrGcNB45zpKYvGa2R6htrHXkrCRtBsrNPeFRtFyXvFPfIN1bLeHK+Zv9iVuAwVA7Q==
X-Received: by 2002:a1c:f60b:: with SMTP id w11mr2637250wmc.138.1644354518818;
        Tue, 08 Feb 2022 13:08:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:35 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Qing Wang <wangqing@vivo.com>
Subject: [PATCH v2 05/19] fbdev/sysfs: Fix locking
Date:   Tue,  8 Feb 2022 22:08:10 +0100
Message-Id: <20220208210824.2238981-6-daniel.vetter@ffwll.ch>
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

fb_set_var requires we hold the fb_info lock. Or at least this now
matches what the ioctl does ...

Note that ps3fb and sh_mobile_lcdcfb are busted in different ways here,
but I will not fix them up.

Also in practice this isn't a big deal, because really variable fbdev
state is actually protected by console_lock (because fbcon just
doesn't bother with lock_fb_info() at all), and lock_fb_info
protecting anything is really just a neat lie. But that's a much
bigger fish to fry.

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Qing Wang <wangqing@vivo.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/video/fbdev/core/fbsysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 26892940c213..8c1ee9ecec3d 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -91,9 +91,11 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 
 	var->activate |= FB_ACTIVATE_FORCE;
 	console_lock();
+	lock_fb_info(fb_info);
 	err = fb_set_var(fb_info, var);
 	if (!err)
 		fbcon_update_vcs(fb_info, var->activate & FB_ACTIVATE_ALL);
+	unlock_fb_info(fb_info);
 	console_unlock();
 	if (err)
 		return err;
-- 
2.34.1

