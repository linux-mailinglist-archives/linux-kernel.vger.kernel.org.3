Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8D04F9A43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiDHQQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiDHQPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75F4D106638
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649434426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zcEitY10iZAiJ+J3+u8UtqIoWNDWTfj8MjNNemYgu3M=;
        b=RT50AdxshudiL9//klnex79SPAzomTCteajelybwihE7Pze5BBXwnjSg9BSupBoTQFcaWZ
        3V3K6ZtLldAgyq9SK+Qz8uzB1xYBqMiMUHPe3v/AizbTiQk9YD57xfJeZwSTetfKlxsU4L
        PSn2L9k55Ksoa5VsXVxl238ALk0tdbQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-4RV9tRvJOReX3hB0cxCATw-1; Fri, 08 Apr 2022 12:13:45 -0400
X-MC-Unique: 4RV9tRvJOReX3hB0cxCATw-1
Received: by mail-wm1-f71.google.com with SMTP id f12-20020a05600c154c00b0038ea9ed0a4aso712357wmg.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 09:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcEitY10iZAiJ+J3+u8UtqIoWNDWTfj8MjNNemYgu3M=;
        b=1DfNZ0XIvDbiO1wanLau4cNCz86pNnVC75xx5fMgVDasev65GhEDSY6NgqLQkWAVRl
         aWM+Igk9h1rkACbmhIwpmTvf1OkRkkG+dt8HJfZa1B8QF+jMRXjN6O+mrBwwOgL3XsYd
         hjis95ZY11JnePH44H7mAgIEG40/kTuQlMM0PLLL84aFjHkzPN2l42bMVM7boRO4/XRL
         EKD9rmSa4F4xZyMV4Hb6r8cjSvT6dyKHKH6MIF1QChMnEVGI4C59QqZtLbLDMzDDLPoF
         UZhKDm+GEO6Zkrf4UGCeCCSR+EzDJ7py+sCW24dcuU+zR+qsICz+JUjLCO6P0q0R8eAm
         0zQg==
X-Gm-Message-State: AOAM533ebl1om4o9yIMHLKYAs6tfNXjnz3iYDKYwBeks2m4vLtypPYqG
        QtBKJBlPk3vmwLaoyyrign1u1imP0Bq2TmcC/cAu+qL9r75jZPMOodaMdrgYVhfDBK3GgspbdE8
        La1zKKRjlN3QEjm7HLkSDqE71aSZAU8Chze+TeWQs2wPX4FqH7GLar2YVIHWjda+BgwvK5nckN3
        w=
X-Received: by 2002:a5d:6785:0:b0:204:f8f:8fab with SMTP id v5-20020a5d6785000000b002040f8f8fabmr15369353wru.353.1649434423709;
        Fri, 08 Apr 2022 09:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt3Rj+zw8mIsN24LhLbQy+hWefHkvvpTKfeMVqAFvoZziJC7qiikDxng1MGBPfgLZBQiYEtg==
X-Received: by 2002:a5d:6785:0:b0:204:f8f:8fab with SMTP id v5-20020a5d6785000000b002040f8f8fabmr15369313wru.353.1649434423340;
        Fri, 08 Apr 2022 09:13:43 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b002060d26c211sm14377455wrn.114.2022.04.08.09.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:13:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v2 3/5] fbdev: Restart conflicting fb removal loop when unregistering devices
Date:   Fri,  8 Apr 2022 18:13:20 +0200
Message-Id: <20220408161322.270176-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408161322.270176-1-javierm@redhat.com>
References: <20220408161322.270176-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers that want to remove registered conflicting framebuffers prior to
register their own framebuffer, calls remove_conflicting_framebuffers().

This function takes the registration_lock mutex, to prevent a races when
drivers register framebuffer devices. But if a conflicting framebuffer
device is found, the underlaying platform device is unregistered and this
will lead to the platform driver .remove callback to be called, which in
turn will call to the unregister_framebuffer() that takes the same lock.

To prevent this, a struct fb_info.forced_out field was used as indication
to unregister_framebuffer() whether the mutex has to be grabbed or not.

A cleaner solution is to drop the lock before platform_device_unregister()
so unregister_framebuffer() can take it when called from the fbdev driver,
and just grab the lock again after the device has been registered and do
a removal loop restart.

Since the framebuffer devices will already be removed, the loop would just
finish when no more conflicting framebuffers are found.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

(no changes since v1)

 drivers/video/fbdev/core/fbmem.c | 29 +++++++++++++++++++----------
 include/linux/fb.h               |  1 -
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index bdd00d381bbc..bcdbbe543466 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1553,6 +1553,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 {
 	int i;
 
+restart_removal:
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for_each_registered_fb(i) {
 		struct apertures_struct *gen_aper;
@@ -1576,16 +1577,28 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			 * VESA, EFI, etc. A native driver will then be able to
 			 * allocate the memory range.
 			 *
-			 * If it's not a platform device, at least print a warning. A
-			 * fix would add code to remove the device from the system.
+			 * Drop the lock because if the device is unregistered, its
+			 * drivers will call to unregister_framebuffer() that takes
+			 * this lock.
 			 */
+			mutex_unlock(&registration_lock);
 			if (dev_is_platform(device)) {
-				registered_fb[i]->forced_out = true;
 				platform_device_unregister(to_platform_device(device));
 			} else {
+				/*
+				 * If it's not a platform device, at least print a warning. A
+				 * fix would add to code to remove the device from the system.
+				 */
 				pr_warn("fb%d: cannot remove device\n", i);
-				do_unregister_framebuffer(registered_fb[i]);
+				/* call unregister_framebuffer() so it can take the lock */
+				unregister_framebuffer(registered_fb[i]);
 			}
+			mutex_lock(&registration_lock);
+			/*
+			 * Restart the removal loop now that the device has been
+			 * unregistered and its associated framebuffer gone.
+			 */
+			goto restart_removal;
 		}
 	}
 }
@@ -1892,13 +1905,9 @@ EXPORT_SYMBOL(register_framebuffer);
 void
 unregister_framebuffer(struct fb_info *fb_info)
 {
-	bool forced_out = fb_info->forced_out;
-
-	if (!forced_out)
-		mutex_lock(&registration_lock);
+	mutex_lock(&registration_lock);
 	do_unregister_framebuffer(fb_info);
-	if (!forced_out)
-		mutex_unlock(&registration_lock);
+	mutex_unlock(&registration_lock);
 }
 EXPORT_SYMBOL(unregister_framebuffer);
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f95da1af9ff6..b781bc721113 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -502,7 +502,6 @@ struct fb_info {
 	} *apertures;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
-	bool forced_out; /* set when being removed by another driver */
 };
 
 static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-- 
2.35.1

