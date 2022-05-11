Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCC523182
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242023AbiEKL0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241383AbiEKLZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02C8E237242
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9SntuE95Z9lS2Zx81mCZFUkNBpVjW+b+N3eCCbF1gA=;
        b=Zp+p5FcGfO+WgwRQPJPqawGMxeIPMJL1BIVHXxkW+2hqpBy6BiTgjXcwrgpmAjKW7Icpr3
        kq+M71qu1KvTBWIkjjvjgolIBYNXiGBRP+7iU6jy7m6q5z4P2AJ4CBDuUO+djgRgo5Kr6V
        9pz5PdZcGPkoQ7Om57A4bqq6V9CgOFY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-RwZaKct1MlSPxE3amZWXQA-1; Wed, 11 May 2022 07:24:56 -0400
X-MC-Unique: RwZaKct1MlSPxE3amZWXQA-1
Received: by mail-wr1-f69.google.com with SMTP id t17-20020adfa2d1000000b0020ac519c222so729050wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9SntuE95Z9lS2Zx81mCZFUkNBpVjW+b+N3eCCbF1gA=;
        b=wX07pUKc43uCcr/FCW8HlHLCWxwaB37KPDdSCUWiAA+f0iIlAiQRrCsj52LvKSLDL0
         WvJBa/13/mJakHjfmrK0uJ41vpBLERHz5qogs9vt4ZHQw1yNymlhKwp3/Fdt/5of0QHT
         NkifzLg8ZlbOMxBFgYa4SwQNhUFd9mysgWR6WbNSAJ+5ChuosjXLKg5qYy7L/eHKxUbi
         hRO/oeOYKQYy1kwiLMDGgQLI3FfMPKEVCWQBNLIT2wguAAhqX5SEVkuHc9QMA5X1R6P5
         +JzY+bbuY4P/kuRFtIUtxtfHFVtU6eOrAE2nLBs4tpJdjWy5/txy31uO80OtUH/KACQf
         IXHg==
X-Gm-Message-State: AOAM530TWV1ZlWbRs874RaObQwDXbslDDYlW2oQzZK7vzJaukeKeqy9A
        NjrwjbJLjfr3p2wABYO8qJrAurHmB2/zMkysEMBW7a1PwHLpuAgsD7fv8XVhLEpKQ5Bob+Ws9h+
        lIesYpm0M0C1xh4dt2KcYjY08/5N36jnTqNGjni48YWwrj+K2fXb4TGR5AjjCV6/1xXhgsxIggv
        o=
X-Received: by 2002:a7b:c310:0:b0:38c:f07a:e10d with SMTP id k16-20020a7bc310000000b0038cf07ae10dmr4381308wmj.110.1652268295562;
        Wed, 11 May 2022 04:24:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLj2CSI9aVxKNa4g6AjcxfP1g4hpdYDGGtiwl+UPUrJBEfHDnhXd+VQuLlXkDmk+7WrCcTxA==
X-Received: by 2002:a7b:c310:0:b0:38c:f07a:e10d with SMTP id k16-20020a7bc310000000b0038cf07ae10dmr4381276wmj.110.1652268295247;
        Wed, 11 May 2022 04:24:55 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4481000000b0020c5253d8d3sm1429174wrq.31.2022.05.11.04.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:24:54 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v5 1/7] firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
Date:   Wed, 11 May 2022 13:24:32 +0200
Message-Id: <20220511112438.1251024-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511112438.1251024-1-javierm@redhat.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

(no changes since v3)

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

