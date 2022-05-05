Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E897351CBDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386156AbiEEWJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiEEWJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:09:39 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 638FD5DD38
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651788357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOMIAnnTamSRotiOWkLRdWbDfwtm7Vtf7J5gIUBLvsY=;
        b=Ba1xRvzB9SAXzBEcc7v3Ut+zYDe2RBV33jCalF3XsLrAW3XtcdZVtzzLVzO7fa7eCxeiPu
        GI2paM6ysQt+cMJODb8LtFpA7WFU5P8Vt+6q1Cri7LPfax4uoXseBdTO2eo6EUnhd27qxl
        od8dfrpQ2gvCHswWY5g2/W6t/ZaPtoU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-naRzLUubPlSJKy_MnNkwOg-1; Thu, 05 May 2022 18:05:56 -0400
X-MC-Unique: naRzLUubPlSJKy_MnNkwOg-1
Received: by mail-wr1-f71.google.com with SMTP id k29-20020adfb35d000000b0020adc94662dso1867431wrd.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 15:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOMIAnnTamSRotiOWkLRdWbDfwtm7Vtf7J5gIUBLvsY=;
        b=x+fs1NMwaAV2QMHOYf8HbG7ltf2EWaLWA78nag66doHOl5aKrtX2YVxIoXxfzgSnez
         V9EZqabN0qXeU1eHQ/W/m8hSEh+WBu5r6997S3iUu5hxmcBKZiwnh+jaASpNg2sf5Uhd
         HzECxF/n2xo66UBX2jKsTdSjzPshux+mFQgIRKX9E3LGM8PMdkSDR9foOEniXWzLDPaT
         RZANL26j50AxI/Zh+lKxA2U+FOteAtw5j/QJRgRhgkvq4DCQDs9jojGArV1OuPLC64BF
         mn/XtyY8izrfy1/NNRbhfyZK4hl52du1FeAnyHVZNmbrPZ7C1w1voIy0MFuV09wPzXmc
         PgEQ==
X-Gm-Message-State: AOAM533p1zIqCSrRHAL3oJMRU2HzgCFeiapWOT4EMVA35N0uJ1wuqtiU
        tcM3YoS06jbcckItM+cT6QHb7Qi448jLH+9uMrD+RC5/MaIPznt6VVJ2sDUZGvnI8iLmHZUaUex
        OiVQzgSyQiPP2EOgLeIAW3rjzrpf30VDGRFEfHGaWxjKSpbfx+FFlq50Qktxbipf1P6yNJH+hG1
        s=
X-Received: by 2002:a05:600c:214c:b0:394:2dfe:2754 with SMTP id v12-20020a05600c214c00b003942dfe2754mr287451wml.135.1651788355019;
        Thu, 05 May 2022 15:05:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeda1HHZwr4FX+lwN/TaIHgdOKHms0BlDVvSG/oTgRzg2lXGiKrE9u+GvlU9S+3hDsIgrQvw==
X-Received: by 2002:a05:600c:214c:b0:394:2dfe:2754 with SMTP id v12-20020a05600c214c00b003942dfe2754mr287430wml.135.1651788354747;
        Thu, 05 May 2022 15:05:54 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b003942a244f39sm7291679wms.18.2022.05.05.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:05:54 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 3/4] fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Fri,  6 May 2022 00:05:40 +0200
Message-Id: <20220505220540.366218-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505215947.364694-1-javierm@redhat.com>
References: <20220505215947.364694-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

 drivers/video/fbdev/efifb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ea42ba6445b2..cfa3dc0b4eee 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -243,6 +243,10 @@ static void efifb_show_boot_graphics(struct fb_info *info)
 static inline void efifb_show_boot_graphics(struct fb_info *info) {}
 #endif
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup here.
+ */
 static void efifb_destroy(struct fb_info *info)
 {
 	if (efifb_pci_dev)
@@ -254,6 +258,9 @@ static void efifb_destroy(struct fb_info *info)
 		else
 			memunmap(info->screen_base);
 	}
+
+	framebuffer_release(info);
+
 	if (request_mem_succeeded)
 		release_mem_region(info->apertures->ranges[0].base,
 				   info->apertures->ranges[0].size);
@@ -620,9 +627,9 @@ static int efifb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
+	/* efifb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
 	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
-	framebuffer_release(info);
 
 	return 0;
 }
-- 
2.35.1

