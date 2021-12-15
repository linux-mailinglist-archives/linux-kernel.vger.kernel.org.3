Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DAD475029
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbhLOBDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:03:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239087AbhLOBBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPkpzdLGHFuwSmlCqreinOa0NMKpEirlVUjYsF2sEmI=;
        b=Hh1sLqROcC0vGbr6H2fLw1gT0rk9Xx9rjaCALgseSA1WQzBuVchEPwpwjhmmexe8QB+aYc
        fngCEr6hk5NiSn7Cl/20MqCIBPoPH1Y3NmCW10OMa5A3t8TJ2xoHs3onO4w0JHkRb/btqj
        9jxFay2rLgHBzJVsp89uHV0PURewU0w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-IzQoRSF0NhaYIti9zBp0gg-1; Tue, 14 Dec 2021 20:01:34 -0500
X-MC-Unique: IzQoRSF0NhaYIti9zBp0gg-1
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so13898303wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPkpzdLGHFuwSmlCqreinOa0NMKpEirlVUjYsF2sEmI=;
        b=MzeA4Iy5Q69KMXF5JWNs71+VI5Fe6J+p+PUW2dvqRvZpQyU7yuLsHgfz9dGLIB+vtr
         7DoW6JY6X9D6PQ6OBplfijLK0f4vkBkWEmBbgxY1slq669uoFoLE+I387FGPtNwcH8Tt
         oLE72tW0xZPFQMixBGMJ8LJUESKkUbnReME8jQjcSd4wI4FMcU63GUHBcLIX4i2++bgA
         AsslgO+om264udoZrEXOdIXqfWWFEGEK0G9B96ckYh/ujml31CCTK0+WV+WrZLQ+QTdm
         MQerq54xZS1WwlOe3jKeFma3Jl6fgzyuwpftsGSrzFdnICXobh1ZWa/C5qgHnPq62DSV
         CULg==
X-Gm-Message-State: AOAM532AcPI8yqAKjDSf2ctri7UmhcBSPnXGIqBiZW1YOXWJ8uNa3BJ7
        baBlISN0M4UaEe1ATDKtcUaUzumwfLwfbA7yiDnBXQI+w3KGF8o8FK3Yz6J4lRoeWxns2Nzpda7
        M6s/M7rCJh/tRIdes8JJ44Z7vh5bwSlgkcMlKoUONLLtxMvwcxqyaOfoekQ15GerHCTaKf1oPqt
        M=
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr2262420wri.8.1639530093524;
        Tue, 14 Dec 2021 17:01:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxO9OzQ3IFEK6KRWAqhTd7Lh7dEalRNtkSBcpZfIM+CviSqSyK/oq21ZgWwll/ZU1mjmxEF1w==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr2262403wri.8.1639530093287;
        Tue, 14 Dec 2021 17:01:33 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:32 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 50/60] drm/ili9341: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:58 +0100
Message-Id: <20211215010008.2545520-51-javierm@redhat.com>
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

 drivers/gpu/drm/tiny/ili9341.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
index 37e0c33399c8..5226b768c550 100644
--- a/drivers/gpu/drm/tiny/ili9341.c
+++ b/drivers/gpu/drm/tiny/ili9341.c
@@ -182,6 +182,9 @@ static int ili9341_probe(struct spi_device *spi)
 	u32 rotation = 0;
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	dbidev = devm_drm_dev_alloc(dev, &ili9341_driver,
 				    struct mipi_dbi_dev, drm);
 	if (IS_ERR(dbidev))
-- 
2.33.1

