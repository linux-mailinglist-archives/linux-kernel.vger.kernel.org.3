Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC15231C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiEKLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbiEKLc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923F323E295
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDplaZMb5YseJ+Hq/qs3ip7VsbbgryHldJFcbzukwP8=;
        b=hoDQq/OPlPA1jIbWxLpQn1eaMCxeQk0RSlIkcJZiZ0i1/bLzwG8WTGnBA/CABRbdFhK/gN
        I60tCXvY26uk2UjfG/gnDuGI27/SRafC2SVLITBo7+M2GVBt3xZcqB/aRY9wuflFTBOk7r
        8T3xUgLXEozVJLsbmvoQHQNjjSTgdCU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-4TGt3YBBPj2bBo33graGqg-1; Wed, 11 May 2022 07:32:22 -0400
X-MC-Unique: 4TGt3YBBPj2bBo33graGqg-1
Received: by mail-wr1-f72.google.com with SMTP id u17-20020a056000161100b0020cda98f292so718247wrb.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDplaZMb5YseJ+Hq/qs3ip7VsbbgryHldJFcbzukwP8=;
        b=CizHwYKrVS2P32kImrfk/P3/mJ1/otfEOu4wr8ljMeM2QxXahqBDlgB5u4AU65SlZ6
         1+YhEclIBpxAfUcXBWxHee7jrUNggLW5FANGDzqBr/KCMDDh4d+ek6+RURtgDsHl13mC
         LLSevL84apK65sid6i4MV3TFCIzJGyZU8+0CkGfE7WdsSj2ZNwL0cY8dvAdp9wqchSal
         u7k8YCOrKWxL4eG2VU6Nk3Wei1P5rincSQjW9GmvlJEe8B8FtV49GqPtnE7/qLtcv0z/
         mKCa9glPQ3XWVqEuqz1darQHXVQZP1fyR5+jAjtDHqWsqKZkE2VEigEdUvZ/NVPkIDH7
         YF1Q==
X-Gm-Message-State: AOAM531AxWD7g6jmLcaozrKwmQsFhUi7ZyrUP5rIRaw/ldkvcBfZmdrh
        YFz6Sw6A8ILoZmLI8m6W/fIGV0/dvvaA14s7pWvXoBY6D3PAPTKWTmwLuc/B9/uf4crgjjbJJGL
        UFW40tfLDwhDkose6J8wRuBfqJKwa+mv8EXyN7yTTUPfw54r51ONneWhUDZTY1eqF2wX8b5WYdk
        0=
X-Received: by 2002:a05:6000:1d8b:b0:20c:54e6:1659 with SMTP id bk11-20020a0560001d8b00b0020c54e61659mr22002291wrb.169.1652268741265;
        Wed, 11 May 2022 04:32:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8DOa4eVy/j4OxWjmKfDXFScY2hy71AEkR7bJehfJjo+JROKXYZWV1lJqXARoz2/Z0HXw3aQ==
X-Received: by 2002:a05:6000:1d8b:b0:20c:54e6:1659 with SMTP id bk11-20020a0560001d8b00b0020c54e61659mr22002251wrb.169.1652268740906;
        Wed, 11 May 2022 04:32:20 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w12-20020adfde8c000000b0020c5253d8dfsm1476857wrl.43.2022.05.11.04.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:32:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zack Rusin <zackr@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH v5 6/7] Revert "fbdev: Prevent probing generic drivers if a FB is already registered"
Date:   Wed, 11 May 2022 13:32:04 +0200
Message-Id: <20220511113204.1252828-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511112438.1251024-1-javierm@redhat.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
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

From: Daniel Vetter <daniel.vetter@ffwll.ch>

This reverts commit fb561bf9abde49f7e00fdbf9ed2ccf2d86cac8ee.

With

commit 27599aacbaefcbf2af7b06b0029459bbf682000d
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Tue Jan 25 10:12:18 2022 +0100

    fbdev: Hot-unplug firmware fb devices on forced removal

this should be fixed properly and we can remove this somewhat hackish
check here (e.g. this won't catch drm drivers if fbdev emulation isn't
enabled).

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ilya Trukhanov <lahvuun@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/video/fbdev/efifb.c    | 11 -----------
 drivers/video/fbdev/simplefb.c | 11 -----------
 2 files changed, 22 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ea42ba6445b2..edca3703b964 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -351,17 +351,6 @@ static int efifb_probe(struct platform_device *dev)
 	char *option = NULL;
 	efi_memory_desc_t md;
 
-	/*
-	 * Generic drivers must not be registered if a framebuffer exists.
-	 * If a native driver was probed, the display hardware was already
-	 * taken and attempting to use the system framebuffer is dangerous.
-	 */
-	if (num_registered_fb > 0) {
-		dev_err(&dev->dev,
-			"efifb: a framebuffer is already registered\n");
-		return -EINVAL;
-	}
-
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
 		return -ENODEV;
 
diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 94fc9c6d0411..0ef41173325a 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -413,17 +413,6 @@ static int simplefb_probe(struct platform_device *pdev)
 	struct simplefb_par *par;
 	struct resource *res, *mem;
 
-	/*
-	 * Generic drivers must not be registered if a framebuffer exists.
-	 * If a native driver was probed, the display hardware was already
-	 * taken and attempting to use the system framebuffer is dangerous.
-	 */
-	if (num_registered_fb > 0) {
-		dev_err(&pdev->dev,
-			"simplefb: a framebuffer is already registered\n");
-		return -EINVAL;
-	}
-
 	if (fb_get_options("simplefb", NULL))
 		return -ENODEV;
 
-- 
2.35.1

