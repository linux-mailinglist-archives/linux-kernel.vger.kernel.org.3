Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263265645F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiGCIuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 04:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiGCIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 04:49:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA702AE43;
        Sun,  3 Jul 2022 01:47:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so2332398pjo.3;
        Sun, 03 Jul 2022 01:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUsFz55Px30MpiSri6WdI5V/eCo3oYtyYbcL/dhllTg=;
        b=niGEtNVyxCbmjPSahF1+ZBR8MEYUD3iy5SMhHcNpaGQ2vS4SqSox9PJtXjt4ndBcOK
         vaIA6IWExgqdi7jThgg0zHrgJwpfbVNaCVJOXO9HvYCEKAym++/tMkv3HLkeM06GnPnz
         9wMg0LeJYrJRo/fMgXreTsiRPZfNqrjcUgMY8wqBFnWy+qmrHruPoN2Ngb1p6THS9393
         32ezqqbr5p5xDmBFt9k/QXPTvtPfwl3HUrB8o7dYGn2CEhjwtCOrGxLN9stkiNISWafx
         er86W4hs1FZWvaU7M5TRAYbmUf7chK+OxGRNFRIT/3OVHa2ON9RlGMaYLQgaH3m70igX
         AxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUsFz55Px30MpiSri6WdI5V/eCo3oYtyYbcL/dhllTg=;
        b=gxqFFLk/Kuu2PjjAyCcfppMvRRDUm3hkve1G82cwtqTsuIo+92BwOd2vHYA44JetvC
         enoRhpC0hmyubvpNl6wBDPskYjBzlFgzBBQGZl38Jh671k/gaD/R3vq7TwC0WWnJ/gaY
         FurVjVDLLJXEq+GHsrqLk5MpJcp9kOPtQ4Rhir7wcuTQBmlfxTVwOoEFnqyhXc6nppPU
         JycrdvTKilnWiot/ikd1NvXkvBR7kTzXCWDgdXoxvxSusSHAYmbQL864Lri4sFIBgI3J
         TwziAFzUuBQKhzN2zUsoZ7/6zq8vDelqq3TEjaP2zQBuTMkydaWT2T+SXihxArIK+b4A
         ZSlw==
X-Gm-Message-State: AJIora8lyvRRUs/u0cIltCjnVg7lmCd9GwvnxDtjDPzL7zrLPexoaneZ
        /yw3AtZf+DOoB4+hWDqZB3urSE6m3QbMrA==
X-Google-Smtp-Source: AGRyM1uxGwlkGItwao0LpzEZt1r4qM73Q1jRopcIa1PdFpWCXpTztf2Ql0ME8FJRdX6TcLjck2QDMw==
X-Received: by 2002:a17:90b:218:b0:1ef:1440:ebe1 with SMTP id fy24-20020a17090b021800b001ef1440ebe1mr29068126pjb.166.1656838069362;
        Sun, 03 Jul 2022 01:47:49 -0700 (PDT)
Received: from fedora.. ([103.159.189.148])
        by smtp.gmail.com with ESMTPSA id mt7-20020a17090b230700b001ef7bd5b711sm1262417pjb.0.2022.07.03.01.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 01:47:48 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>, khalid.masum.92@gmail.com
Subject: [RFC PATCH] scripts/gdb: Fix gdb 'lx-symbols' command
Date:   Sun,  3 Jul 2022 14:46:54 +0600
Message-Id: <20220703084654.6360-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the command 'lx-symbols' in gdb exits with the error`Function
"do_init_module" not defined in "kernel/module.c"`. This occurs because
the file kernel/module.c was moved to kernel/module/main.c.

Fix this breakage by changing the path to "kernel/module/main.c" in
LoadModuleBreakpoint.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 scripts/gdb/linux/symbols.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 46f7542db08c..dc07b6d12e30 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -180,7 +180,7 @@ lx-symbols command."""
                 self.breakpoint.delete()
                 self.breakpoint = None
             self.breakpoint = LoadModuleBreakpoint(
-                "kernel/module.c:do_init_module", self)
+                "kernel/module/main.c:do_init_module", self)
         else:
             gdb.write("Note: symbol update on module loading not supported "
                       "with this gdb version\n")
-- 
2.36.1

