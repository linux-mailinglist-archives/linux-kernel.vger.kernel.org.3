Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC005231B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239240AbiEKLbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbiEKLa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:30:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 804771DA44
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKBAcv9/i+j+NmGeneztCrY9Hfc9zc/TOb5Jz8UH/dw=;
        b=anNttK3x9fdg73xyi/P2jnkHt8EfP84bb+mtIi8eGAR+Zj9LwtfNcIi5NRfAxlA9jYKjiq
        DZRmaSgunDVpLDP8L0gsE21//FdXSQNJKyaGZ1rdOWPP+Q6lf5X7jc6MnyN7wtuckQXEr+
        uuEKlH4JeAX4JFg/7PY0JXGZUxxbJZ0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-316-nyoCIZJeNeiFeYH5AR2l9Q-1; Wed, 11 May 2022 07:30:54 -0400
X-MC-Unique: nyoCIZJeNeiFeYH5AR2l9Q-1
Received: by mail-wr1-f70.google.com with SMTP id o18-20020adfcf12000000b0020cdc76ea11so740340wrj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKBAcv9/i+j+NmGeneztCrY9Hfc9zc/TOb5Jz8UH/dw=;
        b=gM2cvfpJSbZycoa1bpjY8yhNEsWORmSnC3clb7Ig1aaN0SjJ3wXsOHWJeQRVaVe865
         l1X+tqOaUspuk7IX/PpuD+MEvQKFDno5ntmQK+30wl0u1W42rw/w9k2rum8IyQ1vFQvN
         MjHFtTaS36OUAYJ0998dSXu6o8sgfjhEnSpn53DjFeyGTW9xmKLAsHyQsMJT4T9xeGlJ
         lhovnuCTDthx6tHL04V9aH5N6U3FkotGphwRJSVtsN9VjHt3rtDzj7JBAFhcUHxJIA/G
         5C/Ia4IWJ40V+mXys5xLDwEMgZwMpv2q7AidF+K4XzvegJO3UeBfF4fG750LqQu+90e0
         Ka8g==
X-Gm-Message-State: AOAM533TouVUku3QatJ/D1eD9cme3fdvQXTKY4KVnvVEzFlqGw4hbyWJ
        sJKupUrho4GOw35+mLGxZs5xGkI7KVmD1yVHe+r3eDnNCpnP94Gsx8jJjRuj7gHiqLMPCU0xGoy
        i45rwbF+bLLy7JV8xhh04/0bXOKTk52VQgA33JW5bbdBHIOIMmrJeUswxx+41EE3IePDsH6AQhD
        o=
X-Received: by 2002:adf:9dcc:0:b0:20a:ed44:fd48 with SMTP id q12-20020adf9dcc000000b0020aed44fd48mr22330195wre.120.1652268653208;
        Wed, 11 May 2022 04:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIJjtshhhNaPS9SyMj2B6z8Yib37iNGrRjx/XQ5eyK5wW8o/9hh+eocyK9ixZaPPybN81Bxg==
X-Received: by 2002:adf:9dcc:0:b0:20a:ed44:fd48 with SMTP id q12-20020adf9dcc000000b0020aed44fd48mr22330167wre.120.1652268652888;
        Wed, 11 May 2022 04:30:52 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d4049000000b0020c5253d8cfsm1722625wrp.27.2022.05.11.04.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:30:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 3/7] fbdev: Restart conflicting fb removal loop when unregistering devices
Date:   Wed, 11 May 2022 13:30:39 +0200
Message-Id: <20220511113039.1252432-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511112438.1251024-1-javierm@redhat.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index b445a7a00def..2fda5917c212 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1555,6 +1555,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 {
 	int i;
 
+restart_removal:
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for_each_registered_fb(i) {
 		struct apertures_struct *gen_aper;
@@ -1587,12 +1588,23 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
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
@@ -1899,13 +1911,9 @@ EXPORT_SYMBOL(register_framebuffer);
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
index 69c67c70fa78..bbe1e4571899 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -511,7 +511,6 @@ struct fb_info {
 	} *apertures;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
-	bool forced_out; /* set when being removed by another driver */
 };
 
 static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-- 
2.35.1

