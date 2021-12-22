Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F205F47CE43
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhLVI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243362AbhLVI2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YX/sIrrqWUDik1PzndjmJVQyO+z161qCpfbNGHekPD4=;
        b=BDpZPjXNZIBzGEZWgUNJizr4ojqx/sBaTFCBwspRn2K7SD0vbS+apa6ijEwnnFum2J64S9
        WzCsXVuYPPme6ANwv+z/1S7vwOMGMyVb5hSuI2SsxdOLhn7xIMeefFI5DciihsKAAPz5bt
        jZfifJdNgJ51/xBjrHZq78HqnM63eRA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-xbv0D7AeNwWrWMK8-zV77w-1; Wed, 22 Dec 2021 03:28:50 -0500
X-MC-Unique: xbv0D7AeNwWrWMK8-zV77w-1
Received: by mail-wr1-f71.google.com with SMTP id a11-20020adffb8b000000b001a0b0f4afe9so521592wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YX/sIrrqWUDik1PzndjmJVQyO+z161qCpfbNGHekPD4=;
        b=H1dwi6YUVNEMju8ANnHNahxe7bry9U2+qNmYlIIug7ObaJ9Cc5pCQ3YrUkjR88uaIc
         cWIFKp3yVu/zSmOlC5cxB5QYsW5F1Ow4dSPExI53E/9aAwMos902sm/v1He7CLx3HD68
         wNX3I1eET7XW3jtFGPt5E3ybfZwRAeVOZrrk2sHVRonJ9p2ZZvLBgfycWtbwLch256rC
         E8gyJgeVG6j4RAXmCd5Dhwj54gR26c8TUrr1mDLcl/bK+G3YiuogQpcZprPIsJ4mCZS1
         pH/tcZPLeVpA7DsWMEKGCOPWQ1UzVpyin14ePUulbdU+sOZ1ZcdPMDAE/ufAGyF9qFgd
         cxPw==
X-Gm-Message-State: AOAM530CmEQHI4pvaJqisGU8NymNkTPjj3nst/gkGFKcKwAZrM6sKl5h
        WqLMp+/qST5PJVFk//c7pHlauBJTKgYQNlfnHQo0NvynrDyUdezvyyjEbY/8n40V2SwRwhD+TwV
        j+WjdZ7MJ2ZnXt/SumXMh+jLDnjYcGqkp1EEvCXH0mirJCK/j6mB4/yVkNBXESiIRi3VUnAeqRY
        o=
X-Received: by 2002:a5d:5310:: with SMTP id e16mr1288226wrv.91.1640161729568;
        Wed, 22 Dec 2021 00:28:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqScG9KfeV/wbitdFv1RY0/fBhHnWA+ZQcrjuEC7jBkboX0U40jvqhJQ1jShPeLro0YydqwQ==
X-Received: by 2002:a5d:5310:: with SMTP id e16mr1288212wrv.91.1640161729359;
        Wed, 22 Dec 2021 00:28:49 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:49 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>
Subject: [PATCH v3 08/10] drm/komeda: Replace module initialization with DRM helpers
Date:   Wed, 22 Dec 2021 09:28:29 +0100
Message-Id: <20211222082831.196562-9-javierm@redhat.com>
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

 drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index e7933930a657..51e51ff299b7 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/component.h>
 #include <linux/pm_runtime.h>
+#include <drm/drm_module.h>
 #include <drm/drm_of.h>
 #include "komeda_dev.h"
 #include "komeda_kms.h"
@@ -198,7 +199,7 @@ static struct platform_driver komeda_platform_driver = {
 	},
 };
 
-module_platform_driver(komeda_platform_driver);
+drm_module_platform_driver(komeda_platform_driver);
 
 MODULE_AUTHOR("James.Qian.Wang <james.qian.wang@arm.com>");
 MODULE_DESCRIPTION("Komeda KMS driver");
-- 
2.33.1

