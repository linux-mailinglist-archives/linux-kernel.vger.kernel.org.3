Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FBD478171
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhLQAiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231129AbhLQAiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCqrlpOxkFkN8jRFGgvU6Wypx9DvPQbRgHTOxVpgDMI=;
        b=CtGrltOrzDZ664KHcE3HJQUuscejpF6jaHU/7BYZKQU+F+tcemMx+pDM4vBmhv6XxqF2Qm
        KVdY6Pkbcj/dkxTtziWlYgRgJSfVfC4M+zU5+ug9stloaG4tYM9b/NpUJ2av8PS4Cnx/RM
        BTDLgQ0PEs10aqrYEidyiC3DBEB+cXI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-XQ3r81jnM0i-sYBS2G-jAw-1; Thu, 16 Dec 2021 19:38:02 -0500
X-MC-Unique: XQ3r81jnM0i-sYBS2G-jAw-1
Received: by mail-wr1-f69.google.com with SMTP id k11-20020adfc70b000000b001a2333d9406so148240wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yCqrlpOxkFkN8jRFGgvU6Wypx9DvPQbRgHTOxVpgDMI=;
        b=Bq36gjISFvQOcIhlN2u6wKwXlQ7cfn78rXmCTWX73I2Usn3PrrirIuYq5E7Mg5gjK5
         y3gyMHYpA1stDbg+jENYRE6KG0oKCNKGNumJbehjYC0oGeYmtozyx8LrfzYRKzJf/zFZ
         iyTYMX9lEyWn0GTEmWvx1hLGVA6KzOzwurG0t+6v5tzfhD7iaPs9C8u/05tmkOAZLpOI
         hnJytkHHdo57WfxS/JDN4sV4Kdcmth5JPL7hWobag3TwOZQE8s/opVdFZnAmFZsIlNIM
         L7mtvPwiokkSYBPVpu7ql0wXo9SOR8vAPjgRFQKe+mDueWaZwh1NnPdB8Sbth2PYOx+E
         AgKQ==
X-Gm-Message-State: AOAM533z9qkFD1OIYut5aUIr/q23e2erV0iZe6uj9lvk//yQ6pn82DkH
        MwR3Q/o9pesAk3haNM9wKIX4oDrC3iF8Tl4Fn7AeRewRL2WG7nuK3FQO7RSyX0aIFNxwIXYjg7W
        UcIfOIwtky5XanKR7nEW7XbI9CD84RdqBNy4uXFjIFnsttGrJorc20ZBAwoyndJJV33Ho0Uo/OS
        k=
X-Received: by 2002:a05:600c:3d94:: with SMTP id bi20mr7294643wmb.83.1639701481723;
        Thu, 16 Dec 2021 16:38:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPcJfWzzRuydjtFYXtlvszgaSB2rBou3sc3ogRK24mXfEMwess61xOQD9S4/Y6RJZWLXpwAQ==
X-Received: by 2002:a05:600c:3d94:: with SMTP id bi20mr7294633wmb.83.1639701481467;
        Thu, 16 Dec 2021 16:38:01 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:01 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v2 03/37] drm/komeda: Use drm_module_platform_driver() to register the driver
Date:   Fri, 17 Dec 2021 01:37:18 +0100
Message-Id: <20211217003752.3946210-4-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro calls to a DRM specific platform driver init handler that checks
whether the driver is allowed to be registered or not.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index e7933930a657..0d426240b1c9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/component.h>
 #include <linux/pm_runtime.h>
+#include <drm/drm_drv.h>
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

