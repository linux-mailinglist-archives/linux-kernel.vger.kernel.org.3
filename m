Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2454F6D61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbiDFVvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiDFVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A07938BE35
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649281253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOqy/c/KjwvNtJK/R+j/LJQnwi5pZIwF5UUMed5h1E8=;
        b=Fvt2Dtx58ayDJSx2vV4rBrnRyyAwmIUxr318YXkNTd0dlNb7eETl23HA38FlcYD51/UdzP
        /WdOaJCE5JHvredWD6s5uCb3jeuzFbhVW+nDbpB7laqfw6MK651UlKBe4NhGFIlXoFFR8K
        QaeAWcZl1wItEf5ea0AzjHjuF/UYDlk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-pNH_cdbRNmKFKWZQbS6gYw-1; Wed, 06 Apr 2022 17:40:52 -0400
X-MC-Unique: pNH_cdbRNmKFKWZQbS6gYw-1
Received: by mail-wr1-f69.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so814147wri.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOqy/c/KjwvNtJK/R+j/LJQnwi5pZIwF5UUMed5h1E8=;
        b=wwLk/xswFqssW0L5ws8xz3QgvMEW5qIkBFh+GFRu1icEHDF3ydrePBkCkqTcv8d01K
         E4qyXLGAV0eBKQpkhUEPPWTaZ3bWS0OiZDrs6TQhLbdSTZT5Dv7mS7dpFzqVIeuz9pzS
         8LgP8LooGOZe8OgPgnOPT4W9XYTjGifvj07/L22SRxNUcs29U2Dl9aI/0AirQP0FWTHR
         19FMk3EFHjPmxtlEZhYRHHx7FKxj9PetAa4PGjZKf6XmF6PiOJoCjdTCOhV0KxI/ORl8
         TJlRikPbrqjQvWZCsy4u9SSUs2gzavQN6ADKbdJo2BjY5RRy6XpwLIFZoSF/F36SWpy7
         pVlQ==
X-Gm-Message-State: AOAM532A28QOXJNS83pQDCCRIJvlHrDMeJrEHFZE1ncTM046R6Q/k292
        HCf62BfT0JVTcGf0B83ToNRjhCWFweOIUQYT8obihdM8xJ3foqAvay1WB7aklHDE/LyFE6yLZw6
        /nuhzmPcpu9bEBRwvfvYt5OTw9QeeI/SolfK3nD3p2lzL3neO6LKDD2kkkZgTJMYsN8G9FQTDun
        M=
X-Received: by 2002:a7b:c0c9:0:b0:38e:7d65:6e7f with SMTP id s9-20020a7bc0c9000000b0038e7d656e7fmr9054406wmh.168.1649281251353;
        Wed, 06 Apr 2022 14:40:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEvASRFqmeBI/gkKWoj3wck9xOJpn6025gTkIMDUq07B7B+SD3YIdjghFypSAm6QQAtr+Rbw==
X-Received: by 2002:a7b:c0c9:0:b0:38e:7d65:6e7f with SMTP id s9-20020a7bc0c9000000b0038e7d656e7fmr9054390wmh.168.1649281251134;
        Wed, 06 Apr 2022 14:40:51 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm5876020wms.15.2022.04.06.14.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:40:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaoqian Lin <linmq006@gmail.com>
Subject: [RESEND RFC PATCH 1/5] firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
Date:   Wed,  6 Apr 2022 23:39:15 +0200
Message-Id: <20220406213919.600294-2-javierm@redhat.com>
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

This function just returned 0 on success or an errno code on error, but it
could be useful to sysfb_init() to get a pointer to the device registered.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/firmware/sysfb.c          |  4 ++--
 drivers/firmware/sysfb_simplefb.c | 24 +++++++++++++++---------
 include/linux/sysfb.h             | 10 +++++-----
 3 files changed, 22 insertions(+), 16 deletions(-)

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
index 76c4abc42a30..c42648ed3aad 100644
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
 
@@ -104,25 +104,31 @@ __init int sysfb_create_simplefb(const struct screen_info *si,
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
 
 	ret = platform_device_add_resources(pd, &res, 1);
 	if (ret) {
 		platform_device_put(pd);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
 	ret = platform_device_add_data(pd, mode, sizeof(*mode));
 	if (ret) {
 		platform_device_put(pd);
-		return ret;
+		return ERR_PTR(ret);
 	}
 
-	return platform_device_add(pd);
+	ret = platform_device_add(pd);
+	if (ret) {
+		platform_device_put(pd);
+		return ERR_PTR(ret);
+	}
+
+	return pd;
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

