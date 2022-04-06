Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060264F6D65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbiDFVwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiDFVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6663A8BF4D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649281254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gm2w5zhEo/y/hC/MnEig9xvUokSksiUvuJdIdj5pPYA=;
        b=LwmjzkGAb3hn8EWjCXdQoT53iTL11uJG0pQ2b9Cf63l043UqUlHiQawkmK6BYqheedLBHD
        xZT3QFF+6pV6thIvc2Km5xg89zNqcEZPwv775jSqZXK5Sbkker31d84nEhoRH8gw66vraE
        BcQEsQQyhfQy+jbeZm5RtaZD8yZwnVs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-qXseYYpDPz6zpsCNZdcYHQ-1; Wed, 06 Apr 2022 17:40:53 -0400
X-MC-Unique: qXseYYpDPz6zpsCNZdcYHQ-1
Received: by mail-wm1-f70.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so3547778wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gm2w5zhEo/y/hC/MnEig9xvUokSksiUvuJdIdj5pPYA=;
        b=I6JJ49iATjqoE6xq8w8lqxAnlrr0XhFErtu7p4tmkgidcrmyXCvuBbwgdx2oISTd4r
         3i2UYXaESePVe5/Xsii1PEUR/1+3KMw7h3fuh+dJPRnkHCqyO/qF9Qu6Eyf4ZmOZMd2H
         g2CRuoBHHjvXXOwGUtbC+AD5y+qx8uoq3JNYCENv9N7fv6Lbl3byCXDpD8MVyeS+U/sb
         b7q3jU9mUkfSCJh4LnTHDDodqOcJvlBaaf3P7vb0isUgGREs2aNm3hyX64AxoKZHhxsP
         UlXiI/YiPWSY2b/P7z6Sr0r/WSHIWKpFKDhJB2qI11oPvG0wTwRL/CIx2V172Qr0kX/C
         UHdQ==
X-Gm-Message-State: AOAM531MaAoa+3gaw2sq8JVC49Dkg1QGw6yqko81n4+GY7FGXY4jfFei
        Pj6WJg+STBtHwqRkeeNWKpaEUpFEbCHLoElwrXs+3NwpdBsAV1ru34/HyH+LIjpC9ic9ZivbtgO
        5acycAQ8GLCke7Ku3mQ7JjzJSv2+P2M83kbS/AtnKkoDRn5MOJkuX2yrrpnM9WQviqSQN/pwzxw
        Q=
X-Received: by 2002:a05:600c:510e:b0:38e:346f:8a46 with SMTP id o14-20020a05600c510e00b0038e346f8a46mr9048514wms.153.1649281252495;
        Wed, 06 Apr 2022 14:40:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMTekWlIniEn/wRy/hq26mmEdsyLZioccx8O1RToh7NRrIiCsilpEYTP7Kfu1VPjt/UNTH2A==
X-Received: by 2002:a05:600c:510e:b0:38e:346f:8a46 with SMTP id o14-20020a05600c510e00b0038e346f8a46mr9048490wms.153.1649281252164;
        Wed, 06 Apr 2022 14:40:52 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm5876020wms.15.2022.04.06.14.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:40:51 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND RFC PATCH 2/5] firmware: sysfb: Add helpers to unregister a pdev and disable registration
Date:   Wed,  6 Apr 2022 23:39:16 +0200
Message-Id: <20220406213919.600294-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406213919.600294-1-javierm@redhat.com>
References: <20220406213919.600294-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These can be used by subsystems to unregister a platform device registered
by sysfb and also to disable future platform device registration in sysfb.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/firmware/sysfb.c | 47 +++++++++++++++++++++++++++++++++++-----
 include/linux/sysfb.h    | 19 ++++++++++++++++
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index b032f40a92de..08ae78c083f1 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -34,21 +34,52 @@
 #include <linux/screen_info.h>
 #include <linux/sysfb.h>
 
+static struct platform_device *pd;
+static DEFINE_MUTEX(load_lock);
+static bool disabled;
+
+void sysfb_disable(void)
+{
+	mutex_lock(&load_lock);
+	disabled = true;
+	mutex_unlock(&load_lock);
+}
+EXPORT_SYMBOL_GPL(sysfb_disable);
+
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
@@ -60,8 +91,10 @@ static __init int sysfb_init(void)
 		name = "platform-framebuffer";
 
 	pd = platform_device_alloc(name, 0);
-	if (!pd)
-		return -ENOMEM;
+	if (!pd) {
+		ret = -ENOMEM;
+		goto unlock_mutex;
+	}
 
 	sysfb_apply_efi_quirks(pd);
 
@@ -73,9 +106,11 @@ static __init int sysfb_init(void)
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

