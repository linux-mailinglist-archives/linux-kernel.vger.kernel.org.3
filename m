Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3051BE17
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357398AbiEELfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357352AbiEELfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:35:25 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 000C54F9D8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651750304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kHj6RqHilBMUbncDK/2tHoS4NrC5xcTylW4aCqmdFU0=;
        b=O5y10VDzLzn0Oe0P184620ZmJDJOGTZyhhsDv75G9AyM8HLvsasZBlyGkpe1DWhlItzm7e
        rUMiDG7lkWqot/6M/196Mite4ePobO/JYiLZ5x7dyRtxwzkIa0yIgeMeVRKR1YGPLsK9cg
        xylSDUAJJA69dTsPQcadUwDQ2U2bVCs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-C-ntXjm4MTmlovju03Y5Wg-1; Thu, 05 May 2022 07:31:43 -0400
X-MC-Unique: C-ntXjm4MTmlovju03Y5Wg-1
Received: by mail-wr1-f72.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so1354416wra.15
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kHj6RqHilBMUbncDK/2tHoS4NrC5xcTylW4aCqmdFU0=;
        b=z8k3nccoBL8+eS+44XHpbjlTwBR6kUbipSRwIUQ5MZwOdATx9G4uIX9LeifZ+Jir/I
         n3GYMzIRNj2/OLdx+2RxAO1OBfJ8L6MBloBdrPH6WByoAmoNRSm6u+hrBL4j6ZXULhAE
         Qh+CKQqDSBWWYo9bLHsJyCofy/scKbBf/a2/fTncQ6XPyjzqQczs3txqOo/WfVyxUqrc
         O7aUYYawQCfKE0cHiLSO2XnsH1XE8SNb8aWLV3RohRG/afFpIQ+7P7idwB8wJ6LRd1ZR
         kMUjqhcKYAypgopRl/3BvmyWbB+14mYin+BHxmieiFsfzw7knltCd/4JchqFhHCOtdzt
         uANA==
X-Gm-Message-State: AOAM5313xjMRqfxP7wBslhD69Ztt1vcHDW7WgF1RyEPmAF6CYYiQBSSu
        FnXOAxzy/OCOS0Gd4Fkcd4z52yHOzkswzq53+oGXQ7FNIBSzwF1arWSH36ogrwg8YEFQNPqnCty
        YiMa2TSBBCc4059LFInV9Aa+OQS4dBcnLTBaR7iTw0sUGWzj01gY+QqjH7Z3xyKapskLN9symeY
        E=
X-Received: by 2002:a05:600c:48a6:b0:394:39c3:52 with SMTP id j38-20020a05600c48a600b0039439c30052mr4238798wmp.66.1651750302612;
        Thu, 05 May 2022 04:31:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0kdiNiZLFcv712Ydt7i9wnRcz/9iaODWbWGG3Ol0GG6/v5Xr4uslaghhGTnrCqtdWkt6x7A==
X-Received: by 2002:a05:600c:48a6:b0:394:39c3:52 with SMTP id j38-20020a05600c48a600b0039439c30052mr4238760wmp.66.1651750302269;
        Thu, 05 May 2022 04:31:42 -0700 (PDT)
Received: from minerva.. ([90.167.94.135])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d5181000000b0020c5253d8f5sm995809wrv.65.2022.05.05.04.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:31:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 3/4] fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Thu,  5 May 2022 13:31:26 +0200
Message-Id: <20220505113128.264963-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505113128.264963-1-javierm@redhat.com>
References: <20220505113128.264963-1-javierm@redhat.com>
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

The correct thing to do is to only unregister the framebuffer in the
driver's .remove callback, but do any cleanup in the fb_ops.fb_destroy.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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

