Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CCB4C2F64
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiBXPSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiBXPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E77148668
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QF+y92vIi7VDOKP0W9wPJ52RRDqpU3rVATN3qjdWbZo=; b=H0JnrS2cPEqK9AhStL7fizqOP9
        wO3WADc7FiRcNnpYd+KyK9Dv2rGTChZ2VW2r/5FhcDG57EnlaeECVi2jBr8LulDVqlQm6sAQiE2QU
        v1Pfyt9MDKjUdHaTl7NmEQy7sZJTBCbpIEuoGZKuHOfJuyL1Mb4FJhZ4MA92hUKsOCSk1aKKJ4IO/
        71kmMWzA0KCxowPDjVV1DSQlc8hdOOkw+B07dc5hU6Gz77rqcj1T8kVx1i2k5pVHlkTo0fdmiL54z
        COdmZRUKkRGQDQfmklCOfEN0bv+bNmilhsjJqdMrhqY6snqowNcU6b8OePgpUQ5Z42fEchAiwTNwZ
        SigvBDaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs4-004s2O-EU; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 512BE302D67;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AAF4A2B3547AD; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151324.078734828@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 35/39] objtool: IBT fix direct JMP/CALL
References: <20220224145138.952963315@infradead.org>
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

Optionally rewrite all direct JMP/CALL that target ENDBR. 

By doing this it is guaranteed that only indirect code flow uses
ENDBR, at which point it becomes possible to poison unused ENDBR
instructions (a later patch).

By having this rely on --lto the only direct code flow missed is that
fixed up by the module loader.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c         |   71 ++++++++++++++++++++++++++++++++
 tools/objtool/builtin-check.c           |    3 -
 tools/objtool/check.c                   |   45 ++++++++++++++++++--
 tools/objtool/include/objtool/arch.h    |    1 
 tools/objtool/include/objtool/builtin.h |    2 
 5 files changed, 116 insertions(+), 6 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -729,6 +729,77 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
 
+const char *arch_mod_immediate(struct instruction *insn, unsigned long target)
+{
+	struct section *sec = insn->sec;
+	Elf_Data *data = sec->data;
+	unsigned char op1, op2;
+	static char bytes[16];
+	struct insn x86_insn;
+	int ret, disp;
+
+	disp = (long)(target - (insn->offset + insn->len));
+
+	if (data->d_type != ELF_T_BYTE || data->d_off) {
+		WARN("unexpected data for section: %s", sec->name);
+		return NULL;
+	}
+
+	ret = insn_decode(&x86_insn, data->d_buf + insn->offset, insn->len,
+			  INSN_MODE_64);
+	if (ret < 0) {
+		WARN("can't decode instruction at %s:0x%lx", sec->name, insn->offset);
+		return NULL;
+	}
+
+	op1 = x86_insn.opcode.bytes[0];
+	op2 = x86_insn.opcode.bytes[1];
+
+	switch (op1) {
+	case 0x0f: /* escape */
+		switch (op2) {
+		case 0x80 ... 0x8f: /* jcc.d32 */
+			if (insn->len != 6)
+				return NULL;
+			bytes[0] = op1;
+			bytes[1] = op2;
+			*(int *)&bytes[2] = disp;
+			break;
+
+		default:
+			return NULL;
+		}
+		break;
+
+	case 0x70 ... 0x7f: /* jcc.d8 */
+	case 0xeb: /* jmp.d8 */
+		if (insn->len != 2)
+			return NULL;
+
+		if (disp >> 7 != disp >> 31) {
+			WARN("displacement doesn't fit\n");
+			return NULL;
+		}
+
+		bytes[0] = op1;
+		bytes[1] = disp & 0xff;
+		break;
+
+	case 0xe8: /* call */
+	case 0xe9: /* jmp.d32 */
+		if (insn->len != 5)
+			return NULL;
+		bytes[0] = op1;
+		*(int *)&bytes[1] = disp;
+		break;
+
+	default:
+		return NULL;
+	}
+
+	return bytes;
+}
+
 #define BYTE_RET	0xC3
 
 const char *arch_ret_insn(int len)
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -21,7 +21,7 @@
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
      lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-     ibt;
+     ibt, ibt_fix_direct;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -49,6 +49,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
 	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
 	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
+	OPT_BOOLEAN(0, "ibt-fix-direct", &ibt_fix_direct, "fixup direct jmp/call to ENDBR"),
 	OPT_END(),
 };
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1240,9 +1240,25 @@ static int add_jump_destinations(struct
 		    insn->jump_dest->func &&
 		    insn->jump_dest->offset == insn->jump_dest->func->offset) {
 			if (reloc) {
-				WARN_FUNC("Direct RELOC jump to ENDBR", insn->sec, insn->offset);
+				if (ibt_fix_direct) {
+					reloc->addend += 4;
+					elf_write_reloc(file->elf, reloc);
+				} else {
+					WARN_FUNC("Direct RELOC jump to ENDBR", insn->sec, insn->offset);
+				}
 			} else {
-				WARN_FUNC("Direct IMM jump to ENDBR", insn->sec, insn->offset);
+				if (ibt_fix_direct) {
+					const char *bytes = arch_mod_immediate(insn, dest_off + 4);
+					if (bytes) {
+						elf_write_insn(file->elf, insn->sec,
+							       insn->offset, insn->len,
+							       bytes);
+					} else {
+						WARN_FUNC("Direct IMM jump to ENDBR; cannot fix", insn->sec, insn->offset);
+					}
+				} else {
+					WARN_FUNC("Direct IMM jump to ENDBR", insn->sec, insn->offset);
+				}
 			}
 		}
 
@@ -1378,9 +1394,25 @@ static int add_call_destinations(struct
 
 		if (ibt && target && target->type == INSN_ENDBR) {
 			if (reloc) {
-				WARN_FUNC("Direct RELOC call to ENDBR", insn->sec, insn->offset);
+				if (ibt_fix_direct) {
+					reloc->addend += 4;
+					elf_write_reloc(file->elf, reloc);
+				} else {
+					WARN_FUNC("Direct RELOC call to ENDBR", insn->sec, insn->offset);
+				}
 			} else {
-				WARN_FUNC("Direct IMM call to ENDBR", insn->sec, insn->offset);
+				if (ibt_fix_direct) {
+					const char *bytes = arch_mod_immediate(insn, dest_off + 4);
+					if (bytes) {
+						elf_write_insn(file->elf, insn->sec,
+							       insn->offset, insn->len,
+							       bytes);
+					} else {
+						WARN_FUNC("Direct IMM call to ENDBR; cannot fix", insn->sec, insn->offset);
+					}
+				} else {
+					WARN_FUNC("Direct IMM call to ENDBR", insn->sec, insn->offset);
+				}
 			}
 		}
 	}
@@ -3740,6 +3772,11 @@ int check(struct objtool_file *file)
 		return 1;
 	}
 
+	if (ibt_fix_direct && !ibt) {
+		fprintf(stderr, "--ibt-fix-direct requires: --ibt\n");
+		return 1;
+	}
+
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -85,6 +85,7 @@ unsigned long arch_dest_reloc_offset(int
 
 const char *arch_nop_insn(int len);
 const char *arch_ret_insn(int len);
+const char *arch_mod_immediate(struct instruction *insn, unsigned long target);
 
 int arch_decode_hint_reg(u8 sp_reg, int *base);
 
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -10,7 +10,7 @@
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
 	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-	    ibt;
+	    ibt, ibt_fix_direct;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 


