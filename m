Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6295947CE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbhLVI2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:28:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236683AbhLVI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKhPToxfBQq5pNydzHjkwk5WxJWAvq+wwjNPWe8gGJo=;
        b=Uny476gToMx8VUtvijgy4HezNYnOV3HUztQGxP+wxlIPcSGnR7wcJlOXxqwmcVccO3badq
        sGpFmqGT+pAtS92Esg3TkEKT3/0uc0YLtFIbOARL43/8IL/1SCpUotASVbjaRs2qFpVE1Y
        v0zXTsXmfAid5k6QrNY+onb5BhBiWGg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-fJ9Cm_XTOMaExjAzeWhgaw-1; Wed, 22 Dec 2021 03:28:46 -0500
X-MC-Unique: fJ9Cm_XTOMaExjAzeWhgaw-1
Received: by mail-wm1-f69.google.com with SMTP id l20-20020a05600c1d1400b003458e02cea0so2605376wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKhPToxfBQq5pNydzHjkwk5WxJWAvq+wwjNPWe8gGJo=;
        b=Gb2eCAg7NaPXL9DJ5t3qaZlg9+OREtVdYUG97994VGq2+fUBZt9n+sKrQUWd+oKbxI
         wxnRPUFb8p+U5j+PvqejJKtiJ9TvsVGYAQTpt3RZIy5RQwIYZKSvUwpujPszyPgGN7Nd
         ZnWFuzz3GVUqf4GUxKzTdZ/8sfzQnjo1MQcDAJWyGHQb49uicrzzqjGlxG4WxsoxYd0x
         uAVZanOotCemf5fV1BIy9X/V1bnt2+0XgPoLNqrPPX+Ai0ofQef6wp0i4LMF6l4ZwzIK
         Aedu/kiD2wyximvlC0F4aPs3wQUrRqj1Ivqg8Z3FeG/kyMb2cA/ezLQAmO5K76XNLH5j
         /CbA==
X-Gm-Message-State: AOAM532S0GLYZwjCZmAnSXZf5PUWLLx6Fpw6HwdRGYH6FvvBfBQsEf1t
        sjNYUiUxnFYelOocUVhs9KiMiroZKeSqxfzEEytlKrzSNj0qBMEwShUzj1hw4l7qTXXrmDv0ZIX
        dXTXB9n1vQbhyDf5zGLS84zoU2uDUmqnQAXiTLI+whMGHh+ycVhrHAn3moVLyO1tL+d7amSRQOU
        w=
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr99511wme.55.1640161725357;
        Wed, 22 Dec 2021 00:28:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwASAq/dtsK6K6Yjj0AI3A3qYyq47cJbVrQUcbjvBZF7illfU9D4bt+Pmqd9TWF8LyyxZuyEw==
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr99495wme.55.1640161725085;
        Wed, 22 Dec 2021 00:28:45 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:44 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 04/10] drm/cirrus: Replace module-init boiler-plate code with DRM helpers
Date:   Wed, 22 Dec 2021 09:28:25 +0100
Message-Id: <20211222082831.196562-5-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
References: <20211222082831.196562-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

Remove custom cirrus_init() and cirrus_exit() functions and initialize
the module with DRM module helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/tiny/cirrus.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index c95d9ff7d600..ecf2475d0f16 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -39,6 +39,7 @@
 #include <drm/drm_ioctl.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_module.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
@@ -633,21 +634,7 @@ static struct pci_driver cirrus_pci_driver = {
 	.remove = cirrus_pci_remove,
 };
 
-static int __init cirrus_init(void)
-{
-	if (drm_firmware_drivers_only())
-		return -EINVAL;
-
-	return pci_register_driver(&cirrus_pci_driver);
-}
-
-static void __exit cirrus_exit(void)
-{
-	pci_unregister_driver(&cirrus_pci_driver);
-}
-
-module_init(cirrus_init);
-module_exit(cirrus_exit);
+drm_module_pci_driver(cirrus_pci_driver)
 
 MODULE_DEVICE_TABLE(pci, pciidlist);
 MODULE_LICENSE("GPL");
-- 
2.33.1

