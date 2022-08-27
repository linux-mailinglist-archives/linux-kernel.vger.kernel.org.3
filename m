Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A2A5A3573
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiH0HL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH0HLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:11:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973EAB6D05
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 00:11:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u22so3396248plq.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 00:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=y44ThfNQT7OxF8rtiBzHWvJX+KqdDUpUN/onUxq5Iq4=;
        b=g3CoMLJ+/fbWEjoppmRUXlwsc8nf9xlp9gVDz+7JEpDImi+8rD1KzTqWELs2/C4ZWW
         1/vkn6+AonaCCNoIZ7zg4LRuaXq5XpGRPQ/jfKoE4qdPihwxGv+UNThPzi1yvw+6RYMK
         6YEcHpsedktl2ActjYjJE+iYAPr8GKBapUIaGxzjaYpq3fFcTFLW/pWTDbN/5Yuvf0rZ
         mjajwZs6QegGgvsDjF769V5arpcpaBbx+/z5//d0q7RQuoxtkmJtNNRFTUjq1pybiJAB
         doSFsXD2BunDm+J9Ou5n1nuNc9kl97St0N5PYDQck7J6K59LCU0rDDhFXKlEXbdrB2Ix
         KyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=y44ThfNQT7OxF8rtiBzHWvJX+KqdDUpUN/onUxq5Iq4=;
        b=W+UKbMqvXjxu8IE3dMnm3od9odrg9Ff+sJrpMObznlr+YNZqWd/GkoT+upavF1niJl
         Cwz1qtAw7Nvyclt1AndkdRL4BBxJW8+hKu827kkUe3CqQuWDC3TTzDnuuJ6ITkYp3fDd
         iFk43YLSNtQeSu2+BjKQ1csXcIF4OXCngkgKJ4EG8WboDQaEe9kEh9E4q+UJ05UVwot3
         xHq6vlZoW9pcSjkhMAE8v9OR7vQMXyeGH8atP7dD7M0xCdFYwLgGuOOY5JKHXl7ippFV
         4M+RGVH+gv5+sSKl09BDkV9LIYkgP8gQy+RsImEwhoJzLIfqxAtTzPvSgoPrPd0M3e1p
         GQEA==
X-Gm-Message-State: ACgBeo28S7E5USXzF7J37AHzH8ZFx+DlidG3PJin4SPvGghbigctB5wU
        2YKZZNX/xDKSFd9wZr1n0EQ=
X-Google-Smtp-Source: AA6agR7Pzyi28YpZajttOW6lnOmkA19xR1IaptAqfUYzmvXILJxO6d4kW3EN5tWHhl21tScGUWoU6Q==
X-Received: by 2002:a17:902:e548:b0:172:aafb:4927 with SMTP id n8-20020a170902e54800b00172aafb4927mr7371403plf.106.1661584282093;
        Sat, 27 Aug 2022 00:11:22 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d144-20020a621d96000000b00537a6c78ef1sm2955078pfd.190.2022.08.27.00.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 00:11:21 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     viro@zeniv.linux.org.uk, willy@infradead.org, mwilck@suse.com,
        ddiss@suse.de, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: mask my_inptr as __initdata
Date:   Sat, 27 Aug 2022 15:11:16 +0800
Message-Id: <20220827071116.83078-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As my_inptr is only used in __init function unpack_to_rootfs(),
mark it as __initdata to allow it be freed after boot.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 18229cfe8906..2f5bfb7d7652 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -482,7 +482,7 @@ static long __init flush_buffer(void *bufv, unsigned long len)
 	return origLen;
 }
 
-static unsigned long my_inptr; /* index of next byte to be processed in inbuf */
+static unsigned long my_inptr __initdata; /* index of next byte to be processed in inbuf */
 
 #include <linux/decompress/generic.h>
 
-- 
2.20.1

