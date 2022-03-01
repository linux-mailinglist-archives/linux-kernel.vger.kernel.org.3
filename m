Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928914C9563
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiCAUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiCAUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:07:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F22970CD9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eVE4x0a1uiIp7GVd+oaFA8E1J9Sx4rnnEv4gkvYByB0=; b=ZN/HdjRT+7J2hIUgr0q+Livuys
        QkRypafQ43BBDMdXZQlP7pOzskxJ/1/ifb50ib6//pE1EI71GUBPGL3sG1q+i4kbTkQZwOsnwvGGs
        jDSJgxKKwRUxkCWFs9+5KQ+/v8Hv4KgggK5ULt8HCbu0G1Stq2ZcD+QNZFgEDQ6SKkLPrRGSGzkaP
        ASGFTUTcQcEOyfAqkCObWLB/gwPVk9ATUSFGKKhx7lRjfW1saRjBwqosS3EPZ4ZPs0/flNVih+OZu
        /YZltR/a8C0iDt7Bj8xVXZ3iSGBVJfD4pfO2/AjlP0J452RmiLrY+9fI4dscoW+BJ/14SGufkLVS6
        C9sU6Aqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP8km-009tsg-Qc; Tue, 01 Mar 2022 20:05:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BDE1986271; Tue,  1 Mar 2022 21:05:47 +0100 (CET)
Date:   Tue, 1 Mar 2022 21:05:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, alyssa.milburn@intel.com,
        andrew.cooper3@citrix.com, hjl.tools@gmail.com,
        joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz, ndesaulniers@google.com,
        rostedt@goodmis.org, samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-ID: <20220301200547.GK11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.892372059@infradead.org>
 <20220228150705.aab2d654b973109bab070ffe@kernel.org>
 <20220228232513.GH11184@worktop.programming.kicks-ass.net>
 <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
 <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
 <1646154463.4r1sh4kjf0.naveen@linux.ibm.com>
 <20220301191245.GI11184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301191245.GI11184@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 08:12:45PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 01, 2022 at 10:49:09PM +0530, Naveen N. Rao wrote:
> > Peter Zijlstra wrote:

> > > But if you really want/need to retain that, then yes, we need that
> > > else branch unconditionally :/
> > 
> > I think we will need this. perf always specifies an offset from _text.
> 
> The _text section symbol should have an adequate size, no?

n/m, I should really go get some sleep it seems. Even if the size is
correct, that isn't relevant.

> > Also, I just noticed:
> 
> > > +		if (!kallsyms_lookup_size_offset((unsigned long)addr + offset,
> > > +						 NULL, &offset))
> > > +			return ERR_PTR(-ENOENT);
> > > +		addr = (kprobe_opcode_t *)((unsigned long)addr - offset);
> > >  	}
> > 
> > This looks wrong. I think you need to retain offset to calculate the proper
> > function entry address so that you can do:
> > 	addr = (kprobe_opcode_t *)((unsigned long)(addr + offset) - func_offset);
> > 	offset = func_offset;
> 
> 
> Right you are, it needs to be:
> 
> 	addr += offset;
> 	kallsyms_lookup_size_offset(addr, &size, &offset);
> 	addr -= offset;
> 
> with all the extra unreadable casts on.

How does this look?

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
@@ -1489,24 +1489,68 @@ bool within_kprobe_blacklist(unsigned lo
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
 	}
 
-	addr = (kprobe_opcode_t *)(((char *)addr) + offset);
+	/*
+	 * So here we have @addr + @offset, displace it into a new
+	 * @addr' + @offset' where @addr' is the symbol start address.
+	 */
+	addr = (void *)addr + offset;
+	if (!kallsyms_lookup_size_offset((unsigned long)addr, NULL, &offset))
+		return ERR_PTR(-ENOENT);
+	addr = (void *)addr - offset;
+
+	/*
+	 * Then ask the architecture to re-combine them, taking care of
+	 * magical function entry details while telling us if this was indeed
+	 * at the start of the function.
+	 */
+	addr = arch_adjust_kprobe_addr((unsigned long)addr, offset, on_func_entry);
 	if (addr)
 		return addr;
 
@@ -1516,7 +1560,8 @@ static kprobe_opcode_t *_kprobe_addr(kpr
 
 static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 {
-	return _kprobe_addr(p->addr, p->symbol_name, p->offset);
+	bool on_func_entry;
+	return _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
 }
 
 /*
@@ -2067,15 +2112,13 @@ bool __weak arch_kprobe_on_func_entry(un
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
