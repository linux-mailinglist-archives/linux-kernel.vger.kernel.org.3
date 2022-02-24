Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD544C2F69
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiBXPVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiBXPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7500141FDA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vU/JlGNHp8GCqgCQ71KHWmHbP9bCapQE4pQfEdmKjA4=; b=hDdgy4ozhi42VFJ1jqkAF1EVzW
        KH9xx4biKAlUJhKZul2fXPhsyuLNUOv6UQLQposoemrpFQEqE67kN/KCQj13Ut9VbsAc3ZS757V6n
        cmOZace6uHiNPUdmmU/wHpspIi78ov2k3td9aTjXEHmEIyfd1WL89LXs5AN9l/yeJADqwJ9/P0Fh4
        V0PbpREtzbEmK3uTWHr4yGedqDZVqqMGgoNWZGCYPCQ9/4cJWbGPW02fK1YBUY2DdFLQJ5T3VrgrD
        Aj+Q2bZ4Djm/ueuk7oO1OxFUntOR6EPwlFjZFU9dzynhgJFbJ1ACbmxIYa67WUJLWs2ut71E7QyuJ
        MRejsxVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs4-00CeM7-JX; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53090302DA3;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BE3152B3547B5; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151324.314888369@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 39/39] x86/alternative: Use .ibt_endbr_sites to seal indirect calls
References: <20220224145138.952963315@infradead.org>
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

Objtool's --ibt-seal option generates .ibt_endbr_sites which lists
superfluous ENDBR instructions. That is those instructions for which
the function is never indirectly called.

Additionally, objtool's --ibt-fix-direct ensures direct calls never
target an ENDBR instruction.

Combined this yields that these instructions should never be executed.

Poison them using a 4 byte UD1 instruction; for IBT hardware this will
raise an #CP exception due to WAIT-FOR-ENDBR not getting what it
wants. For !IBT hardware it'll trigger #UD.

In either case, it will be 'impossible' to indirectly call these
functions thereafter.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/um/kernel/um_arch.c           |    4 +++
 arch/x86/Kconfig                   |   12 +++++++++
 arch/x86/include/asm/alternative.h |    1 
 arch/x86/include/asm/ibt.h         |    8 ++++++
 arch/x86/kernel/alternative.c      |   41 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/module.c           |   10 ++++++--
 arch/x86/kernel/traps.c            |   45 +++++++++++++++++++++++++++++++------
 scripts/link-vmlinux.sh            |   10 ++++++--
 8 files changed, 120 insertions(+), 11 deletions(-)

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
@@ -1878,6 +1878,18 @@ config X86_KERNEL_IBT
 	  an ENDBR instruction, as such, the compiler will litter the
 	  code with them to make this happen.
 
+config X86_KERNEL_IBT_SEAL
+	prompt "Seal functions"
+	def_bool y
+	depends on X86_KERNEL_IBT && STACK_VALIDATION
+	help
+	  In addition to building the kernel with IBT, seal all functions that
+	  are not indirect call targets, avoiding them ever becomming one.
+
+	  This requires LTO like objtool runs and will slow down the build. It
+	  does significantly reduce the number of ENDBR instructions in the
+	  kernel image as well as provide some validation for !IBT hardware.
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
@@ -31,8 +31,16 @@ static inline __attribute_const__ unsign
 	return endbr;
 }
 
+static inline unsigned int gen_endbr_poison(void)
+{
+	return 0x0040b90f; /* ud1 0x0(%eax), %eax */
+}
+
 static inline bool is_endbr(unsigned int val)
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
+extern s32 __ibt_endbr_sites[], __ibt_endbr_sites_end[];
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
@@ -512,6 +513,44 @@ void __init_or_module noinline apply_ret
 
 #endif /* CONFIG_RETPOLINE && CONFIG_STACK_VALIDATION */
 
+#ifdef CONFIG_X86_KERNEL_IBT_SEAL
+
+/*
+ * Generated by: objtool --ibt-seal
+ */
+void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		u32 ud1 = gen_endbr_poison();
+		u32 endbr;
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
+		 * When we don't have IBT, explicitly trigger #UD
+		 */
+		DUMP_BYTES(((u8*)addr), 4, "%px: orig: ", addr);
+		DUMP_BYTES(((u8*)&ud1), 4, "%px: repl: ", addr);
+		text_poke_early(addr, &ud1, 4);
+	}
+}
+
+#else
+
+void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end) { }
+
+#endif /* CONFIG_X86_KERNEL_IBT_SEAL */
+
 #ifdef CONFIG_SMP
 static void alternatives_smp_lock(const s32 *start, const s32 *end,
 				  u8 *text, u8 *text_end)
@@ -833,6 +872,8 @@ void __init alternative_instructions(voi
 	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
+	apply_ibt_endbr(__ibt_endbr_sites, __ibt_endbr_sites_end);
+
 #ifdef CONFIG_SMP
 	/* Patch to UP if other cpus not imminent. */
 	if (!noreplace_smp && (num_present_cpus() == 1 || setup_max_cpus <= 1)) {
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -132,7 +132,7 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 
 static inline void ibt_fix_direct(void *loc, u64 *val)
 {
-#ifdef CONFIG_X86_KERNEL_IBT
+#ifdef CONFIG_X86_KERNEL_IBT_SEAL
 	const void *addr = (void *)(4 + *val);
 	union text_poke_insn text;
 	u32 insn;
@@ -287,7 +287,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 {
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
 		*para = NULL, *orc = NULL, *orc_ip = NULL,
-		*retpolines = NULL;
+		*retpolines = NULL, *ibt_endbr = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -305,6 +305,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			orc_ip = s;
 		if (!strcmp(".retpoline_sites", secstrings + s->sh_name))
 			retpolines = s;
+		if (!strcmp(".ibt_endbr_sites", secstrings + s->sh_name))
+			ibt_endbr = s;
 	}
 
 	/*
@@ -324,6 +326,10 @@ int module_finalize(const Elf_Ehdr *hdr,
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
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -214,6 +214,17 @@ DEFINE_IDTENTRY(exc_overflow)
 
 static __ro_after_init bool ibt_fatal = true;
 
+static void handle_endbr(struct pt_regs *regs)
+{
+	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
+	if (!ibt_fatal) {
+		printk(KERN_DEFAULT CUT_HERE);
+		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+		return;
+	}
+	BUG();
+}
+
 extern const unsigned long ibt_selftest_ip; /* defined in asm beow */
 
 DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
@@ -231,13 +242,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_pr
 		return;
 	}
 
-	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
-	if (!ibt_fatal) {
-		printk(KERN_DEFAULT CUT_HERE);
-		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
-		return;
-	}
-	BUG();
+	handle_endbr(regs);
 }
 
 bool ibt_selftest(void)
@@ -278,6 +283,29 @@ static int __init ibt_setup(char *str)
 
 __setup("ibt=", ibt_setup);
 
+static bool handle_ud1_endbr(struct pt_regs *regs)
+{
+	u32 ud1;
+
+	if (get_kernel_nofault(ud1, (u32 *)regs->ip))
+		return false;
+
+	if (ud1 == gen_endbr_poison()) {
+		handle_endbr(regs);
+		regs->ip += 4;
+		return true;
+	}
+
+	return false;
+}
+
+#else /* CONFIG_X86_KERNEL_IBT */
+
+static bool handle_ud1_endbr(struct pt_regs *regs)
+{
+	return false;
+}
+
 #endif /* CONFIG_X86_KERNEL_IBT */
 
 #ifdef CONFIG_X86_F00F_BUG
@@ -286,6 +314,9 @@ void handle_invalid_op(struct pt_regs *r
 static inline void handle_invalid_op(struct pt_regs *regs)
 #endif
 {
+	if (!user_mode(regs) && handle_ud1_endbr(regs))
+		return;
+
 	do_error_trap(regs, 0, "invalid opcode", X86_TRAP_UD, SIGILL,
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -108,7 +108,9 @@ objtool_link()
 	local objtoolcmd;
 	local objtoolopt;
 
-	if is_enabled CONFIG_LTO_CLANG && is_enabled CONFIG_STACK_VALIDATION; then
+	if is_enabled CONFIG_STACK_VALIDATION && \
+	   ( is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT_SEAL ); then
+
 		# Don't perform vmlinux validation unless explicitly requested,
 		# but run objtool on vmlinux.o now that we have an object file.
 		if is_enabled CONFIG_UNWINDER_ORC; then
@@ -117,6 +119,10 @@ objtool_link()
 
 		objtoolopt="${objtoolopt} --lto"
 
+		if is_enabled CONFIG_X86_KERNEL_IBT_SEAL; then
+			objtoolopt="${objtoolopt} --ibt --ibt-fix-direct --ibt-seal"
+		fi
+
 		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
 			objtoolopt="${objtoolopt} --mcount"
 		fi
@@ -168,7 +174,7 @@ vmlinux_link()
 	# skip output file argument
 	shift
 
-	if is_enabled CONFIG_LTO_CLANG; then
+	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT_SEAL; then
 		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=vmlinux.o
 		libs=


