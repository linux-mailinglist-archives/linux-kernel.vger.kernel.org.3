Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7E952856A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242630AbiEPNbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbiEPNbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04CA52CCA4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652707870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w+eIR1jdJFJp4FEreIhpWwIkPEB98By7uRBAllkcS2c=;
        b=HzLj3X9EByW6Z2m5IAE3OA30sToaJNBXKg8NdIcZdqIS2gfy7EZlRH0xQF27gMB+I/uonz
        bJ41M6ScDltTV1WMhCvfDlYO1qFO0jWgRwANUnVAgJDKIPwBpbdn/L+WYVu+Z+wpJUFKc0
        chsadU0TYCuUcFA1TYuoRZsKb88zKb0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-130-Z1oiGpVEP8Gn5Jf8j33r8A-1; Mon, 16 May 2022 09:31:09 -0400
X-MC-Unique: Z1oiGpVEP8Gn5Jf8j33r8A-1
Received: by mail-ed1-f71.google.com with SMTP id f20-20020a50d554000000b0042abba35e60so679618edj.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w+eIR1jdJFJp4FEreIhpWwIkPEB98By7uRBAllkcS2c=;
        b=kTsqrb5VKYn4bHDX0zvTmT8kaqgVXIUlNodOv/9LVqdn03qRqXuxFIXZl5fKkh+C2A
         D5b4OxACKKe1Y3neSVMNZkL5e20/QivYBoBCcvNLA/VbPmyClWZQzVGpooP737oU/CZg
         jaQQFekHoBgIv3SKKa7kr7LCOtRXdvyDAN/bXAkI7ydfOniapHYswkJbsh94OTBCxUkY
         ynTVRBUNCcu0F6YotfOKFlbHW2BD/HdatR46aWePNF2vtaAhU8hIJInP5nuu/gN1hXdD
         OOg1Iqe3s4Z2bwpa+0ccnRvzollFBsJ1BZowEA2eoHMMSGhea8qHfMvLfhtRamMUnB+9
         EoMg==
X-Gm-Message-State: AOAM531BqOR9gwcETIe49JtYxNoLrYrlbPTKRccOcyiRmmIPmf9g/EHJ
        9FrfLKBWPf6ZzyUaVWIIceQDQznC42iwYzQrfUxGfzleCiBgilJ8YHjOSM44K8TYjyPuM4x3SBh
        SopwV4SiazksVcJBMvU6w/8CjscmrMG1XKFCjItEvsGK4afNS4qr1KsXoG6tsZ5jYpRoFs3KDmM
        iy
X-Received: by 2002:a17:907:1687:b0:6f4:ebc2:da77 with SMTP id hc7-20020a170907168700b006f4ebc2da77mr14924505ejc.508.1652707867511;
        Mon, 16 May 2022 06:31:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0fOyJSx7iSNVdMn7CYLSlWrFP1mGJaYESmuOYZfdVRlB9QZmxDbNE8F2fpbTaT5BDFciIPw==
X-Received: by 2002:a17:907:1687:b0:6f4:ebc2:da77 with SMTP id hc7-20020a170907168700b006f4ebc2da77mr14924475ejc.508.1652707867235;
        Mon, 16 May 2022 06:31:07 -0700 (PDT)
Received: from fedora.. (78-80-114-84.customers.tmcz.cz. [78.80.114.84])
        by smtp.gmail.com with ESMTPSA id w3-20020a50fa83000000b0042ab8c5e99fsm868438edr.14.2022.05.16.06.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 06:31:06 -0700 (PDT)
From:   Mark Menzynski <mmenzyns@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Menzynski <mmenzyns@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v2] drm/nouveau: reorder nouveau_drm_device_fini
Date:   Mon, 16 May 2022 15:31:03 +0200
Message-Id: <20220516133103.324365-1-mmenzyns@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resources needed for output poll workers are destroyed in
nouveau_fbcon_fini() before output poll workers are cleared in
nouveau_display_fini(). This means there is a time between fbcon_fini()
and display_fini(), where if output poll happens, it crashes.

This makes output poll workers cleared right before fbcon resources are
destroyed.

BUG: KASAN: use-after-free in
__drm_fb_helper_initial_config_and_unlock.cold+0x1f3/0x291
[drm_kms_helper]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Menzynski <mmenzyns@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 4f9b3aa5deda..5226323e55d3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -39,6 +39,7 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_atomic.h>
@@ -605,6 +606,7 @@ nouveau_fbcon_fini(struct drm_device *dev)
 	if (!drm->fbcon)
 		return;
 
+	drm_kms_helper_poll_fini(dev);
 	nouveau_fbcon_accel_fini(dev);
 	nouveau_fbcon_destroy(dev, drm->fbcon);
 	kfree(drm->fbcon);
-- 
2.32.0

