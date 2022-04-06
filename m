Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119EB4F686C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbiDFR5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbiDFR5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FEF7196083
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649261208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gnVQUL3ppm1TNC7utGALyGd2EAWXx63qYM1Qkn/cJqo=;
        b=MuV7334vlIWYXSmVtBfmVi34AVFIlpXf5F0IrFc8AaL2cXjpEV1So9h4Mws4xTNNOHwy2t
        jC+PZZ4vDahvkx4MAZX7jZiYSqeXMRVk1zTL259QEzxOcdxgyDha+GO9TSNBFti4WZivgp
        j28R+xpf0sjdPWb/iTqkHgcTPNvfb5Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-_o-iFnlpMo2SdvaJ8OKCUw-1; Wed, 06 Apr 2022 12:06:47 -0400
X-MC-Unique: _o-iFnlpMo2SdvaJ8OKCUw-1
Received: by mail-wm1-f71.google.com with SMTP id z16-20020a05600c0a1000b0038bebbd8548so3160450wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gnVQUL3ppm1TNC7utGALyGd2EAWXx63qYM1Qkn/cJqo=;
        b=CSFm+uVx2yTrQFKqaaNcqReVLFt+1n96DFuNm01EhSjlpgomzC9HLkrsCeHuNckVRU
         ivsbkDBOTL9/jbQOIzIzUJF4beFjyeR9ZNMEx3MHbWnhIzS8+uJFGvzLGskVySZNjnhL
         5opXeKRrabaBG3xcYPBjg+OHMvmnDKpBQCvd3zAt3UEpSW1S421xqQ/b9sSjXH77E931
         jGj6i5ArJv2GxMdihxk7CvhdiAWDOjgrIiRp4yR2xgTRv5HTVWD5Avuz11Nq0k66GcCV
         42f9QlMAv5ZkUbbv8nIgL+BCXMgdCFlXr9QuWbuzoX+LNlzTYAI49vzPe98Ou1sy98Tv
         2KWw==
X-Gm-Message-State: AOAM531eIS+6QzzcVogWT1jP04T1Myfj+moYCPj0M6uD46JgO1kW7GSe
        qzxbBJofIxGmELtpuLaT++tU2s6PYZ+8COC2wwo5IQ4eXXbAiVy1eltigmOjNxUYB5TgDC5ckHM
        sKbWcN7YnLPHUyvqa/gEjRlJ+AMiTGl4cNibtws1YmmLd3gx6w3TutJHOu6wbQSDh4nEnJsJCf9
        0=
X-Received: by 2002:a5d:6152:0:b0:205:bcf3:2cc with SMTP id y18-20020a5d6152000000b00205bcf302ccmr7424210wrt.158.1649261205826;
        Wed, 06 Apr 2022 09:06:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP58khqgo3xreoQlsQ9J6H4ICR/oggJkDwVoOSBbhaMF0ILCTdOLy/FcqT9y3kQS3YNkwSwQ==
X-Received: by 2002:a5d:6152:0:b0:205:bcf3:2cc with SMTP id y18-20020a5d6152000000b00205bcf302ccmr7424188wrt.158.1649261205542;
        Wed, 06 Apr 2022 09:06:45 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm5038899wmc.7.2022.04.06.09.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:06:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 2/5] firmware: sysfb: Add helpers to unregister a pdev and disable registration
Date:   Wed,  6 Apr 2022 18:06:29 +0200
Message-Id: <20220406160632.496684-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406160632.496684-1-javierm@redhat.com>
References: <20220406160632.496684-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
index 9857518f4cdd..2bbc0ed9b0dd 100644
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
+void sysfb_disable(void)
+{
+
+}
+
+bool sysfb_try_unregister(struct device *dev)
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

