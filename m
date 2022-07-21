Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB3557C680
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiGUIi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiGUIhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:37:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEE97F51A;
        Thu, 21 Jul 2022 01:37:49 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:37:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658392668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pT4BSHEYaK9gV++jCSLu0DuALx6ZzQtiQD+Xfveg7B0=;
        b=iI5leXmo8J6+9akealXlpa0iWjIvO1uj3KEvsuAvXRkmiTpyNC2+sglaC6U2ib4WRSIQzN
        DKYrlxoDzuFP8wvk0N48lBiHs0i2G1DDAa3jVTbIeKo2C+Xx3nJ9QgyHsBhemP9XqBl+jy
        GxeJQrEVcO5z+9UHMfzHIYGeYoWICAbC1O/PV7gUvhGND+SQ1J9NzXUdipW0RdpVZKfenI
        z/lxsp7NeuT2KQ4Id6C72G/tBhZeEnMOnX3JiXPOixGIsJ/iZzJxXtfeapYNsNo6WGf4t/
        IW4LSFW0rWtu3JtNsdnc5nODkNapTFnqvQ3K6dUJEc8dQGVCxWr2Neglj3GX8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658392668;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pT4BSHEYaK9gV++jCSLu0DuALx6ZzQtiQD+Xfveg7B0=;
        b=AdXk3KN5s9VR7KAbCzCHayI/Qk7MnLTe+Zse0aSAuyy712CPwVNkIN1+QKvf/m7XexPgpJ
        +t6H7tltkbb3RgAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] lkdtm: Disable return thunks in rodata.c
Cc:     kernel test robot <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <165839266701.15455.11302298151547769701.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     efc72a665a61fd48c462f5248a9e3dc991398ddd
Gitweb:        https://git.kernel.org/tip/efc72a665a61fd48c462f5248a9e3dc991398ddd
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 18 Jul 2022 07:50:25 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 20 Jul 2022 19:24:53 +02:00

lkdtm: Disable return thunks in rodata.c

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
Debugged-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/Ys58BxHxoDZ7rfpr@xsang-OptiPlex-9020/
---
 arch/x86/Makefile           |  1 +
 drivers/misc/lkdtm/Makefile |  9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1f40dad..7854685 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -27,6 +27,7 @@ RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
 RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
 endif
 
+export RETHUNK_CFLAGS
 export RETPOLINE_CFLAGS
 export RETPOLINE_VDSO_CFLAGS
 
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 2e0aa74..95ef971 100644
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
