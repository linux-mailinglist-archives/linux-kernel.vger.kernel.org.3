Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A9451449C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351258AbiD2Ira (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355973AbiD2Iqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D545213D3A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Brj5kPf1vp2+xvAmZf1o0QRVBdqqcyn2KbRWKGy9p24=;
        b=KRiVholFVymGUsJpTVvPRb7NrRH3lSM7Dpu4BkTZGjdyC/9tZIVePBwlr+62hA+NISF7Vw
        VINAN4s3Xj253Qi0w+EcHHBibrjzlhF+NAgyvdOtOH0Fe2dE2K4+RN+Z8KcPPYfv4C8Btn
        s7g1jLPJFzk3JCDDNqJ2sxBbKQ3OZ50=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-7rR3IuisO2qrCjeAS6RisA-1; Fri, 29 Apr 2022 04:43:16 -0400
X-MC-Unique: 7rR3IuisO2qrCjeAS6RisA-1
Received: by mail-wr1-f70.google.com with SMTP id d28-20020adf9b9c000000b0020ad4a50e14so2816537wrc.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Brj5kPf1vp2+xvAmZf1o0QRVBdqqcyn2KbRWKGy9p24=;
        b=wJHRLaLtPu2Rti5ffzZjs7maiSfUylpIt/Tx8PTzoPZP2qqpodrGjFj0wBfdghPeLA
         ta8zlcYEruzqh6FmdrxQn+sZ7NrhYwNMy/7z1yMfp5O/8IH9RzWprPi2l0qSnkEoXWs4
         rDlZO3e54oYpnSXkawlDD+78rwZSF/1Vy9fJkKmfBeI46vfEk4GQ4z0dhYRcB244Nbko
         X0SX85Kwy5bCBGYeAUwkJojT5FRlY/KQkYM+oLICBaE69TGeC6o17ufdsZaaoBtOSdeN
         Hx8sh9iU0Y+8lBTGDWoOuLF794vZ4+ANp667DKCFdbAU86/u531kqq1aGEsyborTpl4+
         AFvA==
X-Gm-Message-State: AOAM530k5FK1LgzbPSgxv8uZydMh2zUcELcLk4pwtNOiamlhUE8FC2n8
        M7R/3FBBGjibwjFwzgiWLHB0HvD6YtdypKtkJvEOpZdYhZMh4bwPpMpw9x+uZJnjPCqpQyUM/PX
        7Cn/hR0s3Ph9ohOe2oYCZCZaXrkd/ILLcFTZpPATT7sGdtr5KfAGx70NyaXNLLP+Yfbpyfb1N4E
        M=
X-Received: by 2002:a05:600c:1d9b:b0:393:ffc8:a09b with SMTP id p27-20020a05600c1d9b00b00393ffc8a09bmr2179627wms.40.1651221795122;
        Fri, 29 Apr 2022 01:43:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrVFdFCXeRphGLRkfrU/+tc/H0r7qF9nFcGL4D+eRkGaWuTGNr1P6BVgMPY5uynZbJ2i3UmQ==
X-Received: by 2002:a05:600c:1d9b:b0:393:ffc8:a09b with SMTP id p27-20020a05600c1d9b00b00393ffc8a09bmr2179599wms.40.1651221794848;
        Fri, 29 Apr 2022 01:43:14 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [RFC PATCH v4 06/11] fbdev: Restart conflicting fb removal loop when unregistering devices
Date:   Fri, 29 Apr 2022 10:42:48 +0200
Message-Id: <20220429084253.1085911-7-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

 drivers/video/fbdev/core/fbmem.c | 22 +++++++++++++++-------
 include/linux/fb.h               |  1 -
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 84427470367b..0bb459258df3 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1553,6 +1553,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 {
 	int i;
 
+restart_removal:
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for_each_registered_fb(i) {
 		struct apertures_struct *gen_aper;
@@ -1585,12 +1586,23 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 				pr_warn("fb%d: no device set\n", i);
 				do_unregister_framebuffer(registered_fb[i]);
 			} else if (dev_is_platform(device)) {
-				registered_fb[i]->forced_out = true;
+				/*
+				 * Drop the lock because if the device is unregistered, its
+				 * driver will call to unregister_framebuffer(), that takes
+				 * this lock.
+				 */
+				mutex_unlock(&registration_lock);
 				platform_device_unregister(to_platform_device(device));
+				mutex_lock(&registration_lock);
 			} else {
 				pr_warn("fb%d: cannot remove device\n", i);
 				do_unregister_framebuffer(registered_fb[i]);
 			}
+			/*
+			 * Restart the removal loop now that the device has been
+			 * unregistered and its associated framebuffer gone.
+			 */
+			goto restart_removal;
 		}
 	}
 }
@@ -1897,13 +1909,9 @@ EXPORT_SYMBOL(register_framebuffer);
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

