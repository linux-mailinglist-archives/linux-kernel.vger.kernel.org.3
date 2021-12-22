Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8347CE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhLVI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236299AbhLVI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640161724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQ6XtD20XG1EILVnbhVJNr5Jw2nThRr8sIpMKb8E/Wg=;
        b=WKem7XRBLj8sqkz+QHBaE4kNixniVCYrtZa4a/7Di62Ej/xM9xdlSROdbSv1iQrlMg7Q/n
        VB9HUcJZg73Vh/m8SZwi2w487XG/7KyYHowVYBP9sT1oyBxLAG4fgxQw2BarL8vcuRVhkW
        9U7qpKNwOwHevoqj91uKz8WpcEyoyvI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-7xpUUH_gMrmm2X9u2U2ZPQ-1; Wed, 22 Dec 2021 03:28:43 -0500
X-MC-Unique: 7xpUUH_gMrmm2X9u2U2ZPQ-1
Received: by mail-wm1-f70.google.com with SMTP id g126-20020a1c2084000000b00345c1603997so359203wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQ6XtD20XG1EILVnbhVJNr5Jw2nThRr8sIpMKb8E/Wg=;
        b=hUNAzEz2qt4Ddrtojdcel2u8R5cfbZN6eVOCNSr+ELx0Fgtca+LUWCfZlxS02qhc18
         DJZ3Ylt51m9NoaYTgZgJ65ShiHevpFCHgFXBjWcYC9IxUxLwEPN7n6kWhxMuF/Umah/a
         T5qYn6J606I/eHMFK7dQYaecJ0Lgck32wlOiJCddjUTcAxrAgXjQ6gCAQ5dbz+HJqSSq
         5/4Sb8GZbTiyA5Sb3eBAB6D36BM9DPIIHMzewvly2mT99BrNyolA08FXYZYKQCOApjac
         SNb9Ty2q7+xVxpFiEfsXQ0e41XM7rrNZyvgFf1Htg0eDeoktq99OPcz50uYANTPvV3VS
         GC2A==
X-Gm-Message-State: AOAM532LvyFpVASTbw5AEuHkdBVRe8bd+vrA8hMJSW/ME/VMlnD26lrv
        CiVDYqFyy8rmZfatJalpTkbvfYnaTAfseRgdySOqYTii5tNpje8ID6OBBZJIOb+Mo4lXowLhAL5
        LxTJwewQedxqCp5v8HFXP9f35m5fzTWVmmMrIZB6rqZerVUnWhIucABep5V3J5gi5MbDH+9xOij
        s=
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr101535wmk.33.1640161721913;
        Wed, 22 Dec 2021 00:28:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBH22gXld28rnt/TMJZsw2cU9PK2Y6h1QwrH7n0X9igVQwkJGQTXog3ZD10Wn09ZlKplL59Q==
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr101513wmk.33.1640161721658;
        Wed, 22 Dec 2021 00:28:41 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m17sm1247080wrz.91.2021.12.22.00.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:28:41 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, linux-doc@vger.kernel.org
Subject: [PATCH v3 01/10] drm: Provide PCI module-init macros
Date:   Wed, 22 Dec 2021 09:28:22 +0100
Message-Id: <20211222082831.196562-2-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222082831.196562-1-javierm@redhat.com>
References: <20211222082831.196562-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Zimmermann <tzimmermann@suse.de>

Provide helper macros to register PCI-based DRM drivers. The new
macros behave like module_pci_driver() with an additional test if
DRM modesetting has been enabled.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 Documentation/gpu/drm-internals.rst |  6 ++
 include/drm/drm_module.h            | 95 +++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 include/drm/drm_module.h

diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
index 607f78f0f189..38afed24a75c 100644
--- a/Documentation/gpu/drm-internals.rst
+++ b/Documentation/gpu/drm-internals.rst
@@ -75,6 +75,12 @@ update it, its value is mostly useless. The DRM core prints it to the
 kernel log at initialization time and passes it to userspace through the
 DRM_IOCTL_VERSION ioctl.
 
+Module Initialization
+---------------------
+
+.. kernel-doc:: include/drm/drm_module.h
+   :doc: overview
+
 Managing Ownership of the Framebuffer Aperture
 ----------------------------------------------
 
diff --git a/include/drm/drm_module.h b/include/drm/drm_module.h
new file mode 100644
index 000000000000..eb3fd7bcbec9
--- /dev/null
+++ b/include/drm/drm_module.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef DRM_MODULE_H
+#define DRM_MODULE_H
+
+#include <linux/pci.h>
+
+#include <drm/drm_drv.h>
+
+/**
+ * DOC: overview
+ *
+ * This library provides helpers registering DRM drivers during module
+ * initialization and shutdown. The provided helpers act like bus-specific
+ * module helpers, such as module_pci_driver(), but respect additional
+ * parameters that control DRM driver registration.
+ *
+ * Below is an example of initializing a DRM driver for a device on the
+ * PCI bus.
+ *
+ * .. code-block:: c
+ *
+ *	struct pci_driver my_pci_drv = {
+ *	};
+ *
+ *	drm_module_pci_driver(my_pci_drv);
+ *
+ * The generated code will test if DRM drivers are enabled and register
+ * the PCI driver my_pci_drv. For more complex module initialization, you
+ * can still use module_init() and module_exit() in your driver.
+ */
+
+/*
+ * PCI drivers
+ */
+
+static inline int __init drm_pci_register_driver(struct pci_driver *pci_drv)
+{
+	if (drm_firmware_drivers_only())
+		return -ENODEV;
+
+	return pci_register_driver(pci_drv);
+}
+
+/**
+ * drm_module_pci_driver - Register a DRM driver for PCI-based devices
+ * @__pci_drv: the PCI driver structure
+ *
+ * Registers a DRM driver for devices on the PCI bus. The helper
+ * macro behaves like module_pci_driver() but tests the state of
+ * drm_firmware_drivers_only(). For more complex module initialization,
+ * use module_init() and module_exit() directly.
+ *
+ * Each module may only use this macro once. Calling it replaces
+ * module_init() and module_exit().
+ */
+#define drm_module_pci_driver(__pci_drv) \
+	module_driver(__pci_drv, drm_pci_register_driver, pci_unregister_driver)
+
+static inline int __init
+drm_pci_register_driver_if_modeset(struct pci_driver *pci_drv, int modeset)
+{
+	if (drm_firmware_drivers_only() && modeset == -1)
+		return -ENODEV;
+	if (modeset == 0)
+		return -ENODEV;
+
+	return pci_register_driver(pci_drv);
+}
+
+static inline void __exit
+drm_pci_unregister_driver_if_modeset(struct pci_driver *pci_drv, int modeset)
+{
+	pci_unregister_driver(pci_drv);
+}
+
+/**
+ * drm_module_pci_driver_if_modeset - Register a DRM driver for PCI-based devices
+ * @__pci_drv: the PCI driver structure
+ * @__modeset: an additional parameter that disables the driver
+ *
+ * This macro is deprecated and only provided for existing drivers. For
+ * new drivers, use drm_module_pci_driver().
+ *
+ * Registers a DRM driver for devices on the PCI bus. The helper macro
+ * behaves like drm_module_pci_driver() with an additional driver-specific
+ * flag. If __modeset is 0, the driver has been disabled, if __modeset is
+ * -1 the driver state depends on the global DRM state. For all other
+ * values, the PCI driver has been enabled. The default should be -1.
+ */
+#define drm_module_pci_driver_if_modeset(__pci_drv, __modeset) \
+	module_driver(__pci_drv, drm_pci_register_driver_if_modeset, \
+		      drm_pci_unregister_driver_if_modeset, __modeset)
+
+#endif
-- 
2.33.1

