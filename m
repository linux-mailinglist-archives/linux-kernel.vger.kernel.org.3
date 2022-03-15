Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2F14D990C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbiCOKpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347219AbiCOKo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:44:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2912DD73;
        Tue, 15 Mar 2022 03:43:43 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZJIZ0/UkBGyt4O8RqDXixLCGKGb/PS5ZJlf4H0/IEw=;
        b=uFRQ7DEZnkzjZ7Axi6s/1Tipbzdron3kXS5xZ4tn9VMAHWfgSjkyfTQiIUPvGTEX+nNwlL
        aAsM9+4RrhILJ69va1g18icPL0WFqlny4AQ59uFAW+IBK3aq+Sh3q7c8P7pW48YgrECNxk
        /VwHzM5MsJM4fgWQ63TGIRSnbzjyuxAQpWES3+X0DuyntCjFoSrsYyhXr/ljv2U1PmInJG
        QKDkOv6nq3qfq1SFdv5CUnzK82uCQ5aEL3M4LQ/NBPfTh41yZkv3JqszjFZhkTErPm5tp1
        GchT9PWLFmDSa1rrg5Rryx+1ScvVkPKp8cDLfz10M9ri8gyHn6/Ba53Xx18prg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZJIZ0/UkBGyt4O8RqDXixLCGKGb/PS5ZJlf4H0/IEw=;
        b=3hrhzjATjku13MJ2gVnaoYKuH1cmGU3JcH9eNOblReUluUd1BksavMYXS4z/4TWeTvnMt5
        YNyYn/GW9cXRfMBw==
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
Message-ID: <164734102134.16921.756884581284713458.tip-bot2@tip-bot2>
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

Commit-ID:     7d209d13e7c3a3d60dc262f11a8ae4e6b4454d30
Gitweb:        https://git.kernel.org/tip/7d209d13e7c3a3d60dc262f11a8ae4e6b4454d30
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:46 +01:00

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
 
