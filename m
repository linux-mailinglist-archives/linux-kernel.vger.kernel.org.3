Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393C147CE4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbhLVI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:29:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243347AbhLVI2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAodSLL93garPqCDkdNkBwu9Tnajc5yTcM/GAEzqdI4=;
        b=JHbwdyuVq1+jZSOfuOUyS2WxaAlWxYEJQASNg4cx/PXn/TxmohdOLBQx6M8yF+6lMqqlU7
        I2E7rJwjFFh7VCqfsD0UVW3FVnqhlbvwG2iZnjr2YsKBAo2DG3350p1rNB5E4sBOElDVcf
        Oc84WL5Lna/kgGlUXLDYUliNRLgKpfQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-hrvdaxZ2OIytC_x84wd3ww-1; Wed, 22 Dec 2021 03:28:52 -0500
X-MC-Unique: hrvdaxZ2OIytC_x84wd3ww-1
Received: by mail-wr1-f69.google.com with SMTP id s23-20020adf9797000000b001a24674f0f7so524677wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAodSLL93garPqCDkdNkBwu9Tnajc5yTcM/GAEzqdI4=;
        b=2qC4YkvcRLGRDCRIQMUHFfkdm5gK9itY/8luTNi7+9nZs7Oas40b7hJc3BsS1N5NuD
         j5z43ungZ1BTIhwZ3kNCd7VhC7ZI3Ob6wwmhzg+GFrziATx3oDKkNmPKUOBk1jERi2rf
         j2JRMbmU3yHqjsoHSkO5uneo8UjxhOuIfGMi13HEdVvc9DBjhjM0pQNtiYLOeVIS4EHG
         XxdUguLxZkOgT/lfR9WnY1GwUoxw6Ywe/AVMGuzvMjy2kkM5Dj0ZQr9d97HjSH2bj5qv
         UrWNqi9FzsaNA8IJpCECrqkywHfDFp2kwfZqADI7A4pTCY8n8gvthIEwH/+aGsY9YwTu
         r6Tg==
X-Gm-Message-State: AOAM533yiWiXSDk9izvEP8/do33cABJ3g/ozTqzxDRw3nC0WBfRAw49Y
        xN95egwKIDE78W6zgN2jjTVEbXmQTXJlK575NjvYoOQWZ/3io7iVP3yZugTZOSfu2UtgPNg4r1k
        dN3ZFHoP93BfiSCEPTkfMrAIyO7XDkYO4BgB/NGRariUPu+e8DroIizTy4eUxvC1de+qV2wPJPo
        M=
X-Received: by 2002:adf:a115:: with SMTP id o21mr1312268wro.412.1640161731358;
        Wed, 22 Dec 2021 00:28:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjm51fMB5qRQAh6yQM8XD4XEpPtgOnxQIVI3FSY5oNhvoDTlTKefemEzBKkx4IHWPKt0Rr4w==
X-Received: by 2002:adf:a115:: with SMTP id o21mr1312255wro.412.1640161731089;
        Wed, 22 Dec 2021 00:28:51 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:50 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH v3 10/10] drm/malidp: Replace module initialization with DRM helpers
Date:   Wed, 22 Dec 2021 09:28:31 +0100
Message-Id: <20211222082831.196562-11-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
References: <20211222082831.196562-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

 drivers/gpu/drm/arm/malidp_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 78d15b04b105..d5aef21426cf 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -25,6 +25,7 @@
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_modeset_helper.h>
+#include <drm/drm_module.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
@@ -1008,7 +1009,7 @@ static struct platform_driver malidp_platform_driver = {
 	},
 };
 
-module_platform_driver(malidp_platform_driver);
+drm_module_platform_driver(malidp_platform_driver);
 
 MODULE_AUTHOR("Liviu Dudau <Liviu.Dudau@arm.com>");
 MODULE_DESCRIPTION("ARM Mali DP DRM driver");
-- 
2.33.1

