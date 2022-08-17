Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1D8597427
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbiHQQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240251AbiHQQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:26:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2249F75E;
        Wed, 17 Aug 2022 09:26:43 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660753601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+3L7Pb6Y+lCWRputOBViKsnAsaMw41yLztGJF9Jl5Q=;
        b=1jLe+s8drkWD5HETRok4I4A7zalnqH4kvW6M4KUFeDLYI7FcR9uj3HP8XNuLMKrjFSjAki
        +YO5ZKCsI3aqyTd8IpwgcYN27BiCZuiw4pY7fTWaOJKt4AYXNJp7rK2h0lN0y9ivdz5Fjd
        G/6Nk+ny1jHXKFI7AWDTEBF1YBNc4QUOAAKJ7uZe3717gYkHsmQDiVCDKHrTE8nVj8kOep
        w2Nuc/j2AeN+rH2TRc2MuJQEKNaEZJiaamf6aEZkIxlvrC6dVFt7FX/zJa8M6JTb9xODy0
        OgoXMRzIoSOUhk4IvAeGvW+uUIzhmWYjBj4+QkO9mBmEqca2bDotWUI9STd78Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660753601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t+3L7Pb6Y+lCWRputOBViKsnAsaMw41yLztGJF9Jl5Q=;
        b=UWUjPxreEzl8V2dzuW15acdNvYK3RrLCv9FOf+38RRHw8HlLP3pPoaikVnb+R3BcxZtB36
        ZJ7voDrLbzeCVDAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] x86/kvm, objtool: Avoid fastop ENDBR from being sealed
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
References: <YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166075359990.401.7301726902977346879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     52ad1c24d213f176a2424552dfd0db2f870d96bd
Gitweb:        https://git.kernel.org/tip/52ad1c24d213f176a2424552dfd0db2f870d96bd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 17 Aug 2022 12:56:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Aug 2022 18:05:51 +02:00

x86/kvm, objtool: Avoid fastop ENDBR from being sealed

Subject: x86/kvm, objtool: Avoid fastop ENDBR from being sealed

Xu reported a number of "Missing ENDBR" triggers for the KVM fastop
emulation code. It turns out that because of how the fastops are set up,
only the first of a series -- the 8-byte variants that overlap with the
em_ symbols -- is found referenced.

Specifically:

        .pushsection .text, "ax"
        .global em_and
        .align 16
        em_and:
        .align 16
        .type andb_al_dl, @function
        andb_al_dl:
        endbr64
        andb %dl, %al
        11: jmp __x86_return_thunk
        .size andb_al_dl, .-andb_al_dl
        .align 16
        .type andw_ax_dx, @function
        andw_ax_dx:
        endbr64
        andw %dx, %ax
        11: jmp __x86_return_thunk
        .size andw_ax_dx, .-andw_ax_dx
        .align 16
        .type andl_eax_edx, @function
        andl_eax_edx:
        endbr64
        andl %edx, %eax
        11: jmp __x86_return_thunk
        .size andl_eax_edx, .-andl_eax_edx
        .align 16
        .type andq_rax_rdx, @function
        andq_rax_rdx:
        endbr64
        andq %rdx, %rax
        11: jmp __x86_return_thunk
        .size andq_rax_rdx, .-andq_rax_rdx
        .popsection

Only has the em_and symbol referenced, resulting in and{w,l,q}_* getting
sealed.

Add (yet another) annotation to inhibit objtool from sealing a specific
ENDBR instance.

[ mingo: Sync up tools/include/linux/objtool.h to include/linux/objtool.h. ]

Fixes: 6649fa876da4 ("x86/ibt,kvm: Add ENDBR to fastops")
Reported-by: "Xu, Pengfei" <pengfei.xu@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/YvzJTxOwmikAlZ6j@worktop.programming.kicks-ass.net
---
 arch/x86/include/asm/ibt.h    |  5 ++++-
 arch/x86/kvm/emulate.c        |  4 +--
 include/linux/objtool.h       |  6 +++++-
 tools/include/linux/objtool.h |  6 +++++-
 tools/objtool/check.c         | 44 +++++++++++++++++++++++++++++-----
 5 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 689880e..f32ba1c 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -29,6 +29,10 @@
 #define ASM_ENDBR	"endbr32\n\t"
 #endif
 
+#define ASM_ENDBR_NOSEAL	\
+	ANNOTATE_NOSEAL		\
+	ASM_ENDBR
+
 #define __noendbr	__attribute__((nocf_check))
 
 static inline __attribute_const__ u32 gen_endbr(void)
@@ -84,6 +88,7 @@ extern __noendbr void ibt_restore(u64 save);
 #ifndef __ASSEMBLY__
 
 #define ASM_ENDBR
+#define ASM_ENDBR_NOSEAL
 
 #define __noendbr
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index b4eeb7c..d51ee8a 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -326,7 +326,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
 	name ":\n\t" \
-	ASM_ENDBR
+	ASM_ENDBR_NOSEAL
 
 #define FOP_FUNC(name) \
 	__FOP_FUNC(#name)
@@ -461,7 +461,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	".align " __stringify(SETCC_ALIGN) " \n\t" \
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
-	ASM_ENDBR \
+	ASM_ENDBR_NOSEAL \
 	#op " %al \n\t" \
 	__FOP_RET(#op) \
 	".skip " __stringify(SETCC_ALIGN) " - (.-" #op "), 0xcc \n\t"
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 62c54ff..ad752f8 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -90,6 +90,12 @@ struct unwind_hint {
 	_ASM_PTR " 986b\n\t"					\
 	".popsection\n\t"
 
+#define ANNOTATE_NOSEAL						\
+	"986: \n\t"						\
+	".pushsection .discard.noseal\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #define ASM_REACHABLE							\
 	"998:\n\t"							\
 	".pushsection .discard.reachable\n\t"				\
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
index 62c54ff..ad752f8 100644
--- a/tools/include/linux/objtool.h
+++ b/tools/include/linux/objtool.h
@@ -90,6 +90,12 @@ struct unwind_hint {
 	_ASM_PTR " 986b\n\t"					\
 	".popsection\n\t"
 
+#define ANNOTATE_NOSEAL						\
+	"986: \n\t"						\
+	".pushsection .discard.noseal\n\t"			\
+	_ASM_PTR " 986b\n\t"					\
+	".popsection\n\t"
+
 #define ASM_REACHABLE							\
 	"998:\n\t"							\
 	".pushsection .discard.reachable\n\t"				\
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0cec74d..0d04d0a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2111,6 +2111,40 @@ static int read_noendbr_hints(struct objtool_file *file)
 	return 0;
 }
 
+static void mark_endbr_used(struct instruction *insn)
+{
+	if (!list_empty(&insn->call_node))
+		list_del_init(&insn->call_node);
+}
+
+static int read_noseal_hints(struct objtool_file *file)
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct reloc *reloc;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.noseal");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(reloc, &sec->reloc_list, list) {
+		insn = find_insn(file, reloc->sym->sec, reloc->sym->offset + reloc->addend);
+		if (!insn) {
+			WARN("bad .discard.noseal entry");
+			return -1;
+		}
+
+		if (insn->type != INSN_ENDBR) {
+			WARN_FUNC("ANNOTATE_NOSEAL not on ENDBR", insn->sec, insn->offset);
+			continue;
+		}
+
+		mark_endbr_used(insn);
+	}
+
+	return 0;
+}
+
 static int read_retpoline_hints(struct objtool_file *file)
 {
 	struct section *sec;
@@ -2356,6 +2390,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_noseal_hints(file);
+	if (ret)
+		return ret;
+
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
@@ -3952,12 +3990,6 @@ static int validate_functions(struct objtool_file *file)
 	return warnings;
 }
 
-static void mark_endbr_used(struct instruction *insn)
-{
-	if (!list_empty(&insn->call_node))
-		list_del_init(&insn->call_node);
-}
-
 static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
 {
 	struct instruction *dest;
