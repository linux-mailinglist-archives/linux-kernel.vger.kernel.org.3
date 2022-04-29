Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFDA5144A1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355959AbiD2Iqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355924AbiD2Iqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 144F4C400A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0jhE2KzgkBGMgjTP5+WkaIB21znzdT6itwPcWaa2Oc=;
        b=cC15IyhnMSRrGXnIQiTb6iTY3dwzngNWQEZ3/g+0wdL1nAZXonQzfC8vE83416cQ+bZ1ld
        DiXTPfsl5huAC1XtK9mPlF3g1JN/iFKbm6337m7ts5Bb3Xz6JPYKSjriNamSWDXYC9CQhp
        /I4/gOwTTZhMPETABUAor04/VdscO8E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-eCdzz4NzO8-70lyr6LIjYg-1; Fri, 29 Apr 2022 04:43:13 -0400
X-MC-Unique: eCdzz4NzO8-70lyr6LIjYg-1
Received: by mail-wr1-f71.google.com with SMTP id e21-20020adfa455000000b0020ae075cf35so2828438wra.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q0jhE2KzgkBGMgjTP5+WkaIB21znzdT6itwPcWaa2Oc=;
        b=UaZPJJo+EG6OMI7Cw6w/8ec6FB0eczXGXgCesRurS2+g/NmyxqOcLWMyZlg9Ns7EGU
         lktotNejOS5QPDdq5JLVBytjIekB+jQKZVxatDymL9YgKNl0zngL8VGcyMT2IY4a6cDp
         gcI8kSP6OvZhSjhZQrOWm/n1uaDR0zD1qPrL8+sLO7oQOJIxYPd0+6+O/QcFTY2x9MO4
         oOJlhva73Bc9XGJZmEYOZ8lugcjnC3bH5ycJsctJl2twZhm/cPbTnwW6x0cc6AxofkFd
         Ajss7fDvAbeNTVdvTYt1stBBNVP5VYrIwzRle5YfTj7xLDn3lODZFGS7lOk2olQvYIOF
         cX7g==
X-Gm-Message-State: AOAM5334QoXPJiV4AU/Q7HW+lM1dYg2tetdvPkZx+AXws8WAf+CzkeAL
        f104O+MNizP1qpeq78TsXHj+RFR2ESFO/+fMVYI523V8chSjzdUjAQFT3giHJJZw3oHDcSoeVvE
        T5RnjjULacGl7p117LqwFtM61V0PvKbUXwE9XQCFKjmWC5gRWGhTpvgJjFzzZKZ0ncWqhb3KLQ4
        s=
X-Received: by 2002:adf:f0c6:0:b0:20a:d31b:6 with SMTP id x6-20020adff0c6000000b0020ad31b0006mr24327956wro.162.1651221792197;
        Fri, 29 Apr 2022 01:43:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiDzTMN+tsLyAkQvCYvCbzjZUOqN+LljnyCVjIFyMHvW0HFddAhKjNR9BnBHuyZkt2O2lUoA==
X-Received: by 2002:adf:f0c6:0:b0:20a:d31b:6 with SMTP id x6-20020adff0c6000000b0020ad31b0006mr24327932wro.162.1651221791918;
        Fri, 29 Apr 2022 01:43:11 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:11 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>, Johan Hovold <johan@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>
Subject: [RFC PATCH v4 04/11] firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
Date:   Fri, 29 Apr 2022 10:42:46 +0200
Message-Id: <20220429084253.1085911-5-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function just returned 0 on success or an errno code on error, but it
could be useful for sysfb_init() callers to have a pointer to the device.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

---

Changes in v4:
- Make sysfb_disable() to also attempt to unregister a device.

Changes in v3:
- Add Thomas Zimmermann's Reviewed-by tag to patch #1.

Changes in v2:
- Rebase on top of latest drm-misc-next and fix conflicts (Daniel Vetter).

 drivers/firmware/sysfb.c          |  4 ++--
 drivers/firmware/sysfb_simplefb.c | 16 ++++++++--------
 include/linux/sysfb.h             | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 2bfbb05f7d89..b032f40a92de 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -46,8 +46,8 @@ static __init int sysfb_init(void)
 	/* try to create a simple-framebuffer device */
 	compatible = sysfb_parse_mode(si, &mode);
 	if (compatible) {
-		ret = sysfb_create_simplefb(si, &mode);
-		if (!ret)
+		pd = sysfb_create_simplefb(si, &mode);
+		if (!IS_ERR(pd))
 			return 0;
 	}
 
diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
index bda8712bfd8c..a353e27f83f5 100644
--- a/drivers/firmware/sysfb_simplefb.c
+++ b/drivers/firmware/sysfb_simplefb.c
@@ -57,8 +57,8 @@ __init bool sysfb_parse_mode(const struct screen_info *si,
 	return false;
 }
 
-__init int sysfb_create_simplefb(const struct screen_info *si,
-				 const struct simplefb_platform_data *mode)
+__init struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
+						     const struct simplefb_platform_data *mode)
 {
 	struct platform_device *pd;
 	struct resource res;
@@ -76,7 +76,7 @@ __init int sysfb_create_simplefb(const struct screen_info *si,
 		base |= (u64)si->ext_lfb_base << 32;
 	if (!base || (u64)(resource_size_t)base != base) {
 		printk(KERN_DEBUG "sysfb: inaccessible VRAM base\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	/*
@@ -93,7 +93,7 @@ __init int sysfb_create_simplefb(const struct screen_info *si,
 	length = mode->height * mode->stride;
 	if (length > size) {
 		printk(KERN_WARNING "sysfb: VRAM smaller than advertised\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 	length = PAGE_ALIGN(length);
 
@@ -104,11 +104,11 @@ __init int sysfb_create_simplefb(const struct screen_info *si,
 	res.start = base;
 	res.end = res.start + length - 1;
 	if (res.end <= res.start)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	pd = platform_device_alloc("simple-framebuffer", 0);
 	if (!pd)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	sysfb_apply_efi_quirks(pd);
 
@@ -124,10 +124,10 @@ __init int sysfb_create_simplefb(const struct screen_info *si,
 	if (ret)
 		goto err_put_device;
 
-	return 0;
+	return pd;
 
 err_put_device:
 	platform_device_put(pd);
 
-	return ret;
+	return ERR_PTR(ret);
 }
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index b0dcfa26d07b..708152e9037b 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -72,8 +72,8 @@ static inline void sysfb_apply_efi_quirks(struct platform_device *pd)
 
 bool sysfb_parse_mode(const struct screen_info *si,
 		      struct simplefb_platform_data *mode);
-int sysfb_create_simplefb(const struct screen_info *si,
-			  const struct simplefb_platform_data *mode);
+struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
+					      const struct simplefb_platform_data *mode);
 
 #else /* CONFIG_SYSFB_SIMPLE */
 
@@ -83,10 +83,10 @@ static inline bool sysfb_parse_mode(const struct screen_info *si,
 	return false;
 }
 
-static inline int sysfb_create_simplefb(const struct screen_info *si,
-					 const struct simplefb_platform_data *mode)
+static inline struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
+							    const struct simplefb_platform_data *mode)
 {
-	return -EINVAL;
+	return ERR_PTR(-EINVAL);
 }
 
 #endif /* CONFIG_SYSFB_SIMPLE */
-- 
2.35.1

