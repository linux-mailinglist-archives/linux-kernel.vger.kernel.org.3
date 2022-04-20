Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D05508425
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376984AbiDTI4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376981AbiDTI4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 416DE3B3CA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650444800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEDExOxDlSFKrMo2BADznPf+pk0RrOJ/hIHoQZyWFZ4=;
        b=EcTYLlyIc0hqXzpx7wRDsh7elLfXbAG/eXlJ9SHDpv5sxpIOXlo9wKoup0921k6qXJGVsp
        gqA3sJScjYp4UZsS4tbk/85NV9nQI6dis9uUxJP3fWBOTMaR/xdCJ67U6w8pVSHxOD1hIU
        zReFeUJoE6PS9nIJsk3LPWmqEplpYzI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-4fXKG7aVP8-OdkyiO-1R6w-1; Wed, 20 Apr 2022 04:53:19 -0400
X-MC-Unique: 4fXKG7aVP8-OdkyiO-1R6w-1
Received: by mail-wr1-f69.google.com with SMTP id c17-20020a5d6cd1000000b00207a6974951so193588wrc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HEDExOxDlSFKrMo2BADznPf+pk0RrOJ/hIHoQZyWFZ4=;
        b=esqo/2lMw7co1DXvPx9NCXD9jMzKjut4ISeVQfapIXRlV6ejSupF/JzAbg1sOEW5/W
         1QOKjzHrzYD173lMGiDwzS5mm+1ZKLSqIQQeSI6Qmch+0YPbE+vu/k7rva4g7SrJwqY/
         36m5Cgo0/Hm6cP5tKi78jfoXA0UviIFRb0gVZ9Wqbr5YVKeWvOkXGM13DFYKCWQq8SrW
         lBHvHVwsjAOKYLsnn2uPUSwWqTbn8V2L+7/8yiT1GvxRhNBcnW29r+mQvbP5E7ns3q07
         Gas0dHmeaXwy1oOOHLrHwbSs9yTSa7RvAlAv3RSJHH68DVzTNJ7FDHPFP9b10a3TLUe/
         ZVhg==
X-Gm-Message-State: AOAM533BcXPk41z9Sb5yBAJzFesK6/kGKOK8GjNE418ya7h13FrYTKTQ
        zn27E7a54IzjCuEA8eqnvialhYbmwF/9ut42oV9COVejwdSyJKqEbKOYs8ahwQ1/34dzDvGBSJJ
        S4YafiFltec+1CH+Xznr2RZNub+E+elDP/ivxOqn3GvtX5oQOX4Od5eKvYyKIurRxJMp3oasUs/
        o=
X-Received: by 2002:adf:e5c6:0:b0:207:aad8:ed6b with SMTP id a6-20020adfe5c6000000b00207aad8ed6bmr14800906wrn.242.1650444797908;
        Wed, 20 Apr 2022 01:53:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwN/USyUI3IwYq8lcAz0192pW+SmBMU1Ak8VjdCUyJFupecqBiKfFQM6zinrn+b2EF60zQiEA==
X-Received: by 2002:adf:e5c6:0:b0:207:aad8:ed6b with SMTP id a6-20020adfe5c6000000b00207aad8ed6bmr14800882wrn.242.1650444797613;
        Wed, 20 Apr 2022 01:53:17 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b0020aac00f862sm1895343wry.98.2022.04.20.01.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:53:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH v3 2/5] firmware: sysfb: Add helpers to unregister a pdev and disable registration
Date:   Wed, 20 Apr 2022 10:53:00 +0200
Message-Id: <20220420085303.100654-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420085303.100654-1-javierm@redhat.com>
References: <20220420085303.100654-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These can be used by subsystems to unregister a platform device registered
by sysfb and also to disable future platform device registration in sysfb.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

(no changes since v2)

Changes in v2:
- Add kernel-doc comments and include in other_interfaces.rst (Daniel Vetter).

 .../driver-api/firmware/other_interfaces.rst  |  6 ++
 drivers/firmware/sysfb.c                      | 73 +++++++++++++++++--
 include/linux/sysfb.h                         | 19 +++++
 3 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/firmware/other_interfaces.rst b/Documentation/driver-api/firmware/other_interfaces.rst
index b81794e0cfbb..06ac89adaafb 100644
--- a/Documentation/driver-api/firmware/other_interfaces.rst
+++ b/Documentation/driver-api/firmware/other_interfaces.rst
@@ -13,6 +13,12 @@ EDD Interfaces
 .. kernel-doc:: drivers/firmware/edd.c
    :internal:
 
+Generic System Framebuffers Interface
+-------------------------------------
+
+.. kernel-doc:: drivers/firmware/sysfb.c
+   :export:
+
 Intel Stratix10 SoC Service Layer
 ---------------------------------
 Some features of the Intel Stratix10 SoC require a level of privilege
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index b032f40a92de..a50d2858ce4d 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -34,21 +34,78 @@
 #include <linux/screen_info.h>
 #include <linux/sysfb.h>
 
+static struct platform_device *pd;
+static DEFINE_MUTEX(load_lock);
+static bool disabled;
+
+/**
+ * sysfb_disable() - disable the Generic System Framebuffers support
+ *
+ * This disables the registration of system framebuffer devices that match the
+ * generic drivers that make use of the system framebuffer set up by firmware.
+ *
+ * Context: The function can sleep. A @load_lock mutex is acquired to serialize
+ *          against sysfb_init(), that registers a system framebuffer device and
+ *          sysfb_try_unregister(), that tries to unregister framebuffer devices.
+ */
+void sysfb_disable(void)
+{
+	mutex_lock(&load_lock);
+	disabled = true;
+	mutex_unlock(&load_lock);
+}
+EXPORT_SYMBOL_GPL(sysfb_disable);
+
+/**
+ * sysfb_try_unregister() - attempt to unregister a system framebuffer device
+ * @dev: device to unregister
+ *
+ * This tries to unregister a system framebuffer device if this was registered
+ * by the Generic System Framebuffers. The device will only be unregistered if
+ * it was registered by sysfb_init(), otherwise it will not be unregistered.
+ *
+ * Context: The function can sleep. a @load_lock mutex is acquired to serialize
+ *          against sysfb_init(), that registers a simple framebuffer device and
+ *          sysfb_disable(), that disables the Generic System Framebuffers support.
+ *
+ * Return:
+ * * true          - the device was unregistered successfully
+ * * false         - the device was not unregistered
+ */
+bool sysfb_try_unregister(struct device *dev)
+{
+	bool ret = true;
+
+	mutex_lock(&load_lock);
+	if (!pd || pd != to_platform_device(dev))
+		return false;
+
+	platform_device_unregister(to_platform_device(dev));
+	pd = NULL;
+	mutex_unlock(&load_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sysfb_try_unregister);
+
 static __init int sysfb_init(void)
 {
 	struct screen_info *si = &screen_info;
 	struct simplefb_platform_data mode;
-	struct platform_device *pd;
 	const char *name;
 	bool compatible;
-	int ret;
+	int ret = 0;
+
+	mutex_lock(&load_lock);
+	if (disabled)
+		goto unlock_mutex;
 
 	/* try to create a simple-framebuffer device */
 	compatible = sysfb_parse_mode(si, &mode);
 	if (compatible) {
 		pd = sysfb_create_simplefb(si, &mode);
 		if (!IS_ERR(pd))
-			return 0;
+			goto unlock_mutex;
 	}
 
 	/* if the FB is incompatible, create a legacy framebuffer device */
@@ -60,8 +117,10 @@ static __init int sysfb_init(void)
 		name = "platform-framebuffer";
 
 	pd = platform_device_alloc(name, 0);
-	if (!pd)
-		return -ENOMEM;
+	if (!pd) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
 
 	sysfb_apply_efi_quirks(pd);
 
@@ -73,9 +132,11 @@ static __init int sysfb_init(void)
 	if (ret)
 		goto err;
 
-	return 0;
+	goto unlock_mutex;
 err:
 	platform_device_put(pd);
+unlock_mutex:
+	mutex_unlock(&load_lock);
 	return ret;
 }
 
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index 708152e9037b..e8c0313fac8f 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -55,6 +55,25 @@ struct efifb_dmi_info {
 	int flags;
 };
 
+#ifdef CONFIG_SYSFB
+
+void sysfb_disable(void);
+bool sysfb_try_unregister(struct device *dev);
+
+#else /* CONFIG_SYSFB */
+
+static inline void sysfb_disable(void)
+{
+
+}
+
+static inline bool sysfb_try_unregister(struct device *dev)
+{
+	return false;
+}
+
+#endif /* CONFIG_SYSFB */
+
 #ifdef CONFIG_EFI
 
 extern struct efifb_dmi_info efifb_dmi_list[];
-- 
2.35.1

