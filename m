Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4CA47501F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbhLOBCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:02:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238968AbhLOBB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639530085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1nXGx5Wd/g7fzmsst6Uux3CzRbuFIIxSi+2V/lXjkE=;
        b=atq3IUbzy8mBIdxHMnQJfSN3PL+dD+7kRgfQR7EXPIMp9JXBlGxw4qabI/cv1wp2T/oV66
        /XPdmfG+ncCtlqmss/NyesS9OypWx0pircjDCVvrmBOGH9NLyhUbWpxPBSBfJDNn2JCjO+
        mEtH0PKolP+OmMXgYisAsP9hK/TR88s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-BtET-LZiNDyhgX4wtzIWNw-1; Tue, 14 Dec 2021 20:01:24 -0500
X-MC-Unique: BtET-LZiNDyhgX4wtzIWNw-1
Received: by mail-wm1-f71.google.com with SMTP id v23-20020a05600c215700b0034566adb612so211740wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 17:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1nXGx5Wd/g7fzmsst6Uux3CzRbuFIIxSi+2V/lXjkE=;
        b=rB8yw6jRVjoKT66x8i24JBWKUbmwJHduEAkORDGyn6BqpEHRFKoM8fahmdvsRWXF5d
         meoLMVq/7WEFniCRciTjzju+4S7CvIXF7A/G70yqEeZ5JCu9KwiY6n8qvhWbXKfT601n
         7aIgCMV++NvOcY/yYKvH+KheC4zpYJ0VL/1yyXpL8dM4NdyH6Vb8qx0ovC71muleo0FT
         HDaE3qzUDTe+oDszW4weuovHPcgBxdvXADMoW1k7HByB7romN0X2Ic3vru3rD8PaSv73
         6ko9HbGcD24GA2HUyoUUvBzEaqrnQMWbmpIqItIxS0cSNGfBfPpeJWRX8wOiWW30Qwwk
         lhbQ==
X-Gm-Message-State: AOAM530P7yAufe0hnUBI7DbIfsneIL7TXxJaHGAwEwmCWpQvl6MV16Vk
        fFzm1ZODxQnQvUkeflzQ0wfE+IjyyBPrkhYx74x+VLZSZxazf0ktlBj1hnjAaTDRfZhQzj35bHr
        NEF0ekHCTimYG+YgNULioqimoIS3XFurQ996v5S1Y4ebq6USq/nqU6HxRLdkUW/0/YnHEJVraR6
        A=
X-Received: by 2002:adf:e286:: with SMTP id v6mr2221063wri.565.1639530082884;
        Tue, 14 Dec 2021 17:01:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx22fYzLE1Ah8GH2QbaO1YPJDRk0tppY9ONA/JiuobDywPJUJXpeRGzz7g6xwBp2l/1xqmXrg==
X-Received: by 2002:adf:e286:: with SMTP id v6mr2221050wri.565.1639530082703;
        Tue, 14 Dec 2021 17:01:22 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o64sm334543wme.28.2021.12.14.17.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:01:22 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 37/60] drm/sprd: Add support for the nomodeset kernel parameter
Date:   Wed, 15 Dec 2021 01:59:45 +0100
Message-Id: <20211215010008.2545520-38-javierm@redhat.com>
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

 drivers/gpu/drm/sprd/sprd_drm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index a077e2d4d721..dd7e3de780f3 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -186,6 +186,9 @@ static struct platform_driver *sprd_drm_drivers[]  = {
 
 static int __init sprd_drm_init(void)
 {
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	return platform_register_drivers(sprd_drm_drivers,
 					ARRAY_SIZE(sprd_drm_drivers));
 }
-- 
2.33.1

