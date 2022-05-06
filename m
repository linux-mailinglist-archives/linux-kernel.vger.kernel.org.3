Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B2551DB95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442703AbiEFPMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiEFPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:12:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734A96D185;
        Fri,  6 May 2022 08:09:02 -0700 (PDT)
Date:   Fri, 06 May 2022 15:08:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651849740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wc2bzqI42oIckbUmFpKNjycPjcAyrjA3sg0Rb2QcJts=;
        b=Wqdhb52Ai+U0KWwyxU/wWUfVqzJgQxXp5XYqh1WA95BIXQrZ0Qf1ShdDOWa4JGhlAJEFxz
        9mxuCEUWkEwAhUX6OeTRYl8t+WA4zIuZmLccT+ZNOllYSBPtky27F4syrhF00BRVILU6RV
        f7qLGoiALPbZ0221h58kP9IeQuDj0/56f5igsVQi9RatEJgNzXnVlp5aSsiW3Gr1b4iFyw
        tOdPWa/Fp8y0iDUkWNMXTHlsGL9fH4+xR5ULVSjqMsDPUL6EKabEGg3pDUAfDDCRadC6HF
        DholtdF2roUQg7pE6EUoKrpPiVtM/YA7tP5lSXs7MlqwgG4WLotndxpstwJxdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651849740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wc2bzqI42oIckbUmFpKNjycPjcAyrjA3sg0Rb2QcJts=;
        b=nqo6nFxwc0dBI0+fNBv4wYkjWtSZI05tBoJ6KRRD4Eo3jCXKFPLjVg9zMsYLfPqwPOd568
        /q2ownWBMKCnaVDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] objtool: Fix STACK_FRAME_NON_STANDARD reloc type
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220506121631.508692613@infradead.org>
References: <20220506121631.508692613@infradead.org>
MIME-Version: 1.0
Message-ID: <165184973857.4207.8156849772792716816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     38f3803fb4fa588ef7645048285493efbe264d79
Gitweb:        https://git.kernel.org/tip/38f3803fb4fa588ef7645048285493efbe264d79
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 06 May 2022 14:14:37 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 May 2022 16:07:06 +02:00

objtool: Fix STACK_FRAME_NON_STANDARD reloc type

STACK_FRAME_NON_STANDARD results in inconsistent relocation types
depending on .c or .S usage:

  Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x3c01090 contains 5 entries:
  Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  00020c2200000002 R_X86_64_PC32          0000000000047b40 do_suspend_lowlevel + 0
  0000000000000008  0002461e00000001 R_X86_64_64            00000000000480a0 machine_real_restart + 0
  0000000000000010  0000001400000001 R_X86_64_64            0000000000000000 .rodata + b3d4
  0000000000000018  0002444600000002 R_X86_64_PC32          00000000000678a0 __efi64_thunk + 0
  0000000000000020  0002659d00000001 R_X86_64_64            0000000000113160 __crash_kexec + 0

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220506121631.508692613@infradead.org
---
 include/linux/objtool.h       | 4 +++-
 tools/include/linux/objtool.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 586d357..c68d81d 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_OBJTOOL_H
 #define _LINUX_OBJTOOL_H
 
+#include <asm/asm.h>
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
@@ -137,7 +139,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-		.long \func - .
+	_ASM_PTR \func
 	.popsection
 .endm
 
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 586d357..c68d81d 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_OBJTOOL_H
 #define _LINUX_OBJTOOL_H
 
+#include <asm/asm.h>
+
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
@@ -137,7 +139,7 @@ struct unwind_hint {
 
 .macro STACK_FRAME_NON_STANDARD func:req
 	.pushsection .discard.func_stack_frame_non_standard, "aw"
-		.long \func - .
+	_ASM_PTR \func
 	.popsection
 .endm
 
