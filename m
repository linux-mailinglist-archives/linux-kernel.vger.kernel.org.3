Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF8953CBFA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245324AbiFCPEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244661AbiFCPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:04:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27C64D8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A91B616F9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 15:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD885C385A9;
        Fri,  3 Jun 2022 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654268690;
        bh=lwutLgb9SNOCxmpQkrrPjmYr91eeRNJxGbGYmZ6+CXI=;
        h=From:To:Cc:Subject:Date:From;
        b=iaB3A9y22XEAuVmr8z1+mkmxwgdlJPj0cehin/oAo7lAZv+VKBCFWL6miUtnf8ujs
         Mtdej2X1gwAEl38iXH9+AuFF+C7Sa6BJUJdvxNssnVqYekx4lsJ6eIN2b4knXyaLUS
         MtlOcShlpCOOc6Azq1vbrbrx0H0hM7Mxy3Qegud69oF/SEh7/9pFYj4QBJWGyCN5QV
         56F7gZUJSLjWHeD0XIpYiYLH9O59TR0ysJ6lJdlLzP6ziUNsrNQXuG3anlCo7+CFqp
         jCpgAI9MGBTBujBasmglF4ZtdtN8dmpeX7X0vqLrZu5X6N3ETvCA8GRx+K2h6fEBbd
         csNNWDlVwAi8g==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] x86/ftrace: Remove OBJECT_FILES_NON_STANDARD usage
Date:   Fri,  3 Jun 2022 08:04:44 -0700
Message-Id: <b7a7a42fe306aca37826043dac89e113a1acdbac.1654268610.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
v2:
- fix return_to_handler()

 arch/x86/kernel/Makefile      |  4 ----
 arch/x86/kernel/ftrace_64.S   | 11 ++++++++---
 include/linux/objtool.h       |  6 ++++++
 tools/include/linux/objtool.h |  6 ++++++
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 03364dc40d8d..4c8b6ae802ac 100644
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
index 4ec13608d3c6..dfeb227de561 100644
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
index 6491fa8fba6d..15b940ec1eac 100644
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
index 6491fa8fba6d..15b940ec1eac 100644
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
-- 
2.34.3

