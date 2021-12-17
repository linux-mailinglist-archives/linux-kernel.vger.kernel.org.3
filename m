Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150544781AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhLQAjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:39:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231304AbhLQAig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E88hmYo+ObZf3tGYS6T1KggzSFzJlGn4i9AC9N8Fn9Y=;
        b=U7C2zxW1jS/U1DYi3ophu/ok4G2Ecks0CSxXfFdlw1ndUpp12O3Co057hrJTcQrxJOL40o
        Pv7A1gXtwpvE0d2phmjJqwsFSKXk0jbigk5AdcUMVQQbK48eaXYmx1o9W+PIAFwp1y4itJ
        ESJoQqQh2UgfBZTKw5gI1PKFrKaSKkM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-zUYIjUffMw2GtQlnCOeyEw-1; Thu, 16 Dec 2021 19:38:26 -0500
X-MC-Unique: zUYIjUffMw2GtQlnCOeyEw-1
Received: by mail-wm1-f72.google.com with SMTP id p13-20020a05600c1d8d00b0034565e7e5c6so380018wms.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E88hmYo+ObZf3tGYS6T1KggzSFzJlGn4i9AC9N8Fn9Y=;
        b=sKrHwNa8TnWiZ2V90LcDxsjfCRR2BSXzKwrTfAAmnp3sQ1K99GZYqC06gIZtNQRTmm
         Q/iSazPACb+TU3KzxTSZTdgukGJUDO7e4BLPJIG6aStNmftR6AUkszCJD5ldDVXt/WZg
         7Y1i+jSLN8NWKABUK/83An5N2rz5TFc/2WCgxjKDHZ0is+40UY/GIctx2ouBblOvKJBg
         52UEUjWWjLMkgSN9fopf9vSGjM1sIbWwJ/elIS45ZQUWvM+PjWRY9ssTdBCIYaf2JZp4
         Liqb69C3wyw2mGspNGf5S5EuE0QTUGOgQM2XHvtpcLInioDtSekyhX++mRTm17iv0Chp
         Zgww==
X-Gm-Message-State: AOAM531llQ7K2CmuqiZ4WshJV6FOg6w65TD4NFW6diPFwpDlf2GHqIXa
        zX+oAXrRXkrbJMmS1ZJ0VAlXbbxW7TcY2lEytt1F9qNOrWuz/RuMbo8Jhvk017iIiGBTrUDAFQP
        rmX4evIvKJiwJqN1hDf7V5HvJbIbYujnXcrVAg6dxIKsyhh69AKAKdGIbTUMfmivyGro+hopqFc
        c=
X-Received: by 2002:adf:90e5:: with SMTP id i92mr344961wri.675.1639701504698;
        Thu, 16 Dec 2021 16:38:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1Ro2A75bOdMBtxiDF+OSPrt4upTH2ZoFakfTkrJa5WrM1j9hPOCbZctKCZYRtvUlKF/lE9w==
X-Received: by 2002:adf:90e5:: with SMTP id i92mr344947wri.675.1639701504446;
        Thu, 16 Dec 2021 16:38:24 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:38:24 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 27/37] drm/mcde: Add support for the nomodeset kernel parameter
Date:   Fri, 17 Dec 2021 01:37:42 +0100
Message-Id: <20211217003752.3946210-28-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, this
parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, make this driver
to also support the command line parameter.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

(no changes since v1)

 drivers/gpu/drm/mcde/mcde_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 5b5afc6aaf8e..0b2910e69b42 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -491,6 +491,9 @@ static int __init mcde_drm_register(void)
 {
 	int ret;
 
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
 	ret = platform_register_drivers(component_drivers,
 					ARRAY_SIZE(component_drivers));
 	if (ret)
-- 
2.33.1

