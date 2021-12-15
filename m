Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6660474FFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbhLOBAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:00:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238717AbhLOBAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90fdRUH+BwC8CK1ZHj3eypDb3h6VgZnI8Gytvn0sj5U=;
        b=M6b3IkThcGTomPCR2CZoYVJcFpIVrtJ/97JXzjGE0TDyMkK0wug3Y1+VzzcExyCjoSi5AG
        xMkUceZoNPePOny0++1Srlz1+MbZr5P9biq5G3ARNuYr32+oBw5N1YlQW7ziDJO1uZ7rcY
        vWXlng8w6YWbKUDrbbbI2OpvWa/lr1E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-_WjnaE8yMiqwHakEdDmCzw-1; Tue, 14 Dec 2021 20:00:52 -0500
X-MC-Unique: _WjnaE8yMiqwHakEdDmCzw-1
Received: by mail-wr1-f70.google.com with SMTP id f5-20020a5d4dc5000000b001a0b1481734so2563891wru.23
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90fdRUH+BwC8CK1ZHj3eypDb3h6VgZnI8Gytvn0sj5U=;
        b=B71QloNiHTLgcjxXQkcwoNx4hRkIz6zIrAWB3QUaPka+Mf93fLr7FDtZ4ggHAPrkP8
         +QihfavBREdda6Rp+v7oImuLiZl1gpLW9VJrXSHM2O72EfWFOHWdQ0vTDAFuvagh90Ns
         8V5n2hvxxmwAHqCzC6aVR0hzeLDyQ7e86gz8by2v8KnNuiZ1qBfk+UlEkM+uu86E4p3T
         NbmUWbp83QsDbwgSyuU+037E10ZtxLkm9ZidxfZS5fM6DOOxxkWniNLNoomOLKXvgjfZ
         Gl/otztBqOhyk7XCr92HKqw9qwZFpF+uq+bXeCzvuKjmTzgvbi75pVronIw+2GlXUQWs
         i2+w==
X-Gm-Message-State: AOAM530w9Wwi+9h8H371v+zSUaAoKuLYd2te4cD7JLYArUbNaM7l4CT/
        8O8iDDvjurSDB4hHatvW4hoXrM2qMIAdvsOOPUP8SDdQnj8qUai3vG1uT9NOg+44NCuannG2Yfe
        J7qfXnxv6mShrwHMDUSutuxa8xnoe4bckkDs2byErx0olveF55lOqL6eQePw6tcRh3EJ6KgzNdp
        8=
X-Received: by 2002:a5d:5850:: with SMTP id i16mr2168132wrf.410.1639530050735;
        Tue, 14 Dec 2021 17:00:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKtKciV2mCOl9DWsiZcW5uvMrGAi6mSHfnjdBtzkqkSsjfHoUdtZOKfa4UaV1nJfnxdVeKPg==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr2168113wrf.410.1639530050540;
        Tue, 14 Dec 2021 17:00:50 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:50 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH 01/60] drm/komeda: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:09 +0100
Message-Id: <20211215010008.2545520-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211215010008.2545520-1-javierm@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the systewm system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/arm/display/komeda/komeda_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index e7933930a657..4f6d5c2103ec 100644
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
@@ -117,6 +118,9 @@ static int komeda_platform_probe(struct platform_device *pdev)
 	struct component_match *match = NULL;
 	struct device_node *child;
 
+	if (drm_firmware_drivers_only())
+		return -EINVAL;
+
 	if (!dev->of_node)
 		return -ENODEV;
 
-- 
2.33.1

