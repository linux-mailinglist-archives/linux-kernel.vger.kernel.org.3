Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123C14F6D60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiDFVvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiDFVvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6695C8BF4F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649281256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KV4A7vxPY5Ri/A7ExTRv30H1oUVvMjyO4SRhZ4A4Rkc=;
        b=dXE6l8ItUHG7lfOzxbQa27jOXaamr/83VPmdjCmeFbZSBTJreRXpt89WBvG2G7hmbZImMc
        6U1HoaiMwxs/fMTU6AofsUC59FKjMa7w8iz9Apexc2OzoKreiyOfEHBSfgJVddtXZTcLG2
        qYafIQFQjpWhdy5o8g6Lms5hBrdA8XE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-rNrAH_2dPluwDdhr0a7CzA-1; Wed, 06 Apr 2022 17:40:55 -0400
X-MC-Unique: rNrAH_2dPluwDdhr0a7CzA-1
Received: by mail-wm1-f72.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so1900228wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KV4A7vxPY5Ri/A7ExTRv30H1oUVvMjyO4SRhZ4A4Rkc=;
        b=be1OQF6Vt9UweEaDFprjuUkbc+ZK/1+WKNyVmMRp7PHeCXzwJAw5oCcGgQyVDYK5Og
         +V1aMqPWfH0XpgUP9OgM5ssAPKW9TIJaO+8j0XNSsthMzQS1C1Y7PCmT/tvlIO0JOYkn
         pu9MlI0pYeqgFSpZ8xXKdMilxToYuvk5a9OcMF/H0DOhJut8wZnE2RQ6nVWA75lPjm5z
         L/AH0zsNyXlcca2+a+6q2wPJXvjlEeiopVRzpybh3mRvbDyfQO3I3C4Q2XzzaRuLC1b4
         B8adKpv6cFMbliPKFNna4pO60zy1yx+SFNF6E9cMQlGvyKaiiVVCtYu32+/mMAnTXrbC
         sM9g==
X-Gm-Message-State: AOAM530MBSMk6A9fBnV5XPromGX2AbnyDyBkRD2a/6S1QlyyPH6ZG/4B
        LB6NAZ/8j3cSAopys8+MwpFkdu2rm0OHyRNom9u2QkJLNnpFaLioG/QGNKD8cpeuNQP/RRPMlaU
        9KIKiBmfIi9i6w8x2XdGI41UiVmMCqiqNXDQM9ltpFOVCUzb3FGtOCujs2FTK60cmChv0RiMwgW
        A=
X-Received: by 2002:adf:d1e8:0:b0:206:fdb:849 with SMTP id g8-20020adfd1e8000000b002060fdb0849mr8274624wrd.251.1649281253730;
        Wed, 06 Apr 2022 14:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/mJZqMWnMsmiDK/QHEbj6zIloBdqX55fsoP+DxKAu2//ICDmt3KL7sczE6heg786RoMwiDQ==
X-Received: by 2002:adf:d1e8:0:b0:206:fdb:849 with SMTP id g8-20020adfd1e8000000b002060fdb0849mr8274601wrd.251.1649281253422;
        Wed, 06 Apr 2022 14:40:53 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm5876020wms.15.2022.04.06.14.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:40:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org
Subject: [RESEND RFC PATCH 3/5] fbdev: Restart conflicting fb removal loop when unregistering devices
Date:   Wed,  6 Apr 2022 23:39:17 +0200
Message-Id: <20220406213919.600294-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406213919.600294-1-javierm@redhat.com>
References: <20220406213919.600294-1-javierm@redhat.com>
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
---

 drivers/video/fbdev/core/fbmem.c | 21 ++++++++++++++-------
 include/linux/fb.h               |  1 -
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index b585339509b0..c1bfb8df9cba 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1555,6 +1555,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 {
 	int i;
 
+restart_removal:
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for_each_registered_fb(i) {
 		struct apertures_struct *gen_aper;
@@ -1582,8 +1583,18 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			 * fix would add code to remove the device from the system.
 			 */
 			if (dev_is_platform(device)) {
-				registered_fb[i]->forced_out = true;
+				/*
+				 * Drop the lock since the driver will call to the
+				 * unregister_framebuffer() function that takes it.
+				 */
+				mutex_unlock(&registration_lock);
 				platform_device_unregister(to_platform_device(device));
+				mutex_lock(&registration_lock);
+				/*
+				 * Restart the removal now that the platform device
+				 * has been unregistered and its associated fb gone.
+				 */
+				goto restart_removal;
 			} else {
 				pr_warn("fb%d: cannot remove device\n", i);
 				do_unregister_framebuffer(registered_fb[i]);
@@ -1917,13 +1928,9 @@ EXPORT_SYMBOL(register_framebuffer);
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
index 39baa9a70779..f1e0cd751b06 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -503,7 +503,6 @@ struct fb_info {
 	} *apertures;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
-	bool forced_out; /* set when being removed by another driver */
 };
 
 static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-- 
2.35.1

