Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628A84F9A49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiDHQQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiDHQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16105E09E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649434429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+NpBw4lqbBFDRVqxgjOkgfaUZ1HLPBwF1iC6qPlab68=;
        b=gZC2T1piZGsRDNhvpGq6AFJrepK8Zp7z4dZR5KXE86WNIlmEM+dAThwlflxn0lmdQi39yf
        Raj6/HvdNwyGU1aT2WJHruOOdxjEVyWKPx0m8PcF/YyAtcPGDrShhBCM7UR1yp0R+++FQI
        Z8zWARRwlYvldtOvz6UC34Tyonjwi1A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-KAjxjvcFM8-L0j2wHCJvOw-1; Fri, 08 Apr 2022 12:13:48 -0400
X-MC-Unique: KAjxjvcFM8-L0j2wHCJvOw-1
Received: by mail-wm1-f69.google.com with SMTP id c19-20020a05600c4a1300b0038e6b4a104cso6145546wmp.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 09:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NpBw4lqbBFDRVqxgjOkgfaUZ1HLPBwF1iC6qPlab68=;
        b=EkiNcooOjzWRw/+W3ts4KeBvLmr9pqeXd7neESJeRSP39BgRC6rTr3G/2CDMlAJlEo
         eSufYJr6mq7ZsY77LXcpe9d5Mx6bFriif65U9a6hsSrVFExNf6a73StVwhx4l4pimaVQ
         lYs1RSSlzaWAp56XOHM/LysPliI9TtBGh+8NeMg2VfCWrerbWD+XPIKOo3sOOHRBVUYp
         Y0tjUe2N0yTYk4vov7RzMBPwfM1FrJOEvQFhwcVpqK+Uvgz7pUCRedKaR/NUaPfWdlnQ
         f+CdwBEtIRaQzdpCHGnLatBaJ7lC6Z5QD9F/GpPtbGh9fMGPaw3iitRtwv790w7B1bdJ
         9rGA==
X-Gm-Message-State: AOAM533M5W4l5zFZMU1IU8odZmn8FT53uTlcjJDSKWyqIen8FfSVjs5a
        zLv21En9oG3qnZ5In06HQtweE5BWSdqw0wDN/06HMboyGmj7wUA1bR0cM+kAym0io1M4tkFI9Ot
        c5N48TMEXSg/x1DqyrIf8QIsoh1rW4ns3FlTbcv2W2mq3sKIohnAXuCiN2hZXetOXgnR4eDDEsp
        g=
X-Received: by 2002:a5d:526f:0:b0:206:1c39:810f with SMTP id l15-20020a5d526f000000b002061c39810fmr15159311wrc.139.1649434426865;
        Fri, 08 Apr 2022 09:13:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwORWvYYZa7FXQJJTC1f/+l/2/E9uRlYGrj8t0VKR/7z+nDTMUHBSWhuUjM5hw14PF+grH6Sg==
X-Received: by 2002:a5d:526f:0:b0:206:1c39:810f with SMTP id l15-20020a5d526f000000b002061c39810fmr15159279wrc.139.1649434426543;
        Fri, 08 Apr 2022 09:13:46 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b002060d26c211sm14377455wrn.114.2022.04.08.09.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:13:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Zack Rusin <zackr@vmware.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [PATCH v2 5/5] Revert "fbdev: Prevent probing generic drivers if a FB is already registered"
Date:   Fri,  8 Apr 2022 18:13:22 +0200
Message-Id: <20220408161322.270176-6-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408161322.270176-1-javierm@redhat.com>
References: <20220408161322.270176-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

