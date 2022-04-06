Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B014F6D63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbiDFVwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiDFVvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD1BF8CCFC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649281258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2QzSBkwn7Yafa/16sbGGbBUM4FbySeU5GGeHJm/Jx0=;
        b=GWJ08vw2FpfbjWfJxiOinBUanVRwoFxnZDKwy3HCyJ7DniTYXUT9eVUeLIRS8OIXx6WcKi
        +xNmLe/nn3LSM3bTRylGz3cRs8uyTz2kDSQCiEQc4k5OhXxOtt6arE5uX+m86R8QorAvHl
        KyoNqbBxeg0QNKJGGeq3fR7Z2bGNhvw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-qKGFX720OKi3VdV9fhaeaw-1; Wed, 06 Apr 2022 17:40:57 -0400
X-MC-Unique: qKGFX720OKi3VdV9fhaeaw-1
Received: by mail-wm1-f71.google.com with SMTP id o35-20020a05600c512300b0038e83a52c71so978156wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2QzSBkwn7Yafa/16sbGGbBUM4FbySeU5GGeHJm/Jx0=;
        b=Q2DP0XYpay4TNei7iphAHqiC6cLe6XslfmKQwMzBKXn52WYtnsiyGGEPQpVizipUcw
         mD6bI0Zb+0wZ6h0bxrlYq0W99egL1obtJgKu9vD9Rcf/L2IEZLbL2pbT6DcQDwOj4NrQ
         9eRSIvn6SK9bhnpNT6Zpi3POQimcaOlXUA/WgqYZCrQCrQFZ9exxxwz/P6gcFR1VTXyI
         Ms4UEnT3vIDB/d7F4HOduE4dGVUwtLUVY5ONSpbMcgGTJlo3Z6+Bozp+zowqz28pOV+N
         PyWsrOVkNsGAM3ObL4VIjt0lgNRag3bA0PheDKdz15ltuxwAgJ6M8GMkM8Th+Bf0jLMf
         ImQA==
X-Gm-Message-State: AOAM533HyggWY0HjRVImR8nWzVIw68thE43XoaEuk0igbSXjkpS+dPzr
        mHrRT2BSuDunKHboMM4EnwKlJuE7+ghidzCbft48rfzQIfgILplHH79hCoeA/B2xeWn6nNovsXd
        A5lqYHdi2vuHFtyAsNZm55EN0mSD0VYuB9rrfhbR5dMNJ9icLfHuVNXMs2H0WhUhVW/dOKtkiiL
        E=
X-Received: by 2002:a05:600c:6004:b0:38c:6c00:4316 with SMTP id az4-20020a05600c600400b0038c6c004316mr9499678wmb.6.1649281255737;
        Wed, 06 Apr 2022 14:40:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy98rnXAztsyk4KBqYgyk86f1BpoiJOrcBFIcbWPB9DOuUKh2YKVe/1UDGOsUjrhGSlhCdgYw==
X-Received: by 2002:a05:600c:6004:b0:38c:6c00:4316 with SMTP id az4-20020a05600c600400b0038c6c004316mr9499656wmb.6.1649281255447;
        Wed, 06 Apr 2022 14:40:55 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm5876020wms.15.2022.04.06.14.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:40:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [RESEND RFC PATCH 4/5] fbdev: Fix some race conditions between fbmem and sysfb
Date:   Wed,  6 Apr 2022 23:39:18 +0200
Message-Id: <20220406213919.600294-5-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406213919.600294-1-javierm@redhat.com>
References: <20220406213919.600294-1-javierm@redhat.com>
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

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index c1bfb8df9cba..acf641b05d11 100644
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
@@ -1588,7 +1589,10 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 				 * unregister_framebuffer() function that takes it.
 				 */
 				mutex_unlock(&registration_lock);
-				platform_device_unregister(to_platform_device(device));
+				if (!sysfb_try_unregister(device)) {
+					/* sysfb didn't register this device, unregister it */
+					platform_device_unregister(to_platform_device(device));
+				}
 				mutex_lock(&registration_lock);
 				/*
 				 * Restart the removal now that the platform device
@@ -1781,6 +1785,17 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
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

