Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06444CBCBA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiCCLeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbiCCLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC6417C42B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=uY+jcOMFirwczJeMx5tMsqeYilw19841F6sj97KYysQ=; b=E8DVBWUDuzvs8okL6i3DcaFwSn
        Kt1RTWOQ4rys5T/zCvGCJUzzJVACYa9wRtYUMEEo/LM6hWdr2hFGEWiE/DgiYicpsM6r84ZY+/Jr7
        K4Ii6QxjhcwELMlfBrjT3vJtpQecM8f+VAH6iTlZy4EYiLEBCCbSPAWBbtvLmCKkYj09JNYZx3NR2
        rn4RO//xaQlvRho4LUz19j4+lY+f8fwQ7mh90FQ1mqFom++80i4Unj/uhmqxfg9bIJICq34Yd9NAl
        9VUUWsMsSfzYhhoG/xxnO3MFyF7jJKZkQiNGDv5lJA995kfsaA7hmwWaSUU/8GXiifl9IMccWQ2pg
        GvIu8/XQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjei-00Etpq-0C; Thu, 03 Mar 2022 11:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0FC8F302DBC;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 97E1730129AEA; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112826.908513999@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 32/39] Kbuild: Allow whole module objtool runs
References: <20220303112321.422525803@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like we have vmlinux.o objtool runs, add the ability to do whole
module objtool runs.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/Makefile.build    |   44 ++------------------------------------------
 scripts/Makefile.lib      |   45 +++++++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.modfinal |    1 +
 3 files changed, 48 insertions(+), 42 deletions(-)

--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -223,41 +223,6 @@ cmd_record_mcount = $(if $(findstring $(
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
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -32,6 +32,7 @@ ARCH_POSTLINK := $(wildcard $(srctree)/a
 
 quiet_cmd_ld_ko_o = LD [M]  $@
       cmd_ld_ko_o +=							\
+	$(cmd_objtool_mod)						\
 	$(LD) -r $(KBUILD_LDFLAGS)					\
 		$(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)		\
 		-T scripts/module.lds -o $@ $(filter %.o, $^);		\


