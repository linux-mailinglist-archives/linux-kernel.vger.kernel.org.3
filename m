Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2E4F685B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239772AbiDFR5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiDFR5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24E44195335
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649261207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dwo5m09InEiwEv2dnAvGc2fVvZ9j801adW/M2Xiq7pU=;
        b=BKQq5PEP1z1qh8fZH/VUtO4wDm78JUIrVY3Mmipu4YqgpCcLhJnYLLMYaMX2gRniX9Zc6T
        Myq0mKPEu5F/MsojDhLk2Z4wXwIykJXD91h23fBzCdFH2G4JzX6xc37OgD/Y7f0Xe/zhWS
        5vQXpyfcRc4jOqCffqDg47nCPXyQZVY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-XiYxRRgbNoSCkc8RUgxoGQ-1; Wed, 06 Apr 2022 12:06:46 -0400
X-MC-Unique: XiYxRRgbNoSCkc8RUgxoGQ-1
Received: by mail-wm1-f70.google.com with SMTP id f19-20020a7bcd13000000b0038c01defd5aso1508853wmj.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dwo5m09InEiwEv2dnAvGc2fVvZ9j801adW/M2Xiq7pU=;
        b=bJ/rGo+U1jx3GFEdlyNQi6Gb7gN/aealU57vr5rTXFiU7gG7GxEfIc6wQblgPFMQxc
         VnVmRRNMNLgFhQq9eCd6tzmfUSxB/81KWjIY/oYdaIaeGjnxXn6p8PTnsohdz99Pf4+j
         w1fpP8+9bBbK00dX2ez1Z7NXj1LwbSnmDoswvdmm2rLwd9vHbdi+M5C2s2UtWCXdjDPg
         WXQnqKCa90QkbLdvy957Vg/H7TH4zPv+ASQm/tH2LV04sx/ZT5LmaC/fg73o1acmvlfQ
         OJnvA3KQ16DlwzOdeF3K45awa6xF2G1FTb4ox/pksTILIDSlHqx+ohdcLnys/Gl/jUnU
         VWaw==
X-Gm-Message-State: AOAM532g9Jsxdb5Nchg0mQ7BJw9vfpRjbFDO40stOWK2OXLrgWsjyfhS
        plB/RK8hy1p3dg8FRsWzM6K19poeguhpheojoGvNmewTKTHB8/j4exLOpZZCVNzwV5PCKTDWe1r
        ioYhREJZ9Pj5YkElmxymr9P0r//aqt7Ame3zDwht7SS9C3Mm1Rv8Q/oruXe3PQxEQQVkEJqzmia
        8=
X-Received: by 2002:a7b:c24c:0:b0:38e:7a15:e349 with SMTP id b12-20020a7bc24c000000b0038e7a15e349mr8455839wmj.61.1649261204665;
        Wed, 06 Apr 2022 09:06:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKgteymNh0bGfGN9dBE7n8RnKDuoLaQSMbadEdsd2ly2Big0ojbEqQxEsrhTDZom3yXvjizg==
X-Received: by 2002:a7b:c24c:0:b0:38e:7a15:e349 with SMTP id b12-20020a7bc24c000000b0038e7a15e349mr8455808wmj.61.1649261204358;
        Wed, 06 Apr 2022 09:06:44 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm5038899wmc.7.2022.04.06.09.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:06:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miaoqian Lin <linmq006@gmail.com>
Subject: [RFC PATCH 1/5] firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
Date:   Wed,  6 Apr 2022 18:06:28 +0200
Message-Id: <20220406160632.496684-2-javierm@redhat.com>
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

This function just returned 0 on success or an errno code on error, but it
could be useful to sysfb_init() to get a pointer to the device registered.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/firmware/sysfb.c          |  4 ++--
 drivers/firmware/sysfb_simplefb.c | 24 +++++++++++++++---------
 include/linux/sysfb.h             |  8 ++++----
 3 files changed, 21 insertions(+), 15 deletions(-)

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
index b0dcfa26d07b..9857518f4cdd 100644
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
 
@@ -83,8 +83,8 @@ static inline bool sysfb_parse_mode(const struct screen_info *si,
 	return false;
 }
 
-static inline int sysfb_create_simplefb(const struct screen_info *si,
-					 const struct simplefb_platform_data *mode)
+static inline struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
+							    const struct simplefb_platform_data *mode)
 {
 	return -EINVAL;
 }
-- 
2.35.1

