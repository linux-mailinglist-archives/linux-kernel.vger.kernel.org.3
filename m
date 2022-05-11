Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48DE52317A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbiEKL00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbiEKLZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39383237BBF
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhuIDxij1dFQK1woz+U0GSNcD8pO0M2OCBta2I1W2Qw=;
        b=ORBnxkDHB3xfQBM956IWxyKKhkWgmM/vAIHqush/esJWAq/OALFIa8Kmp7JSdaQ/6NQKCU
        pE5fFBt3AO253X16kc1Fq+1MbssSJCuCJhIJxemwfSDY6WwIniEl5M1CBaeTpKlRNpuM8h
        xbr1z71X/mUqBswsECj3Z2ivG2dB3oE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-lXwsggiIOsuKnIQzTRd7bA-1; Wed, 11 May 2022 07:24:58 -0400
X-MC-Unique: lXwsggiIOsuKnIQzTRd7bA-1
Received: by mail-wm1-f70.google.com with SMTP id i18-20020a1c5412000000b0039491a8298cso610434wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhuIDxij1dFQK1woz+U0GSNcD8pO0M2OCBta2I1W2Qw=;
        b=2q4gTW4KFcn0F6p2NNr8StxJWW5aI+H7tU/qrm2oMrQJtyJmnL/LIbIblcfpzlk1qG
         Dmyz46PtBi/NBQ1H0C57AocMcPP9oFvV8sFh9QSLpRetFvQOWt+MlrC6Zw8+/2ZgAwbb
         tfD6aNib6S0DZ9HmZ71rNv+JcBAcLtfDfuHCXDYmGwevesUx/aWu2isxza/giQNoT4DL
         whlbCc9d8NgDaWX6qunQaJGFKr9L4bSTq/rOwdHJcyTlKqC1S9Fxs1oHukuU/nIwdAVK
         YLiHOcgoKbGUOx6mDpgtzbGuzN++tI68hVP8V8BjA8GsfPcqr/0Er0ZwYSCLBnlgUYh4
         YL6Q==
X-Gm-Message-State: AOAM532UDaYKsDntnTu4vFfEodq7GebfVav7H21vuOmZOxmSStcy3CjP
        /hzN0bpCJ4W9sUweIyMVwlYrvU8kCmsRq1g5WHvduKaa5bGy1pQjwlpVinMPqjplPsHPY9jeK9Y
        e/4LCJ2x7G3c9umlj0OUYydKGhIMo4ALg4Qrw7PvH0uh3LQPWrlKnWSdUCPjKxi/XfwpkgiXMq6
        Q=
X-Received: by 2002:a7b:cc93:0:b0:394:2622:fcd9 with SMTP id p19-20020a7bcc93000000b003942622fcd9mr4514984wma.20.1652268296569;
        Wed, 11 May 2022 04:24:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRIFQcq1jQPPfql9v29OqbDwMo6HCFe2d4EHkjhfoYsd8KlDrK7oJBh/f5bYM9M/IMttgafQ==
X-Received: by 2002:a7b:cc93:0:b0:394:2622:fcd9 with SMTP id p19-20020a7bcc93000000b003942622fcd9mr4514945wma.20.1652268296167;
        Wed, 11 May 2022 04:24:56 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4481000000b0020c5253d8d3sm1429174wrq.31.2022.05.11.04.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:24:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v5 2/7] firmware: sysfb: Add helpers to unregister a pdev and disable registration
Date:   Wed, 11 May 2022 13:24:33 +0200
Message-Id: <20220511112438.1251024-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511112438.1251024-1-javierm@redhat.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

(no changes since v4)

Changes in v4:
- Make sysfb_disable() to also attempt to unregister a device.

Changes in v2:
- Add kernel-doc comments and include in other_interfaces.rst (Daniel Vetter).

 .../driver-api/firmware/other_interfaces.rst  |  6 ++
 drivers/firmware/sysfb.c                      | 87 +++++++++++++++++--
 include/linux/sysfb.h                         | 19 ++++
 3 files changed, 106 insertions(+), 6 deletions(-)

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
index b032f40a92de..6768968949e6 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -34,21 +34,92 @@
 #include <linux/screen_info.h>
 #include <linux/sysfb.h>
 
+static struct platform_device *pd;
+static DEFINE_MUTEX(disable_lock);
+static bool disabled;
+
+static bool sysfb_unregister(void)
+{
+	if (IS_ERR_OR_NULL(pd))
+		return false;
+
+	platform_device_unregister(pd);
+	pd = NULL;
+
+	return true;
+}
+
+/**
+ * sysfb_disable() - disable the Generic System Framebuffers support
+ *
+ * This disables the registration of system framebuffer devices that match the
+ * generic drivers that make use of the system framebuffer set up by firmware.
+ *
+ * It also unregisters a device if this was already registered by sysfb_init().
+ *
+ * Context: The function can sleep. A @disable_lock mutex is acquired to serialize
+ *          against sysfb_init(), that registers a system framebuffer device and
+ *          sysfb_try_unregister(), that tries to unregister a framebuffer device.
+ */
+void sysfb_disable(void)
+{
+	mutex_lock(&disable_lock);
+	sysfb_unregister();
+	disabled = true;
+	mutex_unlock(&disable_lock);
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
+	bool ret = false;
+
+	mutex_lock(&disable_lock);
+	if (IS_ERR_OR_NULL(pd) || pd != to_platform_device(dev))
+		goto unlock_mutex;
+
+	ret = sysfb_unregister();
+
+unlock_mutex:
+	mutex_unlock(&disable_lock);
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
+	mutex_lock(&disable_lock);
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
@@ -60,8 +131,10 @@ static __init int sysfb_init(void)
 		name = "platform-framebuffer";
 
 	pd = platform_device_alloc(name, 0);
-	if (!pd)
-		return -ENOMEM;
+	if (!pd) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
 
 	sysfb_apply_efi_quirks(pd);
 
@@ -73,9 +146,11 @@ static __init int sysfb_init(void)
 	if (ret)
 		goto err;
 
-	return 0;
+	goto unlock_mutex;
 err:
 	platform_device_put(pd);
+unlock_mutex:
+	mutex_unlock(&disable_lock);
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

