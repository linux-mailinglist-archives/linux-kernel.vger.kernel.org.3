Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9057D4F9A46
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiDHQQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiDHQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 161F224F0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649434428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QI3SswaraTV8idrWcTwBVC+GiIL0ijW6quL8YZNa3g=;
        b=M3A6/acuehP4pghs7lbcXYlRcrvqgcCiesf0C7wwQH53XQcCZVS6HIvSV08a9UVqsZl4yh
        1u+FJVBz9bha77tD/9m6YnBUJD71BaJ9MVTuCcF8WQN/RxGPioohCSIiWn4dEqvlhfkE7d
        9V0LkH6Z9BjeJ/ImIJLaf+oKHbXYS2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-GiJLFevQMg-V8W47Nsf9Kw-1; Fri, 08 Apr 2022 12:13:47 -0400
X-MC-Unique: GiJLFevQMg-V8W47Nsf9Kw-1
Received: by mail-wm1-f69.google.com with SMTP id x8-20020a7bc768000000b0038e73173886so4568164wmk.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 09:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7QI3SswaraTV8idrWcTwBVC+GiIL0ijW6quL8YZNa3g=;
        b=KWE/G2tAnwRM9F80FdMYoNDhlM9htb5Br50vZb5MZ16xosA0Hwq3ZFPvre4bmrHlZz
         0jY3CDaBQ/yiqPlTi8cjkb+1rhD2AWRshUTtGEg2/zEOYx8cYNZUUFnGgYpoKY5VoD68
         hehMWRLDRqn3Rruc2dA81eOSm9GBQzmtW6C+SQHDogkxNg0M9eyA3AdBRkqqrSWSPOu4
         o2nptSjzoOkoo9oUhsmhgSvjKP3LLQb8tRB/l7ryXwj12N40pu+RbXOweMPzZVjJwhYl
         zjnaxygj47+Ffc/lZ8koYgYDFFBrRs+kH5LyPt3iLAvF2Fb9lO4lnW1n1hTkG61Yyawx
         6PJA==
X-Gm-Message-State: AOAM5325em5dQGprhjE5w5DrHvCvc3r/lwkTX0t8cVpz8IMAHBsSSzze
        k16Ay1mmZIq4ufZ4WAKDlwYBHJCE2f2xdIAmrmn6o+OKEGKy8zYK+Ix/Qdpt6inCluELOphzsWG
        KwL64CKU2QaIY3FwuwPqrzKMHsEhtmFw57QM70/B46Xah+fshGuOXVTk62/uQy9nzK0oJ71S2en
        Q=
X-Received: by 2002:adf:fa4c:0:b0:205:7cb2:e6f0 with SMTP id y12-20020adffa4c000000b002057cb2e6f0mr15284866wrr.218.1649434425717;
        Fri, 08 Apr 2022 09:13:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYRy6iFg+nUxs9pKZmeBKF3byaeUvogbu8dmOibs9HJxOPyzETU8IRSiW1efmqzGmnYftbww==
X-Received: by 2002:adf:fa4c:0:b0:205:7cb2:e6f0 with SMTP id y12-20020adffa4c000000b002057cb2e6f0mr15284837wrr.218.1649434425421;
        Fri, 08 Apr 2022 09:13:45 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b002060d26c211sm14377455wrn.114.2022.04.08.09.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:13:45 -0700 (PDT)
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
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v2 4/5] fbdev: Fix some race conditions between fbmem and sysfb
Date:   Fri,  8 Apr 2022 18:13:21 +0200
Message-Id: <20220408161322.270176-5-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408161322.270176-1-javierm@redhat.com>
References: <20220408161322.270176-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform devices registered in sysfb match with a firmware-based fbdev
or DRM driver, that are used to have early graphics using framebuffers set
up by the system firmware.

Real DRM drivers later are probed and remove all conflicting framebuffers,
leading to these platform devices for generic drivers to be unregistered.

But the current solution has two issues that this patch fixes:

1) It is a layering violation for the fbdev core to unregister a device
   that was registered by sysfb.

   Instead, the sysfb_try_unregister() helper function can be called for
   sysfb to attempt unregistering the device if is the one registered.

2) The sysfb_init() function could be called after a DRM driver is probed
   and requested to unregister devices for drivers with a conflicting fb.

   To prevent this, disable any future sysfb platform device registration
   by calling sysfb_disable(), if a driver requested to remove conflicting
   framebuffers with remove_conflicting_framebuffers().

There are video drivers (e.g: vga16fb) that register their own device and
don't use the sysfb infrastructure for that, so an unregistration has to
be forced by fbmem if sysfb_try_unregister() fails to do the unregister.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

Changes in v2:
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).

 drivers/video/fbdev/core/fbmem.c | 42 +++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index bcdbbe543466..6cb73193410e 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/slab.h>
+#include <linux/sysfb.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/vt.h>
@@ -1582,22 +1583,30 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			 * this lock.
 			 */
 			mutex_unlock(&registration_lock);
-			if (dev_is_platform(device)) {
-				platform_device_unregister(to_platform_device(device));
-			} else {
-				/*
-				 * If it's not a platform device, at least print a warning. A
-				 * fix would add to code to remove the device from the system.
-				 */
-				pr_warn("fb%d: cannot remove device\n", i);
-				/* call unregister_framebuffer() so it can take the lock */
-				unregister_framebuffer(registered_fb[i]);
+			if (!sysfb_try_unregister(device)) {
+				if (dev_is_platform(device)) {
+					/*
+					 * FIXME: sysfb didn't register this device, is a platform
+					 * device registered by a video driver (e.g: vga16fb), so
+					 * force its unregistration here. A proper fix would be to
+					 * move all device registration to the sysfb infrastructure.
+					 */
+					platform_device_unregister(to_platform_device(device));
+				} else {
+					/*
+					 * If it's not a platform device, at least print a warning. A
+					 * fix would add to code to remove the device from the system.
+					 */
+					pr_warn("fb%d: cannot remove device\n", i);
+					/* call unregister_framebuffer() so it can take the lock */
+					unregister_framebuffer(registered_fb[i]);
+				}
 			}
-			mutex_lock(&registration_lock);
 			/*
 			 * Restart the removal loop now that the device has been
 			 * unregistered and its associated framebuffer gone.
 			 */
+			mutex_lock(&registration_lock);
 			goto restart_removal;
 		}
 	}
@@ -1758,6 +1767,17 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 		do_free = true;
 	}
 
+	/*
+	 * If a driver asked to unregister a platform device registered by
+	 * sysfb, then can be assumed that this is a driver for a display
+	 * that is set up by the system firmware and has a generic driver.
+	 *
+	 * Drivers for devices that don't have a generic driver will never
+	 * ask for this, so let's assume that a real driver for the display
+	 * was already probed and prevent sysfb to register devices later.
+	 */
+	sysfb_disable();
+
 	mutex_lock(&registration_lock);
 	do_remove_conflicting_framebuffers(a, name, primary);
 	mutex_unlock(&registration_lock);
-- 
2.35.1

