Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAD44F6820
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbiDFR5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239491AbiDFR5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F31DD197522
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649261210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KV4A7vxPY5Ri/A7ExTRv30H1oUVvMjyO4SRhZ4A4Rkc=;
        b=NxE4X8f5I1DdqXKzABMRyFx0T97MPrGcEjV+ssrEDUZOlhkMoTixAUm6bNnU0mhLap032t
        pVtzDQFv/iYmlCsMlY3lr3CX1KJFWgh8pP+RhD0u6oKQ27YUzp1HZHztqBnWcT6k30Mk/Y
        LeWKs2c+uhaEOTkZULTVp1b9KwTnn+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-5bnbo2WgM5CLfP0kJvIA7w-1; Wed, 06 Apr 2022 12:06:49 -0400
X-MC-Unique: 5bnbo2WgM5CLfP0kJvIA7w-1
Received: by mail-wm1-f71.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso779342wma.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KV4A7vxPY5Ri/A7ExTRv30H1oUVvMjyO4SRhZ4A4Rkc=;
        b=GVShr2X9GQbH7H6Gp2bNAnjb/u1M4EjXuWRCW4m8P19jsV4AEdP1fWcJDXyBacgB9Y
         1KZ0BEGv/h2t1NUrb1XBUNl42SGT8wX17IOI3QftfI8l4F21rtaNrBzNwN7kA4iP0nmj
         FR1r/eaMNZuXQ4/otoma3XxelzW8ODemX748mRTKnhtgfYXB2NtA/EODQ5Vx5jbLfssD
         2uxypQDGRISPcPESzI3Lhvi91C1dRRDt5RAg0n8RZS/QE5lM2ZLfxXQzDpIebNeMvwAY
         WBvqGM3baTOB/DYv/U8+cNPc6yvdG/FUwRklmnQPX05b0PhlpP379UL1B+x17HK7B7yY
         NY/g==
X-Gm-Message-State: AOAM530X+k5UCLfTqJWM7Zsbz7XawT1G2ChjIRVS9xXPvTYb/xHZynwx
        B0GdI0vppFShQx7FnqGta7a2wj5y7jqaCHuNVXy309wmrHpmyc1ZBUc5XKmePhyQxTUq9xEqkpk
        nEMcZFks8DUocp+dTfDhtNhVpJFtQxZwGYSnrjOXjcGn77XFt6TiDJt2QF5H/9O8wdrM+BMklkA
        c=
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id q13-20020adff94d000000b001e55ca12b80mr7358644wrr.323.1649261207595;
        Wed, 06 Apr 2022 09:06:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4iqTGXWAmr0kVXiSaBoH7zqLfupO6IvuwBcok5RYqdCJJH/FQ8YSgWM4GphZdzl59KrH3Wg==
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id q13-20020adff94d000000b001e55ca12b80mr7358600wrr.323.1649261207193;
        Wed, 06 Apr 2022 09:06:47 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm5038899wmc.7.2022.04.06.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:06:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [RFC PATCH 3/5] fbdev: Restart conflicting fb removal loop when unregistering devices
Date:   Wed,  6 Apr 2022 18:06:30 +0200
Message-Id: <20220406160632.496684-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406160632.496684-1-javierm@redhat.com>
References: <20220406160632.496684-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

