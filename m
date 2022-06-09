Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2C2545067
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbiFIPPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344243AbiFIPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:15:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA40828984;
        Thu,  9 Jun 2022 08:15:39 -0700 (PDT)
Date:   Thu, 09 Jun 2022 15:15:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654787738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OX0E9o/hk3UAtzh380FcKdPndbEwHY7bPLgyy9FMddQ=;
        b=Nr1QpCugMCN3mNTGmoVe/fihkM/50Q1+8yP3BjWn5AO0mJh5001POcoWKsROs0aIetZq+r
        1HXX4HvkaUe68jPG7Ufj6O2gjFjN4glD0RbuOjsuXSJgdxnbhHnJqk2upHsfK7UTQI65/X
        XQxjLfWY1w696ZDvrrcN/k7pHR6Gr78wc27yXY0z8eDTHvLWEJBG0MnJTtxG1lrlEgWket
        AQjkMZwreUbixYN1/hvdPDHzgvMiPYmQEKcD5thECAeCUlUhphi+RmajreEB4ngHJIjahF
        KVlbiKyflzfPwJZ8Ibg6A8kG8TMGQ0HEQKvfhojBVFVEYBiJs0Uv125+5CigkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654787738;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OX0E9o/hk3UAtzh380FcKdPndbEwHY7bPLgyy9FMddQ=;
        b=BCKaUQDN1sIFRNl6/7NVFnkIYUey2CyheONslLHYBbbnO9utAcwqnuM/O7Ig2XKwI2LaeZ
        NIryhTL+as6SNnBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/ftrace: Remove OBJECT_FILES_NON_STANDARD usage
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b7a7a42fe306aca37826043dac89e113a1acdbac.1654268610.git.jpoimboe@kernel.org>
References: <b7a7a42fe306aca37826043dac89e113a1acdbac.1654268610.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <165478773692.4207.2311540394030885047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     7b6c7a877cc616bc7dc9cd39646fe454acbed48b
Gitweb:        https://git.kernel.org/tip/7b6c7a877cc616bc7dc9cd39646fe454acbed48b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 03 Jun 2022 08:04:44 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 06 Jun 2022 11:50:22 -07:00

x86/ftrace: Remove OBJECT_FILES_NON_STANDARD usage

The file-wide OBJECT_FILES_NON_STANDARD annotation is used with
CONFIG_FRAME_POINTER to tell objtool to skip the entire file when frame
pointers are enabled.  However that annotation is now deprecated because
it doesn't work with IBT, where objtool runs on vmlinux.o instead of
individual translation units.

Instead, use more fine-grained function-specific annotations:

- The 'save_mcount_regs' macro does funny things with the frame pointer.
  Use STACK_FRAME_NON_STANDARD_FP to tell objtool to ignore the
  functions using it.

- The return_to_handler() "function" isn't actually a callable function.
  Instead of being called, it's returned to.  The real return address
  isn't on the stack, so unwinding is already doomed no matter which
  unwinder is used.  So just remove the STT_FUNC annotation, telling
  objtool to ignore it.  That also removes the implicit
  ANNOTATE_NOENDBR, which now needs to be made explicit.

Fixes the following warning:

  vmlinux.o: warning: objtool: __fentry__+0x16: return with modified stack frame

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/b7a7a42fe306aca37826043dac89e113a1acdbac.1654268610.git.jpoimboe@kernel.org
---
 arch/x86/kernel/Makefile      |  4 ----
 arch/x86/kernel/ftrace_64.S   | 11 ++++++++---
 include/linux/objtool.h       |  6 ++++++
 tools/include/linux/objtool.h |  6 ++++++
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 03364dc..4c8b6ae 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -36,10 +36,6 @@ KCSAN_SANITIZE := n
 
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 
-ifdef CONFIG_FRAME_POINTER
-OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o		:= y
-endif
-
 # If instrumentation of this dir is enabled, boot hangs during first second.
 # Probably could be more selective here, but note that files related to irqs,
 # boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 4ec1360..dfeb227 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -175,6 +175,7 @@ SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 
 	jmp ftrace_epilogue
 SYM_FUNC_END(ftrace_caller);
+STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
 SYM_FUNC_START(ftrace_epilogue)
 /*
@@ -282,6 +283,7 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	jmp	ftrace_epilogue
 
 SYM_FUNC_END(ftrace_regs_caller)
+STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
@@ -311,10 +313,14 @@ trace:
 	jmp ftrace_stub
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
+STACK_FRAME_NON_STANDARD_FP(__fentry__)
+
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-SYM_FUNC_START(return_to_handler)
+SYM_CODE_START(return_to_handler)
+	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	subq  $16, %rsp
 
 	/* Save the return values */
@@ -339,7 +345,6 @@ SYM_FUNC_START(return_to_handler)
 	int3
 .Ldo_rop:
 	mov %rdi, (%rsp)
-	UNWIND_HINT_FUNC
 	RET
-SYM_FUNC_END(return_to_handler)
+SYM_CODE_END(return_to_handler)
 #endif
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 6491fa8..15b940e 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -143,6 +143,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD_FP func:req
+#ifdef CONFIG_FRAME_POINTER
+	STACK_FRAME_NON_STANDARD \func
+#endif
+.endm
+
 .macro ANNOTATE_NOENDBR
 .Lhere_\@:
 	.pushsection .discard.noendbr
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 6491fa8..15b940e 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -143,6 +143,12 @@ struct unwind_hint {
 	.popsection
 .endm
 
+.macro STACK_FRAME_NON_STANDARD_FP func:req
+#ifdef CONFIG_FRAME_POINTER
+	STACK_FRAME_NON_STANDARD \func
+#endif
+.endm
+
 .macro ANNOTATE_NOENDBR
 .Lhere_\@:
 	.pushsection .discard.noendbr
