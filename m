Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3555F50842F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377018AbiDTI4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376988AbiDTI4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E00B23B2B3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650444804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ipOD+iHYz0MO8ka3xCh5rdeCaG6XqtVDndckQG+34g=;
        b=WfPG58N5W/AdXe6wDUzdwU8YXKrG5BKzcL8i7trEGqdIZR/hOT7WsYfJBxP4PaQjEjhi8g
        vnrRMp4gOhAy8W0//+31zw9MUuCxVysleUdzUpbOLHBWvCqIY/NUOaSC3Etvvec0wI2jok
        Hf5G/Fni41co/57y2pg1EvidwT8Qthw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-C37LzPl2M3WdgnszaOyyaA-1; Wed, 20 Apr 2022 04:53:23 -0400
X-MC-Unique: C37LzPl2M3WdgnszaOyyaA-1
Received: by mail-wr1-f69.google.com with SMTP id a12-20020a5d6cac000000b002079e81d09eso192442wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ipOD+iHYz0MO8ka3xCh5rdeCaG6XqtVDndckQG+34g=;
        b=MJEFsPHlm5YRJatgdh1En1l+aI7pB/6odWCDHa2scJEpnFzKIKCPL+abgBoU0wSXrN
         4rGfFrLpqHEM9JJPAjhuTIIebXCVDzNO9Cn3Tx6HNKZRPusgb5zeNCdKpnwz24Eraw5G
         4ooFOnTWZ8km/vPxz7AcPacNKgUctNx9j9IfZ3FEAgPGBWnYYz6wAHcMZGPs3f5ZQspN
         SlFgazGbVQl4HeTL9mquF3m4txn55knvv4wiGUwqe3XtIDs7NTPzpieevQNFr0fC/UIM
         FRWKonedqPyG+jQ13VIQuToLMIk4ICBEUu4lGlq26XVW4yf6FBkX3sQH/mn6Bd+iJ62N
         w0Eg==
X-Gm-Message-State: AOAM532nOjTDhkLQbGEHCd4q7jTWY1ZHIVbuSJFJGXtZouOQ8D7JGMmz
        NNcjCmQWj7JgymQ4/pJz8OmEPBiu1YC4WBnjofxbTniWzTwe1TGD3TH1qpkhcQLze9K4e5uenz8
        8/3XfH2szkFRsLkx4eWZvK6CnL3TzxQT/KCdqvqN4aFf6dleq4RB0cgmeGP4Hh+0fiv844vzgZX
        I=
X-Received: by 2002:a5d:5392:0:b0:207:aaca:9bd8 with SMTP id d18-20020a5d5392000000b00207aaca9bd8mr14859681wrv.615.1650444800409;
        Wed, 20 Apr 2022 01:53:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZbvPSUyZXNVpsoDxEqgIOir/+9fpJtKe5GQ7jt7d1nsakg7f78pMNvQTiKbTLOPgE1YW8kA==
X-Received: by 2002:a5d:5392:0:b0:207:aaca:9bd8 with SMTP id d18-20020a5d5392000000b00207aaca9bd8mr14859645wrv.615.1650444800067;
        Wed, 20 Apr 2022 01:53:20 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b0020aac00f862sm1895343wry.98.2022.04.20.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:53:19 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yizhuo Zhai <yzhai003@ucr.edu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v3 4/5] fbdev: Fix some race conditions between fbmem and sysfb
Date:   Wed, 20 Apr 2022 10:53:02 +0200
Message-Id: <20220420085303.100654-5-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420085303.100654-1-javierm@redhat.com>
References: <20220420085303.100654-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

(no changes since v2)

Changes in v2:
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).

 drivers/video/fbdev/core/fbmem.c | 42 ++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0bb459258df3..8098305879f8 100644
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
@@ -1585,18 +1586,38 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			if (!device) {
 				pr_warn("fb%d: no device set\n", i);
 				do_unregister_framebuffer(registered_fb[i]);
-			} else if (dev_is_platform(device)) {
+			} else {
 				/*
 				 * Drop the lock because if the device is unregistered, its
 				 * driver will call to unregister_framebuffer(), that takes
 				 * this lock.
 				 */
 				mutex_unlock(&registration_lock);
-				platform_device_unregister(to_platform_device(device));
+				/*
+				 * First attempt the device to be unregistered by sysfb.
+				 */
+				if (!sysfb_try_unregister(device)) {
+					if (dev_is_platform(device)) {
+						/*
+						 * FIXME: sysfb didn't register this device, is a platform
+						 * device registered by a video driver (e.g: vga16fb), so
+						 * force its unregistration here. A proper fix would be to
+						 * move all device registration to the sysfb infrastructure
+						 * or platform code.
+						 */
+						platform_device_unregister(to_platform_device(device));
+					} else {
+						/*
+						 * If is not a platform device, at least print a warning. A
+						 * fix would add to make the code that registered the device
+						 * to also unregister it.
+						 */
+						pr_warn("fb%d: cannot remove device\n", i);
+						/* call unregister_framebuffer() since the lock was dropped */
+						unregister_framebuffer(registered_fb[i]);
+					}
+				}
 				mutex_lock(&registration_lock);
-			} else {
-				pr_warn("fb%d: cannot remove device\n", i);
-				do_unregister_framebuffer(registered_fb[i]);
 			}
 			/*
 			 * Restart the removal loop now that the device has been
@@ -1762,6 +1783,17 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
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

