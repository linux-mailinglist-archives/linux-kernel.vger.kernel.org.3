Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BB747CE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbhLVI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58571 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236763AbhLVI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/qoDXiIfAUFTnZkuc0zNNYRvTskgiRkFkbMNCnXmhY=;
        b=ChGn7h1lEqfjdNZGpsOfJqpZF6IjqMWYVWzvO5KBTeysulE5kcadnwzfmYOUFcUVwbczsQ
        S2MW9MWbmczuYjRpF3ymYAqbEStGFqF2cOV2WhCaahtGzkWB5FDSBJ7bN+pQzGAL+AV4rq
        zPGcjKY4TiJ71uh8nywgstowRMFALKc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-No--qHgPOJ6VviIL5nOIJw-1; Wed, 22 Dec 2021 03:28:45 -0500
X-MC-Unique: No--qHgPOJ6VviIL5nOIJw-1
Received: by mail-wr1-f72.google.com with SMTP id r7-20020adfbb07000000b001a254645f13so527527wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/qoDXiIfAUFTnZkuc0zNNYRvTskgiRkFkbMNCnXmhY=;
        b=1AomHZG9a7AetSrOxaX4Qv7hgQqCfcifE0OkxlgHfUwvp1g2fJW43wGXi5JT5LAY8r
         Ln5hy91MEoRBYZCpGjnXYuG3USMRLYkEDbMdqMsZ1ZoJKL5x0wJMtilHypEEkB7Hxhlv
         Zp03GI0Vg9fV1bjUVioLwLGUzkf2ZDn9rgJgejm1YPDkEPAJ/8xVNfixxCQ0PxaGA5W0
         PF6LiTXscCC8fjz9zQthCsSr7ypR/3an1+nRtpKvk7oKXlOfYUswz8r+njXFVSoeuG88
         18MU4ybfs392caUY5BidOxBMgeqHP9sWaSyMhWiKwHcl42ULq6il7P+Eo0BsXbyh4fbF
         6kmQ==
X-Gm-Message-State: AOAM533KCDDm0FuzAYoLweaSBz23Tl6awj2g0khPToLjfsaOPtZLJwXI
        55jJLJuzrHltH84UTPHzl4LzrYp+JWOZgb6llB/ACv0tT62I1ZxmFtSemSly4aidPqpZBjpTzF7
        7fPjFGBSbJasNPYUL0yDpR4dZ/h90g4AXHYqxhRtONselxYH88dGP1KjJH5jmlTLrjniWtAuwPL
        4=
X-Received: by 2002:a05:600c:3507:: with SMTP id h7mr110722wmq.122.1640161724101;
        Wed, 22 Dec 2021 00:28:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmVVLVe+6aOEoAfYzcCCJuT1IgGbQOeC1WEJhsigU/0tjFkWA+ef3XacqmOZoplM0rtMS/Fg==
X-Received: by 2002:a05:600c:3507:: with SMTP id h7mr110702wmq.122.1640161723929;
        Wed, 22 Dec 2021 00:28:43 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:43 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 03/10] drm/bochs: Replace module-init boiler-plate code with DRM helpers
Date:   Wed, 22 Dec 2021 09:28:24 +0100
Message-Id: <20211222082831.196562-4-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
References: <20211222082831.196562-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

Remove custom bochs_init() and bochs_exit() functions and initialize
the module with DRM module helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/tiny/bochs.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index fc26a1ce11ee..ed971c8bb446 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -10,6 +10,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_module.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
@@ -716,24 +717,7 @@ static struct pci_driver bochs_pci_driver = {
 /* ---------------------------------------------------------------------- */
 /* module init/exit                                                       */
 
-static int __init bochs_init(void)
-{
-	if (drm_firmware_drivers_only() && bochs_modeset == -1)
-		return -EINVAL;
-
-	if (bochs_modeset == 0)
-		return -EINVAL;
-
-	return pci_register_driver(&bochs_pci_driver);
-}
-
-static void __exit bochs_exit(void)
-{
-	pci_unregister_driver(&bochs_pci_driver);
-}
-
-module_init(bochs_init);
-module_exit(bochs_exit);
+drm_module_pci_driver_if_modeset(bochs_pci_driver, bochs_modeset);
 
 MODULE_DEVICE_TABLE(pci, bochs_pci_tbl);
 MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
-- 
2.33.1

