Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB884F6811
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiDFR6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbiDFR5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36AF9C31C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649261212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FhXBUnLq/AeYpcQ43hIiOOWtFlBWzfoVNvi0Bsh0Mg=;
        b=Bj7jYjRTgA27PWqK4phuuDKm0/fOdZmtyPdtONAVvAE/B7at75HMgS7yeLEwoLZlxyy6mC
        oycH+2iEoxdVTbcFQ9THAFoqLm6or6Fu9p2bpiHLsRIq++NIS/fgIGy/2tiCjs10j4cPQ7
        ENdDKaoNJPhEceKi7vOxQBMYE4WZe2I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583--lmWiG-UNke42XNIkdXcfg-1; Wed, 06 Apr 2022 12:06:51 -0400
X-MC-Unique: -lmWiG-UNke42XNIkdXcfg-1
Received: by mail-wr1-f70.google.com with SMTP id x17-20020adfbb51000000b002060ff71a3bso652534wrg.22
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FhXBUnLq/AeYpcQ43hIiOOWtFlBWzfoVNvi0Bsh0Mg=;
        b=QmVUTOvidpEYk+3vcCPTJgg7uGbUAcW6OO/p6DVhzrKlxIN9ek/8FmX7F/V8+YNO4/
         kHOhg53wOZbkRZZtXCTXrS3TkKlyz8Qwvob4bekWO96Tb3OF4UCopHQE8WB6E88wxpim
         C5znNavIapcWYVKvtEheYjrsWIKOaqz6WJsSV970Ca4cLRI8iWTFv1L2e0F3FmvVOfds
         EREGMPtYfmzP6pHKhh3DUN5AqwM14ZtOFZOmjaLDKGM4kxg5/B3FfiruEelPrQaQzTjh
         iA97+HVRqI8C8Oo9e7C+PeSVHOTwB8IipQp7NMHqR+7ng2zxQsZtedUffXh08XsNW4df
         R8hA==
X-Gm-Message-State: AOAM533kB9r0BZzIQOdpyKkHV0/ScneJECWCOrvgjjxlgQ33qaZtsAsj
        0gj6HHJmVmUGT5Csod479WCnk6P0ir5ZzvrUyKRRBpwFeR5w6Wib/P4RZG6OOTEXg8AvGwATqS7
        tyUowSdpcwP+TPsfYKnqvWA2e0KIoLgmpr9NabO5+bL5sBIODk8z0DUG0T81c9CWhHqUVJfSSnY
        g=
X-Received: by 2002:adf:dd4d:0:b0:203:f178:b78b with SMTP id u13-20020adfdd4d000000b00203f178b78bmr7137246wrm.93.1649261209890;
        Wed, 06 Apr 2022 09:06:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjTyMg4XL89qFWV3gB2V/HQc1uQjBder3TeH9rKQDOsGox6TANK3aF+8wdzRe76EhPl9Zl5g==
X-Received: by 2002:adf:dd4d:0:b0:203:f178:b78b with SMTP id u13-20020adfdd4d000000b00203f178b78bmr7137221wrm.93.1649261209641;
        Wed, 06 Apr 2022 09:06:49 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm5038899wmc.7.2022.04.06.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:06:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Zack Rusin <zackr@vmware.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 5/5] Revert "fbdev: Prevent probing generic drivers if a FB is already registered"
Date:   Wed,  6 Apr 2022 18:06:32 +0200
Message-Id: <20220406160632.496684-6-javierm@redhat.com>
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

