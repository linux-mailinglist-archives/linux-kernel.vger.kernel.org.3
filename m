Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1F04CBCAE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiCCLdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiCCLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041B17CC5E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YYTQCCPICco3x1N92pao1rPFe2dbVtaCkYMUBxoVGeY=; b=m6Q8InqPBzEwKt1kQndMIVhqO+
        pAmKkWogIeTvuxe6KT61NSL2aOuN3ZPqTgGsTiE4Lf/PHQCEQezk+yvkXilTgqBrpjIvjIwa/GYhg
        8objI0HNg66bF2on98qP605sdJlk4HJ3JO6J+Vg0TjzAiKIkhZ+su+/eewbj2g9z0OvO07mdSJJmN
        QKA+ooP2eZ1d13bsNIDFRete/DQfFHH3ppC0o3a2g2DJn4YOzG830DhrTXOBH2Lj7J8LDlxMjqv00
        waBgF5yjw+o6gicLlZqIVBU3Wj643Mb9dc3b6TZf3cfg3Eak4utXX1xDm6ymZiQZJ1pGCXXove6Ck
        Y83W0eiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjei-00Etps-10; Thu, 03 Mar 2022 11:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13877302DD4;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A33583012B085; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112827.090174129@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 35/39] objtool: Add IBT/ENDBR decoding
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

Decode ENDBR instructions and WARN about NOTRACK prefixes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c      |   34 +++++++++++++++++++++++++++++-----
 tools/objtool/include/objtool/arch.h |    1 +
 2 files changed, 30 insertions(+), 5 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -103,6 +103,18 @@ unsigned long arch_jump_destination(stru
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
@@ -112,7 +124,7 @@ int arch_decode_instruction(struct objto
 	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
-	unsigned char op1, op2, op3,
+	unsigned char op1, op2, op3, prefix,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
@@ -137,6 +149,8 @@ int arch_decode_instruction(struct objto
 	if (insn.vex_prefix.nbytes)
 		return 0;
 
+	prefix = insn.prefixes.bytes[0];
+
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
 	op3 = insn.opcode.bytes[2];
@@ -492,6 +506,12 @@ int arch_decode_instruction(struct objto
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
@@ -636,20 +656,24 @@ int arch_decode_instruction(struct objto
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
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -27,6 +27,7 @@ enum insn_type {
 	INSN_STD,
 	INSN_CLD,
 	INSN_TRAP,
+	INSN_ENDBR,
 	INSN_OTHER,
 };
 


