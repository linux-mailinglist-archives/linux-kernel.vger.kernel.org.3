Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220374F6836
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbiDFR5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiDFR5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DD641A771E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649261211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U2QzSBkwn7Yafa/16sbGGbBUM4FbySeU5GGeHJm/Jx0=;
        b=env1f3IYLBLUN0bDvO5fF8B61UkIhGpjGygidOmSM6sNxq2RRqUQk+b68iXXTSj+PrM2/k
        2MtvZZsFpN9JPSFJ1ntmxscdtgciLV6J5p6g7Yrv/z+9R/fDWeJuxc1hQKjCEvvhkRmNRn
        H5eZjl4EoDk/wgCQafJPX5DP5sAAZ5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-l_pP4vIKNVOfLT1dI12TEQ-1; Wed, 06 Apr 2022 12:06:50 -0400
X-MC-Unique: l_pP4vIKNVOfLT1dI12TEQ-1
Received: by mail-wm1-f72.google.com with SMTP id x8-20020a7bc768000000b0038e73173886so1513826wmk.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U2QzSBkwn7Yafa/16sbGGbBUM4FbySeU5GGeHJm/Jx0=;
        b=2PPqW6vIRgiq9mbuj3sIoRDtAlTyLOF6YXX7RXtCNOJi+dtUgwp5yvC0dZlK8bDLN5
         kOf8UT0gqmEw86AntuLOJ3pZ/bUob0+AjwWqE8SMzJtKFHBO9+zVSfB8ZHi8y0bZcJH0
         Q0LykdKqt2Tmn8Doj21VFZ26jy1Aug9rPyFweHXKfiv586P0iPqoDJeTYVlIYMoUOwsm
         ZPPCjSr4q0h4i9hbCabzO8fNolrerwazY3clwSJJR4R+twaKy9oaeXPF3qW9Z8FoPhm0
         MX2znxhmxIjJRzIqgH4useh38gb3dV3g8sOSiHOXTN6Mj4Xmmyg4vI6bTAL1WaVhXvU5
         erVA==
X-Gm-Message-State: AOAM533PESef2Z8vZhno9DV97xVnbF5F0RzcJj2YhhAYV2AELR+CVyxM
        vhNemvABmA2SZnXMY618kYcjoZ5eXnho8qLZuHJ+A3e83/cCUSsTmcYtfcuTenmzCbzRNSHqd+O
        qCbibKsw3hKvhQgrh33/rHUzKZx7gLwK5qb5A+dmi171AbIRsklzWcKB11PrqJ7JhweVdO5uGc2
        M=
X-Received: by 2002:a05:600c:3b26:b0:38c:8358:4b84 with SMTP id m38-20020a05600c3b2600b0038c83584b84mr8262645wms.185.1649261208783;
        Wed, 06 Apr 2022 09:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrWRPcdVNxxa0OQoFxVtMgEvN6P53Xni3VcPZinWUwk/8XrPqG2DL56DBxegaE9MICKK7T2Q==
X-Received: by 2002:a05:600c:3b26:b0:38c:8358:4b84 with SMTP id m38-20020a05600c3b2600b0038c83584b84mr8262596wms.185.1649261208370;
        Wed, 06 Apr 2022 09:06:48 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm5038899wmc.7.2022.04.06.09.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:06:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [RFC PATCH 4/5] fbdev: Fix some race conditions between fbmem and sysfb
Date:   Wed,  6 Apr 2022 18:06:31 +0200
Message-Id: <20220406160632.496684-5-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406160632.496684-1-javierm@redhat.com>
References: <20220406160632.496684-1-javierm@redhat.com>
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

