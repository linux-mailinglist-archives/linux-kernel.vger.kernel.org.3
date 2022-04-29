Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CEC514488
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356065AbiD2IrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355992AbiD2Iqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1B0BC400A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GpZJ4wX7kOe8KNr9fDnXvQai/0Kn9GYbVZ0gMqgfC8g=;
        b=WUtPRD7NE/d2gGgFbZzDswqfdQ2Qn7UBp1lfOJNdZLTleJL6QETq72ou4yhfB6FNSwpeON
        CTDntLz6pNyOSvTPUMNXr7iXGcADNayGBQ+8wp+M4eBhfCtrTXH5oTQ4TcDX1Wr8NXVIsC
        5CJLRUBulQGCwBn6SlGTBYQy6bCJMsk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-DCjSJ6POPsuQmosYLW14wg-1; Fri, 29 Apr 2022 04:43:23 -0400
X-MC-Unique: DCjSJ6POPsuQmosYLW14wg-1
Received: by mail-wm1-f72.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso5597251wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpZJ4wX7kOe8KNr9fDnXvQai/0Kn9GYbVZ0gMqgfC8g=;
        b=aJDyLYDe+Z6G+wPGACOoHkpel9YWYcW4tCOcOZh99/54SYWpWhu5xHqym35PheXOMV
         lz67OCh8noCDJJ62tGMEUICn5SfmiOvXrFpwFKfUUnRUzof1bGcbzsl7/8MCZB1OU/Qs
         QqcICSVY2E6dalA2x73EdESpgYaHYBdIAldk4D4RRCLFkdBEXA+sKNZYnxuxeoMRnW+2
         cRD4vhIpg3+aUebpXdbndKiXj7uLb1sACYt/twQyuajha3KLpFChUPToOa/ZEbW40obl
         N0lEha+t9evQAdNjvpSDQKjPoCSsoROH1dCEH2fzlIKuuZ6txLdFMK/Rr49lt4LA1yuY
         0l5g==
X-Gm-Message-State: AOAM531SCC59ZjkAhPDNWn98ar7p9nul76d//L7qXiyByLohz+MjuWkg
        sBohwHbs8WrqlHf610WD5p09NS0MBhiYwvrD4/GRvTskuYsRHBwjwMJqOKV0iaVb0gaPc82XP9t
        iuvWMrq4F/ZvTiuawMV4FEkIpZ44GdA26QX+Szksv4xF7u4ozzKFMiRLAJgutGAd5bxR5yBCLE6
        o=
X-Received: by 2002:a05:600c:4ec6:b0:394:1f35:4c69 with SMTP id g6-20020a05600c4ec600b003941f354c69mr1752585wmq.61.1651221802322;
        Fri, 29 Apr 2022 01:43:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhmIBm7Rgju2BXAxf7jfHuCnxn2Uoy7l4mQ/iKVv2qM/3Q7Bt+zoSMdfHM0/61ANAlGkIsNA==
X-Received: by 2002:a05:600c:4ec6:b0:394:1f35:4c69 with SMTP id g6-20020a05600c4ec600b003941f354c69mr1752548wmq.61.1651221802012;
        Fri, 29 Apr 2022 01:43:22 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-fbdev@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Changcheng Deng <deng.changcheng@zte.com.cn>
Subject: [RFC PATCH v4 11/11] fbdev: Make registered_fb[] private to fbmem.c
Date:   Fri, 29 Apr 2022 10:42:53 +0200
Message-Id: <20220429084253.1085911-12-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

Well except when the olpc dcon fbdev driver is enabled, that thing
digs around in there in rather unfixable ways.

Cc oldc_dcon maintainers as fyi.

v2: I typoed the config name (0day)

Cc: kernel test robot <lkp@intel.com>
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/video/fbdev/core/fbmem.c | 8 ++++++--
 include/linux/fb.h               | 7 +++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 7583296481b0..1ce5b0f3abd4 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -50,10 +50,14 @@
 static DEFINE_MUTEX(registration_lock);
 
 struct fb_info *registered_fb[FB_MAX] __read_mostly;
-EXPORT_SYMBOL(registered_fb);
-
 int num_registered_fb __read_mostly;
+#if IS_ENABLED(CONFIG_FB_OLPC_DCON)
+EXPORT_SYMBOL(registered_fb);
 EXPORT_SYMBOL(num_registered_fb);
+#endif
+#define for_each_registered_fb(i)		\
+	for (i = 0; i < FB_MAX; i++)		\
+		if (!registered_fb[i]) {} else
 
 bool fb_center_logo __read_mostly;
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index b781bc721113..208bca693b33 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -623,16 +623,15 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 extern int fb_get_options(const char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
 
+#if IS_ENABLED(CONFIG_FB_OLPC_DCON)
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
2.35.1

