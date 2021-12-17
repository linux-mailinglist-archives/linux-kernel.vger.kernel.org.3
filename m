Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14EE47816B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 01:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhLQAiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 19:38:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230354AbhLQAiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 19:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639701482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JXrPLKHkj9hSvtJ2AHjE/yBMtVQMtgWT388e8DCoaeE=;
        b=AEwHTNcM1Qcdh1u/9lOPtPHBhu1cxusqUlnMXQ7TMW3hIT7PhxUAOIHWyrIFpJpLoH4Wi0
        +XJsb3kNaKTnfnESb2/sIUfFqpE6XL9LsRkN2/hbrEVfhbuIsH4L2nn8iEDikfe0TVgW5k
        MQ9oteHe9tXKlKGbT+1i3OiCvL1+PoU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-04079mf-PKidc2n3HHndxQ-1; Thu, 16 Dec 2021 19:38:00 -0500
X-MC-Unique: 04079mf-PKidc2n3HHndxQ-1
Received: by mail-wm1-f72.google.com with SMTP id b75-20020a1c804e000000b0034569bde713so2066280wmd.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 16:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXrPLKHkj9hSvtJ2AHjE/yBMtVQMtgWT388e8DCoaeE=;
        b=66H1lb1ptnFz8fu4ARYsHG7nt10v5G422s9ARGSCU6/achZodGOEL/fCotqd69Gh8h
         /Jp8be+qRr4n8o5DgE9mN8zgk52y+CFWDQvwohqFpxNWXOx5Uu+RECjQfSz76SimsMxZ
         UUymnae6VOuxXp17doi4dejaYt59mAxpZx4ixb/vA8bCUCD+ITCEoGu7p5S/h2C/F6Qz
         hH/AicGB1yTA12J3mU6bAZszb1cpxM15JYx+7eDJtrDW0oKkevcUeYcRlq3nWhV9xrIz
         t4OLNeQUDK8VyW5CP2vjp6jG5xbbzuPOgqG7mZAVx/orvix8c+Ymzzl8I3dqOO21T6bC
         /UoQ==
X-Gm-Message-State: AOAM532z9NDMJG1cE7zS+noruRSYNaxpTxZgy4JUbd8PlsWGL7lX4GUC
        FirbjXGtcSLBsN08EBKIblFDqQhH+mOwKEbG/dkor1Q6cRD0iuvk103e7Jn0Auy406jhTIZSUwo
        IfTRPATPWTyIBcViQu6X69ciXJl1jW/xUwqoKoqL4LtS2D15W4qV7O+jkJrRkPz8Xt6Lf4vxpcO
        U=
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr6988719wmb.28.1639701479312;
        Thu, 16 Dec 2021 16:37:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXlo6FfstO8WIBxtUT+l0qYJ9trpsz9hQRn5Kxt8vi+S6wBpB0/8cDKIlyx5IsLtqZhpQOyg==
X-Received: by 2002:a1c:1b08:: with SMTP id b8mr6988702wmb.28.1639701478950;
        Thu, 16 Dec 2021 16:37:58 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg12sm7368433wmb.5.2021.12.16.16.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:37:58 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 01/37] drm: Add drm_module_{pci,platform}_driver() helper macros
Date:   Fri, 17 Dec 2021 01:37:16 +0100
Message-Id: <20211217003752.3946210-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217003752.3946210-1-javierm@redhat.com>
References: <20211217003752.3946210-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to disable Documentation/admin-guide/kernel-parameters.txt, the
nomodeset parameter can be used to disable kernel modesetting.

DRM drivers will not perform display-mode changes or accelerated rendering
and only the system framebuffer will be available if it was set-up.

But only a few DRM drivers currently check for nomodeset, so let's add two
helper macros that can be used by DRM drivers for PCI and platform devices
to have module init functions that checks if the drivers could be loaded.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 include/drm/drm_drv.h | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index f6159acb8856..4001d73428c5 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -29,6 +29,8 @@
 
 #include <linux/list.h>
 #include <linux/irqreturn.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
 
 #include <drm/drm_device.h>
 
@@ -604,4 +606,52 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name);
 
 extern bool drm_firmware_drivers_only(void);
 
+/**
+ * drm_pci_register_driver() - register a DRM driver for PCI devices
+ * @drv: PCI driver structure
+ *
+ * Returns zero on success or a negative errno code on failure.
+ */
+static inline int drm_pci_register_driver(struct pci_driver *drv)
+{
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
+	return pci_register_driver(drv);
+}
+
+/**
+ * drm_module_pci_driver() - helper macro for registering a DRM PCI driver
+ *
+ * Helper macro for DRM PCI drivers which do not do anything special in their
+ * module init/exit and just need the DRM specific module init.
+ */
+#define drm_module_pci_driver(__pci_driver) \
+	module_driver(__pci_driver, drm_pci_register_driver, \
+		      pci_unregister_driver)
+
+/**
+ * drm_platform_driver_register - register a DRM driver for platform devices
+ * @drv: platform driver structure
+ *
+ * Returns zero on success or a negative errno code on failure.
+ */
+static inline int drm_platform_driver_register(struct platform_driver *drv)
+{
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
+	return platform_driver_register(drv);
+}
+
+/**
+ * drm_module_platform_driver() - helper macro for registering a DRM platform driver
+ *
+ * Helper macro for DRM platform drivers which do not do anything special in their
+ * module init/exit and just need the DRM specific module init.
+ */
+#define drm_module_platform_driver(__platform_driver) \
+	module_driver(__platform_driver, drm_platform_driver_register, \
+		      platform_driver_unregister)
+
 #endif
-- 
2.33.1

