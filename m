Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8759A4DDD13
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238143AbiCRPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbiCRPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:37:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784FE2631;
        Fri, 18 Mar 2022 08:36:30 -0700 (PDT)
Date:   Fri, 18 Mar 2022 15:36:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647617788;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9gAy6RHh9O8uXg9nZI6GD5pDs0VHy0Nr9DLkqnpXME=;
        b=NulnQnanEodHA+WFvVz//atWbZvSctpj01qS53w1zxKQlpvj8URxNTqCXGH4p9MR+fU8nV
        OA85MgfjX2brJr1PN08SK3vgSV5zx9RDznqPgiA0yLOx2/ATG+LuDbmblHFaAczZGZkvxf
        gQdaA4T7cnAsZtFVzK1hUaBiSkTWUG+ky+pgdyFIkjcC6D3WMpx6JeeiEiDALOHj0Zw1Tf
        VyH7uOblrnDK8HHVB3F4xv2MmpBZ1WSr8BQ6sP9R2hFf7pbXep1iDTXmIib2VY4lkCh4Vl
        m+Crs8gD+rXS3/6k8GY0UwM4c1TKEyUD0fCm2Wcn/ch0ZhIO/zOasrxXa2YlGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647617788;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9gAy6RHh9O8uXg9nZI6GD5pDs0VHy0Nr9DLkqnpXME=;
        b=PBt2//Ye1HrFV6mmpuwiimurAoK2TiUT+IK81wwYlO/XW0Ggcav+rhKufOs+7Qn42rAA/G
        2J/tBMkoYHUJ8LAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] kbuild: Fixup the IBT kbuild changes
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CAK7LNAQ2mYMnOKMQheVi+6byUFE3KEkjm1zcndNUfe0tORGvug@mail.gmail.com>
References: <CAK7LNAQ2mYMnOKMQheVi+6byUFE3KEkjm1zcndNUfe0tORGvug@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <164761778730.389.10755640525998622093.tip-bot2@tip-bot2>
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

Commit-ID:     2f35e67f621fffc636cb802a4f93fd168cf38274
Gitweb:        https://git.kernel.org/tip/2f35e67f621fffc636cb802a4f93fd168cf38274
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 18 Mar 2022 12:19:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Mar 2022 12:43:44 +01:00

kbuild: Fixup the IBT kbuild changes

Masahiro-san deemed my kbuild changes to support whole module objtool
runs too terrible to live and gracefully provided an alternative.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/CAK7LNAQ2mYMnOKMQheVi+6byUFE3KEkjm1zcndNUfe0tORGvug@mail.gmail.com
---
 scripts/Makefile.build | 68 ++++++++++++-----------------------------
 scripts/Makefile.lib   |  4 +-
 scripts/mod/modpost.c  | 12 +++----
 3 files changed, 28 insertions(+), 56 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 926d254..abf93d1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -86,18 +86,12 @@ ifdef need-builtin
 targets-for-builtin += $(obj)/built-in.a
 endif
 
-targets-for-modules :=
+targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
 
-ifdef CONFIG_LTO_CLANG
-targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
+targets-for-modules += $(patsubst %.o, %.prelink.o, $(filter %.o, $(obj-m)))
 endif
 
-ifdef CONFIG_X86_KERNEL_IBT
-targets-for-modules += $(patsubst %.o, %.objtool, $(filter %.o, $(obj-m)))
-endif
-
-targets-for-modules += $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
-
 ifdef need-modorder
 targets-for-modules += $(obj)/modules.order
 endif
@@ -176,7 +170,7 @@ ifdef CONFIG_MODVERSIONS
 #   the actual value of the checksum generated by genksyms
 # o remove .tmp_<file>.o to <file>.o
 
-ifdef CONFIG_LTO_CLANG
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 # Generate .o.symversions files for each .o with exported symbols, and link these
 # to the kernel and/or modules at the end.
 cmd_modversions_c =								\
@@ -244,31 +238,16 @@ objtool_args =								\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_SLS), --sls)
 
-cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $(@:.objtool=.o))
-cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$(@:.objtool=.o): $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
+cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
+cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
 
 endif # CONFIG_STACK_VALIDATION
 
-ifdef CONFIG_LTO_CLANG
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 
 # Skip objtool for LLVM bitcode
 $(obj)/%.o: objtool-enabled :=
 
-# objtool was skipped for LLVM bitcode, run it now that we have compiled
-# modules into native code
-$(obj)/%.lto.o: objtool-enabled = y
-$(obj)/%.lto.o: part-of-module := y
-
-else ifdef CONFIG_X86_KERNEL_IBT
-
-# Skip objtool on individual files
-$(obj)/%.o: objtool-enabled :=
-
-# instead run objtool on the module as a whole, right before
-# the final link pass with the linker script.
-$(obj)/%.objtool: objtool-enabled = y
-$(obj)/%.objtool: part-of-module := y
-
 else
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
@@ -310,19 +289,24 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
-ifdef CONFIG_LTO_CLANG
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 # Module .o files may contain LLVM bitcode, compile them into native code
 # before ELF processing
-quiet_cmd_cc_lto_link_modules = LTO [M] $@
-      cmd_cc_lto_link_modules =						\
+quiet_cmd_cc_prelink_modules = LD [M]  $@
+      cmd_cc_prelink_modules =						\
 	$(LD) $(ld_flags) -r -o $@					\
-		$(shell [ -s $(@:.lto.o=.o.symversions) ] &&		\
-			echo -T $(@:.lto.o=.o.symversions))		\
+               $(shell [ -s $(@:.prelink.o=.o.symversions) ] &&		\
+                       echo -T $(@:.prelink.o=.o.symversions))		\
 		--whole-archive $(filter-out FORCE,$^)			\
 		$(cmd_objtool)
 
-$(obj)/%.lto.o: $(obj)/%.o FORCE
-	$(call if_changed,cc_lto_link_modules)
+# objtool was skipped for LLVM bitcode, run it now that we have compiled
+# modules into native code
+$(obj)/%.prelink.o: objtool-enabled = y
+$(obj)/%.prelink.o: part-of-module := y
+
+$(obj)/%.prelink.o: $(obj)/%.o FORCE
+	$(call if_changed,cc_prelink_modules)
 endif
 
 cmd_mod = { \
@@ -333,18 +317,6 @@ cmd_mod = { \
 $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
 	$(call if_changed,mod)
 
-#
-# Since objtool will re-write the file it will change the timestamps, therefore
-# it is critical that the %.objtool file gets a timestamp *after* objtool runs.
-#
-# Additionally, care must be had with ordering this rule against the other rules
-# that take %.o as a dependency.
-#
-cmd_objtool_mod = true $(cmd_objtool) ; touch $@
-
-$(obj)/%.objtool: $(obj)/%$(mod-prelink-ext).o FORCE
-	$(call if_changed,objtool_mod)
-
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
 		     $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
@@ -498,7 +470,7 @@ $(obj)/lib.a: $(lib-y) FORCE
 # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
 # module is turned into a multi object module, $^ will contain header file
 # dependencies recorded in the .*.cmd file.
-ifdef CONFIG_LTO_CLANG
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 quiet_cmd_link_multi-m = AR [M]  $@
 cmd_link_multi-m =						\
 	$(cmd_update_lto_symversions);				\
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 79be57f..8bfc923 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -230,11 +230,11 @@ dtc_cpp_flags  = -Wp,-MMD,$(depfile).pre.tmp -nostdinc                    \
 		 $(addprefix -I,$(DTC_INCLUDE))                          \
 		 -undef -D__DTS__
 
-ifeq ($(CONFIG_LTO_CLANG),y)
+ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 # With CONFIG_LTO_CLANG, .o files in modules might be LLVM bitcode, so we
 # need to run LTO to compile them into native code (.lto.o) before further
 # processing.
-mod-prelink-ext := .lto
+mod-prelink-ext := .prelink
 endif
 
 # Useful for describing the dependency of composite objects
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6bfa332..09c3ab0 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1989,9 +1989,9 @@ static char *remove_dot(char *s)
 		if (m && (s[n + m] == '.' || s[n + m] == 0))
 			s[n] = 0;
 
-		/* strip trailing .lto */
-		if (strends(s, ".lto"))
-			s[strlen(s) - 4] = '\0';
+		/* strip trailing .prelink */
+		if (strends(s, ".prelink"))
+			s[strlen(s) - 8] = '\0';
 	}
 	return s;
 }
@@ -2015,9 +2015,9 @@ static void read_symbols(const char *modname)
 		/* strip trailing .o */
 		tmp = NOFAIL(strdup(modname));
 		tmp[strlen(tmp) - 2] = '\0';
-		/* strip trailing .lto */
-		if (strends(tmp, ".lto"))
-			tmp[strlen(tmp) - 4] = '\0';
+		/* strip trailing .prelink */
+		if (strends(tmp, ".prelink"))
+			tmp[strlen(tmp) - 8] = '\0';
 		mod = new_module(tmp);
 		free(tmp);
 	}
