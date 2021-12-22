Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E503347CE49
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbhLVI3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:29:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243335AbhLVI2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ivba8PnccKK3fE+1KqwcyTESXW/go6yH+CoRlAVXUHY=;
        b=gezvSdVD7obsb7ShOsf6gwmdX9lo9y+0yApa3RdC518n/QeEwWY5ThpWAWsrJm8nWTme+L
        /lioKf/2kpx3BfFrDYMH6uMgG+XGofbSPefLUmtELGWu+CMrshgo3m9CbgaqNnciVn0UFm
        oTv/WVyWSaXZ1pgTK9PX/m88muSydNY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-rV9ezvw9OF6yr7EUgrTrZg-1; Wed, 22 Dec 2021 03:28:52 -0500
X-MC-Unique: rV9ezvw9OF6yr7EUgrTrZg-1
Received: by mail-wr1-f72.google.com with SMTP id w25-20020adf8bd9000000b001a255212b7cso519161wra.18
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivba8PnccKK3fE+1KqwcyTESXW/go6yH+CoRlAVXUHY=;
        b=LmTV5LuSyNMSg9wSoa93eTZpxYfyv9Ad8AP4C4tcs3m7PsyEK8M2VVkzAp67BHzKBw
         k+GRuX6QyOxDn+9Y0lcjClhKypEW6jqLlwJYIL8AZ1+UwvR+wtgIuYYIYikTi129zBWf
         oyWUs3HgZKFmwVPqndIEaB91g9Yt0rrCJGU1ta2L978DmJ9o5KfrYxIJdQSr439MdZjd
         UHO6h5Tm0Gu7HIwACwjtDlxK5/gO2+Q4US3Qhw45Z34KX7G6R1HL+HIkcmmBHQe3DFzj
         Cgf4sm3cudH34bxW2l/X7xJjbEN0N9bCHjqGvHXLJHQSRRDVcdAwBe4zQjtqvM24WSWW
         cjgg==
X-Gm-Message-State: AOAM531WpE+bWptmsuE6h2zboekIlzm4uEekR8GEAddpvq23sYCnmTVX
        cB2pcsFHdzsPV1Cn1YnAhRYF51kdgluQ7BDpKMR1l5xp8HsP9sukm4i+la/8KqddAg14hyrpSgz
        5X7FSBPb4LwCz+Z+sD+w5k2/GBmoumr/+L9UrLqm3rXOvH8ad/vsjE0HCowqV+UzNQ722ygF7dE
        w=
X-Received: by 2002:a7b:c745:: with SMTP id w5mr88275wmk.167.1640161730422;
        Wed, 22 Dec 2021 00:28:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUvQSHyffY2CYOqgAXb+4llmThUCCs6y8dzFLhVLwFXI0SYQnZ0rbY2rp8lrrmaIFZWyHdFQ==
X-Received: by 2002:a7b:c745:: with SMTP id w5mr88259wmk.167.1640161730228;
        Wed, 22 Dec 2021 00:28:50 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:50 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v3 09/10] drm/arm/hdlcd: Replace module initialization with DRM helpers
Date:   Wed, 22 Dec 2021 09:28:30 +0100
Message-Id: <20211222082831.196562-10-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
References: <20211222082831.196562-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace module_platform_driver() with drm_module_platform_driver(). The
DRM macro respects drm_firmware_drivers_only() and fails if the flag has
been set.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/arm/hdlcd_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 479c2422a2e0..e89ae0ec60eb 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -30,6 +30,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper.h>
+#include <drm/drm_module.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
@@ -434,7 +435,7 @@ static struct platform_driver hdlcd_platform_driver = {
 	},
 };
 
-module_platform_driver(hdlcd_platform_driver);
+drm_module_platform_driver(hdlcd_platform_driver);
 
 MODULE_AUTHOR("Liviu Dudau");
 MODULE_DESCRIPTION("ARM HDLCD DRM driver");
-- 
2.33.1

