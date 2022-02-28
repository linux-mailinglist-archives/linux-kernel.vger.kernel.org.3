Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74B24C7E42
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiB1X03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiB1X02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:26:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A7AC3311
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fCfuRH4s50AAt2MwUz3kzZenb4+CLJUMfZe9pE/B82w=; b=N545VQlozc98xk9T4Q5E0pyMm0
        BQcqTY9UVW5NUE8VxaW4ogSd4Yn1X2nqQqopTxs/lJlm1G0hDebmGPb08nlH/mHfFOwegLmWJhzeN
        t3wfF59eEXaBT439ypD5Nm9GExWLcTpO91yNjHr/93IRWsPyv2XoDFEr7+7QNa+4j0qkTLAd/2kOJ
        WbjxF2QSDROvWfCMLJ6lD2gkJ5Ks8xjmubX142CPs7do+lKmw+YRPAKr5zZEP1nGRvzstE34Q6kzp
        J9mOa3xaO+ZYymb7V4HLrZ9enNu6Ikq5lTyDFufyAZ6lnoSnHKthJfhOM6r5GJnhY2rFmB+1bLpHa
        wwCLrLpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOpOF-0090aY-Fj; Mon, 28 Feb 2022 23:25:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACFAA986271; Tue,  1 Mar 2022 00:25:13 +0100 (CET)
Date:   Tue, 1 Mar 2022 00:25:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <20220228232513.GH11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
 <20220228150705.aab2d654b973109bab070ffe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228150705.aab2d654b973109bab070ffe@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 03:07:05PM +0900, Masami Hiramatsu wrote:
> Hi Peter,
> 
> So, instead of this change, can you try below?
> This introduce the arch_adjust_kprobe_addr() and use it in the kprobe_addr()
> so that it can handle the case that user passed the probe address in 
> _text+OFFSET format.

It works a little... at the very least it still needs
arch_kprobe_on_func_entry() allowing offset 4.

But looking at this, we've got:

kprobe_on_func_entry(addr, sym, offset)
  _kprobe_addr(addr, sym, offset)
    if (sym)
      addr = kprobe_lookup_name()
           = kallsyms_lookup_name()
    arch_adjust_kprobe_addr(addr+offset)
      skip_endbr()
        kallsyms_loopup_size_offset(addr, ...)
  kallsyms_lookup_size_offset(addr, NULL, &offset)
  arch_kprobe_on_func_entry(offset)

Which is _3_ kallsyms lookups and 3 weak/arch hooks.

Surely we can make this a little more streamlined? The below seems to
work.

I think with a little care and testing it should be possible to fold all
the magic of PowerPC's kprobe_lookup_name() into this one hook as well,
meaning we can get rid of kprobe_lookup_name() entirely.  Naveen?

This then gets us down to a 1 kallsyms call and 1 arch hook. Hmm?

---
 arch/powerpc/kernel/kprobes.c  |   34 +++++++++++++++---------
 arch/x86/kernel/kprobes/core.c |   17 ++++++++++++
 include/linux/kprobes.h        |    3 +-
 kernel/kprobes.c               |   56 ++++++++++++++++++++++++++++++++++-------
 4 files changed, 87 insertions(+), 23 deletions(-)

--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -105,6 +105,27 @@ kprobe_opcode_t *kprobe_lookup_name(cons
 	return addr;
 }
 
+static bool arch_kprobe_on_func_entry(unsigned long offset)
+{
+#ifdef PPC64_ELF_ABI_v2
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	return offset <= 16;
+#else
+	return offset <= 8;
+#endif
+#else
+	return !offset;
+#endif
+}
+
+/* XXX try and fold the magic of kprobe_lookup_name() in this */
+kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
+					 bool *on_func_entry)
+{
+	*on_func_entry = arch_kprobe_on_func_entry(offset);
+	return (kprobe_opcode_t *)(addr + offset);
+}
+
 void *alloc_insn_page(void)
 {
 	void *page;
@@ -218,19 +239,6 @@ static nokprobe_inline void set_current_
 	kcb->kprobe_saved_msr = regs->msr;
 }
 
-bool arch_kprobe_on_func_entry(unsigned long offset)
-{
-#ifdef PPC64_ELF_ABI_v2
-#ifdef CONFIG_KPROBES_ON_FTRACE
-	return offset <= 16;
-#else
-	return offset <= 8;
-#endif
-#else
-	return !offset;
-#endif
-}
-
 void arch_prepare_kretprobe(struct kretprobe_instance *ri, struct pt_regs *regs)
 {
 	ri->ret_addr = (kprobe_opcode_t *)regs->link;
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -52,6 +52,7 @@
 #include <asm/insn.h>
 #include <asm/debugreg.h>
 #include <asm/set_memory.h>
+#include <asm/ibt.h>
 
 #include "common.h"
 
@@ -301,6 +302,22 @@ static int can_probe(unsigned long paddr
 	return (addr == paddr);
 }
 
+/* If the x86 support IBT (ENDBR) it must be skipped. */
+kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
+					 bool *on_func_entry)
+{
+	if (is_endbr(*(u32 *)addr)) {
+		*on_func_entry = !offset || offset == 4;
+		if (*on_func_entry)
+			offset = 4;
+
+	} else {
+		*on_func_entry = !offset;
+	}
+
+	return (kprobe_opcode_t *)(addr + offset);
+}
+
 /*
  * Copy an instruction with recovering modified instruction by kprobes
  * and adjust the displacement if the instruction uses the %rip-relative
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -265,7 +265,6 @@ extern int arch_init_kprobes(void);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
 extern int arch_populate_kprobe_blacklist(void);
-extern bool arch_kprobe_on_func_entry(unsigned long offset);
 extern int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
 
 extern bool within_kprobe_blacklist(unsigned long addr);
@@ -384,6 +383,8 @@ static inline struct kprobe_ctlblk *get_
 }
 
 kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
+kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset, bool *on_func_entry);
+
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1489,24 +1489,63 @@ bool within_kprobe_blacklist(unsigned lo
 }
 
 /*
+ * arch_adjust_kprobe_addr - adjust the address
+ * @addr: symbol base address
+ * @offset: offset within the symbol
+ * @on_func_entry: was this @addr+@offset on the function entry
+ *
+ * Typically returns @addr + @offset, except for special cases where the
+ * function might be prefixed by a CFI landing pad, in that case any offset
+ * inside the landing pad is mapped to the first 'real' instruction of the
+ * symbol.
+ *
+ * Specifically, for things like IBT/BTI, skip the resp. ENDBR/BTI.C
+ * instruction at +0.
+ */
+kprobe_opcode_t *__weak arch_adjust_kprobe_addr(unsigned long addr,
+						unsigned long offset,
+						bool *on_func_entry)
+{
+	*on_func_entry = !offset;
+	return (kprobe_opcode_t *)(addr + offset);
+}
+
+/*
  * If 'symbol_name' is specified, look it up and add the 'offset'
  * to it. This way, we can specify a relative address to a symbol.
  * This returns encoded errors if it fails to look up symbol or invalid
  * combination of parameters.
  */
-static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
-			const char *symbol_name, unsigned int offset)
+static kprobe_opcode_t *
+_kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
+	     unsigned long offset, bool *on_func_entry)
 {
 	if ((symbol_name && addr) || (!symbol_name && !addr))
 		goto invalid;
 
 	if (symbol_name) {
+		/*
+		 * Input: @sym + @offset
+		 * Output: @addr + @offset
+		 *
+		 * NOTE: kprobe_lookup_name() does *NOT* fold the offset
+		 *       argument into it's output!
+		 */
 		addr = kprobe_lookup_name(symbol_name, offset);
 		if (!addr)
 			return ERR_PTR(-ENOENT);
+	} else {
+		/*
+		 * Input: @addr + @offset
+		 * Output: @addr' + @offset'
+		 */
+		if (!kallsyms_lookup_size_offset((unsigned long)addr + offset,
+						 NULL, &offset))
+			return ERR_PTR(-ENOENT);
+		addr = (kprobe_opcode_t *)((unsigned long)addr - offset);
 	}
 
-	addr = (kprobe_opcode_t *)(((char *)addr) + offset);
+	addr = arch_adjust_kprobe_addr((unsigned long)addr, offset, on_func_entry);
 	if (addr)
 		return addr;
 
@@ -1516,7 +1555,8 @@ static kprobe_opcode_t *_kprobe_addr(kpr
 
 static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 {
-	return _kprobe_addr(p->addr, p->symbol_name, p->offset);
+	bool on_func_entry;
+	return _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
 }
 
 /*
@@ -2067,15 +2107,13 @@ bool __weak arch_kprobe_on_func_entry(un
  */
 int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
 {
-	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
+	bool on_func_entry;
+	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset, &on_func_entry);
 
 	if (IS_ERR(kp_addr))
 		return PTR_ERR(kp_addr);
 
-	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset))
-		return -ENOENT;
-
-	if (!arch_kprobe_on_func_entry(offset))
+	if (!on_func_entry)
 		return -EINVAL;
 
 	return 0;
