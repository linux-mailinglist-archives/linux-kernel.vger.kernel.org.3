Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C3C53AB0F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355949AbiFAQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243359AbiFAQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:31:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903A985B2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0B42CE1A31
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 16:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81E7C385A5;
        Wed,  1 Jun 2022 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654101064;
        bh=Wd/2NFNek590H9keh7aFB7lvSPIhXat/8uywAb1mU1g=;
        h=From:To:Cc:Subject:Date:From;
        b=FJP87CbK7nOivETvw+t0Py2ks9O2+PhpEK2TzdOy/H1x9dX1nF3ggDdosgcdX5+13
         Y0i/tMnO3otOmMEKYLv0tl+rA3kCWyF5e50n2OxyoyIZyq1mdyooukF3f3gKlbe/D4
         LxsbjOJVATPhEgX/xF3dY6ofj0+dzbFBMxtv55bo0Stwjpm4c6SjU46WLp22ZF5KdP
         VuoZTaEXXIVc0vIQugGb732vIjSNlaeKOe7Zb2pkbiTDmz7gC4dFZAeFUKvniTIRmX
         azG59yOfKVFEHnTyCQ4zWBngB0CoLjtdq4Xwd15Dngr7yp3bcpCCNscIAK6R4z3UTy
         sZ8wgte4gSRuw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] x86/ftrace: Fix objtool vmlinux.o __fentry__ warning
Date:   Wed,  1 Jun 2022 09:30:53 -0700
Message-Id: <ffbae3ed9384307a0f867a366ca9b5765355f4dd.1654101038.git.jpoimboe@kernel.org>
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

The 'save_mcount_regs' macro does funny things with the frame pointer,
which objtool doesn't approve of.  So OBJECT_FILES_NON_STANDARD is used
with CONFIG_FRAME_POINTER to tell objtool to skip the entire file when
frame pointers are enabled.

However, the file-wide OBJECT_FILES_NON_STANDARD annotation is now
deprecated, because it doesn't work for IBT, where objtool runs on
vmlinux.o.  Use more fine-grained function-specific annotations
instead.

Fixes the following warning:

  vmlinux.o: warning: objtool: __fentry__+0x16: return with modified stack frame

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/Makefile      | 4 ----
 arch/x86/kernel/ftrace_64.S   | 4 ++++
 include/linux/objtool.h       | 6 ++++++
 tools/include/linux/objtool.h | 6 ++++++
 4 files changed, 16 insertions(+), 4 deletions(-)

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
index 4ec13608d3c6..db7c396064ef 100644
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
@@ -311,6 +313,8 @@ trace:
 	jmp ftrace_stub
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
+STACK_FRAME_NON_STANDARD_FP(__fentry__)
+
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
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

