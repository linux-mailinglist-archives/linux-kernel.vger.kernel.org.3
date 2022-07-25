Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E957FA8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiGYHyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiGYHyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2FEE12AC7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658735647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gjSp1VwYgFdF3r/pc3Q0KhJt/Ooi2/fe36LMyPMHMA0=;
        b=a3XE06xs+EBvZ6tOJljPn1vAbJ6DQgjR9xJkpmfWQD6h3jtDgviKbTox7NxQCH2gXjAQE2
        nlWjNQK/asszIrIAG1jAFOVF9GTQNm+O8ABpwywJAcpKY2i1h8mOeiKF3HaWvH/ut1fDkZ
        44UyWajOfcoE3HSwEszoz2MUvgFMQMA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-uOZZE0adO0Kx6TkcGcAw2w-1; Mon, 25 Jul 2022 03:54:06 -0400
X-MC-Unique: uOZZE0adO0Kx6TkcGcAw2w-1
Received: by mail-wm1-f70.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so3718383wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gjSp1VwYgFdF3r/pc3Q0KhJt/Ooi2/fe36LMyPMHMA0=;
        b=q7XuVktEpG3w/A8VMgr8x6l7Nmxxvlp6B8yFwGOFQ8aHlvTGEIINP95eo4K8Ybqz/G
         MsGJX0TKS24fO2XCqi++2uKLgkWk1E5rFHsTBrUU45lmCw+pZvCDtYjo+8ZIi2c7LU8O
         bLxqztX0W1arqFBBwwwmjPaP9R2XIyyUWOjdLyNAmCvlJcS2fzaZhEfUmTd8Swp5ixbP
         ZMU/T+bVTb0vIoowm1Pg3jZgrwttrKNjDL200pCQ/OoxfshIaJi2DB3E2ThCTSo4zfnm
         GY/mtaWRqBG41kvwwpNmGwXVoQPAy6ruAq/RV9i0ISzSIXz022qq4Cm0AP+whG6Zke9i
         e+jQ==
X-Gm-Message-State: AJIora8+BKMaSya4OnlJpPNqorTYHeMYInkd4BajeS40y/zj6gmfq6XO
        WcQh4kP7fg4dadNawBZ1whbqD4NctZla505uAW8kJGAZYknwegLxugf6mYEywRttAc2MyVs9m5v
        xl6gay7styE9PGqUQzSEdQkq0WoCKAg5j9TcHyuarGyzRqVdS6xLen9/dqzO1pHnb6y0D8zkGZH
        0=
X-Received: by 2002:a5d:4448:0:b0:21e:640d:337c with SMTP id x8-20020a5d4448000000b0021e640d337cmr6960394wrr.572.1658735645265;
        Mon, 25 Jul 2022 00:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1suU5FTfkKK40ECam9k1/4kpNk1ekZHVHPUssTBMkFcGkvOyZlSDPJGMC7bA8bJaSq6TebPUA==
X-Received: by 2002:a5d:4448:0:b0:21e:640d:337c with SMTP id x8-20020a5d4448000000b0021e640d337cmr6960371wrr.572.1658735645053;
        Mon, 25 Jul 2022 00:54:05 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003a33227e49bsm13439251wms.4.2022.07.25.00.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 00:54:04 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>, linux-fbdev@vger.kernel.org
Subject: [PATCH] fbdev: Make registered_fb[] private to fbmem.c
Date:   Mon, 25 Jul 2022 09:54:00 +0200
Message-Id: <20220725075400.68478-1-javierm@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

No driver access this anymore, except for the olpc dcon fbdev driver but
that has been marked as broken anyways by commit de0952f267ff ("staging:
olpc_dcon: mark driver as broken").

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c | 6 +++---
 include/linux/fb.h               | 6 ------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 6ae1c5fa19f9..1e70d8c67653 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -51,10 +51,10 @@
 static DEFINE_MUTEX(registration_lock);
 
 struct fb_info *registered_fb[FB_MAX] __read_mostly;
-EXPORT_SYMBOL(registered_fb);
-
 int num_registered_fb __read_mostly;
-EXPORT_SYMBOL(num_registered_fb);
+#define for_each_registered_fb(i)		\
+	for (i = 0; i < FB_MAX; i++)		\
+		if (!registered_fb[i]) {} else
 
 bool fb_center_logo __read_mostly;
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 453c3b2b6b8e..0aff76bcbb00 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -627,16 +627,10 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 extern int fb_get_options(const char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
 
-extern struct fb_info *registered_fb[FB_MAX];
-extern int num_registered_fb;
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
2.37.1

