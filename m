Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3845451449D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356023AbiD2IrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355982AbiD2Iqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57BBFC42C1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDplaZMb5YseJ+Hq/qs3ip7VsbbgryHldJFcbzukwP8=;
        b=U7i50dcwnuVcFg7vzfU0Odeyc2piyfq7FGbYmQLgAeMThQ5bcHxHu1/eKjl3TfVdokUn94
        6Yib/O6obMEgArnquFQDmF3Vu/p/VAjt3VUh+PJpPcYmuJDa2iRvE5Ref8odRTBdOgDfi3
        xPprOQZKM9C0AV8crvVI03LwKEVdJvU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-un3qccxAMRG9j7y3rllZOg-1; Fri, 29 Apr 2022 04:43:22 -0400
X-MC-Unique: un3qccxAMRG9j7y3rllZOg-1
Received: by mail-wr1-f72.google.com with SMTP id u26-20020adfb21a000000b0020ac48a9aa4so2814706wra.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDplaZMb5YseJ+Hq/qs3ip7VsbbgryHldJFcbzukwP8=;
        b=IroHDyKrNjqY5CvXvHFU6W+EA6TntU5EKqv6zRZXwy5Tl3FzA5k9m4F36LT3VASp0W
         t26KWiAAO1aEer+2Qujr9V31hfo02i8fGFTMAWFE95dT3xhvhz9wllyxWoERhiNEULq+
         yT3LBWUmTtXtRH7xtErINOHhBD4H9/zLqqCSrUwqs3izmYS0CseF8cun5TJK+qheyha8
         2ICP4/yjB/sPTr6t8MfebDUixK1v7toqOHvYG+0lZDEUEJzVWfKigSK5/UaH5XMouWFw
         3DODFvBGP4/al7uCrdFQgZks5ugCTmnimQlfb2+xjoBYaLyidb0Wb5exjd9yRBtFG1j4
         cJWA==
X-Gm-Message-State: AOAM533tsV/yTPRXnPCDnyPaUyVC2Om7Ny5WL4Vtk1DYiMVjd/OTuuio
        IYsV5Vqray34tciLWkhqahmB23S40Z1JcN4UqaaeivHsTOyYcBgjL2R0ju5d7O5XHBlahLKPRw/
        7VPJMr/i7Xat00D3WqWdHWD5SRky3LwChCtt5kwLxcg8EhNw/6KApIOCaAopbgHpzmmpEE7DKvL
        Y=
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id n43-20020a05600c502b00b0038ff7c63609mr2151336wmr.15.1651221800765;
        Fri, 29 Apr 2022 01:43:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUhJr7adxWPTzLPcLhzy6SAp4kBXCJcXEMXapEUCxJwsbfEcTFBfqvmjks4+3ERNh1qQu2xw==
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id n43-20020a05600c502b00b0038ff7c63609mr2151311wmr.15.1651221800430;
        Fri, 29 Apr 2022 01:43:20 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [RFC PATCH v4 10/11] Revert "fbdev: Prevent probing generic drivers if a FB is already registered"
Date:   Fri, 29 Apr 2022 10:42:52 +0200
Message-Id: <20220429084253.1085911-11-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429084253.1085911-1-javierm@redhat.com>
References: <20220429084253.1085911-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

