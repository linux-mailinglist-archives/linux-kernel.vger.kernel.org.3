Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC77B51BE11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357478AbiEELfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357319AbiEELfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:35:22 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97C5A25C4F
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651750302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlMJQ+wz02RD+81KzAT+P3KjFBfmXeVQ3/vybVcCubw=;
        b=CmYnZ6oHd/UsdftedsHxmRwQpI+jDsBQZclCm/7AnPgj17Bjax/cNnbTZzqM7Iel+EYI7e
        ZDsKuhgC4IE1yRHh5QUtMHoX3qJYCXcTr+65vHcnKlK4zCLMUa9LdcYkJqmRb4AEEkVd+4
        4kWoJ9R3qq9cTLUngXHPlIzqNm4V3sQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-6U9hyrAbPaCIOa0MRZbRCg-1; Thu, 05 May 2022 07:31:41 -0400
X-MC-Unique: 6U9hyrAbPaCIOa0MRZbRCg-1
Received: by mail-wr1-f71.google.com with SMTP id m8-20020adfc588000000b0020c4edd8a57so1354023wrg.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UlMJQ+wz02RD+81KzAT+P3KjFBfmXeVQ3/vybVcCubw=;
        b=ynnUc3JzOAjtFHUsQsUATlDEGHAqaC7Bq2TiG0NXCr5jy+mRhyaHwKgDm2hv3KOiJc
         ntKg5Ggeh3BbBAniimAO0As01MmrNAW6CdnigYrtrkbq/CIzPd7ttsBSspf1P/OfMmnv
         e4Oq8atWz6zcicCp8RQ2Nte62m1gSmPKkXfSQ0jdAdEM4yqrHj1LabWzBgz8uzIglN8Y
         Is9qHWx9RdmiuldrsS+r+aHiyJMwLTnYI+Ty3O5nfKgbKFlTyaT0ItziHMtlL+mu3BGE
         Cprs1EzkoZb8VmCuqj1CisnlRUPO6zCo1gc3PRdp1Md+ddyUh5/1VrPgPzcZldmSWBNY
         86rA==
X-Gm-Message-State: AOAM531ER5Jed/Vcxk317vcV6SmOUpg6YGDyRZptPOpixyowImoE4jUs
        nR5tEcxEIFvyxnZxGolcR39Z2UAIZ02c4cO88h5B0ktJevKxKjpT84xpo+pfqoIwh0mSAGglPlU
        nBGMkyRjIdXn1m6KVLcB8Eqp72sDRrU3gIUIbJoLvhhT1cOyDKlZpyIX5dndHWr3pLmW0tPW9Go
        g=
X-Received: by 2002:a05:6000:1548:b0:20c:5ca8:7722 with SMTP id 8-20020a056000154800b0020c5ca87722mr16350998wry.712.1651750300470;
        Thu, 05 May 2022 04:31:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxug4drE+2lM0Y2bQGAKqHc9/jzcqI1egXtMk1eOS4NmBEoxmupUXagiI2LBGTtqENwnb2VKg==
X-Received: by 2002:a05:6000:1548:b0:20c:5ca8:7722 with SMTP id 8-20020a056000154800b0020c5ca87722mr16350970wry.712.1651750300187;
        Thu, 05 May 2022 04:31:40 -0700 (PDT)
Received: from minerva.. ([90.167.94.135])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d5181000000b0020c5253d8f5sm995809wrv.65.2022.05.05.04.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:31:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v2 2/4] fbdev: simplefb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Thu,  5 May 2022 13:31:25 +0200
Message-Id: <20220505113128.264963-3-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505113128.264963-1-javierm@redhat.com>
References: <20220505113128.264963-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

