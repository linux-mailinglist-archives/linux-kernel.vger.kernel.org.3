Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADACD47CE40
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbhLVI24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243308AbhLVI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5EHgB4jt8VzQ3WZ6ERGEVuhUukhc+8h/a/zrx+jNmtA=;
        b=WWeai2tiFtTnNGDaBBV8yW6TC5KHppGh1oTIM3pFQhXCbQ2pVXQ6F8mHnEry2v9GnZVLli
        iWuOty8EqfmNyny2uombQchZpq+cgN0Mo/FtmvfaBje4/P+o+AJVj3YtMVcXiMbqZIFo3D
        Q9oivp52vXEiolLE3YL6L7+6a+d3O8A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-HbPa1HXWPoquQ4mqqczYlw-1; Wed, 22 Dec 2021 03:28:47 -0500
X-MC-Unique: HbPa1HXWPoquQ4mqqczYlw-1
Received: by mail-wm1-f69.google.com with SMTP id p22-20020a05600c1d9600b00345a25ea8cfso419899wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EHgB4jt8VzQ3WZ6ERGEVuhUukhc+8h/a/zrx+jNmtA=;
        b=qCyRJ9vcN++uRTTb+jl0KBvx+dXZaQ0V7eRdPHWF4nDJrds5gHUXvImVi0MiUvDLQh
         WykZyqjMEjJaUWhl8XdylzBAiXDSmAzRuEA3eLQTG1kw8tYWCwLEKf2mn4UZ62nO7UgK
         keXBCOgMHn5vOt7VVW1MlVOnqvtAtVv8zS1VybDKLklTGkO9grYPibqQwvPUFi8Ykxas
         9UBPQo0fYLdnLcUTPjG8r34yBOMw/pR7U8LfkMUDNxfmirMonllZ1mQyiaEj6M3l1fkb
         v5J/qZrtYrt3bD3of2ZG/AYT9Xn/shlFo2isjn8bTUJQGYT5xYal4FPCQ1XOjAGlPzPd
         MVQw==
X-Gm-Message-State: AOAM530OfaMxfUKHSBTSjDBaqK1aKxC6SmXyodTqyD6GM8LiMJBVDz0g
        BcEGTDp8R5RlOQZauHuSp0HzwTxw4wHywgqoQFcVTQLPDArDYS8M8wfz8SBX/vHxZTMsFCht3Ro
        KyZGOQRZUbkHwRW1rTqhOfu9io0jXbGVwPGLYW40ht72jlbQdCbY1MGETrLovlA6N834t5P3DNq
        Q=
X-Received: by 2002:a05:600c:1c20:: with SMTP id j32mr104017wms.1.1640161726589;
        Wed, 22 Dec 2021 00:28:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxao6fS2/g74UosGgsoqKJfq1VcVJQsZJi/iDWRRvOhWbuaBqYMNZKeV5b54IyJARY9L/JEgg==
X-Received: by 2002:a05:600c:1c20:: with SMTP id j32mr104003wms.1.1640161726400;
        Wed, 22 Dec 2021 00:28:46 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:46 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        John Stultz <john.stultz@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH v3 05/10] drm/hisilicon/hibmc: Replace module initialization with DRM helpers
Date:   Wed, 22 Dec 2021 09:28:26 +0100
Message-Id: <20211222082831.196562-6-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
References: <20211222082831.196562-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

Replace module_pci_driver() with drm_module_pci_driver(). The DRM macro
respects drm_firmware_drivers_only() and fails if the flag has been set.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 610fc8e135f9..fe4269c5aa0a 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -20,6 +20,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_module.h>
 #include <drm/drm_vblank.h>
 
 #include "hibmc_drm_drv.h"
@@ -379,7 +380,7 @@ static struct pci_driver hibmc_pci_driver = {
 	.driver.pm =    &hibmc_pm_ops,
 };
 
-module_pci_driver(hibmc_pci_driver);
+drm_module_pci_driver(hibmc_pci_driver);
 
 MODULE_DEVICE_TABLE(pci, hibmc_pci_table);
 MODULE_AUTHOR("RongrongZou <zourongrong@huawei.com>");
-- 
2.33.1

