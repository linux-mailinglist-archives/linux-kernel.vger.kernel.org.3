Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DC351CBE2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386183AbiEEWKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386177AbiEEWKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:10:18 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25E855EDDA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651788396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2QUs/dFpZjXD63m2oUdzjI7+Wpnx04uqjBRSmxR+fJo=;
        b=NoeVH+LQnxYMLYYVXHGRCy7OFetIWVi5u+7Pk5FBOHyKKEMSgREgymlEgh3EV5WBMV/IZK
        14DKGnoqDCy80qvLrNJyR6w6p05KtLDMZMfmi8Kp7WCNuTRyjXogw+BhgFQKGeqYGr9/FG
        XegBqSEp0bm6RVZ4+Vinv6Aoi4AgJrc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-IOYryVw9Nh6yPaHpBI4weg-1; Thu, 05 May 2022 18:06:35 -0400
X-MC-Unique: IOYryVw9Nh6yPaHpBI4weg-1
Received: by mail-wr1-f72.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so1874160wra.15
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 15:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QUs/dFpZjXD63m2oUdzjI7+Wpnx04uqjBRSmxR+fJo=;
        b=29P5oF84PWp0Z/EOyqbffA7rHLgnPZzNqyas9FjoSyi57U478h/BFTrwuAqGAh3eq/
         T/futsReB6d6EBYrnD4CiH9dYc2hO6qBtq5EsqxDWXBmz2Ox9JZjm7Btb31DbvY3IcBI
         PFG8K3PmglOiWd/IHY6OKQU2eppea0SWar1F9TV4HjwYzcdohO1+59Xix5VK/VJ5buX/
         L5y9Y1hOawZ3edDIy20ylnDDvvjMnFanHvqeuLlPsQ+ac3TPCAehJ3pf0eG0/uuFmmBV
         PttT9MrX9aEpe0PEl6aKCawY0GCgrJjWBYYALiTUHmWowDicPFYweejbNLaOjU2UGddl
         wv0w==
X-Gm-Message-State: AOAM531kM0GFGkZFrlPkkAGPRMxrNoCjHSj15mrsPZSoeeFbQ7gYS7Cd
        MgoN22IasmrHaO4eiQursNYRi6p9cBwxO+11odaTQpZsQtGWcKPzPMy795ZAVz/Fw8RZm4aK0h8
        CX14GgpMOjkhnCXaj1/BpiydWwf80647HU66YQsQvYAOTBgZSqd4g7w0ppSIJrFcSI2h2VnU9Mc
        4=
X-Received: by 2002:a5d:6dd1:0:b0:207:92c4:eaef with SMTP id d17-20020a5d6dd1000000b0020792c4eaefmr165085wrz.498.1651788393706;
        Thu, 05 May 2022 15:06:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJuZtwlqObinYznGZMuIaaeVki7i2UMoMVMO9mJCvQ2FsqRQYwPdVCdFx20Il32JBmnuIcGA==
X-Received: by 2002:a5d:6dd1:0:b0:207:92c4:eaef with SMTP id d17-20020a5d6dd1000000b0020792c4eaefmr165062wrz.498.1651788393466;
        Thu, 05 May 2022 15:06:33 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n11-20020a056000170b00b0020c5253d8c7sm2040236wrc.19.2022.05.05.15.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:06:33 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 4/4] fbdev: vesafb: Cleanup fb_info in .fb_destroy rather than .remove
Date:   Fri,  6 May 2022 00:06:31 +0200
Message-Id: <20220505220631.366371-1-javierm@redhat.com>
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

Changes in v3:
- Only move framebuffer_release() and don't do any other change
  (Daniel Vetter).

Changes in v2:
- Also do the change for vesafb (Thomas Zimmermann).

 drivers/video/fbdev/vesafb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index df6de5a9dd4c..e25e8de5ff67 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -179,6 +179,10 @@ static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 	return err;
 }
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup here.
+ */
 static void vesafb_destroy(struct fb_info *info)
 {
 	struct vesafb_par *par = info->par;
@@ -188,6 +192,8 @@ static void vesafb_destroy(struct fb_info *info)
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
+
+	framebuffer_release(info);
 }
 
 static struct fb_ops vesafb_ops = {
@@ -484,10 +490,10 @@ static int vesafb_remove(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 
+	/* vesafb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
 	if (((struct vesafb_par *)(info->par))->region)
 		release_region(0x3c0, 32);
-	framebuffer_release(info);
 
 	return 0;
 }
-- 
2.35.1

