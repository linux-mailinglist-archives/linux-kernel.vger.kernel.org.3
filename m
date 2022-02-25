Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A267E4C3CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237313AbiBYESO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiBYESN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:18:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2073A17FD0E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:17:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m10-20020a25800a000000b0061daa5b7151so2080315ybk.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ca9YfplyXj+SM4509LbCMm80icGRFj6bn1039+jlxOU=;
        b=Z84SsvrTXNLdQJkCTplGfXh5QdX9VYxDlgKZjyoDhK1wk9ui8erJIvjLUDB9jDHOsC
         pqL7cskY6GZRlBXdrJf2egLQ3rBLLrZfv+owjE6OQWwDMjZCxGqplmyEZbdvvv6XQ2SO
         wORtTmM/arOG3g05BgOq7eMWQIaf9OZ/c249G0XetU/KaiTPPgPun+ONRr0pmSYVl7P7
         3XpLwhv/dR72uq7CsZ0WgPNiSZzvX5DEPcGflcKQFVik4A3eFIcwHMfyPujRPZ+rO528
         fjPAORNfEY+597OXgKS8MMwMLdkZQBpQxse+wzrL3CnbLuC8KCVLLZlrxJkPhj9k55Hr
         cHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ca9YfplyXj+SM4509LbCMm80icGRFj6bn1039+jlxOU=;
        b=sHUFT/MXNq3Ayk7lLjc1R3V4d4igoVh+lITg/W6sWz7wm8Ezj1Cr2DiHYjqflmr5O7
         eSiaXBBkYHhp+AoYs5tgKBU3ekiAvc4qFm28U4l5rBXK03AHbYzuG5nRdP0SkdknW/uf
         rIZOBg8n2IueDYhe209lMJvuxUYiWzRJmG6HcBme+RHOEaQg84R60yyDGVXx2FsVn2Ta
         1dDAPCkslRSY68JzhFC6xCRIBbhvjGj5K7F7rWDAsrDx4MvzPFA8tDoNocHdXq8B3yn7
         Myz2N1g0V7g/2tAQnGShn6XDDjg4HY4GbPbX45bWW70PLqxcWU7q7Uw6L1ijeLz7T81y
         +f/g==
X-Gm-Message-State: AOAM5332eIhvws4ghwj26Bohc/Axpye4wKc27lxlq/J8SbUihd7JYzSm
        aaBSvLf24K3jS3GQsR7LC/x8KWWW9nxPTg==
X-Google-Smtp-Source: ABdhPJy54Ed2MgxvOPtGhUpjFAPZpv5i2d247YuFI5yistXe1auaGr4Z1RmNvM64K614BZhzy+QprlM7iw/siA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:12c6:b0:625:262f:e551 with SMTP
 id j6-20020a05690212c600b00625262fe551mr4343272ybu.414.1645762661349; Thu, 24
 Feb 2022 20:17:41 -0800 (PST)
Date:   Fri, 25 Feb 2022 12:17:27 +0800
Message-Id: <20220225041727.1902850-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2] Input: samsung-keypad - Properly state IOMEM dependency
From:   David Gow <davidgow@google.com>
To:     Joonyoung Shim <jy0922.shim@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     David Gow <davidgow@google.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the samsung-keypad driver explicitly depend on CONFIG_HAS_IOMEM, as it
calls devm_ioremap(). This prevents compile errors in some configs (e.g,
allyesconfig/randconfig under UML):

/usr/bin/ld: drivers/input/keyboard/samsung-keypad.o: in function `samsung_keypad_probe':
samsung-keypad.c:(.text+0xc60): undefined reference to `devm_ioremap'

Signed-off-by: David Gow <davidgow@google.com>
Acked-by: anton ivanov <anton.ivanov@cambridgegreys.com>
---

Changes since v1:
http://lists.infradead.org/pipermail/linux-um/2022-February/002264.html
- Fix to depend on HAS_IOMEM, not IOMEM
- Add Acked-by tag.

---
 drivers/input/keyboard/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 0c607da9ee10..9417ee0b1eff 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -556,7 +556,7 @@ config KEYBOARD_PMIC8XXX
 
 config KEYBOARD_SAMSUNG
 	tristate "Samsung keypad support"
-	depends on HAVE_CLK
+	depends on HAS_IOMEM && HAVE_CLK
 	select INPUT_MATRIXKMAP
 	help
 	  Say Y here if you want to use the keypad on your Samsung mobile
-- 
2.35.1.574.g5d30c73bfb-goog

