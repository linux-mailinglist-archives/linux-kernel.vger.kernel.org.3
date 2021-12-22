Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE447CE41
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbhLVI25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:28:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236903AbhLVI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=916gpQ5TQZBxXpPApgtQW0I1UIGKedMg/4PyltH33/c=;
        b=eF8WAqRzHnrQ9pZH+9c/iNxeAvoPOE5sTpf6mgD4xGVVojAZewRMpfv0vT3PHmbW2PxR3e
        WBojX1lbD4Rhn9JeCrorF7iNdaDJxc9/V4/mnPMIQShxSb0q6Sb/RqyGxpg1v2gT8Vr0rf
        nJ8FzNkkFYKVGn1IhNTMWASi8Px514M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-jNyBZ0gYNJKut1PuCa6PXQ-1; Wed, 22 Dec 2021 03:28:48 -0500
X-MC-Unique: jNyBZ0gYNJKut1PuCa6PXQ-1
Received: by mail-wr1-f70.google.com with SMTP id j26-20020adfb31a000000b001a2356afd4fso516872wrd.21
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=916gpQ5TQZBxXpPApgtQW0I1UIGKedMg/4PyltH33/c=;
        b=PhrQpMxGsbkWiddaD1/6YNb3Tv34bLCnC5RyUMEs2fPTUomurHj91CMoTwiP8YqvPd
         ylcNVqedEe0F+TsVPkUGeuFTkjfTUYrvKXaYy2Bv63V4f5tm7u8rA23UmuFcrlhAb+4o
         nRJOzpZavPmUglyVIrsrqhrjYWnOG5orM6vnmUbmHeQNf4tyFm+MtA3nvEEdshqt6QiL
         OwyeRxSTTtKp+mvI7rHgxFcrwpJLOnWN/p/4+t8fp9ObO4ND5kmVat49XkGoKeHs4sTc
         jitS41cvugt12MTdQDNO4zviLVjY6OFTzwrVW+QAqzmI/qKBwG2nFFdi6ZuBHjVG559c
         cGoQ==
X-Gm-Message-State: AOAM5313JNdx8gOh9RemkggPIE77T8GyV5srrYrGf/nb/m9Ns9DukgLA
        GXPI7Z/iemji8f0WczLZf8GyMwf4fKDje5tBCXbbMOU7e+1acyZDEppMRHsOuhE8rZuNT1tZ9w1
        mwXU0c4vZvsI8udHG9UNZRIHYH4gBt3osn05FUnhsN6kSNReqMNvcABzmaMVIyHBpHHncxQUxcP
        4=
X-Received: by 2002:a5d:4144:: with SMTP id c4mr1323688wrq.702.1640161727507;
        Wed, 22 Dec 2021 00:28:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyArIqTBpIbNGxmI4/yEpmZMeqf+tgNqKacNBC/CgC6jGtAWwEbfkMrIM/wDbmBhbs8PlGrlg==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr1323670wrq.702.1640161727213;
        Wed, 22 Dec 2021 00:28:47 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:47 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 06/10] drm: Provide platform module-init macro
Date:   Wed, 22 Dec 2021 09:28:27 +0100
Message-Id: <20211222082831.196562-7-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
References: <20211222082831.196562-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a helper macro to register platform DRM drivers. The new
macro behaves like module_platform_driver() with an additional
test if DRM modesetting has been enabled.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 include/drm/drm_module.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/drm/drm_module.h b/include/drm/drm_module.h
index eb3fd7bcbec9..4db1ae03d9a5 100644
--- a/include/drm/drm_module.h
+++ b/include/drm/drm_module.h
@@ -4,6 +4,7 @@
 #define DRM_MODULE_H
 
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 
 #include <drm/drm_drv.h>
 
@@ -92,4 +93,33 @@ drm_pci_unregister_driver_if_modeset(struct pci_driver *pci_drv, int modeset)
 	module_driver(__pci_drv, drm_pci_register_driver_if_modeset, \
 		      drm_pci_unregister_driver_if_modeset, __modeset)
 
+/*
+ * Platform drivers
+ */
+
+static inline int __init
+drm_platform_driver_register(struct platform_driver *platform_drv)
+{
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
+	return platform_driver_register(platform_drv);
+}
+
+/**
+ * drm_module_platform_driver - Register a DRM driver for platform devices
+ * @__platform_drv: the platform driver structure
+ *
+ * Registers a DRM driver for devices on the platform bus. The helper
+ * macro behaves like module_platform_driver() but tests the state of
+ * drm_firmware_drivers_only(). For more complex module initialization,
+ * use module_init() and module_exit() directly.
+ *
+ * Each module may only use this macro once. Calling it replaces
+ * module_init() and module_exit().
+ */
+#define drm_module_platform_driver(__platform_drv) \
+	module_driver(__platform_drv, drm_platform_driver_register, \
+		      platform_driver_unregister)
+
 #endif
-- 
2.33.1

