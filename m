Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3734D29F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiCIHzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiCIHzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22447148646;
        Tue,  8 Mar 2022 23:54:44 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfdTmZztAZEn/sNpjfzciE7jkHzg7WHLamDwqHzd5Og=;
        b=jFUGjDkxneNGwDOTXo3Pb6DCHg6LN36CR2wWSQXa14viCvfUaikcmAw69uWxfb6CHxu2pC
        Hve2uZy8wogs1nNWOlwhUxMCIFgFNKa7sYQbllgbbQx+vnPGO2zZm2jDZ3O32g1tAxQDDa
        nphgjTa3X5L1gUGLl9+gU2Rfu4eWRuTpOqHsrZ1+hKLKavaxFjuRmohUfve4zxY8RsG5hd
        h/vNBP0EhxGosfsoXdA/jqk6xSSbXwK/JN8++BFzkVmqVuVuo8Y1l51HCF5zYSh3PpQOKh
        OHa7pr6HHU1503KeclaqTHgfUgPhjh4IsxCuH1QFHpDq8S4KEwJKisMpk0sQXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfdTmZztAZEn/sNpjfzciE7jkHzg7WHLamDwqHzd5Og=;
        b=E+gpwbTAIVRhOkESqGTrESO79m8B6gLauksj+DVZUQoRIRQSO0FntmW0gIL6MluokqqEMc
        6a3rFXE8qjTVehDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Add IBT/ENDBR decoding
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.645963517@infradead.org>
References: <20220308154319.645963517@infradead.org>
MIME-Version: 1.0
Message-ID: <164681248177.16921.6620445780101579265.tip-bot2@tip-bot2>
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

Commit-ID:     df280fcb49f91de003afcac7b4da806d3ded52d6
Gitweb:        https://git.kernel.org/tip/df280fcb49f91de003afcac7b4da806d3ded52d6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:38 +01:00

objtool: Add IBT/ENDBR decoding

Intel IBT requires the target of any indirect CALL or JMP instruction
to be the ENDBR instruction; optionally it allows those two
instructions to have a NOTRACK prefix in order to avoid this
requirement.

The kernel will not enable the use of NOTRACK, as such any occurence
of it in compiler generated code should be flagged.

Teach objtool to Decode ENDBR instructions and WARN about NOTRACK
prefixes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.645963517@infradead.org
---
 tools/objtool/arch/x86/decode.c      | 34 +++++++++++++++++++++++----
 tools/objtool/include/objtool/arch.h |  1 +-
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 479e769..943cb41 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -103,6 +103,18 @@ unsigned long arch_jump_destination(struct instruction *insn)
 #define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
 #define rm_is_reg(reg)	(mod_is_reg() && modrm_rm == (reg))
 
+static bool has_notrack_prefix(struct insn *insn)
+{
+	int i;
+
+	for (i = 0; i < insn->prefixes.nbytes; i++) {
+		if (insn->prefixes.bytes[i] == 0x3e)
+			return true;
+	}
+
+	return false;
+}
+
 int arch_decode_instruction(struct objtool_file *file, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -112,7 +124,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
-	unsigned char op1, op2, op3,
+	unsigned char op1, op2, op3, prefix,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
@@ -137,6 +149,8 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 	if (insn.vex_prefix.nbytes)
 		return 0;
 
+	prefix = insn.prefixes.bytes[0];
+
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
 	op3 = insn.opcode.bytes[2];
@@ -492,6 +506,12 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			/* nopl/nopw */
 			*type = INSN_NOP;
 
+		} else if (op2 == 0x1e) {
+
+			if (prefix == 0xf3 && (modrm == 0xfa || modrm == 0xfb))
+				*type = INSN_ENDBR;
+
+
 		} else if (op2 == 0x38 && op3 == 0xf8) {
 			if (insn.prefixes.nbytes == 1 &&
 			    insn.prefixes.bytes[0] == 0xf2) {
@@ -636,20 +656,24 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		break;
 
 	case 0xff:
-		if (modrm_reg == 2 || modrm_reg == 3)
+		if (modrm_reg == 2 || modrm_reg == 3) {
 
 			*type = INSN_CALL_DYNAMIC;
+			if (has_notrack_prefix(&insn))
+				WARN("notrack prefix found at %s:0x%lx", sec->name, offset);
 
-		else if (modrm_reg == 4)
+		} else if (modrm_reg == 4) {
 
 			*type = INSN_JUMP_DYNAMIC;
+			if (has_notrack_prefix(&insn))
+				WARN("notrack prefix found at %s:0x%lx", sec->name, offset);
 
-		else if (modrm_reg == 5)
+		} else if (modrm_reg == 5) {
 
 			/* jmpf */
 			*type = INSN_CONTEXT_SWITCH;
 
-		else if (modrm_reg == 6) {
+		} else if (modrm_reg == 6) {
 
 			/* push from mem */
 			ADD_OP(op) {
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 76bae30..9b19cc3 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -27,6 +27,7 @@ enum insn_type {
 	INSN_STD,
 	INSN_CLD,
 	INSN_TRAP,
+	INSN_ENDBR,
 	INSN_OTHER,
 };
 
