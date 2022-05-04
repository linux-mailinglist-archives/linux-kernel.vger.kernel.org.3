Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB48B51B176
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378922AbiEDWBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352006AbiEDWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E54F4C7B5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651701452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5E68EYuJS0cLv3NadyCR6Subawx0t/0D3XRnBIF5EA=;
        b=B1jkjqHLDlL5FaW6/IJrxYQ63GM9qf0gCZ8pb/QKj+XOhRdUtJhLtZCF5n25AUrBfcB1v1
        OoxlI6yp/6lXVc0OfwFdJ4m+6LaRh+d3pOYmgKEyv42F5F3ScOvsCOW3TnhnNehz2lvoZm
        H+JoVUJIrIMBQRT4J+UZ9XGzCYBoWnI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-_hPZMhfzNM-lIc9casZmeA-1; Wed, 04 May 2022 17:57:31 -0400
X-MC-Unique: _hPZMhfzNM-lIc9casZmeA-1
Received: by mail-wr1-f69.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so816145wrg.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d5E68EYuJS0cLv3NadyCR6Subawx0t/0D3XRnBIF5EA=;
        b=7pSeqw66I+DbIJdRbIzF636xUA2pzIx21vS6VWpWnKKZNeyzY3+yW4kWEl2XP3IytF
         jtabfON53256/vvNnpeyx630CZ6hVQDcerMdZyhKVq1Kj0Ud1n5QRuQyoDXQtf3CoQLP
         F1lRI9teJeimrHisL/wVKpHn7fwY90QdrVJkG4mS+mpHCgkSQZ8sFKd93LV1+hmcW3jl
         wpHVDRKdy/QTuFAO07IoT+VW1qH+ScKnug5tFyeqIluu5jZ62TSQs5j63LFIOpncXjN7
         fR0g7RsauxolNAtdGLmKZy+ASu68V0gySfOpyo29zmsjXhqe713zpHXSuwBK2W8MFGwy
         JndA==
X-Gm-Message-State: AOAM531reVLDu9CKpRC+dOhoSJE9MbtwhzTdyChZEKe4LleV7KkQT1Gv
        FKAVNSS9sN0uWwjAN/RKoOj9gN4kU1oIfc3HKsgk/Pi+E63ihibMXsPuT0x81PvkHOWkMqs2Ene
        GMwjaJGxP7o2fC5K1GoZwzVNLp4+K494Rr5aGbt2fZ1zU4MRlwVxHfmIy+m/pPdtTg6HmRTQ/6A
        w=
X-Received: by 2002:a7b:c199:0:b0:394:26d0:a6a9 with SMTP id y25-20020a7bc199000000b0039426d0a6a9mr1363682wmi.116.1651701450128;
        Wed, 04 May 2022 14:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1qMT5MICoWPkF4Ji0uGyxOCxsrRQ04CuhwRhiVVfyNZ8vIEl2jgygGi1ttKO9pWOlUIHlhA==
X-Received: by 2002:a7b:c199:0:b0:394:26d0:a6a9 with SMTP id y25-20020a7bc199000000b0039426d0a6a9mr1363665wmi.116.1651701449798;
        Wed, 04 May 2022 14:57:29 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c264b00b0039444973258sm5213068wmy.0.2022.05.04.14.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 14:57:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 2/3] fbdev/simplefb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Wed,  4 May 2022 23:57:22 +0200
Message-Id: <20220504215722.56970-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504215151.55082-1-javierm@redhat.com>
References: <20220504215151.55082-1-javierm@redhat.com>
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

The driver is calling framebuffer_release() in its .remove callback, but
this will cause the struct fb_info to be freed too early. Since it could
be that a reference is still hold to it if user-space opened the fbdev.

This would lead to a use-after-free error if the framebuffer device was
unregistered but later a user-space process tries to close the fbdev fd.

The correct thing to do is to only unregister the framebuffer in the
driver's .remove callback, but do any cleanup in the fb_ops.fb_destroy.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

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

