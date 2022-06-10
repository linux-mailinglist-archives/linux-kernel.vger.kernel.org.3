Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81AA5460B2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346425AbiFJJAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346595AbiFJJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68F7946141
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654851634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ukK3D5FOT/lVXAY3CQ/ZTU+kRLHSqaAf/1KzQyUA/fo=;
        b=GOu1LxGTV2aJdv0dirBVgxTQooieaSq14reWZVLt/1+FcdqQeyPueyvP5gggpP9KBIqVtS
        /MX67uRYwk/YA10SZw3J0STSJHzQCTx1Vfb4MLERlf31WNN8+BFlkE1piJORrH6OkF5eCn
        VU3OE5OXYl/4eVhZhZoSjy+GtGOTG/0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-LspeyokUPoWhtNYU2bK9xw-1; Fri, 10 Jun 2022 05:00:33 -0400
X-MC-Unique: LspeyokUPoWhtNYU2bK9xw-1
Received: by mail-wm1-f72.google.com with SMTP id v8-20020a7bcb48000000b0039c62488f77so3230093wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:00:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ukK3D5FOT/lVXAY3CQ/ZTU+kRLHSqaAf/1KzQyUA/fo=;
        b=iKua0DzC7t9RsusUCXMV366CDCEO4+XILSLdbGREy9H2RxCSCk6sRyBq68KEEFaBNk
         fRnLZvfsGcuTFEZd9m/YSQ6waHbYHl9Br7aMm3oUIvBsI7xJXLMMzFQ/BWbKtQPHL3UI
         TfenSq34yzhE8on605SY1bmc+lT6Y+hifufQhHtlhTzwPaN+rBiL4BBRrNqo/5ibYje2
         alsHnf8V6fF87hg+M33pRArDzCtV6OvY2yRyk0F426lCdziwB7DFKKLplho+KrSYWqHj
         Egpown01U2IXL2WDSPDO3oQ12w8n0Zb/DrCp/O80ZFhx2YAA32PhsnQywJmbcHIbyW9R
         2Ksw==
X-Gm-Message-State: AOAM531hJNx5jC6/VX3OO7GMjAo4sFMFmMchaEY64xuohHvPmZrpHTTV
        o4y5SZDeIdz/KG8Xi7L7fERkM23+62WpZ9vOagldcwIdaaDr7ucRwWhu59r2OB+rOwit1xf8/9X
        zsF+w5Xe1nBgK+e+a4zAVl3VnTWC9tsVrwQRlzFJdKDFcKLH3zGqw03hCvnUszVpBSjuVTR2MxQ
        A=
X-Received: by 2002:a05:600c:4e54:b0:39c:6e5e:c667 with SMTP id e20-20020a05600c4e5400b0039c6e5ec667mr6753181wmq.151.1654851631611;
        Fri, 10 Jun 2022 02:00:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMkBzMN6zqmh3ItL1DEVgtjb5YNjsnmi9WVMAPERuUJTVsqu+6f1r+Qr2+wxO0IT9zUq3CNg==
X-Received: by 2002:a05:600c:4e54:b0:39c:6e5e:c667 with SMTP id e20-20020a05600c4e5400b0039c6e5ec667mr6753151wmq.151.1654851631352;
        Fri, 10 Jun 2022 02:00:31 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d5588000000b00219e4ebf549sm1711792wrv.56.2022.06.10.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 02:00:30 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: [PATCH] efi: sysfb_efi: remove unnecessary <asm/efi.h> include
Date:   Fri, 10 Jun 2022 11:00:05 +0200
Message-Id: <20220610090005.1358402-1-javierm@redhat.com>
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

Nothing defined in the header is used by drivers/firmware/efi/sysfb_efi.c
but also, including it can lead to build errors when built on arches that
don't have an asm/efi.h header file.

This can happen for example if a driver that is built when COMPILE_TEST is
enabled selects the SYSFB symbol, e.g. on powerpc with allyesconfig:

drivers/firmware/efi/sysfb_efi.c:29:10: fatal error: asm/efi.h: No such file or directory
   29 | #include <asm/efi.h>
      |          ^~~~~~~~~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/firmware/efi/sysfb_efi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
index 4c7c9dd7733f..7882d4b3f2be 100644
--- a/drivers/firmware/efi/sysfb_efi.c
+++ b/drivers/firmware/efi/sysfb_efi.c
@@ -26,8 +26,6 @@
 #include <linux/sysfb.h>
 #include <video/vga.h>
 
-#include <asm/efi.h>
-
 enum {
 	OVERRIDE_NONE = 0x0,
 	OVERRIDE_BASE = 0x1,
-- 
2.36.1

