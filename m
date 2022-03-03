Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3D24CBC98
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiCCLdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiCCLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE2517CC43
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Z5vfP8R4bEPnkHygUI8u97NSEl3CMIYl+8oyMGKt2Iw=; b=mvaHNy4CA8JoWOT9SPxcNWUDAY
        33ZlsLegYsVoBOu2YRxs9KHsWCOrWwUA/KVKPaTShim02iujgq9E/fNfeLG9m4TMpRrrRZvoqsOtI
        QOfkobs+jMqMnrvvs2yd60V6Tb6NwB05kPY8/Ll2sq47wVRV/zBJ7i7+Vy7ku1XLB+UrDjnft95zh
        kEH03UlRYrKI+UfcB6aMsiAhwRsAQasMHEBW5CKcdjAArSPrXs7Ca+B1Kb9fnTv0tto0bouzR3WG3
        g+vRg0/8oj/gMjfOghqKnSVQCgstkNmvCFQ9pHvinHW3lSAIUMeRn98coBLXd4UyzCE9+qbOdcaaZ
        dvDGAfeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeh-00Etpd-6X; Thu, 03 Mar 2022 11:29:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F36253021F5;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6182C3003367E; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112826.104222438@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 19/39] x86/ibt,kprobes: Cure sym+0 equals fentry woes
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

Rework _kprobe_addr() to only ever do 2 kallsyms calls and require
only a single architecture/weak function -- although currently powerpc
still uses 2.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/kernel/kprobes.c  |   34 +++++++++++++--------
 arch/x86/kernel/kprobes/core.c |   28 ++++++++++++++---
 include/linux/kprobes.h        |    3 +
 kernel/kprobes.c               |   66 ++++++++++++++++++++++++++++++++---------
 4 files changed, 98 insertions(+), 33 deletions(-)

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
 
@@ -197,13 +198,14 @@ __recover_probed_insn(kprobe_opcode_t *b
 
 	kp = get_kprobe((void *)addr);
 	faddr = ftrace_location(addr);
+
 	/*
-	 * Addresses inside the ftrace location are refused by
-	 * arch_check_ftrace_location(). Something went terribly wrong
-	 * if such an address is checked here.
+	 * In case addr maps to sym+0 ftrace_location() might return something
+	 * other than addr. In that case consider it the same as !faddr.
 	 */
-	if (WARN_ON(faddr && faddr != addr))
-		return 0UL;
+	if (faddr && faddr != addr)
+		faddr = 0;
+
 	/*
 	 * Use the current code if it is not modified by Kprobe
 	 * and it cannot be modified by ftrace.
@@ -301,6 +303,22 @@ static int can_probe(unsigned long paddr
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
@@ -2047,11 +2092,6 @@ static int pre_handler_kretprobe(struct
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
 
-bool __weak arch_kprobe_on_func_entry(unsigned long offset)
-{
-	return !offset;
-}
-
 /**
  * kprobe_on_func_entry() -- check whether given address is function entry
  * @addr: Target address
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


