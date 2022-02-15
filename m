Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0D4B79EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243262AbiBOVL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:11:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiBOVL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:11:57 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785FA69CD2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:11:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l9so223117plg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uunY1rBWY15kDOqQsxS3uiH3g9pNZwIjD1Nw4ZhoAQ0=;
        b=RTsXULwHo0sXfAk6wsLSpVzF+noTxFnRrQwTKt6qzGm7chrP232C4pYbrk9mE6/D8t
         rVtWhyRxER+JQfGyLO0+g0Y4YYMERibgDA4WUqhdo6qjNwDdgAB0nbyl6dGysmwVb6w4
         QXBYRagKF6ajiK6mjmtTZO7lIqlLdQdke8BJkukY5EQNpxWkbv38kZFwzPgu2jb9mpPy
         Ya1uAr+pUSSCPnmnBcIxuOdFPMVJFr+Ixh0FBINaWEqkgnL9x41WWxdDcfKnA8b+gKsD
         emaTP+ejMo/IqBi5SiGVehq8gTS2INp8x2bJ0gFC2WVPny8poWssk7zLCy0SNmHKB7ah
         edvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uunY1rBWY15kDOqQsxS3uiH3g9pNZwIjD1Nw4ZhoAQ0=;
        b=fAQ16lUqc1pEgaAXxP+oTLpJY1H6MZBixPZgdcOlCc6g2Oxf0dr8whKMqJlPIeHmYL
         gL3UWTWgaiDXDxvuDd8Teg0U8A4sjKrVDGfWWVTSDCWkZH0VVpz8fmlmGtqSOiT7qSXa
         3j4SICaLYWsU2QfrbrfyYo3APPLEWVLlwbcMFWJLQWtV5ByBW392dOKOvahvOjJB3umR
         e2jZnKe4dEnqNwTJ3uIrJTlL6DUgjE68M+DQT8dLQpc1scvc8GWEUy8JGm84Gw1cArQa
         Ogzfvn+4VTVf3VAAEkvSurpoIG0VL4wc24Y6zdQ9MgZBEgLbn6eriKXFDdCAQNsU7C8b
         5AVg==
X-Gm-Message-State: AOAM531WQH40JeRGThHfc8XyLiWxxIbAIpdJUmXfyax9SFXzp+haiiqo
        5wNOi9FNYUCKNgIsrXc8nY4=
X-Google-Smtp-Source: ABdhPJwgatXaiDjHtRe00LxYeCHzSC9/PhQF1h0CnkwICNIRPjkqnhGNGJPTQWYKd1Pwibs+f/1ZsA==
X-Received: by 2002:a17:90a:e7c3:b0:1b9:c189:bc3 with SMTP id kb3-20020a17090ae7c300b001b9c1890bc3mr6443555pjb.202.1644959505569;
        Tue, 15 Feb 2022 13:11:45 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4e4a:b0ff:e926:40e2])
        by smtp.gmail.com with ESMTPSA id b15sm16784779pfm.154.2022.02.15.13.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:11:44 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:11:42 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] module: fix building with sysfs disabled
Message-ID: <YgwXDqfL5ecTF9JH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs support might be disabled so we need to guard the code that
instantiates "compression" attribute with an #ifdef.

Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 kernel/module_decompress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/module_decompress.c b/kernel/module_decompress.c
index b01c69c2ff99..ffef98a20320 100644
--- a/kernel/module_decompress.c
+++ b/kernel/module_decompress.c
@@ -250,6 +250,7 @@ void module_decompress_cleanup(struct load_info *info)
 	info->max_pages = info->used_pages = 0;
 }
 
+#ifdef CONFIG_SYSFS
 static ssize_t compression_show(struct kobject *kobj,
 				struct kobj_attribute *attr, char *buf)
 {
@@ -269,3 +270,4 @@ static int __init module_decompress_sysfs_init(void)
 	return 0;
 }
 late_initcall(module_decompress_sysfs_init);
+#endif
-- 
2.35.1.265.g69c8d7142f-goog


-- 
Dmitry
