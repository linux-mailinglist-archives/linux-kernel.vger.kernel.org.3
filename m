Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4314A5120
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381332AbiAaVJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380665AbiAaVHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:07:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B928C061773
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e2so27978316wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FxNR4P5lDXdqDoRY6o7wMDtTBWXikuXUtP+0kdBf7FQ=;
        b=Lo4AW9guvOF81u6WGQBXjsTZUvFuBcQIdzBj2fKuxIY0ijvWI/WKVVcAEew+wpAmNv
         T9o5T51UXeGAC8PY0e/dJSsEAeJCL79CCkRMNfyQnjXBUsH8+RxF6XddMCurXVkMGdfT
         UwQJSGBW+iiRzyYdMPsOrpy+yu64udBa1ILAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FxNR4P5lDXdqDoRY6o7wMDtTBWXikuXUtP+0kdBf7FQ=;
        b=Zs7k2cumxjGybbH+asvNzk93p4ontH2a3ehSRi59G7vqgy3skKMMS3FbqH5AXnwHCk
         eK+GujLipdSXXCSxYVXtW5CTKkVETGQlVjXYDz36cVKf7TTdTdr8bmoPV13yinw5XbW5
         ELjvCGqgJH7RASTWOK/WTxL/hm+QG2ecNF+h1OaHEbJIDA17txNPUDHEZxuaXHChEOa8
         urQJdNQgG0p2UMH0kJXLqIktal8S3c4WzpVTsEqTOtyxlESJa4NL9tb+/kP/HGR1mZqN
         1TGla51iGq64aozPEHd25rbAQsODmlgEsMYvtpNFJcn10xpAeTRYYiPVQFn2Uy9b3+B8
         OL6g==
X-Gm-Message-State: AOAM530vxmv3XnXOs4/0sktNrvEdYWOiLDHR/thKtlAW79PaLN9mG6RX
        LCgayFwKOmKBYNffOKhCIPUv9g==
X-Google-Smtp-Source: ABdhPJwF2QvK4hmf/7QGpz8EsMBpbsf23W007iTEYAPXtLNPFXTESQvIlo2rylKpGsmivnZGCNYQaQ==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr10214483wrn.284.1643663214293;
        Mon, 31 Jan 2022 13:06:54 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b11sm314961wmq.46.2022.01.31.13.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:06:53 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 21/21] fbdev: Make registered_fb[] private to fbmem.c
Date:   Mon, 31 Jan 2022 22:05:52 +0100
Message-Id: <20220131210552.482606-22-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well except when the olpc dcon fbdev driver is enabled, that thing
digs around in there in rather unfixable ways.

Cc oldc_dcon maintainers as fyi.

Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc: linux-fbdev@vger.kernel.org
Cc: Zheyu Ma <zheyuma97@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/video/fbdev/core/fbmem.c | 8 ++++++--
 include/linux/fb.h               | 7 +++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 904ef1250677..dad6572942fa 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -48,10 +48,14 @@
 static DEFINE_MUTEX(registration_lock);
 
 struct fb_info *registered_fb[FB_MAX] __read_mostly;
-EXPORT_SYMBOL(registered_fb);
-
 int num_registered_fb __read_mostly;
+#if IS_ENABLED(CONFIG_OLPC_DCON)
+EXPORT_SYMBOL(registered_fb);
 EXPORT_SYMBOL(num_registered_fb);
+#endif
+#define for_each_registered_fb(i)		\
+	for (i = 0; i < FB_MAX; i++)		\
+		if (!registered_fb[i]) {} else
 
 bool fb_center_logo __read_mostly;
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a8a00d2ba1f3..e236817502c2 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -622,16 +622,15 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 extern int fb_get_options(const char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
 
+#if IS_ENABLED(CONFIG_OLPC_DCON)
 extern struct fb_info *registered_fb[FB_MAX];
+
 extern int num_registered_fb;
+#endif
 extern bool fb_center_logo;
 extern int fb_logo_count;
 extern struct class *fb_class;
 
-#define for_each_registered_fb(i)		\
-	for (i = 0; i < FB_MAX; i++)		\
-		if (!registered_fb[i]) {} else
-
 static inline void lock_fb_info(struct fb_info *info)
 {
 	mutex_lock(&info->lock);
-- 
2.33.0

