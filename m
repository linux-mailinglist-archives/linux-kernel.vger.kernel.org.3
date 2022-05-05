Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A0851CBDA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386154AbiEEWJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355319AbiEEWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:08:49 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25E445DD38
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651788308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpySyazXcP9jeQEo03DKJEoNJ7MOw25wdUGi6hnO0cY=;
        b=Tv5Cn2NQWTmW/dIbpECPwyLPLHqHjROL43HRs6dwHygl2YsVs4kCbOo3jrzFrr4C/v7LWn
        VYi6wxz4ZGygO0FQIiv+pqH6G5rZuEso829J7Pp8CSFCXO81eMEVPPa8mSUz9Zf8WfoOX1
        1TvURTOn1MvV+U+PuF6i/AIGoW8QDYU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-Usafqd9PMU6cvV_cGXZ7Ww-1; Thu, 05 May 2022 18:05:07 -0400
X-MC-Unique: Usafqd9PMU6cvV_cGXZ7Ww-1
Received: by mail-wm1-f70.google.com with SMTP id p24-20020a1c5458000000b003945d2ffc6eso2211789wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 15:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpySyazXcP9jeQEo03DKJEoNJ7MOw25wdUGi6hnO0cY=;
        b=f7+nEtbMYOrYS/fSujUYZfHfyfrScqIBff/agLAPBfXVLFb6I+rRie8s2LtNOiwgH3
         nntFdCXNRLmLf6XenA/0usLZpdePWqogLbxgav7scYrxDXXgaIo9A22YZC3Gaavb1hNW
         vc625BQhcaWAHSxBsINvtvwO06KsNtROVLFm1Ynu4b5EzP4dSoicBTBYcC1oxj6WZKUL
         hFkMmekHiN6Mr0Chlndt2DlXUCk3xRuW31A2VWlk90bCkqWOEed77cktS0rdRxXJa4HN
         1Z0menSN+IiFOY8NW3Nsm3ZF5tcZMi9aoO6ZQ1rWPY8Uyf16d0CXjfPA8EVlnxBaAIlK
         SM2A==
X-Gm-Message-State: AOAM533POi3Mim/rsp7sRqNVyeKrpIOqadD4bEz9iyS6Td09/1tMN00/
        FZ8ALc5VkWVi2F4WnKTz7bBl5eCwHzmQE6RPKZCZNaq3/lsf5Czcfut7iKTKcfkuWahSYm7gsZ/
        moRpI/XBMJYOZLRMmxN+jd0ptwfwjhP67CFaEb8DOYAXXWgX6pId2Z+I6tUT/4iNk96gyDrdkuh
        s=
X-Received: by 2002:a5d:6c65:0:b0:20c:5230:f145 with SMTP id r5-20020a5d6c65000000b0020c5230f145mr142615wrz.337.1651788305826;
        Thu, 05 May 2022 15:05:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzx4hSKJf5+8gqVXy4SQIIH/+d18yIIzPchwfl0/SeHroDdEocZasvgfA/q6M9W6ITqVZA+Yg==
X-Received: by 2002:a5d:6c65:0:b0:20c:5230:f145 with SMTP id r5-20020a5d6c65000000b0020c5230f145mr142590wrz.337.1651788305549;
        Thu, 05 May 2022 15:05:05 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003942a244f47sm7942360wmk.32.2022.05.05.15.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:05:05 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 2/4] fbdev: simplefb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Fri,  6 May 2022 00:04:56 +0200
Message-Id: <20220505220456.366090-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505215947.364694-1-javierm@redhat.com>
References: <20220505215947.364694-1-javierm@redhat.com>
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

The driver is calling framebuffer_release() in its .remove callback, but
this will cause the struct fb_info to be freed too early. Since it could
be that a reference is still hold to it if user-space opened the fbdev.

This would lead to a use-after-free error if the framebuffer device was
unregistered but later a user-space process tries to close the fbdev fd.

To prevent this, move the framebuffer_release() call to fb_ops.fb_destroy
instead of doing it in the driver's .remove callback.

Strictly speaking, the code flow in the driver is still wrong because all
the hardware cleanupd (i.e: iounmap) should be done in .remove while the
software cleanup (i.e: releasing the framebuffer) should be done in the
.fb_destroy handler. But this at least makes to match the behavior before
commit 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal").

Fixes: 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal")
Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

(no changes since v1)

 drivers/video/fbdev/simplefb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 94fc9c6d0411..2c198561c338 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -84,6 +84,10 @@ struct simplefb_par {
 static void simplefb_clocks_destroy(struct simplefb_par *par);
 static void simplefb_regulators_destroy(struct simplefb_par *par);
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup here.
+ */
 static void simplefb_destroy(struct fb_info *info)
 {
 	struct simplefb_par *par = info->par;
@@ -94,6 +98,8 @@ static void simplefb_destroy(struct fb_info *info)
 	if (info->screen_base)
 		iounmap(info->screen_base);
 
+	framebuffer_release(info);
+
 	if (mem)
 		release_mem_region(mem->start, resource_size(mem));
 }
@@ -545,8 +551,8 @@ static int simplefb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
+	/* simplefb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
-	framebuffer_release(info);
 
 	return 0;
 }
-- 
2.35.1

