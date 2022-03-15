Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5DF4D990F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347239AbiCOKpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbiCOKox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:44:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028002AE1C;
        Tue, 15 Mar 2022 03:43:40 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Om1JKH0+6RvJ+rw9H/XlBF9MD0/hqzkEno6Hv5zznAQ=;
        b=2jNqrNwHc+P9ZO2QRroZ1uaoBLkxGrvO249uOUxHx/zEci/vwJ+e6rIgI6ENaj39jtz2O0
        qscZM2Nkcl63dl+9wHCXloz/QIz6VXBl2IxxswoFNbxMnB1QIg6FcBEcmbKgMndJbopVUC
        FtJnlJX2ri26NdakgpXKW49PMnMzroFLxF8eDQFHHklbblhRpy1La2A6OzhyZ9XXpKWjpz
        7HKS2+Qui2WwTYR4WxU+vBcqiYzn3U+krwI4hDxwl+zN5+n7t4W8jxJ8J4FME5xM725Xy7
        ouwlu1qhxi+VyMQ1XnDk5SBss5FEE57tdQx3gtCLKQiFsh7ePqNNFxFCwBThHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Om1JKH0+6RvJ+rw9H/XlBF9MD0/hqzkEno6Hv5zznAQ=;
        b=NQJ8AenmbWgY/xucSVWKIrprxK4fR0dfpKAJId9yvp6DWHhrbw75jRqpuVNqLi7jzxRahA
        YwfPxJdRycJGskAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternative: Use .ibt_endbr_seal to seal indirect calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.822545231@infradead.org>
References: <20220308154319.822545231@infradead.org>
MIME-Version: 1.0
Message-ID: <164734101837.16921.16410924193202609763.tip-bot2@tip-bot2>
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

Commit-ID:     ed53a0d971926e484d86cce617ec02a7ee85c3fe
Gitweb:        https://git.kernel.org/tip/ed53a0d971926e484d86cce617ec02a7ee85c3fe
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:47 +01:00

x86/alternative: Use .ibt_endbr_seal to seal indirect calls

Objtool's --ibt option generates .ibt_endbr_seal which lists
superfluous ENDBR instructions. That is those instructions for which
the function is never indirectly called.

Overwrite these ENDBR instructions with a NOP4 such that these
function can never be indirect called, reducing the number of viable
ENDBR targets in the kernel.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.822545231@infradead.org
---
 arch/um/kernel/um_arch.c           |  4 ++-
 arch/x86/Kconfig                   |  9 +++++-
 arch/x86/include/asm/alternative.h |  1 +-
 arch/x86/include/asm/ibt.h         | 12 +++++++-
 arch/x86/kernel/alternative.c      | 39 ++++++++++++++++++++++++-
 arch/x86/kernel/module.c           |  8 ++++-
 scripts/Makefile.build             | 47 +++++++++++++++++++++++------
 scripts/link-vmlinux.sh            | 10 ++++--
 8 files changed, 117 insertions(+), 13 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index abceeab..0760e24 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -424,6 +424,10 @@ void __init check_bugs(void)
 	os_check_bugs();
 }
 
+void apply_ibt_endbr(s32 *start, s32 *end)
+{
+}
+
 void apply_retpolines(s32 *start, s32 *end)
 {
 }
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 19d16c0..870e0d1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1873,7 +1873,7 @@ config CC_HAS_IBT
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
 	bool
-	depends on X86_64 && CC_HAS_IBT
+	depends on X86_64 && CC_HAS_IBT && STACK_VALIDATION
 	help
 	  Build the kernel with support for Indirect Branch Tracking, a
 	  hardware support course-grain forward-edge Control Flow Integrity
@@ -1881,6 +1881,13 @@ config X86_KERNEL_IBT
 	  an ENDBR instruction, as such, the compiler will instrument the
 	  code with them to make this happen.
 
+	  In addition to building the kernel with IBT, seal all functions that
+	  are not indirect call targets, avoiding them ever becomming one.
+
+	  This requires LTO like objtool runs and will slow down the build. It
+	  does significantly reduce the number of ENDBR instructions in the
+	  kernel image.
+
 config X86_INTEL_MEMORY_PROTECTION_KEYS
 	prompt "Memory Protection Keys"
 	def_bool y
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 58eee64..9b10c8c 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -76,6 +76,7 @@ extern int alternatives_patched;
 extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 extern void apply_retpolines(s32 *start, s32 *end);
+extern void apply_ibt_endbr(s32 *start, s32 *end);
 
 struct module;
 
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 52fb05d..689880e 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -46,8 +46,20 @@ static inline __attribute_const__ u32 gen_endbr(void)
 	return endbr;
 }
 
+static inline __attribute_const__ u32 gen_endbr_poison(void)
+{
+	/*
+	 * 4 byte NOP that isn't NOP4 (in fact it is OSP NOP3), such that it
+	 * will be unique to (former) ENDBR sites.
+	 */
+	return 0x001f0f66; /* osp nopl (%rax) */
+}
+
 static inline bool is_endbr(u32 val)
 {
+	if (val == gen_endbr_poison())
+		return true;
+
 	val &= ~0x01000000U; /* ENDBR32 -> ENDBR64 */
 	return val == gen_endbr();
 }
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 954d39c..a79196f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -115,6 +115,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 }
 
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
+extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
@@ -512,6 +513,42 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
 
 #endif /* CONFIG_RETPOLINE && CONFIG_STACK_VALIDATION */
 
+#ifdef CONFIG_X86_KERNEL_IBT
+
+/*
+ * Generated by: objtool --ibt
+ */
+void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		u32 endbr, poison = gen_endbr_poison();
+		void *addr = (void *)s + *s;
+
+		if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
+			continue;
+
+		if (WARN_ON_ONCE(!is_endbr(endbr)))
+			continue;
+
+		DPRINTK("ENDBR at: %pS (%px)", addr, addr);
+
+		/*
+		 * When we have IBT, the lack of ENDBR will trigger #CP
+		 */
+		DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
+		DUMP_BYTES(((u8*)&poison), 4, "%px: repl: ", addr);
+		text_poke_early(addr, &poison, 4);
+	}
+}
+
+#else
+
+void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
+
+#endif /* CONFIG_X86_KERNEL_IBT */
+
 #ifdef CONFIG_SMP
 static void alternatives_smp_lock(const s32 *start, const s32 *end,
 				  u8 *text, u8 *text_end)
@@ -830,6 +867,8 @@ void __init alternative_instructions(void)
 	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
+	apply_ibt_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
+
 #ifdef CONFIG_SMP
 	/* Patch to UP if other cpus not imminent. */
 	if (!noreplace_smp && (num_present_cpus() == 1 || setup_max_cpus <= 1)) {
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 96d7c27..58bafbd 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -253,7 +253,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 {
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
 		*para = NULL, *orc = NULL, *orc_ip = NULL,
-		*retpolines = NULL;
+		*retpolines = NULL, *ibt_endbr = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -271,6 +271,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			orc_ip = s;
 		if (!strcmp(".retpoline_sites", secstrings + s->sh_name))
 			retpolines = s;
+		if (!strcmp(".ibt_endbr_seal", secstrings + s->sh_name))
+			ibt_endbr = s;
 	}
 
 	/*
@@ -290,6 +292,10 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
+	if (ibt_endbr) {
+		void *iseg = (void *)ibt_endbr->sh_addr;
+		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);
+	}
 	if (locks && text) {
 		void *lseg = (void *)locks->sh_addr;
 		void *tseg = (void *)text->sh_addr;
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a4b89b7..926d254 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -86,12 +86,18 @@ ifdef need-builtin
 targets-for-builtin += $(obj)/built-in.a
 endif
 
-targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
+targets-for-modules :=
 
 ifdef CONFIG_LTO_CLANG
 targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
 endif
 
+ifdef CONFIG_X86_KERNEL_IBT
+targets-for-modules += $(patsubst %.o, %.objtool, $(filter %.o, $(obj-m)))
+endif
+
+targets-for-modules += $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
+
 ifdef need-modorder
 targets-for-modules += $(obj)/modules.order
 endif
@@ -230,6 +236,7 @@ objtool := $(objtree)/tools/objtool/objtool
 objtool_args =								\
 	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
 	$(if $(part-of-module), --module)				\
+	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
 	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
@@ -237,8 +244,8 @@ objtool_args =								\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_SLS), --sls)
 
-cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
-cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
+cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $(@:.objtool=.o))
+cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$(@:.objtool=.o): $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
 
 endif # CONFIG_STACK_VALIDATION
 
@@ -247,6 +254,21 @@ ifdef CONFIG_LTO_CLANG
 # Skip objtool for LLVM bitcode
 $(obj)/%.o: objtool-enabled :=
 
+# objtool was skipped for LLVM bitcode, run it now that we have compiled
+# modules into native code
+$(obj)/%.lto.o: objtool-enabled = y
+$(obj)/%.lto.o: part-of-module := y
+
+else ifdef CONFIG_X86_KERNEL_IBT
+
+# Skip objtool on individual files
+$(obj)/%.o: objtool-enabled :=
+
+# instead run objtool on the module as a whole, right before
+# the final link pass with the linker script.
+$(obj)/%.objtool: objtool-enabled = y
+$(obj)/%.objtool: part-of-module := y
+
 else
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
@@ -292,18 +314,13 @@ ifdef CONFIG_LTO_CLANG
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
 
-# objtool was skipped for LLVM bitcode, run it now that we have compiled
-# modules into native code
-$(obj)/%.lto.o: objtool-enabled = y
-$(obj)/%.lto.o: part-of-module := y
-
 $(obj)/%.lto.o: $(obj)/%.o FORCE
 	$(call if_changed,cc_lto_link_modules)
 endif
@@ -316,6 +333,18 @@ cmd_mod = { \
 $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
 	$(call if_changed,mod)
 
+#
+# Since objtool will re-write the file it will change the timestamps, therefore
+# it is critical that the %.objtool file gets a timestamp *after* objtool runs.
+#
+# Additionally, care must be had with ordering this rule against the other rules
+# that take %.o as a dependency.
+#
+cmd_objtool_mod = true $(cmd_objtool) ; touch $@
+
+$(obj)/%.objtool: $(obj)/%$(mod-prelink-ext).o FORCE
+	$(call if_changed,objtool_mod)
+
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
 		     $(CONFIG_SHELL) $(srctree)/scripts/makelst $*.o \
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 9b08dca..f704034 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -108,7 +108,9 @@ objtool_link()
 	local objtoolcmd;
 	local objtoolopt;
 
-	if is_enabled CONFIG_LTO_CLANG && is_enabled CONFIG_STACK_VALIDATION; then
+	if is_enabled CONFIG_STACK_VALIDATION && \
+	   ( is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT ); then
+
 		# Don't perform vmlinux validation unless explicitly requested,
 		# but run objtool on vmlinux.o now that we have an object file.
 		if is_enabled CONFIG_UNWINDER_ORC; then
@@ -117,6 +119,10 @@ objtool_link()
 
 		objtoolopt="${objtoolopt} --lto"
 
+		if is_enabled CONFIG_X86_KERNEL_IBT; then
+			objtoolopt="${objtoolopt} --ibt"
+		fi
+
 		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
 			objtoolopt="${objtoolopt} --mcount"
 		fi
@@ -168,7 +174,7 @@ vmlinux_link()
 	# skip output file argument
 	shift
 
-	if is_enabled CONFIG_LTO_CLANG; then
+	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
 		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=vmlinux.o
 		libs=
