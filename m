Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280784D29E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiCIH4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiCIHzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F214F981;
        Tue,  8 Mar 2022 23:54:46 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uu+M6BK8PWYHQHPex1cf8gmayk/rKI5lQ8EctEC+wIs=;
        b=ceb9AVGQAJhl1tnz/4ORI9kbMo5sbDXWphsriAyDVWVa+0tafcXIYfjaxg46gbE391Dw9o
        ecEKJ2y+C4Uepnh1rsxkqBpDBKcs2gP5690Mgoygs9md5ChPv91ZXjaR14kLNe0uImn6ha
        VvgvKaKC86jq/j05jtcYVnVfoO86ZDQb7+HHRKiYdnCUZ1t+/JYjhqIlKNvHjA1vgqjFx3
        MF4mYxTpcSIfoJBIX/W++mp6tXeDy0b6dGHPNO/LNMlJgIyKR9okOKGfRQVMN/EYZkHBS2
        JxfNCQ75+mVIJq2OVJ8/8C+jjLEx5EvVQgYLez2pM1uU5VVYRlV+xIpMaN8JGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uu+M6BK8PWYHQHPex1cf8gmayk/rKI5lQ8EctEC+wIs=;
        b=JKALMAU39VluTX+k7yfCQlSFFRwNT/FhBDfBkXjqO0akLgY/twFO3qiH9V8yqVpngQg5jC
        R1jVzrqY9DsMz/CQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] Kbuild: Allow whole module objtool runs
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.528181453@infradead.org>
References: <20220308154319.528181453@infradead.org>
MIME-Version: 1.0
Message-ID: <164681248379.16921.2753140038263453830.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     8856dadf7ad3a0115b904d15532d2ed20c6985bb
Gitweb:        https://git.kernel.org/tip/8856dadf7ad3a0115b904d15532d2ed20c6985bb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:38 +01:00

Kbuild: Allow whole module objtool runs

Just like we have vmlinux.o objtool runs, add the ability to do whole
module objtool runs.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.528181453@infradead.org
---
 scripts/Makefile.build    | 44 +------------------------------------
 scripts/Makefile.lib      | 45 ++++++++++++++++++++++++++++++++++++++-
 scripts/Makefile.modfinal |  1 +-
 3 files changed, 48 insertions(+), 42 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a4b89b7..b10d7ec 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -223,41 +223,6 @@ cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	
 	$(sub_cmd_record_mcount))
 endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 
-ifdef CONFIG_STACK_VALIDATION
-
-objtool := $(objtree)/tools/objtool/objtool
-
-objtool_args =								\
-	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
-	$(if $(part-of-module), --module)				\
-	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
-	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
-	$(if $(CONFIG_RETPOLINE), --retpoline)				\
-	$(if $(CONFIG_X86_SMAP), --uaccess)				\
-	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
-	$(if $(CONFIG_SLS), --sls)
-
-cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
-cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
-
-endif # CONFIG_STACK_VALIDATION
-
-ifdef CONFIG_LTO_CLANG
-
-# Skip objtool for LLVM bitcode
-$(obj)/%.o: objtool-enabled :=
-
-else
-
-# 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
-# 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
-# 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
-
-$(obj)/%.o: objtool-enabled = $(if $(filter-out y%, \
-	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
-
-endif
-
 ifdef CONFIG_TRIM_UNUSED_KSYMS
 cmd_gen_ksymdeps = \
 	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
@@ -292,21 +257,16 @@ ifdef CONFIG_LTO_CLANG
 # Module .o files may contain LLVM bitcode, compile them into native code
 # before ELF processing
 quiet_cmd_cc_lto_link_modules = LTO [M] $@
-cmd_cc_lto_link_modules =						\
+      cmd_cc_lto_link_modules =						\
 	$(LD) $(ld_flags) -r -o $@					\
 		$(shell [ -s $(@:.lto.o=.o.symversions) ] &&		\
 			echo -T $(@:.lto.o=.o.symversions))		\
 		--whole-archive $(filter-out FORCE,$^)			\
 		$(cmd_objtool)
-
-# objtool was skipped for LLVM bitcode, run it now that we have compiled
-# modules into native code
-$(obj)/%.lto.o: objtool-enabled = y
-$(obj)/%.lto.o: part-of-module := y
+endif
 
 $(obj)/%.lto.o: $(obj)/%.o FORCE
 	$(call if_changed,cc_lto_link_modules)
-endif
 
 cmd_mod = { \
 	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 79be57f..72638c2 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -533,3 +533,48 @@ define filechk_offsets
 	 echo ""; \
 	 echo "#endif"
 endef
+
+# objtool
+# ---------------------------------------------------------------------------
+
+ifdef CONFIG_STACK_VALIDATION
+
+objtool := $(objtree)/tools/objtool/objtool
+
+objtool_args =								\
+	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
+	$(if $(part-of-module), --module)				\
+	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
+	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
+	$(if $(CONFIG_RETPOLINE), --retpoline)				\
+	$(if $(CONFIG_X86_SMAP), --uaccess)				\
+	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+	$(if $(CONFIG_SLS), --sls)
+
+cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
+cmd_objtool_mod = $(if $(objtool-enabled), $(objtool) $(objtool_args) $(@:.ko=.o) ; )
+cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
+
+endif # CONFIG_STACK_VALIDATION
+
+ifdef CONFIG_LTO_CLANG
+
+# Skip objtool for LLVM bitcode
+$(obj)/%.o: objtool-enabled :=
+
+# objtool was skipped for LLVM bitcode, run it now that we have compiled
+# modules into native code
+$(obj)/%.lto.o: objtool-enabled = y
+$(obj)/%.lto.o: part-of-module := y
+
+else
+
+# 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
+# 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
+# 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
+
+$(obj)/%.o: objtool-enabled = $(if $(filter-out y%, \
+	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
+
+endif
+
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 7f39599..3a3c650 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -32,6 +32,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
 
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
+	$(cmd_objtool_mod)						\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T scripts/module.lds -o $@ $(filter %.o, $^);		\
