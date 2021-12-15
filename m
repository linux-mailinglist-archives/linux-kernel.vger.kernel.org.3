Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F106F475000
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbhLOBBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:01:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238744AbhLOBA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWbGxoeNjdbDmyKcp2OndXPUITxm5AAUodTQYAK1CmA=;
        b=aQ4e7PmyRfNQOGdXcmrxYoVzrqL+vBnGL3jnXbNTjxYcKLjAuobEgoZmSwFyX4iTKTfHHF
        5pPsYxdfWx2X46gPkHcbYrbt/F6lXaHRI5pUrdCslzN6s14veOx+qTKmrzQMthUM0V3q/W
        KNJkpgmSFS21tH8jPDz1YzGfTDftiJk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-KopP7YAfNJmVcide_lNGIg-1; Tue, 14 Dec 2021 20:00:56 -0500
X-MC-Unique: KopP7YAfNJmVcide_lNGIg-1
Received: by mail-wr1-f71.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso5374723wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWbGxoeNjdbDmyKcp2OndXPUITxm5AAUodTQYAK1CmA=;
        b=qiwpQy9YrWVNwN2G6laWzpp9kWMtLckVsehNXPyW1HEkil7W74Ym2YNa6OuopothQT
         GSu78mysGRZeUhU06r/TZB/N5zH3T5WnmoSi3uELaJi+H8Klq6LeUe2R7HK7hgYGX24Q
         KzZfZ8uVqVelJQpr3f4rGLeYB44mkxkRO0rKQ8jZne8/nnCcx/s7wOaA5otBmE7v+7vC
         E26Rd4BPAh1q5htNxuYQgY7ZNLzLLRGC/UvF08T6e9OsRmzoarGx3WDpfZC/nBSIEqJw
         bN6bWwuewnG8E8w+1HVr+WW3jGQm3XVMYzZQE1FAtHvDdkd6YUY9UH6AuTjw+75awP2N
         62WA==
X-Gm-Message-State: AOAM530qlLxzn1zLzq5ERIywAOqtGPCNQBLKJlO3gDyz7CvC8+pg6Ffl
        QaVhJoIXMDH4Bau7eGr6KxJvF1JHyRCZLo31/bHraG3wbdn3GCJ5X76fhO71oF7HTY1bI2i9osi
        hKT3QxtU2n65McH/V81kLJhX5dDvAEQ3cig+tud2R0X/qmNzGvqD/ntTAinSzr3VnW72K6ho8Fv
        8=
X-Received: by 2002:a5d:4690:: with SMTP id u16mr2171670wrq.321.1639530055180;
        Tue, 14 Dec 2021 17:00:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwByjifmeznMHXNDjsmxy2X6/X9Po4NZarhy11WUEg5MGrKc9cEAhQBDaQMyUvnYgZ4LTTOfw==
X-Received: by 2002:a5d:4690:: with SMTP id u16mr2171646wrq.321.1639530054875;
        Tue, 14 Dec 2021 17:00:54 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:00:54 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 06/60] drm/atmel-hlcdc: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:14 +0100
Message-Id: <20211215010008.2545520-7-javierm@redhat.com>
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

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 1656d27b78b6..4637177184ce 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -747,6 +747,9 @@ static int atmel_hlcdc_dc_drm_probe(struct platform_device *pdev)
 	struct drm_device *ddev;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ddev = drm_dev_alloc(&atmel_hlcdc_dc_driver, &pdev->dev);
 	if (IS_ERR(ddev))
 		return PTR_ERR(ddev);
-- 
2.33.1

