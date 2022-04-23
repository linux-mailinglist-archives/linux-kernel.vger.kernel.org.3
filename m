Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1562850CA44
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiDWM73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiDWM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D00891139
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650718588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fXS1wYFISLzf4YrpSc6l5RCrDLoiak/N6nEId/I9Cks=;
        b=SSaKlAEfnq3EqEd581Ktn/Kiac9PjV3iXRgIEtfh73uhT2YJg5I4WNgSlGI7FVfmVZELAs
        CE3TKsa2hefIM7s1JZNAiUKKiRybMFYRiOh61xC7PdIyBfOIP0d7HElsz6XdQNeYOBZ1NC
        wXfFzsKdmfxqboM8deW2lWhVELwUGFY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-zevMUinqMbO2mlp2DZ42xw-1; Sat, 23 Apr 2022 08:56:26 -0400
X-MC-Unique: zevMUinqMbO2mlp2DZ42xw-1
Received: by mail-qv1-f70.google.com with SMTP id k10-20020ad45bea000000b0044c3ec9f75cso6567493qvc.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fXS1wYFISLzf4YrpSc6l5RCrDLoiak/N6nEId/I9Cks=;
        b=1fZzxemhdjjhzEiOm1gEEO1iPajBt2sAo8v0fYJ+Bd8rrIFozVTqWHDvvdqSM1ejLU
         5+TO95Kx7DbDSZsZiQjZgl5MWZRA3iaG+3g5YksZpKxfp7XBp/qIiExFSoX3y+TJY66/
         dGPA1dh2YKK25sEz/pw+ZTtV9h+cTQkAj1bfhBEp70iAXerHllqsaVU1e7NasBbEk8I1
         FaKfRulL3TK/21KLZycxVyzqEQMmOMO017Ff8BeBP0ljH9wwMxdoGzZtjckrCFC4Q9Js
         M6d6N0cTwM3gbS9c2BQy/FgVaAdYXe/u7swhw79IHjHczSQH88gtFdLaK7L1vk1yXe5I
         uRYw==
X-Gm-Message-State: AOAM532yveZtCOo15+IUxQgyIoDlKeEdn+PO3PM41P5GqLtQ5VwQZvB0
        SU7RP0aksEqrMZWZWMIpKwpTDFYIvtDwwZ/GDJ8EvFjv8gaJS7mK61NTN5yhlIYMPKDUbd0fC2Y
        87QAz8DvO1GvlT4MGCk6So5N6
X-Received: by 2002:a05:620a:44c6:b0:69e:9bef:53e3 with SMTP id y6-20020a05620a44c600b0069e9bef53e3mr5447562qkp.481.1650718586186;
        Sat, 23 Apr 2022 05:56:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhlweP7vkujEfw3nfYFCm7iGeT3wgX5eOb2GZoLM/GocC/XMB64gi5W1GtgsEOcxr1gb7hWw==
X-Received: by 2002:a05:620a:44c6:b0:69e:9bef:53e3 with SMTP id y6-20020a05620a44c600b0069e9bef53e3mr5447553qkp.481.1650718585973;
        Sat, 23 Apr 2022 05:56:25 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a12eb00b0069c88d15b6asm2240097qkl.68.2022.04.23.05.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:56:25 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     daniel@ffwll.ch, deller@gmx.de, sam@ravnborg.org,
        tzimmermann@suse.de, javierm@redhat.com, cssk@net-c.es
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] fbcon: change fbcon_*registered_fb variables to static
Date:   Sat, 23 Apr 2022 08:56:18 -0400
Message-Id: <20220423125618.1916005-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports these issues
fbcon.c:106:16: warning: symbol 'fbcon_registered_fb' was not declared. Should it be static?
fbcon.c:107:5: warning: symbol 'fbcon_num_registered_fb' was not declared. Should it be static?

These variables are only used in fbcon.c. Single file use variables should
be static, so change their storage-class specifiers to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/video/fbdev/core/fbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c4e91715ef00..225ac0fe0143 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -103,8 +103,8 @@ enum {
 
 static struct fbcon_display fb_display[MAX_NR_CONSOLES];
 
-struct fb_info *fbcon_registered_fb[FB_MAX];
-int fbcon_num_registered_fb;
+static struct fb_info *fbcon_registered_fb[FB_MAX];
+static int fbcon_num_registered_fb;
 
 #define fbcon_for_each_registered_fb(i)		\
 	for (i = 0; WARN_CONSOLE_UNLOCKED(), i < FB_MAX; i++)		\
-- 
2.27.0

