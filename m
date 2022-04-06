Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD344F6D64
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiDFVwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiDFVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:51:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A8248CDAB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649281260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FhXBUnLq/AeYpcQ43hIiOOWtFlBWzfoVNvi0Bsh0Mg=;
        b=PyUfjGCC1VQFwn7lvEXn9IaB8SfkWw63Oi/RdasUCAQ4WZbSlyNZuw5y7qn95Xp6+gD+UF
        7FUEv95qfmg6ShaDW1Gr1skp8u+EBXfg/Q5ca4H0tHwq/azB1mDp2Fwg+sSbRwpx/RDIpM
        CJHFQro0+shaq22fQd0UTbiWesgNsBE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-dzmmJFqnOWGMrxp4thtVsQ-1; Wed, 06 Apr 2022 17:40:59 -0400
X-MC-Unique: dzmmJFqnOWGMrxp4thtVsQ-1
Received: by mail-wm1-f70.google.com with SMTP id r19-20020a7bc093000000b0038e706da7c0so1911511wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FhXBUnLq/AeYpcQ43hIiOOWtFlBWzfoVNvi0Bsh0Mg=;
        b=u7IyW1j1pUiWOOolIgOI6l3OO4wNLzNJNog7w61H2qyboJyQw79XiI0TOHDXnbvZKR
         nVQiqtg5WzybmX+/bKkwNMsK8JCShwc2Agz9Sxpu8GR2Fnh4px+YG8ne0vvxda48fkAR
         9/CkMe8rA3EX1ggyEdpBG5rg/PUTMeJjjZ1zy2NFlFZel1hRXUpl3MCgo2kNxVCFhNYs
         d4VBlYz4zXVAlRUkkEJttKHzMIzUlnDHw+TP+/B1DscUGNuNgyBKCOUBE5xujf4C6Upu
         ntJq21o9/DaRP/Ti/wsQ1NaA9wEQixV2U01sFyAGV0O5bw4baPS6dkWkAxqM3AiCwSt2
         WcPQ==
X-Gm-Message-State: AOAM532fO0LUx9pnz3Ah1sQ2ggt6SgVcIbSm4XC6813M4eaTEtxi7CBd
        udkIwEzkauNaMWSW7gzXuftJQOi1NlYIMvkPTD9iIGqA/M7gN6td0altuO/GvGZo4A8lmMCiEgR
        V/Y90qAIhq3bAeLerPIIcj0DyduizAkrB7neVier8FlvDZdNMNDJ7smC0rTFQyoGz7HXjkiL7ia
        U=
X-Received: by 2002:a7b:cf2f:0:b0:38e:6f21:bba9 with SMTP id m15-20020a7bcf2f000000b0038e6f21bba9mr9082588wmg.94.1649281257964;
        Wed, 06 Apr 2022 14:40:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu0lYRk3QkxgnvH66v8eUTrMYR+LVlqeV9xMaH6jcY66CpHDS6DKp0bRanjMtEYrzwKOSL2A==
X-Received: by 2002:a7b:cf2f:0:b0:38e:6f21:bba9 with SMTP id m15-20020a7bcf2f000000b0038e6f21bba9mr9082565wmg.94.1649281257668;
        Wed, 06 Apr 2022 14:40:57 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm5876020wms.15.2022.04.06.14.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:40:57 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Zack Rusin <zackr@vmware.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [RESEND RFC PATCH 5/5] Revert "fbdev: Prevent probing generic drivers if a FB is already registered"
Date:   Wed,  6 Apr 2022 23:39:19 +0200
Message-Id: <20220406213919.600294-6-javierm@redhat.com>
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

From: Daniel Vetter <daniel.vetter@ffwll.ch>

This reverts commit fb561bf9abde49f7e00fdbf9ed2ccf2d86cac8ee.

With

commit 27599aacbaefcbf2af7b06b0029459bbf682000d
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Tue Jan 25 10:12:18 2022 +0100

    fbdev: Hot-unplug firmware fb devices on forced removal

this should be fixed properly and we can remove this somewhat hackish
check here (e.g. this won't catch drm drivers if fbdev emulation isn't
enabled).

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ilya Trukhanov <lahvuun@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/efifb.c    | 11 -----------
 drivers/video/fbdev/simplefb.c | 11 -----------
 2 files changed, 22 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ea42ba6445b2..edca3703b964 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -351,17 +351,6 @@ static int efifb_probe(struct platform_device *dev)
 	char *option = NULL;
 	efi_memory_desc_t md;
 
-	/*
-	 * Generic drivers must not be registered if a framebuffer exists.
-	 * If a native driver was probed, the display hardware was already
-	 * taken and attempting to use the system framebuffer is dangerous.
-	 */
-	if (num_registered_fb > 0) {
-		dev_err(&dev->dev,
-			"efifb: a framebuffer is already registered\n");
-		return -EINVAL;
-	}
-
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
 		return -ENODEV;
 
diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 94fc9c6d0411..0ef41173325a 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -413,17 +413,6 @@ static int simplefb_probe(struct platform_device *pdev)
 	struct simplefb_par *par;
 	struct resource *res, *mem;
 
-	/*
-	 * Generic drivers must not be registered if a framebuffer exists.
-	 * If a native driver was probed, the display hardware was already
-	 * taken and attempting to use the system framebuffer is dangerous.
-	 */
-	if (num_registered_fb > 0) {
-		dev_err(&pdev->dev,
-			"simplefb: a framebuffer is already registered\n");
-		return -EINVAL;
-	}
-
 	if (fb_get_options("simplefb", NULL))
 		return -ENODEV;
 
-- 
2.35.1

