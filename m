Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA49554577B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbiFIWez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiFIWeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16B6E232BCF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654814084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4JBJAbQAGlq6duKRB7SY6Yx4CLSxDIaBCygjW0wpUqc=;
        b=Balb/DVY/dRCMH1az3h3eiulazp0Aa474cLLFxabF16mMXymoW/82gKvqY33UKFozFFqsC
        DlxkOv2Ugfbi/6/jgNkZX5u23TZT15revYfkaVdAktrNx0yie9hKRvhG1MerXfsgB3vmCA
        StJ64k2eBEX1UETNggR2+Lyp/Bl7qlA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-QxeUI6giNU2a-LlK1FLXSg-1; Thu, 09 Jun 2022 18:34:43 -0400
X-MC-Unique: QxeUI6giNU2a-LlK1FLXSg-1
Received: by mail-wm1-f69.google.com with SMTP id j31-20020a05600c1c1f00b0039c481c4664so4709334wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 15:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4JBJAbQAGlq6duKRB7SY6Yx4CLSxDIaBCygjW0wpUqc=;
        b=hVIIHNntzCdiX9PovzOg9A85hOSkMAkzY9/SS7X3t4fd4O93QaTcJeGhPeN6ENhf3E
         BUJMPKIG6WB+RE1uh1kDj/pClUGh5xRfB3qOksnkeNGRWTO5RNdmacpPqrSb+yTf6NF/
         8uQHAhpkdHsaoLNbZKcFNHZqZRuI8uw0mkr7GXN3W6FGlIFkSXgcGNmQqbq/OXSNOluB
         22s1DKbrM13CRJwHIzkSY9jfkV2iqf7UVX+S/Yntg2Qoo7doWw2tKTW5ny3X9RMMKy3c
         Pg3kR63UQdorXGrJaiI+69oihDGfVpQAI+akkRmSq01IkonQvcgMdmP8Okm3M7w8/gKE
         OpBg==
X-Gm-Message-State: AOAM531RYlVN2PIpZmf1tketpS4LB+SfUUOKsMo5ltSJm58IGedCDOy/
        ElcP3FZ/ypRJ3vqV7yB2k5W7f9MVTeOSqkEtChkRr40bgUy4V8eyGFLdOPIWcBFLdfZpCq09/gL
        cFnPS1YavcjBsOQ5gMoJCF7oR+zfb9phe4yFjgyL8NfcNCxJPvDGLrDQ79oqNNdIAM5CNmqdVWT
        A=
X-Received: by 2002:adf:d4c7:0:b0:213:ba6b:b017 with SMTP id w7-20020adfd4c7000000b00213ba6bb017mr37035317wrk.652.1654814081473;
        Thu, 09 Jun 2022 15:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBiSUPEKkjirE2HkOG+I6xW8jverC00Ir2fvZGqGugiHwBbX2BUOYVgy8sHotRHakXFdIqqw==
X-Received: by 2002:adf:d4c7:0:b0:213:ba6b:b017 with SMTP id w7-20020adfd4c7000000b00213ba6bb017mr37035279wrk.652.1654814081091;
        Thu, 09 Jun 2022 15:34:41 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b18-20020adfde12000000b0020d0f111241sm25706675wrm.24.2022.06.09.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 15:34:40 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jerry Lin <wahahab11@gmail.com>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: olpc_dcon: mark driver as broken
Date:   Fri, 10 Jun 2022 00:34:24 +0200
Message-Id: <20220609223424.907174-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit eecb3e4e5d9d ("staging: olpc_dcon: add OLPC display controller
(DCON) support") added this driver in 2010, and has been in staging since
then. It was marked as broken at some point because it didn't even build
but that got removed once the build issues were addressed.

But it seems that the work to move this driver out of staging has stalled,
the last non-trivial change to fix one of the items mentioned in its todo
file was commit e40219d5e4b2 ("staging: olpc_dcon: allow simultaneous XO-1
and XO-1.5 support") in 2019.

And even if work to destage the driver is resumed, the fbdev subsystem has
been deprecated for a long time and instead it should be ported to DRM.

Now this driver is preventing to land a kernel wide change, that makes the
num_registered_fb symbol to be private to the fbmem.c file.

So let's just mark the driver as broken. Someone can then work on making
it not depend on the num_registered_fb symbol, allowing to drop the broken
dependency again.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/staging/olpc_dcon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dcon/Kconfig
index d1a0dea09ef0..d0ba34cc32f7 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
-	depends on OLPC && FB
+	depends on OLPC && FB && BROKEN
 	depends on I2C
 	depends on GPIO_CS5535 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
-- 
2.36.1

