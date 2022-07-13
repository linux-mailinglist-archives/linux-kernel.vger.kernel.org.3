Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4365734AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235274AbiGMKyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGMKyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:54:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36627E2A0B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24CFAB81DD4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F1BC34114;
        Wed, 13 Jul 2022 10:54:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YuoriG/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657709651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EkZsDUD6CTjvy8I5svEtsHdmMOteOQD2pJPAcnje8/I=;
        b=YuoriG/TrgN7qUygQ6DqttSkYVg1dIP/W3W2nKfMxki8sDrNbIIjLagB31lDOGbJaQS+/G
        fi8E3DkDNSDiKcHOVhSyV7wDHJOm75qmu74gJ/bRCWbY7nVwoIDHs3nblvpzsmKQOVIQ7J
        tYcY/FxD4XINrW7X9ZGRjo0hRMrycGg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id db51a2e1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Jul 2022 10:54:11 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes@sipsolutions.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] um: include linux/stddef.h for __always_inline
Date:   Wed, 13 Jul 2022 12:54:06 +0200
Message-Id: <20220713105406.309966-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling against musl, their shipped <stddef.h> doesn't have
__always_inline. So instead explicitly include the kernel uapi header,
<linux/stddef.h>, which does.

This prevents the following build error:

In file included from arch/x86/um/shared/sysdep/stub.h:11,
                 from arch/um/kernel/skas/clone.c:14:
arch/x86/um/shared/sysdep/stub_64.h:111:23: error: expected ‘;’ before ‘void’
  111 | static __always_inline void *get_stub_page(void)
      |                       ^~~~~
      |                       ;
make[4]: *** [scripts/Makefile.build:249: arch/um/kernel/skas/clone.o] Error 1

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/um/shared/sysdep/stub_64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index e9c4b2b38803..92ea1670cf1c 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -8,6 +8,7 @@
 
 #include <sysdep/ptrace_user.h>
 #include <generated/asm-offsets.h>
+#include <linux/stddef.h>
 
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
-- 
2.35.1

