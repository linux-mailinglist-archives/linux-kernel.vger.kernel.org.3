Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994FF5785C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiGROug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiGROub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4B13FA2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC97C6119A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA13BC341CA;
        Mon, 18 Jul 2022 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658155829;
        bh=/NK0/LuWVWBPnCSYd3v8kD5Ciw2hLQ1HXEKjllD63Iw=;
        h=From:To:Cc:Subject:Date:From;
        b=IO7c5jXZmJMYKCKv0NsJ1ArQ835U/YXSPCmcyBXhkuw9CIidxXgI9TNQlS1ykt96h
         COh5j5jz1RRrF0CLOkd59icc/Go5M8I6sYYnsHL3mlhKcwiuxlwK/7pR8VIjsZT+Xm
         OaMaSPccsD1SydrqsyRM47WMGdyk4C0KvDqdEQmQ4z6HbEFbYvh6V9qLIX8G4mctNe
         zncro4uiiRvlVhsA9uIxwQJgCHdZbCJhLl2zm4u1k4HoFCoBMbFJOVZVA7oRouvP7J
         hARXDYKi+juvmpo72MfHpggxiyEQvwXMQhwdY4TizmCbeJcHk1773JvPUFIfrQJq36
         6JL41D/opvi5g==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] lkdtm: Disable return thunks in rodata.c
Date:   Mon, 18 Jul 2022 07:50:25 -0700
Message-Id: <8ec0039712f252693049c70ed3891d39a2357112.1658155446.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning was seen:

  WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:557 apply_returns (arch/x86/kernel/alternative.c:557 (discriminator 1))
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-rc4-00008-gee88d363d156 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
  RIP: 0010:apply_returns (arch/x86/kernel/alternative.c:557 (discriminator 1))
  Code: ff ff 74 cb 48 83 c5 04 49 39 ee 0f 87 81 fe ff ff e9 22 ff ff ff 0f 0b 48 83 c5 04 49 39 ee 0f 87 6d fe ff ff e9 0e ff ff ff <0f> 0b 48 83 c5 04 49 39 ee 0f 87 59 fe ff ff e9 fa fe ff ff 48 89

The warning happened when apply_returns() failed to convert "JMP
__x86_return_thunk" to RET.  It was instead a JMP to nowhere, due to the
thunk relocation not getting resolved.

That rodata.o code is objcopy'd to .rodata, and later memcpy'd, so
relocations don't work (and are apparently silently ignored).

LKDTM is only used for testing, so the naked RET should be fine.  So
just disable return thunks for that file.

While at it, disable objtool and KCSAN for the file.

Fixes: 0b53c374b9ef ("x86/retpoline: Use -mfunction-return")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/lkml/Ys58BxHxoDZ7rfpr@xsang-OptiPlex-9020/
Debugged-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/Makefile           | 1 +
 drivers/misc/lkdtm/Makefile | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1f40dad30d50..7854685c5f25 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -27,6 +27,7 @@ RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
 RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
 endif
 
+export RETHUNK_CFLAGS
 export RETPOLINE_CFLAGS
 export RETPOLINE_VDSO_CFLAGS
 
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 2e0aa74ac185..95ef971b5e1c 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -13,10 +13,13 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 lkdtm-$(CONFIG_LKDTM)		+= fortify.o
 lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
 
-KASAN_SANITIZE_rodata.o		:= n
 KASAN_SANITIZE_stackleak.o	:= n
-KCOV_INSTRUMENT_rodata.o	:= n
-CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
+
+KASAN_SANITIZE_rodata.o			:= n
+KCSAN_SANITIZE_rodata.o			:= n
+KCOV_INSTRUMENT_rodata.o		:= n
+OBJECT_FILES_NON_STANDARD_rodata.o	:= y
+CFLAGS_REMOVE_rodata.o			+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.36.1

