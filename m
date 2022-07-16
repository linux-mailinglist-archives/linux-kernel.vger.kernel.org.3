Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3312577248
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiGPXRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiGPXR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51901AF29
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:21 -0700 (PDT)
Message-ID: <20220716230953.021143397@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uS+wUG53yieKJ2rVW0hF2kwxHQa7dn6gMuFlM3qMG6M=;
        b=sMF0ven6SG0bOoohd362yty6POSUValbGmPlwpWWuDR0SIR9SUZOMHw3vRH9hTRtESvYT8
        pfuU+7sIJa6DPpuPEh3aGjxPCiyWxmadhoOLRLMJEtndhS7yR3OngrqzwZQnnZNaM5jhPo
        hi7lhQIFrpeB/6jGma19rtDPTCY/pqhcicv4qIitHdyzrtHswU0RVXtCBsvaBmJku+UhnV
        pj3qENVR4/rtSmK5bryowgM6D9ICXrh75gIU0xaql2pztKWUpWNxU9eb55b9c9PyS/Zw4+
        Ui7y8c3pjw0fmRmxkC2oxh4j282v0upmUJbipNmBlcVu5F+pcRsP3oqXpds5vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=uS+wUG53yieKJ2rVW0hF2kwxHQa7dn6gMuFlM3qMG6M=;
        b=C0ixrIxw123ZNgk4TVQWjvhNVqMjv7BpoZ24fu99UyG9xyh2FgaiQnbVrPNKtm57FHeG3b
        u6r+O6MiRTHvWiBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 06/38] objtool: Allow GS relative relocs
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:19 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Objtool doesn't currently much like per-cpu usage in alternatives:

arch/x86/entry/entry_64.o: warning: objtool: .altinstr_replacement+0xf: unsupported relocation in alternatives section
  f:   65 c7 04 25 00 00 00 00 00 00 00 80     movl   $0x80000000,%gs:0x0      13: R_X86_64_32S        __x86_call_depth

Allow this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/objtool/arch/x86/decode.c       |   26 +++++++++++++++++++++-----
 tools/objtool/check.c                 |    6 ++----
 tools/objtool/include/objtool/arch.h  |    4 +---
 tools/objtool/include/objtool/check.h |   20 +++++++++++---------
 4 files changed, 35 insertions(+), 21 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -103,24 +103,37 @@ unsigned long arch_jump_destination(stru
 #define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
 #define rm_is_reg(reg)	(mod_is_reg() && modrm_rm == (reg))
 
-static bool has_notrack_prefix(struct insn *insn)
+static bool has_prefix(struct insn *insn, u8 prefix)
 {
 	int i;
 
 	for (i = 0; i < insn->prefixes.nbytes; i++) {
-		if (insn->prefixes.bytes[i] == 0x3e)
+		if (insn->prefixes.bytes[i] == prefix)
 			return true;
 	}
 
 	return false;
 }
 
+static bool has_notrack_prefix(struct insn *insn)
+{
+	return has_prefix(insn, 0x3e);
+}
+
+static bool has_gs_prefix(struct insn *insn)
+{
+	return has_prefix(insn, 0x65);
+}
+
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate,
-			    struct list_head *ops_list)
+			    struct instruction *instruction)
 {
+	struct list_head *ops_list = &instruction->stack_ops;
+	unsigned long *immediate = &instruction->immediate;
+	enum insn_type *type = &instruction->type;
+	unsigned int *len = &instruction->len;
+
 	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
@@ -149,6 +162,9 @@ int arch_decode_instruction(struct objto
 	if (insn.vex_prefix.nbytes)
 		return 0;
 
+	if (has_gs_prefix(&insn))
+		instruction->alt_reloc_safe = 1;
+
 	prefix = insn.prefixes.bytes[0];
 
 	op1 = insn.opcode.bytes[0];
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -396,9 +396,7 @@ static int decode_instructions(struct ob
 
 			ret = arch_decode_instruction(file, sec, offset,
 						      sec->sh.sh_size - offset,
-						      &insn->len, &insn->type,
-						      &insn->immediate,
-						      &insn->stack_ops);
+						      insn);
 			if (ret)
 				goto err;
 
@@ -1620,7 +1618,7 @@ static int handle_group_alt(struct objto
 		 * accordingly.
 		 */
 		alt_reloc = insn_reloc(file, insn);
-		if (alt_reloc &&
+		if (alt_reloc && !insn->alt_reloc_safe &&
 		    !arch_support_alt_relocation(special_alt, insn, alt_reloc)) {
 
 			WARN_FUNC("unsupported relocation in alternatives section",
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -73,9 +73,7 @@ void arch_initial_func_cfi_state(struct
 
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
-			    unsigned int *len, enum insn_type *type,
-			    unsigned long *immediate,
-			    struct list_head *ops_list);
+			    struct instruction *insn);
 
 bool arch_callee_saved_reg(unsigned char reg);
 
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -47,15 +47,17 @@ struct instruction {
 	unsigned long immediate;
 
 	u16 dead_end		: 1,
-	   ignore		: 1,
-	   ignore_alts		: 1,
-	   hint			: 1,
-	   save			: 1,
-	   restore		: 1,
-	   retpoline_safe	: 1,
-	   noendbr		: 1,
-	   entry		: 1;
-		/* 7 bit hole */
+	    ignore		: 1,
+	    ignore_alts		: 1,
+	    hint		: 1,
+	    save		: 1,
+	    restore		: 1,
+	    retpoline_safe	: 1,
+	    noendbr		: 1,
+	    entry		: 1,
+	    alt_reloc_safe	: 1;
+
+		/* 6 bit hole */
 
 	s8 instr;
 	u8 visited;

