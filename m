Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87DC5A50C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiH2Pzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiH2Pzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:55:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D9183F3D;
        Mon, 29 Aug 2022 08:55:41 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 69so6419687pgb.13;
        Mon, 29 Aug 2022 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=o1D98z3mFMBJRrzCcsbL8Mo1gt/r97vRuaih/7SLPHY=;
        b=E3c4ZJF7NWlVsR6u1C2p/hNsu24KBR9b6V36GUpANlsMhvf3iJp+u8uUf8OlxCvK03
         uIbBF1+rKhgsN10RgdaymZ0FGfOzXybGVkpqOv0O6eAmJHTCcjLHPU0Q9eKUsbzvfESk
         Og8DFQHag5Y7m3jzKFmjIzRS1g2ehaA/jvThsS9I/73t2J4NbrB7wYCKlwmeA1VP/bza
         cedd8IhOLiDr2MDK2UGedP8Edo0M3FJwMHeJxMf1pPUpz8UIig6PFgK2r0PPZd1QqHV6
         YP00HSgIR8fzvucKEjCLLjGmS488Owf3auneBdkiPmqc6ZKyxpzmechEGM1aKzxMJPuv
         UMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=o1D98z3mFMBJRrzCcsbL8Mo1gt/r97vRuaih/7SLPHY=;
        b=4tS1Yl9vsOx9J89t0LCE+FpePzaz1Ucxv87ni2ifqAqVCT+xl+Bag6/7PJdqVIIlhD
         CwV34YBDMNfyKzOvq0SsDn7cmHpPfnlELGIu2GowXWRW5nEbwgrpLyFGUHjL7WyBjMiL
         2VA63i6b1Pc5f31QBKDVSX+GeXiPN0zbSP8WOjTH84SWvJh+oP61Rd92iwFkFCxg4CIy
         seXuzuQ8ji1xk3o0QFkYFGxwij6TJXzYOgdvaZY+hGMw1RtA3PxOqA5iSLUCY/ZBqVXS
         WeQqwjNBC/9rxj9uKjwjG10jCeRKj5PBoGFJqzh2XBjdPUykkrSjZVOQZWpOsXE53fQY
         UyGA==
X-Gm-Message-State: ACgBeo0VzhJfQl0ozgBnBsBYxehK8VDjQfJc6RWlQYCeGW8ggn7NT8kG
        qgoqcd1i79QbB47eJqK4ZGvwuSeO4MkMND7w
X-Google-Smtp-Source: AA6agR5y99+69yOmkB97EALjo2VwgTeiFh45+mKxUglNef7UD8cXMgcjRZOlREr2Jsud6xcSevjFiQ==
X-Received: by 2002:a05:6a00:2484:b0:538:cfb:4b2 with SMTP id c4-20020a056a00248400b005380cfb04b2mr9418427pfv.65.1661788541225;
        Mon, 29 Aug 2022 08:55:41 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090340cd00b00174923afa8asm4079416pld.3.2022.08.29.08.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:55:40 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH] docs: x86: move do_IRQ to common_interrupt in entry_64.rst
Date:   Mon, 29 Aug 2022 23:53:50 +0800
Message-Id: <20220829155350.7014-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_IRQ has been replaced by common_interrupt in commit
fa5e5c409213 ("x86/entry: Use idtentry for interrupts").
Move do_IRQ to common_interrupt.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 Documentation/x86/entry_64.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/entry_64.rst b/Documentation/x86/entry_64.rst
index e433e08f7018..e27f1fa796db 100644
--- a/Documentation/x86/entry_64.rst
+++ b/Documentation/x86/entry_64.rst
@@ -33,7 +33,7 @@ Some of these entries are:
  - interrupt: An array of entries.  Every IDT vector that doesn't
    explicitly point somewhere else gets set to the corresponding
    value in interrupts.  These point to a whole array of
-   magically-generated functions that make their way to do_IRQ with
+   magically-generated functions that make their way to common_interrupt with
    the interrupt number as a parameter.
 
  - APIC interrupts: Various special-purpose interrupts for things
-- 
2.17.1

