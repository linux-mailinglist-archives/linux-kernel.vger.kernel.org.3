Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF04CBCA5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiCCLde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiCCLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1863417CC64
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=I7p5+DYH8U1arII34U/+6lMMFXCLX9VK6R9WBVZqDzA=; b=NAE2hiZvJrpCacNnq7HGcIChS7
        /U6GO7HHCgOWLyYhDSsDqfZjlHBb0y2v0nQjiD4EvUHJR4wr0CUZFUrOcM997z3Ve+ubD3g8aEkea
        bfsnhTZ+yXM27myY2hF5qEAaGf3p5T7iawFQojLhl7FRAKm7D9rzyBtpmLsWhK38LXZBi1tPIdxHt
        n8EoaIHPrTbvoboaCKErCIg1yMym9jWM8QKtTkzvIMMqucmJJYqmhgxCZ5rm/8WqOTFQZdq/sMy7d
        b0kdVqf4aQa3NXomjR/VjF/UK81/GBmbqHoTm8APkvG964wN5y41HPPcil4TjWhGAn7ukhjaAQR69
        UKB/0Fag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjei-00Etpu-4t; Thu, 03 Mar 2022 11:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1675B302DD7;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B57DE3012BCF1; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112827.344422816@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:24:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 39/39] x86/alternative: Use .ibt_endbr_seal to seal indirect calls
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

Objtool's --ibt option generates .ibt_endbr_seal which lists
superfluous ENDBR instructions. That is those instructions for which
the function is never indirectly called.

Overwrite these ENDBR instructions with a NOP4 such that these
function can never be indirect called, reducing the number of viable
ENDBR targets in the kernel.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/um/kernel/um_arch.c           |    4 +++
 arch/x86/Kconfig                   |    9 +++++++-
 arch/x86/include/asm/alternative.h |    1 
 arch/x86/include/asm/ibt.h         |   12 +++++++++++
 arch/x86/kernel/alternative.c      |   39 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/module.c           |    8 ++++++-
 scripts/Makefile.lib               |   11 ++++++++++
 scripts/link-vmlinux.sh            |   10 +++++++--
 8 files changed, 90 insertions(+), 4 deletions(-)

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
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -76,6 +76,7 @@ extern int alternatives_patched;
 extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 extern void apply_retpolines(s32 *start, s32 *end);
+extern void apply_ibt_endbr(s32 *start, s32 *end);
 
 struct module;
 
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -33,8 +33,20 @@ static inline __attribute_const__ u32 ge
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
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -115,6 +115,7 @@ static void __init_or_module add_nops(vo
 }
 
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
+extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
@@ -512,6 +513,42 @@ void __init_or_module noinline apply_ret
 
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
@@ -833,6 +870,8 @@ void __init alternative_instructions(voi
 	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
+	apply_ibt_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
+
 #ifdef CONFIG_SMP
 	/* Patch to UP if other cpus not imminent. */
 	if (!noreplace_smp && (num_present_cpus() == 1 || setup_max_cpus <= 1)) {
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
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -544,6 +544,7 @@ objtool := $(objtree)/tools/objtool/objt
 objtool_args =								\
 	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
 	$(if $(part-of-module), --module)				\
+	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)	                \
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
 	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
@@ -567,6 +568,16 @@ $(obj)/%.o: objtool-enabled :=
 $(obj)/%.lto.o: objtool-enabled = y
 $(obj)/%.lto.o: part-of-module := y
 
+else ifdef CONFIG_X86_KERNEL_IBT
+
+# Skip objtool on individual files
+$(obj)/%.o: objtool-enabled :=
+
+# instead run objtool on the module as a whole, right before
+# the final link pass with the linker script.
+%.ko: objtool-enabled = y
+%.ko: part-of-module := y
+
 else
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
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


