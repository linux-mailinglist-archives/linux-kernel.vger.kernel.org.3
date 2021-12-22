Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7986E47CE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbhLVI2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:28:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233849AbhLVI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbQRb30yFnbPRrQK/qwkVgeb4aTpo5Ai4KaBIhKcKkg=;
        b=AC8xsHzwWabqTBZRSWsUW2pHF6Vy8RG1gHVTV37Tb2y2b4HTXKwXk0PbCXTwAmIOMQEUmX
        uSeOayB8UVrHLkAGN6J4p6ozDm+7zKSXw1RfbkkTvBFvrSMgG1khnhIoihRn8rRa2K7/eo
        K2syDbVskZZAm2sDVMBUBdjJ3ZlqfCw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-C-mjPjNQObm88w0ch08D6g-1; Wed, 22 Dec 2021 03:28:44 -0500
X-MC-Unique: C-mjPjNQObm88w0ch08D6g-1
Received: by mail-wm1-f69.google.com with SMTP id ay41-20020a05600c1e2900b00345a568e6b2so420620wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbQRb30yFnbPRrQK/qwkVgeb4aTpo5Ai4KaBIhKcKkg=;
        b=CFCvFcf2C/wwMPULwmhnBS5CTTE6cHm6aT1SgXBMQCAcm37iZofntdlR2gxDWVp+7e
         A4Df+eX9rJNYxEtUACXS4NtRaaD9MUfpVeKs3ysHU2r/ue/NSmCDnnlDr55D5egtoT3O
         62K5Op/MyDDPf7xK9AAU6MeWHI1d9qQ6Q+WZLVc+govZl8ll/00Jx16r8v5q/HyRYLHi
         qdOka+/q2dzCslBE95MW9zSu2hmV5Jh1tUzKrZgZx2Y5C86RdQDwY+hA/b/TMaYr4IQd
         p83uEHtBcrEuBfZ3MLqWaobY7G7RI0XHkwhQOHU9tbZDWtwe12qN2BGldkBASPCYyGvk
         MDhg==
X-Gm-Message-State: AOAM530nF5rhp1L4ZkZloPrQMf6Tdgzf0yRroDqT53geP4ia5P6akm6A
        R6zB8aF2+tTkqKSeVSfBDKA0Xsbfm7Ninm7dl8lEgN9cZAqPQZVXvrltEOBvYDcO74mEEuPwpF+
        Yi2tNzMMSCQ4UX/GMMYOo3dFgFQ1ssrbl/siDN8N5c6zLn6ldo6w6lJPV3iEvC23wpOkp1yXhtb
        4=
X-Received: by 2002:a05:600c:3b2a:: with SMTP id m42mr118178wms.4.1640161723072;
        Wed, 22 Dec 2021 00:28:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNbvNKWRYRRx42OwX6hAbth/vJE/sgOJvPPhgItN3MC3bPcTGbWNoNV+D2bK5szud1caQ+Kg==
X-Received: by 2002:a05:600c:3b2a:: with SMTP id m42mr118157wms.4.1640161722786;
        Wed, 22 Dec 2021 00:28:42 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:42 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v3 02/10] drm/ast: Replace module-init boiler-plate code with DRM helpers
Date:   Wed, 22 Dec 2021 09:28:23 +0100
Message-Id: <20211222082831.196562-3-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
References: <20211222082831.196562-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

Remove custom ast_init() and ast_exit() functions and initialize the
module with DRM module helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/ast/ast_drv.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 6d8613f6fe1c..7465c4f0156a 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -34,6 +34,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_gem_vram_helper.h>
+#include <drm/drm_module.h>
 #include <drm/drm_probe_helper.h>
 
 #include "ast_drv.h"
@@ -230,22 +231,7 @@ static struct pci_driver ast_pci_driver = {
 	.driver.pm = &ast_pm_ops,
 };
 
-static int __init ast_init(void)
-{
-	if (drm_firmware_drivers_only() && ast_modeset == -1)
-		return -EINVAL;
-
-	if (ast_modeset == 0)
-		return -EINVAL;
-	return pci_register_driver(&ast_pci_driver);
-}
-static void __exit ast_exit(void)
-{
-	pci_unregister_driver(&ast_pci_driver);
-}
-
-module_init(ast_init);
-module_exit(ast_exit);
+drm_module_pci_driver_if_modeset(ast_pci_driver, ast_modeset);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-- 
2.33.1

