Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EDA5AB975
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiIBU0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiIBU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:26:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CD16BD47
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tzbu7sLuKXzdICR1gMr0lrJCZCH1MKqo5IZYOohdmUo=; b=Thlrue0+8MvOnBs97u1tOohoeS
        RAzAWHs2tMyYgV2OlNxwwX9EDl/1YO45k4sCEw8gzjBxYqbKM/oDxjJilee8qSjVvNpyUFHJ7CpFi
        GalFKbLzsjuqf5w4yLHcxp15LZthl7HQBsRVs/r8uNVKgVZ98k7qQlXdMVFH0ojVzWkjddlEVpnh9
        G41jXgfO7hNxlxI93H0KfwtW7KdxjJC4roEpBiSOHM9dy/87NvL2Hi6S8oybY6rsSWpKGwneClECv
        ISgm42NI2yJWN7qgbGaCTG9xvbnqih3lLSju5EiufG3CwCj8WK+NsQ7qqzPs/D+g9SOkQqjSTjwrK
        xRLUqGwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oUDDD-008kpg-6A; Fri, 02 Sep 2022 20:24:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A6F4E300244;
        Fri,  2 Sep 2022 22:24:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8B4F82B907AB4; Fri,  2 Sep 2022 22:24:20 +0200 (CEST)
Date:   Fri, 2 Sep 2022 22:24:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 37/59] x86/putuser: Provide room for padding
Message-ID: <YxJmdG9Ug7euJdZS@hirez.programming.kicks-ass.net>
References: <20220902130625.217071627@infradead.org>
 <20220902130950.205726504@infradead.org>
 <CAHk-=wig7_=CpkvZXrbcM97pBGk5MCbVkA0yBGP2moiho-XS_Q@mail.gmail.com>
 <YxI3Zf5drSHAkBL3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxI3Zf5drSHAkBL3@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 07:03:33PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 02, 2022 at 09:43:45AM -0700, Linus Torvalds wrote:
> > So I don't hate this patch and it's probably good for consistency, but
> > I really think that the retbleed tracking could perhaps be improved to
> > let this be all unnecessary.
> > 
> > The whole return stack depth counting is already not 100% exact, and I
> > think we could just make the rule be that we don't track leaf
> > functions.
> > 
> > Why? It's just a off-by-one in the already not exact tracking. And -
> > perhaps equally importantly - leaf functions are very very common
> > dynamically, and I suspect it's trivial to see them.
> > 
> > Yes, yes, you could make objtool even smarter and actually do some
> > kind of function flow graph thing (and I think some people were
> > talking about that with the whole ret counting long long ago), but the
> > leaf function thing is the really simple low-hanging fruit case of
> > that.
> 
> So I did the leaf thing a few weeks ago, and at the time the perf gains
> where not worth the complexity.
> 
> I can try again :-)

The below (mashup of a handful of patches) is the best I could come up
with in a hurry.

Specifically, the approach taken is that instead of the 10 byte sarq for
accounting a leaf has a 10 byte NOP in front of it. When this 'leaf'-nop
is found, the return thunk is also not used and a regular 'ret'
instruction is patched in.

Direct calls to leaf functions are unmodified; they still go to +0.

However, indirect call will unconditionally jump to -10. These will then
either hit the sarq or the fancy nop

Seems to boot in kvm (defconfig+kvm_guest.config)

That is; the thing you complained about isn't actually 'fixed', leaf
functions still need their padding.

If this patch makes you feel warm and fuzzy, I can clean it up,
otherwise I would suggest getting the stuff we have merged before adding
even more things on top.

I'll see if I get time to clean up the alignment thing this weekend,
otherwise it'll have to wait till next week or so.

---
 arch/x86/include/asm/alternative.h  |    7 ++
 arch/x86/kernel/alternative.c       |   11 ++++
 arch/x86/kernel/callthunks.c        |   51 +++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c          |    2 
 arch/x86/kernel/module.c            |    8 ++-
 arch/x86/kernel/vmlinux.lds.S       |    7 ++
 arch/x86/lib/retpoline.S            |   11 +---
 tools/objtool/check.c               |   95 ++++++++++++++++++++++++++++++++++++
 tools/objtool/include/objtool/elf.h |    2 
 9 files changed, 186 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -94,6 +94,8 @@ extern void callthunks_patch_module_call
 extern void *callthunks_translate_call_dest(void *dest);
 extern bool is_callthunk(void *addr);
 extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
+extern void apply_leafs(s32 *start, s32 *end);
+extern bool is_leaf_function(void *addr);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -112,6 +114,11 @@ static __always_inline int x86_call_dept
 {
 	return 0;
 }
+static __always_inline void apply_leafs(s32 *start, s32 *end) {}
+static __always_inline bool is_leaf_function(void *addr)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_SMP
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -114,6 +114,7 @@ static void __init_or_module add_nops(vo
 	}
 }
 
+extern s32 __leaf_sites[], __leaf_sites_end[];
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern s32 __return_sites[], __return_sites_end[];
 extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
@@ -586,9 +587,14 @@ static int patch_return(void *addr, stru
 		if (x86_return_thunk == __x86_return_thunk)
 			return -1;
 
+		if (x86_return_thunk == __x86_return_skl &&
+		    is_leaf_function(addr))
+			goto plain_ret;
+
 		i = JMP32_INSN_SIZE;
 		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
 	} else {
+plain_ret:
 		bytes[i++] = RET_INSN_OPCODE;
 	}
 
@@ -988,6 +994,11 @@ void __init alternative_instructions(voi
 	apply_paravirt(__parainstructions, __parainstructions_end);
 
 	/*
+	 * Mark the leaf sites; this affects apply_returns() and callthunks_patch*().
+	 */
+	apply_leafs(__leaf_sites, __leaf_sites_end);
+
+	/*
 	 * Rewrite the retpolines, must be done before alternatives since
 	 * those can rewrite the retpoline thunks.
 	 */
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -181,6 +181,54 @@ static const u8 nops[] = {
 	0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90, 0x90,
 };
 
+/*
+ * 10 byte nop that spells 'leaf' in the immediate.
+ */
+static const u8 leaf_nop[] = {            /* 'l',  'e',  'a',  'f' */
+	0x2e, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x6c, 0x65, 0x61, 0x66,
+};
+
+void __init_or_module noinline apply_leafs(s32 *start, s32 *end)
+{
+	u8 buffer[16];
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+
+		if (skip_addr(addr))
+			continue;
+
+		if (copy_from_kernel_nofault(buffer, addr-10, 10))
+			continue;
+
+		/* already patched */
+		if (!memcmp(buffer, leaf_nop, 10))
+			continue;
+
+		if (memcmp(buffer, nops, 10)) {
+			pr_warn("Not NOPs: %pS %px %*ph\n", addr, addr, 10, addr);
+			continue;
+		}
+
+		text_poke_early(addr-10, leaf_nop, 10);
+	}
+}
+
+bool is_leaf_function(void *addr)
+{
+	unsigned long size, offset;
+	u8 buffer[10];
+
+	if (kallsyms_lookup_size_offset((unsigned long)addr, &size, &offset))
+		addr -= offset;
+
+	if (copy_from_kernel_nofault(buffer, addr-10, 10))
+		return false;
+
+	return memcmp(buffer, leaf_nop, 10) == 0;
+}
+
 static __init_or_module void *patch_dest(void *dest, bool direct)
 {
 	unsigned int tsize = SKL_TMPL_SIZE;
@@ -190,6 +238,9 @@ static __init_or_module void *patch_dest
 	if (!bcmp(pad, skl_call_thunk_template, tsize))
 		return pad;
 
+	if (!bcmp(pad, leaf_nop, tsize))
+		return dest;
+
 	/* Ensure there are nops */
 	if (bcmp(pad, nops, tsize)) {
 		pr_warn_once("Invalid padding area for %pS\n", dest);
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -838,6 +838,8 @@ static int __init retbleed_parse_cmdline
 			retbleed_cmd = RETBLEED_CMD_STUFF;
 		} else if (!strcmp(str, "nosmt")) {
 			retbleed_nosmt = true;
+		} else if (!strcmp(str, "force")) {
+			setup_force_cpu_bug(X86_BUG_RETBLEED);
 		} else {
 			pr_err("Ignoring unknown retbleed option (%s).", str);
 		}
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -253,7 +253,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    struct module *me)
 {
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
-		*para = NULL, *orc = NULL, *orc_ip = NULL,
+		*para = NULL, *orc = NULL, *orc_ip = NULL, *leafs = NULL,
 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
 		*calls = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
@@ -271,6 +271,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			orc = s;
 		if (!strcmp(".orc_unwind_ip", secstrings + s->sh_name))
 			orc_ip = s;
+		if (!strcmp(".leaf_sites", secstrings + s->sh_name))
+			leafs = s;
 		if (!strcmp(".retpoline_sites", secstrings + s->sh_name))
 			retpolines = s;
 		if (!strcmp(".return_sites", secstrings + s->sh_name))
@@ -289,6 +291,10 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *pseg = (void *)para->sh_addr;
 		apply_paravirt(pseg, pseg + para->sh_size);
 	}
+	if (leafs) {
+		void *rseg = (void *)leafs->sh_addr;
+		apply_leafs(rseg, rseg + leafs->sh_size);
+	}
 	if (retpolines) {
 		void *rseg = (void *)retpolines->sh_addr;
 		apply_retpolines(rseg, rseg + retpolines->sh_size);
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -298,6 +298,13 @@ SECTIONS
 		*(.call_sites)
 		__call_sites_end = .;
 	}
+
+	. = ALIGN(8);
+	.leaf_sites : AT(ADDR(.leaf_sites) - LOAD_OFFSET) {
+		__leaf_sites = .;
+		*(.leaf_sites)
+		__leaf_sites_end = .;
+	}
 #endif
 
 #ifdef CONFIG_X86_KERNEL_IBT
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -77,9 +77,9 @@ SYM_CODE_END(__x86_indirect_thunk_array)
 SYM_INNER_LABEL(__x86_indirect_call_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR
-
-	CALL_DEPTH_ACCOUNT
-	POLINE \reg
+	sub	$10, %\reg
+	POLINE	\reg
+	add	$10, %\reg
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -216,10 +216,7 @@ SYM_FUNC_START(__x86_return_skl)
 1:
 	CALL_THUNKS_DEBUG_INC_STUFFS
 	.rept	16
-	ANNOTATE_INTRA_FUNCTION_CALL
-	call	2f
-	int3
-2:
+	__FILL_RETURN_SLOT
 	.endr
 	add	$(8*16), %rsp
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -945,6 +945,74 @@ static int create_direct_call_sections(s
 	return 0;
 }
 
+static int create_leaf_sites_sections(struct objtool_file *file)
+{
+	struct section *sec, *s;
+	struct symbol *sym;
+	unsigned int *loc;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".leaf_sites");
+	if (sec) {
+		INIT_LIST_HEAD(&file->call_list);
+		WARN("file already has .leaf_sites section, skipping");
+		return 0;
+	}
+
+	idx = 0;
+	for_each_sec(file, s) {
+		if (!s->text || s->init)
+			continue;
+
+		list_for_each_entry(sym, &s->symbol_list, list) {
+			if (sym->pfunc != sym)
+				continue;
+
+			if (sym->static_call_tramp)
+				continue;
+
+			if (!sym->leaf)
+				continue;
+
+			idx++;
+		}
+	}
+
+	sec = elf_create_section(file->elf, ".leaf_sites", 0, sizeof(unsigned int), idx);
+	if (!sec)
+		return -1;
+
+	idx = 0;
+	for_each_sec(file, s) {
+		if (!s->text || s->init)
+			continue;
+
+		list_for_each_entry(sym, &s->symbol_list, list) {
+			if (sym->pfunc != sym)
+				continue;
+
+			if (sym->static_call_tramp)
+				continue;
+
+			if (!sym->leaf)
+				continue;
+
+			loc = (unsigned int *)sec->data->d_buf + idx;
+			memset(loc, 0, sizeof(unsigned int));
+
+			if (elf_add_reloc_to_insn(file->elf, sec,
+						  idx * sizeof(unsigned int),
+						  R_X86_64_PC32,
+						  s, sym->offset))
+				return -1;
+
+			idx++;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -2362,6 +2430,9 @@ static int classify_symbols(struct objto
 			if (!strcmp(func->name, "__fentry__"))
 				func->fentry = true;
 
+			if (!strcmp(func->name, "__stack_chk_fail"))
+				func->stack_chk = true;
+
 			if (is_profiling_func(func->name))
 				func->profiling_func = true;
 		}
@@ -2492,6 +2563,16 @@ static bool is_fentry_call(struct instru
 	return false;
 }
 
+static bool is_stack_chk_call(struct instruction *insn)
+{
+	if (insn->type == INSN_CALL &&
+	    insn->call_dest &&
+	    insn->call_dest->stack_chk)
+		return true;
+
+	return false;
+}
+
 static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
 {
 	struct cfi_state *cfi = &state->cfi;
@@ -3269,6 +3350,9 @@ static int validate_call(struct objtool_
 			 struct instruction *insn,
 			 struct insn_state *state)
 {
+	if (insn->func && !is_fentry_call(insn) && !is_stack_chk_call(insn))
+		insn->func->leaf = 0;
+
 	if (state->noinstr && state->instr <= 0 &&
 	    !noinstr_call_dest(file, insn, insn->call_dest)) {
 		WARN_FUNC("call to %s() leaves .noinstr.text section",
@@ -3973,6 +4057,12 @@ static int validate_section(struct objto
 		init_insn_state(file, &state, sec);
 		set_func_state(&state.cfi);
 
+		/*
+		 * Asumme it is a leaf function; will be cleared for any CALL
+		 * encountered while validating the branches.
+		 */
+		func->leaf = 1;
+
 		warnings += validate_symbol(file, sec, func, &state);
 	}
 
@@ -4358,6 +4448,11 @@ int check(struct objtool_file *file)
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+
+		ret = create_leaf_sites_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (opts.rethunk) {
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -61,6 +61,8 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
+	u8 leaf	             : 1;
+	u8 stack_chk         : 1;
 	struct list_head pv_target;
 };
 
