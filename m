Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C137F4BBE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiBRRQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:16:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbiBRRPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE574C7BC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zz+9h1mSxvYI4aMokyek0x/111O05QZVpaT2QS40Dv8=; b=XS3B/TdzXiFVxMExA3vhJfL00q
        U4RuFFCrNGaRd1PrCpzlKHpNEC9x1riV8lPKwHBeyMq5KuB/cqAKVwQIUxvaQr0eB2z6clUqzRObu
        XeUhfWkAbd5Fz2yUP4B4z5HiMvImDFQzo0tzYTYK7jpyVs/t3h2PIkZgxcjBw08gm7OewmMDsLBE2
        j01n3dB9qNjgCHkmJwhFZeL97OzASfuV6P82yZ61eL09sD/H3TCoUHmrVnsCMfDaN1C3ofKwZ/7Gq
        ly03jpRQFKhQg+I0NJ94Wo0kX8b+Q4t7YBXgvd+dCD4B/vQJY/IvKD90jhdKXn3msh2T5rnYtgcCc
        G1rB84Dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qB-00Gl8p-22; Fri, 18 Feb 2022 17:14:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA0BF302D41;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 727802B09FA70; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171410.121006443@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 26/29] objtool: Add IBT validation / fixups
References: <20220218164902.008644515@infradead.org>
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

Objtool based IBT validation in 3 passes:

 --ibt:

    Report code relocs that are not JMP/CALL and don't point to ENDBR

 --ibt-fix-direct:

    Detect and rewrite any code/reloc from a JMP/CALL instruction
    to an ENDBR instruction. This is basically a compiler bug since
    neither needs the ENDBR and decoding it is a pure waste of time.

 --ibt-seal:

    Find superfluous ENDBR instructions. Any function that
    doesn't have it's address taken should not have an ENDBR
    instruction. This removes about 1-in-4 ENDBR instructions.

All these flags are LTO like and require '--lto' to run.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/vmlinux.lds.S           |    9 
 tools/objtool/arch/x86/decode.c         |   82 +++++++
 tools/objtool/builtin-check.c           |    6 
 tools/objtool/check.c                   |  356 ++++++++++++++++++++++++++++++--
 tools/objtool/include/objtool/arch.h    |    3 
 tools/objtool/include/objtool/builtin.h |    3 
 tools/objtool/include/objtool/objtool.h |    4 
 tools/objtool/objtool.c                 |    1 
 8 files changed, 441 insertions(+), 23 deletions(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -285,6 +285,15 @@ SECTIONS
 	}
 #endif
 
+#ifdef CONFIG_X86_IBT
+	. = ALIGN(8);
+	.ibt_endbr_sites : AT(ADDR(.ibt_endbr_sites) - LOAD_OFFSET) {
+		__ibt_endbr_sites = .;
+		*(.ibt_endbr_sites)
+		__ibt_endbr_sites_end = .;
+	}
+#endif
+
 	/*
 	 * struct alt_inst entries. From the header (alternative.h):
 	 * "Alternative instructions for different CPU types or capabilities"
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -112,7 +112,7 @@ int arch_decode_instruction(struct objto
 	const struct elf *elf = file->elf;
 	struct insn insn;
 	int x86_64, ret;
-	unsigned char op1, op2, op3,
+	unsigned char op1, op2, op3, prefix,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
@@ -137,6 +137,8 @@ int arch_decode_instruction(struct objto
 	if (insn.vex_prefix.nbytes)
 		return 0;
 
+	prefix = insn.prefixes.bytes[0];
+
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
 	op3 = insn.opcode.bytes[2];
@@ -492,6 +494,12 @@ int arch_decode_instruction(struct objto
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
@@ -605,6 +613,7 @@ int arch_decode_instruction(struct objto
 				op->dest.type = OP_DEST_REG;
 				op->dest.reg = CFI_SP;
 			}
+			*type = INSN_IRET;
 			break;
 		}
 
@@ -705,6 +714,77 @@ const char *arch_nop_insn(int len)
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
@@ -20,7 +20,8 @@
 #include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-     lto, vmlinux, mcount, noinstr, backup, sls, dryrun;
+     lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
+     ibt, ibt_fix_direct, ibt_seal;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -47,6 +48,9 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('B', "backup", &backup, "create .orig files before modification"),
 	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
 	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
+	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
+	OPT_BOOLEAN(0, "ibt-fix-direct", &ibt_fix_direct, "fixup direct jmp/call to ENDBR"),
+	OPT_BOOLEAN(0, "ibt-seal", &ibt_seal, "list superfluous ENDBR instructions"),
 	OPT_END(),
 };
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -380,6 +380,7 @@ static int decode_instructions(struct ob
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
+			INIT_LIST_HEAD(&insn->call_node);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -731,6 +732,58 @@ static int create_retpoline_sites_sectio
 	return 0;
 }
 
+static int create_ibt_endbr_sites_sections(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".ibt_endbr_sites");
+	if (sec) {
+		WARN("file already has .ibt_endbr_sites, skipping");
+		return 0;
+	}
+
+	idx = 0;
+	list_for_each_entry(insn, &file->endbr_list, call_node)
+		idx++;
+
+	if (stats) {
+		printf("ibt: ENDBR at function start: %d\n", file->nr_endbr);
+		printf("ibt: ENDBR inside functions:  %d\n", file->nr_endbr_int);
+		printf("ibt: superfluous ENDBR:       %d\n", idx);
+	}
+
+	if (!idx)
+		return 0;
+
+	sec = elf_create_section(file->elf, ".ibt_endbr_sites", 0,
+				 sizeof(int), idx);
+	if (!sec) {
+		WARN("elf_create_section: .ibt_endbr_sites");
+		return -1;
+	}
+
+	idx = 0;
+	list_for_each_entry(insn, &file->endbr_list, call_node) {
+
+		int *site = (int *)sec->data->d_buf + idx;
+		*site = 0;
+
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(int),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset)) {
+			WARN("elf_add_reloc_to_insn: .ibt_endbr_sites");
+			return -1;
+		}
+
+		idx++;
+	}
+
+	return 0;
+}
+
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1176,6 +1229,15 @@ static int add_jump_destinations(struct
 	unsigned long dest_off;
 
 	for_each_insn(file, insn) {
+		if (insn->type == INSN_ENDBR && insn->func) {
+			if (insn->offset == insn->func->offset) {
+				list_add_tail(&insn->call_node, &file->endbr_list);
+				file->nr_endbr++;
+			} else {
+				file->nr_endbr_int++;
+			}
+		}
+
 		if (!is_static_jump(insn))
 			continue;
 
@@ -1192,10 +1254,14 @@ static int add_jump_destinations(struct
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
 			add_call_dest(file, insn, reloc->sym, true);
-			continue;
+
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->offset +
+				   arch_dest_reloc_offset(reloc->addend);
+
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
-			dest_off = reloc->sym->sym.st_value +
+			dest_off = reloc->sym->offset +
 				   arch_dest_reloc_offset(reloc->addend);
 		} else {
 			/* non-func asm code jumping to another file */
@@ -1205,6 +1271,10 @@ static int add_jump_destinations(struct
 		insn->jump_dest = find_insn(file, dest_sec, dest_off);
 		if (!insn->jump_dest) {
 
+			/* external symbol */
+			if (!vmlinux && insn->func)
+				continue;
+
 			/*
 			 * This is a special case where an alt instruction
 			 * jumps past the end of the section.  These are
@@ -1219,6 +1289,32 @@ static int add_jump_destinations(struct
 			return -1;
 		}
 
+		if (ibt && insn->jump_dest->type == INSN_ENDBR &&
+		    insn->jump_dest->func &&
+		    insn->jump_dest->offset == insn->jump_dest->func->offset) {
+			if (reloc) {
+				if (ibt_fix_direct) {
+					reloc->addend += 4;
+					elf_write_reloc(file->elf, reloc);
+				} else {
+					WARN_FUNC("Direct RELOC jump to ENDBR", insn->sec, insn->offset);
+				}
+			} else {
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
+			}
+		}
+
 		/*
 		 * Cross-function jump.
 		 */
@@ -1246,7 +1342,8 @@ static int add_jump_destinations(struct
 				insn->jump_dest->func->pfunc = insn->func;
 
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
-				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
+				   ((insn->jump_dest->offset == insn->jump_dest->func->offset) ||
+				    (insn->jump_dest->offset == insn->jump_dest->func->offset + 4))) {
 				/* internal sibling call (without reloc) */
 				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
@@ -1256,23 +1353,12 @@ static int add_jump_destinations(struct
 	return 0;
 }
 
-static struct symbol *find_call_destination(struct section *sec, unsigned long offset)
-{
-	struct symbol *call_dest;
-
-	call_dest = find_func_by_offset(sec, offset);
-	if (!call_dest)
-		call_dest = find_symbol_by_offset(sec, offset);
-
-	return call_dest;
-}
-
 /*
  * Find the destination instructions for all calls.
  */
 static int add_call_destinations(struct objtool_file *file)
 {
-	struct instruction *insn;
+	struct instruction *insn, *target = NULL;
 	unsigned long dest_off;
 	struct symbol *dest;
 	struct reloc *reloc;
@@ -1284,7 +1370,21 @@ static int add_call_destinations(struct
 		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
-			dest = find_call_destination(insn->sec, dest_off);
+
+			target = find_insn(file, insn->sec, dest_off);
+			if (!target) {
+				WARN_FUNC("direct call to nowhere", insn->sec, insn->offset);
+				return -1;
+			}
+			dest = target->func;
+			if (!dest)
+				dest = find_symbol_containing(insn->sec, dest_off);
+			if (!dest) {
+				WARN_FUNC("IMM can't find call dest symbol at %s+0x%lx",
+					  insn->sec, insn->offset,
+					  insn->sec->name, dest_off);
+				return -1;
+			}
 
 			add_call_dest(file, insn, dest, false);
 
@@ -1303,10 +1403,25 @@ static int add_call_destinations(struct
 			}
 
 		} else if (reloc->sym->type == STT_SECTION) {
-			dest_off = arch_dest_reloc_offset(reloc->addend);
-			dest = find_call_destination(reloc->sym->sec, dest_off);
+			struct section *dest_sec;
+
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->offset +
+				   arch_dest_reloc_offset(reloc->addend);
+
+			target = find_insn(file, dest_sec, dest_off);
+			if (target) {
+				dest = target->func;
+				if (!dest)
+					dest = find_symbol_containing(dest_sec, dest_off);
+			} else {
+				WARN("foo");
+				dest = find_func_by_offset(dest_sec, dest_off);
+				if (!dest)
+					dest = find_symbol_by_offset(dest_sec, dest_off);
+			}
 			if (!dest) {
-				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
+				WARN_FUNC("RELOC can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  reloc->sym->sec->name,
 					  dest_off);
@@ -1317,9 +1432,43 @@ static int add_call_destinations(struct
 
 		} else if (reloc->sym->retpoline_thunk) {
 			add_retpoline_call(file, insn);
+			continue;
+
+		} else {
+			struct section *dest_sec;
+
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->offset +
+				   arch_dest_reloc_offset(reloc->addend);
+
+			target = find_insn(file, dest_sec, dest_off);
 
-		} else
 			add_call_dest(file, insn, reloc->sym, false);
+		}
+
+		if (ibt && target && target->type == INSN_ENDBR) {
+			if (reloc) {
+				if (ibt_fix_direct) {
+					reloc->addend += 4;
+					elf_write_reloc(file->elf, reloc);
+				} else {
+					WARN_FUNC("Direct RELOC call to ENDBR", insn->sec, insn->offset);
+				}
+			} else {
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
+			}
+		}
 	}
 
 	return 0;
@@ -3054,6 +3203,8 @@ static struct instruction *next_insn_to_
 	return next_insn_same_sec(file, insn);
 }
 
+static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn);
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -3102,6 +3253,12 @@ static int validate_branch(struct objtoo
 
 		if (insn->hint) {
 			state.cfi = *insn->cfi;
+			if (ibt) {
+				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_ENTRY &&
+				    insn->type != INSN_ENDBR) {
+					WARN_FUNC("IRET_ENTRY hint without ENDBR", insn->sec, insn->offset);
+				}
+			}
 		} else {
 			/* XXX track if we actually changed state.cfi */
 
@@ -3261,7 +3418,12 @@ static int validate_branch(struct objtoo
 			state.df = false;
 			break;
 
+		case INSN_NOP:
+			break;
+
 		default:
+			if (ibt)
+				validate_ibt_insn(file, insn);
 			break;
 		}
 
@@ -3507,6 +3669,131 @@ static int validate_functions(struct obj
 	return warnings;
 }
 
+static struct instruction *
+validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
+{
+	struct instruction *dest;
+	struct section *sec;
+	unsigned long off;
+
+	sec = reloc->sym->sec;
+	off = reloc->sym->offset + reloc->addend;
+
+	dest = find_insn(file, sec, off);
+	if (!dest)
+		return NULL;
+
+	if (dest->type == INSN_ENDBR) {
+		if (!list_empty(&dest->call_node))
+			list_del_init(&dest->call_node);
+
+		return NULL;
+	}
+
+	if (reloc->sym->static_call_tramp)
+		return NULL;
+
+	return dest;
+}
+
+static void validate_ibt_target(struct objtool_file *file, struct instruction *insn,
+				struct instruction *target)
+{
+	if (target->func && target->func == insn->func) {
+		/*
+		 * Anything from->to self is either _THIS_IP_ or IRET-to-self.
+		 *
+		 * There is no sane way to annotate _THIS_IP_ since the compiler treats the
+		 * relocation as a constant and is happy to fold in offsets, skewing any
+		 * annotation we do, leading to vast amounts of false-positives.
+		 *
+		 * There's also compiler generated _THIS_IP_ through KCOV and
+		 * such which we have no hope of annotating.
+		 *
+		 * As such, blanked accept self-references without issue.
+		 */
+		return;
+	}
+
+	/*
+	 * Annotated non-control flow target.
+	 */
+	if (target->noendbr)
+		return;
+
+	WARN_FUNC("relocation to !ENDBR: %s+0x%lx",
+		  insn->sec, insn->offset,
+		  target->func ? target->func->name : target->sec->name,
+		  target->func ? target->offset - target->func->offset : target->offset);
+}
+
+static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
+{
+	struct reloc *reloc = insn_reloc(file, insn);
+	struct instruction *target;
+
+	for (;;) {
+		if (!reloc)
+			return;
+
+		target = validate_ibt_reloc(file, reloc);
+		if (target)
+			validate_ibt_target(file, insn, target);
+
+		reloc = find_reloc_by_dest_range(file->elf, insn->sec, reloc->offset + 1,
+						 (insn->offset + insn->len) - (reloc->offset + 1));
+	}
+}
+
+static int validate_ibt(struct objtool_file *file)
+{
+	struct section *sec;
+	struct reloc *reloc;
+
+	for_each_sec(file, sec) {
+		bool is_data;
+
+		/* already done in validate_branch() */
+		if (sec->sh.sh_flags & SHF_EXECINSTR)
+			continue;
+
+		if (!sec->reloc)
+			continue;
+
+		if (!strncmp(sec->name, ".orc", 4))
+			continue;
+
+		if (!strncmp(sec->name, ".discard", 8))
+			continue;
+
+		if (!strncmp(sec->name, ".debug", 6))
+			continue;
+
+		if (!strcmp(sec->name, "_error_injection_whitelist"))
+			continue;
+
+		if (!strcmp(sec->name, "_kprobe_blacklist"))
+			continue;
+
+		is_data = strstr(sec->name, ".data") || strstr(sec->name, ".rodata");
+
+		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
+			struct instruction *target;
+
+			target = validate_ibt_reloc(file, reloc);
+			if (is_data && target && !target->noendbr) {
+				WARN_FUNC("data relocaction to !ENDBR: %s+0x%lx",
+					  reloc->sym->sec,
+					  reloc->sym->offset + reloc->addend,
+		  target->func ? target->func->name : target->sec->name,
+		  target->func ? target->offset - target->func->offset : target->offset);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -3534,6 +3821,21 @@ int check(struct objtool_file *file)
 		return 1;
 	}
 
+	if (ibt && !lto) {
+		fprintf(stderr, "--ibt requires: --lto\n");
+		return 1;
+	}
+
+	if (ibt_fix_direct && !ibt) {
+		fprintf(stderr, "--ibt-fix-direct requires: --ibt\n");
+		return 1;
+	}
+
+	if (ibt_seal && !ibt_fix_direct) {
+		fprintf(stderr, "--ibt-seal requires: --ibt-fix-direct\n");
+		return 1;
+	}
+
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
@@ -3580,6 +3882,13 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings += ret;
 
+	if (ibt) {
+		ret = validate_ibt(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	if (!warnings) {
 		ret = validate_reachable_instructions(file);
 		if (ret < 0)
@@ -3604,6 +3913,13 @@ int check(struct objtool_file *file)
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+	}
+
+	if (ibt_seal) {
+		ret = create_ibt_endbr_sites_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (stats) {
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -27,6 +27,8 @@ enum insn_type {
 	INSN_STD,
 	INSN_CLD,
 	INSN_TRAP,
+	INSN_ENDBR,
+	INSN_IRET,
 	INSN_OTHER,
 };
 
@@ -84,6 +86,7 @@ unsigned long arch_dest_reloc_offset(int
 
 const char *arch_nop_insn(int len);
 const char *arch_ret_insn(int len);
+const char *arch_mod_immediate(struct instruction *insn, unsigned long target);
 
 int arch_decode_hint_reg(u8 sp_reg, int *base);
 
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,8 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun;
+	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
+	    ibt, ibt_fix_direct, ibt_seal;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -26,8 +26,12 @@ struct objtool_file {
 	struct list_head retpoline_call_list;
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
+	struct list_head endbr_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 
+	unsigned int nr_endbr;
+	unsigned int nr_endbr_int;
+
 	unsigned long jl_short, jl_long;
 	unsigned long jl_nop_short, jl_nop_long;
 
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -128,6 +128,7 @@ struct objtool_file *objtool_open_read(c
 	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
+	INIT_LIST_HEAD(&file.endbr_list);
 	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;


