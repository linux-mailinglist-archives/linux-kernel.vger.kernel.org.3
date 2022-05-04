Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22404519EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 13:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349194AbiEDMDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiEDMDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F35AE18B0E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651665577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hdaz9MpZoIlHo5W6Yr3E01ttRcC4gjvc5tNziIXBlcs=;
        b=E6Q6UW0fnBFWwyBX+4YjzfAHsOPnK72iQ709cHYdMVVK8ucpfUGkQyJE8AgrVCDb0y6/qU
        Dsakzw/4nLfAX1gCrN5VW2bFRpGyjEKEYsRwJKGfU1hzeZYdmYClbbQejlZW7n3S0L+boC
        xJ12P7ZnifrETV2Z75Qp1KtQ6IDB85s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-ztTNp3W4NkGra9RmB5uXSQ-1; Wed, 04 May 2022 07:59:33 -0400
X-MC-Unique: ztTNp3W4NkGra9RmB5uXSQ-1
Received: by mail-wm1-f69.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso2920666wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 04:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hdaz9MpZoIlHo5W6Yr3E01ttRcC4gjvc5tNziIXBlcs=;
        b=eeSufTsUH/iQTtVaL4PHHvEAxvNZOKQrAOtl5q9korYnPUdBocuIMHo3zCheBwyEZg
         O572Uv8fdOVb8OeNcRsUFz3xDQBFATj58FwERFEchSYiZlzwlP/COCpX+S5PJI43mlMZ
         45N91RNQETFjFTJOU3GZgeMIUPrF9QlezvX7z7NYRmNwzjQ1d3wlLfIkwFYONA1VneNT
         wB5wPvHl94wz3QcYOIdQ4YEwebzqNeVghadako9XqjJ3YBsmk57ZXwpkA9zOo6TvUW+o
         jirDhjByPov+zC7ZQ63qooqbAVgQMUq4FsWdMgVMJXtmNQbmDuxcsOez/PdL6kTzg9Do
         54kg==
X-Gm-Message-State: AOAM531g4EmwaI0Vk72HTySyHjFhJ4+cANViD7M3OYTEeTJmzQstmBpT
        Q/303ldJkTkii9T9/xAUTqu+YnccYKgjD9CrloeiEJna/ZXuTRXozBfSj4JNTS9GR/6TreQFXA1
        Dgfm5J/xq/dU0DjGGDY2KsqD8OmiwO80oMuEYMV8Vxs45FlY7V1sZrZKYQjBCq7KNl1npuxuFOa
        s=
X-Received: by 2002:a05:6000:1844:b0:20c:5672:9573 with SMTP id c4-20020a056000184400b0020c56729573mr15065540wri.538.1651665572032;
        Wed, 04 May 2022 04:59:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgDtpAe/DLUybOoXaFzCCcl0wELARIERg8DV6OtPnYk2dBjPP7wFdtw5kHDTnYHSwd136yIw==
X-Received: by 2002:a05:6000:1844:b0:20c:5672:9573 with SMTP id c4-20020a056000184400b0020c56729573mr15065508wri.538.1651665571647;
        Wed, 04 May 2022 04:59:31 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c3ba000b003943a559b3fsm3765344wms.8.2022.05.04.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 04:59:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2] Revert "fbdev: Make fb_release() return -ENODEV if fbdev was unregistered"
Date:   Wed,  4 May 2022 13:59:17 +0200
Message-Id: <20220504115917.758787-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
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

This reverts commit aafa025c76dcc7d1a8c8f0bdefcbe4eb480b2f6a. That commit
attempted to fix a NULL pointer dereference, caused by the struct fb_info
associated with a framebuffer device to not longer be valid when the file
descriptor was closed.

The issue was exposed by commit 27599aacbaef ("fbdev: Hot-unplug firmware
fb devices on forced removal"), which added a new path that goes through
the struct device removal instead of directly unregistering the fb.

Most fbdev drivers have issues with the fb_info lifetime, because call to
framebuffer_release() from their driver's .remove callback, rather than
doing from fbops.fb_destroy callback. This meant that due to this switch,
the fb_info was now destroyed too early, while references still existed,
while before it was simply leaked.

The patch we're reverting here reinstated that leak, hence "fixed" the
regression. But the proper solution is to fix the drivers to not release
the fb_info too soon.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

Changes in v2:
- Add more info in the commit message about why it's crashing and how
  the reverted commit was papering over the issue (Daniel Vetter).
- Add Daniel Vetter's Reviewed-by tag.

 drivers/video/fbdev/core/fbmem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 97eb0dee411c..a6bb0e438216 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1434,10 +1434,7 @@ fb_release(struct inode *inode, struct file *file)
 __acquires(&info->lock)
 __releases(&info->lock)
 {
-	struct fb_info * const info = file_fb_info(file);
-
-	if (!info)
-		return -ENODEV;
+	struct fb_info * const info = file->private_data;
 
 	lock_fb_info(info);
 	if (info->fbops->fb_release)
-- 
2.35.1

