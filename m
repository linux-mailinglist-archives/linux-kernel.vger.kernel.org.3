Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B580A4D29F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiCIH5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiCIH40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1282F15F35D;
        Tue,  8 Mar 2022 23:55:02 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812501;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBxNeggDvGmLSWkXKlhX7M7QjBr5DgB19i6yv8NsWuM=;
        b=m+RkZbdH4PU2d5CD+9EK8mvYd8CRLQltxDTq6pyv62YHx+e3UD462lczjKzjotqMBxgcU4
        mIYjfkRbzrD8Sn6zulbVed+4x12L+EyYmmPQmzlOAn+souJaUjPO8L9Og5prTbhWYqi+mq
        NJ/feAZ0mTzuyeomhH1hpS7yQj+xLuEbmBgZijYixg/Cm4twJbT9sfvrTMhNerQ6XIlgnf
        N2NrYIryRbNQESDxHNVPUWYi97TbhKZQPyu170gFQAUVYiyFhOu+11G0AL0fEmJBExzoD/
        FLvbq0k3C/xwv9nWOATXhs9UNHtMHNOj0/R4gpYUQ/+d2sSqRDGjuWAm9OTgew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812501;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBxNeggDvGmLSWkXKlhX7M7QjBr5DgB19i6yv8NsWuM=;
        b=B3mW6k9ny4JR/XZohawmkozc3pbA0yGKOZGEPl95ICZ7iHcW6hwcNkYOps5lmlWtAOiGMe
        WT4EORfn+AMsBNBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,kprobes: Cure sym+0 equals fentry woes
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.405947704@infradead.org>
References: <20220308154318.405947704@infradead.org>
MIME-Version: 1.0
Message-ID: <164681250041.16921.8970224674416607381.tip-bot2@tip-bot2>
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

Commit-ID:     19d1033ec715d873e490841b07f300bb16cdcd21
Gitweb:        https://git.kernel.org/tip/19d1033ec715d873e490841b07f300bb16cdcd21
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:32 +01:00

x86/ibt,kprobes: Cure sym+0 equals fentry woes

In order to allow kprobes to skip the ENDBR instructions at sym+0 for
X86_KERNEL_IBT builds, change _kprobe_addr() to take an architecture
callback to inspect the function at hand and modify the offset if
needed.

This streamlines the existing interface to cover more cases and
require less hooks. Once PowerPC gets fully converted there will only
be the one arch hook.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.405947704@infradead.org
---
 arch/powerpc/kernel/kprobes.c  | 34 ++++++++++-------
 arch/x86/kernel/kprobes/core.c | 17 +++++++++-
 include/linux/kprobes.h        |  3 +-
 kernel/kprobes.c               | 66 ++++++++++++++++++++++++++-------
 4 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 9a492fd..7dae0b0 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -105,6 +105,27 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
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
@@ -218,19 +239,6 @@ static nokprobe_inline void set_current_kprobe(struct kprobe *p, struct pt_regs 
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
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4d8086a..9ea0e3e 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -52,6 +52,7 @@
 #include <asm/insn.h>
 #include <asm/debugreg.h>
 #include <asm/set_memory.h>
+#include <asm/ibt.h>
 
 #include "common.h"
 
@@ -294,6 +295,22 @@ static int can_probe(unsigned long paddr)
 	return (addr == paddr);
 }
 
+/* If x86 supports IBT (ENDBR) it must be skipped. */
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
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 19b8843..9c28f7a 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -265,7 +265,6 @@ extern int arch_init_kprobes(void);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
 extern int arch_populate_kprobe_blacklist(void);
-extern bool arch_kprobe_on_func_entry(unsigned long offset);
 extern int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
 
 extern bool within_kprobe_blacklist(unsigned long addr);
@@ -384,6 +383,8 @@ static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
 }
 
 kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset);
+kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset, bool *on_func_entry);
+
 int register_kprobe(struct kprobe *p);
 void unregister_kprobe(struct kprobe *p);
 int register_kprobes(struct kprobe **kps, int num);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 6d1e11c..185badc 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1489,24 +1489,68 @@ bool within_kprobe_blacklist(unsigned long addr)
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
 
@@ -1516,7 +1560,8 @@ invalid:
 
 static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 {
-	return _kprobe_addr(p->addr, p->symbol_name, p->offset);
+	bool on_func_entry;
+	return _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
 }
 
 /*
@@ -2043,11 +2088,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
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
@@ -2063,15 +2103,13 @@ bool __weak arch_kprobe_on_func_entry(unsigned long offset)
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
