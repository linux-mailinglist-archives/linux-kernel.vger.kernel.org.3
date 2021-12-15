Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1247501C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhLOBCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238939AbhLOBBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Vk2qnrhEf+Kai7YeRcT32BEinF6P94Q+jPpKbZkEq0=;
        b=fuGVBp123MMiOjKT8yf+TTR7JfrOMeXsAIYNxtxjcxvy3wFB5htLDOjAob14UKzK9CIwgp
        TUc0a3y4Bnvjt/OJ4G3xJeJnGWccuDKbWXY/SzDHGOnwtcNaJfVmpHKL2wwAgQ5A4Z5RS8
        L7fpfQn1CdX9wSIR4n1DjVF1dzbwZP4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-Gzcy_5OBN6quZeYsPzBmuA-1; Tue, 14 Dec 2021 20:01:21 -0500
X-MC-Unique: Gzcy_5OBN6quZeYsPzBmuA-1
Received: by mail-wm1-f72.google.com with SMTP id j20-20020a05600c1c1400b00343ad0c4c40so1928956wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Vk2qnrhEf+Kai7YeRcT32BEinF6P94Q+jPpKbZkEq0=;
        b=AEUNruAEp/T7vnDV6JHSXIeXdwgDcZK1g29/V+jXJnsiIiFXjlrd94npMb8JBFBiQI
         oPMl3uA2ZnbM9ZA6nFuqHH671TotL68g96qIXiQl2kGpiVZt2fLnp7wniGvU72aepY6L
         DyRZ4k/2XjqnPaUj/gbfkfzl8T5fXGLSKxC/tU0vUgJC5Z0r9CdvjIA8RtvLCobaOA55
         Ox8IpnQ1xCy+XAgpdjErr4kimzCz8HDbCzunqIM95PkVwtu5ziA0bgJqQj2BLMRm1PsI
         vb3qwy5IckH6FnvwuRgP8kPDIlObL5TNbDMVnFv9ar0e0KfY7ImUvO3M9YFHRc7ZZ1sp
         A47Q==
X-Gm-Message-State: AOAM530mbupx4OKcmSRRZcgHlKNTQxC06Nwl0/Y5htO/gxC0P6PpLSYL
        Lkp/0y0lS9yf+IY7q2NlfmOJzgKme7UjRFAQ6upv4/Y4RnZF008OIVq20wWM2w7xcWt+ij8jaV+
        ecY2El2bRysemDbjEGSfJQdspWXH9OP/SB5Wp6akfjqhSO306bOSspTWsr1ZK7XAeUDg7pfWM+N
        k=
X-Received: by 2002:a5d:64c4:: with SMTP id f4mr2274522wri.6.1639530079951;
        Tue, 14 Dec 2021 17:01:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpgf/synfrDivMDCeU4Ykh/9ngl8VnGKCZ76Fqha4/HBFuKYtD61t4V9M6O1vIOzMH4S9syg==
X-Received: by 2002:a5d:64c4:: with SMTP id f4mr2274509wri.6.1639530079778;
        Tue, 14 Dec 2021 17:01:19 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:19 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 34/60] drm/savage: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:42 +0100
Message-Id: <20211215010008.2545520-35-javierm@redhat.com>
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

 drivers/gpu/drm/savage/savage_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/savage/savage_drv.c b/drivers/gpu/drm/savage/savage_drv.c
index 799bd11adb9c..bb3f12874178 100644
--- a/drivers/gpu/drm/savage/savage_drv.c
+++ b/drivers/gpu/drm/savage/savage_drv.c
@@ -74,6 +74,9 @@ static struct pci_driver savage_pci_driver = {
 
 static int __init savage_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	driver.num_ioctls = savage_max_ioctl;
 	return drm_legacy_pci_init(&driver, &savage_pci_driver);
 }
-- 
2.33.1

